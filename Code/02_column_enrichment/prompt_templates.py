from __future__ import annotations

import os
from typing import Final

_PROMPTS_DIR = os.path.join(os.path.dirname(__file__), "prompts")

PRIMARY_TEMPLATE: Final[str] = os.path.join(
    _PROMPTS_DIR, "column_enrichment_primary.template.txt"
)
REPAIR_TEMPLATE: Final[str] = os.path.join(
    _PROMPTS_DIR, "column_enrichment_json_repair.template.txt"
)


def _read(path: str) -> str:
    with open(path, "r", encoding="utf-8") as f:
        return f.read()


def format_primary_prompt(input_json_text: str) -> str:
    body = _read(PRIMARY_TEMPLATE)
    if "{{INPUT_JSON}}" not in body:
        raise ValueError(f"Template missing {{INPUT_JSON}} placeholder: {PRIMARY_TEMPLATE}")
    return body.replace("{{INPUT_JSON}}", input_json_text.strip())


def format_repair_prompt(failed_response: str) -> str:
    body = _read(REPAIR_TEMPLATE)
    if "{{FAILED_RESPONSE}}" not in body:
        raise ValueError(
            f"Template missing {{FAILED_RESPONSE}} placeholder: {REPAIR_TEMPLATE}"
        )
    clipped = failed_response[:120000]
    return body.replace("{{FAILED_RESPONSE}}", clipped)
