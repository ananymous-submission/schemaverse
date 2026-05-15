"""Extract SQLite user tables, columns, and optional FK hints."""

from __future__ import annotations

import sqlite3
from dataclasses import dataclass, field
from typing import Dict, List, Optional, Tuple


@dataclass
class ColumnInfo:
    cid: int
    name: str
    type: str
    notnull: bool
    default_value: Optional[str]
    pk: bool


@dataclass
class ForeignKeyHint:
    from_column: str
    to_table: str
    to_column: str


@dataclass
class TableSchema:
    name: str
    columns: List[ColumnInfo]
    foreign_keys: List[ForeignKeyHint] = field(default_factory=list)


def list_user_tables(conn: sqlite3.Connection) -> List[str]:
    cur = conn.execute(
        "SELECT name FROM sqlite_master "
        "WHERE type='table' AND name NOT LIKE 'sqlite_%' ORDER BY name"
    )
    return [r[0] for r in cur.fetchall()]


def table_info(conn: sqlite3.Connection, table: str) -> List[ColumnInfo]:
    cur = conn.execute(f'PRAGMA table_info("{table}")')
    cols: List[ColumnInfo] = []
    for row in cur.fetchall():
        cid, name, col_type, notnull, dflt, pk = row
        cols.append(
            ColumnInfo(
                cid=int(cid),
                name=str(name),
                type=str(col_type or ""),
                notnull=bool(notnull),
                default_value=None if dflt is None else str(dflt),
                pk=bool(pk),
            )
        )
    return cols


def foreign_key_list(conn: sqlite3.Connection, table: str) -> List[ForeignKeyHint]:
    cur = conn.execute(f'PRAGMA foreign_key_list("{table}")')
    out: List[ForeignKeyHint] = []
    for row in cur.fetchall():
        # id, seq, table, from, to, on_update, on_delete, match
        _id, _seq, to_table, from_col, to_col = row[0], row[1], row[2], row[3], row[4]
        out.append(
            ForeignKeyHint(
                from_column=str(from_col),
                to_table=str(to_table),
                to_column=str(to_col),
            )
        )
    return out


def extract_schema(db_path: str) -> Dict[str, TableSchema]:
    conn = sqlite3.connect(f"file:{db_path}?mode=ro", uri=True)
    try:
        tables: Dict[str, TableSchema] = {}
        for t in list_user_tables(conn):
            tables[t] = TableSchema(
                name=t,
                columns=table_info(conn, t),
                foreign_keys=foreign_key_list(conn, t),
            )
        return tables
    finally:
        conn.close()
