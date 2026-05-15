import sqlite3
import os
from typing import List, Dict, Optional
from collections import defaultdict

from schema_parser import SchemaGraph
from transforms import LocalSchema, TableTransform, TransformSpec
from query_rewriter import _build_federated_vertical_row_combined_cte_multi


def _qi(name: str) -> str:
    """Quote an SQLite identifier using double quotes (robust with `[`/`]` in names)."""
    safe = (name or "").replace('"', '""')
    return f"\"{safe}\""


def generate_reconstruction_sql(
    schema_graph: SchemaGraph,
    locals_list: List[LocalSchema],
    transform_spec: TransformSpec,
) -> str:
    """
    Generate SQL that reconstructs original tables from locals as views.

    Strategy:
    - For normal (unsplit) tables: CREATE VIEW selecting from local table with column renaming
    - For vertically split tables: CREATE VIEW joining N fragments on PK
    - For horizontally row-partitioned tables: CREATE VIEW as UNION of F fragments
      (UNION DISTINCT when the partition has row overlap, UNION ALL otherwise).
    """
    # Build a map: original_table -> list of (local_schema, local_table_name, transform)
    orig_to_local = defaultdict(list)
    for local in locals_list:
        for lt_name, transform in local.tables.items():
            orig_to_local[transform.source_table].append(
                (local, lt_name, transform)
            )

    views = []
    attach_statements = []
    attached_dbs = set()

    # First, generate ATTACH statements for all local databases
    for local in locals_list:
        alias = local.local_name
        attach_statements.append(
            f"ATTACH DATABASE '{local.local_name}.sqlite' AS {_qi(alias)};"
        )
        attached_dbs.add(alias)

    for orig_table in sorted(schema_graph.tables.keys()):
        orig_tbl = schema_graph.tables[orig_table]
        orig_cols = [c.name for c in orig_tbl.columns]
        entries = orig_to_local.get(orig_table, [])

        if not entries:
            views.append(f"-- WARNING: No local source found for {orig_table}")
            continue

        vsplit_entries = [e for e in entries if e[2].is_vertical_split_fragment]
        rpart_entries = [e for e in entries if e[2].is_row_partition]
        normal_entries = [
            e
            for e in entries
            if not e[2].is_vertical_split_fragment and not e[2].is_row_partition
        ]

        has_vrow = any(
            e[2].is_vertical_split_fragment and e[2].is_row_partition for e in entries
        )

        if vsplit_entries and rpart_entries and has_vrow:
            view_sql = _reconstruct_vertical_row_combined(
                orig_table, orig_cols, entries, schema_graph
            )
        elif vsplit_entries:
            view_sql = _reconstruct_vertical_split(
                orig_table, orig_cols, orig_tbl, vsplit_entries
            )
        elif rpart_entries:
            view_sql = _reconstruct_row_partition(orig_table, orig_cols, rpart_entries)
        elif normal_entries:
            view_sql = _reconstruct_normal(orig_table, orig_cols, normal_entries[0])
        else:
            views.append(f"-- WARNING: Unexpected state for {orig_table}")
            continue

        views.append(view_sql)

    # Combine
    all_sql = "-- Reconstruction SQL: Attach local databases and create views\n"
    all_sql += "-- that reconstruct the original tables.\n\n"
    all_sql += "\n".join(attach_statements)
    all_sql += "\n\n"
    all_sql += "\n\n".join(views)
    all_sql += "\n"

    return all_sql


def _reconstruct_vertical_row_combined(
    orig_table: str,
    orig_cols: List[str],
    entries: list,
    schema_graph: SchemaGraph,
) -> str:
    """JOIN vertical fragments where one fragment is UNION ALL of row partitions."""
    all_entries = [(e[0].local_name, e[1], e[2]) for e in entries]
    body, _ = _build_federated_vertical_row_combined_cte_multi(all_entries, schema_graph)
    return (
        f"-- Reconstruct {orig_table} from vertical split + row partition on a fragment\n"
        f"CREATE VIEW {_qi(orig_table)} AS\n"
        f"{body};"
    )


def _reconstruct_normal(
    orig_table: str,
    orig_cols: List[str],
    entry: tuple,
) -> str:
    """Reconstruct a normal (non-split) table from its local version."""
    local, lt_name, transform = entry
    alias = local.local_name

    # column_map is {local_col: orig_col}
    inv_map = {v: k for k, v in transform.column_map.items()}

    select_parts = []
    for oc in orig_cols:
        local_col = inv_map.get(oc, oc)
        if local_col != oc:
            select_parts.append(
                f"{_qi(alias)}.{_qi(lt_name)}.{_qi(local_col)} AS {_qi(oc)}"
            )
        else:
            select_parts.append(f"{_qi(alias)}.{_qi(lt_name)}.{_qi(local_col)}")

    select_clause = ",\n    ".join(select_parts)

    return (
        f"-- Reconstruct {orig_table} from {alias}.{lt_name}\n"
        f"CREATE VIEW {_qi(orig_table)} AS\n"
        f"SELECT\n    {select_clause}\n"
        f"FROM {_qi(alias)}.{_qi(lt_name)};"
    )


def _reconstruct_vertical_split(
    orig_table: str,
    orig_cols: List[str],
    orig_tbl,
    entries: list,
) -> str:
    """Reconstruct a vertically (column) split table by N-way JOIN on PK."""
    entries = sorted(entries, key=lambda e: e[1])
    if len(entries) < 2:
        return _reconstruct_normal(orig_table, orig_cols, entries[0])

    pk_cols = orig_tbl.primary_keys
    inv_maps = []
    col_sets = []
    for local, lt_name, tr in entries:
        inv_maps.append(
            ({v: k for k, v in tr.column_map.items()}, local.local_name, lt_name, tr)
        )
        col_sets.append(set(tr.column_map.values()))

    aliases = [f"t{i}" for i in range(len(entries))]

    def _pick_fragment_for_col(oc: str) -> int:
        if oc in pk_cols:
            return 0
        for i, cs in enumerate(col_sets):
            if oc in cs:
                return i
        return 0

    select_parts = []
    for oc in orig_cols:
        fi = _pick_fragment_for_col(oc)
        inv, alias, lt_name, _ = inv_maps[fi]
        al = aliases[fi]
        local_col = inv.get(oc, oc)
        select_parts.append(f"{al}.{_qi(local_col)} AS {_qi(oc)}")

    select_clause = ",\n    ".join(select_parts)

    # Use a row_number disambiguator to avoid NULL/duplicate-key blowups.
    # This preserves multiplicity even when PK values are duplicated or NULL in data.
    join_conditions = []
    inv0, alias0, lt0, tr0 = inv_maps[0]
    for i in range(1, len(entries)):
        inv_i, alias_i, lt_i, _tr_i = inv_maps[i]
        for pk in pk_cols:
            lp0 = inv0.get(pk, pk)
            lpi = inv_i.get(pk, pk)
            join_conditions.append(
                f"{aliases[0]}.{_qi(lp0)} IS {aliases[i]}.{_qi(lpi)}"
            )
        join_conditions.append(f"{aliases[0]}.__rn = {aliases[i]}.__rn")
    join_clause = " AND ".join(join_conditions)
    if not join_clause:
        raise ValueError(
            f"Vertical split reconstruction for [{orig_table}] has no join keys."
        )

    part_by = ", ".join(f"{_qi(inv_maps[0][0].get(pk, pk))}" for pk in pk_cols)
    def _sub(alias_db: str, table_name: str, inv: dict) -> str:
        pcols = ", ".join(_qi(inv.get(pk, pk)) for pk in pk_cols)
        # Partition by local pk columns (NULLs allowed), order by rowid for stable pairing.
        return (
            f"(SELECT *, ROW_NUMBER() OVER (PARTITION BY {pcols} ORDER BY rowid) AS __rn "
            f"FROM {_qi(alias_db)}.{_qi(table_name)})"
        )

    from_clause = f"{_sub(inv_maps[0][1], inv_maps[0][2], inv_maps[0][0])} {aliases[0]}"
    for i in range(1, len(entries)):
        inv_i, alias_i, lt_i, _ = inv_maps[i]
        jc = " AND ".join(
            [f"{aliases[0]}.{_qi(inv_maps[0][0].get(pk, pk))} IS {aliases[i]}.{_qi(inv_i.get(pk, pk))}" for pk in pk_cols]
            + [f"{aliases[0]}.__rn = {aliases[i]}.__rn"]
        )
        from_clause += f"\nJOIN {_qi(alias_i)}.{_qi(lt_i)} {aliases[i]} ON {jc}"

    return (
        f"-- Reconstruct {orig_table} from vertical (column) split ({len(entries)} fragments)\n"
        f"CREATE VIEW {_qi(orig_table)} AS\n"
        f"SELECT\n    {select_clause}\n"
        f"FROM {from_clause};"
    )


def _reconstruct_row_partition(
    orig_table: str,
    orig_cols: List[str],
    entries: list,
) -> str:
    """Reconstruct a row-partitioned table via UNION / UNION ALL.

    If any fragment in the set is marked ``row_partition_has_overlap`` then
    rows are intentionally duplicated across fragments; we must use UNION
    (set-union / distinct) for reconstruction. Otherwise UNION ALL is fine
    and slightly cheaper.
    """
    union_parts = []
    has_overlap = any(
        getattr(transform, "row_partition_has_overlap", False)
        for _, _, transform in entries
    )

    for local, lt_name, transform in entries:
        alias = local.local_name
        inv_map = {v: k for k, v in transform.column_map.items()}

        select_parts = []
        for oc in orig_cols:
            local_col = inv_map.get(oc, oc)
            if local_col != oc:
                select_parts.append(
                    f"{_qi(alias)}.{_qi(lt_name)}.{_qi(local_col)} AS {_qi(oc)}"
                )
            else:
                select_parts.append(f"{_qi(alias)}.{_qi(lt_name)}.{_qi(local_col)}")

        select_clause = ", ".join(select_parts)
        union_parts.append(f"SELECT {select_clause} FROM {_qi(alias)}.{_qi(lt_name)}")

    joiner = "\nUNION\n" if has_overlap else "\nUNION ALL\n"
    union_sql = joiner.join(union_parts)
    variant = "UNION (overlap)" if has_overlap else "UNION ALL"
    return (
        f"-- Reconstruct {orig_table} from row partitions ({variant})\n"
        f"CREATE VIEW {_qi(orig_table)} AS\n"
        f"{union_sql};"
    )


def materialize_reconstruction(
    schema_graph: SchemaGraph,
    locals_list: List[LocalSchema],
    transform_spec: TransformSpec,
    output_dir: str,
    original_db_path: str,
) -> str:
    """
    Create reconstructed.sqlite by attaching local databases and
    materializing reconstruction views as actual tables.

    Returns path to reconstructed.sqlite.
    """
    recon_dir = os.path.join(output_dir, "reconstruction")
    os.makedirs(recon_dir, exist_ok=True)

    locals_dir = os.path.join(output_dir, "locals")

    # Generate and save reconstruction SQL
    recon_sql = generate_reconstruction_sql(schema_graph, locals_list, transform_spec)
    sql_path = os.path.join(recon_dir, "reconstruct_original.sql")
    with open(sql_path, "w") as f:
        f.write(recon_sql)

    # Now materialize: create reconstructed.sqlite
    recon_db_path = os.path.join(recon_dir, "reconstructed.sqlite")
    if os.path.exists(recon_db_path):
        os.remove(recon_db_path)

    conn = sqlite3.connect(recon_db_path)
    cursor = conn.cursor()

    # Attach all local databases
    for local in locals_list:
        local_db = os.path.join(locals_dir, f"{local.local_name}.sqlite")
        local_db_abs = os.path.abspath(local_db)
        cursor.execute(f"ATTACH DATABASE ? AS {_qi(local.local_name)}", (local_db_abs,))

    # Build reconstruction for each original table
    orig_to_local = defaultdict(list)
    for local in locals_list:
        for lt_name, transform in local.tables.items():
            orig_to_local[transform.source_table].append(
                (local, lt_name, transform)
            )

    # Get original DDL for reference
    orig_conn = sqlite3.connect(original_db_path)
    orig_cursor = orig_conn.cursor()

    for orig_table in sorted(schema_graph.tables.keys()):
        orig_tbl = schema_graph.tables[orig_table]
        orig_cols = [c.name for c in orig_tbl.columns]
        entries = orig_to_local.get(orig_table, [])

        if not entries:
            print(f"WARNING: No local source for {orig_table}")
            continue

        vsplit_entries = [e for e in entries if e[2].is_vertical_split_fragment]
        rpart_entries = [e for e in entries if e[2].is_row_partition]
        normal_entries = [
            e
            for e in entries
            if not e[2].is_vertical_split_fragment and not e[2].is_row_partition
        ]

        has_vrow = any(
            e[2].is_vertical_split_fragment and e[2].is_row_partition for e in entries
        )

        if vsplit_entries and rpart_entries and has_vrow:
            all_entries = [(e[0].local_name, e[1], e[2]) for e in entries]
            select_sql, _ = _build_federated_vertical_row_combined_cte_multi(
                all_entries, schema_graph
            )
        elif vsplit_entries:
            select_sql = _build_vertical_split_select(
                orig_table, orig_cols, orig_tbl, vsplit_entries
            )
        elif rpart_entries:
            select_sql = _build_rpart_select(orig_table, orig_cols, rpart_entries)
        elif normal_entries:
            select_sql = _build_normal_select(orig_table, orig_cols, normal_entries[0])
        else:
            continue

        # Create the original table structure and populate
        # Get original DDL
        orig_cursor.execute(
            "SELECT sql FROM sqlite_master WHERE type='table' AND name=?",
            (orig_table,)
        )
        orig_ddl = orig_cursor.fetchone()
        if orig_ddl and orig_ddl[0]:
            try:
                cursor.execute(orig_ddl[0])
            except sqlite3.OperationalError:
                # Table might already exist or DDL might have issues with FK references
                # Create a simpler version
                col_defs = []
                for c in orig_tbl.columns:
                    ctype = c.type if c.type else "TEXT"
                    col_defs.append(f"{_qi(c.name)} {ctype}")
                pk_str = ", ".join(_qi(pk) for pk in orig_tbl.primary_keys)
                if pk_str:
                    col_defs.append(f"PRIMARY KEY ({pk_str})")
                create_sql = f"CREATE TABLE {_qi(orig_table)} ({', '.join(col_defs)})"
                cursor.execute(create_sql)

        # Insert data from reconstruction query
        try:
            cursor.execute(f"INSERT INTO {_qi(orig_table)} {select_sql}")
            conn.commit()
        except Exception as e:
            # If original DDL enforced PK/NOT NULL constraints but the *data*
            # violates them, retry with a relaxed table definition.
            msg = str(e).lower()
            retryable = any(
                k in msg for k in ("constraint", "not null", "unique", "primary key")
            )
            if retryable:
                try:
                    cursor.execute(f"DROP TABLE IF EXISTS {_qi(orig_table)}")
                    col_defs = []
                    for c in orig_tbl.columns:
                        ctype = c.type if c.type else "TEXT"
                        col_defs.append(f"{_qi(c.name)} {ctype}")
                    cursor.execute(f"CREATE TABLE {_qi(orig_table)} ({', '.join(col_defs)})")
                    cursor.execute(f"INSERT INTO {_qi(orig_table)} {select_sql}")
                    conn.commit()
                    continue
                except Exception:
                    pass
            print(f"Error reconstructing {orig_table}: {e}")
            print(f"  Query: INSERT INTO {_qi(orig_table)} {select_sql}")

    orig_conn.close()

    # Verify reconstruction
    print("\n=== Reconstruction Summary ===")
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'")
    tables = [r[0] for r in cursor.fetchall()]
    for t in sorted(tables):
        cursor.execute(f"SELECT COUNT(*) FROM {_qi(t)}")
        count = cursor.fetchone()[0]
        orig_count = schema_graph.tables[t].row_count if t in schema_graph.tables else "?"
        print(f"  {t}: {count} rows (original: {orig_count})")

    conn.close()
    return recon_db_path


def _build_normal_select(orig_table, orig_cols, entry):
    """Build SELECT for normal table reconstruction."""
    local, lt_name, transform = entry
    alias = local.local_name
    inv_map = {v: k for k, v in transform.column_map.items()}

    select_parts = []
    for oc in orig_cols:
        local_col = inv_map.get(oc, oc)
        select_parts.append(f"{_qi(alias)}.{_qi(lt_name)}.{_qi(local_col)} AS {_qi(oc)}")

    select_clause = ", ".join(select_parts)
    return f"SELECT {select_clause} FROM {_qi(alias)}.{_qi(lt_name)}"


def _build_vertical_split_select(orig_table, orig_cols, orig_tbl, entries):
    """Build SELECT for N-way vertical split reconstruction."""
    entries = sorted(entries, key=lambda e: e[1])
    if len(entries) < 2:
        return _build_normal_select(orig_table, orig_cols, entries[0])

    pk_cols = orig_tbl.primary_keys
    inv_maps = []
    col_sets = []
    for local, lt_name, tr in entries:
        inv_maps.append(
            ({v: k for k, v in tr.column_map.items()}, local.local_name, lt_name)
        )
        col_sets.append(set(tr.column_map.values()))
    aliases = [f"t{i}" for i in range(len(entries))]

    def _pick(oc: str) -> int:
        if oc in pk_cols:
            return 0
        for i, cs in enumerate(col_sets):
            if oc in cs:
                return i
        return 0

    select_parts = []
    for oc in orig_cols:
        fi = _pick(oc)
        inv, _alias, _lt = inv_maps[fi]
        select_parts.append(
            f"{aliases[fi]}.{_qi(inv.get(oc, oc))} AS {_qi(oc)}"
        )

    inv0, alias0, lt0 = inv_maps[0]

    # Stable join across vertical fragments: original rowid propagated into locals.
    def _sub(alias_db: str, table_name: str) -> str:
        return f"{_qi(alias_db)}.{_qi(table_name)}"

    from_parts = f"{_sub(alias0, lt0)} {aliases[0]}"
    for i in range(1, len(entries)):
        inv_i, alias_i, lt_i = inv_maps[i]
        jc = f"{aliases[0]}.{_qi('__orig_rowid')} = {aliases[i]}.{_qi('__orig_rowid')}"
        from_parts += f" JOIN {_sub(alias_i, lt_i)} {aliases[i]} ON {jc}"

    return f"SELECT {', '.join(select_parts)} FROM {from_parts}"


def _build_rpart_select(orig_table, orig_cols, entries):
    """Build SELECT for row-partitioned table reconstruction.

    Uses UNION (distinct) when any fragment has row overlap, UNION ALL
    otherwise.
    """
    union_parts = []
    has_overlap = any(
        getattr(transform, "row_partition_has_overlap", False)
        for _, _, transform in entries
    )
    for local, lt_name, transform in entries:
        alias = local.local_name
        inv_map = {v: k for k, v in transform.column_map.items()}

        select_parts = []
        for oc in orig_cols:
            local_col = inv_map.get(oc, oc)
            select_parts.append(
                f"{_qi(alias)}.{_qi(lt_name)}.{_qi(local_col)} AS {_qi(oc)}"
            )

        select_clause = ", ".join(select_parts)
        union_parts.append(f"SELECT {select_clause} FROM {_qi(alias)}.{_qi(lt_name)}")

    joiner = " UNION " if has_overlap else " UNION ALL "
    return joiner.join(union_parts)
