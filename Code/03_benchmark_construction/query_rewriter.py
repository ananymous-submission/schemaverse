import re
import json
import os
import sqlite3
from typing import List, Dict, Set, Tuple, Optional
from collections import defaultdict

from schema_parser import SchemaGraph
from transforms import LocalSchema, TransformSpec
from fragment_workload import (
    extract_table_refs,
    collect_needed_original_columns,
    compute_fragment_aware_locals,
)
from sql_order_stabilize import has_outer_order_by, stabilize_sqlite_order_by_tiebreaker


# ──────────────────────────────────────────────
# Table extraction from SQL
# ──────────────────────────────────────────────

SQL_KEYWORDS = {
    'SELECT', 'WHERE', 'AND', 'OR', 'ON', 'SET', 'VALUES', 'INTO',
    'GROUP', 'ORDER', 'HAVING', 'LIMIT', 'UNION', 'EXCEPT', 'INTERSECT',
    'CASE', 'WHEN', 'THEN', 'ELSE', 'END', 'AS', 'NOT', 'NULL',
    'INNER', 'LEFT', 'RIGHT', 'OUTER', 'CROSS', 'NATURAL', 'EXISTS',
    'IN', 'BETWEEN', 'LIKE', 'IS', 'BY', 'ALL', 'ANY', 'SOME',
    'TRUE', 'FALSE', 'DISTINCT', 'COUNT', 'SUM', 'AVG', 'MIN', 'MAX',
    'ASC', 'DESC', 'WITH', 'RECURSIVE', 'IF', 'CAST', 'COALESCE',
    'REPLACE', 'INSERT', 'UPDATE', 'DELETE', 'CREATE', 'DROP', 'ALTER',
    'TABLE', 'VIEW', 'INDEX', 'TRIGGER', 'PRAGMA', 'BEGIN', 'COMMIT',
    'ROLLBACK', 'SAVEPOINT', 'RELEASE', 'EXPLAIN', 'VACUUM', 'REINDEX',
    'ATTACH', 'DETACH', 'DATABASE', 'TEMPORARY', 'TEMP', 'UNIQUE',
    'PRIMARY', 'FOREIGN', 'KEY', 'REFERENCES', 'CHECK', 'DEFAULT',
    'CONSTRAINT', 'AUTOINCREMENT', 'INTEGER', 'TEXT', 'REAL', 'BLOB',
    'NUMERIC', 'VARCHAR', 'CHAR', 'BOOLEAN', 'DATE', 'DATETIME',
    'TIMESTAMP', 'FLOAT', 'DOUBLE', 'USING', 'OFFSET', 'FETCH',
    'NEXT', 'ROWS', 'ONLY', 'PERCENT', 'TOP', 'FOR',
}


def _extract_tables_from_sql(sql: str, known_tables: Set[str]) -> List[Tuple[str, str]]:
    """
    Extract (original_table_name, alias) pairs from a SQL query.
    Uses both pattern matching and known-table-name lookup.

    Returns list of (table_name, alias) where alias defaults to table_name
    if no alias is provided.
    """
    refs = []
    seen = set()

    # Build a case-insensitive lookup for known tables
    table_lower_map = {t.lower(): t for t in known_tables}

    # Pattern: FROM/JOIN table_name [AS] [alias]
    pattern = r'\b(?:FROM|JOIN)\s+(\w+)(?:\s+(?:AS\s+)?(\w+))?'

    for m in re.finditer(pattern, sql, re.IGNORECASE):
        raw_table = m.group(1)
        raw_alias = m.group(2)

        # Skip SQL keywords
        if raw_table.upper() in SQL_KEYWORDS:
            continue
        if raw_alias and raw_alias.upper() in SQL_KEYWORDS:
            raw_alias = None

        # Resolve to known table name (case-insensitive)
        actual_table = table_lower_map.get(raw_table.lower())
        if actual_table is None:
            # Table not in schema — might be a subquery alias, skip
            continue

        alias = raw_alias if raw_alias else raw_table

        key = (actual_table, alias)
        if key not in seen:
            refs.append((actual_table, alias, raw_table))
            seen.add(key)

    return refs


# ──────────────────────────────────────────────
# Build lookup maps
# ──────────────────────────────────────────────

def _build_table_to_local_map(locals_list: List[LocalSchema]) -> Dict[str, Set[str]]:
    """
    Build mapping: original_table_name -> set of local_names.
    If a table is split/partitioned and fragments are in different locals,
    the set will contain multiple local names.
    """
    table_to_locals = {}
    for local in locals_list:
        for lt_name, transform in local.tables.items():
            orig = transform.source_table
            if orig not in table_to_locals:
                table_to_locals[orig] = set()
            table_to_locals[orig].add(local.local_name)
    return table_to_locals


def _build_table_to_local_schema(locals_list: List[LocalSchema]) -> Dict[str, LocalSchema]:
    """Build mapping: original_table_name -> LocalSchema object."""
    table_to_schema = {}
    for local in locals_list:
        for lt_name, transform in local.tables.items():
            orig = transform.source_table
            if orig not in table_to_schema:
                table_to_schema[orig] = local
    return table_to_schema


def _get_local_table_info(
    original_table: str, local_schema: LocalSchema
) -> List[Tuple[str, dict]]:
    """
    Get all local table entries that correspond to an original table.
    Returns list of (local_table_name, transform) — usually 1,
    but 2 for split/partitioned tables.
    """
    entries = []
    for lt_name, transform in local_schema.tables.items():
        if transform.source_table == original_table:
            entries.append((lt_name, transform))
    return entries


# ──────────────────────────────────────────────
# Single-local query rewriter
# ──────────────────────────────────────────────

def _rewrite_query_for_local(
    sql: str,
    table_refs: List[Tuple[str, str, str]],
    local_schema: LocalSchema,
    schema_graph: SchemaGraph,
) -> str:
    """
    Rewrite an SQL query to use local table/column names.

    Handles:
    - Normal tables: direct rename of table + columns
    - Row-partitioned tables: replace with CTE using UNION ALL of partitions
    - Horizontally split tables: replace with CTE using JOIN of fragments

    Args:
        sql: Original SQL
        table_refs: List of (actual_table, alias, raw_table_in_sql)
        local_schema: The local schema these tables belong to
        schema_graph: Original schema graph

    Returns:
        Rewritten SQL string
    """
    # Build alias -> original_table
    alias_to_orig = {}
    for actual_table, alias, raw_table in table_refs:
        alias_to_orig[alias] = actual_table

    # For each original table, get local info
    orig_to_local_entries = {}
    for actual_table, _, _ in table_refs:
        if actual_table not in orig_to_local_entries:
            entries = _get_local_table_info(actual_table, local_schema)
            orig_to_local_entries[actual_table] = entries

    # Determine which tables need CTEs (split or partitioned)
    ctes = []
    cte_table_aliases = {}  # maps original table name -> CTE alias name
    system_cte_col_maps: Dict[str, Dict[str, str]] = {}

    for actual_table, entries in orig_to_local_entries.items():
        if not entries:
            continue

        has_row_partition = any(e[1].is_row_partition for e in entries)
        has_vsplit = any(e[1].is_vertical_split_fragment for e in entries)

        if has_row_partition and has_vsplit:
            cte_alias = f"_cte_{actual_table.lower()}"
            cte_sql, rep_trs = _build_vertical_row_combined_cte(
                actual_table, entries, schema_graph
            )
            ctes.append((cte_alias, cte_sql))
            cte_table_aliases[actual_table] = cte_alias
            system_cte_col_maps[actual_table] = _vertical_split_merged_orig_to_output_local(
                rep_trs
            )

        elif has_row_partition and len(entries) >= 2:
            # Horizontal row partition: UNION ALL CTE
            cte_alias = f"_cte_{actual_table.lower()}"
            cte_sql = _build_row_partition_cte(actual_table, entries, schema_graph)
            ctes.append((cte_alias, cte_sql))
            cte_table_aliases[actual_table] = cte_alias
            rp_first = next((tr for _, tr in entries if tr.is_row_partition), None)
            if rp_first:
                system_cte_col_maps[actual_table] = {
                    oc: lc for lc, oc in rp_first.column_map.items()
                }

        elif has_vsplit and len(entries) >= 2:
            # Vertical column split: N-way JOIN on PK
            cte_alias = f"_cte_{actual_table.lower()}"
            cte_sql = _build_vertical_split_cte(actual_table, entries, schema_graph)
            ctes.append((cte_alias, cte_sql))
            cte_table_aliases[actual_table] = cte_alias
            trs = _ordered_vertical_transforms_single(entries)
            system_cte_col_maps[actual_table] = _vertical_split_merged_orig_to_output_local(trs)

    # ── Build the rewritten SQL ──
    result = sql

    # Build a map of original_table -> replacement name (for ALL occurrences)
    table_replacements = {}  # raw_table_in_sql -> replacement
    for actual_table, alias, raw_table in table_refs:
        entries = orig_to_local_entries.get(actual_table, [])
        if actual_table in cte_table_aliases:
            table_replacements[raw_table] = cte_table_aliases[actual_table]
        elif entries:
            table_replacements[raw_table] = entries[0][0]

    # Step 1: Replace ALL occurrences of table names in FROM/JOIN clauses
    # (including subqueries). Replace longest table names first.
    for raw_table in sorted(table_replacements.keys(), key=len, reverse=True):
        replacement = table_replacements[raw_table]
        # Replace in FROM/JOIN contexts — all occurrences
        result = re.sub(
            r'(\b(?:FROM|JOIN)\s+)' + re.escape(raw_table) + r'\b',
            r'\g<1>' + replacement,
            result,
            flags=re.IGNORECASE,
        )

    # Step 2: Replace qualified column references (alias.orig_col → qual.local_col)
    for actual_table, alias, raw_table in table_refs:
        entries = orig_to_local_entries.get(actual_table, [])
        if not entries:
            continue
        physical = _physical_qualifier_single_local(
            actual_table, orig_to_local_entries, cte_table_aliases,
        )
        if not physical:
            continue
        qual = _column_qualifier_prefix(alias, raw_table, physical)
        # In this step we handle both bare identifiers (alias.col)
        # and quoted identifiers (alias.`col`, alias.[col], alias."col").
        inv_col_map = _prune_prefix_orig_column_keys(
            dict(system_cte_col_maps.get(actual_table) or _get_inverse_column_map(actual_table, entries))
        )

        # Sort column names by length (longest first) to avoid partial replacements
        sorted_cols = sorted(inv_col_map.items(), key=lambda x: len(x[0]), reverse=True)

        for orig_col, local_col in sorted_cols:
            if orig_col == local_col:
                continue  # No change needed

            # Match SQL correlation name; emit qual.local_col (alias or physical)
            # Avoid trailing \\b: it matches end-of-word inside multi-word column names.
            end_anchor = r"\b" if re.match(r"^[A-Za-z0-9_]+$", orig_col) else r"(?![A-Za-z0-9_])"
            pattern = r"\b" + re.escape(alias) + r"\." + re.escape(orig_col) + end_anchor
            replacement = _qual_qualified_col(qual, local_col)
            result = re.sub(pattern, replacement, result, flags=re.IGNORECASE)

            # Also handle quoted identifiers such as alias.`orig_col` or alias.[orig_col]
            for q_open, q_close in (('[', ']'), ('`', '`'), ('"', '"')):
                quoted_orig = q_open + orig_col + q_close
                pattern_quoted = r'\b' + re.escape(alias) + r'\.' + re.escape(quoted_orig)
                result = re.sub(pattern_quoted, replacement, result, flags=re.IGNORECASE)

    # Step 3 + 4: Scope-aware unqualified column rename + CTE propagation
    result = _scope_aware_unqualified_rename(
        result, sql, table_refs, table_replacements, cte_table_aliases,
        orig_to_local_entries, schema_graph, system_cte_col_maps=system_cte_col_maps,
    )

    # Step 5: Prepend / merge CTEs (must not emit a second top-level WITH)
    if ctes:
        cte_parts = []
        for cte_alias, cte_sql in ctes:
            cte_parts.append(f"{cte_alias} AS (\n{cte_sql}\n)")
        result = _prepend_or_merge_with_ctes(result, cte_parts)

    result = _stabilize_distinct_order_limit(result)

    return result


def _prepend_or_merge_with_ctes(result: str, cte_parts: List[str]) -> str:
    """
    Inject generated CTEs. If the query already starts with WITH (user CTEs),
    merge as a single WITH c1, c2, ... — SQLite rejects ``WITH a AS (...) WITH b AS (...)``.
    """
    joined = ",\n".join(cte_parts)
    if re.match(r"^\s*WITH\s+", result, re.IGNORECASE):
        return re.sub(
            r"^\s*WITH\s+",
            f"WITH {joined},\n",
            result,
            count=1,
            flags=re.IGNORECASE,
        )
    return f"WITH {joined}\n{result}"


def _outer_order_by_limit_span(s: str) -> Optional[Tuple[int, int]]:
    """
    Return (start_index, end_exclusive) of the trailing ``ORDER BY ... LIMIT ...``
    at parenthesis depth 0 (not inside a subquery).
    """
    depth = 0
    i = 0
    n = len(s)
    markers: List[Tuple[str, int]] = []
    while i < n:
        c = s[i]
        if c == "'":
            j = s.find("'", i + 1)
            if j < 0:
                break
            i = j + 1
            continue
        if c == "(":
            depth += 1
        elif c == ")":
            depth -= 1
        elif depth == 0:
            if re.match(r"\bORDER\s+BY\b", s[i:], re.I):
                markers.append(("OB", i))
            elif re.match(r"\bLIMIT\b", s[i:], re.I):
                markers.append(("LM", i))
        i += 1
    if not markers or markers[-1][0] != "LM":
        return None
    lim_pos = markers[-1][1]
    ob_pos = None
    for kind, pos in reversed(markers[:-1]):
        if kind == "OB" and pos < lim_pos:
            ob_pos = pos
            break
    if ob_pos is None:
        return None
    return ob_pos, n


def _stabilize_distinct_order_limit(sql: str) -> str:
    """
    ``SELECT DISTINCT c ... ORDER BY x LIMIT n`` leaves row order among ``x`` ties
    unspecified; original vs local DB can return different LIMIT windows. If DISTINCT
    projects a column not used in ORDER BY, append it as a final tie-breaker so LIMIT
    is deterministic (card_games / BIRD pattern).
    """
    had_semicolon = sql.rstrip().endswith(";")
    s = sql.rstrip().rstrip(";").strip()
    low = s.lower()
    if "select distinct" not in low:
        return sql
    span = _outer_order_by_limit_span(s)
    if not span:
        return sql
    ob_start, end_excl = span
    tail = s[ob_start:end_excl]
    m = re.match(
        r"ORDER\s+BY\s+(.+?)\s+LIMIT\s+([\d\s,]+)\s*$",
        tail,
        re.IGNORECASE | re.DOTALL,
    )
    if not m:
        return sql
    order_exprs = m.group(1).strip()
    lim = m.group(2).strip()
    matches = list(
        re.finditer(
            r"\bSELECT\s+DISTINCT\s+(\[[^\]]+\]|\w+)\s+FROM\b",
            s,
            re.IGNORECASE,
        )
    )
    if not matches:
        return sql
    dist_col = matches[-1].group(1)
    bare = dist_col.strip("[]")
    if re.search(r"\b" + re.escape(bare) + r"\b", order_exprs, re.IGNORECASE):
        return sql
    new_tail = f"ORDER BY {order_exprs}, {dist_col} ASC LIMIT {lim}"
    out = s[:ob_start] + new_tail
    if had_semicolon:
        out += ";"
    return out


def _get_inverse_column_map(
    original_table: str,
    entries: List[Tuple[str, object]],
) -> Dict[str, str]:
    """
    Get orig_col -> local_col mapping for a table.
    For split/partitioned tables, merges column maps from ALL entries
    so that columns from any fragment are included.
    """
    # column_map is {local_col: orig_col}
    # We need the inverse: {orig_col: local_col}
    merged = {}
    for _, transform in entries:
        for local_col, orig_col in transform.column_map.items():
            if orig_col not in merged:
                merged[orig_col] = local_col
    return merged


def _sqlite_ident_needs_brackets(name: str) -> bool:
    return not bool(re.match(r"^[A-Za-z_][A-Za-z0-9_]*$", name))


def _sqlite_unwrap_bracketed(name: str) -> str:
    s = name.strip()
    if len(s) >= 2 and s.startswith("[") and s.endswith("]"):
        inner = s[1:-1].replace("]]", "]")
        return inner
    return s


def _sqlite_ident(name: str) -> str:
    """Emit a SQLite identifier; bracket and escape ] when not a simple token (idempotent)."""
    s = _sqlite_unwrap_bracketed(name)
    if not _sqlite_ident_needs_brackets(s):
        return s
    return "[" + s.replace("]", "]]") + "]"


def _prune_prefix_orig_column_keys(inv: Dict[str, str]) -> Dict[str, str]:
    """
    Drop shorter orig_col keys that are strict prefixes of a longer key + space,
    so `alias.District` does not match inside `alias.District Name`.
    """
    if not inv:
        return inv
    keys = sorted(inv.keys(), key=lambda k: (-len(k), k))
    kept: Dict[str, str] = {}
    for k in keys:
        kl = k.lower()
        skip = False
        for ex in kept:
            el = ex.lower()
            if el.startswith(kl + " ") and len(ex) > len(k):
                skip = True
                break
        if not skip:
            kept[k] = inv[k]
    return kept


def _qual_qualified_col(qual: str, local_col: str) -> str:
    """qual.local_col with safe bracketing of local_col (spaces, parens, etc.)."""
    return f"{qual}.{_sqlite_ident(local_col)}"


def _vertical_split_merged_orig_to_output_local(
    transforms_in_cte_order: List[object],
) -> Dict[str, str]:
    """
    orig_col -> output column name exposed by a vertical-split CTE SELECT.
    Matches fragment pick order in _vertical_split_select_clause_parts (first fragment
    that contains the column wins for overlaps).
    """
    seen_orig: Set[str] = set()
    out: Dict[str, str] = {}
    for tr in transforms_in_cte_order:
        for local_col, orig_col in tr.column_map.items():
            if orig_col in seen_orig:
                continue
            seen_orig.add(orig_col)
            out[orig_col] = local_col
    return out


def _ordered_vertical_transforms_federated(
    all_entries: List[Tuple[str, str, object]],
) -> List[object]:
    triples = [
        (ln, lt, tr)
        for ln, lt, tr in all_entries
        if tr.is_vertical_split_fragment
    ]
    triples.sort(key=lambda x: (x[0], x[1]))
    return [tr for _, _, tr in triples]


def _ordered_vertical_transforms_single(
    entries: List[Tuple[str, object]],
) -> List[object]:
    pairs = [(lt, tr) for lt, tr in entries if tr.is_vertical_split_fragment]
    pairs.sort(key=lambda x: x[0])
    return [tr for _, tr in pairs]


def _physical_qualifier_single_local(
    orig_table: str,
    orig_to_local_entries: Dict,
    cte_table_aliases: Dict[str, str],
) -> Optional[str]:
    """
    After FROM/JOIN names are rewritten, qualified columns must use the same
    identifier (local table name or system CTE alias), not the original SQL alias.
    Otherwise SQLite sees e.g. JOIN profile_publisher ... publisher.col.
    """
    if orig_table in cte_table_aliases:
        return cte_table_aliases[orig_table]
    entries = orig_to_local_entries.get(orig_table) or []
    if entries:
        return entries[0][0]
    return None


def _physical_qualifier_federated(
    orig_table: str,
    orig_to_local_entries: Dict,
    cte_table_aliases: Dict[str, str],
) -> Optional[str]:
    """Same as single-local, but federated FROM/JOIN uses [local].[table]."""
    if orig_table in cte_table_aliases:
        return cte_table_aliases[orig_table]
    entries_list = orig_to_local_entries.get(orig_table)
    if not entries_list:
        return None
    local_name, entries = entries_list[0]
    if not entries:
        return None
    lt_name = entries[0][0]
    return f"[{local_name}].[{lt_name}]"


def _column_qualifier_prefix(alias: str, raw_table: str, physical: str) -> str:
    """
    Choose the left-hand side for qualified columns after FROM/JOIN renames.

    If the query uses an explicit correlation name different from the table name
    (``FROM superhero AS T1``), SQLite only resolves ``T1.col`` after the FROM
    clause becomes ``FROM _cte_superhero AS T1`` — not ``_cte_superhero.col``.

    If the correlation name is the table name (``FROM superhero`` / ``JOIN publisher``),
    Pass 1 rewrites the table token to ``physical``, so qualifiers must use
    ``physical.col`` (not ``publisher.col``).
    """
    if alias.lower() == raw_table.lower():
        return physical
    return alias


# ──────────────────────────────────────────────
# Scope-aware column rename helpers
# ──────────────────────────────────────────────

def _find_scope_start(sql: str, pos: int) -> int:
    """Return the start of the innermost enclosing parenthesised scope."""
    depth = 0
    for i in range(pos - 1, -1, -1):
        if sql[i] == ')':
            depth += 1
        elif sql[i] == '(':
            if depth > 0:
                depth -= 1
            else:
                return i + 1
    return 0


def _find_scope_end(sql: str, pos: int) -> int:
    """Return the end of the innermost enclosing parenthesised scope."""
    depth = 0
    for i in range(pos, len(sql)):
        if sql[i] == '(':
            depth += 1
        elif sql[i] == ')':
            if depth > 0:
                depth -= 1
            else:
                return i
    return len(sql)


def _strip_nested_parens(sql: str) -> str:
    """Replace content inside nested parentheses with spaces (keeps top level)."""
    result = list(sql)
    depth = 0
    for i, c in enumerate(sql):
        if c == '(':
            depth += 1
            if depth > 1:
                result[i] = ' '
        elif c == ')':
            if depth > 1:
                result[i] = ' '
            depth -= 1
    return ''.join(result)


def _extract_scope_tables(
    scope_sql: str,
    replacement_to_actual: Dict[str, str],
    user_cte_names: Set[str],
) -> List[str]:
    """
    Extract original table names (or user CTE names) from FROM/JOIN inside
    a single scope segment.  Handles ``[local].[table]`` federated refs,
    system-CTE aliases, plain local table names and user-CTE names.
    Returns names in FROM-clause order.
    """
    clean = _strip_nested_parens(scope_sql)
    tables: List[str] = []
    seen: Set[str] = set()

    # Matches [schema].[table]  or  plain_word
    for m in re.finditer(
        r'\b(?:FROM|JOIN)\s+(\[[\w]+\]\.\[[\w]+\]|[\w]+)',
        clean, re.IGNORECASE,
    ):
        ref = m.group(1)
        if ref.upper() in SQL_KEYWORDS:
            continue
        # Exact lookup
        actual = replacement_to_actual.get(ref)
        if actual and actual not in seen:
            tables.append(actual)
            seen.add(actual)
            continue
        if ref in user_cte_names and ref not in seen:
            tables.append(ref)
            seen.add(ref)
            continue
        # Case-insensitive fallback
        for k, v in replacement_to_actual.items():
            if k.lower() == ref.lower() and v not in seen:
                tables.append(v)
                seen.add(v)
                break
    return tables


def _extract_user_cte_info(sql: str) -> Dict[str, str]:
    """
    Extract user-defined CTE names → body text from an SQL WITH clause.
    Returns an insertion-ordered dict.
    """
    from collections import OrderedDict
    ctes: Dict[str, str] = OrderedDict()
    if not re.match(r'^\s*WITH\s', sql, re.IGNORECASE):
        return ctes
    pos = re.match(r'^\s*WITH\s', sql, re.IGNORECASE).end()
    while pos < len(sql):
        while pos < len(sql) and (sql[pos].isspace() or sql[pos] == ','):
            pos += 1
        name_m = re.match(r'(\w+)\s+AS\s*\(', sql[pos:], re.IGNORECASE)
        if not name_m:
            break
        cte_name = name_m.group(1)
        if cte_name.upper() in ('SELECT', 'INSERT', 'UPDATE', 'DELETE'):
            break
        body_start = pos + name_m.end()
        depth, i = 1, body_start
        while i < len(sql) and depth > 0:
            if sql[i] == '(':
                depth += 1
            elif sql[i] == ')':
                depth -= 1
            i += 1
        ctes[cte_name] = sql[body_start:i - 1]
        pos = i
    return ctes


def _split_select_items(select_clause: str) -> List[str]:
    """Split a SELECT clause into items, respecting nested parentheses."""
    items: List[str] = []
    depth = 0
    current: List[str] = []
    for c in select_clause:
        if c == '(':
            depth += 1
            current.append(c)
        elif c == ')':
            depth -= 1
            current.append(c)
        elif c == ',' and depth == 0:
            items.append(''.join(current))
            current = []
        else:
            current.append(c)
    if current:
        items.append(''.join(current))
    return items


def _build_cte_column_map(
    cte_body: str,
    known_tables: Set[str],
    all_inv_maps: Dict[str, Dict[str, str]],
    prev_cte_maps: Optional[Dict[str, Dict[str, str]]] = None,
) -> Dict[str, str]:
    """
    Build ``{orig_output_col: renamed_output_col}`` for a user-defined CTE.
    Uses qualified references in the SELECT list to decide which table's
    rename applies; falls back to previous CTE maps for CTE-to-CTE refs.
    """
    prev_cte_maps = prev_cte_maps or {}

    # Tables referenced in the CTE body
    cte_table_refs = _extract_tables_from_sql(cte_body, known_tables)
    cte_alias_to_orig = {alias: actual for actual, alias, _ in cte_table_refs}

    # Previous CTEs referenced in FROM
    cte_from_refs: Dict[str, Dict[str, str]] = {}
    for m_ref in re.finditer(r'\b(?:FROM|JOIN)\s+(\w+)', cte_body, re.IGNORECASE):
        ref = m_ref.group(1)
        if ref.upper() not in SQL_KEYWORDS and ref in prev_cte_maps:
            cte_from_refs[ref] = prev_cte_maps[ref]

    # Parse SELECT list
    sel_m = re.match(
        r'\s*SELECT\s+(?:DISTINCT\s+)?(.*?)\s+FROM\b',
        cte_body, re.IGNORECASE | re.DOTALL,
    )
    if not sel_m:
        return {}

    items = _split_select_items(sel_m.group(1))
    col_map: Dict[str, str] = {}

    for item in items:
        item = item.strip()
        # Explicit alias → keeps its name
        as_m = re.search(r'\bAS\s+(\w+)\s*$', item, re.IGNORECASE)
        if as_m:
            col_map[as_m.group(1)] = as_m.group(1)
            continue
        # Qualified reference (alias.col)
        qual_m = re.search(r'\b(\w+)\.(\w+)\s*$', item)
        if qual_m:
            alias, col_name = qual_m.group(1), qual_m.group(2)
            orig_table = cte_alias_to_orig.get(alias)
            if orig_table and orig_table in all_inv_maps:
                col_map[col_name] = all_inv_maps[orig_table].get(col_name, col_name)
            else:
                col_map[col_name] = col_name
            continue
        # Bare identifier
        bare_m = re.match(r'^\s*(\w+)\s*$', item)
        if bare_m:
            col_name = bare_m.group(1)
            # Check previous CTEs first
            for cte_map in cte_from_refs.values():
                if col_name in cte_map:
                    col_map[col_name] = cte_map[col_name]
                    break
            else:
                # Then real tables
                for actual, _, _ in cte_table_refs:
                    inv = all_inv_maps.get(actual, {})
                    if col_name in inv:
                        col_map[col_name] = inv[col_name]
                        break
                else:
                    col_map[col_name] = col_name
            continue
    return col_map


def _determine_scope_rename(
    sql: str,
    pos: int,
    orig_col: str,
    replacement_to_actual: Dict[str, str],
    all_inv_maps: Dict[str, Dict[str, str]],
    user_cte_column_maps: Dict[str, Dict[str, str]],
    user_cte_names: Set[str],
    _depth: int = 0,
) -> Optional[str]:
    """
    For an unqualified column at *pos* in *sql*, walk the enclosing scopes
    outward until a matching rename is found.
    """
    if _depth > 20:
        return None
    scope_start = _find_scope_start(sql, pos)
    scope_end = _find_scope_end(sql, pos)
    scope_sql = sql[scope_start:scope_end]

    scope_tables = _extract_scope_tables(
        scope_sql, replacement_to_actual, user_cte_names,
    )
    for table_name in scope_tables:
        if table_name in all_inv_maps:
            inv = all_inv_maps[table_name]
            for k, v in inv.items():
                if k.lower() == orig_col.lower():
                    # Column found in this scope's table.
                    # Return mapped name (may equal orig_col if unchanged).
                    return v
        if table_name in user_cte_column_maps:
            cte_map = user_cte_column_maps[table_name]
            for k, v in cte_map.items():
                if k.lower() == orig_col.lower():
                    return v

    # Column not found in this scope → try outer scope
    if scope_start > 1:
        return _determine_scope_rename(
            sql, scope_start - 2, orig_col,
            replacement_to_actual, all_inv_maps,
            user_cte_column_maps, user_cte_names,
            _depth + 1,
        )
    # Top-level fallback: first available rename
    for inv in all_inv_maps.values():
        for k, v in inv.items():
            if k.lower() == orig_col.lower() and k != v:
                return v
    return None


def _scope_aware_unqualified_rename(
    result: str,
    orig_sql: str,
    table_refs: List[Tuple[str, str, str]],
    table_replacements: Dict[str, str],
    cte_table_aliases: Dict[str, str],
    orig_to_local_entries: Dict,
    schema_graph,
    system_cte_col_maps: Optional[Dict[str, Dict[str, str]]] = None,
) -> str:
    """
    Rename unqualified column references in a scope-aware manner.
    Shared implementation for both single-local and federated rewriters.

    * Builds per-table inverse column maps.
    * Extracts user-defined CTE info from the ORIGINAL sql and builds
      per-CTE column maps.
    * For every unqualified column occurrence, walks outward through
      enclosing scopes to find the correct rename.
    * Fixes qualified references to user-defined CTEs
      (``cte_name.orig_col``).
    * Fixes qualified references to system-generated CTEs
      (``_cte_X.orig_col``).
    """
    # 1. Build all_inv_maps  (orig_table -> {orig_col: local_col})
    all_inv_maps: Dict[str, Dict[str, str]] = {}
    for actual_table, _, _ in table_refs:
        if actual_table in all_inv_maps:
            continue
        entries = orig_to_local_entries.get(actual_table)
        if not entries:
            continue
        # entries may be a list of (lt_name, transform) or list of (local_name, list_of_entries)
        # Flatten if federated format
        flat: list = []
        for item in entries:
            if isinstance(item, tuple) and len(item) == 2:
                # Could be (lt_name, transform) or (local_name, entries_list)
                second = item[1]
                if isinstance(second, list):
                    flat.extend(second)
                else:
                    flat.append(item)
            else:
                flat.append(item)
        if flat:
            if system_cte_col_maps and actual_table in system_cte_col_maps:
                all_inv_maps[actual_table] = _prune_prefix_orig_column_keys(
                    dict(system_cte_col_maps[actual_table])
                )
            else:
                all_inv_maps[actual_table] = _prune_prefix_orig_column_keys(
                    _get_inverse_column_map(actual_table, flat)
                )

    # 2. Build reverse table mapping  (replacement_text -> orig_table)
    replacement_to_actual: Dict[str, str] = {}
    for actual_table, alias, raw_table in table_refs:
        repl = table_replacements.get(raw_table)
        if repl:
            replacement_to_actual[repl] = actual_table
    for actual_table, cte_alias in cte_table_aliases.items():
        replacement_to_actual[cte_alias] = actual_table

    # 3. Extract user-defined CTEs from ORIGINAL sql
    user_cte_info = _extract_user_cte_info(orig_sql)
    user_cte_names = set(user_cte_info.keys())
    known_tables = set(schema_graph.tables.keys()) if schema_graph else set()

    # 4. Build CTE column maps (sequentially so later CTEs can reference earlier)
    user_cte_column_maps: Dict[str, Dict[str, str]] = {}
    for cte_name, cte_body in user_cte_info.items():
        user_cte_column_maps[cte_name] = _build_cte_column_map(
            cte_body, known_tables, all_inv_maps, user_cte_column_maps,
        )

    # 5. Protect string literals
    string_lits: List[str] = []
    def _save(m):
        string_lits.append(m.group(0))
        return f"__STRLIT_{len(string_lits) - 1}__"
    result = re.sub(r"'[^']*'", _save, result)

    # 6. Collect all orig columns that have a rename somewhere
    all_rename_cols: Set[str] = set()
    for inv in all_inv_maps.values():
        for k, v in inv.items():
            if k != v:
                all_rename_cols.add(k)

    # 7. Scope-aware replacement  (process right-to-left to preserve positions)
    for orig_col in sorted(all_rename_cols, key=len, reverse=True):
        # 7a: Quoted identifiers first — avoids turning `` `County Name` `` into
        #     `` `[local]` `` and avoids corrupting already-bracketed names.
        for q_open, q_close in (('[', ']'), ('`', '`'), ('"', '"')):
            qpat = re.escape(q_open + orig_col + q_close)
            qmatches = list(re.finditer(qpat, result, flags=re.IGNORECASE))
            for m in reversed(qmatches):
                rename = _determine_scope_rename(
                    result, m.start(), orig_col,
                    replacement_to_actual, all_inv_maps,
                    user_cte_column_maps, user_cte_names,
                )
                if rename and rename.lower() != orig_col.lower():
                    result = result[:m.start()] + _sqlite_ident(rename) + result[m.end():]

        # 7b: Bare orig_col — not after `.` and not inside `[...]` / `` `...` ``
        pattern = (
            r"(?<![\[`])(?<!\.)"
            + r"\b"
            + re.escape(orig_col)
            + r"\b(?!\s*\()"
        )
        matches = list(re.finditer(pattern, result, flags=re.IGNORECASE))
        for m in reversed(matches):
            rename = _determine_scope_rename(
                result, m.start(), orig_col,
                replacement_to_actual, all_inv_maps,
                user_cte_column_maps, user_cte_names,
            )
            if rename and rename.lower() != orig_col.lower():
                result = result[:m.start()] + _sqlite_ident(rename) + result[m.end():]

    # 8. Fix qualified user-CTE refs:  cte_name.orig_col -> cte_name.renamed_col
    for cte_name, col_map in user_cte_column_maps.items():
        for o, r in sorted(col_map.items(), key=lambda x: len(x[0]), reverse=True):
            if o == r:
                continue
            pat = r'\b' + re.escape(cte_name) + r'\.' + re.escape(o) + r'\b'
            result = re.sub(
                pat, _qual_qualified_col(cte_name, r), result, flags=re.IGNORECASE
            )

    # 9. Fix qualified system-CTE refs:  _cte_X.orig_col -> _cte_X.local_col
    for actual_table, cte_alias in cte_table_aliases.items():
        inv = all_inv_maps.get(actual_table, {})
        for o, lc in sorted(inv.items(), key=lambda x: len(x[0]), reverse=True):
            if o == lc:
                continue
            pat = r'\b' + re.escape(cte_alias) + r'\.' + re.escape(o) + r'\b'
            result = re.sub(
                pat, _qual_qualified_col(cte_alias, lc), result, flags=re.IGNORECASE
            )

    # 10. Fix qualified refs to inline subquery aliases  ( (SELECT ...) AS T3 )
    #     T3.orig_col  →  T3.renamed_col
    alias_to_orig_map = {alias: actual for actual, alias, _ in table_refs}
    known_aliases_set = (
        set(alias_to_orig_map.keys())
        | user_cte_names
        | set(cte_table_aliases.values())
    )
    flat_renames: Dict[str, str] = {}
    for inv in all_inv_maps.values():
        for k, v in inv.items():
            if k != v and k not in flat_renames:
                flat_renames[k] = v

    for orig_col, local_col in sorted(
        flat_renames.items(), key=lambda x: len(x[0]), reverse=True,
    ):
        pat = r'(\b\w+)\.' + re.escape(orig_col) + r'\b'

        def _repl_subq(m, _known=known_aliases_set, _new=local_col):
            prefix = m.group(1)
            if prefix in _known or prefix.upper() in SQL_KEYWORDS:
                return m.group(0)
            return _qual_qualified_col(prefix, _new)

        result = re.sub(pat, _repl_subq, result, flags=re.IGNORECASE)

    # 11. Restore string literals
    for i, lit in enumerate(string_lits):
        result = result.replace(f"__STRLIT_{i}__", lit)

    return result


def _propagate_column_renames(
    sql: str,
    alias_to_orig: Dict[str, str],
    orig_to_local_entries: Dict[str, List],
) -> str:
    """
    Propagation pass: fix CTE and subquery alias column references.

    After the main rewrite, columns inside CTEs/subqueries are renamed,
    but outer references like `cte_name.orig_col` or `subquery_alias.orig_col`
    still use old names. This pass catches those.

    Strategy:
    1. Collect ALL column renames (orig_col -> local_col) from all tables.
    2. For any remaining qualified reference `WORD.orig_col` where WORD is NOT
       a known table alias (already handled), replace with `WORD.local_col`.
    3. For any remaining unqualified `orig_col` not preceded by a dot,
       replace with `local_col`.
    """
    # Collect all column renames
    all_renames = {}  # orig_col -> local_col
    for orig_table, entries in orig_to_local_entries.items():
        if not entries:
            continue
        inv_map = _get_inverse_column_map(orig_table, entries)
        for orig_col, local_col in inv_map.items():
            if orig_col != local_col and orig_col not in all_renames:
                all_renames[orig_col] = local_col

    if not all_renames:
        return sql

    def _extract_cte_names(s: str) -> Set[str]:
        """
        Extract CTE names from a leading WITH clause.
        Best-effort: captures names in patterns like:
          WITH cte AS (...), other AS (...) SELECT ...
        """
        names: Set[str] = set()
        if not re.match(r'^\s*WITH\s+', s, re.IGNORECASE):
            return names
        # Capture identifiers followed by AS (
        for m in re.finditer(r'(?i)\bWITH\b|\b([A-Za-z_]\w*)\s+AS\s*\(', s):
            if m.group(1):
                names.add(m.group(1))
        return names

    known_aliases = set(alias_to_orig.keys()) | _extract_cte_names(sql)

    # Protect string literals by temporarily replacing them
    string_literals = []
    def _save_string(m):
        string_literals.append(m.group(0))
        return f"__STR_PLACEHOLDER_{len(string_literals) - 1}__"

    result = re.sub(r"'[^']*'", _save_string, sql)

    # Pass 1: Replace qualified references (CTE/subquery aliases)
    for orig_col, local_col in sorted(
        all_renames.items(), key=lambda x: len(x[0]), reverse=True
    ):
        # Don't skip renaming even if column name matches a SQL keyword
        # Column names that happen to match keywords should still be renamed

        # Match: WORD.orig_col where WORD is not a known table alias
        pattern = r'(\b\w+)\.' + re.escape(orig_col) + r'\b'

        def _replace_if_not_alias(m, known=known_aliases, new_col=local_col):
            prefix = m.group(1)
            if prefix in known:
                return m.group(0)  # Already handled by main rewrite
            return _qual_qualified_col(prefix, new_col)

        result = re.sub(pattern, _replace_if_not_alias, result, flags=re.IGNORECASE)

    # Pass 2: Replace unqualified references (inside CTE/subquery scopes)
    for orig_col, local_col in sorted(
        all_renames.items(), key=lambda x: len(x[0]), reverse=True
    ):
        # 2a: Whole quoted identifiers first so we do not leave `` `County Name` `` for
        #     unqualified pass to corrupt into `` `[County Name_1]` `` (invalid nesting).
        for q_open, q_close in (('[', ']'), ('`', '`'), ('"', '"')):
            quoted_orig = q_open + orig_col + q_close
            result = re.sub(
                re.escape(quoted_orig), _sqlite_ident(local_col), result, flags=re.IGNORECASE
            )
        # 2b: Bare orig_col — must NOT match inside bracketed / backtick identifiers
        #     (e.g. [County Name_1] contains substring "County Name" before _1).
        pattern = (
            r"(?<![\[`])(?<!\.)"
            + r"\b"
            + re.escape(orig_col)
            + r"\b(?!\s*\()"
        )
        result = re.sub(pattern, _sqlite_ident(local_col), result, flags=re.IGNORECASE)

    # Restore string literals
    for i, literal in enumerate(string_literals):
        result = result.replace(f"__STR_PLACEHOLDER_{i}__", literal)

    return result


def _build_row_partition_cte(
    original_table: str,
    entries: List[Tuple[str, object]],
    schema_graph: SchemaGraph,
) -> str:
    """
    Build a CTE that UNIONs F row partition fragments.

    Uses UNION (distinct) when the partition has row overlap, UNION ALL otherwise.
    The CTE exposes columns with LOCAL names.
    """
    parts = []
    has_overlap = any(
        getattr(t, "row_partition_has_overlap", False)
        for _lt, t in entries
        if getattr(t, "is_row_partition", False)
    )
    for lt_name, transform in entries:
        if not transform.is_row_partition:
            continue
        col_list = ", ".join(f"[{local_col}]" for local_col in transform.column_map.keys())
        parts.append(f"SELECT {col_list} FROM [{lt_name}]")

    joiner = "\nUNION\n" if has_overlap else "\nUNION ALL\n"
    return joiner.join(parts)


def _build_vertical_row_combined_cte(
    original_table: str,
    entries: List[Tuple[str, object]],
    schema_graph: SchemaGraph,
) -> Tuple[str, List[object]]:
    """
    Vertical split where at least one column fragment is also row-partitioned:
    per vertical_fragment_suffix, UNION ALL row parts or a single table, then
    JOIN groups on PK (same row universe as original SQLite).
    """
    groups: Dict[str, List[Tuple[str, object]]] = defaultdict(list)
    for lt, tr in entries:
        if not getattr(tr, "is_vertical_split_fragment", False):
            continue
        suf = getattr(tr, "vertical_fragment_suffix", None) or ""
        groups[suf].append((lt, tr))

    suf_order = sorted(groups.keys())
    aliases = [f"t{i}" for i in range(len(suf_order))]
    reps: List[object] = []
    from_clauses: List[str] = []

    for i, suf in enumerate(suf_order):
        ge = groups[suf]
        row_parts = sorted([(lt, tr) for lt, tr in ge if tr.is_row_partition], key=lambda x: x[0])
        single = [(lt, tr) for lt, tr in ge if not tr.is_row_partition]
        if len(row_parts) >= 2:
            uni = []
            ot_src = row_parts[0][1].source_table
            for lt, tr in row_parts:
                cols = _fragment_union_select_list_sql(
                    ot_src, tr, schema_graph, federated=False
                )
                uni.append(f"SELECT {cols} FROM [{lt}]")
            has_overlap = any(
                getattr(tr, "row_partition_has_overlap", False) for _lt, tr in row_parts
            )
            joiner = "\nUNION\n" if has_overlap else "\nUNION ALL\n"
            from_clauses.append("(\n" + joiner.join(uni) + f"\n) {aliases[i]}")
            reps.append(row_parts[0][1])
        elif single:
            lt, tr = single[0]
            from_clauses.append(f"[{lt}] {aliases[i]}")
            reps.append(tr)
        else:
            raise ValueError(
                f"Combined vertical+row CTE for [{original_table}] fragment {suf!r} has no transforms."
            )

    pk_pairs = _vertical_pk_join_columns(original_table, reps, schema_graph)
    select_parts = _vertical_split_select_clause_parts(
        original_table, [(None, tr) for tr in reps], schema_graph
    )
    out = f"SELECT {', '.join(select_parts)}\nFROM {from_clauses[0]}"
    for i in range(1, len(from_clauses)):
        jc = " AND ".join(
            # NULL-safe join: required for losslessness on real-world data where
            # declared PK columns can still contain NULLs.
            f"{aliases[0]}.[{loc_names[0]}] IS {aliases[i]}.[{loc_names[i]}]"
            for _pk, loc_names in pk_pairs
        )
        out += f"\nJOIN {from_clauses[i]} ON {jc}"
    return out, reps


def _build_federated_vertical_row_combined_cte_multi(
    all_entries: List[Tuple[str, str, object]],
    schema_graph: SchemaGraph,
) -> Tuple[str, List[object]]:
    """Federated variant of _build_vertical_row_combined_cte (qualified local DB names)."""
    groups: Dict[str, List[Tuple[str, str, object]]] = defaultdict(list)
    for ln, lt, tr in all_entries:
        if not getattr(tr, "is_vertical_split_fragment", False):
            continue
        suf = getattr(tr, "vertical_fragment_suffix", None) or ""
        groups[suf].append((ln, lt, tr))

    suf_order = sorted(groups.keys())
    aliases = [f"t{i}" for i in range(len(suf_order))]
    reps: List[object] = []
    from_clauses: List[str] = []

    for i, suf in enumerate(suf_order):
        ge = groups[suf]
        row_parts = sorted(
            [(ln, lt, tr) for ln, lt, tr in ge if tr.is_row_partition],
            key=lambda x: (x[0], x[1]),
        )
        single = [(ln, lt, tr) for ln, lt, tr in ge if not tr.is_row_partition]
        if len(row_parts) >= 2:
            uni = []
            ot_src = row_parts[0][2].source_table
            for ln, lt, tr in row_parts:
                cols = _fragment_union_select_list_sql(
                    ot_src, tr, schema_graph, federated=True, local_name=ln, lt_name=lt
                )
                # Carry stable original row id for reconstruction joins.
                uni.append(f"SELECT [{lt}].[__orig_rowid] AS __orig_rowid, {cols} FROM [{ln}].[{lt}]")
            has_overlap = any(
                getattr(tr, "row_partition_has_overlap", False) for _ln, _lt, tr in row_parts
            )
            joiner = "\nUNION\n" if has_overlap else "\nUNION ALL\n"
            from_clauses.append("(\n" + joiner.join(uni) + f"\n) {aliases[i]}")
            reps.append(row_parts[0][2])
        elif single:
            ln, lt, tr = single[0]
            from_clauses.append(f"[{ln}].[{lt}] {aliases[i]}")
            reps.append(tr)
        else:
            raise ValueError(
                f"Federated combined vertical+row CTE fragment {suf!r} has no transforms."
            )

    orig_tbl = reps[0].source_table
    pk_pairs = _vertical_pk_join_columns(orig_tbl, reps, schema_graph)
    select_parts = _vertical_split_select_clause_parts(
        orig_tbl, [(None, tr) for tr in reps], schema_graph
    )
    # Join vertical fragments using propagated original rowid (`__orig_rowid`) for
    # stable, lossless pairing even when PK columns are NULL/duplicated.
    out = f"SELECT {', '.join(select_parts)}\nFROM {from_clauses[0]}"
    for i in range(1, len(from_clauses)):
        jc = f"{aliases[0]}.[__orig_rowid] = {aliases[i]}.[__orig_rowid]"
        out += f"\nJOIN {from_clauses[i]} ON {jc}"
    return out, reps


def _vertical_pk_join_columns(
    original_table: str,
    transforms: List[object],
    schema_graph: SchemaGraph,
) -> List[Tuple[str, List[str]]]:
    """
    PK join columns for vertical-split reconstruction.

    DO NOT use intersection-of-local-columns: overlap can duplicate non-PK columns
    across fragments, and using them in JOIN predicates filters rows and breaks
    losslessness. Instead, join only on the original table's declared PK columns.

    Returns a list of (pk_original_name, [pk_local_name_per_transform]).
    """
    pk_orig = []
    try:
        pk_orig = list(schema_graph.tables[original_table].primary_keys or [])
    except Exception:
        pk_orig = []
    if not pk_orig:
        # Best-effort fallback: if no declared PK, do NOT join on intersection-of-local
        # columns (too restrictive; filters rows when nullable columns differ/NULL).
        # Instead, join on a small set of original columns that appear in *every*
        # fragment (these are the duplicated "key" columns introduced by our splitter).
        common_orig = None
        for t in transforms:
            vals = set((t.column_map or {}).values())
            common_orig = vals if common_orig is None else (common_orig & vals)
        if not common_orig:
            return []

        schema_order = [c.name for c in schema_graph.tables[original_table].columns]
        ordered = [c for c in schema_order if c in common_orig]
        # Keep the join predicate small/stable.
        ordered = ordered[:2]

        out: List[Tuple[str, List[str]]] = []
        for oc in ordered:
            local_names: List[str] = []
            for t in transforms:
                found = None
                for lc, mapped_oc in (t.column_map or {}).items():
                    if mapped_oc == oc:
                        found = lc
                        break
                if found is None:
                    return []
                local_names.append(found)
            out.append((oc, local_names))
        return out

    out: List[Tuple[str, List[str]]] = []
    for pk in pk_orig:
        local_names: List[str] = []
        for t in transforms:
            found = None
            for lc, oc in t.column_map.items():
                if oc == pk:
                    found = lc
                    break
            if found is None:
                raise ValueError(
                    f"Vertical split CTE for [{original_table}]: PK column [{pk}] missing from a fragment."
                )
            local_names.append(found)
        out.append((pk, local_names))
    return out


def _single_fragment_vertical_select_expressions(
    original_table: str,
    transform: object,
    schema_graph: SchemaGraph,
) -> List[str]:
    """One SELECT expression per original column in **schema column order** (local names)."""
    # Invert local->orig mapping into orig->local. Some pipelines may record
    # orig column ids with a `table.` prefix; normalize keys so schema columns
    # like `Reputation` can still be found.
    inv_raw = {v: k for k, v in transform.column_map.items()}
    inv: Dict[str, str] = {}
    for oc, lc in inv_raw.items():
        inv.setdefault(str(oc), lc)
        if isinstance(oc, str) and "." in oc:
            inv.setdefault(oc.split(".")[-1], lc)
    inv_lc = {k.lower(): v for k, v in inv.items()}
    orig_cols = [c.name for c in schema_graph.tables[original_table].columns]
    out: List[str] = []
    for oc in orig_cols:
        lc = inv.get(oc) or inv_lc.get(str(oc).lower())
        if not lc:
            # If a column is genuinely absent from this transform, selecting it would
            # be invalid SQL. Emit NULL placeholder to keep column alignment.
            out.append(f"NULL AS [{oc}]")
        else:
            out.append(f"[{lc}]")
    return out


def _fragment_union_select_list_sql(
    original_table: str,
    transform: object,
    schema_graph: SchemaGraph,
    *,
    federated: bool,
    local_name: Optional[str] = None,
    lt_name: Optional[str] = None,
) -> str:
    """
    Comma-separated column list for one arm of UNION ALL over row fragments of the
    same vertical slice. Uses **schema column order** so both partitions align.
    """
    inv_raw = {v: k for k, v in transform.column_map.items()}
    inv: Dict[str, str] = {}
    for oc, lc in inv_raw.items():
        inv.setdefault(str(oc), lc)
        if isinstance(oc, str) and "." in oc:
            inv.setdefault(oc.split(".")[-1], lc)
    inv_lc = {k.lower(): v for k, v in inv.items()}
    orig_cols = [c.name for c in schema_graph.tables[original_table].columns]
    parts: List[str] = []
    for oc in orig_cols:
        lc = inv.get(oc) or inv_lc.get(str(oc).lower())
        if not lc:
            continue
        if federated and local_name is not None and lt_name is not None:
            parts.append(f"[{local_name}].[{lt_name}].[{lc}]")
        else:
            parts.append(f"[{lc}]")
    return ", ".join(parts)


def _vertical_split_select_clause_parts(
    original_table: str,
    frags: List[Tuple[object, object]],
    schema_graph: SchemaGraph,
) -> List[str]:
    """
    Build SELECT list entries for vertical-split JOIN: one expression per original column
    in **schema table column order** (required for INSERT...SELECT and DDL alignment).

    When the same logical column appears in multiple fragments (overlap), the first
    fragment in join order that contains the column wins (same as reconstruct.py).
    frags: (unused_table_name, transform) per alias t0, t1, ...
    """
    orig_tbl = schema_graph.tables.get(original_table)
    if orig_tbl is None:
        raise ValueError(f"Unknown table [{original_table}] for vertical split SELECT")
    orig_cols = [c.name for c in orig_tbl.columns]
    pk_cols = set(orig_tbl.primary_keys or [])

    transforms = [tr for _lt, tr in frags]
    col_sets = [set(tr.column_map.values()) for tr in transforms]
    inv_maps: List[Dict[str, str]] = []
    inv_maps_lc: List[Dict[str, str]] = []
    for tr in transforms:
        inv_raw = {v: k for k, v in tr.column_map.items()}
        inv: Dict[str, str] = {}
        for oc, lc in inv_raw.items():
            inv.setdefault(str(oc), lc)
            if isinstance(oc, str) and "." in oc:
                inv.setdefault(oc.split(".")[-1], lc)
        inv_maps.append(inv)
        inv_maps_lc.append({k.lower(): v for k, v in inv.items()})
    aliases = [f"t{i}" for i in range(len(frags))]

    def _pick_fragment_index(oc: str) -> int:
        if oc in pk_cols:
            return 0
        for i, cs in enumerate(col_sets):
            if oc in cs:
                return i
        return 0

    parts: List[str] = []
    for oc in orig_cols:
        fi = _pick_fragment_index(oc)
        inv = inv_maps[fi]
        inv_lc = inv_maps_lc[fi]
        lc = inv.get(oc) or inv_lc.get(str(oc).lower())
        # If a column isn't in any fragment (unexpected), fall back to alias0 raw.
        if not lc:
            lc = oc
        parts.append(f"{aliases[fi]}.[{lc}]")
    return parts


def _build_vertical_split_cte(
    original_table: str,
    entries: List[Tuple[str, object]],
    schema_graph: SchemaGraph,
) -> str:
    """
    Build a CTE that JOINs N vertical (column) fragments on shared PK columns.
    """
    frags = [(lt_name, t) for lt_name, t in entries if t.is_vertical_split_fragment]
    frags.sort(key=lambda x: x[0])
    if len(frags) < 2:
        lt_name, transform = entries[0]
        ot = transform.source_table
        exprs = _single_fragment_vertical_select_expressions(ot, transform, schema_graph)
        col_list = ", ".join(exprs)
        return f"SELECT {col_list} FROM [{lt_name}]"

    transforms = [t for _, t in frags]
    pk_pairs = _vertical_pk_join_columns(original_table, transforms, schema_graph)
    if not pk_pairs:
        raise ValueError(
            f"Vertical split CTE for [{original_table}]: no shared columns across fragments."
        )

    select_parts = _vertical_split_select_clause_parts(original_table, frags, schema_graph)

    from_parts = [f"[{frags[0][0]}] t0"]
    for i in range(1, len(frags)):
        lt_nm = frags[i][0]
        jc = " AND ".join(
            f"t0.[{locals_for_pk[0]}] = t{i}.[{locals_for_pk[i]}]"
            for _pk, locals_for_pk in pk_pairs
        )
        from_parts.append(f"JOIN [{lt_nm}] t{i} ON {jc}")

    return f"SELECT {', '.join(select_parts)}\nFROM " + "\n".join(from_parts)


# ──────────────────────────────────────────────
# Cross-local federated query builder
# ──────────────────────────────────────────────

def _build_federated_query(
    sql: str,
    table_refs: List[Tuple[str, str, str]],
    locals_list: List[LocalSchema],
    table_to_local_map: Dict[str, Set[str]],
    table_to_local_schema: Dict[str, LocalSchema],
    schema_graph: SchemaGraph,
    table_locals_override: Optional[Dict[str, Set[str]]] = None,
) -> Tuple[str, List[str]]:
    """
    Build a federated query that uses ATTACH DATABASE syntax to reference
    tables across multiple locals using local table/column names.

    Returns (federated_sql, list_of_attach_statements).
    """
    alias_to_orig = {}
    for actual_table, alias, raw_table in table_refs:
        alias_to_orig[alias] = actual_table

    def _effective_locals_for_table(orig: str) -> Set[str]:
        if table_locals_override and orig in table_locals_override:
            return set(table_locals_override[orig])
        return set(table_to_local_map.get(orig, set()))

    # Figure out which locals are involved (fragment-aware when override is set)
    locals_involved = set()
    for actual_table, _, _ in table_refs:
        locals_involved.update(_effective_locals_for_table(actual_table))

    # Generate ATTACH statements
    attach_stmts = []
    for local_name in sorted(locals_involved):
        attach_stmts.append(f"ATTACH DATABASE '{local_name}.sqlite' AS [{local_name}];")

    # Get local entries for each original table
    # A table may have fragments in multiple locals
    orig_to_local_entries = {}
    for actual_table, _, _ in table_refs:
        local_names = _effective_locals_for_table(actual_table)
        entries_list = []
        for local_name in local_names:
            local_schema = next((l for l in locals_list if l.local_name == local_name), None)
            if local_schema:
                entries = _get_local_table_info(actual_table, local_schema)
                if entries:
                    entries_list.append((local_name, entries))
        if entries_list:
            orig_to_local_entries[actual_table] = entries_list

    result = sql

    # Build CTEs for split/partitioned tables
    ctes = []
    cte_table_aliases = {}
    system_cte_col_maps: Dict[str, Dict[str, str]] = {}

    for actual_table, entries_list in orig_to_local_entries.items():
        # Collect all entries across all locals for this table
        all_entries = []
        for local_name, entries in entries_list:
            all_entries.extend([(local_name, lt_name, transform) for lt_name, transform in entries])
        
        has_row_partition = any(e[2].is_row_partition for e in all_entries)
        has_vsplit = any(e[2].is_vertical_split_fragment for e in all_entries)

        if has_row_partition and has_vsplit:
            cte_alias = f"_cte_{actual_table.lower()}"
            cte_sql, rep_trs = _build_federated_vertical_row_combined_cte_multi(
                all_entries, schema_graph
            )
            ctes.append((cte_alias, cte_sql))
            cte_table_aliases[actual_table] = cte_alias
            system_cte_col_maps[actual_table] = _vertical_split_merged_orig_to_output_local(
                rep_trs
            )
        elif has_row_partition and len(all_entries) >= 2:
            cte_alias = f"_cte_{actual_table.lower()}"
            cte_sql = _build_federated_row_partition_cte_multi(all_entries)
            ctes.append((cte_alias, cte_sql))
            cte_table_aliases[actual_table] = cte_alias
            rp_first = next(
                (tr for ln, lt, tr in all_entries if tr.is_row_partition), None
            )
            if rp_first:
                system_cte_col_maps[actual_table] = {
                    oc: lc for lc, oc in rp_first.column_map.items()
                }
        elif has_vsplit and len(all_entries) >= 2:
            cte_alias = f"_cte_{actual_table.lower()}"
            cte_sql = _build_federated_vertical_split_cte_multi(all_entries, schema_graph)
            ctes.append((cte_alias, cte_sql))
            cte_table_aliases[actual_table] = cte_alias
            trs = _ordered_vertical_transforms_federated(all_entries)
            system_cte_col_maps[actual_table] = _vertical_split_merged_orig_to_output_local(trs)

    # Build table replacement map (ALL occurrences)
    table_replacements = {}
    for actual_table, alias, raw_table in table_refs:
        entries_list = orig_to_local_entries.get(actual_table)
        if not entries_list:
            continue

        if actual_table in cte_table_aliases:
            table_replacements[raw_table] = cte_table_aliases[actual_table]
        else:
            # Use the first local/table we find
            local_name, entries = entries_list[0]
            if entries:
                lt_name = entries[0][0]
                table_replacements[raw_table] = f"[{local_name}].[{lt_name}]"

    # Replace ALL occurrences of table names in FROM/JOIN
    for raw_table in sorted(table_replacements.keys(), key=len, reverse=True):
        replacement = table_replacements[raw_table]
        result = re.sub(
            r'(\b(?:FROM|JOIN)\s+)' + re.escape(raw_table) + r'\b',
            r'\g<1>' + replacement,
            result,
            flags=re.IGNORECASE,
        )

    # Heuristic fix for single-table subqueries without aliases:
    # If a subquery selects from a single local table with no alias, and the selected column
    # got rewritten to an FK-ish name that doesn't exist on that table, SQLite may silently
    # bind it as an outer correlated reference (causing huge result blowups).
    # We patch the common "drivers" case here: pilot_info PK is driverId.
    result = re.sub(
        r'(?is)(SELECT\s+)(driver_ref)(\s+FROM\s+\[[^\]]+\]\.\[pilot_info\]\b)',
        r'\1driverId\3',
        result,
    )

    # Replace qualified column references (merge all fragment maps)
    for actual_table, alias, raw_table in table_refs:
        entries_list = orig_to_local_entries.get(actual_table)
        if not entries_list:
            continue
        # Flatten all entries from all locals
        all_entries_flat = []
        for local_name, entries in entries_list:
            all_entries_flat.extend(entries)
        entries = all_entries_flat
        if not entries:
            continue

        physical = _physical_qualifier_federated(
            actual_table, orig_to_local_entries, cte_table_aliases,
        )
        if not physical:
            continue

        qual = _column_qualifier_prefix(alias, raw_table, physical)

        inv_col_map = _prune_prefix_orig_column_keys(
            dict(system_cte_col_maps.get(actual_table) or _get_inverse_column_map(actual_table, entries))
        )
        sorted_cols = sorted(inv_col_map.items(), key=lambda x: len(x[0]), reverse=True)

        for orig_col, local_col in sorted_cols:
            if orig_col == local_col:
                continue
            end_anchor = r"\b" if re.match(r"^[A-Za-z0-9_]+$", orig_col) else r"(?![A-Za-z0-9_])"
            pattern = r"\b" + re.escape(alias) + r"\." + re.escape(orig_col) + end_anchor
            replacement = _qual_qualified_col(qual, local_col)
            result = re.sub(pattern, replacement, result, flags=re.IGNORECASE)
            for q_open, q_close in (('[', ']'), ('`', '`'), ('"', '"')):
                quoted_orig = q_open + orig_col + q_close
                pattern_quoted = r'\b' + re.escape(alias) + r'\.' + re.escape(quoted_orig)
                result = re.sub(pattern_quoted, replacement, result, flags=re.IGNORECASE)

    # Scope-aware unqualified column rename + CTE propagation
    result = _scope_aware_unqualified_rename(
        result, sql, table_refs, table_replacements, cte_table_aliases,
        orig_to_local_entries, schema_graph, system_cte_col_maps=system_cte_col_maps,
    )

    # Prepend CTEs - if the original query already has WITH, inject ours FIRST
    # so that any original CTEs can reference our CTEs (e.g., time_in_seconds uses _cte_results).
    if ctes:
        cte_parts = [f"{cte_alias} AS (\n{cte_sql}\n)" for cte_alias, cte_sql in ctes]

        if re.match(r'^\s*WITH\s+', result, re.IGNORECASE):
            # Inject right after WITH keyword
            injected = "WITH " + ",\n".join(cte_parts) + ",\n"
            result = re.sub(r'^\s*WITH\s+', injected, result, flags=re.IGNORECASE)
        else:
            cte_prefix = "WITH " + ",\n".join(cte_parts) + "\n"
            result = cte_prefix + result

    return result, attach_stmts


def _build_federated_row_partition_cte(local_name: str, entries):
    """Build a CTE for row partitions with qualified table names.

    Uses UNION (distinct) when any fragment has row overlap, UNION ALL otherwise.
    """
    parts = []
    has_overlap = any(
        getattr(t, "row_partition_has_overlap", False)
        for _lt, t in entries
        if getattr(t, "is_row_partition", False)
    )
    for lt_name, transform in entries:
        if not transform.is_row_partition:
            continue
        col_list = ", ".join(f"[{local_col}]" for local_col in transform.column_map.keys())
        parts.append(f"SELECT {col_list} FROM [{local_name}].[{lt_name}]")
    joiner = "\nUNION\n" if has_overlap else "\nUNION ALL\n"
    return joiner.join(parts)


def _build_federated_vertical_split_cte(
    local_name: str,
    entries,
    schema_graph: SchemaGraph,
):
    """Build a CTE for vertical splits with qualified table names (single local)."""
    frags = [(lt_name, t) for lt_name, t in entries if t.is_vertical_split_fragment]
    frags.sort(key=lambda x: x[0])
    if len(frags) < 2:
        lt_name, transform = entries[0]
        ot = transform.source_table
        inv_raw = {v: k for k, v in transform.column_map.items()}
        inv: Dict[str, str] = {}
        for oc, lc in inv_raw.items():
            inv.setdefault(str(oc), lc)
            if isinstance(oc, str) and "." in oc:
                inv.setdefault(oc.split(".")[-1], lc)
        inv_lc = {k.lower(): v for k, v in inv.items()}
        orig_cols = [c.name for c in schema_graph.tables[ot].columns]
        exprs: List[str] = []
        for oc in orig_cols:
            lc = inv.get(oc) or inv_lc.get(str(oc).lower())
            if not lc:
                exprs.append(f"NULL AS [{oc}]")
            else:
                exprs.append(f"[{local_name}].[{lt_name}].[{lc}]")
        col_list = ", ".join(exprs)
        return f"SELECT {col_list} FROM [{local_name}].[{lt_name}]"

    transforms = [t for _, t in frags]
    # entries are for one original table within a single local
    original_table = entries[0][1].source_table
    pk_pairs = _vertical_pk_join_columns(original_table, transforms, schema_graph)
    select_parts = _vertical_split_select_clause_parts(original_table, frags, schema_graph)

    parts = [f"[{local_name}].[{frags[0][0]}] t0"]
    for i in range(1, len(frags)):
        lt_nm = frags[i][0]
        jc = " AND ".join(
            f"t0.[{locals_for_pk[0]}] = t{i}.[{locals_for_pk[i]}]"
            for _pk, locals_for_pk in pk_pairs
        )
        parts.append(f"JOIN [{local_name}].[{lt_nm}] t{i} ON {jc}")

    return f"SELECT {', '.join(select_parts)}\nFROM " + "\n".join(parts)


def _build_federated_row_partition_cte_multi(all_entries):
    """
    Build a CTE for row partitions that may span multiple locals.

    Uses UNION (distinct) when any fragment has row overlap, UNION ALL otherwise.

    Args:
        all_entries: List of (local_name, lt_name, transform) tuples
    """
    parts = []
    has_overlap = any(
        getattr(t, "row_partition_has_overlap", False)
        for _ln, _lt, t in all_entries
        if getattr(t, "is_row_partition", False)
    )
    for local_name, lt_name, transform in all_entries:
        if not transform.is_row_partition:
            continue
        col_list = ", ".join(f"[{local_col}]" for local_col in transform.column_map.keys())
        parts.append(f"SELECT {col_list} FROM [{local_name}].[{lt_name}]")
    joiner = "\nUNION\n" if has_overlap else "\nUNION ALL\n"
    return joiner.join(parts)


def _build_federated_vertical_split_cte_multi(all_entries, schema_graph: SchemaGraph):
    """
    Build a CTE for vertical splits that may span multiple locals.

    Args:
        all_entries: List of (local_name, lt_name, transform) tuples
    """
    frags = [
        (local_name, lt_name, t)
        for local_name, lt_name, t in all_entries
        if t.is_vertical_split_fragment
    ]
    frags.sort(key=lambda x: (x[0], x[1]))
    if len(frags) < 2:
        local_name, lt_name, transform = all_entries[0]
        ot = transform.source_table
        inv_raw = {v: k for k, v in transform.column_map.items()}
        inv: Dict[str, str] = {}
        for oc, lc in inv_raw.items():
            inv.setdefault(str(oc), lc)
            if isinstance(oc, str) and "." in oc:
                inv.setdefault(oc.split(".")[-1], lc)
        inv_lc = {k.lower(): v for k, v in inv.items()}
        orig_cols = [c.name for c in schema_graph.tables[ot].columns]
        exprs: List[str] = []
        for oc in orig_cols:
            lc = inv.get(oc) or inv_lc.get(str(oc).lower())
            if not lc:
                exprs.append(f"NULL AS [{oc}]")
            else:
                exprs.append(f"[{local_name}].[{lt_name}].[{lc}]")
        col_list = ", ".join(exprs)
        return f"SELECT {col_list} FROM [{local_name}].[{lt_name}]"

    transforms = [t for _, _, t in frags]
    original_table = frags[0][2].source_table
    pk_pairs = _vertical_pk_join_columns(original_table, transforms, schema_graph)

    select_parts = _vertical_split_select_clause_parts(
        original_table,
        [(_ln, tr) for _ln, _lt, tr in frags],
        schema_graph,
    )

    ln0, lt0, _ = frags[0]
    parts = [f"[{ln0}].[{lt0}] t0"]
    for i in range(1, len(frags)):
        ln_i, lt_i, _ = frags[i]
        jc = " AND ".join(
            f"t0.[{locals_for_pk[0]}] = t{i}.[{locals_for_pk[i]}]"
            for _pk, locals_for_pk in pk_pairs
        )
        parts.append(f"JOIN [{ln_i}].[{lt_i}] t{i} ON {jc}")

    return f"SELECT {', '.join(select_parts)}\nFROM " + "\n".join(parts)


# ──────────────────────────────────────────────
# Validation: run rewritten queries on local DBs
# ──────────────────────────────────────────────

def _validate_single_local_query(
    original_sql: str,
    rewritten_sql: str,
    original_db_path: str,
    local_db_path: str,
) -> Tuple[bool, str]:
    """
    Validate that the rewritten query on the local DB produces the same
    results as the original query on the original DB.

    Returns (passed, error_message).
    """
    try:
        orig_conn = sqlite3.connect(original_db_path)
        orig_run = stabilize_sqlite_order_by_tiebreaker(orig_conn, original_sql)
        orig_result = orig_conn.execute(orig_run).fetchall()
        orig_conn.close()
    except Exception as e:
        return False, f"Original query error: {e}"

    try:
        local_conn = sqlite3.connect(local_db_path)
        local_run = stabilize_sqlite_order_by_tiebreaker(local_conn, rewritten_sql)
        local_result = local_conn.execute(local_run).fetchall()
        local_conn.close()
    except Exception as e:
        return False, f"Rewritten query error: {e}"

    # Compare results
    has_order_by = has_outer_order_by(original_sql)

    if has_order_by:
        if len(orig_result) != len(local_result):
            return False, f"Row count mismatch: orig={len(orig_result)}, local={len(local_result)}"
        for i, (o, r) in enumerate(zip(orig_result, local_result)):
            if _normalize_row(o) != _normalize_row(r):
                # ORDER BY ties (same manaCost, ruling date, …): order is not
                # guaranteed to match across connections / federated plans.
                if _multiset_results_equal(orig_result, local_result):
                    return True, ""
                return False, f"Row {i} mismatch: orig={o}, local={r}"
        return True, ""
    else:
        orig_sorted = sorted([_normalize_row(r) for r in orig_result], key=_sortable_key)
        local_sorted = sorted([_normalize_row(r) for r in local_result], key=_sortable_key)
        if orig_sorted != local_sorted:
            return False, f"Multiset mismatch: orig has {len(orig_result)} rows, local has {len(local_result)} rows"
        return True, ""


def _validate_federated_query(
    original_sql: str,
    federated_sql: str,
    attach_stmts: List[str],
    original_db_path: str,
    locals_dir: str,
) -> Tuple[bool, str]:
    """
    Validate a federated cross-local query by attaching local DBs.
    """
    try:
        orig_conn = sqlite3.connect(original_db_path)
        orig_run = stabilize_sqlite_order_by_tiebreaker(orig_conn, original_sql)
        orig_result = orig_conn.execute(orig_run).fetchall()
        orig_conn.close()
    except Exception as e:
        return False, f"Original query error: {e}"

    try:
        fed_conn = sqlite3.connect(":memory:")
        for stmt in attach_stmts:
            # Resolve relative paths to locals_dir
            # Handle both 'local_X.sqlite' and "local_X.sqlite" formats
            import re
            # Extract local name from ATTACH statement
            match = re.search(r"ATTACH\s+DATABASE\s+['\"]([^'\"]+)['\"]", stmt, re.IGNORECASE)
            if match:
                db_file = match.group(1)
                # Convert to absolute path
                if not os.path.isabs(db_file):
                    abs_path = os.path.join(locals_dir, db_file)
                else:
                    abs_path = db_file
                # Replace in statement
                resolved_stmt = stmt.replace(db_file, abs_path)
            else:
                resolved_stmt = stmt.replace("'local_", f"'{locals_dir}/local_").replace('"local_', f'"{locals_dir}/local_')
            
            try:
                fed_conn.execute(resolved_stmt)
            except Exception as attach_err:
                return False, f"Failed to attach database: {attach_err}. Statement: {resolved_stmt}"
        
        fed_run = stabilize_sqlite_order_by_tiebreaker(fed_conn, federated_sql)
        fed_result = fed_conn.execute(fed_run).fetchall()
        fed_conn.close()
    except Exception as e:
        return False, f"Federated query error: {e}"

    has_order_by = has_outer_order_by(original_sql)

    if has_order_by:
        if len(orig_result) != len(fed_result):
            return False, f"Row count mismatch: orig={len(orig_result)}, fed={len(fed_result)}"
        for i, (o, r) in enumerate(zip(orig_result, fed_result)):
            if _normalize_row(o) != _normalize_row(r):
                if _multiset_results_equal(orig_result, fed_result):
                    return True, ""
                return False, f"Row {i} mismatch"
        return True, ""
    else:
        orig_sorted = sorted([_normalize_row(r) for r in orig_result], key=_sortable_key)
        fed_sorted = sorted([_normalize_row(r) for r in fed_result], key=_sortable_key)
        if orig_sorted != fed_sorted:
            return False, f"Multiset mismatch: orig={len(orig_result)}, fed={len(fed_result)}"
        return True, ""


def _multiset_results_equal(rows_a: List[tuple], rows_b: List[tuple]) -> bool:
    """True if both result lists are the same multiset of normalized rows."""
    sa = sorted([_normalize_row(r) for r in rows_a], key=_sortable_key)
    sb = sorted([_normalize_row(r) for r in rows_b], key=_sortable_key)
    return sa == sb


def _normalize_row(row):
    normalized = []
    for val in row:
        if val is None:
            normalized.append(None)
        elif isinstance(val, float):
            normalized.append(round(val, 10))
        else:
            normalized.append(str(val))
    return tuple(normalized)


def _sortable_key(row):
    return tuple(
        (0, "") if v is None else (1, str(v))
        for v in row
    )


# ──────────────────────────────────────────────
# Master function: classify, rewrite, validate, save
# ──────────────────────────────────────────────

def classify_and_rewrite_queries(
    queries: List[str],
    query_metadata: List[Dict],
    locals_list: List[LocalSchema],
    transform_spec: TransformSpec,
    schema_graph: SchemaGraph,
    original_db_path: str,
    output_dir: str,
    validate: bool = True,
) -> Dict:
    """
    Main entry point: classify all queries, rewrite single-local ones,
    build federated queries for cross-local ones, validate, and save.

    Args:
        queries: List of original SQL queries.
        query_metadata: List of metadata dicts (question, difficulty, etc.)
        locals_list: List of LocalSchema objects.
        transform_spec: Complete transformation specification.
        schema_graph: Original schema graph.
        original_db_path: Path to original SQLite database.
        output_dir: Output directory for the benchmark instance.
        validate: Whether to validate rewritten queries.

    Returns:
        Summary dict with classification counts and validation results.
    """
    known_tables = set(schema_graph.tables.keys())
    table_to_local_map = _build_table_to_local_map(locals_list)
    table_to_local_schema = _build_table_to_local_schema(locals_list)

    locals_dir = os.path.join(output_dir, "locals")

    # Build local_name -> db_path mapping
    local_db_paths = {}
    for local in locals_list:
        local_db_paths[local.local_name] = os.path.join(
            locals_dir, f"{local.local_name}.sqlite"
        )

    classified = []
    local_queries = defaultdict(list)  # local_name -> list of query entries
    cross_local_queries = []
    
    # Collect validation errors for reporting
    validation_errors = []

    # Stats
    stats = {
        "total": len(queries),
        "single_local": 0,
        "cross_local": 0,
        "rewrite_failed": 0,
        "unknown": 0,
        "single_local_validated": 0,
        "single_local_validation_failed": 0,
        "cross_local_validated": 0,
        "cross_local_validation_failed": 0,
    }

    for i, (sql, meta) in enumerate(zip(queries, query_metadata)):
        table_refs = extract_table_refs(sql, known_tables)
        if not table_refs:
            table_refs = _extract_tables_from_sql(sql, known_tables)
        tables_in_query = list(set(t[0] for t in table_refs))

        legacy_locals_involved: Set[str] = set()
        for tbl in tables_in_query:
            legacy_locals_involved.update(table_to_local_map.get(tbl, set()))

        per_table_locals: Dict[str, Set[str]] = {}
        locals_involved: Set[str] = set()
        if tables_in_query:
            needed_cols = collect_needed_original_columns(sql, table_refs, schema_graph)
            rmap = getattr(transform_spec, "row_partition_map", None) or {}
            fragment_locals, per_table_locals = compute_fragment_aware_locals(
                tables_in_query,
                needed_cols,
                locals_list,
                schema_graph,
                sql=sql,
                row_partition_map=rmap,
            )
            for tbl in tables_in_query:
                if tbl not in per_table_locals:
                    per_table_locals[tbl] = set(table_to_local_map.get(tbl, set()))
            locals_involved = set()
            for s in per_table_locals.values():
                locals_involved |= s
        if not locals_involved and tables_in_query:
            locals_involved = set(legacy_locals_involved)

        query_entry = {
            "query_index": i,
            "original_sql": sql,
            "question": meta.get("question", ""),
            "difficulty": meta.get("difficulty", ""),
            "question_id": meta.get("question_id"),
            "evidence": meta.get("evidence", ""),
            "tables_referenced": sorted(tables_in_query),
            "locals_involved": sorted(locals_involved),
            "legacy_locals_involved": sorted(legacy_locals_involved),
            "per_table_locals_fragment_aware": {
                k: sorted(v) for k, v in sorted(per_table_locals.items())
            },
        }

        if len(locals_involved) == 1:
            # ── Single-local query ──
            local_name = list(locals_involved)[0]
            local_schema = next(l for l in locals_list if l.local_name == local_name)

            try:
                rewritten_sql = _rewrite_query_for_local(
                    sql, table_refs, local_schema, schema_graph
                )
                query_entry["type"] = "single_local"
                query_entry["local"] = local_name
                query_entry["local_sql"] = rewritten_sql
                stats["single_local"] += 1

                # Validate
                if validate and local_name in local_db_paths:
                    try:
                        ok, err = _validate_single_local_query(
                            sql, rewritten_sql, original_db_path,
                            local_db_paths[local_name]
                        )
                        query_entry["validation_passed"] = ok
                        if not ok:
                            query_entry["validation_error"] = err
                            stats["single_local_validation_failed"] += 1
                            validation_errors.append({
                                "query_index": i,
                                "type": "single_local",
                                "error": err,
                                "original_sql": sql,
                                "rewritten_sql": rewritten_sql,
                            })
                        else:
                            stats["single_local_validated"] += 1
                    except Exception as val_err:
                        query_entry["validation_passed"] = False
                        error_msg = f"Validation exception: {val_err}"
                        query_entry["validation_error"] = error_msg
                        stats["single_local_validation_failed"] += 1
                        validation_errors.append({
                            "query_index": i,
                            "type": "single_local",
                            "error": error_msg,
                            "original_sql": sql,
                            "rewritten_sql": rewritten_sql,
                        })

                local_queries[local_name].append(query_entry)

            except Exception as e:
                query_entry["type"] = "single_local_rewrite_failed"
                query_entry["local"] = local_name
                query_entry["rewrite_error"] = str(e)
                stats["rewrite_failed"] += 1

        elif len(locals_involved) > 1:
            # ── Cross-local query ──
            try:
                federated_sql, attach_stmts = _build_federated_query(
                    sql, table_refs, locals_list,
                    table_to_local_map, table_to_local_schema,
                    schema_graph,
                    table_locals_override=per_table_locals,
                )
                query_entry["type"] = "cross_local"
                query_entry["federated_sql"] = federated_sql
                query_entry["attach_statements"] = attach_stmts

                # Per-local table info
                tables_per_local = defaultdict(dict)
                for tbl in tables_in_query:
                    local_names = per_table_locals.get(
                        tbl, table_to_local_map.get(tbl, set())
                    )
                    for local_name in local_names:
                        local_schema = next((l for l in locals_list if l.local_name == local_name), None)
                        if local_schema:
                            entries = _get_local_table_info(tbl, local_schema)
                            for lt_name, _ in entries:
                                tables_per_local[local_name][lt_name] = tbl

                query_entry["tables_per_local"] = dict(tables_per_local)
                stats["cross_local"] += 1

                # Validate federated query - ALWAYS validate if validate=True
                if validate:
                    if federated_sql and federated_sql.strip():
                        try:
                            ok, err = _validate_federated_query(
                                sql, federated_sql, attach_stmts,
                                original_db_path, locals_dir
                            )
                            query_entry["validation_passed"] = ok
                            if not ok:
                                query_entry["validation_error"] = err
                                stats["cross_local_validation_failed"] += 1
                                validation_errors.append({
                                    "query_index": i,
                                    "type": "cross_local",
                                    "error": err,
                                    "original_sql": sql,
                                    "federated_sql": federated_sql,
                                    "attach_statements": attach_stmts,
                                })
                            else:
                                stats["cross_local_validated"] += 1
                        except Exception as val_err:
                            query_entry["validation_passed"] = False
                            error_msg = f"Validation exception: {val_err}"
                            query_entry["validation_error"] = error_msg
                            stats["cross_local_validation_failed"] += 1
                            validation_errors.append({
                                "query_index": i,
                                "type": "cross_local",
                                "error": error_msg,
                                "original_sql": sql,
                                "federated_sql": federated_sql,
                                "attach_statements": attach_stmts,
                            })
                    else:
                        query_entry["validation_passed"] = False
                        error_msg = "No federated SQL generated or empty SQL"
                        query_entry["validation_error"] = error_msg
                        stats["cross_local_validation_failed"] += 1
                        validation_errors.append({
                            "query_index": i,
                            "type": "cross_local",
                            "error": error_msg,
                            "original_sql": sql,
                            "federated_sql": federated_sql or "(None)",
                            "attach_statements": attach_stmts,
                        })
                else:
                    # If validation is disabled, mark as not validated
                    query_entry["validation_passed"] = None

                cross_local_queries.append(query_entry)

            except Exception as e:
                query_entry["type"] = "cross_local"
                query_entry["federated_sql"] = None
                query_entry["federated_error"] = str(e)
                stats["cross_local"] += 1
                
                # Mark as validation failed since we couldn't generate federated SQL
                if validate:
                    query_entry["validation_passed"] = False
                    error_msg = f"Failed to generate federated SQL: {e}"
                    query_entry["validation_error"] = error_msg
                    stats["cross_local_validation_failed"] += 1
                    validation_errors.append({
                        "query_index": i,
                        "type": "cross_local",
                        "error": error_msg,
                        "original_sql": sql,
                        "federated_sql": None,
                        "attach_statements": [],
                    })
                else:
                    query_entry["validation_passed"] = None
                
                cross_local_queries.append(query_entry)

        else:
            query_entry["type"] = "unknown"
            stats["unknown"] += 1

        classified.append(query_entry)

    # ── Save outputs ──
    _save_outputs(classified, local_queries, cross_local_queries,
                  output_dir, locals_list, validation_errors, stats)

    return stats


# ──────────────────────────────────────────────
# Output generation
# ──────────────────────────────────────────────

def _save_outputs(
    classified: List[Dict],
    local_queries: Dict[str, List[Dict]],
    cross_local_queries: List[Dict],
    output_dir: str,
    locals_list: List[LocalSchema],
    validation_errors: List[Dict],
    stats: Dict,
):
    """Save all query outputs to the benchmark instance."""

    queries_dir = os.path.join(output_dir, "queries")
    os.makedirs(queries_dir, exist_ok=True)
    locals_dir = os.path.join(output_dir, "locals")

    # 1. Master classification file
    with open(os.path.join(queries_dir, "all_queries_classified.json"), "w") as f:
        json.dump(classified, f, indent=2, default=str)

    # 2. Per-local query files
    for local in locals_list:
        lname = local.local_name
        lqs = local_queries.get(lname, [])

        # JSON with full metadata
        with open(os.path.join(locals_dir, f"{lname}_queries.json"), "w") as f:
            # Build a clean output for the LLM (without ground truth in the "challenge" version)
            output_entries = []
            for q in lqs:
                output_entries.append({
                    "query_index": q["query_index"],
                    "question": q.get("question", ""),
                    "evidence": q.get("evidence", ""),
                    "difficulty": q.get("difficulty", ""),
                    "local_sql": q.get("local_sql", ""),
                    "original_sql": q.get("original_sql", ""),
                    "validation_passed": q.get("validation_passed"),
                })
            json.dump(output_entries, f, indent=2)

        # SQL file with just the rewritten queries (what the LLM would see)
        with open(os.path.join(locals_dir, f"{lname}_queries.sql"), "w") as f:
            f.write(f"-- Queries for {lname}\n")
            f.write(f"-- These queries run against {lname}.sqlite\n\n")
            for q in lqs:
                q_sql = q.get("local_sql", "")
                if q_sql:
                    question = q.get("question", "")
                    if question:
                        f.write(f"-- Q{q['query_index']}: {question}\n")
                    f.write(q_sql + ";\n\n")

    # 3. Cross-local queries file
    with open(os.path.join(queries_dir, "cross_local_queries.json"), "w") as f:
        output_entries = []
        for q in cross_local_queries:
            output_entries.append({
                "query_index": q["query_index"],
                "question": q.get("question", ""),
                "evidence": q.get("evidence", ""),
                "difficulty": q.get("difficulty", ""),
                "locals_involved": q.get("locals_involved", []),
                "tables_per_local": q.get("tables_per_local", {}),
                "federated_sql": q.get("federated_sql"),
                "attach_statements": q.get("attach_statements", []),
                "original_sql": q.get("original_sql", ""),
                "validation_passed": q.get("validation_passed"),
            })
        json.dump(output_entries, f, indent=2)

    # 4. Federated queries SQL file
    with open(os.path.join(queries_dir, "cross_local_queries.sql"), "w") as f:
        f.write("-- Cross-local (federated) queries\n")
        f.write("-- These queries require ATTACHing multiple local databases\n\n")

        # Collect all needed ATTACH statements
        all_attaches = set()
        for q in cross_local_queries:
            for stmt in q.get("attach_statements", []):
                all_attaches.add(stmt)

        for stmt in sorted(all_attaches):
            f.write(stmt + "\n")
        f.write("\n")

        for q in cross_local_queries:
            q_sql = q.get("federated_sql", "")
            if q_sql:
                question = q.get("question", "")
                locals_inv = q.get("locals_involved", [])
                if question:
                    f.write(f"-- Q{q['query_index']}: {question}\n")
                f.write(f"-- Locals: {', '.join(locals_inv)}\n")
                f.write(q_sql + ";\n\n")

    # 5. Summary stats
    total = len(classified)
    single = sum(1 for q in classified if q.get("type") == "single_local")
    cross = sum(1 for q in classified if q.get("type") == "cross_local")
    failed = sum(1 for q in classified if q.get("type") == "single_local_rewrite_failed")

    legacy_single = sum(
        1 for q in classified if len(q.get("legacy_locals_involved", [])) == 1
    )
    fragment_rescued_single = sum(
        1 for q in classified
        if q.get("type") == "single_local"
        and len(q.get("legacy_locals_involved", [])) > 1
    )

    summary = {
        "total_queries": total,
        "single_local_queries": single,
        "cross_local_queries": cross,
        "rewrite_failures": failed,
        "single_local_queries_legacy_table_union": legacy_single,
        "fragment_aware_single_rescued_from_legacy_multi": fragment_rescued_single,
        "per_local_counts": {
            local.local_name: len(local_queries.get(local.local_name, []))
            for local in locals_list
        },
        "cross_local_by_combination": {},
    }

    # Count cross-local combos
    from collections import Counter
    combos = Counter()
    for q in cross_local_queries:
        combo = tuple(q.get("locals_involved", []))
        combos[combo] += 1
    summary["cross_local_by_combination"] = {
        " + ".join(k): v for k, v in combos.most_common()
    }

    with open(os.path.join(queries_dir, "query_summary.json"), "w") as f:
        json.dump(summary, f, indent=2)
    
    # Save validation errors to file
    if validation_errors:
        errors_file = os.path.join(queries_dir, "validation_errors.json")
        with open(errors_file, "w") as f:
            json.dump({
                "total_errors": len(validation_errors),
                "single_local_errors": len([e for e in validation_errors if e["type"] == "single_local"]),
                "cross_local_errors": len([e for e in validation_errors if e["type"] == "cross_local"]),
                "errors": validation_errors,
            }, f, indent=2)
        print(f"\n  Validation Errors: {len(validation_errors)} errors saved to {errors_file}")

    # Print summary
    print(f"\n  Query Classification Summary:")
    print(f"    Total queries: {total}")
    print(f"    Single-local: {single}")
    print(f"    Cross-local: {cross}")
    if failed:
        print(f"    Rewrite failures: {failed}")
    print(f"    Per-local counts: ", end="")
    for lname, count in summary["per_local_counts"].items():
        print(f"{lname}={count} ", end="")
    print()
    if combos:
        print(f"    Cross-local combos:")
        for combo, count in combos.most_common():
            print(f"      {' + '.join(combo)}: {count} queries")
    
    print(f"\n  Rewrite validation:")
    print(f"    Single-local validated: {stats['single_local_validated']}/{single}")
    print(f"    Single-local validation failed: {stats['single_local_validation_failed']}/{single}")
    print(f"    Cross-local validated: {stats['cross_local_validated']}/{cross}")
    print(f"    Cross-local validation failed: {stats['cross_local_validation_failed']}/{cross}")
    if cross > 0 and stats['cross_local_validated'] == 0 and stats['cross_local_validation_failed'] == 0:
        print(f"    WARNING: {cross} cross-local queries but no validation attempted!")
        print(f"    This suggests validation is not running. Check validation_errors.json for details.")