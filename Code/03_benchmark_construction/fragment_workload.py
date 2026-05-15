from __future__ import annotations

import re
from collections import Counter, defaultdict
from typing import Any, Dict, List, Set, Tuple, Optional

from schema_parser import SchemaGraph

# Sentinel: query needs full logical table (e.g. SELECT *, COUNT(*), or parse failure)
NEED_ALL = "__ALL__"

_SQL_KEYWORDS_SKIP = {
    "select", "where", "from", "join", "on", "group", "order", "by", "having",
    "limit", "offset", "union", "except", "intersect", "case", "when", "then",
    "else", "end", "as", "distinct", "inner", "left", "right", "outer", "cross",
    "natural", "using", "with", "recursive", "true", "false", "null", "is", "not",
    "and", "or", "in", "exists", "between", "like", "escape", "cast", "asc", "desc",
}


def extract_table_refs(sql: str, known_tables: Set[str]) -> List[Tuple[str, str, str]]:
    """Same contract as query_rewriter._extract_tables_from_sql (actual, alias, raw)."""
    refs: List[Tuple[str, str, str]] = []
    seen: Set[Tuple[str, str]] = set()
    table_lower_map = {t.lower(): t for t in known_tables}

    pattern = (
        r"\b(?:FROM|JOIN)\s+"
        r"(\`[^\`]+\`|\[[^\]]+\]|\"[^\"]+\"|[A-Za-z_][\w]*)"
        r"(?:\s+(?:AS\s+)?(\`[^\`]+\`|\[[^\]]+\]|\"[^\"]+\"|[A-Za-z_][\w]*))?"
    )
    for m in re.finditer(pattern, sql, re.IGNORECASE):
        raw_table = m.group(1).strip()
        raw_alias = m.group(2)
        if raw_table.startswith("`") and raw_table.endswith("`"):
            raw_table = raw_table[1:-1]
        elif raw_table.startswith("[") and raw_table.endswith("]"):
            raw_table = raw_table[1:-1]
        elif raw_table.startswith('"') and raw_table.endswith('"'):
            raw_table = raw_table[1:-1]

        if raw_table.lower() in _SQL_KEYWORDS_SKIP:
            continue

        actual_table = table_lower_map.get(raw_table.lower())
        if actual_table is None:
            continue

        if raw_alias:
            a = raw_alias.strip()
            if a.startswith("`") and a.endswith("`"):
                a = a[1:-1]
            elif a.startswith("[") and a.endswith("]"):
                a = a[1:-1]
            elif a.startswith('"') and a.endswith('"'):
                a = a[1:-1]
            if a.lower() in _SQL_KEYWORDS_SKIP:
                raw_alias = None
            else:
                raw_alias = a
        alias = raw_alias if raw_alias else raw_table

        key = (actual_table, alias)
        if key not in seen:
            refs.append((actual_table, alias, raw_table))
            seen.add(key)
    return refs


def _strip_sql_string_literals(sql: str) -> str:
    """Remove single-quoted SQLite string literals (naive; doubled '' escaped)."""
    out: List[str] = []
    i = 0
    n = len(sql)
    while i < n:
        ch = sql[i]
        if ch == "'":
            i += 1
            while i < n:
                if sql[i] == "'" and i + 1 < n and sql[i + 1] == "'":
                    i += 2
                    continue
                if sql[i] == "'":
                    i += 1
                    break
                i += 1
            out.append(" '' ")
            continue
        out.append(ch)
        i += 1
    return "".join(out)


def _table_has_column(tbl, name: str) -> bool:
    if tbl is None:
        return False
    nl = name.lower()
    return any(c.name.lower() == nl for c in tbl.columns)


def collect_needed_original_columns(
    sql: str,
    table_refs: List[Tuple[str, str, str]],
    schema_graph: SchemaGraph,
) -> Dict[str, Set[str]]:
    """
    Best-effort per-original-table column set referenced in the query.
    If uncertain, includes NEED_ALL for that table (conservative).
    """
    tables = {t[0] for t in table_refs}
    needed: Dict[str, Set[str]] = {t: set() for t in tables}
    if not table_refs:
        return needed

    sql2 = _strip_sql_string_literals(sql)

    # SELECT * (whole-table need)
    if re.search(r"\bSELECT\s+\*(?!\s*\()", sql2, re.IGNORECASE):
        if len(tables) == 1:
            needed[next(iter(tables))].add(NEED_ALL)
        else:
            for t in tables:
                needed[t].add(NEED_ALL)

    # Qualified: alias.col
    for orig, alias, _ in table_refs:
        pat = (
            r"\b" + re.escape(alias) + r"\s*\.\s*"
            r"(\`[^\`]+\`|\[[^\]]+\]|\"[^\"]+\"|[A-Za-z_][\w]*)"
        )
        for m in re.finditer(pat, sql2, re.IGNORECASE):
            col = m.group(1)
            if col.startswith("`") and col.endswith("`"):
                col = col[1:-1]
            elif col.startswith("[") and col.endswith("]"):
                col = col[1:-1]
            elif col.startswith('"') and col.endswith('"'):
                col = col[1:-1]
            needed[orig].add(col)

    # Backtick identifiers (common in BIRD): attribute to any table that has that column
    for m in re.finditer(r"\`([^\`]+)\`", sql2):
        tok = m.group(1)
        for orig in tables:
            if _table_has_column(schema_graph.tables.get(orig), tok):
                needed[orig].add(tok)

    # Bracket identifiers
    for m in re.finditer(r"\[([^\]]+)\]", sql2):
        tok = m.group(1).strip()
        if not tok or tok.lower() in _SQL_KEYWORDS_SKIP:
            continue
        for orig in tables:
            if _table_has_column(schema_graph.tables.get(orig), tok):
                needed[orig].add(tok)

    for orig in tables:
        if not needed[orig]:
            needed[orig].add(NEED_ALL)

    return needed


def _orig_columns_in_transform(tr) -> Set[str]:
    cols = set(tr.column_map.values())
    if tr.projected_columns:
        cols |= set(tr.projected_columns)
    return cols


def _find_row_partition_meta(
    source_table: str,
    local_table_names: Set[str],
    row_partition_map: Optional[Dict[str, Dict[str, Any]]],
) -> Optional[Dict[str, Any]]:
    if not row_partition_map:
        return None
    for _k, meta in row_partition_map.items():
        if meta.get("source_table") != source_table:
            continue
        pns = set(meta.get("partition_names") or [])
        if pns & local_table_names:
            return meta
    return None


def _normalize_sql_literal_token(tok: str) -> object:
    t = tok.strip().strip("'\"")
    if t.upper() == "NULL":
        return None
    try:
        if "." in t:
            return float(t)
        return int(t)
    except ValueError:
        return t


def _sql_value_eq_ref(parsed: object, ref: object) -> bool:
    if parsed is None and ref is None:
        return True
    try:
        if isinstance(ref, bool):
            return parsed == ref
        if isinstance(ref, (int, float)):
            return float(parsed) == float(ref)
    except (TypeError, ValueError):
        pass
    return str(parsed) == str(ref)


def _column_eq_rhs_in_sql(sql: str, col: str) -> Optional[str]:
    """First simple equality `col = rhs` (bracketed/backtick/bare)."""
    patterns = [
        rf"\[{re.escape(col)}\]\s*=\s*([^\s\)\],]+)",
        rf"`{re.escape(col)}`\s*=\s*([^\s\)\],]+)",
        rf"(?<![\w.])\b{re.escape(col)}\b\s*=\s*([^\s\)\],]+)",
    ]
    for pat in patterns:
        m = re.search(pat, sql, re.IGNORECASE)
        if m:
            return m.group(1).strip()
    return None


def _column_is_null_in_sql(sql: str, col: str) -> bool:
    patterns = [
        rf"\[{re.escape(col)}\]\s+IS\s+NULL",
        rf"`{re.escape(col)}`\s+IS\s+NULL",
        rf"(?<![\w.])\b{re.escape(col)}\b\s+IS\s+NULL",
    ]
    return any(re.search(p, sql, re.IGNORECASE) for p in patterns)


def _infer_row_partition_branch_indices(
    sql: str,
    predicate_column: str,
    kind: str,
    pvals: List[Any],
) -> Optional[Set[int]]:
    """
    If predicates restrict rows to a single horizontal branch, return {index};
    if ambiguous or full scan implied, return None.
    """
    if not predicate_column or not pvals:
        return None
    col = predicate_column
    kind = str(kind or "")

    if kind == "binary_categorical" and len(pvals) >= 2:
        v0, v1 = pvals[0], pvals[1]
        rhs = _column_eq_rhs_in_sql(sql, col)
        if rhs is not None:
            lit = _normalize_sql_literal_token(rhs)
            if _sql_value_eq_ref(lit, v0):
                return {0}
            if _sql_value_eq_ref(lit, v1):
                return {1}
        if _column_is_null_in_sql(sql, col):
            # Typical second branch: (= v1 OR IS NULL)
            return {1}
        return None

    if kind == "categorical_one_vs_rest" and pvals:
        dominant = pvals[0]
        rhs = _column_eq_rhs_in_sql(sql, col)
        if rhs is not None:
            lit = _normalize_sql_literal_token(rhs)
            if _sql_value_eq_ref(lit, dominant):
                return {0}
        return None

    if kind in ("median_numeric", "median_date") and pvals:
        med = pvals[0]
        # Branch 0: col <= med (non-null handled in predicate); branch 1: > med or NULL
        for pat, idx in (
            (rf"\[{re.escape(col)}\]\s*<=\s*([^\s\)\],]+)", 0),
            (rf"`{re.escape(col)}`\s*<=\s*([^\s\)\],]+)", 0),
            (rf"\[{re.escape(col)}\]\s*>\s*([^\s\)\],]+)", 1),
            (rf"`{re.escape(col)}`\s*>\s*([^\s\)\],]+)", 1),
        ):
            m = re.search(pat, sql, re.IGNORECASE)
            if m:
                lit = _normalize_sql_literal_token(m.group(1))
                if idx == 0 and _sql_value_eq_ref(lit, med):
                    return {0}
                if idx == 1 and _sql_value_eq_ref(lit, med):
                    return {1}
        return None

    return None


def _locals_for_row_partition_branches(
    meta: Dict[str, Any],
    branch_indices: Set[int],
    entries: List[Tuple[str, Any]],
) -> Set[str]:
    """Map branch indices to local schema names using partition_names / locals + live layout."""
    pnames = list(meta.get("partition_names") or [])
    plocs = list(meta.get("partition_locals") or [])
    lt_to_loc: Dict[str, str] = {}
    for ln, tr in entries:
        if tr.is_row_partition:
            lt_to_loc[tr.local_table] = ln
    out: Set[str] = set()
    for i in branch_indices:
        if i < 0 or i >= len(pnames):
            continue
        pn = pnames[i]
        if i < len(plocs) and plocs[i]:
            out.add(plocs[i])
        elif pn in lt_to_loc:
            out.add(lt_to_loc[pn])
    return out


def _narrow_row_partition_locals(
    sql: str,
    source_table: str,
    meta: Dict[str, Any],
    needed_cols: Dict[str, Set[str]],
    entries: List[Tuple[str, Any]],
) -> Optional[Set[str]]:
    """
    When the query references the partition column and predicates single out one branch,
    return only the local(s) hosting that branch; else None (caller unions all branches).
    """
    nc = needed_cols.get(source_table, set())
    if NEED_ALL in nc:
        return None
    pcol = meta.get("predicate_column") or ""
    if not pcol:
        return None
    ncl = {c.lower() for c in nc if c != NEED_ALL}
    if pcol.lower() not in ncl:
        return None
    kind = str(meta.get("predicate_kind") or "")
    pvals = list(meta.get("partition_values") or [])
    branches = _infer_row_partition_branch_indices(sql, pcol, kind, pvals)
    if not branches or len(branches) != 1:
        return None
    locs = _locals_for_row_partition_branches(meta, branches, entries)
    return locs if locs else None


def compute_fragment_aware_locals(
    tables_in_query: List[str],
    needed_cols: Dict[str, Set[str]],
    locals_list,
    schema_graph: SchemaGraph,
    sql: str = "",
    row_partition_map: Optional[Dict[str, Dict[str, Any]]] = None,
) -> Tuple[Set[str], Dict[str, Set[str]]]:
    """
    Returns (union_locals, per_original_table_locals).

    Vertical splits: only locals for fragments whose columns appear in the query (or all
    if NEED_ALL / unresolved).

    Row partitions: union of locals for each horizontal branch **unless** the query
    references the partition column and a single branch can be inferred from predicates;
    then only that branch's local(s) are used.
    """
    per_table: Dict[str, Set[str]] = {}
    all_locals: Set[str] = set()

    for T in tables_in_query:
        entries = []
        for loc in locals_list:
            for _lt, tr in loc.tables.items():
                if tr.source_table == T:
                    entries.append((loc.local_name, tr))

        if not entries:
            continue

        row_entries = [(ln, tr) for ln, tr in entries if tr.is_row_partition]
        non_row_entries = [(ln, tr) for ln, tr in entries if not tr.is_row_partition]

        row_ls: Set[str] = set()
        if row_entries:
            entry_lts = {tr.local_table for _, tr in row_entries}
            meta = _find_row_partition_meta(T, entry_lts, row_partition_map)
            narrowed: Optional[Set[str]] = None
            if meta and sql.strip():
                narrowed = _narrow_row_partition_locals(
                    sql, T, meta, needed_cols, row_entries
                )
            if narrowed is not None:
                row_ls = narrowed
            else:
                row_ls = {ln for ln, _ in row_entries}

        vert_ls: Set[str] = set()
        if non_row_entries:
            is_vsplit_nr = any(tr.is_vertical_split_fragment for _, tr in non_row_entries)
            if not is_vsplit_nr:
                vert_ls = {ln for ln, _ in non_row_entries}
            else:
                nc = needed_cols.get(T, {NEED_ALL})
                if NEED_ALL in nc:
                    vert_ls = {ln for ln, tr in non_row_entries if tr.is_vertical_split_fragment}
                    if not vert_ls:
                        vert_ls = {ln for ln, _ in non_row_entries}
                else:
                    frags_locals: Set[str] = set()
                    missing = set(nc) - {NEED_ALL}
                    for ln, tr in non_row_entries:
                        if not tr.is_vertical_split_fragment:
                            continue
                        ocols = _orig_columns_in_transform(tr)
                        if missing & ocols:
                            frags_locals.add(ln)
                            missing -= ocols
                    if missing:
                        vert_ls = {ln for ln, tr in non_row_entries if tr.is_vertical_split_fragment}
                        if not vert_ls:
                            vert_ls = {ln for ln, _ in non_row_entries}
                    else:
                        vert_ls = frags_locals

        ls = row_ls | vert_ls
        per_table[T] = ls
        all_locals |= ls

    return all_locals, per_table


def vertical_fragment_hit_counts(
    queries: List[str],
    known_tables: Set[str],
    schema_graph: SchemaGraph,
    frag_col_sets: Dict[str, List[Tuple[str, frozenset]]],
    table_pk_columns: Optional[Dict[str, Set[str]]] = None,
) -> Dict[str, Dict[str, int]]:
    """
    orig_table -> local_fragment_table_name -> query count.
    A query counts for a fragment only if it references a **non-PK** column in that
    fragment (or NEED_ALL). If a fragment has no non-PK columns, any column hit counts.
    """
    out: Dict[str, Dict[str, int]] = defaultdict(lambda: defaultdict(int))
    for sql in queries:
        refs = extract_table_refs(sql, known_tables)
        if not refs:
            continue
        needed = collect_needed_original_columns(sql, refs, schema_graph)
        tables_in_q = {t[0] for t in refs}
        for orig, frag_list in frag_col_sets.items():
            if orig not in tables_in_q:
                continue
            nset = needed.get(orig, {NEED_ALL})
            pk = set(table_pk_columns.get(orig, set())) if table_pk_columns else set()
            for fname, fcols in frag_list:
                fset = set(fcols)
                basis = (fset - pk) if (fset - pk) else fset
                if NEED_ALL in nset or (nset & basis):
                    out[orig][fname] += 1
    return {k: dict(v) for k, v in out.items()}


def score_relocation_targets_for_fragment(
    queries: List[str],
    known_tables: Set[str],
    schema_graph: SchemaGraph,
    orig_table: str,
    frag_column_set: Set[str],
    pk_columns: Set[str],
    groups: List[Set[str]],
    home_local_idx: int,
) -> List[Tuple[float, int]]:
    """
    Scores target locals by queries that reference this fragment's **non-PK** columns
    (PK-only touches are ignored) and also reference another table in that local's group.
    """
    non_pk = frag_column_set - pk_columns
    touch_basis = non_pk if non_pk else frag_column_set
    scores: Dict[int, float] = defaultdict(float)
    for sql in queries:
        refs = extract_table_refs(sql, known_tables)
        if not refs:
            continue
        needed = collect_needed_original_columns(sql, refs, schema_graph)
        tables_in_q = {t[0] for t in refs}
        if orig_table not in tables_in_q:
            continue
        nset = needed.get(orig_table, {NEED_ALL})
        if NEED_ALL not in nset and not (nset & touch_basis):
            continue
        for other_idx, g in enumerate(groups):
            if other_idx == home_local_idx:
                continue
            for U in tables_in_q:
                if U == orig_table:
                    continue
                if U in g:
                    scores[other_idx] += 1.0
    return sorted(((scores[j], j) for j in scores), key=lambda x: (-x[0], x[1]))


def column_based_coquery_partner_counts(
    queries: List[str],
    known_tables: Set[str],
    schema_graph: SchemaGraph,
    orig_table: str,
    frag_column_set: Set[str],
    pk_columns: Set[str],
) -> List[Tuple[str, int]]:
    """
    For a fragment, count how often each **other** original table appears in a query
    that also references this fragment's non-PK columns (PK-only ignored).
    """
    non_pk = frag_column_set - pk_columns
    basis = non_pk if non_pk else frag_column_set
    counts: Dict[str, int] = defaultdict(int)
    for sql in queries:
        refs = extract_table_refs(sql, known_tables)
        if not refs:
            continue
        needed = collect_needed_original_columns(sql, refs, schema_graph)
        tables_in_q = {t[0] for t in refs}
        if orig_table not in tables_in_q:
            continue
        nset = needed.get(orig_table, {NEED_ALL})
        if NEED_ALL not in nset and not (nset & basis):
            continue
        for U in tables_in_q:
            if U == orig_table:
                continue
            counts[U] += 1
    return sorted(counts.items(), key=lambda x: (-x[1], x[0]))


def build_fragment_home_local_map(locals_list) -> Dict[str, str]:
    """local_fragment_table_name -> local_name (before relocation is applied)."""
    out: Dict[str, str] = {}
    for loc in locals_list:
        for lt, tr in loc.tables.items():
            out[lt] = loc.local_name
    return out


def _entries_for_original_with_placement(
    T: str,
    locals_list,
    fragment_placement: Dict[str, str],
) -> List[Tuple[str, object]]:
    entries: List[Tuple[str, object]] = []
    for loc in locals_list:
        for lt, tr in loc.tables.items():
            if tr.source_table != T:
                continue
            eff_loc = fragment_placement.get(lt, loc.local_name)
            entries.append((eff_loc, tr))
    return entries


def locals_union_for_table_with_placement(
    T: str,
    needed_cols: Set[str],
    locals_list,
    schema_graph: SchemaGraph,
    fragment_placement: Dict[str, str],
) -> Set[str]:
    """Which locals host the fragments of T needed for this query, given hypothetical placement."""
    entries = _entries_for_original_with_placement(T, locals_list, fragment_placement)
    if not entries:
        return set()
    is_rpart = any(getattr(tr, "is_row_partition", False) for _, tr in entries)
    is_vsplit = any(getattr(tr, "is_vertical_split_fragment", False) for _, tr in entries)
    if is_rpart:
        return {ln for ln, _ in entries}
    if not is_vsplit:
        return {ln for ln, _ in entries}
    nc = set(needed_cols) if needed_cols else {NEED_ALL}
    if NEED_ALL in nc:
        ls = {ln for ln, tr in entries if getattr(tr, "is_vertical_split_fragment", False)}
        return ls if ls else {ln for ln, _ in entries}
    frags_locals: Set[str] = set()
    missing = set(nc) - {NEED_ALL}
    for ln, tr in entries:
        if not getattr(tr, "is_vertical_split_fragment", False):
            continue
        ocols = _orig_columns_in_transform(tr)
        if missing & ocols:
            frags_locals.add(ln)
            missing -= ocols
    if missing:
        ls = {ln for ln, tr in entries if getattr(tr, "is_vertical_split_fragment", False)}
        return ls if ls else {ln for ln, _ in entries}
    return frags_locals


def score_relocation_targets_fragment_placement(
    queries: List[str],
    known_tables: Set[str],
    schema_graph: SchemaGraph,
    orig_table: str,
    fragment_local_table: str,
    frag_column_set: Set[str],
    pk_columns: Set[str],
    groups: List[Set[str]],
    home_local_idx: int,
    locals_list,
) -> List[Tuple[float, int]]:
    """
    Score locals L where hypothetically moving fragment_local_table to L makes the
    entire query's required fragments lie in L only (maximizes future single-local queries).
    """
    non_pk = frag_column_set - pk_columns
    touch_basis = non_pk if non_pk else frag_column_set
    home_name = f"local_{home_local_idx + 1}"
    placement0 = build_fragment_home_local_map(locals_list)
    scores: Dict[int, float] = defaultdict(float)
    for sql in queries:
        refs = extract_table_refs(sql, known_tables)
        if not refs:
            continue
        needed = collect_needed_original_columns(sql, refs, schema_graph)
        tables_in_q = sorted({t[0] for t in refs})
        if orig_table not in tables_in_q:
            continue
        nset = needed.get(orig_table, {NEED_ALL})
        if NEED_ALL not in nset:
            if not (nset & frag_column_set & touch_basis):
                continue
        for other_idx, _g in enumerate(groups):
            if other_idx == home_local_idx:
                continue
            Lname = f"local_{other_idx + 1}"
            if placement0.get(fragment_local_table) != home_name:
                continue
            pl = dict(placement0)
            pl[fragment_local_table] = Lname
            union_l: Set[str] = set()
            for T in tables_in_q:
                ucols = needed.get(T, {NEED_ALL})
                union_l |= locals_union_for_table_with_placement(
                    T, ucols, locals_list, schema_graph, pl
                )
            if union_l == {Lname}:
                scores[other_idx] += 1.0
    return sorted(((scores[j], j) for j in scores), key=lambda x: (-x[0], x[1]))


def score_relocation_targets_smart(
    queries: List[str],
    known_tables: Set[str],
    schema_graph: SchemaGraph,
    orig_table: str,
    fragment_local_table: str,
    frag_column_set: Set[str],
    pk_columns: Set[str],
    groups: List[Set[str]],
    home_local_idx: int,
    locals_list,
) -> Tuple[List[Tuple[float, int]], str]:
    """
    Prefer fragment-placement-aware scoring; fall back to table-group co-occurrence.
    Returns (ranked_scores, method_name).
    """
    # No workload: use FK boundary evidence as the relocation signal.
    # This is important for datasets like Spider2 localdb that have schemas but
    # few/no natural query workloads.
    if not queries:
        scores: List[Tuple[float, int]] = []
        for j, g in enumerate(groups):
            if j == home_local_idx:
                continue
            w = 0.0
            for fk in schema_graph.foreign_keys:
                if fk.from_table == orig_table and fk.to_table in g:
                    w += 1.0
                elif fk.to_table == orig_table and fk.from_table in g:
                    w += 1.0
            if w > 0:
                scores.append((w, j))
        scores.sort(key=lambda t: (-t[0], t[1]))
        return scores, "fk_only_no_workload"

    ranked = score_relocation_targets_fragment_placement(
        queries,
        known_tables,
        schema_graph,
        orig_table,
        fragment_local_table,
        frag_column_set,
        pk_columns,
        groups,
        home_local_idx,
        locals_list,
    )
    if ranked and ranked[0][0] > 0:
        return ranked, "fragment_placement_single_local"
    ranked2 = score_relocation_targets_for_fragment(
        queries,
        known_tables,
        schema_graph,
        orig_table,
        frag_column_set,
        pk_columns,
        groups,
        home_local_idx,
    )
    return ranked2, "table_group_fallback"


def column_based_partner_fragment_details(
    queries: List[str],
    known_tables: Set[str],
    schema_graph: SchemaGraph,
    orig_table: str,
    frag_column_set: Set[str],
    pk_columns: Set[str],
    locals_list,
    top_n: int = 15,
) -> List[Dict[str, object]]:
    """
    For workload on this fragment, list partner logical tables with the **local fragment
    names** whose columns satisfy the query's needs (given current placement).
    """
    non_pk = frag_column_set - pk_columns
    basis = non_pk if non_pk else frag_column_set
    placement0 = build_fragment_home_local_map(locals_list)
    pair_counts: Counter = Counter()
    for sql in queries:
        refs = extract_table_refs(sql, known_tables)
        if not refs:
            continue
        needed = collect_needed_original_columns(sql, refs, schema_graph)
        tables_in_q = {t[0] for t in refs}
        if orig_table not in tables_in_q:
            continue
        nset = needed.get(orig_table, {NEED_ALL})
        if NEED_ALL not in nset and not (nset & basis):
            continue
        seen_pairs: Set[Tuple[str, str]] = set()
        for U in tables_in_q:
            if U == orig_table:
                continue
            uneed = needed.get(U, {NEED_ALL})
            for _eff_loc, tr in _entries_for_original_with_placement(
                U, locals_list, placement0
            ):
                ocols = _orig_columns_in_transform(tr)
                if NEED_ALL in uneed or (uneed & ocols):
                    seen_pairs.add((U, tr.local_table))
        for pair in seen_pairs:
            pair_counts[pair] += 1
    rows = []
    for (U, lt), c in pair_counts.most_common(top_n):
        rows.append(
            {
                "partner_source_table": U,
                "partner_local_fragment": lt,
                "coquery_count": c,
            }
        )
    return rows
