from __future__ import annotations

import os
from typing import List


def spider2_root_default() -> str:
    return os.path.join(
        os.path.abspath(os.path.join(os.path.dirname(__file__), "..")),
        "data",
        "Spider2",
    )


def db_dir(spider2_root: str, db_name: str) -> str:
    return os.path.join(os.path.abspath(spider2_root), db_name)


def sqlite_path(spider2_root: str, db_name: str) -> str:
    return os.path.join(db_dir(spider2_root, db_name), f"{db_name}.sqlite")


def database_description_dir(spider2_root: str, db_name: str) -> str:
    return os.path.join(db_dir(spider2_root, db_name), "database_description")


def default_output_path(spider2_root: str, db_name: str) -> str:
    return os.path.join(db_dir(spider2_root, db_name), "column_semantic_enrichment.json")


def discover_spider2_databases(spider2_root: str) -> List[str]:
    """Subdirectories of ``spider2_root`` that contain ``{name}/{name}.sqlite``."""
    root = os.path.abspath(spider2_root)
    if not os.path.isdir(root):
        return []
    names: List[str] = []
    for name in sorted(os.listdir(root)):
        path = os.path.join(root, name)
        if not os.path.isdir(path):
            continue
        if os.path.isfile(os.path.join(path, f"{name}.sqlite")):
            names.append(name)
    return names


def assert_sqlite_exists(db_path: str) -> None:
    if not os.path.isfile(db_path):
        raise FileNotFoundError(
            f"SQLite database not found: {db_path}\n"
            "Expected layout: {spider2_root}/<db_name>/<db_name>.sqlite"
        )
