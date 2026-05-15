"""Sample 3–5 distinct (or first non-null) values per column."""

from __future__ import annotations

import sqlite3
from typing import Any, Dict, List, Optional, Sequence

MAX_STRING_LEN = 200
MAX_SAMPLES_DEFAULT = 5


def _quote_ident(name: str) -> str:
    return '"' + name.replace('"', '""') + '"'


def _normalize_value(v: Any) -> Any:
    if v is None:
        return None
    if isinstance(v, (bytes, bytearray)):
        try:
            s = v.decode("utf-8", errors="replace")
        except Exception:
            s = repr(v)
        if len(s) > MAX_STRING_LEN:
            return s[: MAX_STRING_LEN - 3] + "..."
        return s
    if isinstance(v, str) and len(v) > MAX_STRING_LEN:
        return v[: MAX_STRING_LEN - 3] + "..."
    return v


def sample_column_values(
    conn: sqlite3.Connection,
    table: str,
    column: str,
    k: int = MAX_SAMPLES_DEFAULT,
) -> List[Any]:
    tq = _quote_ident(table)
    cq = _quote_ident(column)
    samples: List[Any] = []

    try:
        cur = conn.execute(
            f"SELECT DISTINCT {cq} AS v FROM {tq} "
            f"WHERE {cq} IS NOT NULL LIMIT ?",
            (k * 3,),
        )
        seen = set()
        for (val,) in cur.fetchall():
            nv = _normalize_value(val)
            key = repr(nv)
            if key in seen:
                continue
            seen.add(key)
            samples.append(nv)
            if len(samples) >= k:
                break
    except sqlite3.Error:
        samples = []

    if len(samples) >= k:
        return samples[:k]

    try:
        cur = conn.execute(
            f"SELECT {cq} AS v FROM {tq} WHERE {cq} IS NOT NULL LIMIT ?",
            (k * 5,),
        )
        seen = {repr(s) for s in samples}
        for (val,) in cur.fetchall():
            nv = _normalize_value(val)
            key = repr(nv)
            if key in seen:
                continue
            seen.add(key)
            samples.append(nv)
            if len(samples) >= k:
                break
    except sqlite3.Error:
        pass

    return samples[:k]

def sample_values_from_sample_rows(
    sample_rows: Sequence[Dict[str, Any]],
    column: str,
    k: int = MAX_SAMPLES_DEFAULT,
) -> List[Any]:
    """Extract up to k distinct non-null values for column from provided sample rows."""
    out: List[Any] = []
    seen = set()
    for r in sample_rows:
        if not isinstance(r, dict):
            continue
        if column not in r:
            continue
        nv = _normalize_value(r.get(column))
        if nv is None:
            continue
        key = repr(nv)
        if key in seen:
            continue
        seen.add(key)
        out.append(nv)
        if len(out) >= k:
            break
    return out[:k]

