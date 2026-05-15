from __future__ import annotations

import json
import os
import re
from datetime import datetime, timezone
from typing import Any, Dict, List, Optional, Tuple, TYPE_CHECKING

import prompt_templates

if TYPE_CHECKING:
    from run_logger import SessionFileLogger


def get_gemini_api_key() -> str:
    key = os.environ.get("GEMINI_API_KEY") or os.environ.get("GOOGLE_API_KEY")
    if not key:
        raise EnvironmentError(
            "Set GEMINI_API_KEY or GOOGLE_API_KEY for Gemini API access."
        )
    return key


def get_openai_api_key() -> str:
    key = os.environ.get("OPENAI_API_KEY") or os.environ.get("OPENAI_KEY")
    if not key:
        raise EnvironmentError(
            "Set OPENAI_API_KEY or OPENAI_KEY for OpenAI API access."
        )
    return key


def _openai_key_available() -> bool:
    return bool(os.environ.get("OPENAI_API_KEY") or os.environ.get("OPENAI_KEY"))


def _gemini_key_available() -> bool:
    return bool(os.environ.get("GEMINI_API_KEY") or os.environ.get("GOOGLE_API_KEY"))


def _strip_json_fence(text: str) -> str:
    t = text.strip()
    m = re.match(r"^```(?:json)?\s*([\s\S]*?)\s*```$", t, re.IGNORECASE)
    if m:
        return m.group(1).strip()
    return t


def parse_json_object(text: str) -> Dict[str, Any]:
    cleaned = _strip_json_fence(text)
    return json.loads(cleaned)


def _load_genai():
    try:
        from google import genai
        from google.genai import types as genai_types
    except ImportError as e:
        raise ImportError(
            "Install the Gemini SDK: pip install google-genai"
        ) from e
    return genai, genai_types


def _is_gpt5_style(model: str) -> bool:
    m = (model or "").lower()
    return m.startswith("gpt-5") or m.startswith("gpt5")


def _usage_from_gemini_response(resp: Any) -> Dict[str, Any]:
    u = getattr(resp, "usage_metadata", None)
    if u is None:
        return {}
    if hasattr(u, "model_dump"):
        try:
            return u.model_dump()
        except Exception:
            pass
    if isinstance(u, dict):
        return dict(u)
    out: Dict[str, Any] = {}
    for k in (
        "prompt_token_count",
        "candidates_token_count",
        "total_token_count",
        "cached_content_token_count",
        "thoughts_token_count",
    ):
        if hasattr(u, k):
            out[k] = getattr(u, k)
    return out if out else {"raw": str(u)}


def _usage_from_openai_response(response: Any) -> Dict[str, Any]:
    u = getattr(response, "usage", None)
    if u is None:
        return {}
    if hasattr(u, "model_dump"):
        try:
            return u.model_dump()
        except Exception:
            pass
    return {
        "prompt_tokens": getattr(u, "prompt_tokens", None),
        "completion_tokens": getattr(u, "completion_tokens", None),
        "total_tokens": getattr(u, "total_tokens", None),
    }


def _build_gemini_config(genai_types: Any, model: str) -> Any:
    kwargs: Dict[str, Any] = {
        "response_mime_type": "application/json",
        "temperature": 0.2,
    }
    if "gemini-3-flash-preview" in (model or "").lower():
        try:
            kwargs["thinking_config"] = genai_types.ThinkingConfig(
                thinking_level="LOW",
            )
        except Exception:
            try:
                kwargs["thinking_config"] = genai_types.ThinkingConfig(
                    thinking_level="low",
                )
            except Exception:
                pass
    try:
        return genai_types.GenerateContentConfig(**kwargs)
    except Exception:
        kwargs.pop("thinking_config", None)
        return genai_types.GenerateContentConfig(
            response_mime_type="application/json",
            temperature=0.2,
        )


def _call_gemini(*, model: str, prompt: str) -> Tuple[str, Dict[str, Any]]:
    genai, genai_types = _load_genai()
    client = genai.Client(api_key=get_gemini_api_key())
    config = _build_gemini_config(genai_types, model)
    kwargs: Dict[str, Any] = {"model": model, "contents": prompt, "config": config}
    resp = client.models.generate_content(**kwargs)
    usage = _usage_from_gemini_response(resp)
    if hasattr(resp, "text") and resp.text:
        return resp.text, usage
    if getattr(resp, "candidates", None):
        parts = resp.candidates[0].content.parts
        text = "".join(getattr(pt, "text", "") for pt in parts)
        if text:
            return text, usage
    raise RuntimeError("Empty response from Gemini")


def _call_openai(*, model: str, prompt: str) -> Tuple[str, Dict[str, Any]]:
    from openai import OpenAI

    client = OpenAI(api_key=get_openai_api_key())
    kwargs: Dict[str, Any] = {
        "model": model,
        "messages": [{"role": "user", "content": prompt}],
        "max_completion_tokens": 8192,
    }
    if not _is_gpt5_style(model):
        kwargs["temperature"] = 0.2
    try:
        response = client.chat.completions.create(**kwargs)
    except Exception as e:
        err = str(e).lower()
        if "max_tokens" in err and (
            "not supported" in err or "unsupported" in err or "use" in err
        ):
            kwargs.pop("max_tokens", None)
            kwargs.setdefault("max_completion_tokens", 8192)
            response = client.chat.completions.create(**kwargs)
        else:
            raise
    usage = _usage_from_openai_response(response)
    content = response.choices[0].message.content
    if not content:
        raise RuntimeError("Empty response from OpenAI")
    return content, usage


def _log(
    session_logger: Optional["SessionFileLogger"],
    *,
    phase: str,
    backend: str,
    model: str,
    prompt: str,
    response: str,
    usage: Dict[str, Any],
    extra: Optional[Dict[str, Any]],
) -> None:
    if session_logger is None:
        return
    session_logger.log_interaction(
        phase=phase,
        backend=backend,
        model=model,
        prompt=prompt,
        response=response,
        usage=usage,
        extra=extra or {},
    )


def _append_transcript_legacy(
    transcript: Optional[List[Dict[str, Any]]],
    transcript_prefix: Optional[Dict[str, Any]],
    *,
    phase: str,
    backend: str,
    model: str,
    prompt: str,
    response: str,
) -> None:
    """Optional lightweight list (no longer written to BIRD by default)."""
    if transcript is None:
        return
    rec: Dict[str, Any] = {
        "phase": phase,
        "backend": backend,
        "model": model,
        "prompt_chars": len(prompt),
        "response_chars": len(response),
        "timestamp_utc": datetime.now(timezone.utc).isoformat(),
    }
    if transcript_prefix:
        rec.update(transcript_prefix)
    transcript.append(rec)


def _align_column_keys(
    cols_out: Any,
    expected_names: List[str],
) -> Dict[str, Any]:
    """Map model JSON keys onto canonical SQLite column names (exact, then case-insensitive)."""
    if not isinstance(cols_out, dict):
        return {}
    expected_set = set(expected_names)
    lower_map = {n.lower(): n for n in expected_names}
    out: Dict[str, Any] = {}
    for k, v in cols_out.items():
        key = str(k).strip()
        if key in expected_set and key not in out:
            out[key] = v
            continue
        lk = key.lower()
        if lk in lower_map:
            canon = lower_map[lk]
            if canon not in out:
                out[canon] = v
    return out


BatchSegment = Tuple[str, Dict[str, Any], List[Dict[str, Any]]]


def _parse_enrichment_response(
    raw: Any,
    batch_segments: List[Tuple[str, Dict[str, Any], List[Dict[str, Any]]]],
) -> Dict[str, Dict[str, Any]]:
    """
    From model JSON, extract table_name -> { column_name -> enrichment dict }.
    Supports nested ``tables`` object or legacy flat ``columns`` (single-table batch only).
    """
    out: Dict[str, Dict[str, Any]] = {}
    if not isinstance(raw, dict):
        return out

    tables_block = raw.get("tables")
    if isinstance(tables_block, dict) and tables_block:
        lower_to_table = {str(k).lower(): k for k in tables_block}
        for tname, _ctx, cols in batch_segments:
            expected = [c["name"] for c in cols]
            node = tables_block.get(tname)
            if node is None:
                lk = tname.lower()
                if lk in lower_to_table:
                    node = tables_block.get(lower_to_table[lk])
            if not isinstance(node, dict):
                continue
            cols_out = node.get("columns")
            out[tname] = _align_column_keys(cols_out, expected)
        return out

    if len(batch_segments) == 1:
        tname, _ctx, cols = batch_segments[0]
        expected = [c["name"] for c in cols]
        cols_out = raw.get("columns")
        out[tname] = _align_column_keys(cols_out, expected)
    return out


def _generate_column_enrichment_once(
    *,
    model: str,
    gemini_fallback_model: str,
    batch_segments: List[BatchSegment],
    repair: bool,
    transcript: Optional[List[Dict[str, Any]]],
    transcript_prefix: Optional[Dict[str, Any]],
    openai_primary_model: str,
    openai_fallback_model: str,
    session_logger: Optional["SessionFileLogger"],
    db_llm_state: Optional[Dict[str, Any]] = None,
) -> Dict[str, Any]:
    """Single primary (+ optional JSON repair) pass; does not retry missing columns."""
    payload = {
        "tables": [
            {"table": t, "table_context": ctx, "columns_to_enrich": cols}
            for t, ctx, cols in batch_segments
        ]
    }
    input_json_text = json.dumps(payload, ensure_ascii=False, indent=2)
    prompt = prompt_templates.format_primary_prompt(input_json_text)

    text: Optional[str] = None
    usage: Dict[str, Any] = {}
    extra = dict(transcript_prefix or {})

    openai_only = bool(db_llm_state and db_llm_state.get("openai_only"))
    first_primary_for_db = db_llm_state is not None and db_llm_state.get("primary_calls", 0) == 0

    if openai_only:
        try:
            text, usage = _call_openai(model=openai_primary_model, prompt=prompt)
            _log(
                session_logger,
                phase="primary_openai_only",
                backend="openai",
                model=openai_primary_model,
                prompt=prompt,
                response=text,
                usage=usage,
                extra=extra,
            )
            _append_transcript_legacy(
                transcript,
                transcript_prefix,
                phase="primary_openai_only",
                backend="openai",
                model=openai_primary_model,
                prompt=prompt,
                response=text,
            )
        except Exception:
            if openai_fallback_model == openai_primary_model:
                raise
            text, usage = _call_openai(model=openai_fallback_model, prompt=prompt)
            _log(
                session_logger,
                phase="primary_openai_only_fallback",
                backend="openai_fallback",
                model=openai_fallback_model,
                prompt=prompt,
                response=text,
                usage=usage,
                extra=extra,
            )
            _append_transcript_legacy(
                transcript,
                transcript_prefix,
                phase="primary_openai_only_fallback",
                backend="openai_fallback",
                model=openai_fallback_model,
                prompt=prompt,
                response=text,
            )
    else:
        if _openai_key_available():
            try:
                text, usage = _call_openai(model=openai_primary_model, prompt=prompt)
                _log(
                    session_logger,
                    phase="primary_openai",
                    backend="openai",
                    model=openai_primary_model,
                    prompt=prompt,
                    response=text,
                    usage=usage,
                    extra=extra,
                )
                _append_transcript_legacy(
                    transcript,
                    transcript_prefix,
                    phase="primary_openai",
                    backend="openai",
                    model=openai_primary_model,
                    prompt=prompt,
                    response=text,
                )
            except Exception as oe:
                err_txt = f"<error: {oe!r}>"
                _log(
                    session_logger,
                    phase="primary_openai_failed",
                    backend="openai",
                    model=openai_primary_model,
                    prompt=prompt,
                    response=err_txt,
                    usage={},
                    extra={**extra, "error": repr(oe)},
                )
                _append_transcript_legacy(
                    transcript,
                    transcript_prefix,
                    phase="primary_openai_failed",
                    backend="openai",
                    model=openai_primary_model,
                    prompt=prompt,
                    response=err_txt,
                )

        if text is None and _gemini_key_available():
            try:
                text, usage = _call_gemini(model=model, prompt=prompt)
                _log(
                    session_logger,
                    phase="primary",
                    backend="gemini",
                    model=model,
                    prompt=prompt,
                    response=text,
                    usage=usage,
                    extra=extra,
                )
                _append_transcript_legacy(
                    transcript,
                    transcript_prefix,
                    phase="primary",
                    backend="gemini",
                    model=model,
                    prompt=prompt,
                    response=text,
                )
            except Exception as gem_err:
                err_txt = f"<error: {gem_err!r}>"
                _log(
                    session_logger,
                    phase="primary_gemini_failed",
                    backend="gemini",
                    model=model,
                    prompt=prompt,
                    response=err_txt,
                    usage={},
                    extra={**extra, "error": repr(gem_err)},
                )
                _append_transcript_legacy(
                    transcript,
                    transcript_prefix,
                    phase="primary_gemini_failed",
                    backend="gemini",
                    model=model,
                    prompt=prompt,
                    response=err_txt,
                )
                try:
                    text, usage = _call_gemini(
                        model=gemini_fallback_model, prompt=prompt
                    )
                    _log(
                        session_logger,
                        phase="primary_gemini_fallback",
                        backend="gemini",
                        model=gemini_fallback_model,
                        prompt=prompt,
                        response=text,
                        usage=usage,
                        extra=extra,
                    )
                    _append_transcript_legacy(
                        transcript,
                        transcript_prefix,
                        phase="primary_gemini_fallback",
                        backend="gemini",
                        model=gemini_fallback_model,
                        prompt=prompt,
                        response=text,
                    )
                except Exception as gem_err2:
                    err_txt2 = f"<error: {gem_err2!r}>"
                    _log(
                        session_logger,
                        phase="primary_gemini_secondary_failed",
                        backend="gemini",
                        model=gemini_fallback_model,
                        prompt=prompt,
                        response=err_txt2,
                        usage={},
                        extra={**extra, "error": repr(gem_err2)},
                    )
                    _append_transcript_legacy(
                        transcript,
                        transcript_prefix,
                        phase="primary_gemini_secondary_failed",
                        backend="gemini",
                        model=gemini_fallback_model,
                        prompt=prompt,
                        response=err_txt2,
                    )
                    if db_llm_state is not None and first_primary_for_db:
                        db_llm_state["openai_only"] = True
                    if _openai_key_available():
                        text, usage = _call_openai(
                            model=openai_fallback_model, prompt=prompt
                        )
                        _log(
                            session_logger,
                            phase="primary_openai_fallback",
                            backend="openai_fallback",
                            model=openai_fallback_model,
                            prompt=prompt,
                            response=text,
                            usage=usage,
                            extra=extra,
                        )
                        _append_transcript_legacy(
                            transcript,
                            transcript_prefix,
                            phase="primary_openai_fallback",
                            backend="openai_fallback",
                            model=openai_fallback_model,
                            prompt=prompt,
                            response=text,
                        )

        if text is None:
            raise RuntimeError(
                "Column enrichment primary LLM chain produced no response "
                "(check API keys and model ids)."
            )

    if db_llm_state is not None:
        db_llm_state["primary_calls"] = db_llm_state.get("primary_calls", 0) + 1

    try:
        return parse_json_object(text)
    except json.JSONDecodeError:
        if not repair:
            raise
        fix_prompt = prompt_templates.format_repair_prompt(text)
        text2: Optional[str] = None
        skip_gemini_repair = bool(db_llm_state and db_llm_state.get("openai_only"))
        if skip_gemini_repair:
            try:
                text2, usage = _call_openai(
                    model=openai_primary_model, prompt=fix_prompt
                )
                _log(
                    session_logger,
                    phase="json_repair_openai_only",
                    backend="openai",
                    model=openai_primary_model,
                    prompt=fix_prompt,
                    response=text2,
                    usage=usage,
                    extra=extra,
                )
                _append_transcript_legacy(
                    transcript,
                    transcript_prefix,
                    phase="json_repair_openai_only",
                    backend="openai",
                    model=openai_primary_model,
                    prompt=fix_prompt,
                    response=text2,
                )
            except Exception:
                if openai_fallback_model == openai_primary_model:
                    raise
                text2, usage = _call_openai(
                    model=openai_fallback_model, prompt=fix_prompt
                )
                _log(
                    session_logger,
                    phase="json_repair_openai_only_fallback",
                    backend="openai_fallback",
                    model=openai_fallback_model,
                    prompt=fix_prompt,
                    response=text2,
                    usage=usage,
                    extra=extra,
                )
                _append_transcript_legacy(
                    transcript,
                    transcript_prefix,
                    phase="json_repair_openai_only_fallback",
                    backend="openai_fallback",
                    model=openai_fallback_model,
                    prompt=fix_prompt,
                    response=text2,
                )
        else:
            if _openai_key_available():
                try:
                    text2, usage = _call_openai(
                        model=openai_primary_model, prompt=fix_prompt
                    )
                    _log(
                        session_logger,
                        phase="json_repair_openai",
                        backend="openai",
                        model=openai_primary_model,
                        prompt=fix_prompt,
                        response=text2,
                        usage=usage,
                        extra=extra,
                    )
                    _append_transcript_legacy(
                        transcript,
                        transcript_prefix,
                        phase="json_repair_openai",
                        backend="openai",
                        model=openai_primary_model,
                        prompt=fix_prompt,
                        response=text2,
                    )
                except Exception as roe:
                    err_txt = f"<error: {roe!r}>"
                    _log(
                        session_logger,
                        phase="json_repair_openai_failed",
                        backend="openai",
                        model=openai_primary_model,
                        prompt=fix_prompt,
                        response=err_txt,
                        usage={},
                        extra={**extra, "error": repr(roe)},
                    )
                    _append_transcript_legacy(
                        transcript,
                        transcript_prefix,
                        phase="json_repair_openai_failed",
                        backend="openai",
                        model=openai_primary_model,
                        prompt=fix_prompt,
                        response=err_txt,
                    )

            if text2 is None and _gemini_key_available():
                try:
                    text2, usage = _call_gemini(model=model, prompt=fix_prompt)
                    _log(
                        session_logger,
                        phase="json_repair",
                        backend="gemini",
                        model=model,
                        prompt=fix_prompt,
                        response=text2,
                        usage=usage,
                        extra=extra,
                    )
                    _append_transcript_legacy(
                        transcript,
                        transcript_prefix,
                        phase="json_repair",
                        backend="gemini",
                        model=model,
                        prompt=fix_prompt,
                        response=text2,
                    )
                except Exception as rep_g_err:
                    err_txt = f"<error: {rep_g_err!r}>"
                    _log(
                        session_logger,
                        phase="json_repair_gemini_failed",
                        backend="gemini",
                        model=model,
                        prompt=fix_prompt,
                        response=err_txt,
                        usage={},
                        extra={**extra, "error": repr(rep_g_err)},
                    )
                    _append_transcript_legacy(
                        transcript,
                        transcript_prefix,
                        phase="json_repair_gemini_failed",
                        backend="gemini",
                        model=model,
                        prompt=fix_prompt,
                        response=err_txt,
                    )
                    try:
                        text2, usage = _call_gemini(
                            model=gemini_fallback_model, prompt=fix_prompt
                        )
                        _log(
                            session_logger,
                            phase="json_repair_gemini_fallback",
                            backend="gemini",
                            model=gemini_fallback_model,
                            prompt=fix_prompt,
                            response=text2,
                            usage=usage,
                            extra=extra,
                        )
                        _append_transcript_legacy(
                            transcript,
                            transcript_prefix,
                            phase="json_repair_gemini_fallback",
                            backend="gemini",
                            model=gemini_fallback_model,
                            prompt=fix_prompt,
                            response=text2,
                        )
                    except Exception as rep_g2:
                        err_txt2 = f"<error: {rep_g2!r}>"
                        _log(
                            session_logger,
                            phase="json_repair_gemini_secondary_failed",
                            backend="gemini",
                            model=gemini_fallback_model,
                            prompt=fix_prompt,
                            response=err_txt2,
                            usage={},
                            extra={**extra, "error": repr(rep_g2)},
                        )
                        _append_transcript_legacy(
                            transcript,
                            transcript_prefix,
                            phase="json_repair_gemini_secondary_failed",
                            backend="gemini",
                            model=gemini_fallback_model,
                            prompt=fix_prompt,
                            response=err_txt2,
                        )
                        if _openai_key_available():
                            text2, usage = _call_openai(
                                model=openai_fallback_model, prompt=fix_prompt
                            )
                            _log(
                                session_logger,
                                phase="json_repair_openai_fallback",
                                backend="openai_fallback",
                                model=openai_fallback_model,
                                prompt=fix_prompt,
                                response=text2,
                                usage=usage,
                                extra=extra,
                            )
                            _append_transcript_legacy(
                                transcript,
                                transcript_prefix,
                                phase="json_repair_openai_fallback",
                                backend="openai_fallback",
                                model=openai_fallback_model,
                                prompt=fix_prompt,
                                response=text2,
                            )

            if text2 is None:
                raise RuntimeError(
                    "Column enrichment JSON repair chain produced no response."
                )

        return parse_json_object(text2)


def generate_batch_column_enrichment_json(
    *,
    model: str,
    batch_segments: List[BatchSegment],
    gemini_fallback_model: str = "gemini-2.5-flash",
    repair: bool = True,
    transcript: Optional[List[Dict[str, Any]]] = None,
    transcript_prefix: Optional[Dict[str, Any]] = None,
    openai_primary_model: str = "gpt-5-mini",
    openai_fallback_model: str = "gpt-5-mini",
    session_logger: Optional["SessionFileLogger"] = None,
    db_llm_state: Optional[Dict[str, Any]] = None,
) -> Dict[str, Dict[str, Any]]:
    """
    Ask the model for nested ``tables`` -> ``columns`` enrichment.

    Returns ``{ table_name: { column_name: enrichment_dict } }``.

    Retries until every expected (table, column) appears in the response or raises
    ``RuntimeError``.
    """
    if not batch_segments:
        return {}

    ctx_by_table = {t: ctx for t, ctx, _cols in batch_segments}
    original_pending: List[Tuple[str, Dict[str, Any]]] = []
    for tname, _ctx, cols in batch_segments:
        for cp in cols:
            original_pending.append((tname, cp))

    merged: Dict[str, Dict[str, Any]] = {}
    pending = list(original_pending)
    n_col = len(original_pending)
    max_rounds = max(12, n_col + 3)
    round_num = 0

    while pending:
        round_num += 1
        if round_num > max_rounds:
            missing_pairs = [f"{t}.{cp['name']}" for t, cp in pending]
            raise RuntimeError(
                f"Column coverage incomplete for batch "
                f"(batch_index={(transcript_prefix or {}).get('batch_index')}) "
                f"after {max_rounds} round(s); missing: {missing_pairs}"
            )

        by_table: Dict[str, List[Dict[str, Any]]] = {}
        for tname, cp in pending:
            by_table.setdefault(tname, []).append(cp)
        current_segments: List[BatchSegment] = [
            (t, ctx_by_table[t], by_table[t]) for t in sorted(by_table.keys())
        ]

        base_extra = dict(transcript_prefix or {})
        base_extra["column_coverage_round"] = round_num
        base_extra["columns_requested_this_round"] = [
            f"{t}.{cp['name']}" for t, cp in pending
        ]

        raw = _generate_column_enrichment_once(
            model=model,
            gemini_fallback_model=gemini_fallback_model,
            batch_segments=current_segments,
            repair=repair,
            transcript=transcript,
            transcript_prefix=base_extra,
            openai_primary_model=openai_primary_model,
            openai_fallback_model=openai_fallback_model,
            session_logger=session_logger,
            db_llm_state=db_llm_state,
        )

        parsed = _parse_enrichment_response(raw, current_segments)

        for tname, _ctx, cols in current_segments:
            expected_names = [c["name"] for c in cols]
            got = parsed.get(tname, {})
            present = [n for n in expected_names if n in got]
            missing = [n for n in expected_names if n not in got]
            if session_logger is not None:
                session_logger.record_column_coverage(
                    table=tname,
                    round_num=round_num,
                    expected=expected_names,
                    present=present,
                    missing=missing,
                )
            for n in present:
                merged.setdefault(tname, {})[n] = got[n]

        pending = [
            (t, cp)
            for t, cp in original_pending
            if cp["name"] not in merged.get(t, {})
        ]

    return merged


def generate_column_enrichment_json(
    *,
    model: str,
    table_name: str,
    table_context: Dict[str, Any],
    columns_chunk: List[Dict[str, Any]],
    gemini_fallback_model: str = "gemini-2.5-flash",
    repair: bool = True,
    transcript: Optional[List[Dict[str, Any]]] = None,
    transcript_prefix: Optional[Dict[str, Any]] = None,
    openai_primary_model: str = "gpt-5-mini",
    openai_fallback_model: str = "gpt-5-mini",
    session_logger: Optional["SessionFileLogger"] = None,
    db_llm_state: Optional[Dict[str, Any]] = None,
) -> Dict[str, Any]:
    """
    Single-table helper: same as :func:`generate_batch_column_enrichment_json`
    with one segment; returns legacy shape ``{"columns": {...}}``.
    """
    if not columns_chunk:
        return {"columns": {}}
    per_table = generate_batch_column_enrichment_json(
        model=model,
        gemini_fallback_model=gemini_fallback_model,
        batch_segments=[(table_name, table_context, columns_chunk)],
        repair=repair,
        transcript=transcript,
        transcript_prefix=transcript_prefix,
        openai_primary_model=openai_primary_model,
        openai_fallback_model=openai_fallback_model,
        session_logger=session_logger,
        db_llm_state=db_llm_state,
    )
    return {"columns": per_table.get(table_name, {})}
