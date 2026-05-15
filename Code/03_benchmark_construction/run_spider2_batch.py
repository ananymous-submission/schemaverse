from __future__ import annotations

import os
import sys
from dataclasses import dataclass
from typing import List, Optional, Sequence, Tuple

from main import generate_instance
from paths import data_spider2_root, data_table_classifications_subdir


@dataclass(frozen=True)
class Spider2Db:
    name: str
    db_path: str
    enrich_path: str


def _repo_root() -> str:
    return os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))


def _iter_spider2_localdbs(*, spider2_localdb_root: str) -> List[Spider2Db]:
    out: List[Spider2Db] = []
    root = os.path.abspath(spider2_localdb_root)
    if not os.path.isdir(root):
        return out
    for name in sorted(os.listdir(root)):
        base = os.path.join(root, name)
        if not os.path.isdir(base):
            continue
        # Spider2 localdb convention: {name}/{name}.sqlite + column_semantic_enrichment.json
        db_path = os.path.join(base, f"{name}.sqlite")
        enrich_path = os.path.join(base, "column_semantic_enrichment.json")
        if os.path.isfile(db_path) and os.path.isfile(enrich_path):
            out.append(Spider2Db(name=name, db_path=db_path, enrich_path=enrich_path))
    return out


def _check_required_artifacts(
    *,
    dbs: Sequence[Spider2Db],
    classifications_dir: str,
) -> None:
    missing: List[str] = []
    for db in dbs:
        if not os.path.isfile(db.db_path):
            missing.append(f"{db.name}: missing sqlite: {db.db_path}")
        if not os.path.isfile(db.enrich_path):
            missing.append(f"{db.name}: missing enrichment: {db.enrich_path}")
        cls_path = os.path.join(classifications_dir, f"{db.name}.json")
        if not os.path.isfile(cls_path):
            missing.append(f"{db.name}: missing classification: {cls_path}")
    if missing:
        raise RuntimeError(
            "Missing required artifacts (aborting; no fallbacks allowed):\n"
            + "\n".join(f"  - {m}" for m in missing)
        )


def _default_output_dir(output_root: str, db_name: str) -> str:
    return os.path.join(output_root, f"{db_name}_benchmark")


def main(argv: Optional[List[str]] = None) -> int:
    import argparse

    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument(
        "--spider2-localdb-root",
        default=data_spider2_root(),
        help=(
            "Root folder with one subdirectory per DB "
            "(default: <Code>/data/Spider2; each <name>/<name>.sqlite + enrichment JSON)."
        ),
    )
    p.add_argument("--output-root", default="output_spider2", help="Root folder for outputs.")
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
        default=data_table_classifications_subdir("Spider2"),
        help="Must contain <db>.json for every DB (default: Code/data/table_classifications/Spider2).",
    )
    args = p.parse_args(argv)

    dbs = _iter_spider2_localdbs(spider2_localdb_root=args.spider2_localdb_root)
    if not dbs:
        print(f"No Spider2 localdb databases found under {args.spider2_localdb_root}", file=sys.stderr)
        return 1

    classifications_dir = os.path.abspath(args.classifications_dir)
    try:
        _check_required_artifacts(dbs=dbs, classifications_dir=classifications_dir)
    except Exception as e:
        print(str(e), file=sys.stderr)
        return 1

    os.makedirs(args.output_root, exist_ok=True)
    failures: List[Tuple[str, str]] = []
    for i, db in enumerate(dbs, start=1):
        out_dir = _default_output_dir(args.output_root, db.name)
        meta_path = os.path.join(out_dir, "metadata.json")
        if os.path.isfile(meta_path):
            print(
                f"[{i}/{len(dbs)}] SKIP db={db.name!r} reason=existing_metadata path={meta_path}",
                file=sys.stderr,
                flush=True,
            )
            continue
        print(
            f"[{i}/{len(dbs)}] WORK db={db.name!r} -> {out_dir}",
            file=sys.stderr,
            flush=True,
        )
        try:
            ok = generate_instance(
                db_path=os.path.abspath(db.db_path),
                queries_path=None,
                output_dir=os.path.abspath(out_dir),
                difficulty=args.difficulty,
                seed=args.seed,
                use_llm=True,
                classifications_dir=classifications_dir,
            )
            if not ok:
                failures.append((db.name, "generate_instance returned False"))
        except Exception as e:
            failures.append((db.name, str(e)))
            break

    if failures:
        print("\nFailures:", file=sys.stderr)
        for name, err in failures:
            print(f"  - {name}: {err}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

