from __future__ import annotations

import re
import sqlite3
from typing import List, Optional, Tuple


def _strip_over_clauses(sql: str) -> str:
    """Remove OVER ( ... ) window specs so ORDER BY inside OVER is ignored."""
    result: List[str] = []
    i = 0
    n = len(sql)
    upper = sql.upper()
    while i < n:
        if i + 4 <= n and upper[i : i + 4] == "OVER":
            prev = sql[i - 1] if i > 0 else " "
            if not (prev.isalnum() or prev == "_"):
                j = i + 4
                while j < n and sql[j].isspace():
                    j += 1
                if j < n and sql[j] == "(":
                    depth = 1
                    k = j + 1
                    while k < n and depth > 0:
                        if sql[k] == "(":
                            depth += 1
                        elif sql[k] == ")":
                            depth -= 1
                        k += 1
                    i = k
                    continue
        result.append(sql[i])
        i += 1
    return "".join(result)


def has_outer_order_by(sql: str) -> bool:
    """True if ORDER BY orders the outer statement result (not subqueries / OVER)."""
    stripped = _strip_over_clauses(sql)
    depth = 0
    i = 0
    n = len(stripped)
    upper = stripped.upper()
    in_single = False
    in_double = False
    while i < n:
        ch = stripped[i]
        if in_single:
            if ch == "'":
                nxt = stripped[i + 1] if i + 1 < n else ""
                if nxt == "'":
                    i += 2
                    continue
                in_single = False
            i += 1
            continue
        if in_double:
            if ch == '"':
                in_double = False
            i += 1
            continue
        if ch == "'":
            in_single = True
            i += 1
            continue
        if ch == '"':
            in_double = True
            i += 1
            continue
        if ch == "(":
            depth += 1
            i += 1
            continue
        if ch == ")":
            depth = max(0, depth - 1)
            i += 1
            continue
        if depth == 0 and i + 8 <= n and upper[i : i + 8] == "ORDER BY":
            before = stripped[i - 1] if i > 0 else " "
            if before.isalnum() or before == "_":
                i += 1
                continue
            j = i + 8
            while j < n and stripped[j].isspace():
                j += 1
            if j < n and (
                stripped[j].isalnum()
                or stripped[j] == "_"
                or stripped[j] in "`[\""
            ):
                return True
        i += 1
    return False


def _iter_keyword_positions_at_depth_zero(sql: str, keyword: str) -> List[int]:
    """Indices where `keyword` starts at parenthesis depth 0 (not in strings)."""
    kw = keyword.upper()
    n = len(sql)
    upper = sql.upper()
    depth = 0
    in_single = in_double = False
    starts: List[int] = []
    i = 0
    kw_len = len(keyword)
    while i < n:
        ch = sql[i]
        if in_single:
            if ch == "'":
                nxt = sql[i + 1] if i + 1 < n else ""
                if nxt == "'":
                    i += 2
                    continue
                in_single = False
            i += 1
            continue
        if in_double:
            if ch == '"':
                in_double = False
            i += 1
            continue
        if ch == "'":
            in_single = True
            i += 1
            continue
        if ch == '"':
            in_double = True
            i += 1
            continue
        if ch == "(":
            depth += 1
            i += 1
            continue
        if ch == ")":
            depth = max(0, depth - 1)
            i += 1
            continue
        if depth == 0 and i + kw_len <= n and upper[i : i + kw_len] == kw:
            before = sql[i - 1] if i > 0 else " "
            if before.isalnum() or before == "_":
                i += 1
                continue
            starts.append(i)
            i += 1
            continue
        i += 1
    return starts


def _has_outer_limit_at_depth_zero(sql: str) -> bool:
    return bool(_iter_keyword_positions_at_depth_zero(sql, "LIMIT"))


def _split_top_level_commas(expr_list: str) -> List[str]:
    """Split comma-separated expressions respecting parens and string literals."""
    s = expr_list.strip()
    if not s:
        return []
    n = len(s)
    depth = 0
    in_single = in_double = False
    start = 0
    parts: List[str] = []
    i = 0
    while i < n:
        ch = s[i]
        if in_single:
            if ch == "'":
                nxt = s[i + 1] if i + 1 < n else ""
                if nxt == "'":
                    i += 2
                    continue
                in_single = False
            i += 1
            continue
        if in_double:
            if ch == '"':
                in_double = False
            i += 1
            continue
        if ch == "'":
            in_single = True
            i += 1
            continue
        if ch == '"':
            in_double = True
            i += 1
            continue
        if ch == "(":
            depth += 1
            i += 1
            continue
        if ch == ")":
            depth = max(0, depth - 1)
            i += 1
            continue
        if ch == "," and depth == 0:
            parts.append(s[start:i].strip())
            start = i + 1
        i += 1
    parts.append(s[start:].strip())
    return [p for p in parts if p]


def _extract_outer_group_by_expressions(stripped: str) -> Optional[List[str]]:
    """
    Expressions in the outer GROUP BY list (depth 0).

    Used as ORDER BY tiebreakers: with GROUP BY, aggregates can tie across groups;
    PK-style tiebreakers on joined tables are not stable per group.
    """
    n = len(stripped)
    upper = stripped.upper()
    depth = 0
    in_single = in_double = False
    i = 0
    body_start: Optional[int] = None
    while i < n:
        ch = stripped[i]
        if in_single:
            if ch == "'":
                nxt = stripped[i + 1] if i + 1 < n else ""
                if nxt == "'":
                    i += 2
                    continue
                in_single = False
            i += 1
            continue
        if in_double:
            if ch == '"':
                in_double = False
            i += 1
            continue
        if ch == "'":
            in_single = True
            i += 1
            continue
        if ch == '"':
            in_double = True
            i += 1
            continue
        if ch == "(":
            depth += 1
            i += 1
            continue
        if ch == ")":
            depth = max(0, depth - 1)
            i += 1
            continue
        if depth == 0 and i + 8 <= n and upper[i : i + 8] == "GROUP BY":
            before = stripped[i - 1] if i > 0 else " "
            if not (before.isalnum() or before == "_"):
                j = i + 8
                while j < n and stripped[j].isspace():
                    j += 1
                body_start = j
                break
        i += 1
    if body_start is None:
        return None

    depth = 0
    in_single = in_double = False
    k = body_start
    body_end: Optional[int] = None
    while k < n:
        ch = stripped[k]
        if in_single:
            if ch == "'":
                nxt = stripped[k + 1] if k + 1 < n else ""
                if nxt == "'":
                    k += 2
                    continue
                in_single = False
            k += 1
            continue
        if in_double:
            if ch == '"':
                in_double = False
            k += 1
            continue
        if ch == "'":
            in_single = True
            k += 1
            continue
        if ch == '"':
            in_double = True
            k += 1
            continue
        if ch == "(":
            depth += 1
            k += 1
            continue
        if ch == ")":
            depth = max(0, depth - 1)
            k += 1
            continue
        if depth == 0:
            if k + 6 <= n and upper[k : k + 6] == "HAVING":
                before = stripped[k - 1] if k > 0 else " "
                if not (before.isalnum() or before == "_"):
                    body_end = k
                    break
            if k + 8 <= n and upper[k : k + 8] == "ORDER BY":
                before = stripped[k - 1] if k > 0 else " "
                if not (before.isalnum() or before == "_"):
                    body_end = k
                    break
            if k + 6 <= n and upper[k : k + 6] == "LIMIT":
                before = stripped[k - 1] if k > 0 else " "
                if not (before.isalnum() or before == "_"):
                    body_end = k
                    break
        k += 1

    body = (
        stripped[body_start:body_end].strip()
        if body_end is not None
        else stripped[body_start:].strip()
    )
    if not body:
        return None
    return _split_top_level_commas(body)


def _extract_outer_from_clause(stripped: str) -> Optional[str]:
    """Text from first depth-0 FROM through the next depth-0 clause keyword."""
    n = len(stripped)
    upper = stripped.upper()
    depth = 0
    in_single = in_double = False
    from_start: Optional[int] = None
    i = 0
    while i < n:
        ch = stripped[i]
        if in_single:
            if ch == "'":
                nxt = stripped[i + 1] if i + 1 < n else ""
                if nxt == "'":
                    i += 2
                    continue
                in_single = False
            i += 1
            continue
        if in_double:
            if ch == '"':
                in_double = False
            i += 1
            continue
        if ch == "'":
            in_single = True
            i += 1
            continue
        if ch == '"':
            in_double = True
            i += 1
            continue
        if ch == "(":
            depth += 1
            i += 1
            continue
        if ch == ")":
            depth = max(0, depth - 1)
            i += 1
            continue
        if depth == 0 and i + 4 <= n and upper[i : i + 4] == "FROM":
            before = stripped[i - 1] if i > 0 else " "
            if before.isalnum() or before == "_":
                i += 1
                continue
            j = i + 4
            while j < n and stripped[j].isspace():
                j += 1
            if j < n and (
                stripped[j].isalnum()
                or stripped[j] == "_"
                or stripped[j] in "([`\""
            ):
                from_start = j
                break
        i += 1
    if from_start is None:
        return None

    i = from_start
    while i < n:
        ch = stripped[i]
        if in_single:
            if ch == "'":
                nxt = stripped[i + 1] if i + 1 < n else ""
                if nxt == "'":
                    i += 2
                    continue
                in_single = False
            i += 1
            continue
        if in_double:
            if ch == '"':
                in_double = False
            i += 1
            continue
        if ch == "'":
            in_single = True
            i += 1
            continue
        if ch == '"':
            in_double = True
            i += 1
            continue
        if ch == "(":
            depth += 1
            i += 1
            continue
        if ch == ")":
            depth = max(0, depth - 1)
            i += 1
            continue
        if depth == 0:
            if i + 5 <= n and upper[i : i + 5] == "WHERE":
                before = stripped[i - 1] if i > 0 else " "
                if not (before.isalnum() or before == "_"):
                    return stripped[from_start:i].strip()
            if i + 5 <= n and upper[i : i + 5] == "GROUP":
                before = stripped[i - 1] if i > 0 else " "
                if not (before.isalnum() or before == "_"):
                    return stripped[from_start:i].strip()
            if i + 6 <= n and upper[i : i + 6] == "HAVING":
                before = stripped[i - 1] if i > 0 else " "
                if not (before.isalnum() or before == "_"):
                    return stripped[from_start:i].strip()
            if i + 8 <= n and upper[i : i + 8] == "ORDER BY":
                before = stripped[i - 1] if i > 0 else " "
                if not (before.isalnum() or before == "_"):
                    return stripped[from_start:i].strip()
            if i + 6 <= n and upper[i : i + 6] == "LIMIT":
                before = stripped[i - 1] if i > 0 else " "
                if not (before.isalnum() or before == "_"):
                    return stripped[from_start:i].strip()
        i += 1
    return stripped[from_start:].strip()


def _strip_join_on_tail(segment: str) -> str:
    """For a JOIN rhs segment, drop ` ON ...` at depth 0."""
    n = len(segment)
    upper = segment.upper()
    depth = 0
    in_single = in_double = False
    i = 0
    while i < n:
        ch = segment[i]
        if in_single:
            if ch == "'":
                nxt = segment[i + 1] if i + 1 < n else ""
                if nxt == "'":
                    i += 2
                    continue
                in_single = False
            i += 1
            continue
        if in_double:
            if ch == '"':
                in_double = False
            i += 1
            continue
        if ch == "'":
            in_single = True
            i += 1
            continue
        if ch == '"':
            in_double = True
            i += 1
            continue
        if ch == "(":
            depth += 1
            i += 1
            continue
        if ch == ")":
            depth = max(0, depth - 1)
            i += 1
            continue
        if depth == 0 and i + 3 <= n and upper[i : i + 3] == "ON ":
            before = segment[i - 1] if i > 0 else " "
            if not (before.isalnum() or before == "_"):
                return segment[:i].strip()
        i += 1
    return segment.strip()


def parse_from_table_aliases(from_clause: str) -> List[Tuple[str, str, str]]:
    """
    Best-effort list of (schema, table, alias) from a depth-0 FROM clause.

    *schema* is ``\"main\"`` for unqualified tables, or an attached schema name
    such as ``local_1`` for ``[local_1].[Table]``.

    Returns [] if a subquery or unsupported shape is detected.
    """
    s = from_clause.strip()
    if s.upper().startswith("FROM"):
        s = s[4:].strip()
    if not s or s[0] == "(":
        return []
    parts = re.split(
        r"\s+(?:(?:INNER|LEFT|RIGHT|FULL|CROSS)\s+)?JOIN\s+",
        s,
        flags=re.IGNORECASE,
    )
    out: List[Tuple[str, str, str]] = []
    for idx, raw in enumerate(parts):
        seg = raw.strip()
        if idx > 0:
            seg = _strip_join_on_tail(seg)
        parsed = _parse_one_from_table_segment(seg)
        if parsed is None:
            return []
        out.append(parsed)
    return out


def _parse_one_from_table_segment(seg: str) -> Optional[Tuple[str, str, str]]:
    seg = seg.strip()
    if not seg or seg.startswith("("):
        return None
    m = re.match(
        r"^(\[[^\]]+\]\.\[[^\]]+\])(?:\s+AS\s+(\w+))?",
        seg,
        re.IGNORECASE,
    )
    if m:
        qual = m.group(1)
        alias_g = m.group(2)
        sm = re.match(r"^\[([^\]]+)\]\.\[([^\]]+)\]$", qual)
        if not sm:
            return None
        schema, table = sm.group(1), sm.group(2)
        alias = alias_g if alias_g else table
        return (schema, table, alias)
    m2 = re.match(r"^(\w+)(?:\s+AS\s+(\w+))?", seg, re.IGNORECASE)
    if not m2:
        return None
    table, alias = m2.group(1), m2.group(2) or m2.group(1)
    if table.upper() == "SELECT":
        return None
    return ("main", table, alias)


def _quote_sqlite_ident(name: str) -> str:
    if re.match(r"^[A-Za-z_][A-Za-z0-9_]*$", name):
        return name
    return f'"{name.replace(chr(34), chr(34)+chr(34))}"'


def _pk_columns_for_table(
    conn: sqlite3.Connection, schema: str, table: str
) -> Optional[List[str]]:
    qi = _quote_sqlite_ident(table)
    try:
        if schema and schema != "main":
            qs = _quote_sqlite_ident(schema)
            rows = conn.execute(f"PRAGMA {qs}.table_info({qi})").fetchall()
        else:
            rows = conn.execute(f"PRAGMA table_info({qi})").fetchall()
    except sqlite3.Error:
        return None
    if not rows:
        return None
    pk_cols = sorted((r[5], r[1]) for r in rows if r[5] and r[5] > 0)
    if pk_cols:
        return [name for _, name in pk_cols]
    return []


_TIEBREAKER_NAME_CANDIDATES = (
    "CdsCode",
    "CDSCode",
    "cds_cd",
    "cds_code",
    "cds",
    "CdsCodeId",
    "schoolCdsId",
    "Cds",
    "NcesSchoolId",
    "id",
    "Id",
)


def _explain_accepts(conn: sqlite3.Connection, sql: str) -> bool:
    try:
        conn.execute(f"EXPLAIN {sql}")
        return True
    except sqlite3.Error:
        return False


def _tiebreaker_for_alias_explain(
    conn: sqlite3.Connection,
    prefix_before_limit: str,
    limit_suffix: str,
    alias: str,
) -> Optional[str]:
    """
    Prefer real key columns (validated with EXPLAIN); optionally rowid.
    Used for CTEs and sources without PRAGMA metadata on *conn*.

    Returns None if nothing is valid (e.g. JOIN of CTEs often has no rowid).
    """
    qa = _quote_sqlite_ident(alias)
    for col in _TIEBREAKER_NAME_CANDIDATES:
        qc = _quote_sqlite_ident(col)
        expr = f"{qa}.{qc} ASC"
        trial = f"{prefix_before_limit}, {expr} {limit_suffix}"
        if _explain_accepts(conn, trial):
            return expr
    rowid_expr = f"{qa}.rowid ASC"
    trial_rid = f"{prefix_before_limit}, {rowid_expr} {limit_suffix}"
    if _explain_accepts(conn, trial_rid):
        return rowid_expr
    return None


def build_order_tiebreaker_exprs(
    conn: sqlite3.Connection,
    from_clause: str,
    prefix_before_limit: str,
    limit_suffix: str,
) -> Optional[str]:
    tables = parse_from_table_aliases(from_clause)
    if not tables:
        return None
    parts: List[str] = []
    current_prefix = prefix_before_limit
    for schema, table, alias in tables:
        pks = _pk_columns_for_table(conn, schema, table)
        if pks:
            for c in pks:
                expr = f"{_quote_sqlite_ident(alias)}.{_quote_sqlite_ident(c)} ASC"
                parts.append(expr)
                current_prefix = f"{current_prefix}, {expr}"
        else:
            expr = _tiebreaker_for_alias_explain(
                conn, current_prefix, limit_suffix, alias
            )
            if expr:
                parts.append(expr)
                current_prefix = f"{current_prefix}, {expr}"
    if not parts:
        return None
    return ", ".join(parts)


def stabilize_sqlite_order_by_tiebreaker(
    conn: sqlite3.Connection, sql: str
) -> str:
    """
    If the statement has outer ORDER BY and outer LIMIT, append tiebreakers
    immediately before LIMIT. No-op if parsing fails or shape is unsupported.

    * Queries with outer **GROUP BY**: append the grouping expressions (e.g.
      ``T2.City``) so ties on ``ORDER BY SUM(...)`` are deterministic.
    * Otherwise: append PK / candidate columns from the outer **FROM** clause.
    """
    if not has_outer_order_by(sql):
        return sql
    if not _has_outer_limit_at_depth_zero(sql):
        return sql
    stripped = _strip_over_clauses(sql)
    limit_positions = _iter_keyword_positions_at_depth_zero(stripped, "LIMIT")
    if not limit_positions:
        return sql
    lim = max(limit_positions)
    prefix = stripped[:lim].rstrip()
    suffix = stripped[lim:]
    # GROUP BY + ORDER BY aggregates: ties must break on grouping columns, not
    # row PKs (which are not unique per grouped row).
    gb_exprs = _extract_outer_group_by_expressions(stripped)
    if gb_exprs:
        tb = ", ".join(f"{e} ASC" for e in gb_exprs)
        return prefix + ", " + tb + " " + suffix
    from_clause = _extract_outer_from_clause(stripped)
    if not from_clause:
        return sql
    tb = build_order_tiebreaker_exprs(conn, from_clause, prefix, suffix)
    if not tb:
        return sql
    return prefix + ", " + tb + " " + suffix
