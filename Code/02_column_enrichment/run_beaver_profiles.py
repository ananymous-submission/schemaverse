from __future__ import annotations

import copy
import json
import os
import sys
import time
from datetime import datetime, timezone
from typing import Any, Dict, List, Tuple

import llm_enrichment, run_logger
from pipeline import _normalize_col_entry, _pack_segments_into_llm_batches


def _package_root() -> str:
    return os.path.dirname(os.path.abspath(__file__))


def _repo_root() -> str:
    return os.path.abspath(os.path.join(_package_root(), ".."))


# logical_name -> table_profiles.json path (relative to repo root)
DEFAULT_BEAVER_TABLE_PROFILES: Dict[str, str] = {
    "new_dw": "beaver/databases/DW/new_dw_indexed_table_profiles.json",
    "csail_stata_cinder": "beaver/databases/NW/exportedsql/csail_stata_cinder_table_profiles.json",
    "csail_stata_glance": "beaver/databases/NW/exportedsql/csail_stata_glance_table_profiles.json",
    "csail_stata_neutron": "beaver/databases/NW/exportedsql/csail_stata_neutron_table_profiles.json",
    "csail_stata_nova": "beaver/databases/NW/exportedsql/csail_stata_nova_table_profiles.json",
    "keystone": "beaver/databases/NW/exportedsql/keystone_table_profiles.json",
}


def _load_table_profiles(path: str) -> List[Dict[str, Any]]:
    with open(path, "r", encoding="utf-8") as f:
        data = json.load(f)
    if not isinstance(data, list):
        raise ValueError(f"Expected list in {path}")
    return [x for x in data if isinstance(x, dict)]


def _normalize_beaver_columns_for_llm(rows: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
    """
    build_beaver_profiles uses "type" for generic SQL type; BIRD-style payloads use sqlite_type.
    Copy type -> sqlite_type when needed so prompts match the main pipeline.
    """
    out: List[Dict[str, Any]] = []
    for row in rows:
        r = copy.deepcopy(row)
        cols = r.get("columns_to_enrich")
        if isinstance(cols, list):
            for c in cols:
                if not isinstance(c, dict):
                    continue
                if "sqlite_type" not in c and "type" in c:
                    c["sqlite_type"] = c["type"]
        out.append(r)
    return out


def _segments_from_profiles(
    rows: List[Dict[str, Any]], column_chunk_size: int
) -> List[llm_enrichment.BatchSegment]:
    mc = max(1, int(column_chunk_size))
    out: List[llm_enrichment.BatchSegment] = []
    for row in rows:
        tname = row.get("table")
        if not isinstance(tname, str) or not tname:
            continue
        ctx = row.get("table_context") or {}
        if not isinstance(ctx, dict):
            ctx = {}
        cols = row.get("columns_to_enrich")
        if not isinstance(cols, list) or not cols:
            continue
        for i in range(0, len(cols), mc):
            chunk = cols[i : i + mc]
            out.append((tname, ctx, chunk))
    return out


def enrich_beaver_db(
    *,
    db_name: str,
    table_profiles_path: str,
    out_path: str,
    model: str = "gemini-3-flash-preview",
    column_chunk_size: int = 40,
    force: bool = False,
    dry_run: bool = False,
    sleep_s: float = 0.0,
    openai_fallback_model: str = "gpt-5-mini",
) -> Tuple[bool, str]:
    if os.path.isfile(out_path) and not force and not dry_run:
        return True, f"Skip existing (use --force): {out_path}"

    raw_rows = _load_table_profiles(table_profiles_path)
    rows = _normalize_beaver_columns_for_llm(raw_rows)
    table_order = [r.get("table") for r in rows if isinstance(r.get("table"), str)]
    table_names_sorted = sorted(set(t for t in table_order if t))

    if dry_run:
        ncols = 0
        for r in rows:
            c = r.get("columns_to_enrich")
            if isinstance(c, list):
                ncols += len(c)
        return True, f"Dry run {db_name}: {len(table_names_sorted)} table(s), {ncols} column payload(s)."

    segments = _segments_from_profiles(rows, column_chunk_size)
    batches = _pack_segments_into_llm_batches(segments, column_chunk_size)
    merged_tables: Dict[str, Dict[str, Any]] = {tn: {"columns": {}} for tn in table_names_sorted}

    session_logger = run_logger.new_session_logger(db_name)
    db_llm_state: Dict[str, Any] = {"openai_only": False, "primary_calls": 0}
    first = True
    n_batches = len(batches)

    for batch_idx, batch in enumerate(batches, start=1):
        if not first and sleep_s > 0:
            time.sleep(sleep_s)
        first = False
        ncols = sum(len(seg[2]) for seg in batch)
        tables_in_batch = list(dict.fromkeys(seg[0] for seg in batch))
        raw = llm_enrichment.generate_batch_column_enrichment_json(
            model=model,
            batch_segments=batch,
            transcript=None,
            transcript_prefix={
                "source": "beaver_table_profiles",
                "table_profiles_path": os.path.abspath(table_profiles_path),
                "tables_in_batch": tables_in_batch,
                "batch_index": batch_idx - 1,
                "batches_total": n_batches,
                "columns_in_batch": ncols,
                "batch_column_names": [f"{t}.{c['name']}" for t, _c, cols in batch for c in cols],
            },
            openai_fallback_model=openai_fallback_model,
            session_logger=session_logger,
            db_llm_state=db_llm_state,
        )
        for tname, cols_map in raw.items():
            if tname not in merged_tables:
                merged_tables[tname] = {"columns": {}}
            for cname, entry in cols_map.items():
                merged_tables[tname]["columns"][cname] = _normalize_col_entry(entry)

    generated_at = datetime.now(timezone.utc).isoformat()
    usage = session_logger.usage_totals()
    result = {
        "schema_name": db_name,
        "sqlite_path": os.path.abspath(table_profiles_path),
        "source": "beaver",
        "table_profiles_path": os.path.abspath(table_profiles_path),
        "generated_at": generated_at,
        "model": model,
        "openai_fallback_model": openai_fallback_model,
        "sample_rows_per_column": 0,
        "llm_usage_totals": usage,
        "llm_openai_only_for_database": bool(db_llm_state.get("openai_only")),
        "tables": merged_tables,
    }
    os.makedirs(os.path.dirname(out_path) or ".", exist_ok=True)
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(result, f, indent=2, ensure_ascii=False)
        f.write("\n")
    return True, f"Wrote {out_path}"


def main() -> int:
    import argparse

    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument(
        "--beaver-root",
        default=_repo_root(),
        help="Repository root (default: parent of column_enrichment/)",
    )
    p.add_argument(
        "--db",
        action="append",
        help="Logical DB name, e.g. new_dw, keystone (repeatable).",
    )
    p.add_argument("--all", action="store_true", help="Run all six Beaver databases.")
    p.add_argument("--model", default="gemini-3-flash-preview")
    p.add_argument("--chunk-size", type=int, default=40)
    p.add_argument("--force", action="store_true")
    p.add_argument("--dry-run", action="store_true")
    p.add_argument("--sleep", type=float, default=0.0)
    p.add_argument("--openai-fallback-model", default="gpt-5-mini")
    args = p.parse_args()

    if args.all:
        names: List[str] = list(DEFAULT_BEAVER_TABLE_PROFILES.keys())
    elif args.db:
        names = list(args.db)
    else:
        p.error("Specify --all or at least one --db")

    failures: List[Tuple[str, str]] = []
    for i, name in enumerate(names):
        if i > 0:
            time.sleep(2.0)
        rel = DEFAULT_BEAVER_TABLE_PROFILES.get(name)
        if not rel:
            print(f"FAIL {name}: unknown (known: {list(DEFAULT_BEAVER_TABLE_PROFILES)})", file=sys.stderr)
            failures.append((name, "unknown db"))
            continue
        tp = os.path.join(args.beaver_root, rel)
        out = os.path.join(_package_root(), name, "column_semantic_enrichment.json")
        print(f"[Beaver enrichment] {name} ...", file=sys.stderr, flush=True)
        try:
            if not os.path.isfile(tp):
                raise FileNotFoundError(tp)
            ok, msg = enrich_beaver_db(
                db_name=name,
                table_profiles_path=tp,
                out_path=out,
                model=args.model,
                column_chunk_size=args.chunk_size,
                force=args.force,
                dry_run=args.dry_run,
                sleep_s=args.sleep,
                openai_fallback_model=args.openai_fallback_model,
            )
            if not ok:
                failures.append((name, msg))
            else:
                print(msg, file=sys.stderr, flush=True)
        except Exception as e:
            failures.append((name, str(e)))
            print(f"FAIL {name}: {e}", file=sys.stderr, flush=True)

    if failures:
        for n, m in failures:
            print(f"  - {n}: {m}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
