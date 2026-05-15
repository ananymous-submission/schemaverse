import sqlite3
import os
import secrets
from typing import List, Dict

from schema_parser import SchemaGraph, Table, Column
from transforms import LocalSchema, TableTransform, TransformSpec
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from transforms import LocalSchema


def _qi(name: str) -> str:
    """Quote an SQLite identifier using double quotes (robust with `[`/`]` in names)."""
    safe = (name or "").replace('"', '""')
    return f"\"{safe}\""

def _sqlite_type(col_type: str) -> str:
    """Normalize SQLite type string."""
    if not col_type:
        return "TEXT"
    return col_type.upper()


def _needs_orig_rowid(transform: TableTransform) -> bool:
    """Whether this local table needs propagated source row identity.

    We only need `__orig_rowid` for vertical-fragment joins during reconstruction.
    Keeping it out of non-vertical tables avoids leaking internal helper columns
    into user-facing local schemas.
    """
    return bool(transform.is_vertical_split_fragment)


def _build_create_table_sql(
    local_table_name: str,
    transform: TableTransform,
    schema_graph: SchemaGraph,
    local_schema: 'LocalSchema',
    fk_map: Dict,
    include_internal_columns: bool = True,
    include_inferred_constraints: bool = True,
) -> str:
    """Build CREATE TABLE DDL for a local table.
    
    Preserves FK constraints when both endpoints are in the same local.
    """
    orig_table = schema_graph.tables[transform.source_table]

    # Determine which original columns are in this local table
    # column_map is {local_col_name: orig_col_name}
    inv_map = {v: k for k, v in transform.column_map.items()}

    if transform.projected_columns:
        # Horizontal split: only include projected columns
        orig_cols_to_include = transform.projected_columns
    else:
        # All columns
        orig_cols_to_include = [c.name for c in orig_table.columns]

    # Build column definitions
    col_defs = []
    pk_cols = []

    if include_internal_columns and _needs_orig_rowid(transform):
        # Stable row identity from the original table, needed for vertical-fragment
        # joins when declared PK columns contain NULLs or duplicates.
        col_defs.append(f"    {_qi('__orig_rowid')} INTEGER")

    for orig_col_name in orig_cols_to_include:
        # Find the original column definition
        orig_col = next((c for c in orig_table.columns if c.name == orig_col_name), None)
        if orig_col is None:
            continue

        local_col_name = inv_map.get(orig_col_name, orig_col_name)
        col_type = orig_col.type if orig_col.type else "TEXT"

        parts = [_qi(local_col_name), col_type]

        if orig_col.is_pk:
            pk_cols.append(local_col_name)

        if not orig_col.nullable and not orig_col.is_pk:
            parts.append("NOT NULL")

        if orig_col.default is not None:
            parts.append(f"DEFAULT {orig_col.default}")

        col_defs.append("    " + " ".join(parts))

    # NOTE: Do not emit PRIMARY KEY constraints in locals.
    # Some BIRD DBs contain rows that violate declared PK NOT NULL constraints
    # (e.g., NULLs in a PK column). Enforcing PKs at materialization time would
    # silently drop or error on those rows, breaking losslessness.

    # Add foreign key constraints for intra-local FKs
    # Check all FKs where this table is the "from" table
    fk_constraints = []
    source_table_by_local_table = {
        lname: ltr.source_table for lname, ltr in local_schema.tables.items()
    }
    if fk_map and "foreign_keys" in fk_map:
        for fk_entry in fk_map["foreign_keys"]:
            orig_fk = fk_entry["original"]
            if not include_inferred_constraints and orig_fk.get("origin") == "inferred":
                continue
            if orig_fk["from_table"] != transform.source_table:
                continue
            
            # Check if there's an intra-local pair for this FK
            for pair in fk_entry.get("intra_local_pairs", []):
                if pair["local"] != local_schema.local_name:
                    continue
                if pair["from_local_table"] != local_table_name:
                    continue
                src_from = source_table_by_local_table.get(pair["from_local_table"])
                src_to = source_table_by_local_table.get(pair["to_local_table"])
                # Hide explicit sibling-fragment FK links from one source table.
                if (
                    src_from
                    and src_to
                    and src_from == src_to
                    and pair["from_local_table"] != pair["to_local_table"]
                ):
                    continue
                
                # This FK should be preserved
                from_col = pair["from_local_column"]
                to_table = pair["to_local_table"]
                to_col = pair["to_local_column"]
                
                # Verify:
                # 1. The FK column (from_col) actually exists in this local table
                #    (important for vertical splits where columns are split across fragments)
                # 2. The referenced table exists in this local
                local_cols_in_table = set(transform.column_map.keys())  # Local column names in this table
                if from_col not in local_cols_in_table:
                    # The FK column is not in this fragment, skip
                    continue
                
                if to_table in local_schema.tables:
                    # DDL-only omission: keep fk_map metadata, but omit ~10% constraints.
                    if secrets.SystemRandom().random() < 0.10:
                        continue
                    fk_constraints.append(
                        f"    FOREIGN KEY ({_qi(from_col)}) REFERENCES {_qi(to_table)}({_qi(to_col)})"
                    )

    # Combine all constraints
    all_constraints = col_defs + fk_constraints
    cols_sql = ",\n".join(all_constraints)
    return f"CREATE TABLE {_qi(local_table_name)} (\n{cols_sql}\n);"


def _populate_table(
    src_conn: sqlite3.Connection,
    dst_conn: sqlite3.Connection,
    local_table_name: str,
    transform: TableTransform,
    schema_graph: SchemaGraph,
):
    """Populate a local table from the original database."""
    # Fast, memory-safe bulk copy:
    # Use a single INSERT..SELECT inside SQLite by attaching the source DB to
    # the destination connection. This avoids Python-level row materialization
    # (fetchall/fetchmany) which is both slow and can OOM on large tables.
    orig_table = schema_graph.tables[transform.source_table]
    inv_map = {v: k for k, v in transform.column_map.items()}

    if transform.projected_columns:
        orig_cols = transform.projected_columns
    else:
        orig_cols = [c.name for c in orig_table.columns]

    local_cols = [inv_map.get(c, c) for c in orig_cols]
    include_orig_rowid = _needs_orig_rowid(transform)
    if include_orig_rowid:
        local_cols = ["__orig_rowid"] + local_cols

    insert_cols_sql = ", ".join(_qi(c) for c in local_cols)

    def _source_has_rowid(conn: sqlite3.Connection, table_name: str) -> bool:
        try:
            conn.execute(f"SELECT rowid FROM {_qi(table_name)} LIMIT 1;")
            return True
        except sqlite3.OperationalError:
            return False

    # Stable row identity:
    # - Prefer SQLite rowid when available.
    # - For WITHOUT ROWID tables, synthesize a deterministic surrogate using
    #   ROW_NUMBER() over a stable ORDER BY that is consistent across fragments.
    #   Use declared PK columns when present; otherwise fall back to ordering by
    #   all original columns (not just the projected subset) so multiple fragments
    #   derived from the same source table compute identical __orig_rowid values.
    if _source_has_rowid(src_conn, transform.source_table):
        orig_rowid_expr = "rowid"
    else:
        order_cols = list(orig_table.primary_keys) if orig_table.primary_keys else [c.name for c in orig_table.columns]
        if order_cols:
            order_sql = ", ".join(_qi(c) for c in order_cols)
        else:
            order_sql = "1"
        orig_rowid_expr = f"ROW_NUMBER() OVER (ORDER BY {order_sql})"

    select_cols_sql = ", ".join(_qi(c) for c in orig_cols)
    if include_orig_rowid:
        select_cols_sql = f"{orig_rowid_expr} AS __orig_rowid, " + select_cols_sql

    where_sql = f" WHERE {transform.row_predicate}" if transform.row_predicate else ""
    sql = (
        f"INSERT INTO {_qi(local_table_name)} ({insert_cols_sql}) "
        f"SELECT {select_cols_sql} FROM src.{_qi(transform.source_table)}{where_sql};"
    )

    try:
        dst_conn.execute(sql)
    except sqlite3.OperationalError as e:
        raise sqlite3.OperationalError(
            f"{e} | while populating table={local_table_name!r} "
            f"from source={transform.source_table!r} sql={sql}"
        )


def materialize_locals(
    schema_graph: SchemaGraph,
    locals_list: List[LocalSchema],
    original_db_path: str,
    output_dir: str,
    transform_spec: TransformSpec = None,
) -> Dict[str, str]:
    """
    Create SQLite files and DDL files for each local schema.
    Returns dict mapping local_name -> sqlite_file_path.
    
    If transform_spec is provided, FK constraints within the same local
    will be preserved.
    """
    locals_dir = os.path.join(output_dir, "locals")
    os.makedirs(locals_dir, exist_ok=True)

    # Get FK map from transform spec if available
    fk_map = transform_spec.fk_map if transform_spec and transform_spec.fk_map else None

    src_conn = sqlite3.connect(original_db_path)
    local_paths = {}
    local_ddls: Dict[str, str] = {}

    for local in locals_list:
        db_path = os.path.join(locals_dir, f"{local.local_name}.sqlite")
        ddl_path = os.path.join(locals_dir, f"{local.local_name}_schema.sql")

        # Remove existing file
        if os.path.exists(db_path):
            os.remove(db_path)

        dst_conn = sqlite3.connect(db_path)
        # Speed up bulk loads. Safe because DBs are ephemeral outputs.
        try:
            dst_conn.execute("PRAGMA journal_mode=WAL;")
            dst_conn.execute("PRAGMA synchronous=NORMAL;")
            dst_conn.execute("PRAGMA temp_store=MEMORY;")
            dst_conn.execute("PRAGMA cache_size=-200000;")  # ~200MB
        except Exception:
            pass
        # Attach source DB so inserts can be done in-SQL.
        dst_conn.execute("ATTACH DATABASE ? AS src", (os.path.abspath(original_db_path),))
        ddl_statements = []

        for lt_name, transform in local.tables.items():
            # Build CREATE TABLE for physical SQLite materialization
            create_sql = _build_create_table_sql(
                lt_name, transform, schema_graph, local, fk_map
            )
            # Build exported DDL for humans/LLM-facing schema text.
            # Do not expose internal helper columns like __orig_rowid.
            export_sql = _build_create_table_sql(
                lt_name,
                transform,
                schema_graph,
                local,
                fk_map,
                include_internal_columns=False,
                include_inferred_constraints=False,
            )
            ddl_statements.append(export_sql)

            try:
                dst_conn.execute(create_sql)
            except sqlite3.OperationalError as e:
                print(f"Error creating table {lt_name}: {e}")
                print(f"  DDL: {create_sql}")
                raise

            # Populate with data
            # Wrap each table load in a transaction for speed.
            dst_conn.execute("BEGIN")
            _populate_table(src_conn, dst_conn, lt_name, transform, schema_graph)
            dst_conn.execute("COMMIT")

        dst_conn.close()

        # Write DDL file
        ddl_text = "\n\n".join(ddl_statements)
        with open(ddl_path, "w") as f:
            f.write(ddl_text)
        local_ddls[local.local_name] = ddl_text

        local_paths[local.local_name] = db_path

        # Print summary
        verify_conn = sqlite3.connect(db_path)
        cursor = verify_conn.cursor()
        cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
        tables = [r[0] for r in cursor.fetchall()]
        print(f"\n{local.local_name} ({db_path}):")
        for t in tables:
            cursor.execute(f"SELECT COUNT(*) FROM {_qi(t)}")
            count = cursor.fetchone()[0]
            print(f"  {t}: {count} rows")
        verify_conn.close()

    # Write consolidated schema file with all locals.
    # This is purely for inspection/analysis (not used by the pipeline).
    combined_path = os.path.join(locals_dir, "all_locals_schema.sql")
    with open(combined_path, "w", encoding="utf-8") as f:
        f.write("-- Consolidated local schemas\n")
        f.write(f"-- Generated from: {os.path.abspath(original_db_path)}\n")
        f.write("--\n")
        f.write("-- Each section below corresponds to one local_*.sqlite database.\n\n")
        for local in locals_list:
            name = local.local_name
            f.write(f"-- {'=' * 72}\n")
            f.write(f"-- {name}\n")
            f.write(f"-- DDL file: {name}_schema.sql\n")
            f.write(f"-- {'=' * 72}\n\n")
            f.write((local_ddls.get(name) or "").rstrip() + "\n\n")

    src_conn.close()
    return local_paths
