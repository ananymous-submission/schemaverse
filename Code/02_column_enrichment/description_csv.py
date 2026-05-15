"""Load BIRD database_description/*.csv column metadata."""

from __future__ import annotations

import csv
import os
from io import StringIO
from typing import Dict, Optional


def _csv_text_stream(csv_path: str) -> StringIO:
    """
    BIRD CSVs are usually UTF-8; some ship as Windows-1252 or Latin-1.
    Decode with fallbacks so a single non-UTF-8 file does not abort --all.
    """
    with open(csv_path, "rb") as bf:
        raw = bf.read()
    text: str
    for enc in ("utf-8-sig", "utf-8", "cp1252", "latin-1"):
        try:
            text = raw.decode(enc)
            break
        except UnicodeDecodeError:
            continue
    else:
        text = raw.decode("latin-1")
    return StringIO(text)


def load_database_descriptions(db_dir: str) -> Optional[Dict[str, Dict[str, Dict[str, str]]]]:
    """
    Returns {table_name: {original_column_name: {column_description, value_description, data_format}}}.
    """
    desc_dir = os.path.join(os.path.abspath(db_dir), "database_description")
    if not os.path.isdir(desc_dir):
        return None

    descriptions: Dict[str, Dict[str, Dict[str, str]]] = {}

    for filename in os.listdir(desc_dir):
        if not filename.endswith(".csv"):
            continue
        table_name = filename[:-4]
        csv_path = os.path.join(desc_dir, filename)
        try:
            reader = csv.DictReader(_csv_text_stream(csv_path))
            table_desc: Dict[str, Dict[str, str]] = {}
            for row in reader:
                col_name = (row.get("original_column_name") or "").strip()
                if not col_name:
                    continue
                table_desc[col_name] = {
                    "column_description": (row.get("column_description") or "").strip(),
                    "value_description": (row.get("value_description") or "").strip(),
                    "data_format": (row.get("data_format") or "").strip(),
                }
            if table_desc:
                descriptions[table_name] = table_desc
        except OSError:
            continue

    return descriptions if descriptions else None
