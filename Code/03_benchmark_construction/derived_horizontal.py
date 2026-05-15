from __future__ import annotations

from typing import Dict, List, Tuple

from schema_parser import SchemaGraph


def apply_derived_horizontal_fragmentation(
    schema_graph: SchemaGraph,
    *,
    enabled: bool = False,
    **kwargs,
) -> Tuple[Dict, List]:
    """
    Placeholder for one-hop derived splits. Returns ({}, []) when disabled.
    """
    if not enabled:
        return {}, []
    return {}, []
