from __future__ import annotations

import os
import sys
from typing import List, Optional, Sequence, Tuple

from beaver_prepare import BEAVER_DBS, PreparedBeaverDb, prepare_beaver_db
from main import generate_instance
from paths import data_table_classifications_subdir, legacy_column_enrichment_root


def _repo_root() -> str:
    return os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))


def _default_output_dir(output_root: str, db_name: str) -> str:
    return os.path.join(output_root, f"{db_name}_benchmark")


def _check_inputs_exist(
    *,
    names: Sequence[str],
    beaver_root: str,
    column_enrichment_root: str,
    classifications_dir: str,
) -> None:
    missing: List[str] = []
    for name in names:
        if name not in BEAVER_DBS:
            missing.append(f"{name}: unknown BEAVER database")
            continue

        if name == "new_dw":
            sql_path = os.path.join(beaver_root, "databases", "DW", "new_dw_indexed.sql")
        else:
            sql_path = os.path.join(
                beaver_root, "databases", "NW", "exportedsql", f"{name}.sql"
            )
        enrich_src = os.path.join(
            column_enrichment_root, name, "column_semantic_enrichment.json"
        )
        cls_path = os.path.join(classifications_dir, f"{name}.json")

        for path, label in (
            (sql_path, "MySQL dump (.sql)"),
            (enrich_src, "column_semantic_enrichment.json"),
            (cls_path, "table classification"),
        ):
            if not os.path.isfile(path):
                missing.append(f"{name}: missing {label}: {path}")

    # also require BEAVER query workloads to exist once per run
    dev_dw = os.path.join(beaver_root, "dev_dw.json")
    dev_nw = os.path.join(beaver_root, "dev_nw.json")
    if not os.path.isfile(dev_dw):
        missing.append(f"missing workload file: {dev_dw}")
    if not os.path.isfile(dev_nw):
        missing.append(f"missing workload file: {dev_nw}")

    if missing:
        raise RuntimeError(
            "Missing required BEAVER inputs (aborting; no fallbacks):\n"
            + "\n".join(f"  - {m}" for m in missing)
        )


def main(argv: Optional[List[str]] = None) -> int:
    import argparse

    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument(
        "--names",
        nargs="*",
        default=list(BEAVER_DBS),
        choices=list(BEAVER_DBS),
        help="Subset of databases to generate (default: all).",
    )
    p.add_argument(
        "--beaver-root",
        default=os.path.join(_repo_root(), "beaver"),
        help="Root folder containing beaver/README.md, dev_*.json, and databases/.",
    )
    p.add_argument(
        "--column-enrichment-root",
        default=legacy_column_enrichment_root(),
    )
    p.add_argument(
        "--classifications-dir",
        default=data_table_classifications_subdir("Beaver"),
        help="Must contain <db>.json for every DB (default: Code/data/table_classifications/Beaver).",
    )
    p.add_argument(
        "--output-root",
        default="output_beaver",
        help="Root folder for outputs.",
    )
    p.add_argument("--seed", type=int, default=42)
    p.add_argument("--difficulty", choices=["easy", "medium", "hard", "extra_hard"], default="hard")
    p.add_argument(
        "--prepare-only",
        action="store_true",
        help="Only stage SQLite + queries (skip generate_instance).",
    )
    args = p.parse_args(argv)

    beaver_root = os.path.abspath(args.beaver_root)
    column_enrichment_root = os.path.abspath(args.column_enrichment_root)
    classifications_dir = os.path.abspath(args.classifications_dir)
    output_root = os.path.abspath(args.output_root)

    try:
        _check_inputs_exist(
            names=args.names,
            beaver_root=beaver_root,
            column_enrichment_root=column_enrichment_root,
            classifications_dir=classifications_dir,
        )
    except Exception as e:
        print(str(e), file=sys.stderr)
        return 1

    os.makedirs(output_root, exist_ok=True)

    prepared: List[PreparedBeaverDb] = []
    skipped_already_done: List[str] = []
    prep_failures: List[Tuple[str, str]] = []

    for i, name in enumerate(args.names, start=1):
        out_dir = _default_output_dir(output_root, name)
        meta_path = os.path.join(out_dir, "metadata.json")
        if os.path.isfile(meta_path):
            skipped_already_done.append(name)
            print(
                f"[{i}/{len(args.names)}] SKIP db={name!r} "
                f"reason=existing_metadata path={meta_path}",
                file=sys.stderr,
                flush=True,
            )
            continue

        print(
            f"[{i}/{len(args.names)}] PREPARE db={name!r}",
            file=sys.stderr,
            flush=True,
        )
        try:
            info = prepare_beaver_db(
                name=name,
                beaver_root=beaver_root,
                column_enrichment_root=column_enrichment_root,
                classifications_dir=classifications_dir,
                output_root=output_root,
            )
        except Exception as e:
            print(f"  PREPARE FAILED for {name!r}: {e}", file=sys.stderr)
            prep_failures.append((name, str(e)))
            continue

        prepared.append(info)
        print(
            f"  staged: sqlite={info.sqlite_path} ({info.num_tables} tables); "
            f"{info.num_queries} queries",
            file=sys.stderr,
            flush=True,
        )

    if args.prepare_only:
        if prep_failures:
            print("\nPrepare failures:", file=sys.stderr)
            for name, err in prep_failures:
                print(f"  - {name}: {err}", file=sys.stderr)
            return 1
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
                use_llm=True,  # always use LLM renaming
                classifications_dir=classifications_dir,
            )
            if not ok:
                failures.append((info.name, "generate_instance returned False"))
        except Exception as e:
            failures.append((info.name, str(e)))
            continue

    if prep_failures or failures:
        print("\nFailures:", file=sys.stderr)
        for name, err in prep_failures:
            print(f"  - {name}: PREPARE FAILED: {err}", file=sys.stderr)
        for name, err in failures:
            print(f"  - {name}: {err}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

