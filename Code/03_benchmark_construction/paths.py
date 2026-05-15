from __future__ import annotations

import json
import os
from pathlib import Path
from typing import Optional


def final_version_root() -> Path:
    """Parent of ``03_benchmark_construction`` (the ``Code/`` directory)."""
    return Path(__file__).resolve().parents[1]


def data_bird_root() -> str:
    return str(final_version_root() / "data" / "BIRD")


def data_spider2_root() -> str:
    return str(final_version_root() / "data" / "Spider2")


def data_table_classifications_bird() -> str:
    return str(final_version_root() / "data" / "table_classifications" / "BIRD")


def data_table_classifications_subdir(name: str) -> str:
    """e.g. name=Spider2 → .../data/table_classifications/Spider2"""
    return str(final_version_root() / "data" / "table_classifications" / name)


def repo_root() -> Path:
    """Repository root (parent of ``final_version/``)."""
    return final_version_root().parent.parent


def legacy_column_enrichment_root() -> str:
    """Repo-root ``column_enrichment/`` tree (Beaver / ScienceBenchmark batch inputs)."""
    return str(repo_root() / "column_enrichment")


def infer_original_db_path_from_instance(instance_dir: str) -> Optional[str]:
    """
    Infer path to the original SQLite DB without reading metadata.json.

    Reads ``mappings/transform_spec.json`` → ``vertical_split_selection`` →
    ``column_semantic_enrichment_path_resolved``; original DB is
    ``<dir(enrichment)>/<basename(dir)>.sqlite`` (BIRD-style layout).
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
