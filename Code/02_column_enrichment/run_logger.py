from __future__ import annotations

from datetime import datetime, timezone
from typing import Any, Dict, List, Optional, Tuple


def _split_prompt_output_tokens(usage: Optional[Dict[str, Any]]) -> Tuple[int, int]:
    if not usage:
        return 0, 0
    p = usage.get("prompt_token_count")
    if p is None:
        p = usage.get("prompt_tokens")
    out = 0
    if usage.get("candidates_token_count") is not None:
        out += int(usage["candidates_token_count"])
    if usage.get("thoughts_token_count") is not None:
        out += int(usage["thoughts_token_count"])
    if out == 0 and usage.get("completion_tokens") is not None:
        out = int(usage["completion_tokens"])
    return (int(p) if p is not None else 0, out)


class SessionFileLogger:
    """Accumulates token usage in memory only; does not write log files."""

    def __init__(self, schema_name: str) -> None:
        self.schema_name = schema_name
        self.session_dir = ""
        self.started_at = datetime.now(timezone.utc).isoformat()
        self.total_prompt_tokens = 0
        self.total_output_tokens = 0
        self.column_coverage_events: List[Dict[str, Any]] = []

    def log_interaction(
        self,
        *,
        phase: str,
        backend: str,
        model: str,
        prompt: str,
        response: str,
        usage: Optional[Dict[str, Any]] = None,
        extra: Optional[Dict[str, Any]] = None,
    ) -> None:
        del phase, backend, model, prompt, response, extra
        p, o = _split_prompt_output_tokens(usage)
        self.total_prompt_tokens += p
        self.total_output_tokens += o

    def record_column_coverage(
        self,
        *,
        table: str,
        round_num: int,
        expected: List[str],
        present: List[str],
        missing: List[str],
    ) -> None:
        del table, round_num, expected, present, missing

    def usage_totals(self) -> Dict[str, Any]:
        return {
            "total_prompt_tokens": self.total_prompt_tokens,
            "total_output_tokens": self.total_output_tokens,
            "total_tokens_sum": self.total_prompt_tokens + self.total_output_tokens,
        }


def new_session_logger(schema_name: str) -> SessionFileLogger:
    return SessionFileLogger(schema_name)
