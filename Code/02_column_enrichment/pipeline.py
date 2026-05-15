from __future__ import annotations

import json
import os
import sys
import time
from datetime import datetime, timezone
from typing import Any, Dict, List, Optional, Tuple

import bird_layout, description_csv, llm_enrichment, schema_extract, value_sampling
from run_logger import SessionFileLogger, new_session_logger
from spider2_layout import default_output_path, discover_spider2_databases, sqlite_path
from spider2_metadata import load_spider2_db_metadata, load_spider2_schema_metadata


def _progress_line(msg: str, enabled: bool) -> None:
    if not enabled:
        return
    print(msg, file=sys.stderr, flush=True)


def _normalize_col_entry(raw: Any) -> Dict[str, Any]:
    if not isinstance(raw, dict):
        return {"alternative_names": [], "description": ""}
    alts = raw.get("alternative_names") or []
    if not isinstance(alts, list):
        alts = []
    cleaned: List[str] = []
    seen_lower = set()
    for a in alts:
        s = str(a).strip()
        if not s:
            continue
        if s.lower() in seen_lower:
            continue
        seen_lower.add(s.lower())
        cleaned.append(s)
        if len(cleaned) >= 3:
            break
    desc = str(raw.get("description") or "").strip()
    return {"alternative_names": cleaned, "description": desc}


def _table_context(ts: schema_extract.TableSchema) -> Dict[str, Any]:
    return {
        "foreign_keys": [
            {
                "from_column": fk.from_column,
                "to_table": fk.to_table,
                "to_column": fk.to_column,
            }
            for fk in ts.foreign_keys
        ],
    }


def _build_column_payload(
    col: schema_extract.ColumnInfo,
    col_meta: Optional[Dict[str, str]],
    samples: List[Any],
) -> Dict[str, Any]:
    out: Dict[str, Any] = {
        "name": col.name,
        "sqlite_type": col.type,
        "not_null": col.notnull,
        "primary_key": col.pk,
        "value_profile": samples,
    }
    # Generic metadata keys (not dataset-specific). Only include non-empty fields.
    if col_meta:
        cd = (col_meta.get("column_description") or "").strip()
        vd = (col_meta.get("value_description") or "").strip()
        df = (col_meta.get("data_format") or "").strip()
        if cd:
            out["column_description"] = cd
        if vd:
            out["value_description"] = vd
        if df:
            out["data_format"] = df
    return out


def _split_table_into_column_segments(
    table_name: str,
    ts: schema_extract.TableSchema,
    col_payloads: List[Dict[str, Any]],
    max_columns: int,
) -> List[llm_enrichment.BatchSegment]:
    """Split one table's columns into segments of at most ``max_columns`` each."""
    ctx = _table_context(ts)
    out: List[llm_enrichment.BatchSegment] = []
    mc = max(1, int(max_columns))
    for start in range(0, len(col_payloads), mc):
        piece = col_payloads[start : start + mc]
        out.append((table_name, ctx, piece))
    return out


def _pack_segments_into_llm_batches(
    segments: List[llm_enrichment.BatchSegment],
    max_columns: int,
) -> List[List[llm_enrichment.BatchSegment]]:
    """
    Greedily pack column segments into batches where the total number of columns
    in the batch does not exceed ``max_columns`` (so multiple tables can share one prompt).
    """
    mc = max(1, int(max_columns))
    batches: List[List[llm_enrichment.BatchSegment]] = []
    cur: List[llm_enrichment.BatchSegment] = []
    cur_n = 0
    for seg in segments:
        _t, _ctx, cols = seg
        n = len(cols)
        if cur and cur_n + n > mc:
            batches.append(cur)
            cur = []
            cur_n = 0
        cur.append(seg)
        cur_n += n
    if cur:
        batches.append(cur)
    return batches


def enrich_database(
    *,
    sqlite_path: str,
    out_path: str,
    db_name: Optional[str] = None,
    table_metadata: Optional[Dict[str, Any]] = None,
    table_sample_rows: Optional[Dict[str, List[Dict[str, Any]]]] = None,
    model: str,
    gemini_fallback_model: str = "gemini-2.5-flash",
    samples_per_column: int = 5,
    column_chunk_size: int = 40,
    force: bool = False,
    dry_run: bool = False,
    sleep_s: float = 0.0,
    openai_primary_model: str = "gpt-5-mini",
    openai_fallback_model: str = "gpt-5-mini",
    progress: bool = False,
) -> Tuple[bool, str]:
    bird_layout.assert_sqlite_exists(sqlite_path)

    if os.path.isfile(out_path) and not force and not dry_run:
        return True, f"Skip existing (use --force): {out_path}"

    schema_dir = os.path.dirname(os.path.abspath(sqlite_path))
    if not db_name:
        # Fallback: use parent folder name (BIRD layout).
        db_name = os.path.basename(schema_dir)
    _progress_line(
        f"[column_enrichment] database={db_name!r} — reading schema + metadata…",
        progress,
    )
    # Default metadata source (BIRD): database_description/*.csv next to sqlite file.
    descriptions = table_metadata if table_metadata is not None else description_csv.load_database_descriptions(schema_dir)

    tables_map = schema_extract.extract_schema(sqlite_path)
    table_names_sorted = sorted(tables_map.keys())
    n_tables = len(table_names_sorted)

    import sqlite3

    conn = sqlite3.connect(f"file:{sqlite_path}?mode=ro", uri=True)
    session_logger: Optional[SessionFileLogger] = None
    db_llm_state: Optional[Dict[str, Any]] = None
    if not dry_run:
        session_logger = new_session_logger(db_name)
        db_llm_state = {"openai_only": False, "primary_calls": 0}

    try:
        all_payload_debug: List[str] = []
        merged_tables: Dict[str, Dict[str, Any]] = {}
        first_llm_call = True
        csize = max(1, int(column_chunk_size))

        col_payloads_by_table: Dict[str, List[Dict[str, Any]]] = {}
        for table_name in table_names_sorted:
            ts = tables_map[table_name]
            table_meta = (descriptions or {}).get(table_name, {})
            col_payloads: List[Dict[str, Any]] = []
            sample_rows_for_table = (table_sample_rows or {}).get(table_name, [])
            for col in ts.columns:
                col_meta = table_meta.get(col.name, {}) if isinstance(table_meta, dict) else {}
                # Prefer external sample_rows (Spider2) if available; otherwise query the DB.
                if sample_rows_for_table:
                    samples = value_sampling.sample_values_from_sample_rows(
                        sample_rows_for_table, col.name, k=samples_per_column
                    )
                else:
                    samples = value_sampling.sample_column_values(
                        conn, table_name, col.name, k=samples_per_column
                    )
                col_payloads.append(_build_column_payload(col, col_meta or None, samples))
            col_payloads_by_table[table_name] = col_payloads

        if dry_run:
            for ti, table_name in enumerate(table_names_sorted, start=1):
                col_payloads = col_payloads_by_table[table_name]
                _progress_line(
                    f"[column_enrichment] database={db_name!r}  table {ti}/{n_tables}  "
                    f"{table_name!r}  ({len(col_payloads)} columns, dry-run)",
                    progress,
                )
                all_payload_debug.append(
                    f"{table_name}: {len(col_payloads)} columns, "
                    f"{sum(len(c.get('value_profile') or []) for c in col_payloads)} samples"
                )
                merged_tables[table_name] = {"columns": {}}
        else:
            segments: List[llm_enrichment.BatchSegment] = []
            for table_name in table_names_sorted:
                ts = tables_map[table_name]
                col_payloads = col_payloads_by_table[table_name]
                segments.extend(
                    _split_table_into_column_segments(table_name, ts, col_payloads, csize)
                )

            batches = _pack_segments_into_llm_batches(segments, csize)
            merged_tables = {tn: {"columns": {}} for tn in table_names_sorted}
            n_batches = len(batches)

            for batch_idx, batch in enumerate(batches, start=1):
                if sleep_s > 0 and not first_llm_call:
                    time.sleep(sleep_s)
                first_llm_call = False
                ncols_batch = sum(len(seg[2]) for seg in batch)
                tables_in_batch = list(dict.fromkeys(seg[0] for seg in batch))
                _progress_line(
                    f"[column_enrichment] database={db_name!r}  LLM batch {batch_idx}/{n_batches}  "
                    f"{ncols_batch} column(s)  table(s)={tables_in_batch!r}",
                    progress,
                )
                raw_by_table = llm_enrichment.generate_batch_column_enrichment_json(
                    model=model,
                    batch_segments=batch,
                    gemini_fallback_model=gemini_fallback_model,
                    transcript=None,
                    transcript_prefix={
                        "tables_in_batch": tables_in_batch,
                        "batch_index": batch_idx - 1,
                        "columns_in_batch": ncols_batch,
                        "batch_column_names": [
                            f"{t}.{c['name']}" for t, _ctx, cols in batch for c in cols
                        ],
                    },
                    openai_primary_model=openai_primary_model,
                    openai_fallback_model=openai_fallback_model,
                    session_logger=session_logger,
                    db_llm_state=db_llm_state,
                )
                for tname, cols_map in raw_by_table.items():
                    if tname not in merged_tables:
                        merged_tables[tname] = {"columns": {}}
                    for cname, entry in cols_map.items():
                        merged_tables[tname]["columns"][cname] = _normalize_col_entry(entry)

    finally:
        conn.close()

    if dry_run:
        msg = "Dry run:\n" + "\n".join(all_payload_debug)
        return True, msg

    generated_at = datetime.now(timezone.utc).isoformat()
    usage_totals: Dict[str, Any] = (
        session_logger.usage_totals() if session_logger is not None else {}
    )
    openai_only_db = bool(db_llm_state and db_llm_state.get("openai_only"))

    result = {
        "schema_name": db_name,
        "sqlite_path": os.path.abspath(sqlite_path),
        "generated_at": generated_at,
        "model": model,
        "gemini_fallback_model": gemini_fallback_model,
        "openai_primary_model": openai_primary_model,
        "openai_fallback_model": openai_fallback_model,
        "sample_rows_per_column": samples_per_column,
        "llm_usage_totals": usage_totals,
        "llm_openai_only_for_database": openai_only_db,
        "tables": merged_tables,
    }

    os.makedirs(os.path.dirname(out_path) or ".", exist_ok=True)
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(result, f, indent=2, ensure_ascii=False)

    return True, f"Wrote {out_path}"


def run_bird_root(
    bird_root: str,
    db_names: Optional[List[str]],
    *,
    all_dbs: bool,
    databases_subdir: str = bird_layout.DEFAULT_BIRD_DATABASES_SUBDIR,
    model: str,
    gemini_fallback_model: str = "gemini-2.5-flash",
    samples_per_column: int,
    column_chunk_size: int,
    force: bool,
    dry_run: bool,
    sleep_s: float,
    openai_primary_model: str = "gpt-5-mini",
    openai_fallback_model: str = "gpt-5-mini",
    progress: bool = False,
) -> List[Tuple[str, bool, str]]:
    results: List[Tuple[str, bool, str]] = []
    if all_dbs:
        names = bird_layout.discover_bird_databases(bird_root, databases_subdir)
    elif db_names:
        names = db_names
    else:
        return results

    total = len(names)
    for i, name in enumerate(names):
        if i > 0:
            time.sleep(2.0)
        _progress_line(
            f"[column_enrichment] ({i + 1}/{total}) starting database {name!r} …",
            progress,
        )
        sp = bird_layout.sqlite_path(bird_root, name, databases_subdir)
        op = bird_layout.default_output_path(bird_root, name, databases_subdir)
        try:
            ok, msg = enrich_database(
                sqlite_path=sp,
                out_path=op,
                db_name=name,
                model=model,
                gemini_fallback_model=gemini_fallback_model,
                samples_per_column=samples_per_column,
                column_chunk_size=column_chunk_size,
                force=force,
                dry_run=dry_run,
                sleep_s=sleep_s,
                openai_primary_model=openai_primary_model,
                openai_fallback_model=openai_fallback_model,
                progress=progress,
            )
        except FileNotFoundError as e:
            ok, msg = False, str(e)
        results.append((name, ok, msg))
    return results


def run_spider2_root(
    spider2_root: str,
    db_names: Optional[List[str]],
    *,
    all_dbs: bool,
    model: str,
    gemini_fallback_model: str = "gemini-2.5-flash",
    samples_per_column: int,
    column_chunk_size: int,
    force: bool,
    dry_run: bool,
    sleep_s: float,
    openai_primary_model: str = "gpt-5-mini",
    openai_fallback_model: str = "gpt-5-mini",
    progress: bool = False,
) -> List[Tuple[str, bool, str]]:
    """Enrich Spider2 DBs under ``{spider2_root}/{name}/{name}.sqlite``."""
    if all_dbs:
        names = discover_spider2_databases(spider2_root)
    elif db_names:
        names = db_names
    else:
        return []

    results: List[Tuple[str, bool, str]] = []
    total = len(names)
    for i, name in enumerate(names):
        if i > 0:
            time.sleep(2.0)
        _progress_line(
            f"[column_enrichment] Spider2 ({i + 1}/{total}) starting {name!r} …",
            progress,
        )
        sp = sqlite_path(spider2_root, name)
        op = default_output_path(spider2_root, name)
        db_dir = os.path.dirname(sp)
        tmeta, tsamples = load_spider2_db_metadata(db_dir)
        try:
            ok, msg = enrich_database(
                sqlite_path=sp,
                out_path=op,
                db_name=name,
                table_metadata=tmeta or None,
                table_sample_rows=tsamples or None,
                model=model,
                gemini_fallback_model=gemini_fallback_model,
                samples_per_column=samples_per_column,
                column_chunk_size=column_chunk_size,
                force=force,
                dry_run=dry_run,
                sleep_s=sleep_s,
                openai_primary_model=openai_primary_model,
                openai_fallback_model=openai_fallback_model,
                progress=progress,
            )
        except FileNotFoundError as e:
            ok, msg = False, str(e)
        results.append((name, ok, msg))
    return results


def run_sqlite_dir(
    sqlite_dir: str,
    *,
    metadata_root: Optional[str] = None,
    metadata_format: Optional[str] = None,
    model: str,
    gemini_fallback_model: str = "gemini-2.5-flash",
    samples_per_column: int,
    column_chunk_size: int,
    force: bool,
    dry_run: bool,
    sleep_s: float,
    openai_primary_model: str = "gpt-5-mini",
    openai_fallback_model: str = "gpt-5-mini",
    progress: bool = False,
) -> List[Tuple[str, bool, str]]:
    """Process every *.sqlite file in a directory (non-recursive)."""
    root = os.path.abspath(sqlite_dir)
    if not os.path.isdir(root):
        return []
    db_files = sorted(
        fn for fn in os.listdir(root) if fn.lower().endswith(".sqlite")
    )
    if not db_files:
        return []

    results: List[Tuple[str, bool, str]] = []
    total = len(db_files)
    for i, fn in enumerate(db_files):
        if i > 0:
            time.sleep(2.0)
        sqlite_path = os.path.join(root, fn)
        schema_name = os.path.splitext(fn)[0]

        _progress_line(
            f"[column_enrichment] ({i + 1}/{total}) starting database {schema_name!r} …",
            progress,
        )

        # Output convention: create a per-schema folder next to the sqlite file.
        out_dir = os.path.join(root, schema_name)
        out_path = os.path.join(out_dir, "column_semantic_enrichment.json")

        table_meta = None
        table_sample_rows = None
        if metadata_format == "spider2" and metadata_root:
            tmeta, tsamples = load_spider2_schema_metadata(metadata_root, schema_name)
            table_meta = tmeta
            table_sample_rows = tsamples

        try:
            ok, msg = enrich_database(
                sqlite_path=sqlite_path,
                out_path=out_path,
                db_name=schema_name,
                table_metadata=table_meta,
                table_sample_rows=table_sample_rows,
                model=model,
                gemini_fallback_model=gemini_fallback_model,
                samples_per_column=samples_per_column,
                column_chunk_size=column_chunk_size,
                force=force,
                dry_run=dry_run,
                sleep_s=sleep_s,
                openai_primary_model=openai_primary_model,
                openai_fallback_model=openai_fallback_model,
                progress=progress,
            )
        except FileNotFoundError as e:
            ok, msg = False, str(e)
        results.append((schema_name, ok, msg))
    return results
