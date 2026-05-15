from __future__ import annotations

import json
import os
import re
from datetime import datetime, timezone
from typing import Any, Dict, List, Optional, Set, Tuple

from classify_sqlite_db import (
    _call_table_classify_llm_chain,
    _parse_json_object,
    _validate_items,
)

_TABLE_LINE_RE = re.compile(r"^TABLE\s+(\S+)\s*$", re.IGNORECASE)


def split_sciencebenchmark_schema_text(text: str) -> Tuple[str, List[Tuple[str, str]]]:
    """
    Returns (preamble, [(table_name, table_block), ...]).
    Preamble is all lines before the first ``TABLE`` line.
    """
    lines = (text or "").splitlines()
    p_lines: List[str] = []
    blocks: List[Tuple[str, str]] = []
    current_name: Optional[str] = None
    current_lines: List[str] = []
    in_table = False
    first_table_yet = False

    for line in lines:
        m = _TABLE_LINE_RE.match(line.strip())
        if m:
            first_table_yet = True
            if in_table and current_name is not None:
                blocks.append((current_name, "\n".join(current_lines).rstrip() + "\n"))
            current_name = m.group(1)
            current_lines = [line]
            in_table = True
            continue
        if in_table:
            current_lines.append(line)
        else:
            p_lines.append(line)

    if in_table and current_name is not None:
        blocks.append((current_name, "\n".join(current_lines).rstrip() + "\n"))

    if not first_table_yet:
        return "", []
    preamble = "\n".join(p_lines).rstrip() + ("\n" if p_lines else "")

    return preamble, blocks


def _format_batch_schema_text(
    schema_name: str, preamble: str, batch_blocks: List[Tuple[str, str]]
) -> str:
    parts: List[str] = [
        f"Schema Name: {schema_name}",
        "",
    ]
    if preamble.strip():
        parts.append(preamble.rstrip() + "\n\n")
    parts.append("\n\n".join(b[1].rstrip() for b in batch_blocks))
    return "\n".join(parts).rstrip() + "\n"


def _chunks(seq: List[Any], n: int) -> List[List[Any]]:
    return [seq[i : i + n] for i in range(0, len(seq), n)]


def classify_sciencebenchmark_schema(
    *,
    schema_file: str,
    schema_name: str,
    prompt_template: str,
    out_dir: str,
    primary_model: str,
    fallback_model: str,
    openai_model: str = "gpt-5-mini",
    batch_size: int = 40,
    max_retries: int = 3,
    sleep_s: float = 0.0,
) -> str:
    """
    Read schema text file, call OpenAI then Gemini fallback chain, write BIRD-shaped + .full.json + _schema.txt snapshot.
    """
    with open(schema_file, "r", encoding="utf-8") as f:
        raw = f.read()

    preamble, blocks = split_sciencebenchmark_schema_text(raw)
    if not blocks:
        raise ValueError(f"No TABLE blocks found in {schema_file!r}")

    all_names = [b[0] for b in blocks]
    by_name = {b[0]: b[1] for b in blocks}

    os.makedirs(out_dir, exist_ok=True)

    schema_snapshot_path = os.path.join(out_dir, f"{schema_name}_schema.txt")
    with open(schema_snapshot_path, "w", encoding="utf-8") as f:
        f.write(raw)

    merged: Dict[str, Dict[str, Any]] = {}
    runs_meta: List[Dict[str, Any]] = []
    source_abs = os.path.abspath(schema_file)

    for batch_idx, name_chunk in enumerate(_chunks(all_names, batch_size), start=1):
        expected: Set[str] = set(name_chunk)
        batch_blocks = [(n, by_name[n]) for n in name_chunk]
        schema_text = _format_batch_schema_text(schema_name, preamble, batch_blocks)
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
                    "batch_tables": list(name_chunk),
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
                f"Failed to classify batch (first={name_chunk[0]!r}, size={len(name_chunk)}). "
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
        "db_path": source_abs,
        "schema_format": "sciencebenchmark_schema_for_prompt",
        "openai_model": openai_model,
        "model_primary": primary_model,
        "model_fallback": fallback_model,
        "batch_size": batch_size,
        "tables": final_tables,
        "meta": {
            "num_tables": len(all_names),
            "schema_snapshot_path": os.path.abspath(schema_snapshot_path),
            "runs": runs_meta,
        },
    }

    out_path = os.path.join(out_dir, f"{schema_name}.json")
    out_full_path = os.path.join(out_dir, f"{schema_name}.full.json")
    with open(out_full_path, "w", encoding="utf-8") as f:
        json.dump(out_obj_full, f, indent=2, ensure_ascii=False)
        f.write("\n")
    out_obj_bird = {"schema_name": schema_name, "tables": final_tables}
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(out_obj_bird, f, indent=2, ensure_ascii=False)
        f.write("\n")
    return out_path
