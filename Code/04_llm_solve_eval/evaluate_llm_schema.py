import sqlite3
import json
import os
import re
from typing import Any, Dict, List, Optional, Set, Tuple
import math
from collections import defaultdict, Counter


def _sqlite_value_sort_key(v: Any) -> Tuple:
    """
    Deterministic ordering for SQLite cell values. Plain tuple(row) sort fails
    when None is mixed with numbers (TypeError: '<' not supported between
    NoneType and float).
    """
    if v is None:
        return (0, None)
    if isinstance(v, bool):
        return (1, v)
    if isinstance(v, int):
        return (2, float(v))
    if isinstance(v, float):
        return (3, v)
    if isinstance(v, (bytes, bytearray)):
        return (4, bytes(v))
    return (5, str(v))


def _sqlite_row_sort_key(row: tuple) -> Tuple:
    return tuple(_sqlite_value_sort_key(x) for x in row)


# ──────────────────────────────────────────────
# GAV Rule Parsing
# ──────────────────────────────────────────────

def parse_gav_views(gav_text: str) -> List[Tuple[str, str]]:
    """
    Parse GAV rules text into individual CREATE VIEW statements.

    Returns list of (view_name, full_create_view_sql) tuples.
    """
    if not gav_text or not gav_text.strip():
        return []

    lines = gav_text.split('\n')
    clean_lines = []
    for line in lines:
        stripped = line.strip()
        if stripped.startswith('--'):
            continue
        if '--' in line:
            quote_depth = 0
            cut_idx = None
            for i, ch in enumerate(line):
                if ch == "'":
                    quote_depth = 1 - quote_depth
                elif ch == '-' and i + 1 < len(line) and line[i + 1] == '-' and quote_depth == 0:
                    cut_idx = i
                    break
            if cut_idx is not None:
                line = line[:cut_idx]
        clean_lines.append(line)
    clean_text = '\n'.join(clean_lines).strip()
    clean_text = re.sub(r'```\w*\s*', '', clean_text)

    pattern = re.compile(
        r'CREATE\s+VIEW\s+[`\[\"]?(\w+)[`\]\"]?\s+AS\s+'
        r'(SELECT\b.*?)(?=\bCREATE\s+VIEW\b|$)',
        re.IGNORECASE | re.DOTALL
    )

    results = []
    for match in pattern.finditer(clean_text):
        view_name = match.group(1)
        select_body = match.group(2).strip().rstrip(';').strip()
        full_sql = f'CREATE VIEW [{view_name}] AS {select_body}'
        results.append((view_name, full_sql))

    return results


# ──────────────────────────────────────────────
# DDL Parsing Helpers
# ──────────────────────────────────────────────

def _parse_create_table_header(stmt: str) -> Optional[Tuple[str, int]]:
    """
    Parse leading CREATE TABLE ... ( and return (table_name, index of '(').

    Supports quoted / multi-word identifiers: `Sales Orders`, "Store Locations".
    The previous implementation used (\\w+) for the table name, which turned
    ``"Sales Orders"`` into ``Sales`` and broke original-schema parsing.
    """
    stmt = stmt.strip()
    m = re.match(
        r"CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?"
        r'(?:`([^`]+)`|"([^"]+)"|\[([^\]]+)\]|(\w+))\s*\(',
        stmt,
        re.IGNORECASE | re.DOTALL,
    )
    if not m:
        return None
    name = m.group(1) or m.group(2) or m.group(3) or m.group(4)
    paren_start = m.end() - 1
    return name, paren_start


def _parse_ddl_columns(ddl_text: str) -> Dict[str, List[str]]:
    """Parse DDL text to extract table_name -> [column_names].

    Handles backtick-quoted identifiers that may contain spaces,
    e.g. `Academic Year`.
    """
    tables = {}
    statements = re.split(r';\s*', ddl_text)

    for stmt in statements:
        stmt = stmt.strip()
        if not stmt:
            continue
        parsed = _parse_create_table_header(stmt)
        if not parsed:
            continue
        table_name, paren_start = parsed
        depth = 0
        paren_end = -1
        for i in range(paren_start, len(stmt)):
            if stmt[i] == '(':
                depth += 1
            elif stmt[i] == ')':
                depth -= 1
                if depth == 0:
                    paren_end = i
                    break

        if paren_end == -1:
            continue

        body = stmt[paren_start + 1:paren_end]
        columns = []

        parts = _split_comma_respecting_parens(body)
        for part in parts:
            part = part.strip()
            if not part:
                continue
            if re.match(
                r'(PRIMARY|FOREIGN|UNIQUE|CHECK|CONSTRAINT)\b',
                part, re.IGNORECASE,
            ):
                continue

            # Backtick-quoted name (may contain spaces): `Column Name`
            col_match = re.match(r'`([^`]+)`\s+\w+', part)
            if not col_match:
                # Bracket-quoted: [Column Name]
                col_match = re.match(r'\[([^\]]+)\]\s+\w+', part)
            if not col_match:
                # Double-quoted: "Column Name"
                col_match = re.match(r'"([^"]+)"\s+\w+', part)
            if not col_match:
                # Unquoted simple identifier
                col_match = re.match(r'(\w+)\s+\w+', part, re.IGNORECASE)

            if col_match:
                col_name = col_match.group(1)
                if col_name.upper() not in (
                    'PRIMARY', 'FOREIGN', 'UNIQUE', 'CHECK', 'CONSTRAINT',
                ):
                    columns.append(col_name)

        tables[table_name] = columns

    return tables


def _parse_ddl_with_pks(ddl_text: str) -> Dict[str, Dict]:
    """Parse DDL text to extract table_name -> {'columns': [...], 'primary_keys': [...]}.

    Handles both inline PK declarations (col_name TYPE primary key) and
    table-level PRIMARY KEY constraints (PRIMARY KEY (col1, col2)).
    """
    tables: Dict[str, Dict] = {}
    statements = re.split(r';\s*', ddl_text)

    for stmt in statements:
        stmt = stmt.strip()
        if not stmt:
            continue
        parsed = _parse_create_table_header(stmt)
        if not parsed:
            continue
        table_name, paren_start = parsed
        depth = 0
        paren_end = -1
        for i in range(paren_start, len(stmt)):
            if stmt[i] == '(':
                depth += 1
            elif stmt[i] == ')':
                depth -= 1
                if depth == 0:
                    paren_end = i
                    break
        if paren_end == -1:
            continue

        body = stmt[paren_start + 1:paren_end]
        columns: List[str] = []
        pk_columns: List[str] = []

        parts = _split_comma_respecting_parens(body)
        for part in parts:
            part = part.strip()
            if not part:
                continue

            pk_constraint = re.match(
                r'PRIMARY\s+KEY\s*\(([^)]+)\)', part, re.IGNORECASE,
            )
            if pk_constraint:
                pk_inner = pk_constraint.group(1)
                for pk_col in pk_inner.split(','):
                    pk_col = pk_col.strip().strip('`[]"')
                    if pk_col:
                        pk_columns.append(pk_col)
                continue

            if re.match(
                r'(FOREIGN|UNIQUE|CHECK|CONSTRAINT)\b', part, re.IGNORECASE,
            ):
                continue

            col_match = re.match(r'`([^`]+)`\s+\w+', part)
            if not col_match:
                col_match = re.match(r'\[([^\]]+)\]\s+\w+', part)
            if not col_match:
                col_match = re.match(r'"([^"]+)"\s+\w+', part)
            if not col_match:
                col_match = re.match(r'(\w+)\s+\w+', part, re.IGNORECASE)

            if col_match:
                col_name = col_match.group(1)
                if col_name.upper() in (
                    'PRIMARY', 'FOREIGN', 'UNIQUE', 'CHECK', 'CONSTRAINT',
                ):
                    continue
                columns.append(col_name)
                if re.search(r'\bprimary\s+key\b', part, re.IGNORECASE):
                    pk_columns.append(col_name)

        tables[table_name] = {
            "columns": columns,
            "primary_keys": pk_columns,
        }

    return tables


def _split_comma_respecting_parens(text: str) -> List[str]:
    """Split text by commas, respecting nested parentheses."""
    parts = []
    depth = 0
    current: List[str] = []
    for char in text:
        if char == '(':
            depth += 1
            current.append(char)
        elif char == ')':
            depth -= 1
            current.append(char)
        elif char == ',' and depth == 0:
            parts.append(''.join(current))
            current = []
        else:
            current.append(char)
    if current:
        parts.append(''.join(current))
    return parts


def _discover_local_databases(instance_dir: str) -> Dict[str, str]:
    """Find all local_N.sqlite files in the instance's locals/ directory."""
    locals_dir = os.path.join(instance_dir, "locals")
    result = {}
    if not os.path.isdir(locals_dir):
        return result
    for fname in sorted(os.listdir(locals_dir)):
        if fname.endswith('.sqlite'):
            schema_name = os.path.splitext(fname)[0]
            result[schema_name] = os.path.join(locals_dir, fname)
    return result


# ──────────────────────────────────────────────
# Ground-Truth Mapping Helpers
# ──────────────────────────────────────────────

def _build_original_column_set(
    instance_dir: str,
) -> Set[Tuple[str, str]]:
    """Build the set of (original_table, original_column) pairs."""
    schema_path = os.path.join(instance_dir, "global", "original_schema.sql")
    with open(schema_path) as f:
        ddl = f.read()

    tables = _parse_ddl_columns(ddl)
    col_set: Set[Tuple[str, str]] = set()
    for table_name, columns in tables.items():
        for col in columns:
            col_set.add((table_name, col))
    return col_set


def _build_local_to_original_map(
    instance_dir: str,
) -> Dict[Tuple[str, str, str], Tuple[str, str]]:
    """
    Build mapping: (local_name, local_table, local_column) -> (orig_table, orig_column).

    Uses ``transform_spec.json`` logical ``(local, table_key, logical_col)`` entries,
    then augments with physical SQLite names from ``locals/*_schema.sql`` (pairing
    by arity / heuristics), and finally adds ``(local, physical_table, physical_col)``
    rows when the physical table name encodes the source (``schools_*``, ``satscores_*``,
    ``frpm_*``) and ``physical_col`` is a real column on that original table. The last
    step fixes relocated fragments where the spec's ``local_N`` does not match attach
    placement or arity-only pairing fails.
    """
    spec_path = os.path.join(instance_dir, "mappings", "transform_spec.json")
    with open(spec_path) as f:
        spec = json.load(f)

    mapping: Dict[Tuple[str, str, str], Tuple[str, str]] = {}
    for local in spec.get("locals", []):
        local_name = local.get("local_name")
        tables = local.get("tables", {})
        if not local_name or not isinstance(tables, dict):
            continue
        for local_table, tinfo in tables.items():
            source_table = tinfo.get("source_table")
            col_map = tinfo.get("column_map", {})
            if not source_table or not isinstance(col_map, dict):
                continue
            for local_col, orig_col in col_map.items():
                mapping[(local_name, local_table, local_col)] = (
                    source_table, orig_col,
                )

    _augment_local_to_original_from_physical_schemas(instance_dir, spec, mapping)
    _augment_local_to_original_from_physical_name_prefix(instance_dir, mapping)
    return mapping


def _disambiguate_physical_table_name(
    physical_table: str,
    candidates: List[str],
    spec_tables: Dict[str, Any],
) -> Optional[str]:
    """
    When several transform_spec table keys share the same arity, pick the one
    that matches obfuscated physical DDL names (cust_mast vs ClientAccount, etc.).
    """
    if not candidates:
        return None
    if len(candidates) == 1:
        return candidates[0]

    pn = physical_table.lower()
    scored: List[Tuple[int, str]] = []

    for sk in candidates:
        score = 0
        sl = sk.lower()
        # Customers / Products short paths (two-column masters)
        if ("cust" in pn or "customer" in pn) and "client" in sl:
            score += 200
        if "prod_mast" in pn or ("prod" in pn and "mast" in pn):
            if "inventory" in sl or "product" in sl:
                score += 200
        # Sales Orders row-partition fragments (snake_case vs PascalCase)
        frag_hints = [
            ("lte_three", "upto3"),
            ("lte_three", "quantityupto"),
            ("gt_three_lte_five", "greaterthan3to5"),
            ("gt_three_lte_five", "greaterthan3"),
            ("gt_five_lte_seven", "greaterthan5to7"),
            ("gt_five_lte_seven", "greaterthan5"),
            ("gt_seven_or_null", "greaterthan7"),
            ("gt_seven_or_null", "greaterthan7ornull"),
        ]
        for sub, hint in frag_hints:
            if sub in pn and hint in sl:
                score += 150
        if "s_ord" in pn or "ord_qty" in pn:
            if "salesorder" in sl or "currency" in sl:
                score += 40
        scored.append((score, sk))

    scored.sort(key=lambda t: (-t[0], t[1]))
    if scored[0][0] > 0:
        return scored[0][1]

    return None


def _pair_physical_tables_to_spec_keys(
    ddl_tables: Dict[str, List[str]],
    spec_tables: Dict[str, Any],
) -> Dict[str, str]:
    """Map physical SQLite table name -> transform_spec.json tables{} key."""
    out: Dict[str, str] = {}
    spec_keys = list(spec_tables.keys())
    used_spec: Set[str] = set()

    for phys in ddl_tables:
        if phys in spec_tables:
            out[phys] = phys
            used_spec.add(phys)

    for phys in sorted(ddl_tables.keys()):
        if phys in out:
            continue
        ncols = len(ddl_tables[phys])
        cands = [
            sk for sk in spec_keys
            if sk not in used_spec
            and len((spec_tables[sk].get("column_map") or {})) == ncols
        ]
        if len(cands) == 1:
            out[phys] = cands[0]
            used_spec.add(cands[0])
            continue
        if len(cands) > 1:
            pick = _disambiguate_physical_table_name(phys, cands, spec_tables)
            if pick:
                out[phys] = pick
                used_spec.add(pick)

    return out


def _physical_tables_from_local_sqlite(
    instance_dir: str,
    local_name: str,
) -> Dict[str, List[str]]:
    """
    When locals/<local>_schema.sql is missing or empty, read table/column names
    from the materialized SQLite (same source the solver queries).
    """
    sqlite_path = os.path.join(instance_dir, "locals", f"{local_name}.sqlite")
    if not os.path.isfile(sqlite_path):
        return {}

    abs_path = os.path.abspath(sqlite_path).replace("\\", "/")
    uri = f"file:{abs_path}?mode=ro"
    conn = sqlite3.connect(uri, uri=True)
    try:
        out: Dict[str, List[str]] = {}
        for (tname,) in conn.execute(
            "SELECT name FROM sqlite_master WHERE type='table' "
            "AND name NOT LIKE 'sqlite_%%' ORDER BY name"
        ).fetchall():
            rows = conn.execute(f'PRAGMA table_info("{tname}")').fetchall()
            out[tname] = [r[1] for r in rows]
        return out
    finally:
        conn.close()


def _load_physical_ddl_tables(instance_dir: str, local_name: str) -> Dict[str, List[str]]:
    """Prefer locals/*_schema.sql; fall back to introspecting locals/*.sqlite."""
    schema_path = os.path.join(instance_dir, "locals", f"{local_name}_schema.sql")
    if os.path.isfile(schema_path) and os.path.getsize(schema_path) > 0:
        with open(schema_path, encoding="utf-8") as f:
            ddl_tables = _parse_ddl_columns(f.read())
        if ddl_tables:
            return ddl_tables
    return _physical_tables_from_local_sqlite(instance_dir, local_name)


def _augment_local_to_original_from_physical_schemas(
    instance_dir: str,
    spec: Dict[str, Any],
    mapping: Dict[Tuple[str, str, str], Tuple[str, str]],
) -> None:
    """
    Materialized locals often use final obfuscated names (cust_mast) while
    transform_spec.json keys still use logical names (ClientAccount). GAV SQL
    references the physical names, so we add (local, physical_table, physical_col)
    entries by pairing locals/*_schema.sql (or PRAGMA from locals/*.sqlite) with
    transform_spec entries.
    """
    for local in spec.get("locals", []):
        local_name = local.get("local_name")
        spec_tables = local.get("tables") or {}
        if not local_name or not isinstance(spec_tables, dict):
            continue

        ddl_tables = _load_physical_ddl_tables(instance_dir, local_name)
        if not ddl_tables:
            continue

        pairing = _pair_physical_tables_to_spec_keys(ddl_tables, spec_tables)

        for phys_table, spec_key in pairing.items():
            tinfo = spec_tables.get(spec_key)
            if not tinfo:
                continue
            cmap = tinfo.get("column_map") or {}
            source_table = tinfo.get("source_table")
            if not source_table or not isinstance(cmap, dict) or not cmap:
                continue

            phys_cols = ddl_tables.get(phys_table) or []
            if len(cmap) != len(phys_cols):
                continue

            # Prefer projected_columns / original-column order (matches materialized DDL order).
            proj = tinfo.get("projected_columns")
            loc_keys_ordered: List[str] = []
            if isinstance(proj, list) and proj:
                for orig_col in proj:
                    for lk, ov in cmap.items():
                        if ov == orig_col:
                            loc_keys_ordered.append(lk)
                            break
            if len(loc_keys_ordered) != len(phys_cols):
                loc_keys_ordered = sorted(cmap.keys())
                phys_cols = sorted(phys_cols)

            for lk, pc in zip(loc_keys_ordered, phys_cols):
                orig_col = cmap[lk]
                key = (local_name, phys_table, pc)
                if key not in mapping:
                    mapping[key] = (source_table, orig_col)


def _infer_original_table_from_physical_fragment_name(
    physical_table: str,
) -> Optional[str]:
    """
    Many materialized BIRD-style fragments keep a stable table-name prefix
    matching the original source table (``schools_*``, ``satscores_*``, ``frpm_*``).
    """
    t = physical_table.lower()
    if t.startswith("frpm"):
        return "frpm"
    if t.startswith("satscores"):
        return "satscores"
    if t.startswith("schools"):
        return "schools"
    return None


def _augment_local_to_original_from_physical_name_prefix(
    instance_dir: str,
    mapping: Dict[Tuple[str, str, str], Tuple[str, str]],
) -> None:
    """
    When ``transform_spec`` logical tables live under a different ``local_N`` than
    the materialized SQLite files, arity-only pairing in
    ``_augment_local_to_original_from_physical_schemas`` often fails or mis-pairs.
    For physical tables whose names still encode the source (``schools_admemail1``,
    ``satscores_cname``, ``frpm_academic_year``), map each physical column to the
    original column with the same name on that source table when it exists in
    ``global/original_schema.sql``.
    """
    orig_pairs = _build_original_column_set(instance_dir)
    cols_by_orig_table: Dict[str, Set[str]] = defaultdict(set)
    for ot, oc in orig_pairs:
        cols_by_orig_table[ot].add(oc)

    for local_name in sorted(_discover_local_databases(instance_dir).keys()):
        ddl_tables = _load_physical_ddl_tables(instance_dir, local_name)
        for phys_table, phys_cols in ddl_tables.items():
            source_table = _infer_original_table_from_physical_fragment_name(
                phys_table,
            )
            if not source_table:
                continue
            allowed = cols_by_orig_table.get(source_table)
            if not allowed:
                continue
            for phys_col in phys_cols:
                if phys_col not in allowed:
                    continue
                key = (local_name, phys_table, phys_col)
                if key not in mapping:
                    mapping[key] = (source_table, phys_col)


def _build_fk_equivalences(
    instance_dir: str,
) -> Set[Tuple[Tuple[str, str], Tuple[str, str]]]:
    """Load FK relationships from fk_map.json.

    Returns a set of ((from_table, from_col), (to_table, to_col)) pairs
    representing FK relationships in the original schema.
    """
    fk_path = os.path.join(instance_dir, "mappings", "fk_map.json")
    if not os.path.exists(fk_path):
        return set()
    with open(fk_path) as f:
        fk_data = json.load(f)

    equivalences: Set[Tuple[Tuple[str, str], Tuple[str, str]]] = set()
    for fk in fk_data.get("foreign_keys", []):
        orig = fk.get("original", {})
        from_table = orig.get("from_table")
        from_col = orig.get("from_column")
        to_table = orig.get("to_table")
        to_col = orig.get("to_column")
        if from_table and from_col and to_table and to_col:
            equivalences.add(
                ((from_table, from_col), (to_table, to_col))
            )
    return equivalences


def _extract_join_conditions(
    view_sql: str,
    local_to_original: Dict[Tuple[str, str, str], Tuple[str, str]],
) -> List[Tuple[Tuple[str, str], Tuple[str, str]]]:
    """Parse JOIN ON conditions from a view's SQL and resolve both sides
    to original columns via the provenance chain.

    Returns list of ((orig_table_A, orig_col_A), (orig_table_B, orig_col_B))
    pairs for each join condition where both sides can be resolved.
    """
    as_match = re.search(
        r'\bAS\s+(SELECT\b.+)', view_sql, re.IGNORECASE | re.DOTALL,
    )
    if not as_match:
        return []

    select_body = as_match.group(1).strip()
    union_parts = re.split(
        r'\bUNION\b(?:\s+ALL\b)?', select_body, flags=re.IGNORECASE,
    )

    KW_SET = {
        'ON', 'WHERE', 'GROUP', 'ORDER', 'HAVING', 'LIMIT',
        'INNER', 'LEFT', 'RIGHT', 'OUTER', 'CROSS', 'NATURAL',
        'JOIN', 'UNION', 'SET',
    }

    results: List[Tuple[Tuple[str, str], Tuple[str, str]]] = []

    for part in union_parts:
        part = part.strip()

        table_refs: Dict[str, Tuple[str, str]] = {}
        for m in re.finditer(
            r'(?:FROM|JOIN)\s+\[?(\w+)\]?\s*\.\s*\[?(\w+)\]?'
            r'(?:\s+(?:AS\s+)?(\w+))?',
            part, re.IGNORECASE,
        ):
            local_db = m.group(1)
            local_table = m.group(2)
            alias = m.group(3) or local_table
            if alias.upper() in KW_SET:
                alias = local_table
            table_refs[alias.lower()] = (local_db, local_table)
            table_refs[local_table.lower()] = (local_db, local_table)

        for m in re.finditer(
            r'\bON\s+\[?(\w+)\]?\s*\.\s*\[?(\w+)\]?\s*=\s*'
            r'\[?(\w+)\]?\s*\.\s*\[?(\w+)\]?',
            part, re.IGNORECASE,
        ):
            alias_a, col_a = m.group(1).lower(), m.group(2)
            alias_b, col_b = m.group(3).lower(), m.group(4)

            def _resolve(alias: str, col: str) -> Optional[Tuple[str, str]]:
                if alias not in table_refs:
                    return None
                ld, lt = table_refs[alias]
                key = (ld, lt, col)
                if key in local_to_original:
                    return local_to_original[key]
                for (ld2, lt2, lc2), (ot, oc) in local_to_original.items():
                    if (ld2.lower() == ld.lower()
                            and lt2.lower() == lt.lower()
                            and lc2.lower() == col.lower()):
                        return (ot, oc)
                return None

            orig_a = _resolve(alias_a, col_a)
            orig_b = _resolve(alias_b, col_b)
            if orig_a and orig_b and orig_a != orig_b:
                results.append((orig_a, orig_b))

    return results


# ──────────────────────────────────────────────
# Metric 1: GAV Compile Rate
# ──────────────────────────────────────────────

def evaluate_compile_rate(
    gav_views: List[Tuple[str, str]],
    instance_dir: str,
) -> Tuple[Dict, sqlite3.Connection]:
    """
    Validate each GAV rule by executing its SELECT body against the
    local databases attached to an in-memory SQLite connection.

    SQLite views cannot reference attached databases, so instead of
    CREATE VIEW we extract the SELECT body and execute it directly
    (with LIMIT 0) to validate syntax and column/table references.

    Returns:
        (result_dict, connection)

    The connection is returned with local databases still attached
    so it can be reused for materialization in Metric 3.
    """
    local_dbs = _discover_local_databases(instance_dir)
    conn = sqlite3.connect(":memory:")

    attached: Dict[str, Dict] = {}
    for schema_name, db_path in local_dbs.items():
        try:
            conn.execute(
                f'ATTACH DATABASE ? AS [{schema_name}]', (db_path,)
            )
            tables = [
                r[0] for r in conn.execute(
                    f"SELECT name FROM [{schema_name}].sqlite_master "
                    f"WHERE type='table'"
                ).fetchall()
            ]
            attached[schema_name] = {"status": "ok", "tables": tables}
        except Exception as e:
            attached[schema_name] = {"status": "error", "error": str(e)}

    per_view: List[Dict] = []
    compiled = 0
    failed = 0

    for view_name, view_sql in gav_views:
        # Extract SELECT body from CREATE VIEW ... AS SELECT ...
        as_match = re.search(
            r'\bAS\s+(SELECT\b.+)', view_sql, re.IGNORECASE | re.DOTALL
        )
        if not as_match:
            failed += 1
            per_view.append({
                "view_name": view_name,
                "status": "failed",
                "sql": view_sql,
                "error": "Could not extract SELECT body from CREATE VIEW",
            })
            continue

        select_body = as_match.group(1).strip()

        try:
            # Validate by executing with LIMIT 0 (no data fetched)
            conn.execute(f"SELECT * FROM ({select_body}) LIMIT 0")
            compiled += 1
            per_view.append({
                "view_name": view_name,
                "status": "compiled",
                "sql": view_sql,
                "select_body": select_body,
            })
        except Exception as e:
            failed += 1
            per_view.append({
                "view_name": view_name,
                "status": "failed",
                "sql": view_sql,
                "select_body": select_body,
                "error": str(e),
            })

    total = len(gav_views)
    compile_rate = compiled / max(1, total)

    result = {
        "compile_rate": round(compile_rate, 4),
        "total_views": total,
        "compiled": compiled,
        "failed": failed,
        "per_view": per_view,
        "attached_databases": attached,
    }

    return result, conn


# ──────────────────────────────────────────────
# Metric 2: Attribute Provenance
# ──────────────────────────────────────────────

def _extract_view_column_provenance(
    gav_views: List[Tuple[str, str]],
) -> Dict[str, List[Tuple[str, str, str]]]:
    """
    For each view, parse its SQL to extract which
    (local_db, local_table, local_column) tuples it references.

    Returns:
        view_name -> [(local_db, local_table, local_column), ...]
    """
    provenance: Dict[str, List[Tuple[str, str, str]]] = {}

    for view_name, view_sql in gav_views:
        as_match = re.search(
            r'\bAS\s+(SELECT\b.+)', view_sql, re.IGNORECASE | re.DOTALL
        )
        if not as_match:
            continue

        select_body = as_match.group(1).strip()

        # Split by UNION / UNION ALL to handle row-partition views
        union_parts = re.split(
            r'\bUNION\b(?:\s+ALL\b)?', select_body, flags=re.IGNORECASE
        )

        references: List[Tuple[str, str, str]] = []

        for part in union_parts:
            part = part.strip()

            # Collect table references: FROM/JOIN local_N.table [alias]
            table_refs: Dict[str, Tuple[str, str]] = {}
            for m in re.finditer(
                # Accept common identifier quoting for both DB alias and table:
                #   local_1.table
                #   local_1."table"
                #   "local_1"."table"
                #   [local_1].[table]
                r'(?:FROM|JOIN)\s+[`"\[]?(\w+)[`"\]]?\s*\.\s*[`"\[]?(\w+)[`"\]]?'
                r'(?:\s+(?:AS\s+)?(\w+))?',
                part, re.IGNORECASE,
            ):
                local_db = m.group(1)
                local_table = m.group(2)
                alias = m.group(3) or local_table
                kw_set = {
                    'ON', 'WHERE', 'GROUP', 'ORDER', 'HAVING', 'LIMIT',
                    'INNER', 'LEFT', 'RIGHT', 'OUTER', 'CROSS', 'NATURAL',
                    'JOIN', 'UNION', 'SET',
                }
                if alias.upper() in kw_set:
                    alias = local_table
                table_refs[alias.lower()] = (local_db, local_table)
                table_refs[local_table.lower()] = (local_db, local_table)

            # Extract SELECT column list
            from_idx = re.search(r'\bFROM\b', part, re.IGNORECASE)
            if not from_idx:
                continue
            select_text = part[:from_idx.start()].strip()
            if select_text.upper().startswith('SELECT'):
                select_text = select_text[6:].strip()

            col_exprs = _split_comma_respecting_parens(select_text)

            for expr in col_exprs:
                expr = expr.strip()
                if not expr or expr == '*':
                    continue

                # Capture fully-qualified local references anywhere inside the expression,
                # including inside functions like COALESCE(...) and CASE ... END.
                #
                # Examples matched:
                #   local_1.Table.Col
                #   "local_1"."Table"."Col"
                #   [local_1].[Table].[Col]
                for m3 in re.finditer(
                    r'[`"\[]?(local_\d+)[`"\]]?\s*\.\s*[`"\[]?(\w+)[`"\]]?\s*\.\s*'
                    r'(?:`([^`]+)`|"([^"]+)"|\[([^\]]+)\]|(\w+))',
                    expr,
                    re.IGNORECASE,
                ):
                    col_part = (
                        m3.group(3) or m3.group(4) or m3.group(5) or m3.group(6)
                    )
                    references.append((m3.group(1), m3.group(2), col_part))

                # qualified: alias.column [AS output]
                m = re.match(
                    r'[`\[\"]?(\w+)[`\]\"]?\s*\.\s*'
                    r'(?:`([^`]+)`|"([^"]+)"|\[([^\]]+)\]|(\w+))'
                    r'(?:\s+AS\s+[`\[\"]?\w+[`\]\"]?)?$',
                    expr, re.IGNORECASE,
                )
                if m:
                    alias = m.group(1).lower()
                    col_name = (
                        m.group(2) or m.group(3) or m.group(4) or m.group(5)
                    )
                    if alias in table_refs:
                        local_db, local_table = table_refs[alias]
                        references.append((local_db, local_table, col_name))
                    continue

                # unqualified: column [AS output]
                m = re.match(
                    r'[`\[\"]?(\w+)[`\]\"]?'
                    r'(?:\s+AS\s+[`\[\"]?\w+[`\]\"]?)?$',
                    expr, re.IGNORECASE,
                )
                if m:
                    col_name = m.group(1)
                    if col_name.upper() in ('SELECT', 'FROM', 'AS'):
                        continue
                    if len(table_refs) >= 1:
                        # Assign to each unique table (we can't resolve
                        # ambiguity without the DB schema)
                        seen = set()
                        for ref_alias, (ld, lt) in table_refs.items():
                            key = (ld, lt)
                            if key not in seen:
                                references.append((ld, lt, col_name))
                                seen.add(key)
                                break

        provenance[view_name] = references

    return provenance


def _fragment_occurrence_multiplicity_from_spec(
    spec: Dict[str, Any],
) -> Dict[Tuple[str, str], int]:
    """
    For each (source_table, original_column), count how many logical fragments
    (one per ``locals[].tables`` entry) carry that column in ``column_map`` values.

    Attributes with count > 1 are ``repeated`` in the benchmark instance (vertical
    splits, horizontal fragments, etc.).
    """
    mult: Dict[Tuple[str, str], int] = defaultdict(int)
    for local in spec.get("locals", []) or []:
        if not local.get("local_name"):
            continue
        tables = local.get("tables") or {}
        if not isinstance(tables, dict):
            continue
        for _table_key, tinfo in tables.items():
            if not isinstance(tinfo, dict):
                continue
            source_table = tinfo.get("source_table")
            cmap = tinfo.get("column_map") or {}
            if not source_table or not isinstance(cmap, dict):
                continue
            orig_cols_this_fragment: Set[str] = set()
            for v in cmap.values():
                if isinstance(v, str) and v:
                    orig_cols_this_fragment.add(v)
            for oc in orig_cols_this_fragment:
                mult[(str(source_table), oc)] += 1
    return dict(mult)


def evaluate_attribute_provenance(
    gav_views: List[Tuple[str, str]],
    instance_dir: str,
    compiled_view_names: Optional[Set[str]] = None,
) -> Dict:
    """
    Metric 2: Column recall, precision, redundancy, and FK join credit.

    Traces each column referenced in the GAV rules through the ground-truth
    local→original mapping:
        GAV ref (local_db, local_table, local_col) -> (orig_table, orig_col)

    When compiled_view_names is provided, computes two sets of metrics:
      - compiled_only: metrics from compiled views only (original behavior)
      - all_views: metrics from all views including failed ones

    Redundancy / compactness:

    **Fragmentation A/B (``schema_compactness`` / ``column_redundancy_ratio``)**:
      - ``A`` = number of distinct original ``(table, column)`` pairs that occur in
        more than one logical fragment in ``mappings/transform_spec.json``.
      - ``B`` = count of valid GAV column references (after mapping) that target
        one of those attributes; duplicates count. Only **compiled** views contribute
        to ``B`` when ``compiled_view_names`` is provided (normal ``evaluate_solve`` path).
      - ``schema_compactness = A / B``; ``column_redundancy_ratio = B / A``.

    FK join credit: when a view JOINs two local columns that map to FK-related
    original columns, both sides of the FK are credited as found.
    """
    original_columns = _build_original_column_set(instance_dir)
    local_to_original = _build_local_to_original_map(instance_dir)
    fk_equivalences = _build_fk_equivalences(instance_dir)

    spec_path = os.path.join(instance_dir, "mappings", "transform_spec.json")
    frag_mult: Dict[Tuple[str, str], int] = {}
    try:
        with open(spec_path, encoding="utf-8") as sf:
            spec_data = json.load(sf)
        if isinstance(spec_data, dict):
            frag_mult = _fragment_occurrence_multiplicity_from_spec(spec_data)
    except (OSError, json.JSONDecodeError, TypeError):
        frag_mult = {}

    fragmented_attrs: Set[Tuple[str, str]] = {
        k for k, v in frag_mult.items() if int(v) > 1
    }
    fragmentation_A = len(fragmented_attrs)

    view_provenance = _extract_view_column_provenance(gav_views)

    found_original_columns: Set[Tuple[str, str]] = set()
    found_from_compiled: Set[Tuple[str, str]] = set()
    found_from_failed: Set[Tuple[str, str]] = set()

    total_gav_refs = 0
    valid_gav_refs = 0
    invalid_refs: List[Dict] = []

    per_view_detail: Dict[str, Dict] = {}

    fragmentation_B = 0

    for view_name, references in view_provenance.items():
        is_compiled = (
            compiled_view_names is None or view_name in compiled_view_names
        )
        view_found: Set[Tuple[str, str]] = set()
        view_total = 0
        view_valid = 0
        view_invalid: List[str] = []

        for local_db, local_table, local_col in references:
            total_gav_refs += 1
            view_total += 1

            key = (local_db, local_table, local_col)
            if key in local_to_original:
                orig_table, orig_col = local_to_original[key]
                found_original_columns.add((orig_table, orig_col))
                view_found.add((orig_table, orig_col))
                valid_gav_refs += 1
                view_valid += 1
                if is_compiled:
                    found_from_compiled.add((orig_table, orig_col))
                else:
                    found_from_failed.add((orig_table, orig_col))
                if is_compiled and (orig_table, orig_col) in fragmented_attrs:
                    fragmentation_B += 1
            else:
                matched = False
                for (ld, lt, lc), (ot, oc) in local_to_original.items():
                    if (ld.lower() == local_db.lower()
                            and lt.lower() == local_table.lower()
                            and lc.lower() == local_col.lower()):
                        found_original_columns.add((ot, oc))
                        view_found.add((ot, oc))
                        valid_gav_refs += 1
                        view_valid += 1
                        matched = True
                        if is_compiled:
                            found_from_compiled.add((ot, oc))
                        else:
                            found_from_failed.add((ot, oc))
                        if is_compiled and (ot, oc) in fragmented_attrs:
                            fragmentation_B += 1
                        break
                if not matched:
                    invalid_refs.append({
                        "view": view_name,
                        "local_ref": f"{local_db}.{local_table}.{local_col}",
                    })
                    view_invalid.append(
                        f"{local_db}.{local_table}.{local_col}"
                    )

        # Distinct originals mapped from this view (UNION branches merged).
        per_view_detail[view_name] = {
            "total_column_refs": view_total,
            "valid_refs": view_valid,
            "invalid_refs": view_invalid,
            "is_compiled": is_compiled,
            "distinct_original_columns_in_view": len(view_found),
            "original_columns_covered": sorted(
                f"{t}.{c}" for t, c in view_found
            ),
        }

    # FK join credit: parse JOIN conditions and credit both sides of FK pairs
    fk_credited: Set[Tuple[str, str]] = set()
    fk_credited_compiled: Set[Tuple[str, str]] = set()

    def _apply_fk_join_credit(
        join_pairs: List[Tuple[Tuple[str, str], Tuple[str, str]]],
        anchor_found: Set[Tuple[str, str]],
        into: Set[Tuple[str, str]],
    ) -> None:
        for orig_a, orig_b in join_pairs:
            pair_fwd = (orig_a, orig_b)
            pair_rev = (orig_b, orig_a)
            if pair_fwd in fk_equivalences or pair_rev in fk_equivalences:
                if orig_a in anchor_found and orig_b not in anchor_found:
                    if orig_b in original_columns:
                        into.add(orig_b)
                if orig_b in anchor_found and orig_a not in anchor_found:
                    if orig_a in original_columns:
                        into.add(orig_a)

    if fk_equivalences:
        for view_name, view_sql in gav_views:
            join_pairs = _extract_join_conditions(
                view_sql, local_to_original,
            )
            _apply_fk_join_credit(join_pairs, found_original_columns, fk_credited)
            if compiled_view_names is not None and view_name in compiled_view_names:
                _apply_fk_join_credit(
                    join_pairs, found_from_compiled, fk_credited_compiled,
                )

    found_with_fk = found_original_columns | fk_credited

    # Compute metrics for all views (including failed)
    # Cap recall at 1.0: FK-inferred columns may not appear in _parse_ddl_columns
    # (e.g. quoted table edge cases), so |found| can exceed len(original_columns).
    recall_all = min(
        1.0,
        len(found_with_fk) / max(1, len(original_columns)),
    )
    precision_all = valid_gav_refs / max(1, total_gav_refs)
    f1_all = (
        2 * precision_all * recall_all / (precision_all + recall_all)
        if (precision_all + recall_all) > 0 else 0.0
    )

    # Compiled-only: direct refs from compiled views + FK credit from those views only
    # (do not union global fk_credited, or recall stays > 0 when zero views compile)
    found_compiled_with_fk = (
        found_from_compiled | fk_credited_compiled
        if compiled_view_names is not None
        else found_with_fk
    )
    recall_compiled = (
        min(
            1.0,
            len(found_compiled_with_fk) / max(1, len(original_columns)),
        )
        if compiled_view_names is not None
        else recall_all
    )

    # Fragmentation A/B: A = fragmented originals; B = valid refs to them (compiled views).
    if fragmentation_A == 0:
        schema_compactness = 1.0
        column_redundancy_ratio = 0.0
    elif fragmentation_B == 0:
        schema_compactness = 0.0
        column_redundancy_ratio = 0.0
    else:
        schema_compactness = fragmentation_A / float(fragmentation_B)
        column_redundancy_ratio = fragmentation_B / float(fragmentation_A)

    # Per-table coverage (using all views + FK credit)
    per_table_coverage: Dict[str, Dict] = {}
    orig_by_table: Dict[str, List[str]] = defaultdict(list)
    for table, col in original_columns:
        orig_by_table[table].append(col)

    for table, cols in orig_by_table.items():
        found = [c for c in cols if (table, c) in found_with_fk]
        missing = [c for c in cols if (table, c) not in found_with_fk]
        found_direct = [c for c in cols if (table, c) in found_original_columns]
        found_via_fk = [c for c in cols if (table, c) in fk_credited]
        per_table_coverage[table] = {
            "total_columns": len(cols),
            "columns_found": len(found),
            "columns_found_direct": len(found_direct),
            "columns_found_via_fk": len(found_via_fk),
            "coverage": round(len(found) / max(1, len(cols)), 4),
            "missing_columns": missing,
        }

    result = {
        "column_recall": round(recall_all, 4),
        "column_precision": round(precision_all, 4),
        "column_f1": round(f1_all, 4),
        "total_original_columns": len(original_columns),
        "original_columns_found": len(found_with_fk),
        "original_columns_found_direct": len(found_original_columns),
        "original_columns_found_via_fk": len(fk_credited),
        "original_columns_missing": len(original_columns) - len(found_with_fk),
        "total_gav_column_refs": total_gav_refs,
        "valid_gav_refs": valid_gav_refs,
        "invalid_gav_refs": len(invalid_refs),
        "column_redundancy_ratio": round(column_redundancy_ratio, 4),
        "schema_compactness": round(schema_compactness, 4),
        "invalid_ref_details": invalid_refs[:20],
        "per_view_detail": per_view_detail,
        "per_table_coverage": per_table_coverage,
    }

    if compiled_view_names is not None:
        compiled_only_refs = 0
        compiled_only_valid = 0
        for vn, vd in per_view_detail.items():
            if vd["is_compiled"]:
                compiled_only_refs += vd["total_column_refs"]
                compiled_only_valid += vd["valid_refs"]
        precision_compiled = compiled_only_valid / max(1, compiled_only_refs)
        f1_compiled = (
            2 * precision_compiled * recall_compiled
            / (precision_compiled + recall_compiled)
            if (precision_compiled + recall_compiled) > 0 else 0.0
        )
        result["compiled_only"] = {
            "column_recall": round(recall_compiled, 4),
            "column_precision": round(precision_compiled, 4),
            "column_f1": round(f1_compiled, 4),
            "original_columns_found": len(found_compiled_with_fk),
        }

    return result


# ──────────────────────────────────────────────
# Metric 3: Tuple-Level Exact Match
# ──────────────────────────────────────────────

def _normalize_value(v: Any) -> Any:
    """Normalize a single value for set-based row comparison."""
    if v is None:
        return None
    if isinstance(v, float):
        return round(v, 6)
    return str(v)


def _parse_view_output_mapping(
    view_sql: str,
    local_to_original: Dict[Tuple[str, str, str], Tuple[str, str]],
) -> List[Dict[str, Tuple[str, str]]]:
    """
    Trace each output column of a CREATE VIEW through the provenance chain:
        view_output_col → local_col → original_col

    For UNION views, returns one mapping dict per UNION branch.
    Each dict maps: output_column_name → (original_table, original_column).
    """
    as_match = re.search(
        r'\bAS\s+(SELECT\b.+)', view_sql, re.IGNORECASE | re.DOTALL
    )
    if not as_match:
        return []

    select_body = as_match.group(1).strip()
    union_parts = re.split(
        r'\bUNION\b(?:\s+ALL\b)?', select_body, flags=re.IGNORECASE
    )

    return [
        _parse_branch_output_mapping(part.strip(), local_to_original)
        for part in union_parts
    ]


def _parse_branch_output_mapping(
    select_part: str,
    local_to_original: Dict[Tuple[str, str, str], Tuple[str, str]],
) -> Dict[str, Tuple[str, str]]:
    """
    Parse one SELECT ... FROM ... branch to build:
        {output_column_name: (original_table, original_column)}
    """
    KW_SET = {
        'ON', 'WHERE', 'GROUP', 'ORDER', 'HAVING', 'LIMIT',
        'INNER', 'LEFT', 'RIGHT', 'OUTER', 'CROSS', 'NATURAL',
        'JOIN', 'UNION', 'SET',
    }

    table_refs: Dict[str, Tuple[str, str]] = {}
    for m in re.finditer(
        # Accept common identifier quoting for both DB alias and table:
        #   local_1.table
        #   local_1."table"
        #   "local_1"."table"
        #   [local_1].[table]
        r'(?:FROM|JOIN)\s+[`"\[]?(\w+)[`"\]]?\s*\.\s*[`"\[]?(\w+)[`"\]]?'
        r'(?:\s+(?:AS\s+)?(\w+))?',
        select_part, re.IGNORECASE,
    ):
        local_db = m.group(1)
        local_table = m.group(2)
        alias = m.group(3)
        if alias and alias.upper() in KW_SET:
            alias = None
        alias = alias or local_table
        table_refs[alias.lower()] = (local_db, local_table)
        table_refs[local_table.lower()] = (local_db, local_table)

    from_match = re.search(r'\bFROM\b', select_part, re.IGNORECASE)
    if not from_match:
        return {}
    select_text = select_part[:from_match.start()].strip()
    if select_text.upper().startswith('SELECT'):
        select_text = select_text[6:].strip()

    mapping: Dict[str, Tuple[str, str]] = {}

    for expr in _split_comma_respecting_parens(select_text):
        expr = expr.strip()
        if not expr or expr == '*':
            continue

        output_name: Optional[str] = None
        local_col: Optional[str] = None
        resolved_alias: Optional[str] = None

        def _resolve_local_to_original(
            local_db: str, local_table: str, local_col: str,
        ) -> Optional[Tuple[str, str]]:
            key = (local_db, local_table, local_col)
            if key in local_to_original:
                return local_to_original[key]
            for (ld, lt, lc), (ot, oc) in local_to_original.items():
                if (ld.lower() == local_db.lower()
                        and lt.lower() == local_table.lower()
                        and lc.lower() == local_col.lower()):
                    return (ot, oc)
            return None

        # COALESCE(...) AS output  (best-effort passthrough mapping)
        # If every referenced local column inside COALESCE maps to the same original column,
        # we treat the output as that original column. This recovers common patterns like:
        #   COALESCE(local_1.T.c, local_2.T2.c, NULL) AS c
        # while avoiding ambiguous many-to-one merges.
        m = re.match(
            r'COALESCE\s*\((.+)\)\s+AS\s+[`\[\"]?(\w+)[`\]\"]?\s*$',
            expr,
            re.IGNORECASE | re.DOTALL,
        )
        if m:
            inner = m.group(1)
            output_name = m.group(2)
            targets: Set[Tuple[str, str]] = set()

            # Prefer explicit local_#.table.col references inside the args.
            for m3 in re.finditer(
                r'[`"\[]?(local_\d+)[`"\]]?\s*\.\s*[`"\[]?(\w+)[`"\]]?\s*\.\s*[`"\[]?(\w+)[`"\]]?',
                inner,
                re.IGNORECASE,
            ):
                ref = _resolve_local_to_original(m3.group(1), m3.group(2), m3.group(3))
                if ref is not None:
                    targets.add(ref)

            # Also accept alias.col references when the alias resolves via FROM/JOIN.
            for m2 in re.finditer(
                r'[`\[\"]?(\w+)[`\]\"]?\s*\.\s*[`\[\"]?(\w+)[`\]\"]?',
                inner,
                re.IGNORECASE,
            ):
                alias = m2.group(1).lower()
                col = m2.group(2)
                if alias in table_refs:
                    ld, lt = table_refs[alias]
                    ref = _resolve_local_to_original(ld, lt, col)
                    if ref is not None:
                        targets.add(ref)

            if len(targets) == 1:
                mapping[output_name] = next(iter(targets))
                continue
            # If ambiguous or unmapped, fall through to other patterns.
            output_name = None

        # alias.col AS output
        m = re.match(
            r'[`\[\"]?(\w+)[`\]\"]?\s*\.\s*[`\[\"]?(\w+)[`\]\"]?'
            r'\s+AS\s+[`\[\"]?(\w+)[`\]\"]?',
            expr, re.IGNORECASE,
        )
        if m:
            resolved_alias, local_col, output_name = (
                m.group(1).lower(), m.group(2), m.group(3),
            )

        # alias.col (no AS)
        if not output_name:
            m = re.match(
                r'[`\[\"]?(\w+)[`\]\"]?\s*\.\s*[`\[\"]?(\w+)[`\]\"]?\s*$',
                expr, re.IGNORECASE,
            )
            if m:
                resolved_alias = m.group(1).lower()
                local_col = m.group(2)
                output_name = local_col

        # col AS output (unqualified)
        if not output_name:
            m = re.match(
                r'[`\[\"]?(\w+)[`\]\"]?\s+AS\s+[`\[\"]?(\w+)[`\]\"]?',
                expr, re.IGNORECASE,
            )
            if m:
                local_col, output_name = m.group(1), m.group(2)
                if local_col.upper() in ('NULL', 'TRUE', 'FALSE'):
                    continue
                if local_col[:1].isdigit():
                    continue
                if table_refs:
                    resolved_alias = next(iter(table_refs))

        # just col (unqualified, no AS)
        if not output_name:
            m = re.match(
                r'[`\[\"]?(\w+)[`\]\"]?\s*$', expr, re.IGNORECASE,
            )
            if m:
                local_col = m.group(1)
                output_name = local_col
                if local_col.upper() in ('SELECT', 'FROM', 'AS', 'NULL'):
                    continue
                if table_refs:
                    resolved_alias = next(iter(table_refs))

        if not (output_name and local_col and resolved_alias):
            continue
        if resolved_alias not in table_refs:
            continue

        local_db, local_table = table_refs[resolved_alias]
        ref = _resolve_local_to_original(local_db, local_table, local_col)
        if ref is not None:
            mapping[output_name] = ref

    return mapping


def infer_original_db_path_from_instance(instance_dir: str) -> Optional[str]:
    """
    Infer path to the original SQLite DB without reading metadata.json.

    Uses ``mappings/transform_spec.json`` → ``vertical_split_selection`` →
    ``column_semantic_enrichment_path_resolved`` (same resolved path the
    generator used). The original BIRD-style DB is
    ``<dir(enrichment)>/<basename(dir)>.sqlite`` beside that JSON.
    """
    spec_path = os.path.join(instance_dir, "mappings", "transform_spec.json")
    if not os.path.isfile(spec_path):
        return None
    try:
        with open(spec_path, encoding="utf-8") as f:
            spec = json.load(f)
    except (OSError, json.JSONDecodeError):
        return None
    if not isinstance(spec, dict):
        return None
    vs = spec.get("vertical_split_selection") or {}
    if not isinstance(vs, dict):
        return None
    enrich = (vs.get("column_semantic_enrichment_path_resolved") or "").strip()
    if not enrich:
        return None
    enrich_abs = os.path.abspath(enrich)
    if not os.path.isfile(enrich_abs):
        return None
    db_dir = os.path.dirname(enrich_abs)
    folder = os.path.basename(db_dir)
    cand = os.path.join(db_dir, f"{folder}.sqlite")
    if os.path.isfile(cand):
        return cand
    for name in sorted(os.listdir(db_dir)):
        if name.lower().endswith(".sqlite"):
            return os.path.join(db_dir, name)
    return None


def evaluate_tuple_match(
    compiled_views: List[Dict],
    conn: sqlite3.Connection,
    instance_dir: str,
    *,
    mode: str = "full",
    max_view_rows: int = 0,
    max_orig_rows: int = 0,
) -> Dict:
    """
    Metric 3: Tuple-level exact match with PK-based comparison and
    multi-view combination.

    ``mode``:
    - ``full``: row sets, PK diagnostics, and aligned+full triplet micro-metrics.
    - ``triplet_only``: triplet metrics; by default **no row cap** (``max_view_rows`` /
      ``max_orig_rows`` of 0 = full table scans). Set caps > 0 to limit memory/time.
    - ``triplet_hybrid``: **paper / reproducible** hybrid triplet metric only
      (no aligned/full triplet blocks): full scans of compiled views and aligned
      original columns (no ``LIMIT``); PK-ordered original ``SELECT`` when PKs exist.

    For each *original* table:
    1. Collect ALL compiled views that cover it (not just the best).
    2. If multiple views share PK columns, combine them via PK-based join.
    3. Compare using both set-based matching (backward compat) and
       PK-based row matching with per-column accuracy.
    """
    meta_path = os.path.join(instance_dir, "metadata.json")
    raw_from_meta = ""
    if os.path.isfile(meta_path):
        with open(meta_path, encoding="utf-8") as f:
            metadata = json.load(f)
        raw_from_meta = (metadata.get("original_db_path") or "") if isinstance(metadata, dict) else ""
    else:
        metadata = {}

    def _resolve_original_db_path(raw_path: str) -> str:
        """
        Resolve original_db_path robustly when the repo was moved.

        Many instances were generated with absolute paths that later become stale,
        e.g. containing a duplicated repo segment:
          .../data-integration/data-integration/BIRD/...

        Strategy:
        1) If raw_path exists, use it.
        2) Strip the duplicated 'data-integration/data-integration/' segment when present.
        3) If the path contains '/data-integration/', take the suffix after it and
           treat it as repo-relative under the current repo root (inferred from instance_dir).
        """
        if raw_path and os.path.isfile(raw_path):
            return raw_path

        p = (raw_path or "")
        if "data-integration/data-integration/" in p:
            cand = p.replace("data-integration/data-integration/", "data-integration/")
            if os.path.isfile(cand):
                return cand

        marker = "/data-integration/"
        if marker in p:
            rel = p.split(marker, 1)[1]
            # If the old absolute path contained a nested repo (data-integration/data-integration/...),
            # the suffix will start with "data-integration/". Strip that extra segment so the
            # remainder is truly repo-relative (e.g., "BIRD/...").
            if rel.startswith("data-integration/"):
                rel = rel[len("data-integration/") :]
            # infer repo root as parent of SchemaVerse (instance_dir lives under it)
            inst_abs = os.path.abspath(instance_dir)
            if f"{os.sep}SchemaVerse{os.sep}" in inst_abs:
                repo_root = inst_abs.split(f"{os.sep}SchemaVerse{os.sep}", 1)[0]
            else:
                repo_root = os.path.abspath(os.path.join(inst_abs, os.pardir, os.pardir))
            cand2 = os.path.join(repo_root, rel)
            if os.path.isfile(cand2):
                return cand2

        return raw_path

    original_db_path = _resolve_original_db_path(raw_from_meta)
    if not original_db_path or not os.path.isfile(original_db_path):
        inferred = infer_original_db_path_from_instance(instance_dir)
        if inferred:
            original_db_path = _resolve_original_db_path(inferred)
    if not original_db_path or not os.path.isfile(original_db_path):
        raise FileNotFoundError(
            f"original_db_path not found for tuple match: {original_db_path!r} "
            f"(raw_metadata={raw_from_meta!r}; tried metadata.json if present, "
            f"else mappings/transform_spec.json column_semantic_enrichment_path_resolved)"
        )

    schema_path = os.path.join(instance_dir, "global", "original_schema.sql")
    with open(schema_path) as f:
        original_ddl = f.read()
    original_table_info = _parse_ddl_with_pks(original_ddl)
    original_tables = {
        t: info["columns"] for t, info in original_table_info.items()
    }
    original_pks = {
        t: info["primary_keys"] for t, info in original_table_info.items()
    }

    local_to_original = _build_local_to_original_map(instance_dir)
    orig_conn = sqlite3.connect(original_db_path)

    # ── Step 1: parse provenance mappings and pre-materialize views ──

    mode_lc = str(mode or "full").lower()
    is_hybrid = mode_lc == "triplet_hybrid"
    cap_view_rows = mode_lc == "triplet_only" and int(max_view_rows) > 0
    cap_orig_rows = mode_lc == "triplet_only" and int(max_orig_rows) > 0

    # Hybrid triplet metric: precision denom = every output cell of every compiled view
    # (rows × projection width), reproducible with full table scans (no row caps).
    pred_projection_cells = 0

    def _set_eval_pragmas(c: sqlite3.Connection) -> None:
        """
        Best-effort performance pragmas for read-heavy evaluation.

        These pragmas must not change query semantics or determinism of results.
        """
        for stmt in (
            "PRAGMA foreign_keys=OFF",
            "PRAGMA automatic_index=ON",
            "PRAGMA temp_store=MEMORY",
            "PRAGMA cache_size=-200000",  # ~200MB (KiB units when negative)
            "PRAGMA synchronous=OFF",
            "PRAGMA journal_mode=OFF",
        ):
            try:
                c.execute(stmt)
            except Exception:
                pass

    def _progress(it, *, total: Optional[int], desc: str):
        """
        Best-effort progress indicator.

        - Uses tqdm when installed.
        - Falls back to a lightweight stderr progress printer when tqdm isn't available.
        """
        try:  # pragma: no cover
            from tqdm.auto import tqdm  # type: ignore

            return tqdm(it, total=total, desc=desc, unit="item", leave=False)
        except Exception:
            import sys
            import time

            if total is None or total <= 0:
                return it

            # Print at most every ~2 seconds (and on final item).
            start = time.monotonic()
            last_print = start

            def _fmt_s(sec: float) -> str:
                sec = max(0.0, float(sec))
                if sec < 60:
                    return f"{sec:.1f}s"
                if sec < 3600:
                    return f"{sec/60.0:.1f}m"
                return f"{sec/3600.0:.2f}h"

            for idx, item in enumerate(it, start=1):
                now = time.monotonic()
                if (now - last_print) >= 2.0 or idx == int(total):
                    pct = 100.0 * float(idx) / float(total)
                    elapsed = now - start
                    rate = float(idx) / elapsed if elapsed > 0 else 0.0
                    eta = (float(total - idx) / rate) if rate > 0 else float("nan")
                    eta_s = _fmt_s(eta) if not math.isnan(eta) else "?"
                    print(
                        f"[{desc}] {idx}/{total} ({pct:.1f}%) "
                        f"elapsed={_fmt_s(elapsed)} eta={eta_s}",
                        file=sys.stderr,
                        flush=True,
                    )
                    last_print = now
                yield item

    if is_hybrid:
        _set_eval_pragmas(conn)
        _set_eval_pragmas(orig_conn)
        # Allow SQL-side comparison between predicted (locals) and original DB.
        # Use a stable attachment name; ignore "already attached" errors if re-entered.
        try:
            # Escape single quotes for SQLite string literal.
            odb = str(original_db_path).replace("'", "''")
            conn.execute(f"ATTACH DATABASE '{odb}' AS origdb")
        except sqlite3.OperationalError as e:
            msg = str(e).lower()
            if "already" in msg and ("origdb" in msg or "in use" in msg):
                # Safe to proceed; origdb is already attached.
                pass
            else:
                # In hybrid mode, failing to attach makes common-fact computation meaningless.
                raise

    view_data: Dict[str, Dict] = {}
    view_scan_errors: List[Dict[str, str]] = []
    view_iter = _progress(
        compiled_views,
        total=len(compiled_views) if isinstance(compiled_views, list) else None,
        desc="triplet_hybrid: scanning compiled views",
    ) if is_hybrid else compiled_views
    for view_info in view_iter:
        view_name = view_info["view_name"]
        view_sql = view_info.get("sql", "")
        select_body = view_info.get("select_body", "")
        if not select_body:
            if is_hybrid and len(view_scan_errors) < 10:
                view_scan_errors.append({
                    "view": str(view_name),
                    "error": "missing select_body on compiled view (unexpected)",
                })
            continue

        branch_mappings = _parse_view_output_mapping(
            view_sql, local_to_original,
        )

        table_col_pairs: Dict[str, List[Tuple[str, str]]] = defaultdict(list)
        seen: Dict[str, Set[str]] = defaultdict(set)
        for branch in branch_mappings:
            for output_col, (orig_table, orig_col) in branch.items():
                if output_col not in seen[orig_table]:
                    table_col_pairs[orig_table].append(
                        (output_col, orig_col),
                    )
                    seen[orig_table].add(output_col)

        try:
            # Clean SELECT body for embedding in a subquery. Many generators include a trailing
            # semicolon which breaks `FROM (<sql>)` in SQLite.
            select_body_clean = (select_body or "").strip()
            while select_body_clean.endswith(";"):
                select_body_clean = select_body_clean[:-1].rstrip()

            # Read schema (column names) without materializing rows.
            cursor0 = conn.execute(f"SELECT * FROM ({select_body_clean}) LIMIT 0")
            if cursor0.description is None:
                if is_hybrid and len(view_scan_errors) < 10:
                    view_scan_errors.append({
                        "view": str(view_name),
                        "error": "no cursor description for SELECT (unexpected)",
                    })
                continue
            columns = [d[0] for d in cursor0.description]

            if is_hybrid:
                # Precision denominator counts every produced cell in every compiled view.
                nrows = conn.execute(
                    f"SELECT COUNT(*) FROM ({select_body_clean})"
                ).fetchone()[0]
                pred_projection_cells += int(nrows) * int(len(columns))
                rows = None
            else:
                cursor = conn.execute(select_body_clean)
                if cursor.description is None:
                    continue
                if cap_view_rows:
                    rows = cursor.fetchmany(int(max_view_rows))
                else:
                    rows = cursor.fetchall()
        except Exception as e:
            # In hybrid mode we must know why scanning failed; collect a small sample.
            if is_hybrid and len(view_scan_errors) < 10:
                view_scan_errors.append({
                    "view": str(view_name),
                    "error": f"{type(e).__name__}: {e}",
                })
            continue

        view_data[view_name] = {
            "table_col_pairs": dict(table_col_pairs),
            "columns": columns,
            "rows": rows,
            "select_body": select_body_clean,
        }

    # ── Step 2: for each original table, combine views and compare ──

    per_original_table: Dict[str, Dict] = {}
    exact_matches = 0

    def _qi(name: str) -> str:
        safe = (name or "").replace("]", "]]")
        return f"[{safe}]"

    def _hybrid_common_cells_for_table(
        *,
        orig_table: str,
        pk_cols: List[str],
        matched_views: List[str],
        valid_pairs: List[Tuple[str, str]],
    ) -> Optional[int]:
        """
        SQL-side multiset-like common-cell count using PK + deterministic occurrence index.

        - Build per-view ranked rows with occ = row_number(partition by PK order by compared columns).
        - Create a full PK+occ universe (union across views), then join all ranked views onto it.
          This avoids dropping rows that exist only in a "non-anchor" view.
        - For each column, take COALESCE across views (first non-NULL wins).
        - Join predicted vs original on (pk, occ) and count per-cell equality using NULL-safe IS.
        """
        if not valid_pairs:
            return 0

        col_list = [oc for _, oc in valid_pairs]
        if pk_cols and (not all(pk in col_list for pk in pk_cols)):
            return None

        # Build per-view subqueries that expose only needed columns, aliased to original column names.
        needed_by_oc = {oc: vc for vc, oc in valid_pairs}

        # No-PK fallback (still exact/full-data):
        # Compare predicted vs original as multisets of rows over the compared columns.
        # common_cells = common_rows * number_of_compared_columns.
        #
        # This is heavier than PK alignment but avoids pathological all-zero hybrid scores on
        # schemas whose original DDL doesn't declare PKs (common in Spider/Spider2).
        if not pk_cols:
            # Pick the first usable matched view (we cannot reliably "merge" multiple views without PKs).
            chosen: Optional[Tuple[str, str]] = None  # (view_name, select_body)
            chosen_cols: Set[str] = set()
            for vn in matched_views:
                vd = view_data.get(vn) or {}
                sb = vd.get("select_body") or ""
                cols = set(vd.get("columns") or [])
                if sb and cols:
                    chosen = (vn, sb)
                    chosen_cols = cols
                    break
            if chosen is None:
                return 0

            _vn, select_body = chosen
            proj = []
            for oc in col_list:
                vc = needed_by_oc.get(oc)
                if vc and vc in chosen_cols:
                    proj.append(f"v.{_qi(vc)} AS {_qi(oc)}")
                else:
                    proj.append(f"NULL AS {_qi(oc)}")
            pred0 = f"SELECT {', '.join(proj)} FROM ({select_body}) v"
            orig0 = f"SELECT {', '.join(_qi(c) for c in col_list)} FROM origdb.{_qi(orig_table)}"
            group_cols = ", ".join(_qi(c) for c in col_list)
            join_on = " AND ".join(f"p.{_qi(c)} IS o.{_qi(c)}" for c in col_list) or "1=1"

            sql = f"""
WITH
predg AS (
  SELECT {group_cols}, COUNT(*) AS cnt
  FROM ({pred0})
  GROUP BY {group_cols}
),
origg AS (
  SELECT {group_cols}, COUNT(*) AS cnt
  FROM ({orig0})
  GROUP BY {group_cols}
)
SELECT SUM(MIN(p.cnt, o.cnt)) AS common_rows
FROM predg p
JOIN origg o
  ON {join_on}
"""
            try:
                common_rows = conn.execute(sql).fetchone()[0]
                common_rows_i = int(common_rows or 0)
                return common_rows_i * int(len(col_list))
            except Exception as e:
                _hybrid_common_cells_for_table._last_error = f"{type(e).__name__}: {e}"  # type: ignore[attr-defined]
                return None

        def _distinct_pk_count_sql(*, from_sql: str, pk_cols_: List[str]) -> str:
            pk_sel = ", ".join(_qi(c) for c in pk_cols_)
            pk_not_null = " AND ".join(f"{_qi(c)} IS NOT NULL" for c in pk_cols_)
            where = f" WHERE {pk_not_null}" if pk_not_null else ""
            # SQLite has no COUNT(DISTINCT a, b) for composite keys; use GROUP BY.
            return (
                f"SELECT COUNT(*) FROM ("
                f"SELECT {pk_sel} FROM ({from_sql}){where} GROUP BY {pk_sel}"
                f")"
            )

        def _pk_is_unique_in(*, from_sql: str, pk_cols_: List[str]) -> Optional[bool]:
            if not pk_cols_:
                return None
            pk_not_null = " AND ".join(f"{_qi(c)} IS NOT NULL" for c in pk_cols_)
            where = f" WHERE {pk_not_null}" if pk_not_null else ""
            try:
                n = conn.execute(f"SELECT COUNT(*) FROM ({from_sql}){where}").fetchone()[0]
                nd = conn.execute(
                    _distinct_pk_count_sql(from_sql=from_sql, pk_cols_=pk_cols_)
                ).fetchone()[0]
                return int(n) == int(nd)
            except Exception:
                return None

        # Fast path: if PK is unique in the original table and in each participating view output,
        # we can skip ROW_NUMBER() entirely (occ is always 1). This avoids heavy sorts.
        try:
            orig_from = f"SELECT {', '.join(_qi(c) for c in col_list)} FROM origdb.{_qi(orig_table)}"
            orig_pk_unique = _pk_is_unique_in(from_sql=orig_from, pk_cols_=pk_cols)
        except Exception:
            orig_pk_unique = None

        view_base_sqls: List[Tuple[str, str]] = []  # (alias, base_sql)
        view_pk_unique: List[Optional[bool]] = []
        for i, vn in enumerate(matched_views):
            vd = view_data.get(vn) or {}
            select_body = vd.get("select_body") or ""
            cols = set(vd.get("columns") or [])
            if not select_body or not cols:
                continue

            # This view must expose PK columns (under some output name mapped to pk oc).
            for pk in pk_cols:
                vc_pk = needed_by_oc.get(pk)
                if not vc_pk or vc_pk not in cols:
                    # cannot align this view on PK+occ
                    break
            else:
                # Project a fixed schema: all columns in col_list (missing -> NULL).
                proj = []
                for oc in col_list:
                    vc = needed_by_oc.get(oc)
                    if vc and vc in cols:
                        proj.append(f"v.{_qi(vc)} AS {_qi(oc)}")
                    else:
                        proj.append(f"NULL AS {_qi(oc)}")
                base = f"SELECT {', '.join(proj)} FROM ({select_body}) v"
                alias = f"v{i}"
                view_base_sqls.append((alias, base))
                view_pk_unique.append(_pk_is_unique_in(from_sql=base, pk_cols_=pk_cols))

        if not view_base_sqls:
            return 0

        pk_part = ", ".join(_qi(c) for c in pk_cols)
        order_cols = ", ".join(_qi(c) for c in col_list)

        can_use_unique_pk_fast_path = (
            (orig_pk_unique is True)
            and (len(view_pk_unique) == len(view_base_sqls))
            and all(v is True for v in view_pk_unique)
        )

        if can_use_unique_pk_fast_path:
            pk_union = " UNION ALL ".join(
                f"SELECT {', '.join(_qi(c) for c in pk_cols)} FROM {a}"
                for a, _ in view_base_sqls
            )

            def _coalesce_fast(col: str) -> str:
                if len(view_base_sqls) == 1:
                    a0 = view_base_sqls[0][0]
                    return f"{a0}.{_qi(col)} AS {_qi(col)}"
                terms = ", ".join(f"{a}.{_qi(col)}" for a, _ in view_base_sqls)
                return f"COALESCE({terms}) AS {_qi(col)}"

            pred_select_cols_fast = (
                [f"pkset.{_qi(c)} AS {_qi(c)}" for c in pk_cols]
                + [_coalesce_fast(c) for c in col_list if c not in pk_cols]
            )
            join_pred_fast = " ".join(
                f"LEFT JOIN {a} ON "
                + " AND ".join([f"{a}.{_qi(pk)} IS pkset.{_qi(pk)}" for pk in pk_cols])
                for a, _ in view_base_sqls
            )
            eq_terms_fast = " + ".join(f"(p.{_qi(c)} IS o.{_qi(c)})" for c in col_list)
            orig_cols_sql_fast = ", ".join(_qi(c) for c in col_list)
            sql_fast = f"""
WITH
{", ".join(f"{a} AS ({s})" for a, s in view_base_sqls)},
pkset AS (
  SELECT DISTINCT {", ".join(_qi(c) for c in pk_cols)}
  FROM ({pk_union})
),
pred AS (
  SELECT {", ".join(pred_select_cols_fast)}
  FROM pkset
  {join_pred_fast}
),
orig AS (
  SELECT {orig_cols_sql_fast}
  FROM origdb.{_qi(orig_table)}
)
SELECT SUM({eq_terms_fast}) AS common_cells
FROM pred p
JOIN orig o
  ON {" AND ".join(f"p.{_qi(pk)} IS o.{_qi(pk)}" for pk in pk_cols)}
"""
            try:
                v_fast = conn.execute(sql_fast).fetchone()[0]
                return int(v_fast or 0)
            except Exception as e:
                # Fall back to fully general occ-based logic.
                _hybrid_common_cells_for_table._last_error = f"{type(e).__name__}: {e}"  # type: ignore[attr-defined]

        # General (duplicate-PK-safe) path: compute occ per PK deterministically.
        view_ranked: List[Tuple[str, str]] = []  # (alias, ranked_sql)
        for a, base in view_base_sqls:
            ranked_sql = (
                "SELECT *, "
                f"ROW_NUMBER() OVER (PARTITION BY {pk_part} ORDER BY {order_cols}) AS occ "
                f"FROM ({base})"
            )
            view_ranked.append((a, ranked_sql))

        # Build a PK+occ universe across all ranked views.
        pkocc_union = " UNION ALL ".join(
            f"SELECT {', '.join(_qi(c) for c in pk_cols)}, occ FROM {a}"
            for a, _ in view_ranked
        )

        # Combined predicted rows: COALESCE each column across views in order.
        def _coalesce(col: str) -> str:
            if len(view_ranked) == 1:
                a0 = view_ranked[0][0]
                return f"{a0}.{_qi(col)} AS {_qi(col)}"
            terms = ", ".join(f"{a}.{_qi(col)}" for a, _ in view_ranked)
            return f"COALESCE({terms}) AS {_qi(col)}"

        pred_select_cols = (
            [f"pkocc.{_qi(c)} AS {_qi(c)}" for c in pk_cols]
            + ["pkocc.occ AS occ"]
            + [_coalesce(c) for c in col_list if c not in pk_cols]
        )

        join_pred = " ".join(
            f"LEFT JOIN {a} ON "
            + " AND ".join(
                [f"{a}.{_qi(pk)} IS pkocc.{_qi(pk)}" for pk in pk_cols] + [f"{a}.occ = pkocc.occ"]
            )
            for a, _ in view_ranked
        )

        # Note: we include PK columns in equality implicitly via the join; they also appear in col_list.
        # For per-cell equality, count all col_list columns including PKs.
        eq_terms = " + ".join(f"(p.{_qi(c)} IS o.{_qi(c)})" for c in col_list)

        # Original ranked rows (PK+occ)
        orig_cols_sql = ", ".join(_qi(c) for c in col_list)
        sql = f"""
WITH
{", ".join(f"{a} AS ({s})" for a, s in view_ranked)},
pkocc AS (
  SELECT DISTINCT {", ".join(_qi(c) for c in pk_cols)}, occ
  FROM ({pkocc_union})
),
pred AS (
  SELECT {", ".join(pred_select_cols)}
  FROM pkocc
  {join_pred}
),
orig0 AS (
  SELECT {orig_cols_sql}
  FROM origdb.{_qi(orig_table)}
),
orig AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY {pk_part} ORDER BY {order_cols}) AS occ
  FROM orig0
)
SELECT SUM({eq_terms}) AS common_cells
FROM pred p
JOIN orig o
  ON {" AND ".join(f"p.{_qi(pk)} IS o.{_qi(pk)}" for pk in pk_cols)}
 AND p.occ = o.occ
"""
        try:
            v = conn.execute(sql).fetchone()[0]
            return int(v or 0)
        except Exception as e:
            # Caller will mark as sql_failed; keep the error discoverable without huge SQL dumps.
            _hybrid_common_cells_for_table._last_error = f"{type(e).__name__}: {e}"  # type: ignore[attr-defined]
            return None

    def _build_fact_set(
        table: str,
        col_names: List[str],
        rows_list: List[tuple],
        pk_indices: Optional[List[int]] = None,
    ) -> Counter:
        """
        Build atomic facts as (table, subject, predicate, object).

        - subject: PK tuple when available; otherwise full row tuple.
        - duplicates: when PKs are available, disambiguate duplicate PK rows
          with a deterministic occurrence counter (penalizes duplication).
          Without PKs, duplicates are still tracked (multiset semantics).
        """
        if not rows_list or not col_names:
            return Counter()
        facts: Counter = Counter()

        # PK mode: group by PK, sort rows deterministically within each PK.
        if pk_indices:
            by_pk: Dict[tuple, List[tuple]] = defaultdict(list)
            for row in rows_list:
                pk = tuple(row[i] for i in pk_indices)
                by_pk[pk].append(tuple(row))
            for pk, group_rows in by_pk.items():
                group_rows.sort(key=_sqlite_row_sort_key)
                for occ_idx, row in enumerate(group_rows, start=1):
                    subject = (pk, occ_idx)
                    for j, col in enumerate(col_names):
                        facts[(table, subject, col, row[j])] += 1
            return facts

        # No-PK mode: subject is the row tuple itself.
        for row in rows_list:
            subject = tuple(row)
            for j, col in enumerate(col_names):
                facts[(table, subject, col, row[j])] += 1
        return facts

    # Triplet/fact metrics:
    # - aligned_*: only over compared tables+aligned columns (can be 1.0 even if other tables are missing)
    # - full_*: recall denominator includes ALL original-table facts (missing tables reduce recall)
    # - hybrid: common multiset on aligned reconstructed facts only; recall denom = all original cells;
    #   precision denom = sum over compiled views of (rows × projected columns)
    fact_pred_total_aligned = 0
    fact_orig_total_aligned = 0
    fact_common_total_aligned = 0

    fact_pred_total_full = 0
    fact_orig_total_full = 0
    fact_common_total_full = 0

    fact_common_total_hybrid = 0

    table_iter = _progress(
        list(original_tables.items()),
        total=len(original_tables),
        desc="triplet_hybrid: comparing original tables",
    ) if is_hybrid else original_tables.items()

    for orig_table, orig_cols in table_iter:
        pk_cols = original_pks.get(orig_table, [])

        covering_views: List[Tuple[str, List[Tuple[str, str]]]] = []
        for view_name, vd in view_data.items():
            pairs = vd["table_col_pairs"].get(orig_table, [])
            if pairs:
                covering_views.append((view_name, pairs))

        if not covering_views:
            # For full-schema fact recall, uncovered tables contribute 0 predicted facts
            # but DO contribute their original facts count.
            try:
                orig_cnt = orig_conn.execute(
                    f"SELECT COUNT(*) FROM [{orig_table}]"
                ).fetchone()[0]
                fact_orig_total_full += int(orig_cnt) * int(len(orig_cols))
            except Exception:
                pass
            per_original_table[orig_table] = {
                "status": "not_covered",
                "total_original_columns": len(orig_cols),
                "columns_covered": 0,
                "exact_match": False,
            }
            continue

        # Try to combine multiple views via PK-based join
        combined_pairs, matched_views = _combine_views_for_table(
            orig_table, pk_cols, covering_views, view_data,
        )

        if not combined_pairs:
            per_original_table[orig_table] = {
                "status": "column_index_mismatch",
                "matched_views": matched_views,
                "total_original_columns": len(orig_cols),
                "columns_covered": 0,
                "exact_match": False,
            }
            continue

        # Hybrid: avoid Python materialization; compute common facts via SQL and skip aligned/full triplet blocks.
        if is_hybrid:
            # valid_pairs: those present in at least one matched view output schema
            all_cols_by_view: Dict[str, Set[str]] = {
                vn: set(view_data.get(vn, {}).get("columns") or []) for vn in matched_views
            }
            valid_pairs = [
                (vc, oc)
                for vc, oc in combined_pairs
                if any(vc in all_cols_by_view.get(vn, set()) for vn in matched_views)
            ]

            # Update per-table record (for debugging/inspection).
            table_result: Dict[str, Any] = {
                "status": "compared" if valid_pairs else "combine_failed",
                "matched_views": matched_views,
                "columns_compared": len(valid_pairs),
                "total_original_columns": len(orig_cols),
                "column_coverage": round(
                    len(valid_pairs) / max(1, len(orig_cols)), 4,
                ),
                "column_mapping": {vc: oc for vc, oc in valid_pairs},
                "exact_match": False,
            }

            common_cells = _hybrid_common_cells_for_table(
                orig_table=orig_table,
                pk_cols=pk_cols,
                matched_views=matched_views,
                valid_pairs=valid_pairs,
            )
            if common_cells is None:
                table_result["status"] = "hybrid_pk_required_or_sql_failed"
                err = getattr(_hybrid_common_cells_for_table, "_last_error", None)
                if err:
                    table_result["sql_error"] = str(err)[:500]
                table_result["triplet_match"] = {
                    "common_facts": None,
                    "subject_mode": "pk_required",
                }
            else:
                fact_common_total_hybrid += int(common_cells)
                table_result["triplet_match"] = {
                    "common_facts": int(common_cells),
                    "subject_mode": "pk",
                }

            # Full-schema denominator still counts all original cells (handled below).
            per_original_table[orig_table] = table_result

            # Add original full-schema cell count for this table (no sampling).
            try:
                orig_cnt_full = orig_conn.execute(
                    f"SELECT COUNT(*) FROM [{orig_table}]"
                ).fetchone()[0]
                fact_orig_total_full += int(orig_cnt_full) * int(len(orig_cols))
            except Exception:
                pass
            continue

        # Build predicted rows from combined pairs
        pred_rows_list: List[tuple] = []
        if len(matched_views) == 1:
            vd = view_data[matched_views[0]]
            col_idx = {c: i for i, c in enumerate(vd["columns"])}
            valid_pairs = [
                (vc, oc) for vc, oc in combined_pairs if vc in col_idx
            ]
            pred_rows_list = []
            for row in vd["rows"]:
                pred_rows_list.append(tuple(
                    _normalize_value(row[col_idx[vc]])
                    for vc, oc in valid_pairs
                ))
            pred_rows = set(pred_rows_list) if mode_lc == "full" else set()
        else:
            valid_pairs, pred_rows, pred_rows_list = _materialize_combined_views(
                orig_table, pk_cols, matched_views, combined_pairs, view_data,
            )
            if not valid_pairs:
                per_original_table[orig_table] = {
                    "status": "combine_failed",
                    "matched_views": matched_views,
                    "total_original_columns": len(orig_cols),
                    "columns_covered": 0,
                    "exact_match": False,
                }
                continue
            if mode_lc != "full":
                pred_rows = set()

        # Query original table for the corresponding original columns
        orig_col_str = ", ".join(f"[{oc}]" for _, oc in valid_pairs)
        orig_rows: Set[tuple] = set()
        orig_rows_list: List[tuple] = []
        try:
            if cap_orig_rows:
                query = (
                    f"SELECT {orig_col_str} FROM [{orig_table}] "
                    f"LIMIT {int(max_orig_rows)}"
                )
            elif is_hybrid and pk_cols:
                order_clause = ", ".join(f"[{c}]" for c in pk_cols)
                query = (
                    f"SELECT {orig_col_str} FROM [{orig_table}] "
                    f"ORDER BY {order_clause}"
                )
            else:
                query = f"SELECT {orig_col_str} FROM [{orig_table}]"
            for row in orig_conn.execute(query).fetchall():
                norm = tuple(_normalize_value(v) for v in row)
                orig_rows_list.append(norm)
                if mode_lc == "full":
                    orig_rows.add(norm)
        except Exception as e:
            per_original_table[orig_table] = {
                "status": "original_query_error",
                "error": str(e),
                "exact_match": False,
            }
            continue

        # Row-level comparison (full mode only; can be very memory heavy)
        if mode_lc == "full":
            common = pred_rows & orig_rows
            only_pred = pred_rows - orig_rows
            only_orig = orig_rows - pred_rows
            is_match = len(only_pred) == 0 and len(only_orig) == 0
        else:
            common = set()
            only_pred = set()
            only_orig = set()
            is_match = False

        if is_match:
            exact_matches += 1

        row_recall = (len(common) / max(1, len(orig_rows))) if mode_lc == "full" else 0.0

        table_result: Dict[str, Any] = {
            "status": "compared",
            "matched_views": matched_views,
            "columns_compared": len(valid_pairs),
            "total_original_columns": len(orig_cols),
            "column_coverage": round(
                len(valid_pairs) / max(1, len(orig_cols)), 4,
            ),
            "column_mapping": {vc: oc for vc, oc in valid_pairs},
            "predicted_rows": (len(pred_rows) if mode_lc == "full" else None),
            "original_rows": (len(orig_rows) if mode_lc == "full" else None),
            "common_rows": (len(common) if mode_lc == "full" else None),
            "rows_missing": (len(only_orig) if mode_lc == "full" else None),
            "rows_extra": (len(only_pred) if mode_lc == "full" else None),
            "exact_match": is_match,
            "row_recall": round(row_recall, 4),
        }

        # Triplet-based (atomic fact) comparison
        orig_col_list = [oc for _, oc in valid_pairs]
        pk_indices: Optional[List[int]] = None
        if pk_cols:
            pk_indices_tmp: List[int] = []
            ok = True
            for pk in pk_cols:
                if pk in orig_col_list:
                    pk_indices_tmp.append(orig_col_list.index(pk))
                else:
                    ok = False
                    break
            if ok and pk_indices_tmp:
                pk_indices = pk_indices_tmp

        pred_facts = _build_fact_set(
            orig_table, orig_col_list, pred_rows_list, pk_indices
        )
        orig_facts = _build_fact_set(
            orig_table, orig_col_list, orig_rows_list, pk_indices
        )
        common_facts = pred_facts & orig_facts
        pred_fact_count = sum(pred_facts.values())
        orig_fact_count = sum(orig_facts.values())
        common_fact_count = sum(common_facts.values())

        fact_precision = common_fact_count / max(1, pred_fact_count)
        fact_recall = common_fact_count / max(1, orig_fact_count)
        fact_f1 = (
            2 * fact_precision * fact_recall / (fact_precision + fact_recall)
            if (fact_precision + fact_recall) > 0 else 0.0
        )

        if is_hybrid:
            fact_common_total_hybrid += common_fact_count
        else:
            # Aligned micro totals (only aligned/compared columns)
            fact_pred_total_aligned += pred_fact_count
            fact_orig_total_aligned += orig_fact_count
            fact_common_total_aligned += common_fact_count

            # Full-schema micro totals:
            # - predicted facts: only what the view actually provides (subset of columns)
            # - original facts: ALL facts from the original table (all columns)
            # - common facts: facts that match among the predicted subset
            fact_pred_total_full += pred_fact_count
            fact_common_total_full += common_fact_count

        if mode_lc in ("triplet_only", "triplet_hybrid"):
            # Use true table row count (no need to materialize all rows).
            try:
                orig_cnt_full = orig_conn.execute(
                    f"SELECT COUNT(*) FROM [{orig_table}]"
                ).fetchone()[0]
                fact_orig_total_full += int(orig_cnt_full) * int(len(orig_cols))
            except Exception:
                fact_orig_total_full += int(len(orig_rows_list)) * int(len(orig_cols))
        elif not is_hybrid:
            fact_orig_total_full += int(len(orig_rows_list)) * int(len(orig_cols))

        table_result["triplet_match"] = {
            "predicted_facts": pred_fact_count,
            "original_facts": orig_fact_count,
            "common_facts": common_fact_count,
            "fact_precision": round(fact_precision, 4),
            "fact_recall": round(fact_recall, 4),
            "fact_f1": round(fact_f1, 4),
            "subject_mode": "pk" if pk_indices else "row",
        }

        # PK-based comparison when PKs are available (full mode only; can be heavy)
        if mode_lc == "full":
            pk_result = _pk_based_comparison(
                orig_table, pk_cols, valid_pairs, pred_rows, orig_conn,
            )
            if pk_result:
                table_result["pk_comparison"] = pk_result

        per_original_table[orig_table] = table_result

    # In hybrid mode, zeros in both denominators almost always mean we silently skipped
    # view scanning and/or original DB counting due to exceptions. That makes the report
    # misleading, so fail loud.
    if is_hybrid:
        if compiled_views and pred_projection_cells == 0:
            detail = ""
            if view_scan_errors:
                detail = " Scan errors (first few): " + "; ".join(
                    f"{d.get('view')} -> {d.get('error')}" for d in view_scan_errors
                )
            # If we have no recorded per-view exceptions, add a targeted diagnostic:
            # show attached DBs and attempt to COUNT(*) the first compiled view.
            diag = ""
            if not view_scan_errors:
                try:
                    dbs = conn.execute("PRAGMA database_list").fetchall()
                    diag_parts = [f"{name}={file}" for _, name, file in dbs]
                    diag = " PRAGMA database_list: " + ", ".join(diag_parts)
                except Exception:
                    diag = ""
                try:
                    v0 = compiled_views[0]
                    vb = v0.get("select_body") or ""
                    vn = v0.get("view_name") or "<?>"
                    if vb:
                        n0 = conn.execute(f"SELECT COUNT(*) FROM ({vb})").fetchone()[0]
                        diag += f" first_view={vn} count={n0}"
                    else:
                        diag += f" first_view={vn} select_body_missing"
                except Exception as e:
                    diag += f" first_view_count_error={type(e).__name__}: {e}"

            raise RuntimeError(
                "triplet_hybrid produced predicted_projection_cells=0 despite having compiled views. "
                "This indicates every compiled view SELECT failed during scanning (e.g., SQL parse error)."
                + detail
                + diag
            )
        if original_tables and fact_orig_total_full == 0:
            raise RuntimeError(
                "triplet_hybrid produced original_facts_all_schema=0 despite having original tables. "
                "This indicates original DB counting failed (e.g., original_db_path mismatch or table-name mismatch)."
            )

    compared = [
        v for v in per_original_table.values()
        if v.get("status") == "compared"
    ]

    # PK-based aggregates (full mode only)
    if mode_lc == "full":
        pk_compared = [v for v in compared if "pk_comparison" in v]
        avg_pk_row_match = (
            sum(v["pk_comparison"]["pk_row_match_rate"] for v in pk_compared)
            / len(pk_compared)
            if pk_compared else None
        )
        avg_pk_cell_accuracy = (
            sum(v["pk_comparison"]["overall_cell_accuracy"] for v in pk_compared)
            / len(pk_compared)
            if pk_compared else None
        )
    else:
        avg_pk_row_match = None
        avg_pk_cell_accuracy = None

    result: Dict[str, Any] = {
        "mode": mode_lc,
        "per_original_table": per_original_table,
    }
    if avg_pk_row_match is not None:
        result["avg_pk_row_match_rate"] = round(avg_pk_row_match, 4)
    if avg_pk_cell_accuracy is not None:
        result["avg_pk_cell_accuracy"] = round(avg_pk_cell_accuracy, 4)

    # Triplet-based (atomic fact) micro metrics across all compared columns/tables
    #
    # Relationship to attribute_provenance.column_recall (different quantities):
    #   - Column recall = |distinct (orig_table, orig_col) referenced in GAV| / |all schema columns|.
    #     A column is "found" if it appears at least once in any view SQL (mapped correctly).
    #   - Triplet full recall = sum(common atomic facts) / sum(all atomic facts in the original DB).
    #     Each cell (row × column) is one fact; uncovered tables and unmapped columns still add to
    #     the denominator. Wrong cell values reduce the numerator. So high column recall with low
    #     triplet full recall is expected when many columns exist per table but views only project a
    #     subset, tables are missing from GAV, JOINs drop rows, or values disagree with ground truth.
    #
    # Relationship to attribute_provenance compactness (fragmentation A/B):
    #   see ``schema_compactness`` / ``column_redundancy_ratio`` in attribute provenance metrics.
    #
    if is_hybrid:
        p_h = fact_common_total_hybrid / max(1, pred_projection_cells)
        r_h = fact_common_total_hybrid / max(1, fact_orig_total_full)
        f1_h = (2 * p_h * r_h / (p_h + r_h)) if (p_h + r_h) > 0 else 0.0
        result["triplet_match_hybrid"] = {
            "common_facts": fact_common_total_hybrid,
            "original_facts_all_schema": fact_orig_total_full,
            "predicted_projection_cells": pred_projection_cells,
            "fact_precision_micro": round(p_h, 4),
            "fact_recall_micro": round(r_h, 4),
            "fact_f1_micro": round(f1_h, 4),
            "notes": (
                "Common multiset = intersection of predicted vs original atomic facts over "
                "aligned (mapped) columns after view merge; recall denom = all cells in the "
                "original schema (row_count×column_count per table); precision denom = sum over "
                "compiled views of (materialized rows × projection width), counting every view "
                "separately (cross-view duplication increases the precision denominator)."
            ),
        }
    else:
        # (A) Aligned: only compared tables+aligned columns
        p_a = fact_common_total_aligned / max(1, fact_pred_total_aligned)
        r_a = fact_common_total_aligned / max(1, fact_orig_total_aligned)
        f1_a = (2 * p_a * r_a / (p_a + r_a)) if (p_a + r_a) > 0 else 0.0
        result["triplet_match_aligned"] = {
            "predicted_facts": fact_pred_total_aligned,
            "original_facts": fact_orig_total_aligned,
            "common_facts": fact_common_total_aligned,
            "fact_precision_micro": round(p_a, 4),
            "fact_recall_micro": round(r_a, 4),
            "fact_f1_micro": round(f1_a, 4),
        }

        # (B) Full-schema: recall denominator includes ALL original-table facts,
        # so missing tables/views lower recall.
        p_f = fact_common_total_full / max(1, fact_pred_total_full)
        r_f = fact_common_total_full / max(1, fact_orig_total_full)
        f1_f = (2 * p_f * r_f / (p_f + r_f)) if (p_f + r_f) > 0 else 0.0
        result["triplet_match_full"] = {
            "predicted_facts": fact_pred_total_full,
            "original_facts": fact_orig_total_full,
            "common_facts": fact_common_total_full,
            "fact_precision_micro": round(p_f, 4),
            "fact_recall_micro": round(r_f, 4),
            "fact_f1_micro": round(f1_f, 4),
        }

    orig_conn.close()
    return result


def _combine_views_for_table(
    orig_table: str,
    pk_cols: List[str],
    covering_views: List[Tuple[str, List[Tuple[str, str]]]],
    view_data: Dict[str, Dict],
) -> Tuple[List[Tuple[str, str]], List[str]]:
    """Combine multiple views covering the same original table.

    If multiple views share PK columns, merge their column pairs.
    Otherwise, pick the single best view.

    Returns (combined_pairs, list_of_view_names_used).
    """
    if len(covering_views) == 1:
        vn, pairs = covering_views[0]
        col_idx = {c: i for i, c in enumerate(view_data[vn]["columns"])}
        valid = [(vc, oc) for vc, oc in pairs if vc in col_idx]
        return valid, [vn]

    if not pk_cols:
        best_vn, best_pairs = max(covering_views, key=lambda x: len(x[1]))
        col_idx = {c: i for i, c in enumerate(view_data[best_vn]["columns"])}
        valid = [(vc, oc) for vc, oc in best_pairs if vc in col_idx]
        return valid, [best_vn]

    pk_set = set(pk_cols)

    combinable: List[Tuple[str, List[Tuple[str, str]]]] = []
    for vn, pairs in covering_views:
        orig_cols_in_view = {oc for _, oc in pairs}
        if pk_set <= orig_cols_in_view:
            combinable.append((vn, pairs))

    if len(combinable) <= 1:
        best_vn, best_pairs = max(covering_views, key=lambda x: len(x[1]))
        col_idx = {c: i for i, c in enumerate(view_data[best_vn]["columns"])}
        valid = [(vc, oc) for vc, oc in best_pairs if vc in col_idx]
        return valid, [best_vn]

    combined_orig_cols_seen: Set[str] = set()
    combined_pairs: List[Tuple[str, str]] = []
    used_views: List[str] = []

    combinable.sort(key=lambda x: len(x[1]), reverse=True)

    for vn, pairs in combinable:
        col_idx = {c: i for i, c in enumerate(view_data[vn]["columns"])}
        new_pairs = []
        for vc, oc in pairs:
            if vc in col_idx and oc not in combined_orig_cols_seen:
                new_pairs.append((vc, oc))
                combined_orig_cols_seen.add(oc)
        if new_pairs:
            if not used_views:
                combined_pairs.extend(new_pairs)
            else:
                non_pk_new = [(vc, oc) for vc, oc in new_pairs if oc not in pk_set]
                combined_pairs.extend(non_pk_new)
            used_views.append(vn)

    return combined_pairs, used_views


def _materialize_combined_views(
    orig_table: str,
    pk_cols: List[str],
    view_names: List[str],
    combined_pairs: List[Tuple[str, str]],
    view_data: Dict[str, Dict],
) -> Tuple[List[Tuple[str, str]], Set[tuple], List[tuple]]:
    """Materialize combined data from multiple views joined on PKs.

    Builds a dict keyed by PK tuples from the primary view, then enriches
    each row with columns from secondary views.
    """
    pk_set = set(pk_cols)
    all_valid_pairs = combined_pairs

    primary_vn = view_names[0]
    primary_vd = view_data[primary_vn]
    primary_col_idx = {c: i for i, c in enumerate(primary_vd["columns"])}

    primary_pairs = [
        (vc, oc)
        for vc, oc in primary_vd["table_col_pairs"].get(orig_table, [])
        if vc in primary_col_idx
    ]
    primary_pk_view_cols = [
        vc for vc, oc in primary_pairs if oc in pk_set
    ]
    if not primary_pk_view_cols:
        # Cannot join/align rows without PK columns exposed by the view(s).
        # Return empty materialization consistently (3-tuple).
        return [], set(), []

    pk_row_index: Dict[tuple, Dict[str, Any]] = {}
    for row in primary_vd["rows"]:
        pk_tuple = tuple(
            _normalize_value(row[primary_col_idx[vc]])
            for vc in primary_pk_view_cols
        )
        row_dict: Dict[str, Any] = {}
        for vc, oc in primary_pairs:
            row_dict[oc] = _normalize_value(row[primary_col_idx[vc]])
        pk_row_index[pk_tuple] = row_dict

    for sec_vn in view_names[1:]:
        sec_vd = view_data[sec_vn]
        sec_col_idx = {c: i for i, c in enumerate(sec_vd["columns"])}
        sec_pairs = [
            (vc, oc)
            for vc, oc in sec_vd["table_col_pairs"].get(orig_table, [])
            if vc in sec_col_idx
        ]
        sec_pk_view_cols = [vc for vc, oc in sec_pairs if oc in pk_set]
        if not sec_pk_view_cols:
            continue

        for row in sec_vd["rows"]:
            pk_tuple = tuple(
                _normalize_value(row[sec_col_idx[vc]])
                for vc in sec_pk_view_cols
            )
            if pk_tuple in pk_row_index:
                for vc, oc in sec_pairs:
                    if oc not in pk_set:
                        pk_row_index[pk_tuple][oc] = _normalize_value(
                            row[sec_col_idx[vc]]
                        )

    orig_col_order = [oc for _, oc in all_valid_pairs]
    pred_rows: Set[tuple] = set()
    pred_rows_list: List[tuple] = []
    for pk_tuple, row_dict in pk_row_index.items():
        row_tuple = tuple(row_dict.get(oc) for oc in orig_col_order)
        pred_rows.add(row_tuple)
        pred_rows_list.append(row_tuple)

    return all_valid_pairs, pred_rows, pred_rows_list


def _pk_based_comparison(
    orig_table: str,
    pk_cols: List[str],
    valid_pairs: List[Tuple[str, str]],
    pred_rows: Set[tuple],
    orig_conn: sqlite3.Connection,
) -> Optional[Dict]:
    """PK-based row matching: join predicted and original on PKs,
    compare non-PK columns value-by-value.

    Returns per-column accuracy, missing/extra row counts by PK,
    or None if PKs are not available in the mapped columns.
    """
    if not pk_cols:
        return None

    orig_col_list = [oc for _, oc in valid_pairs]
    pk_indices = []
    for pk in pk_cols:
        if pk in orig_col_list:
            pk_indices.append(orig_col_list.index(pk))
        else:
            return None

    non_pk_indices = [
        i for i in range(len(orig_col_list))
        if i not in pk_indices
    ]
    if not non_pk_indices:
        return None

    pred_by_pk: Dict[tuple, tuple] = {}
    pred_dup_count = 0
    for row in pred_rows:
        pk_val = tuple(row[i] for i in pk_indices)
        if pk_val in pred_by_pk:
            pred_dup_count += 1
        pred_by_pk[pk_val] = row

    orig_col_str = ", ".join(f"[{oc}]" for oc in orig_col_list)
    orig_by_pk: Dict[tuple, tuple] = {}
    try:
        for row in orig_conn.execute(
            f"SELECT {orig_col_str} FROM [{orig_table}]"
        ).fetchall():
            norm_row = tuple(_normalize_value(v) for v in row)
            pk_val = tuple(norm_row[i] for i in pk_indices)
            orig_by_pk[pk_val] = norm_row
    except Exception:
        return None

    matched_pks = set(pred_by_pk.keys()) & set(orig_by_pk.keys())
    missing_pks = set(orig_by_pk.keys()) - set(pred_by_pk.keys())
    extra_pks = set(pred_by_pk.keys()) - set(orig_by_pk.keys())

    per_column_matches: Dict[str, int] = {
        orig_col_list[i]: 0 for i in non_pk_indices
    }
    per_column_total: Dict[str, int] = {
        orig_col_list[i]: 0 for i in non_pk_indices
    }

    for pk_val in matched_pks:
        pred_row = pred_by_pk[pk_val]
        orig_row = orig_by_pk[pk_val]
        for i in non_pk_indices:
            col_name = orig_col_list[i]
            per_column_total[col_name] += 1
            if pred_row[i] == orig_row[i]:
                per_column_matches[col_name] += 1

    per_column_accuracy = {}
    for col_name in per_column_matches:
        total = per_column_total[col_name]
        correct = per_column_matches[col_name]
        per_column_accuracy[col_name] = round(
            correct / max(1, total), 4,
        )

    total_matched = len(matched_pks)
    total_cells = sum(per_column_total.values())
    total_correct = sum(per_column_matches.values())

    return {
        "pk_columns": pk_cols,
        "rows_matched_by_pk": total_matched,
        "rows_missing_from_predicted": len(missing_pks),
        "rows_extra_in_predicted": len(extra_pks),
        "pk_row_match_rate": round(
            total_matched / max(1, len(orig_by_pk)), 4,
        ),
        "overall_cell_accuracy": round(
            total_correct / max(1, total_cells), 4,
        ),
        "per_column_accuracy": per_column_accuracy,
    }


# ──────────────────────────────────────────────
# Full Evaluation Pipeline
# ──────────────────────────────────────────────

def evaluate_solve_results(
    instance_dir: str,
    solve_dir: str,
    *,
    tuple_match_mode: str = "triplet_only",
    max_view_rows: int = 0,
    max_orig_rows: int = 0,
    evaluation_report_json: Optional[str] = None,
    merge_hybrid_from_report: Optional[str] = None,
) -> Dict:
    """
    Evaluate the LLM's GAV rules against ground truth.

    Three deterministic metrics:
      1. GAV Compile Rate
      2. Attribute Provenance (column recall / precision / redundancy / compactness)
         - all_views: all parsed views; column precision is always all-view refs
         - compiled_only: compiled views only; FK credit only from compiled JOINs
         - ``schema_compactness`` (= A/B), ``column_redundancy_ratio`` (= B/A)
      3. Tuple-Level Data Comparison (triplet micro-metrics in ``metrics.tuple_match``)
         Use ``tuple_match_mode=\"triplet_hybrid\"`` for reproducible full-data hybrid
         triplets only (writes ``triplet_match_hybrid`` instead of aligned/full blocks).

    evaluation_report_json:
      Output filename under ``solve_dir`` (default: ``evaluation_report.json``).
      Use e.g. ``evaluation_report.hybrid.json`` for a side-by-side hybrid report.

    merge_hybrid_from_report:
      When ``tuple_match_mode=triplet_hybrid``, optional filename under ``solve_dir``
      (e.g. ``evaluation_report_without_data.json``). If present, **compile_rate** and
      **attribute_provenance** metrics and detail blocks are copied from that report;
      only **triplet_hybrid** tuple matching is recomputed (still uses a fresh
      ``evaluate_compile_rate`` connection for SQL). If the file is missing, falls
      back to a full evaluation.
    """
    # Normalize to absolute paths so CLI behavior does not depend on current working directory.
    instance_dir = os.path.abspath(instance_dir)
    solve_dir = os.path.abspath(solve_dir)

    print(f"\n{'=' * 70}")
    print(f"Evaluating LLM GAV Rules")
    print(f"{'=' * 70}")
    print(f"Instance:  {instance_dir}")
    print(f"Solve dir: {solve_dir}")
    print()

    # Load GAV rules
    gav_path = os.path.join(solve_dir, "gav_rules.sql")
    if not os.path.exists(gav_path):
        print("  ERROR: gav_rules.sql not found")
        return {
            "instance_dir": instance_dir,
            "solve_dir": solve_dir,
            "error": "gav_rules.sql not found",
        }

    with open(gav_path) as f:
        gav_text = f.read()

    gav_views = parse_gav_views(gav_text)
    print(f"  Parsed {len(gav_views)} CREATE VIEW statements")
    if not gav_views:
        print("  ERROR: No valid CREATE VIEW statements found")
        return {
            "instance_dir": instance_dir,
            "solve_dir": solve_dir,
            "error": "No views parsed from gav_rules.sql",
        }

    # ── Metric 1: GAV Compile Rate ──
    print(f"\n  Metric 1: GAV Compile Rate")
    compile_result, conn = evaluate_compile_rate(gav_views, instance_dir)

    print(f"    Compiled: {compile_result['compiled']} / {compile_result['total_views']}")
    print(f"    Compile Rate: {compile_result['compile_rate']:.4f}")

    if compile_result['failed'] > 0:
        print(f"    Failed views:")
        for v in compile_result['per_view']:
            if v['status'] == 'failed':
                err_msg = v.get('error', '')[:100]
                print(f"      {v['view_name']}: {err_msg}")

    tmode_pre = str(tuple_match_mode or "triplet_only").lower()
    base_report: Optional[Dict[str, Any]] = None
    merge_name = (merge_hybrid_from_report or "").strip()
    if merge_name and tmode_pre == "triplet_hybrid":
        merge_path = os.path.join(solve_dir, merge_name)
        if os.path.isfile(merge_path):
            with open(merge_path, encoding="utf-8") as f:
                base_report = json.load(f)
        else:
            print(
                f"\n  NOTE: merge_hybrid_from_report={merge_name!r} not found; "
                f"running full attribute provenance.",
            )

    # ── Metric 2: Attribute Provenance ──
    print(f"\n  Metric 2: Attribute Provenance")

    if base_report is not None:
        provenance_result = dict(base_report.get("attribute_provenance_detail") or {})
        print(f"    (reused from {merge_name})")
        cr_b = float(
            (base_report.get("metrics") or {}).get("compile_rate", {}).get(
                "view_compile_rate", -1.0,
            ),
        )
        cr_f = float(compile_result.get("compile_rate") or -1.0)
        if cr_b >= 0 and cr_f >= 0 and abs(cr_b - cr_f) > 1e-5:
            print(
                f"    WARNING: compile_rate mismatch vs merge file "
                f"(fresh={cr_f:.4f}, merge={cr_b:.4f}); keeping merge-file compile metrics.",
            )
        print(
            f"    [All views] Column Recall:    {provenance_result.get('column_recall', 0):.4f} "
        )
        print(
            f"    [All views] Column Precision: {provenance_result.get('column_precision', 0):.4f} "
        )
        print(f"    [All views] Column F1:        {provenance_result.get('column_f1', 0):.4f}")
        co = provenance_result.get("compiled_only") or {}
        if co:
            print(
                f"    [Compiled only] Column Recall:    {co.get('column_recall', 0):.4f} "
            )
            print(
                f"    [Compiled only] Column Precision: {co.get('column_precision', 0):.4f}"
            )
            print(f"    [Compiled only] Column F1:        {co.get('column_f1', 0):.4f}")
        print(
            f"    Compactness (A/B): {float(provenance_result.get('schema_compactness') or 0):.4f} "
            f"(redundancy B/A = {float(provenance_result.get('column_redundancy_ratio') or 0):.4f})"
        )
    else:
        compiled_view_names = {
            v['view_name']
            for v in compile_result['per_view']
            if v['status'] == 'compiled'
        }

        provenance_result = evaluate_attribute_provenance(
            gav_views, instance_dir,
            compiled_view_names=compiled_view_names,
        )

        print(
            f"    [All views] Column Recall:    {provenance_result['column_recall']:.4f} "
            f"({provenance_result['original_columns_found']}"
            f"/{provenance_result['total_original_columns']})"
        )
        print(
            f"    [All views] Column Precision: {provenance_result['column_precision']:.4f} "
            f"({provenance_result['valid_gav_refs']}"
            f"/{provenance_result['total_gav_column_refs']})"
        )
        print(f"    [All views] Column F1:        {provenance_result['column_f1']:.4f}")

        if "compiled_only" in provenance_result:
            co = provenance_result["compiled_only"]
            print(
                f"    [Compiled only] Column Recall:    {co['column_recall']:.4f} "
                f"({co['original_columns_found']}"
                f"/{provenance_result['total_original_columns']})"
            )
            print(
                f"    [Compiled only] Column Precision: {co['column_precision']:.4f}"
            )
            print(f"    [Compiled only] Column F1:        {co['column_f1']:.4f}")

        if provenance_result.get('original_columns_found_via_fk', 0) > 0:
            print(
                f"    FK join credit: {provenance_result['original_columns_found_via_fk']} "
                f"additional columns credited via FK relationships"
            )

        print(
            f"    Compactness (A/B): {provenance_result['schema_compactness']:.4f} "
            f"(redundancy B/A = {provenance_result['column_redundancy_ratio']:.4f})"
        )

        print(f"    Per-table coverage:")
        for table, info in sorted(provenance_result['per_table_coverage'].items()):
            if info['coverage'] == 1.0:
                status = "COMPLETE"
            else:
                missing_str = ', '.join(info['missing_columns'])
                status = f"MISSING: {missing_str}"
            fk_note = ""
            if info.get('columns_found_via_fk', 0) > 0:
                fk_note = f" (+{info['columns_found_via_fk']} via FK)"
            print(
                f"      {table}: {info['columns_found']}/{info['total_columns']} "
                f"({status}){fk_note}"
            )

    # ── Metric 3: Tuple-Level Data Comparison ──
    tmode = str(tuple_match_mode or "triplet_only").lower()
    skip_tuple = tmode in ("none", "skip", "no_tuple", "no_data", "without_data")
    print(f"\n  Metric 3: Tuple-Level Data Comparison (mode={tmode})")
    compiled_view_dicts = [
        v for v in compile_result['per_view']
        if v['status'] == 'compiled'
    ]

    if skip_tuple:
        tuple_result = {"mode": "none"}
    else:
        tuple_result = evaluate_tuple_match(
            compiled_view_dicts,
            conn,
            instance_dir,
            mode=tmode,
            max_view_rows=int(max_view_rows),
            max_orig_rows=int(max_orig_rows),
        )

    if not skip_tuple:
        if "triplet_match_hybrid" in tuple_result:
            tmh = tuple_result["triplet_match_hybrid"]
            print(
                f"    Triplet hybrid F1: {tmh['fact_f1_micro']:.4f} "
                f"(P={tmh['fact_precision_micro']:.4f}, R={tmh['fact_recall_micro']:.4f})"
            )
        if "triplet_match_full" in tuple_result:
            tmf = tuple_result["triplet_match_full"]
            print(f"    Triplet F1 (full schema): {tmf['fact_f1_micro']:.4f}")
        if "triplet_match_aligned" in tuple_result:
            tma = tuple_result["triplet_match_aligned"]
            print(f"    Triplet F1 (aligned):     {tma['fact_f1_micro']:.4f}")

    conn.close()

    # ── Build and save report ──

    # Grouped metrics: each area in its own key (merge preserves without-data metrics)
    compile_rate_detail_out: Any = compile_result
    attribute_provenance_detail_out: Any = provenance_result

    if base_report is not None:
        compile_metrics = dict(
            ((base_report.get("metrics") or {}).get("compile_rate") or {}),
        )
        if not compile_metrics:
            compile_metrics = {
                "view_compile_rate": compile_result["compile_rate"],
                "total_views": compile_result["total_views"],
                "compiled": compile_result["compiled"],
                "failed": compile_result["failed"],
            }
        compile_rate_detail_out = base_report.get("compile_rate_detail") or compile_result

        provenance_metrics = dict(
            ((base_report.get("metrics") or {}).get("attribute_provenance") or {}),
        )
        if not provenance_metrics:
            provenance_metrics = {}
        attribute_provenance_detail_out = (
            base_report.get("attribute_provenance_detail") or provenance_result
        )
    else:
        compile_metrics = {
            "view_compile_rate": compile_result["compile_rate"],
            "total_views": compile_result["total_views"],
            "compiled": compile_result["compiled"],
            "failed": compile_result["failed"],
        }

        provenance_metrics = {
            "column_recall": provenance_result["column_recall"],
            "column_precision": provenance_result["column_precision"],
            "column_f1": provenance_result["column_f1"],
            "column_redundancy_ratio": provenance_result["column_redundancy_ratio"],
            "schema_compactness": provenance_result["schema_compactness"],
            "total_original_columns": provenance_result["total_original_columns"],
            "columns_found": provenance_result["original_columns_found"],
            "columns_found_direct": provenance_result["original_columns_found_direct"],
            "columns_found_via_fk": provenance_result["original_columns_found_via_fk"],
            "columns_missing": provenance_result["original_columns_missing"],
        }
        if "compiled_only" in provenance_result:
            provenance_metrics["compiled_only"] = {
                "column_recall": provenance_result["compiled_only"]["column_recall"],
                "column_precision": provenance_result["compiled_only"]["column_precision"],
                "column_f1": provenance_result["compiled_only"]["column_f1"],
                "columns_found": provenance_result["compiled_only"]["original_columns_found"],
            }

    tuple_metrics: Dict[str, Any] = {
        "mode": tuple_result.get("mode", tmode),
    }
    if "triplet_match_hybrid" in tuple_result:
        tuple_metrics["triplet_match_hybrid"] = tuple_result["triplet_match_hybrid"]
    if "triplet_match_full" in tuple_result:
        tuple_metrics["triplet_match_full"] = tuple_result["triplet_match_full"]
    if "triplet_match_aligned" in tuple_result:
        tuple_metrics["triplet_match_aligned"] = tuple_result["triplet_match_aligned"]

    report = {
        "instance_dir": instance_dir,
        "solve_dir": solve_dir,
        "metrics": {
            "compile_rate": compile_metrics,
            "attribute_provenance": provenance_metrics,
            "tuple_match": tuple_metrics,
        },
        "compile_rate_detail": compile_rate_detail_out,
        "attribute_provenance_detail": attribute_provenance_detail_out,
        "tuple_match_detail": tuple_result,
    }
    if base_report is not None:
        report["hybrid_merge"] = {
            "source_report": merge_name,
            "note": (
                "compile_rate and attribute_provenance copied from source_report; "
                "tuple_match recomputed (triplet_hybrid)."
            ),
        }

    eval_name = evaluation_report_json or "evaluation_report.json"
    eval_path = os.path.join(solve_dir, eval_name)
    with open(eval_path, "w") as f:
        json.dump(report, f, indent=2, default=str)

    cr_show = float(compile_metrics.get("view_compile_rate") or 0.0)
    print(f"\n{'=' * 70}")
    print(f"Evaluation Summary")
    print(f"{'=' * 70}")
    print(f"  1. GAV Compile Rate:         {cr_show:.4f}")
    print(f"  2. Attribute Provenance:")
    print(
        f"     Column Recall (all):      "
        f"{float(provenance_metrics.get('column_recall') or 0):.4f}",
    )
    co_m = provenance_metrics.get("compiled_only") or {}
    if co_m:
        print(
            f"     Column Recall (compiled):  "
            f"{float(co_m.get('column_recall') or 0):.4f}",
        )
    print(
        f"     Column Precision:         "
        f"{float(provenance_metrics.get('column_precision') or 0):.4f}",
    )
    print(
        f"     Column F1 (all):          "
        f"{float(provenance_metrics.get('column_f1') or 0):.4f}",
    )
    print(
        f"     Compactness (A/B): {float(provenance_metrics.get('schema_compactness') or 0):.4f} "
        f"(B/A = {float(provenance_metrics.get('column_redundancy_ratio') or 0):.4f})"
    )
    print(f"  3. Tuple-Level Data Comparison:")
    if skip_tuple:
        print("     (mode=none)")
    elif "triplet_match_hybrid" in tuple_result:
        tmh = tuple_result["triplet_match_hybrid"]
        print(
            f"     Triplet hybrid F1: {tmh['fact_f1_micro']:.4f} "
            f"(P={tmh['fact_precision_micro']:.4f}, R={tmh['fact_recall_micro']:.4f})"
        )
    if (not skip_tuple) and "triplet_match_full" in tuple_result:
        print(
            f"     Triplet F1 (full schema): "
            f"{tuple_result['triplet_match_full']['fact_f1_micro']:.4f}"
        )
    if (not skip_tuple) and "triplet_match_aligned" in tuple_result:
        print(
            f"     Triplet F1 (aligned):     "
            f"{tuple_result['triplet_match_aligned']['fact_f1_micro']:.4f}"
        )
    print(f"  Report saved to: {eval_path}")
    print(f"{'=' * 70}")

    return report
