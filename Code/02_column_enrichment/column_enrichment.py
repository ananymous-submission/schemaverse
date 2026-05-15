from __future__ import annotations

import argparse
import os
import sys
from pathlib import Path

import bird_layout, pipeline, spider2_layout


def _default_bird_root_code() -> str:
    return str(Path(__file__).resolve().parents[1] / "data" / "BIRD")


def _default_spider2_root_code() -> str:
    return spider2_layout.spider2_root_default()


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(
        description=(
            "Enrich SQLite columns (OpenAI primary, Gemini fallback): aliases + one-line descriptions."
        ),
    )
    p.add_argument(
        "--sqlite-dir",
        default=None,
        help="Directory containing multiple *.sqlite files to process (non-recursive).",
    )
    p.add_argument(
        "--metadata-root",
        default=None,
        help="Optional metadata root used by --metadata-format (e.g. Spider2 sqlite metadata root).",
    )
    p.add_argument(
        "--metadata-format",
        default=None,
        choices=[None, "spider2", "none"],
        help="Optional metadata format adapter (currently: spider2).",
    )
    p.add_argument(
        "--spider2-root",
        default=_default_spider2_root_code(),
        help="Spider2 tree root (default: <Code>/data/Spider2); one folder per database",
    )
    p.add_argument(
        "--bird-root",
        default=_default_bird_root_code(),
        help="BIRD tree root (default: <Code>/data/BIRD); databases under --bird-databases-subdir",
    )
    p.add_argument(
        "--bird-databases-subdir",
        default=bird_layout.DEFAULT_BIRD_DATABASES_SUBDIR,
        help=(
            "Subfolder under --bird-root with one directory per database "
            f"(default: {bird_layout.DEFAULT_BIRD_DATABASES_SUBDIR}; "
            "e.g. train_databases for the train split)"
        ),
    )
    p.add_argument(
        "--db",
        dest="db_name",
        action="append",
        help=(
            "Database name (repeatable): under --bird-root (BIRD mode) or --spider2-root "
            "(Spider2 mode). Ignored if --all."
        ),
    )
    p.add_argument(
        "--all",
        action="store_true",
        help=(
            "Process every database under the active corpus root "
            "(BIRD: <bird-root>/<bird-databases-subdir>; Spider2: <spider2-root>)"
        ),
    )
    p.add_argument(
        "--corpus",
        choices=["bird", "spider2"],
        default="bird",
        help="Which dataset layout --db / --all refer to (default: bird).",
    )
    p.add_argument(
        "--sqlite",
        help="Path to a single .sqlite file (output: <parent>/column_semantic_enrichment.json "
        "unless --out is set)",
    )
    p.add_argument(
        "--out",
        help="Output JSON path (only with --sqlite)",
    )
    p.add_argument(
        "--model",
        default="gemini-3-flash-preview",
        help="Primary Gemini model id when Gemini is used (default: gemini-3-flash-preview).",
    )
    p.add_argument(
        "--gemini-fallback-model",
        default="gemini-2.5-flash",
        help="Secondary Gemini model id if the primary Gemini call fails (default: gemini-2.5-flash).",
    )
    p.add_argument(
        "--samples",
        type=int,
        default=5,
        help="Max distinct sample values per column (default: 5)",
    )
    p.add_argument(
        "--chunk-size",
        type=int,
        default=40,
        help="Max columns per LLM request per table (default: 40)",
    )
    p.add_argument(
        "--force",
        action="store_true",
        help="Overwrite existing column_semantic_enrichment.json",
    )
    p.add_argument(
        "--dry-run",
        action="store_true",
        help="Load schema and samples only; do not call the LLM",
    )
    p.add_argument(
        "--sleep",
        type=float,
        default=0.0,
        help="Seconds to sleep between LLM requests (rate limiting)",
    )
    p.add_argument(
        "--openai-primary-model",
        default="gpt-5-mini",
        help="OpenAI model id tried first when OPENAI_API_KEY/OPENAI_KEY is set (default: gpt-5-mini).",
    )
    p.add_argument(
        "--openai-fallback-model",
        default="gpt-5-mini",
        help=(
            "OpenAI model id used after both Gemini models fail on a request "
            "(default: gpt-5-mini)."
        ),
    )
    p.add_argument(
        "--quiet",
        action="store_true",
        help="Do not print database/table progress lines on stderr",
    )

    args = p.parse_args(argv)
    show_progress = not args.quiet

    if not args.dry_run:
        if not (
            os.environ.get("OPENAI_API_KEY")
            or os.environ.get("OPENAI_KEY")
            or os.environ.get("GEMINI_API_KEY")
            or os.environ.get("GOOGLE_API_KEY")
        ):
            print(
                "Error: set OPENAI_API_KEY or OPENAI_KEY and/or GEMINI_API_KEY or GOOGLE_API_KEY "
                "(required unless --dry-run).",
                file=sys.stderr,
            )
            return 1

    if args.sqlite_dir:
        try:
            rows = pipeline.run_sqlite_dir(
                args.sqlite_dir,
                metadata_root=args.metadata_root,
                metadata_format=None if args.metadata_format in (None, "none") else args.metadata_format,
                model=args.model,
                gemini_fallback_model=args.gemini_fallback_model,
                samples_per_column=args.samples,
                column_chunk_size=args.chunk_size,
                force=args.force,
                dry_run=args.dry_run,
                sleep_s=args.sleep,
                openai_primary_model=args.openai_primary_model,
                openai_fallback_model=args.openai_fallback_model,
                progress=show_progress,
            )
        except (EnvironmentError, ImportError) as e:
            print(e, file=sys.stderr)
            return 1
        if not rows:
            print("No databases found.", file=sys.stderr)
            return 1
        code = 0
        for name, ok, msg in rows:
            print(f"[{name}] {msg}")
            if not ok:
                code = 1
        return code

    if args.sqlite:
        sqlite_path = os.path.abspath(args.sqlite)
        if args.out:
            out_path = os.path.abspath(args.out)
        else:
            out_path = os.path.join(os.path.dirname(sqlite_path), "column_semantic_enrichment.json")
        try:
            ok, msg = pipeline.enrich_database(
                sqlite_path=sqlite_path,
                out_path=out_path,
                db_name=os.path.splitext(os.path.basename(sqlite_path))[0],
                model=args.model,
                gemini_fallback_model=args.gemini_fallback_model,
                samples_per_column=args.samples,
                column_chunk_size=args.chunk_size,
                force=args.force,
                dry_run=args.dry_run,
                sleep_s=args.sleep,
                openai_primary_model=args.openai_primary_model,
                openai_fallback_model=args.openai_fallback_model,
                progress=show_progress,
            )
        except (FileNotFoundError, EnvironmentError, ImportError) as e:
            print(e, file=sys.stderr)
            return 1
        print(msg)
        return 0 if ok else 1

    if not args.all and not args.db_name:
        p.error("Provide --sqlite-dir, --all, --db <name>, or --sqlite <path>")

    names = None if args.all else args.db_name
    try:
        if args.corpus == "spider2":
            rows = pipeline.run_spider2_root(
                args.spider2_root,
                names,
                all_dbs=bool(args.all),
                model=args.model,
                gemini_fallback_model=args.gemini_fallback_model,
                samples_per_column=args.samples,
                column_chunk_size=args.chunk_size,
                force=args.force,
                dry_run=args.dry_run,
                sleep_s=args.sleep,
                openai_primary_model=args.openai_primary_model,
                openai_fallback_model=args.openai_fallback_model,
                progress=show_progress,
            )
        else:
            rows = pipeline.run_bird_root(
                args.bird_root,
                names,
                all_dbs=bool(args.all),
                databases_subdir=args.bird_databases_subdir,
                model=args.model,
                gemini_fallback_model=args.gemini_fallback_model,
                samples_per_column=args.samples,
                column_chunk_size=args.chunk_size,
                force=args.force,
                dry_run=args.dry_run,
                sleep_s=args.sleep,
                openai_primary_model=args.openai_primary_model,
                openai_fallback_model=args.openai_fallback_model,
                progress=show_progress,
            )
    except (EnvironmentError, ImportError) as e:
        print(e, file=sys.stderr)
        return 1

    if not rows:
        print("No databases found.", file=sys.stderr)
        return 1

    code = 0
    for name, ok, msg in rows:
        print(f"[{name}] {msg}")
        if not ok:
            code = 1
    return code


if __name__ == "__main__":
    raise SystemExit(main())
