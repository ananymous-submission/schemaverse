from __future__ import annotations

import json
import os
from dataclasses import dataclass
from typing import Any, Dict, List, Optional, Tuple


@dataclass
class Spider2TableMeta:
    table_name: str
    columns: Dict[str, Dict[str, str]]  # col -> {column_description?, data_format?}
    sample_rows: List[Dict[str, Any]]


def _safe_read_json(path: str) -> Optional[Dict[str, Any]]:
    try:
        with open(path, "r", encoding="utf-8") as f:
            return json.load(f)
    except OSError:
        return None
    except json.JSONDecodeError:
        return None


def _coerce_str_list(x: Any) -> List[str]:
    if not isinstance(x, list):
        return []
    out: List[str] = []
    for v in x:
        if v is None:
            out.append("")
        else:
            out.append(str(v))
    return out


def _resolve_metadata_json_dir(metadata_root: str, schema_name: str) -> Optional[str]:
    """Find per-table JSON directory for a Spider2 database."""
    root = os.path.abspath(metadata_root)
    candidates = [
        os.path.join(root, schema_name, "database_description"),
        os.path.join(root, schema_name),
        os.path.join(root, "database_description"),
    ]
    if os.path.basename(root) == schema_name:
        candidates.insert(0, os.path.join(root, "database_description"))
    for path in candidates:
        if not os.path.isdir(path):
            continue
        if any(fn.endswith(".json") for fn in os.listdir(path)):
            return path
    return None


def _load_metadata_from_dir(
    schema_dir: str,
) -> Tuple[Dict[str, Dict[str, Dict[str, str]]], Dict[str, List[Dict[str, Any]]]]:
    table_column_meta: Dict[str, Dict[str, Dict[str, str]]] = {}
    table_sample_rows: Dict[str, List[Dict[str, Any]]] = {}

    for fn in sorted(os.listdir(schema_dir)):
        if not fn.endswith(".json"):
            continue
        path = os.path.join(schema_dir, fn)
        obj = _safe_read_json(path)
        if not isinstance(obj, dict):
            continue

        table = str(obj.get("table_name") or obj.get("table_fullname") or "") or fn[:-5]
        col_names = _coerce_str_list(obj.get("column_names"))
        col_types = _coerce_str_list(obj.get("column_types"))
        descs = _coerce_str_list(obj.get("description"))

        cols: Dict[str, Dict[str, str]] = {}
        for i, c in enumerate(col_names):
            c0 = (c or "").strip()
            if not c0:
                continue
            m: Dict[str, str] = {}
            if i < len(descs):
                d = (descs[i] or "").strip()
                if d:
                    m["column_description"] = d
            if i < len(col_types):
                t = (col_types[i] or "").strip()
                if t:
                    # Spider2 stores SQLite-ish types per column; treat as generic data_format.
                    m["data_format"] = t
            if m:
                cols[c0] = m

        if cols:
            table_column_meta[table] = cols

        sr = obj.get("sample_rows")
        if isinstance(sr, list):
            rows: List[Dict[str, Any]] = []
            for r in sr:
                if isinstance(r, dict):
                    rows.append(dict(r))
            if rows:
                table_sample_rows[table] = rows

    return table_column_meta, table_sample_rows


def load_spider2_db_metadata(
    db_dir: str,
) -> Tuple[Dict[str, Dict[str, Dict[str, str]]], Dict[str, List[Dict[str, Any]]]]:
    """Load metadata from ``<db_dir>/database_description/*.json``."""
    desc = os.path.join(os.path.abspath(db_dir), "database_description")
    if not os.path.isdir(desc):
        return {}, {}
    return _load_metadata_from_dir(desc)


def load_spider2_schema_metadata(
    metadata_root: str, schema_name: str
) -> Tuple[Dict[str, Dict[str, Dict[str, str]]], Dict[str, List[Dict[str, Any]]]]:
    """Load Spider2 metadata for one schema.

    Supports:
      - ``<root>/<schema>/database_description/*.json`` (SchemaVerse ``Code/data/Spider2``)
      - ``<root>/<schema>/*.json`` (upstream spider2-lite sqlite metadata tree)
      - ``<db_dir>/database_description/*.json`` when ``metadata_root`` is the DB folder

    Returns:
      - table_column_meta: {table: {col: {column_description?, data_format?}}}
      - table_sample_rows: {table: [rowdict, ...]}
    """
    schema_dir = _resolve_metadata_json_dir(metadata_root, schema_name)
    if not schema_dir:
        return {}, {}
    return _load_metadata_from_dir(schema_dir)

