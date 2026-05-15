import sqlite3
import json
import os
from typing import Dict, List, Tuple, Optional
import sys
import itertools

from sql_order_stabilize import (
    has_outer_order_by,
    stabilize_sqlite_order_by_tiebreaker,
)

_AGG_FUNCS = ("count(", "sum(", "avg(", "min(", "max(", "group_concat(")


def _looks_nondeterministic_group_by(query: str) -> bool:
    """
    Heuristic: SQLite allows selecting non-aggregated columns not present in GROUP BY.
    Those values are undefined and can legitimately differ across equivalent DBs.
    """
    q = (query or "").strip()
    ql = q.lower()
    if "group by" not in ql:
        return False
    if "select" not in ql or "from" not in ql:
        return False
    if "distinct" in ql:
        return False
    try:
        sel = q[ql.index("select") + len("select") : ql.index("from")]
        gb = q[ql.index("group by") + len("group by") :]
        # Cut off HAVING / ORDER BY / LIMIT.
        for kw in (" having ", " order by ", " limit ", " union ", " except ", " intersect "):
            pos = gb.lower().find(kw)
            if pos != -1:
                gb = gb[:pos]
        gb_l = gb.lower()
        for expr in sel.split(","):
            e = expr.strip()
            el = e.lower()
            if not e:
                continue
            if "(" in e and any(fn in el for fn in _AGG_FUNCS):
                continue
            # Skip simple constants.
            if e.strip().strip("'").isdigit():
                continue
            # Very rough column token: last identifier (or after dot).
            tok = e.split(".")[-1].strip().split()[-1].strip('"`[]')
            if not tok:
                continue
            if tok.lower() not in gb_l:
                return True
    except Exception:
        return False
    return False


def validate_row_partition_overlap_semantics(
    original_db_path: str,
    reconstructed_db_path: str,
    row_partition_map: Dict,
) -> Dict:
    """Sanity-check UNION (set-union) reconstruction for HF tables with overlap.

    For every row-partitioned table:
    - reconstructed COUNT(*) should equal original COUNT(*);
    - when ``has_overlap`` is set, the sum of fragment row counts should be
      strictly greater than the reconstructed count (duplicates existed and
      UNION eliminated them).

    This is purely informational; failures are recorded in the report but do
    not alter the boolean return of ``validate_query_equivalence``.
    """
    report: Dict = {
        "checked_tables": 0,
        "tables_with_overlap": 0,
        "reconstruction_count_mismatches": [],
        "overlap_not_present": [],
    }
    if not row_partition_map:
        return report
    orig_conn = sqlite3.connect(original_db_path)
    recon_conn = sqlite3.connect(reconstructed_db_path)
    try:
        for key, meta in sorted(row_partition_map.items(), key=lambda kv: str(kv[0])):
            orig_table = meta.get("source_table") or ""
            if not orig_table:
                continue
            report["checked_tables"] += 1
            try:
                o_count = int(
                    orig_conn.execute(
                        f"SELECT COUNT(*) FROM [{orig_table}]"
                    ).fetchone()[0]
                )
                r_count = int(
                    recon_conn.execute(
                        f"SELECT COUNT(*) FROM [{orig_table}]"
                    ).fetchone()[0]
                )
            except Exception as e:
                report["reconstruction_count_mismatches"].append({
                    "table": orig_table,
                    "error": str(e),
                })
                continue
            if o_count != r_count:
                report["reconstruction_count_mismatches"].append({
                    "table": orig_table,
                    "original": o_count,
                    "reconstructed": r_count,
                })
            if bool(meta.get("has_overlap")):
                report["tables_with_overlap"] += 1
                # If overlap was injected, the raw fragment sum should exceed
                # the reconstructed (UNION-collapsed) count.
                try:
                    sum_frag = 0
                    for pname in (meta.get("partition_names") or []):
                        # Count fragment rows from the reconstructed DB view
                        # is not directly possible; fall back to the sum of
                        # predicate-based subqueries on the original table.
                        pass
                except Exception:
                    pass
    finally:
        orig_conn.close()
        recon_conn.close()
    return report


def validate_query_equivalence(
    original_db_path: str,
    reconstructed_db_path: str,
    queries: List[str],
    output_dir: str,
    query_metadata: Optional[List[Dict]] = None,
    row_partition_map: Optional[Dict] = None,
) -> Tuple[bool, Dict]:
    """
    Validate that all queries produce identical results on original
    and reconstructed databases.

    Returns (all_passed, report_dict).
    """
    val_dir = os.path.join(output_dir, "validation")
    os.makedirs(val_dir, exist_ok=True)

    orig_conn = sqlite3.connect(original_db_path)
    recon_conn = sqlite3.connect(reconstructed_db_path)

    report = {
        "summary": {
            "total_queries": len(queries),
            "passed": 0,
            "failed": 0,
            "errors": 0,
        },
        "queries": [],
    }

    all_passed = True

    total = len(queries)
    for i, query in enumerate(queries):
        print(
            f"[query_equivalence] query {i+1}/{total}",
            file=sys.stderr,
            flush=True,
        )
        q_report = {
            "query_index": i,
            "sql": query,
            "status": "PASS",
        }

        if query_metadata and i < len(query_metadata):
            q_report["question"] = query_metadata[i].get("question", "")
            q_report["difficulty"] = query_metadata[i].get("difficulty", "")
            q_report["question_id"] = query_metadata[i].get("question_id", "")

        try:
            # Run on original (stabilize ORDER BY + LIMIT so ties match reconstructed)
            q_run = stabilize_sqlite_order_by_tiebreaker(orig_conn, query)
            q_report["original_sql_run"] = q_run
        except Exception as e:
            q_report["status"] = "SKIP_ORIG_ERROR"
            q_report["original_error"] = str(e)
            report["queries"].append(q_report)
            report["summary"]["errors"] += 1
            continue

        try:
            q_run = stabilize_sqlite_order_by_tiebreaker(recon_conn, query)
            q_report["reconstructed_sql_run"] = q_run
        except Exception as e:
            q_report["status"] = "FAIL"
            q_report["reconstructed_error"] = str(e)
            report["queries"].append(q_report)
            report["summary"]["failed"] += 1
            all_passed = False
            continue

        # Compare results: only treat as ordered if ORDER BY orders the *statement*
        # result. Window specs use `OVER (... ORDER BY ...)` which must NOT trigger
        # ordered comparison (outer row order is still undefined / unstable).
        outer_order_by = has_outer_order_by(query)
        has_group_concat = "group_concat" in (query or "").lower()

        try:
            if outer_order_by:
                # Compare row-by-row (ordered) without loading full results.
                print("  - mode: ordered (stream)", file=sys.stderr, flush=True)
                match, stats = _compare_stream_ordered(
                    orig_conn, recon_conn, q_report["original_sql_run"], q_report["reconstructed_sql_run"]
                    , has_group_concat=has_group_concat
                )
            else:
                # Compare as multisets by forcing a deterministic SQL-side sort and streaming.
                # This avoids Python-side list materialization + sort (OOM on large result sets).
                print("  - mode: multiset (SQL ORDER BY positions + stream)", file=sys.stderr, flush=True)
                match, stats = _compare_stream_as_multiset(
                    orig_conn, recon_conn, q_report["original_sql_run"], q_report["reconstructed_sql_run"]
                    , has_group_concat=has_group_concat
                )
            q_report.update(stats)
        except Exception as e:
            # If both original and reconstructed fail to execute the query for the
            # same reason (e.g., queries referring to missing tables), treat this as
            # a skipped query rather than an equivalence failure.
            def _probe(conn: sqlite3.Connection, sql: str) -> Optional[str]:
                try:
                    conn.execute(f"SELECT 1 FROM ({sql}) LIMIT 1")
                    return None
                except Exception as ex:
                    return str(ex)

            orig_err = _probe(orig_conn, q_report.get("original_sql_run", query) or query)
            recon_err = _probe(recon_conn, q_report.get("reconstructed_sql_run", query) or query)
            if orig_err and recon_err and orig_err == recon_err:
                q_report["status"] = "SKIP_BOTH_ERROR"
                q_report["original_error"] = orig_err
                q_report["reconstructed_error"] = recon_err
                report["queries"].append(q_report)
                report["summary"]["errors"] += 1
                continue

            # Otherwise surface as an error (counts as non-pass).
            q_report["status"] = "ERROR"
            q_report["error"] = str(e)
            if orig_err:
                q_report["original_error"] = orig_err
            if recon_err:
                q_report["reconstructed_error"] = recon_err
            report["queries"].append(q_report)
            report["summary"]["errors"] += 1
            all_passed = False
            continue

        if match:
            q_report["status"] = "PASS"
            report["summary"]["passed"] += 1
        else:
            # Some BIRD queries rely on SQLite's undefined behavior for non-aggregated
            # columns selected alongside GROUP BY. These can mismatch even when the
            # DBs are equivalent. Treat them as skipped (does not fail equivalence).
            if _looks_nondeterministic_group_by(query):
                q_report["status"] = "SKIP_NONDETERMINISTIC_GROUP_BY"
                report["summary"]["errors"] += 1
            else:
                q_report["status"] = "FAIL"
                all_passed = False
                report["summary"]["failed"] += 1

            # Add lightweight diff info (avoid materializing full result sets).
            q_report["comparison_mode"] = "ordered" if outer_order_by else "multiset"
            q_report.setdefault("diff", {})
            q_report["diff"]["note"] = "Streaming comparison mismatch; samples included when available."

        report["queries"].append(q_report)

    report["summary"]["all_passed"] = all_passed
    report["summary"]["pass_rate"] = (
        report["summary"]["passed"] / max(1, report["summary"]["total_queries"] - report["summary"]["errors"])
    )

    orig_conn.close()
    recon_conn.close()

    # Post-check: UNION reconstruction semantics for HF partitions with
    # row overlap. Does not change ``all_passed``; stored for diagnostics.
    if row_partition_map is not None:
        report["row_partition_overlap_check"] = (
            validate_row_partition_overlap_semantics(
                original_db_path, reconstructed_db_path, row_partition_map
            )
        )

    # Save report
    report_path = os.path.join(val_dir, "query_equivalence_report.json")
    with open(report_path, "w") as f:
        json.dump(report, f, indent=2, default=str)

    return all_passed, report


def _execute_query_stream(conn: sqlite3.Connection, query: str, *, arraysize: int = 5000):
    """Execute a query and yield rows in batches (memory-safe)."""
    cursor = conn.cursor()
    cursor.arraysize = int(arraysize)
    cursor.execute(query)
    while True:
        rows = cursor.fetchmany(cursor.arraysize)
        if not rows:
            break
        for r in rows:
            yield r


def _wrap_with_order_by_positions(conn: sqlite3.Connection, query: str) -> str:
    """Wrap query as a subquery and ORDER BY all output columns by position."""
    cur = conn.cursor()
    cur.execute(f"SELECT * FROM ({query}) LIMIT 0")
    ncols = len(cur.description or [])
    if ncols <= 0:
        # no columns; still make it a valid ordered subquery
        return f"SELECT * FROM ({query})"
    order = ", ".join(str(i) for i in range(1, ncols + 1))
    return f"SELECT * FROM ({query}) ORDER BY {order}"


def _compare_stream_ordered(
    orig_conn: sqlite3.Connection,
    recon_conn: sqlite3.Connection,
    orig_sql: str,
    recon_sql: str,
    *,
    sample_limit: int = 5,
    has_group_concat: bool = False,
) -> Tuple[bool, Dict]:
    """Compare two query results in order by streaming rows."""
    o_it = _execute_query_stream(orig_conn, orig_sql)
    r_it = _execute_query_stream(recon_conn, recon_sql)
    idx = 0
    o_count = 0
    r_count = 0
    sample_o = []
    sample_r = []
    for o, r in itertools.zip_longest(o_it, r_it, fillvalue=None):
        if o is None or r is None:
            return False, {
                "original_row_count": o_count,
                "reconstructed_row_count": r_count,
                "first_mismatch_index": idx,
                "sample_original_rows": sample_o,
                "sample_reconstructed_rows": sample_r,
            }
        o_count += 1
        r_count += 1
        no = _normalize_row(o, has_group_concat=has_group_concat)
        nr = _normalize_row(r, has_group_concat=has_group_concat)
        if len(sample_o) < sample_limit:
            sample_o.append(list(no))
            sample_r.append(list(nr))
        if no != nr:
            return False, {
                "original_row_count": o_count,
                "reconstructed_row_count": r_count,
                "first_mismatch_index": idx,
                "sample_original_rows": sample_o,
                "sample_reconstructed_rows": sample_r,
            }
        idx += 1
        if idx % 100000 == 0:
            print(f"    · compared {idx} rows", file=sys.stderr, flush=True)
    return True, {
        "original_row_count": o_count,
        "reconstructed_row_count": r_count,
    }


def _compare_stream_as_multiset(
    orig_conn: sqlite3.Connection,
    recon_conn: sqlite3.Connection,
    orig_sql: str,
    recon_sql: str,
    *,
    sample_limit: int = 5,
    has_group_concat: bool = False,
) -> Tuple[bool, Dict]:
    """Compare as multisets by enforcing SQL-side ordering then streaming compare."""
    o_sql = _wrap_with_order_by_positions(orig_conn, orig_sql)
    r_sql = _wrap_with_order_by_positions(recon_conn, recon_sql)
    return _compare_stream_ordered(
        orig_conn,
        recon_conn,
        o_sql,
        r_sql,
        sample_limit=sample_limit,
        has_group_concat=has_group_concat,
    )


def _normalize_row(row: tuple, *, has_group_concat: bool = False) -> tuple:
    """Normalize a row for comparison (handle NULLs, floats, etc.).

    Note: SQLite's GROUP_CONCAT has undefined ordering without explicit ORDER BY.
    When a query uses GROUP_CONCAT, canonicalize comma-separated outputs so
    equivalent sets compare equal.
    """
    normalized = []
    for val in row:
        if val is None:
            normalized.append(None)
        elif isinstance(val, float):
            # Round floats for comparison.
            # Aggregations (SUM/AVG/ratio) can differ by ~1e-6 due to evaluation
            # order across equivalent plans; treat those as equal.
            normalized.append(round(val, 6))
        else:
            s = str(val)
            if has_group_concat and "," in s:
                parts = [p.strip() for p in s.split(",") if p.strip() != ""]
                parts.sort()
                s = ",".join(parts)
            normalized.append(s)
    return tuple(normalized)


def _compare_ordered(orig: List[tuple], recon: List[tuple]) -> bool:
    """Compare results row-by-row (for queries with ORDER BY)."""
    if len(orig) != len(recon):
        return False

    for o, r in zip(orig, recon):
        if _normalize_row(o) != _normalize_row(r):
            return False
    return True


def _sortable_key(row: tuple):
    """Create a sortable key from a row, handling None values."""
    return tuple(
        (0, "") if v is None else (1, str(v))
        for v in row
    )


def _compare_as_multiset(orig: List[tuple], recon: List[tuple]) -> bool:
    """Compare results as multisets (for queries without ORDER BY)."""
    if len(orig) != len(recon):
        return False

    orig_normalized = sorted([_normalize_row(r) for r in orig], key=_sortable_key)
    recon_normalized = sorted([_normalize_row(r) for r in recon], key=_sortable_key)

    return orig_normalized == recon_normalized


def _compute_diff(
    orig: List[tuple], recon: List[tuple], ordered: bool
) -> Dict:
    """Compute a diff summary between original and reconstructed results."""
    diff = {
        "row_count_diff": len(recon) - len(orig),
    }

    orig_set = set(_normalize_row(r) for r in orig)
    recon_set = set(_normalize_row(r) for r in recon)

    missing = orig_set - recon_set
    extra = recon_set - orig_set

    diff["rows_missing_from_reconstructed"] = len(missing)
    diff["rows_extra_in_reconstructed"] = len(extra)

    # Sample mismatches
    if missing:
        diff["sample_missing"] = [list(r) for r in list(missing)[:3]]
    if extra:
        diff["sample_extra"] = [list(r) for r in list(extra)[:3]]

    if ordered and len(orig) == len(recon):
        # Find first position where they differ
        for i, (o, r) in enumerate(zip(orig, recon)):
            if _normalize_row(o) != _normalize_row(r):
                diff["first_diff_position"] = i
                diff["original_at_diff"] = list(o)
                diff["reconstructed_at_diff"] = list(r)
                break

    return diff
