"""Backward-compatible re-export; logic lives in llm_enrichment.py."""

from llm_enrichment import (
    generate_batch_column_enrichment_json,
    generate_column_enrichment_json,
    parse_json_object,
)

__all__ = [
    "generate_batch_column_enrichment_json",
    "generate_column_enrichment_json",
    "parse_json_object",
]
