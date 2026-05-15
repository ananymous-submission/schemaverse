from __future__ import annotations

import os
import sys
from typing import List, Optional, Sequence, Tuple

from main import generate_instance
from paths import data_table_classifications_subdir, legacy_column_enrichment_root
from sciencebenchmark_prepare import (
    SCIENCEBENCHMARK_SCHEMAS,
    PreparedScienceDb,
    prepare_sciencebenchmark_db,
)


def _repo_root() -> str:
    return os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))


def _default_output_dir(output_root: str, db_name: str) -> str:
    return os.path.join(output_root, f"{db_name}_benchmark")


def _check_inputs_exist(
    *,
    names: Sequence[str],
    sciencebenchmark_root: str,
    column_enrichment_root: str,
    classifications_dir: str,
) -> None:
    missing: List[str] = []
    for name in names:
        if name not in SCIENCEBENCHMARK_SCHEMAS:
            missing.append(f"{name}: unknown ScienceBenchmark database")
            continue
        restore_sql = os.path.join(sciencebenchmark_root, name, "db", "restore.sql")
        dev_json = os.path.join(sciencebenchmark_root, name, "dev.json")
        enrich_src = os.path.join(
            column_enrichment_root, name, "column_semantic_enrichment.json"
        )
        cls_path = os.path.join(classifications_dir, f"{name}.json")
        for path, label in (
            (restore_sql, "restore.sql"),
            (dev_json, "dev.json"),
            (enrich_src, "column_semantic_enrichment.json"),
            (cls_path, "table classification"),
        ):
            if not os.path.isfile(path):
                missing.append(f"{name}: missing {label}: {path}")
    if missing:
        raise RuntimeError(
            "Missing required ScienceBenchmark inputs (aborting; no fallbacks):\n"
            + "\n".join(f"  - {m}" for m in missing)
        )


def main(argv: Optional[List[str]] = None) -> int:
    import argparse

    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument(
        "--names",
        nargs="*",
        default=list(SCIENCEBENCHMARK_SCHEMAS.keys()),
        choices=list(SCIENCEBENCHMARK_SCHEMAS.keys()),
        help="Subset of databases to generate (default: all three).",
    )
    p.add_argument(
        "--sciencebenchmark-root",
        default=os.path.join(_repo_root(), "sciencebenchmark_dataset"),
    )
    p.add_argument(
        "--column-enrichment-root",
        default=legacy_column_enrichment_root(),
    )
    p.add_argument(
        "--classifications-dir",
        default=data_table_classifications_subdir("ScienceBenchmark"),
        help="Must contain <db>.json for every DB (default: Code/data/table_classifications/ScienceBenchmark).",
    )
    p.add_argument(
        "--output-root",
        default="output_sciencebenchmark",
        help="Root folder for outputs.",
    )
    p.add_argument("--seed", type=int, default=42)
    p.add_argument(
        "--difficulty",
        choices=["easy", "medium", "hard", "extra_hard"],
        default="hard",
    )
    p.add_argument(
        "--use-llm",
        action="store_true",
        default=True,
        help="Use LLM naming drift (always enabled in batch runners; requires OPENAI_API_KEY / OPENAI_KEY).",
    )
    p.add_argument(
        "--no-dedup",
        action="store_true",
        help="Keep duplicate dev.json queries (default: deduplicate).",
    )
    p.add_argument(
        "--prepare-only",
        action="store_true",
        help="Only stage SQLite + queries (skip generate_instance).",
    )
    args = p.parse_args(argv)

    sciencebenchmark_root = os.path.abspath(args.sciencebenchmark_root)
    column_enrichment_root = os.path.abspath(args.column_enrichment_root)
    classifications_dir = os.path.abspath(args.classifications_dir)
    output_root = os.path.abspath(args.output_root)

    try:
        _check_inputs_exist(
            names=args.names,
            sciencebenchmark_root=sciencebenchmark_root,
            column_enrichment_root=column_enrichment_root,
            classifications_dir=classifications_dir,
        )
    except Exception as e:
        print(str(e), file=sys.stderr)
        return 1

    os.makedirs(output_root, exist_ok=True)

    # Stage all DBs first (idempotent), then run generate_instance per DB.
    prepared: List[PreparedScienceDb] = []
    for i, name in enumerate(args.names, start=1):
        print(
            f"[{i}/{len(args.names)}] PREPARE db={name!r}",
            file=sys.stderr,
            flush=True,
        )
        try:
            p_info = prepare_sciencebenchmark_db(
                name=name,
                sciencebenchmark_root=sciencebenchmark_root,
                column_enrichment_root=column_enrichment_root,
                classifications_dir=classifications_dir,
                output_root=output_root,
                deduplicate_queries=not args.no_dedup,
            )
        except Exception as e:
            print(f"  PREPARE FAILED for {name!r}: {e}", file=sys.stderr)
            return 1
        prepared.append(p_info)
        print(
            f"  staged: sqlite={p_info.sqlite_path} "
            f"({sum(p_info.table_counts.values()):,} rows in "
            f"{len(p_info.table_counts)} tables); "
            f"{p_info.num_queries} queries",
            file=sys.stderr,
            flush=True,
        )

    if args.prepare_only:
        return 0

    failures: List[Tuple[str, str]] = []
    for i, info in enumerate(prepared, start=1):
        out_dir = _default_output_dir(output_root, info.name)
        meta_path = os.path.join(out_dir, "metadata.json")
        if os.path.isfile(meta_path):
            print(
                f"[{i}/{len(prepared)}] SKIP db={info.name!r} "
                f"reason=existing_metadata path={meta_path}",
                file=sys.stderr,
                flush=True,
            )
            continue
        print(
            f"[{i}/{len(prepared)}] WORK db={info.name!r} -> {out_dir}",
            file=sys.stderr,
            flush=True,
        )
        try:
            ok = generate_instance(
                db_path=os.path.abspath(info.sqlite_path),
                queries_path=os.path.abspath(info.queries_path),
                output_dir=os.path.abspath(out_dir),
                difficulty=args.difficulty,
                seed=args.seed,
                use_llm=True,
                classifications_dir=classifications_dir,
            )
            if not ok:
                failures.append((info.name, "generate_instance returned False"))
        except Exception as e:
            failures.append((info.name, str(e)))
            break  # stop immediately when a generation fails (matches BIRD/Spider2 runners)

    if failures:
        print("\nFailures:", file=sys.stderr)
        for name, err in failures:
            print(f"  - {name}: {err}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
