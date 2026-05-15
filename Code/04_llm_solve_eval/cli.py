from __future__ import annotations

import argparse
import os
import sys
from typing import List, Optional

from evaluate_llm_schema import evaluate_solve_results
from llm_solver import run_solver


def main(argv: Optional[List[str]] = None) -> int:
    parser = argparse.ArgumentParser(
        description="LLM GAV solve and evaluation for SchemaVerse instances"
    )
    subparsers = parser.add_subparsers(dest="command", help="Command to run")

    solve_parser = subparsers.add_parser(
        "solve",
        help="LLM: generate GAV (Global-As-View) rules from local schemas",
    )
    solve_parser.add_argument("--instance_dir", required=True, help="Instance directory")
    solve_parser.add_argument(
        "--model",
        default="gpt-5.4-mini",
        help="LLM model identifier (default: gpt-5.4-mini).",
    )
    solve_parser.add_argument(
        "--temperature",
        type=float,
        default=None,
        help="Sampling temperature; omit for API defaults.",
    )
    solve_parser.add_argument(
        "--api_key",
        default=None,
        help="OpenAI API key (or set OPENAI_API_KEY / OPENAI_KEY).",
    )

    eval_solve_parser = subparsers.add_parser(
        "evaluate_solve",
        help="Evaluate GAV rules: compile rate, attribute provenance, tuple match",
    )
    eval_solve_parser.add_argument("--instance_dir", required=True, help="Instance directory")
    eval_solve_parser.add_argument(
        "--solve_dir",
        required=True,
        help="Path to solve results (e.g. .../solve_results/gpt-5.4-mini)",
    )
    eval_solve_parser.add_argument(
        "--tuple-match-mode",
        default="triplet_only",
        choices=["none", "triplet_only", "full", "triplet_hybrid"],
        help="Tuple/triplet evaluation mode.",
    )
    eval_solve_parser.add_argument(
        "--evaluation-report-json",
        default="evaluation_report.json",
        help="Report filename written under solve_dir.",
    )
    eval_solve_parser.add_argument(
        "--max-view-rows",
        type=int,
        default=0,
        help=(
            "triplet_only (and full tuple path): max rows fetched per compiled view "
            "(0 = no cap, full scan; uses more memory/time)."
        ),
    )
    eval_solve_parser.add_argument(
        "--max-orig-rows",
        type=int,
        default=0,
        help=(
            "triplet_only (and full tuple path): max rows from each original table "
            "(0 = no cap, full scan)."
        ),
    )
    eval_solve_parser.add_argument(
        "--merge-hybrid-from",
        default=None,
        metavar="FILENAME",
        help="With triplet_hybrid: merge compile/provenance from this JSON under solve_dir.",
    )

    args = parser.parse_args(argv)

    if args.command == "solve":
        if args.api_key:
            os.environ["OPENAI_API_KEY"] = args.api_key
        run_solver(
            instance_dir=args.instance_dir,
            model=args.model,
            temperature=args.temperature,
        )
        return 0

    if args.command == "evaluate_solve":
        evaluate_solve_results(
            instance_dir=args.instance_dir,
            solve_dir=args.solve_dir,
            tuple_match_mode=str(args.tuple_match_mode),
            max_view_rows=int(args.max_view_rows),
            max_orig_rows=int(args.max_orig_rows),
            evaluation_report_json=str(args.evaluation_report_json),
            merge_hybrid_from_report=(
                str(args.merge_hybrid_from) if args.merge_hybrid_from else None
            ),
        )
        return 0

    parser.print_help()
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
