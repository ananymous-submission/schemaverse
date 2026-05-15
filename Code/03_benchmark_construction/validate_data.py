import sqlite3
import json
import os
from typing import Dict, List, Tuple
from collections import OrderedDict
import sys


def _qi(name: str) -> str:
    """Quote an SQLite identifier using double quotes (robust with `[`/`]` in names)."""
    safe = (name or "").replace('"', '""')
    return f"\"{safe}\""


def _cast_text_list(cols: List[str]) -> str:
    """Build SELECT expression list that compares values as TEXT.

    This normalizes type-affinity differences (e.g., 2024 vs "2024") that can
    arise when reconstructed tables were materialized with slightly different
    column types but identical string representations.
    """
    return ", ".join(f"CAST({_qi(c)} AS TEXT)" for c in cols)


def validate_data_equivalence(
    original_db_path: str,
    reconstructed_db_path: str,
    table_names: List[str],
    output_dir: str,
) -> Tuple[bool, Dict]:
    """
    Validate that reconstructed data exactly matches original data.

    For each table:
    - Check schema compatibility (columns)
    - Check row counts
    - Check set equality using EXCEPT
    - Report any mismatches

    Returns (all_passed, report_dict).
    """
    val_dir = os.path.join(output_dir, "validation")
    os.makedirs(val_dir, exist_ok=True)

    orig_conn = sqlite3.connect(original_db_path)
    recon_conn = sqlite3.connect(reconstructed_db_path)
    # Also open a verifier connection that can ATTACH both DBs, so we can
    # compute EXCEPT-based set differences inside SQLite without materializing
    # entire tables into Python sets (which OOMs on large tables).
    verify_conn = sqlite3.connect(":memory:")
    verify_conn.execute("ATTACH DATABASE ? AS orig", (os.path.abspath(original_db_path),))
    verify_conn.execute("ATTACH DATABASE ? AS recon", (os.path.abspath(reconstructed_db_path),))

    report = {
        "summary": {"total_tables": 0, "passed": 0, "failed": 0},
        "tables": {},
    }

    all_passed = True

    tables_sorted = sorted(table_names)
    total = len(tables_sorted)

    for idx, tname in enumerate(tables_sorted, start=1):
        # Progress indicator (prints live to stderr so long checks show activity)
        print(
            f"[data_equivalence] table {idx}/{total}: {tname}",
            file=sys.stderr,
            flush=True,
        )
        table_report = {
            "status": "PASS",
            "checks": {},
        }
        report["summary"]["total_tables"] += 1

        try:
            # 1. Check columns
            print("  - check: schema", file=sys.stderr, flush=True)
            orig_cols = _get_columns(orig_conn, tname)
            recon_cols = _get_columns(recon_conn, tname)

            orig_col_names = set(c[1] for c in orig_cols)
            recon_col_names = set(c[1] for c in recon_cols)

            missing_cols = orig_col_names - recon_col_names
            extra_cols = recon_col_names - orig_col_names

            table_report["checks"]["schema"] = {
                "original_columns": sorted(orig_col_names),
                "reconstructed_columns": sorted(recon_col_names),
                "missing_columns": sorted(missing_cols),
                "extra_columns": sorted(extra_cols),
                "pass": len(missing_cols) == 0,
            }

            if missing_cols:
                table_report["status"] = "FAIL"
                table_report["checks"]["schema"]["error"] = (
                    f"Missing columns: {missing_cols}"
                )

            # 2. Check row counts
            print("  - check: row_count", file=sys.stderr, flush=True)
            orig_count = _row_count(orig_conn, tname)
            recon_count = _row_count(recon_conn, tname)

            table_report["checks"]["row_count"] = {
                "original": orig_count,
                "reconstructed": recon_count,
                "pass": orig_count == recon_count,
            }

            if orig_count != recon_count:
                table_report["status"] = "FAIL"
                table_report["checks"]["row_count"]["error"] = (
                    f"Row count mismatch: {orig_count} vs {recon_count}"
                )

            # 3. Check set equality using EXCEPT
            # Use common columns only
            common_cols = sorted(orig_col_names & recon_col_names)
            if common_cols:
                print("  - check: set_equality (EXCEPT)", file=sys.stderr, flush=True)
                # Compare on TEXT-cast values to avoid false negatives from
                # SQLite type-affinity differences between original and reconstructed.
                col_list = _cast_text_list(common_cols)

                # Compute set differences inside SQLite using ATTACH.
                print("    · orig \\ recon", file=sys.stderr, flush=True)
                orig_minus_recon = _except_count_sql(verify_conn, tname, col_list, left="orig", right="recon")
                print("    · recon \\ orig", file=sys.stderr, flush=True)
                recon_minus_orig = _except_count_sql(verify_conn, tname, col_list, left="recon", right="orig")

                table_report["checks"]["set_equality"] = {
                    "rows_in_original_not_in_reconstructed": orig_minus_recon,
                    "rows_in_reconstructed_not_in_original": recon_minus_orig,
                    "pass": orig_minus_recon == 0 and recon_minus_orig == 0,
                }

                if orig_minus_recon > 0 or recon_minus_orig > 0:
                    table_report["status"] = "FAIL"
                    # Get sample mismatches
                    print("    · collecting mismatch samples", file=sys.stderr, flush=True)
                    samples = _get_mismatch_samples(
                        verify_conn, tname, col_list
                    )
                    table_report["checks"]["set_equality"]["sample_mismatches"] = samples
            print(
                f"  - result: {table_report['status']}",
                file=sys.stderr,
                flush=True,
            )

        except Exception as e:
            table_report["status"] = "ERROR"
            table_report["error"] = str(e)
            print(f"  - result: ERROR ({e})", file=sys.stderr, flush=True)

        if table_report["status"] != "PASS":
            all_passed = False
            report["summary"]["failed"] += 1
        else:
            report["summary"]["passed"] += 1

        report["tables"][tname] = table_report

    report["summary"]["all_passed"] = all_passed

    orig_conn.close()
    recon_conn.close()
    verify_conn.close()

    # Save report
    report_path = os.path.join(val_dir, "data_equivalence_report.json")
    with open(report_path, "w") as f:
        json.dump(report, f, indent=2)

    return all_passed, report


def _get_columns(conn, table_name):
    """Get column info for a table."""
    cursor = conn.cursor()
    cursor.execute(f"PRAGMA table_info({_qi(table_name)})")
    return cursor.fetchall()


def _row_count(conn, table_name):
    """Get row count for a table."""
    cursor = conn.cursor()
    cursor.execute(f"SELECT COUNT(*) FROM {_qi(table_name)}")
    return cursor.fetchone()[0]


def _except_count_sql(conn: sqlite3.Connection, table_name: str, col_list: str, *, left: str, right: str) -> int:
    """
    Count rows in left.table_name that are NOT in right.table_name using SQL EXCEPT.
    Requires both DBs to be attached to conn under schema names 'orig' and 'recon'
    (or other names passed in left/right).
    """
    cur = conn.cursor()
    q = (
        f"SELECT COUNT(*) FROM ("
        f"SELECT {col_list} FROM {left}.{_qi(table_name)} "
        f"EXCEPT "
        f"SELECT {col_list} FROM {right}.{_qi(table_name)}"
        f")"
    )
    cur.execute(q)
    return int(cur.fetchone()[0] or 0)


def _get_mismatch_samples(conn: sqlite3.Connection, table_name: str, col_list: str, limit: int = 5):
    """Get sample mismatched rows using SQL EXCEPT with LIMIT (no Python set build)."""
    cur = conn.cursor()
    q_missing = (
        f"SELECT {col_list} FROM orig.{_qi(table_name)} "
        f"EXCEPT "
        f"SELECT {col_list} FROM recon.{_qi(table_name)} "
        f"LIMIT {int(limit)}"
    )
    q_extra = (
        f"SELECT {col_list} FROM recon.{_qi(table_name)} "
        f"EXCEPT "
        f"SELECT {col_list} FROM orig.{_qi(table_name)} "
        f"LIMIT {int(limit)}"
    )
    cur.execute(q_missing)
    missing = [list(r) for r in cur.fetchall()]
    cur.execute(q_extra)
    extra = [list(r) for r in cur.fetchall()]
    return {"missing_from_reconstructed": missing, "extra_in_reconstructed": extra}
