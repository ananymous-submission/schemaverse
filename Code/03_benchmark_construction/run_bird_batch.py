from __future__ import annotations

import os
import sys
from dataclasses import dataclass
from typing import List, Optional, Sequence, Tuple

from main import bird_instance_paths, generate_instance
from paths import data_bird_root, data_table_classifications_bird


@dataclass(frozen=True)
class BirdDb:
    split: str  # dev_databases | train_databases
    name: str
    db_path: str
    queries_path: str
    enrich_path: str


def _iter_bird_dbs(*, bird_root: str, splits: Sequence[str]) -> List[BirdDb]:
    out: List[BirdDb] = []
    for split in splits:
        split_dir = os.path.join(bird_root, split)
        if not os.path.isdir(split_dir):
            continue
        for name in sorted(os.listdir(split_dir)):
            base = os.path.join(split_dir, name)
            if not os.path.isdir(base):
                continue
            db_path, queries_path = bird_instance_paths(name, bird_root, split)
            enrich_path = os.path.join(base, "column_semantic_enrichment.json")
            out.append(
                BirdDb(
                    split=split,
                    name=name,
                    db_path=db_path,
                    queries_path=queries_path,
                    enrich_path=enrich_path,
                )
            )
    # stable ordering: split then schema name
    out.sort(key=lambda x: (x.split, x.name))
    return out


def _check_required_artifacts(
    *,
    bird_dbs: Sequence[BirdDb],
    classifications_dir: str,
) -> None:
    missing: List[str] = []
    for db in bird_dbs:
        if not os.path.isfile(db.db_path):
            missing.append(f"[{db.split}] {db.name}: missing sqlite: {db.db_path}")
        if not os.path.isfile(db.queries_path):
            missing.append(f"[{db.split}] {db.name}: missing queries: {db.queries_path}")
        cls_path = os.path.join(classifications_dir, f"{db.name}.json")
        if not os.path.isfile(cls_path):
            missing.append(f"[{db.split}] {db.name}: missing classification: {cls_path}")
        if not os.path.isfile(db.enrich_path):
            missing.append(f"[{db.split}] {db.name}: missing enrichment: {db.enrich_path}")
    if missing:
        raise RuntimeError(
            "Missing required artifacts (aborting; no fallbacks allowed):\n"
            + "\n".join(f"  - {m}" for m in missing)
        )


def _default_output_dir(output_root: str, split: str, db_name: str) -> str:
    return os.path.join(output_root, split, f"{db_name}_benchmark")


def main(argv: Optional[List[str]] = None) -> int:
    import argparse

    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument(
        "--bird-root",
        default=data_bird_root(),
        help="BIRD tree root (default: <Code>/data/BIRD)",
    )
    p.add_argument(
        "--split",
        action="append",
        help="Repeatable: dev_databases or train_databases. If omitted, use --all.",
    )
    p.add_argument("--all", action="store_true", help="Run both dev_databases and train_databases.")
    p.add_argument("--output-root", default="output_bird", help="Root folder for outputs.")
    p.add_argument("--seed", type=int, default=42)
    p.add_argument("--difficulty", choices=["easy", "medium", "hard", "extra_hard"], default="hard")
    p.add_argument(
        "--use-llm",
        action="store_true",
        default=True,
        help="Use LLM naming drift (always enabled in batch runners; requires OPENAI_API_KEY / OPENAI_KEY).",
    )
    p.add_argument(
        "--classifications-dir",
        default=data_table_classifications_bird(),
        help="Must contain <db>.json for every DB (default: data/table_classifications/BIRD).",
    )
    p.add_argument(
        "--run-validation",
        action="store_true",
        default=False,
        help="Run data/query equivalence inline after generation (disabled by default).",
    )
    args = p.parse_args(argv)

    bird_root = os.path.abspath(args.bird_root)
    if args.all:
        splits = ["dev_databases", "train_databases"]
    elif args.split:
        splits = list(args.split)
    else:
        p.error("Specify --all or at least one --split")

    dbs = _iter_bird_dbs(bird_root=bird_root, splits=splits)
    if not dbs:
        print(f"No BIRD databases found under {bird_root} for splits={splits}", file=sys.stderr)
        return 1

    # Enforce required inputs before any generation.
    try:
        _check_required_artifacts(
            bird_dbs=dbs, classifications_dir=os.path.abspath(args.classifications_dir)
        )
    except Exception as e:
        print(str(e), file=sys.stderr)
        return 1

    os.makedirs(args.output_root, exist_ok=True)

    failures: List[Tuple[str, str]] = []
    for i, db in enumerate(dbs, start=1):
        out_dir = _default_output_dir(args.output_root, db.split, db.name)
        meta_path = os.path.join(out_dir, "metadata.json")
        if os.path.isfile(meta_path):
            print(
                f"[{i}/{len(dbs)}] SKIP db={db.name!r} split={db.split!r} "
                f"reason=existing_metadata path={meta_path}",
                file=sys.stderr,
                flush=True,
            )
            continue
        print(
            f"[{i}/{len(dbs)}] WORK db={db.name!r} split={db.split!r} -> {out_dir}",
            file=sys.stderr,
            flush=True,
        )
        try:
            ok = generate_instance(
                db_path=db.db_path,
                queries_path=db.queries_path,
                output_dir=out_dir,
                difficulty=args.difficulty,
                seed=args.seed,
                use_llm=True,
                classifications_dir=os.path.abspath(args.classifications_dir),
                run_validation=args.run_validation,
            )
            if not ok:
                failures.append((f"{db.split}/{db.name}", "generate_instance returned False"))
        except Exception as e:
            failures.append((f"{db.split}/{db.name}", str(e)))
            break  # stop immediately (requested: stop when required artifacts missing or run fails)

    if failures:
        print("\nFailures:", file=sys.stderr)
        for name, err in failures:
            print(f"  - {name}: {err}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

