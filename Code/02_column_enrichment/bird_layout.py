from __future__ import annotations

import os
from typing import List

# Per-database folders live here (dev vs train split under the same BIRD tree).
DEFAULT_BIRD_DATABASES_SUBDIR = "dev_databases"


def databases_root(
    bird_root: str, databases_subdir: str = DEFAULT_BIRD_DATABASES_SUBDIR
) -> str:
    """Absolute path to the folder that contains one subdirectory per database."""
    return os.path.join(os.path.abspath(bird_root), databases_subdir)


def sqlite_path(
    bird_root: str,
    db_name: str,
    databases_subdir: str = DEFAULT_BIRD_DATABASES_SUBDIR,
) -> str:
    base = os.path.join(databases_root(bird_root, databases_subdir), db_name)
    return os.path.join(base, f"{db_name}.sqlite")


def description_dir(
    bird_root: str,
    db_name: str,
    databases_subdir: str = DEFAULT_BIRD_DATABASES_SUBDIR,
) -> str:
    return os.path.join(
        databases_root(bird_root, databases_subdir), db_name, "database_description"
    )


def discover_bird_databases(
    bird_root: str, databases_subdir: str = DEFAULT_BIRD_DATABASES_SUBDIR
) -> List[str]:
    """
    Subdirectories of {bird_root}/{databases_subdir} that contain {name}/{name}.sqlite.
    """
    root = databases_root(bird_root, databases_subdir)
    if not os.path.isdir(root):
        return []
    names: List[str] = []
    for name in sorted(os.listdir(root)):
        path = os.path.join(root, name)
        if not os.path.isdir(path):
            continue
        db_file = os.path.join(path, f"{name}.sqlite")
        if os.path.isfile(db_file):
            names.append(name)
    return names


def assert_sqlite_exists(db_path: str) -> None:
    if not os.path.isfile(db_path):
        raise FileNotFoundError(
            f"SQLite database not found: {db_path}\n"
            "Expected BIRD layout: {bird_root}/<databases_subdir>/<db_name>/<db_name>.sqlite"
        )


def default_output_path(
    bird_root: str,
    db_name: str,
    databases_subdir: str = DEFAULT_BIRD_DATABASES_SUBDIR,
) -> str:
    return os.path.join(
        databases_root(bird_root, databases_subdir),
        db_name,
        "column_semantic_enrichment.json",
    )
