from __future__ import annotations

import argparse
import json
import os
import re
import sqlite3
import sys
import time
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional, Sequence, Set, Tuple


def _strip_json_fence(text: str) -> str:
    t = (text or "").strip()
    m = re.match(r"^```(?:json)?\s*([\s\S]*?)\s*```$", t, re.IGNORECASE)
    return (m.group(1).strip() if m else t)


def _parse_json_object(text: str) -> Dict[str, Any]:
    obj = json.loads(_strip_json_fence(text))
    # Some models wrap the object in a single-item list; accept that.
    if isinstance(obj, list) and len(obj) == 1 and isinstance(obj[0], dict):
        return obj[0]
    if not isinstance(obj, dict):
        raise ValueError(f"Expected JSON object, got {type(obj).__name__}")
    return obj


def _load_genai():
    try:
        from google import genai
        from google.genai import types as genai_types
    except ImportError as e:
        raise ImportError("Install Gemini SDK: pip install google-genai") from e
    return genai, genai_types


def _gemini_api_key() -> str:
    key = os.environ.get("GEMINI_API_KEY") or os.environ.get("GOOGLE_API_KEY")
    if not key:
        raise EnvironmentError("Set GEMINI_API_KEY or GOOGLE_API_KEY.")
    return key


def _openai_api_key_optional() -> Optional[str]:
    return os.environ.get("OPENAI_API_KEY") or os.environ.get("OPENAI_KEY") or None


def _gemini_api_key_optional() -> Optional[str]:
    return os.environ.get("GEMINI_API_KEY") or os.environ.get("GOOGLE_API_KEY") or None


def _is_gpt5_style(model: str) -> bool:
    m = (model or "").lower()
    return m.startswith("gpt-5") or m.startswith("gpt5")


def _call_openai(*, model: str, prompt: str) -> Tuple[str, Dict[str, Any]]:
    from openai import OpenAI

    api_key = _openai_api_key_optional()
    if not api_key:
        raise EnvironmentError("Set OPENAI_API_KEY or OPENAI_KEY for OpenAI access.")
    client = OpenAI(api_key=api_key)
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
    u = getattr(response, "usage", None)
    usage: Dict[str, Any] = {}
    if u is not None:
        if hasattr(u, "model_dump"):
            try:
                usage = u.model_dump()
            except Exception:
                usage = {
                    "prompt_tokens": getattr(u, "prompt_tokens", None),
                    "completion_tokens": getattr(u, "completion_tokens", None),
                    "total_tokens": getattr(u, "total_tokens", None),
                }
        else:
            usage = {
                "prompt_tokens": getattr(u, "prompt_tokens", None),
                "completion_tokens": getattr(u, "completion_tokens", None),
                "total_tokens": getattr(u, "total_tokens", None),
            }
    content = response.choices[0].message.content
    if not content:
        raise RuntimeError("Empty response from OpenAI")
    return content, usage


def _build_gemini_config(genai_types: Any, model: str) -> Any:
    kwargs: Dict[str, Any] = {
        "response_mime_type": "application/json",
        "temperature": 0.2,
    }
    if "gemini-3-flash-preview" in (model or "").lower():
        try:
            kwargs["thinking_config"] = genai_types.ThinkingConfig(thinking_level="LOW")
        except Exception:
            try:
                kwargs["thinking_config"] = genai_types.ThinkingConfig(thinking_level="low")
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
    client = genai.Client(api_key=_gemini_api_key())
    config = _build_gemini_config(genai_types, model)
    resp = client.models.generate_content(model=model, contents=prompt, config=config)
    usage: Dict[str, Any] = {}
    u = getattr(resp, "usage_metadata", None)
    if u is not None:
        try:
            usage = u.model_dump() if hasattr(u, "model_dump") else {"raw": str(u)}
        except Exception:
            usage = {"raw": str(u)}
    if hasattr(resp, "text") and resp.text:
        return resp.text, usage
    if getattr(resp, "candidates", None):
        parts = resp.candidates[0].content.parts
        text = "".join(getattr(pt, "text", "") for pt in parts)
        if text:
            return text, usage
    raise RuntimeError("Empty response from Gemini")


def _call_table_classify_llm_chain(
    *,
    openai_model: str,
    gemini_primary: str,
    gemini_fallback: str,
    prompt: str,
    sleep_s: float = 0.0,
) -> Tuple[str, Dict[str, Any]]:
    """
    Try OpenAI (JSON-oriented user prompt) first, then Gemini primary, then Gemini fallback.
    """
    if sleep_s > 0:
        time.sleep(sleep_s)
    errors: List[str] = []
    okey = _openai_api_key_optional()
    if okey:
        try:
            text, usage = _call_openai(model=openai_model, prompt=prompt)
            return text, {"backend": "openai", "model": openai_model, "usage": usage}
        except Exception as e:
            errors.append(f"OpenAI ({openai_model}): {e}")

    gkey = _gemini_api_key_optional()
    if not gkey and not okey:
        raise RuntimeError(
            "No LLM API keys: set OPENAI_API_KEY or OPENAI_KEY and/or "
            "GEMINI_API_KEY or GOOGLE_API_KEY."
        )
    if gkey:
        if sleep_s > 0:
            time.sleep(sleep_s)
        try:
            text, usage = _call_gemini(model=gemini_primary, prompt=prompt)
            return text, {"backend": "gemini", "model": gemini_primary, "usage": usage}
        except Exception as e1:
            errors.append(f"Gemini primary ({gemini_primary}): {e1}")
            if sleep_s > 0:
                time.sleep(sleep_s)
            try:
                text, usage = _call_gemini(model=gemini_fallback, prompt=prompt)
                return text, {
                    "backend": "gemini_fallback",
                    "model": gemini_fallback,
                    "usage": usage,
                    "primary_error": str(e1),
                }
            except Exception as e2:
                errors.append(f"Gemini fallback ({gemini_fallback}): {e2}")

    raise RuntimeError("All configured LLM backends failed:\n" + "\n".join(errors))


@dataclass(frozen=True)
class TableInfo:
    name: str
    create_sql: str
    columns: List[Tuple[str, str, int]]  # (name, type, pk_rank)
    fks: List[Tuple[str, str, str]]  # (from_col, to_table, to_col)


def _connect_ro(db_path: str) -> sqlite3.Connection:
    ap = os.path.abspath(db_path)
    return sqlite3.connect(f"file:{ap}?mode=ro", uri=True)


def _list_tables(conn: sqlite3.Connection) -> List[Tuple[str, str]]:
    cur = conn.cursor()
    cur.execute(
        "SELECT name, sql FROM sqlite_master "
        "WHERE type='table' AND name NOT LIKE 'sqlite_%' ORDER BY name"
    )
    return [(n, s or "") for (n, s) in cur.fetchall()]


def _table_columns(conn: sqlite3.Connection, table: str) -> List[Tuple[str, str, int]]:
    cur = conn.cursor()
    cur.execute(f'PRAGMA table_info("{table}");')
    rows = cur.fetchall()
    # columns: cid, name, type, notnull, dflt_value, pk
    out = [(r[1], r[2] or "", int(r[5] or 0)) for r in rows]
    # stable ordering: as in PRAGMA (cid)
    return out


def _table_fks(conn: sqlite3.Connection, table: str) -> List[Tuple[str, str, str]]:
    cur = conn.cursor()
    cur.execute(f'PRAGMA foreign_key_list("{table}");')
    rows = cur.fetchall()
    # columns: id, seq, table, from, to, on_update, on_delete, match
    out: List[Tuple[str, str, str]] = []
    for r in rows:
        out.append((r[3], r[2], r[4]))
    return out


def load_schema(db_path: str) -> Tuple[List[TableInfo], str]:
    """Returns (tables, ddl_sql)."""
    conn = _connect_ro(db_path)
    try:
        pairs = _list_tables(conn)
        tis: List[TableInfo] = []
        ddl_parts: List[str] = []
        for name, create_sql in pairs:
            cols = _table_columns(conn, name)
            fks = _table_fks(conn, name)
            tis.append(TableInfo(name=name, create_sql=create_sql, columns=cols, fks=fks))
            if create_sql:
                ddl_parts.append(create_sql.strip().rstrip(";") + ";")
        ddl_sql = "\n\n".join(ddl_parts) + ("\n" if ddl_parts else "")
        return tis, ddl_sql
    finally:
        conn.close()


def _format_table_block(t: TableInfo) -> str:
    # Keep it compact; PCDM can be huge.
    cols = []
    for (c, typ, pk) in t.columns:
        pk_s = " [PK]" if pk else ""
        typ_s = typ if typ else "UNKNOWN"
        cols.append(f"{c}: {typ_s}{pk_s}")
    col_line = ", ".join(cols)
    fk_lines = []
    for (from_c, to_t, to_c) in t.fks:
        fk_lines.append(f"- {t.name}.{from_c} -> {to_t}.{to_c}")
    fk_text = "\n".join(fk_lines)
    out = [f"- {t.name} ({col_line})"]
    if fk_text:
        out.append("  Relationships:")
        out.append(fk_text.replace("\n", "\n  "))
    return "\n".join(out)


def _format_schema_for_prompt(schema_name: str, tables: Sequence[TableInfo]) -> str:
    blocks = "\n".join(_format_table_block(t) for t in tables)
    return f"Schema Name: {schema_name}\n\nTables:\n{blocks}\n"


def _format_schema_for_prompt_ddl(schema_name: str, tables: Sequence[TableInfo]) -> str:
    ddls: List[str] = []
    for t in tables:
        if t.create_sql:
            ddls.append(t.create_sql.strip().rstrip(";") + ";")
        else:
            # Fallback: at least surface the table name.
            ddls.append(f"-- Missing CREATE TABLE in sqlite_master for: {t.name}")
    ddl_text = "\n\n".join(ddls)
    return f"Schema Name: {schema_name}\n\nDDL:\n{ddl_text}\n"


def _chunks(seq: Sequence[str], n: int) -> Iterable[List[str]]:
    for i in range(0, len(seq), n):
        yield list(seq[i : i + n])


def _validate_items(
    *,
    schema_name: str,
    expected_tables: Set[str],
    obj: Dict[str, Any],
) -> Tuple[bool, List[str]]:
    if not isinstance(obj, dict):
        return False, sorted(expected_tables)
    if obj.get("schema_name") not in (schema_name, None, ""):
        # Don't hard-fail on schema_name mismatch; focus on table coverage.
        pass
    items = obj.get("tables")
    if not isinstance(items, list):
        return False, sorted(expected_tables)
    seen: Set[str] = set()
    for it in items:
        if not isinstance(it, dict):
            continue
        tn = it.get("table")
        if isinstance(tn, str) and tn:
            seen.add(tn)
    missing = sorted(expected_tables - seen)
    ok = not missing
    return ok, missing


def classify_database(
    *,
    db_path: str,
    schema_name: str,
    prompt_template: str,
    out_dir: str,
    primary_model: str,
    fallback_model: str,
    openai_model: str = "gpt-5-mini",
    batch_size: int = 40,
    max_retries: int = 3,
    sleep_s: float = 0.0,
    bird_shape: bool = False,
) -> str:
    tables, ddl_sql = load_schema(db_path)
    all_names = [t.name for t in tables]
    by_name = {t.name: t for t in tables}

    os.makedirs(out_dir, exist_ok=True)

    schema_sql_path = os.path.join(out_dir, f"{schema_name}_schema.sql")
    with open(schema_sql_path, "w", encoding="utf-8") as f:
        f.write(ddl_sql)

    merged: Dict[str, Dict[str, Any]] = {}
    runs_meta: List[Dict[str, Any]] = []

    for batch_idx, batch_names in enumerate(_chunks(all_names, batch_size), start=1):
        expected = set(batch_names)
        batch_tables = [by_name[n] for n in batch_names]
        # Prefer DDL form (less lossy than hand-formatted cols/FKs).
        schema_text = _format_schema_for_prompt_ddl(schema_name, batch_tables)
        base_prompt = prompt_template.replace("[INPUT_SCHEMA_HERE]", schema_text)

        prompt = base_prompt
        last_obj: Optional[Dict[str, Any]] = None
        last_err: Optional[str] = None
        for attempt in range(max_retries):
            text, meta = _call_table_classify_llm_chain(
                openai_model=openai_model,
                gemini_primary=primary_model,
                gemini_fallback=fallback_model,
                prompt=prompt,
                sleep_s=sleep_s,
            )
            runs_meta.append(
                {
                    "batch_tables": list(batch_names),
                    "batch_index": batch_idx,
                    "attempt": attempt + 1,
                    "llm": meta,
                    "generated_at": datetime.now(timezone.utc).isoformat(),
                    "prompt_chars": len(prompt),
                    "response_chars": len(text or ""),
                }
            )
            try:
                obj = _parse_json_object(text)
                last_obj = obj
                ok, missing = _validate_items(
                    schema_name=schema_name, expected_tables=expected, obj=obj
                )
                if ok:
                    break
                # Ask for a corrected full JSON for the same batch.
                prompt = (
                    base_prompt
                    + "\n\nIMPORTANT: Your previous JSON was missing these tables from the batch:\n"
                    + ", ".join(missing)
                    + "\nReturn the FULL JSON again, including ALL tables in this batch exactly once.\n"
                )
            except Exception as e:
                last_err = str(e)
                prompt = (
                    base_prompt
                    + "\n\nYour previous response was not valid JSON. Return ONLY the JSON object.\n"
                )
        if last_obj is None:
            raise RuntimeError(
                f"Failed to classify batch (first={batch_names[0]!r}, size={len(batch_names)}). "
                f"Last error: {last_err}"
            )
        ok, missing = _validate_items(
            schema_name=schema_name, expected_tables=expected, obj=last_obj
        )
        if not ok:
            raise RuntimeError(
                f"LLM output missing tables after retries: {missing[:20]} "
                f"(total_missing={len(missing)})"
            )
        for it in last_obj.get("tables", []):
            tn = it.get("table")
            if not isinstance(tn, str) or tn not in expected:
                continue
            merged[tn] = dict(it)

    final_tables = [merged[n] for n in all_names if n in merged]
    missing_all = [n for n in all_names if n not in merged]
    if missing_all:
        raise RuntimeError(f"Internal merge bug: missing {len(missing_all)} tables.")

    out_obj_full = {
        "schema_name": schema_name,
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "db_path": os.path.abspath(db_path),
        "openai_model": openai_model,
        "model_primary": primary_model,
        "model_fallback": fallback_model,
        "batch_size": batch_size,
        "tables": final_tables,
        "meta": {
            "num_tables": len(all_names),
            "schema_sql_path": os.path.abspath(schema_sql_path),
            "runs": runs_meta,
        },
    }

    # If bird_shape is requested, emit a BIRD-compatible file while keeping a full artifact.
    out_path = os.path.join(out_dir, f"{schema_name}.json")
    if bird_shape:
        out_full_path = os.path.join(out_dir, f"{schema_name}.full.json")
        with open(out_full_path, "w", encoding="utf-8") as f:
            json.dump(out_obj_full, f, indent=2, ensure_ascii=False)
            f.write("\n")
        out_obj_bird = {"schema_name": schema_name, "tables": final_tables}
        with open(out_path, "w", encoding="utf-8") as f:
            json.dump(out_obj_bird, f, indent=2, ensure_ascii=False)
            f.write("\n")
        return out_path

    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(out_obj_full, f, indent=2, ensure_ascii=False)
        f.write("\n")
    return out_path


def _default_out_dir_bird() -> str:
    """Code/data/table_classifications/BIRD when using this bundle layout."""
    return str(Path(__file__).resolve().parents[1] / "data" / "table_classifications" / "BIRD")


def _default_out_dir_spider2() -> str:
    return str(Path(__file__).resolve().parents[1] / "data" / "table_classifications" / "Spider2")


def main(argv: Optional[List[str]] = None) -> int:
    p = argparse.ArgumentParser(
        description=(
            "Classify SQLite tables using OpenAI (primary) with Gemini fallback."
        ),
    )
    p.add_argument("--db_path", required=True, help="Path to SQLite database file.")
    p.add_argument("--schema_name", required=True, help="Schema name label for output JSON.")
    p.add_argument(
        "--prompt_path",
        default=os.path.join(os.path.dirname(__file__), "table-classification-ddl.txt"),
        help="Path to the table-classification prompt template.",
    )
    p.add_argument(
        "--corpus",
        choices=["bird", "spider2"],
        default="bird",
        help="Default output corpus when --out_dir is omitted (default: bird).",
    )
    p.add_argument(
        "--out_dir",
        default=None,
        help=(
            "Output directory (default: <Code>/data/table_classifications/BIRD or "
            ".../Spider2 per --corpus)"
        ),
    )
    p.add_argument(
        "--openai-model",
        default="gpt-5-mini",
        help="OpenAI model id tried first when OPENAI_API_KEY/OPENAI_KEY is set (default: gpt-5-mini).",
    )
    p.add_argument(
        "--model_primary",
        default="gemini-3-flash-preview",
        help="Gemini model id used if OpenAI is unavailable or fails (default: gemini-3-flash-preview).",
    )
    p.add_argument(
        "--model_fallback",
        default="gemini-2.5-flash",
        help="Second Gemini model id if the primary Gemini call fails (default: gemini-2.5-flash).",
    )
    p.add_argument("--batch_size", type=int, default=40)
    p.add_argument("--max_retries", type=int, default=3)
    p.add_argument("--sleep", type=float, default=0.0, help="Seconds to sleep between calls.")
    p.add_argument(
        "--bird-shape",
        action="store_true",
        help="Emit BIRD-compatible JSON (schema_name + tables) and also write <schema>.full.json.",
    )

    args = p.parse_args(argv)
    if args.out_dir:
        out_dir = args.out_dir
    elif args.corpus == "spider2":
        out_dir = _default_out_dir_spider2()
    else:
        out_dir = _default_out_dir_bird()

    if not (_openai_api_key_optional() or _gemini_api_key_optional()):
        print(
            "Error: set OPENAI_API_KEY or OPENAI_KEY and/or GEMINI_API_KEY or GOOGLE_API_KEY.",
            file=sys.stderr,
        )
        return 1

    try:
        with open(args.prompt_path, "r", encoding="utf-8") as f:
            template = f.read()
        out_path = classify_database(
            db_path=args.db_path,
            schema_name=args.schema_name,
            prompt_template=template,
            out_dir=out_dir,
            primary_model=args.model_primary,
            fallback_model=args.model_fallback,
            openai_model=args.openai_model,
            batch_size=args.batch_size,
            max_retries=args.max_retries,
            sleep_s=args.sleep,
            bird_shape=bool(args.bird_shape),
        )
    except Exception as e:
        print(str(e), file=sys.stderr)
        return 1
    print(f"Wrote: {out_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

