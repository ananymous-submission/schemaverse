from __future__ import annotations

import argparse
import os
import sys
from typing import List, Optional, Sequence


DATASETS = ("bird", "spider2", "beaver", "sciencebenchmark")
DIFFICULTIES = ("easy", "medium", "hard", "extra_hard")


def _abs(p: str) -> str:
    return os.path.abspath(p)


def _run(module, argv: List[str]) -> int:
    return int(module.main(argv))


def main(argv: Optional[Sequence[str]] = None) -> int:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--root", default="SchemaVerse", help="Output root directory.")
    p.add_argument(
        "--difficulties",
        nargs="*",
        default=list(DIFFICULTIES),
        choices=list(DIFFICULTIES),
        help="Which difficulty levels to generate.",
    )
    p.add_argument(
        "--datasets",
        nargs="*",
        default=list(DATASETS),
        choices=list(DATASETS),
        help="Which datasets to generate.",
    )
    p.add_argument("--seed", type=int, default=42)
    p.add_argument(
        "--run-validation",
        action="store_true",
        default=False,
        help="Run data/query equivalence inline during generation.",
    )
    args = p.parse_args(list(argv) if argv is not None else None)

    root = _abs(args.root)
    os.makedirs(root, exist_ok=True)

    failures: List[str] = []

    for diff in args.difficulties:
        for ds in args.datasets:
            out_root = _abs(os.path.join(root, diff, ds))
            os.makedirs(out_root, exist_ok=True)
            print(
                f"\n=== SchemaVerse generate difficulty={diff!r} dataset={ds!r} out={out_root} ===",
                file=sys.stderr,
                flush=True,
            )

            try:
                if ds == "bird":
                    import run_bird_batch as mod
                    code = _run(
                        mod,
                        [
                            "--all",
                            "--output-root",
                            out_root,
                            "--seed",
                            str(args.seed),
                            "--difficulty",
                            diff,
                            "--use-llm",
                            *(['--run-validation'] if args.run_validation else []),
                        ],
                    )
                elif ds == "spider2":
                    import run_spider2_batch as mod
                    code = _run(
                        mod,
                        [
                            "--output-root",
                            out_root,
                            "--seed",
                            str(args.seed),
                            "--difficulty",
                            diff,
                            "--use-llm",
                        ],
                    )
                elif ds == "beaver":
                    import run_beaver_batch as mod
                    code = _run(
                        mod,
                        [
                            "--output-root",
                            out_root,
                            "--seed",
                            str(args.seed),
                            "--difficulty",
                            diff,
                        ],
                    )
                elif ds == "sciencebenchmark":
                    import run_sciencebenchmark_batch as mod
                    code = _run(
                        mod,
                        [
                            "--output-root",
                            out_root,
                            "--seed",
                            str(args.seed),
                            "--difficulty",
                            diff,
                        ],
                    )
                else:
                    raise RuntimeError(f"Unknown dataset: {ds}")

                if code != 0:
                    failures.append(f"{diff}/{ds}: exit_code={code}")
            except Exception as e:
                failures.append(f"{diff}/{ds}: {e}")

    if failures:
        print("\nFailures:", file=sys.stderr)
        for f in failures:
            print(f"  - {f}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

