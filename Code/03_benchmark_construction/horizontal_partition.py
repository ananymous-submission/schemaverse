from __future__ import annotations

import hashlib
import math
import os
import random
import re
import sqlite3
from typing import Any, Dict, List, Optional, Sequence, Set, Tuple

from config import DifficultyConfig
from schema_parser import SchemaGraph

try:  # pandas is listed in requirements; guard so import failure does not break tests
    import pandas as pd  # type: ignore
    _HAS_PANDAS = True
except Exception:  # pragma: no cover
    pd = None  # type: ignore
    _HAS_PANDAS = False

try:  # Use desbordante for AFD discovery when available.
    import desbordante  # type: ignore
    _HAS_DESBORDANTE = True
except Exception:  # pragma: no cover - fall back to pandas precision computation
    desbordante = None  # type: ignore
    _HAS_DESBORDANTE = False


# ──────────────────────────────────────────────────────────────────────
# Small helpers (reused from the previous implementation)
# ──────────────────────────────────────────────────────────────────────

def _is_fk_column(tname: str, cname: str, schema_graph: SchemaGraph) -> bool:
    for fk in schema_graph.foreign_keys:
        if fk.from_table == tname and fk.from_column == cname:
            return True
        if fk.to_table == tname and fk.to_column == cname:
            return True
    return False


def _lit_sql(v: object) -> str:
    if v is None:
        return "NULL"
    if isinstance(v, str):
        return "'" + v.replace("'", "''") + "'"
    return str(v)


def _qi(name: str) -> str:
    """Quote an SQLite identifier using double quotes (robust with `[`/`]` in names)."""
    safe = (name or "").replace('"', '""')
    return f"\"{safe}\""


_DATEISH = re.compile(r"^\d{4}-\d{2}-\d{2}")


def _is_dateish_text(samples: Sequence[object]) -> bool:
    if not samples:
        return False
    hit = 0
    for s in list(samples)[:30]:
        if s is None:
            continue
        text = str(s).strip()
        if text and _DATEISH.match(text):
            hit += 1
    return hit >= max(3, min(len(samples), 30) // 2)


def _table_seeded_rng(seed: int, tname: str) -> random.Random:
    h = int(hashlib.md5(tname.encode("utf-8")).hexdigest()[:8], 16)
    return random.Random(seed + h)


# ──────────────────────────────────────────────────────────────────────
# Stage 1: Candidate column pre-filter
# ──────────────────────────────────────────────────────────────────────

def _candidate_columns(
    conn: sqlite3.Connection,
    tname: str,
    schema_graph: SchemaGraph,
    allowed_non_pk: Optional[Set[str]],
    config: DifficultyConfig,
) -> Dict[str, Dict[str, Any]]:
    """Return {col_name: stats} for columns that pass the HF eligibility filter.

    Stats include:
      - n (rows), nd (distinct non-null count), nn (nulls),
      - top_rows: list[(value, count)] up to 10 entries,
      - ctype: uppercase SQLite type hint,
      - is_numeric: True when the column is INTEGER / REAL / FLOAT / DOUBLE / NUMERIC,
      - is_dateish: True for date-like TEXT columns,
      - top_frac: fraction of rows that equal the most common value (NULL counted).
    """
    tbl = schema_graph.tables[tname]
    cur = conn.cursor()

    max_uniq = float(getattr(config, "max_column_uniqueness_ratio", 0.5))
    max_null = float(getattr(config, "max_column_null_ratio", 0.6))
    min_part = float(getattr(config, "min_partition_ratio", 0.2))

    candidates: Dict[str, Dict[str, Any]] = {}

    for col in tbl.columns:
        if col.is_pk:
            continue
        if allowed_non_pk is not None and col.name not in allowed_non_pk:
            continue
        if _is_fk_column(tname, col.name, schema_graph):
            continue

        try:
            cur.execute(
                f"SELECT COUNT(*), COUNT(DISTINCT {_qi(col.name)}), "
                f"SUM({_qi(col.name)} IS NULL) FROM {_qi(tname)}"
            )
            n, nd, nn = cur.fetchone()
            n = int(n or 0)
            nd = int(nd or 0)
            nn = int(nn or 0)
        except Exception:
            continue
        if n <= 0 or nd < 2:
            continue
        if nn / max(n, 1) > max_null:
            continue
        if nd / max(n, 1) > max_uniq:
            continue

        try:
            cur.execute(
                f"SELECT {_qi(col.name)}, COUNT(*) AS cnt FROM {_qi(tname)} "
                f"GROUP BY {_qi(col.name)} ORDER BY cnt DESC LIMIT 10"
            )
            top_rows = cur.fetchall()
        except Exception:
            continue

        top_cnt = int(top_rows[0][1]) if top_rows else 0
        top_frac = top_cnt / n if n else 1.0
        if top_frac > (1.0 - min_part):
            continue  # near-constant: dominant value eats all but < min_part

        ctype = (col.type or "TEXT").upper()
        is_numeric = ctype in ("INTEGER", "INT", "REAL", "FLOAT", "DOUBLE", "NUMERIC")
        nonnull_samples = [r[0] for r in top_rows if r[0] is not None][:15]
        if "TEXT" in ctype or ctype == "":
            if nonnull_samples and max(len(str(s)) for s in nonnull_samples) > 200:
                continue
        is_dateish = (not is_numeric) and _is_dateish_text(nonnull_samples)

        candidates[col.name] = {
            "n": n,
            "nd": nd,
            "nn": nn,
            "top_rows": list(top_rows),
            "top_frac": top_frac,
            "ctype": ctype,
            "is_numeric": is_numeric,
            "is_dateish": is_dateish,
        }

    return candidates


# ──────────────────────────────────────────────────────────────────────
# Stage 2: AFD discovery (desbordante if available, pandas otherwise)
# ──────────────────────────────────────────────────────────────────────

def _load_sample(
    conn: sqlite3.Connection,
    tname: str,
    cols: Sequence[str],
    n_max: int,
    seed: int,
) -> Optional["pd.DataFrame"]:
    if not _HAS_PANDAS:
        return None
    col_list = ", ".join(f"[{c}]" for c in cols)
    try:
        total = int(conn.execute(f"SELECT COUNT(*) FROM {_qi(tname)}").fetchone()[0])
    except Exception:
        return None
    if total <= 0:
        return None
    if total <= n_max:
        query = f"SELECT {col_list} FROM {_qi(tname)}"
    else:
        frac = n_max / total
        query = (
            f"SELECT {col_list} FROM {_qi(tname)} "
            f"WHERE abs(random() % 1000) < {int(max(1, round(frac * 1000)))} "
            f"LIMIT {n_max}"
        )
    try:
        df = pd.read_sql_query(query, conn)
    except Exception:
        return None
    return df


def _precision_single_lhs(df: "pd.DataFrame", lhs: str, rhs: str) -> float:
    """c(lhs -> rhs) = 1 - g3 on the sample. NULLs count as a value."""
    if lhs == rhs:
        return 1.0
    total = len(df)
    if total <= 0:
        return 0.0
    covered = (
        df.groupby(lhs, dropna=False)[rhs]
        .apply(lambda s: s.value_counts(dropna=False).iloc[0] if len(s) else 0)
        .sum()
    )
    try:
        return float(covered) / float(total)
    except Exception:
        return 0.0


def _mine_afds_desbordante(
    df: "pd.DataFrame",
    cols: Sequence[str],
    error_threshold: float,
) -> Optional[List[Tuple[str, str, float]]]:
    """Return list of (lhs_col, rhs_col, precision) or None on any failure."""
    if not _HAS_DESBORDANTE:
        return None
    try:
        # Desbordante's AFD algorithms exist under slightly different module
        # paths across releases; probe the common ones in order.
        algo = None
        # Prefer Tane first: in practice Pyro/Default can stall on some tables
        # in this environment, while Tane is stable and fast for single-LHS AFDs.
        for mod_path in (
            ("afd", "algorithms", "Tane"),
            ("afd", "algorithms", "Default"),
            ("afd", "algorithms", "Pyro"),
        ):
            obj: Any = desbordante
            try:
                for part in mod_path:
                    obj = getattr(obj, part)
                algo = obj()
                break
            except Exception:
                algo = None
                continue
        if algo is None:
            return None

        algo.load_data(table=df)
        try:
            algo.execute(error=float(error_threshold), max_lhs=1)
        except TypeError:
            algo.execute(error=float(error_threshold))

        fds = algo.get_fds()
    except Exception:
        return None

    col_list = list(df.columns)
    results: List[Tuple[str, str, float]] = []
    for fd in fds:
        try:
            lhs_idx = list(getattr(fd, "lhs_indices", []) or [])
            rhs_idx = getattr(fd, "rhs_index", None)
            if rhs_idx is None or len(lhs_idx) != 1:
                continue
            lhs = col_list[int(lhs_idx[0])]
            rhs = col_list[int(rhs_idx)]
            err = float(getattr(fd, "error", 0.0) or 0.0)
        except Exception:
            continue
        precision = max(0.0, min(1.0, 1.0 - err))
        results.append((lhs, rhs, precision))
    return results


def _mine_afds(
    df: "pd.DataFrame",
    cols: Sequence[str],
    error_threshold: float,
) -> List[Tuple[str, str, float]]:
    """Discover single-LHS AFDs. Uses desbordante if available, falls back to
    a direct pandas precision sweep (equivalent under 1 - g3 semantics)."""
    from_desb = _mine_afds_desbordante(df, cols, error_threshold)
    if from_desb is not None:
        return from_desb

    min_strength = 1.0 - error_threshold
    out: List[Tuple[str, str, float]] = []
    col_set = list(cols)
    for lhs in col_set:
        for rhs in col_set:
            if lhs == rhs:
                continue
            c = _precision_single_lhs(df, lhs, rhs)
            if c >= min_strength:
                out.append((lhs, rhs, c))
    return out


# ──────────────────────────────────────────────────────────────────────
# Stage 3: Column score (single-threshold precision × coverage)
# ──────────────────────────────────────────────────────────────────────

def _score_columns(
    deps: List[Tuple[str, str, float]],
    candidate_cols: Sequence[str],
    afd_min_strength: float,
) -> Dict[str, Dict[str, Any]]:
    """Compute per-column {score, mean_strong, coverage, strong_deps}.

    - strong_deps[C]: list of (A, c) with c >= afd_min_strength.
    - mean_strong(C) = mean(c for (A,c) in strong_deps[C]) or 0.
    - coverage(C)    = |strong_deps[C]| / (m - 1), m = |candidate_cols|.
    - score(C)       = mean_strong(C) * coverage(C).
    """
    strong_by_col: Dict[str, List[Tuple[str, float]]] = {c: [] for c in candidate_cols}
    for lhs, rhs, c in deps:
        if c < afd_min_strength:
            continue
        if lhs not in strong_by_col:
            continue
        if rhs == lhs:
            continue
        strong_by_col[lhs].append((rhs, float(c)))

    m = max(1, len(candidate_cols) - 1)  # excluding C itself
    scores: Dict[str, Dict[str, Any]] = {}
    for col, deps_list in strong_by_col.items():
        deps_list.sort(key=lambda t: (-t[1], t[0]))
        if deps_list:
            mean_strong = sum(c for _, c in deps_list) / len(deps_list)
        else:
            mean_strong = 0.0
        coverage = len(deps_list) / m
        score = mean_strong * coverage
        scores[col] = {
            "score": float(score),
            "mean_strong": float(mean_strong),
            "coverage": float(coverage),
            "strong_deps": deps_list,
        }
    return scores


# ──────────────────────────────────────────────────────────────────────
# Stage 4: Choose F and build base predicates
# ──────────────────────────────────────────────────────────────────────

def _build_base_predicates(
    conn: sqlite3.Connection,
    tname: str,
    col: str,
    stats: Dict[str, Any],
    config: DifficultyConfig,
) -> Optional[Dict[str, Any]]:
    """Return a dict with F, base predicates, values, roles, and kind, or None.

    Handles three shapes:
    - categorical (nd <= hf_max_num_fragments): one bucket per distinct value.
    - categorical with many values: top-(F-1) buckets + one OTHER bucket.
    - numeric/date-like: hf_numeric_default_fragments quantile buckets.
    """
    n = int(stats["n"])
    nd = int(stats["nd"])
    is_numeric = bool(stats["is_numeric"])
    is_dateish = bool(stats["is_dateish"])
    min_ratio = float(getattr(config, "min_partition_ratio", 0.2))
    f_max = int(getattr(config, "hf_max_num_fragments", 5))
    f_numeric_default = int(getattr(config, "hf_numeric_default_fragments", 4))

    cur = conn.cursor()

    if is_numeric or is_dateish:
        f_raw = max(2, min(f_numeric_default, f_max))
        try:
            order_expr = (
                f"CAST({_qi(col)} AS REAL)" if is_numeric else f"{_qi(col)}"
            )
            cur.execute(
                f"SELECT {_qi(col)} FROM {_qi(tname)} WHERE {_qi(col)} IS NOT NULL "
                f"ORDER BY {order_expr}"
            )
            ordered_vals = [r[0] for r in cur.fetchall()]
        except Exception:
            return None
        n_nonnull = len(ordered_vals)
        if n_nonnull < f_raw:
            f_raw = max(2, n_nonnull)
            if f_raw < 2:
                return None
        boundaries: List[object] = []
        for k in range(1, f_raw):
            idx = max(0, min(n_nonnull - 1, (k * n_nonnull) // f_raw - 1))
            boundaries.append(ordered_vals[idx])

        predicates: List[str] = []
        roles: List[str] = []
        partition_values: List[object] = []
        for i in range(f_raw):
            if i == 0:
                bound = boundaries[0]
                pred = f"({_qi(col)} IS NOT NULL AND {_qi(col)} <= {_lit_sql(bound)})"
                role = f"rows where {col} <= {bound}"
                partition_values.append({"upper": bound})
            elif i == f_raw - 1:
                prev = boundaries[i - 1]
                pred = f"({_qi(col)} > {_lit_sql(prev)} OR {_qi(col)} IS NULL)"
                role = f"rows where {col} > {prev} or is NULL"
                partition_values.append({"lower": prev, "includes_null": True})
            else:
                prev = boundaries[i - 1]
                bound = boundaries[i]
                pred = (
                    f"({_qi(col)} IS NOT NULL AND {_qi(col)} > {_lit_sql(prev)} "
                    f"AND {_qi(col)} <= {_lit_sql(bound)})"
                )
                role = f"rows where {prev} < {col} <= {bound}"
                partition_values.append({"lower": prev, "upper": bound})
            predicates.append(pred)
            roles.append(role)

        counts = [_count_where(cur, tname, p) for p in predicates]
        predicates, partition_values, roles, counts = _enforce_balance(
            predicates, partition_values, roles, counts, n, min_ratio,
            numeric_like=True,
        )
        if predicates is None or len(predicates) < 2:
            return None
        kind = "afd_date_quantile" if is_dateish else "afd_numeric_quantile"
        return {
            "F": len(predicates),
            "base_predicates": predicates,
            "partition_values": partition_values,
            "fragment_roles": roles,
            "counts": counts,
            "predicate_kind": kind,
        }

    # Categorical case
    try:
        cur.execute(
            f"SELECT {_qi(col)}, COUNT(*) AS cnt FROM {_qi(tname)} "
            f"WHERE {_qi(col)} IS NOT NULL GROUP BY {_qi(col)} ORDER BY cnt DESC, {_qi(col)}"
        )
        value_freq = cur.fetchall()
    except Exception:
        return None
    if not value_freq:
        return None
    null_count = int(cur.execute(
        f"SELECT SUM({_qi(col)} IS NULL) FROM {_qi(tname)}"
    ).fetchone()[0] or 0)

    if nd <= f_max:
        predicates = []
        roles = []
        partition_values = []
        for i, (v, _c) in enumerate(value_freq):
            if i < len(value_freq) - 1:
                pred = f"{_qi(col)} = {_lit_sql(v)}"
            else:
                pred = f"({_qi(col)} = {_lit_sql(v)} OR {_qi(col)} IS NULL)"
            role = f"rows where {col} = {v}" + (" or is NULL" if i == len(value_freq) - 1 else "")
            predicates.append(pred)
            roles.append(role)
            partition_values.append({"value": v, "includes_null": i == len(value_freq) - 1})
        kind = "afd_categorical_fway"
    else:
        top = value_freq[: f_max - 1]
        predicates = []
        roles = []
        partition_values = []
        for v, _c in top:
            predicates.append(f"{_qi(col)} = {_lit_sql(v)}")
            roles.append(f"rows where {col} = {v}")
            partition_values.append({"value": v, "includes_null": False})
        top_values_sql = ", ".join(_lit_sql(v) for v, _ in top)
        predicates.append(
            f"({_qi(col)} IS NULL OR {_qi(col)} NOT IN ({top_values_sql}))"
        )
        excluded_values = [v for v, _ in top]
        excluded_display = ", ".join(repr(v) for v in excluded_values)
        roles.append(
            f"rows where {col} is NULL or not in {{{excluded_display}}} "
            f"(catch-all 'OTHER' bucket)"
        )
        partition_values.append({"value": "__OTHER__", "includes_null": True,
                                 "excluded_values": excluded_values})
        kind = "afd_categorical_topk_plus_other"

    counts = [_count_where(cur, tname, p) for p in predicates]
    predicates, partition_values, roles, counts = _enforce_balance(
        predicates, partition_values, roles, counts, n, min_ratio,
        numeric_like=False,
    )
    if predicates is None or len(predicates) < 2:
        return None
    return {
        "F": len(predicates),
        "base_predicates": predicates,
        "partition_values": partition_values,
        "fragment_roles": roles,
        "counts": counts,
        "predicate_kind": kind,
    }


def _count_where(cur: sqlite3.Cursor, tname: str, where_sql: str) -> int:
    try:
        cur.execute(f"SELECT COUNT(*) FROM {_qi(tname)} WHERE {where_sql}")
        return int(cur.fetchone()[0])
    except Exception:
        return 0


def _enforce_balance(
    predicates: List[str],
    values: List[Any],
    roles: List[str],
    counts: List[int],
    n: int,
    min_ratio: float,
    numeric_like: bool,
) -> Tuple[Optional[List[str]], Optional[List[Any]], Optional[List[str]], Optional[List[int]]]:
    """Merge too-small buckets with a neighbour until all meet min_ratio.

    Neighbour policy:
    - numeric_like: merge with the adjacent bucket with the smallest count.
    - categorical: merge the smallest bucket with the next-smallest peer.

    Returns the final (predicates, values, roles, counts) or (None,…) if
    we cannot keep at least two buckets above the threshold.
    """
    if min_ratio <= 0 or n <= 0:
        return predicates, values, roles, counts
    threshold = max(1, int(math.ceil(min_ratio * n)))

    for _ in range(len(predicates)):
        if len(predicates) < 2:
            break
        too_small = [i for i, c in enumerate(counts) if c < threshold]
        if not too_small:
            break
        i = min(too_small, key=lambda k: (counts[k], k))
        if numeric_like:
            neighbours = [j for j in (i - 1, i + 1) if 0 <= j < len(predicates)]
            j = min(neighbours, key=lambda k: counts[k])
        else:
            others = [k for k in range(len(predicates)) if k != i]
            if not others:
                break
            j = min(others, key=lambda k: counts[k])
        a, b = sorted([i, j])
        predicates[a] = f"({predicates[a]} OR {predicates[b]})"
        counts[a] = counts[a] + counts[b]
        merged_role = f"{roles[a]} + {roles[b]}"
        roles[a] = merged_role
        if isinstance(values[a], dict) and isinstance(values[b], dict):
            merged = {"merged_buckets": [values[a], values[b]]}
            values[a] = merged
        elif isinstance(values[a], list):
            values[a] = values[a] + [values[b]]
        else:
            values[a] = [values[a], values[b]]
        del predicates[b]
        del counts[b]
        del roles[b]
        del values[b]

    if len(predicates) < 2:
        return None, None, None, None
    if min(counts) < threshold:
        return None, None, None, None
    return predicates, values, roles, counts


# ──────────────────────────────────────────────────────────────────────
# Stage 5: Row-overlap injection
# ──────────────────────────────────────────────────────────────────────

def _fetch_rowids(
    cur: sqlite3.Cursor, tname: str, where_sql: str
) -> List[int]:
    try:
        cur.execute(f"SELECT rowid FROM [{tname}] WHERE {where_sql}")
        return [int(r[0]) for r in cur.fetchall()]
    except Exception:
        return []


def _rowid_in_chunked(rowids: Sequence[int]) -> str:
    """Render a rowid IN (...) predicate safely (chunked to avoid 999-param
    limits even though SQLite normally allows much larger literal lists)."""
    if not rowids:
        return "0"
    chunks: List[str] = []
    ids = list(rowids)
    step = 800
    for k in range(0, len(ids), step):
        part = ids[k : k + step]
        chunks.append("rowid IN (" + ",".join(str(int(x)) for x in part) + ")")
    return "(" + " OR ".join(chunks) + ")"


def _inject_overlap(
    conn: sqlite3.Connection,
    tname: str,
    base_predicates: Sequence[str],
    rng: random.Random,
    overlap_fraction: float,
) -> Tuple[List[str], float, List[Dict[str, Any]]]:
    """Build final predicate_sqls with 10–15% row overlap mirrored between
    neighbouring fragments. Returns (predicate_sqls, overlap_ratio_used,
    overlap_audit) where overlap_audit[i] describes the mirroring at i.
    """
    cur = conn.cursor()
    f = len(base_predicates)
    if f < 2:
        return list(base_predicates), 0.0, []

    o = max(0.0, float(overlap_fraction))
    # Prevent huge `rowid IN (...)` predicates on large tables, which can flood
    # stdout (if surfaced via errors) and become extremely slow for SQLite to parse/execute.
    # This caps the number of mirrored rowids per fragment.
    max_mirrored = 20000

    per_fragment_rowids: List[List[int]] = [
        _fetch_rowids(cur, tname, p) for p in base_predicates
    ]
    mirrored_into: List[List[int]] = [[] for _ in range(f)]
    audit: List[Dict[str, Any]] = []

    for i in range(f):
        src = per_fragment_rowids[i]
        base_n = len(src)
        if base_n == 0 or o <= 0:
            audit.append({"from": i, "to": None, "count": 0, "base_count": base_n})
            continue
        target = (i + 1) % f
        sample_size = int(math.ceil(o * base_n))
        sample_size = min(sample_size, base_n, max_mirrored)
        sampled = rng.sample(src, sample_size) if sample_size > 0 else []
        mirrored_into[target].extend(sampled)
        audit.append({
            "from": i,
            "to": target,
            "count": sample_size,
            "base_count": base_n,
        })

    final_preds: List[str] = []
    for i, base in enumerate(base_predicates):
        extra = sorted(set(mirrored_into[i]))
        if extra:
            final_preds.append(f"({base} OR {_rowid_in_chunked(extra)})")
        else:
            final_preds.append(base)
    return final_preds, float(o), audit


# ──────────────────────────────────────────────────────────────────────
# Public entry points
# ──────────────────────────────────────────────────────────────────────

def _build_name_prefix_base(name_prefix: str) -> str:
    return re.sub(r"[^a-zA-Z0-9_]+", "_", name_prefix).strip("_")


def _partition_name_hint(
    chosen_col: str,
    predicate_kind: str,
    partition_value: Any,
    idx: int,
    total: int,
) -> str:
    """Build an ordinal partition name hint (legacy).

    Note: LLM-facing prompts are hardened to avoid ordinal naming patterns,
    but the *internal* fragment role/table names produced by this module may
    still contain ordinals.
    """
    kind = str(predicate_kind or "")

    # Quantile-based predicates use q1..qF style.
    if kind in ("afd_numeric_quantile", "afd_date_quantile"):
        return f"q{idx + 1}"

    # Categorical / other predicate kinds use part1..partF style.
    return f"part{idx + 1}"


def _build_partition_names(
    base: str,
    chosen_col: str,
    predicate_kind: str,
    partition_values: Sequence[Any],
    F: int,
) -> List[str]:
    names: List[str] = []
    used: Set[str] = set()
    for i in range(F):
        pv = partition_values[i] if i < len(partition_values) else {}
        hint = _partition_name_hint(chosen_col, predicate_kind, pv, i, F)
        candidate = _sanitize(f"{base}_{hint}")[:64]
        if not candidate:
            candidate = f"{base}_{_sanitize(chosen_col)}_segment"
        if candidate in used:
            candidate = f"{candidate}_{_sanitize(hex(i + 17)[2:])}"
        used.add(candidate)
        names.append(candidate)
    return names


def _choose_partition_core(
    schema_graph: SchemaGraph,
    tname: str,
    db_path: str,
    config: DifficultyConfig,
    name_prefix: str,
    allowed_non_pk: Optional[Set[str]],
) -> Optional[Dict[str, Any]]:
    tbl = schema_graph.tables[tname]
    if not tbl.primary_keys:
        return None
    min_rows = int(getattr(config, "min_rows_for_hfrag", 40))
    if tbl.row_count < min_rows:
        return None

    afd_min_strength = float(getattr(config, "afd_min_strength", 0.7))
    afd_max_sample_rows = int(getattr(config, "afd_max_sample_rows", 20000))
    overlap_fraction = float(getattr(config, "row_partition_overlap_fraction", 0.12))
    f_max = int(getattr(config, "hf_max_num_fragments", 5))

    conn = sqlite3.connect(db_path)
    try:
        candidates = _candidate_columns(
            conn, tname, schema_graph, allowed_non_pk, config
        )
        if len(candidates) < 1:
            return None

        if _HAS_PANDAS and len(candidates) >= 2:
            df = _load_sample(
                conn, tname, list(candidates.keys()),
                afd_max_sample_rows, int(getattr(config, "seed", 42)),
            )
        else:
            df = None

        if df is not None and len(df) >= 10 and len(candidates) >= 2:
            error_threshold = max(0.0, 1.0 - afd_min_strength)
            deps = _mine_afds(df, list(candidates.keys()), error_threshold)
            col_scores = _score_columns(deps, list(candidates.keys()), afd_min_strength)
        else:
            deps = []
            col_scores = {
                c: {"score": 0.0, "mean_strong": 0.0, "coverage": 0.0, "strong_deps": []}
                for c in candidates
            }

        # Ranking: primary by AFD score, then balance preference, then column.
        def _rank_key(col: str) -> Tuple[float, float, float, int, str]:
            s = col_scores[col]
            nd = int(candidates[col]["nd"])
            # Prefer nd close to f_max (more uniform fragments). Distance
            # smaller is better; use negative so sort ascending == best first
            # consistent with other negative primaries.
            dist_to_fmax = abs(min(nd, f_max) - f_max)
            return (
                -float(s["score"]),
                -float(s["mean_strong"]),
                -float(s["coverage"]),
                dist_to_fmax,
                col,
            )

        ranked = sorted(candidates.keys(), key=_rank_key)

        base = _build_name_prefix_base(name_prefix)
        chosen_col: Optional[str] = None
        chosen_partition: Optional[Dict[str, Any]] = None
        for col in ranked:
            plan = _build_base_predicates(
                conn, tname, col, candidates[col], config
            )
            if plan is None:
                continue
            chosen_col = col
            chosen_partition = plan
            break

        if chosen_col is None or chosen_partition is None:
            return None

        rng = _table_seeded_rng(int(getattr(config, "seed", 42)), f"{tname}:{name_prefix}")
        final_predicates, overlap_ratio, overlap_audit = _inject_overlap(
            conn,
            tname,
            chosen_partition["base_predicates"],
            rng,
            overlap_fraction,
        )

        F = int(chosen_partition["F"])
        # Build ordinal (legacy) names for row partitions.
        part_names = _build_partition_names(
            base=base,
            chosen_col=chosen_col,
            predicate_kind=str(chosen_partition["predicate_kind"]),
            partition_values=list(chosen_partition["partition_values"]),
            F=F,
        )
        home_fragment = part_names[0]
        movable_fragments = list(part_names[1:])

        strong_deps_payload = [
            {"lhs": chosen_col, "rhs": a, "precision": round(float(c), 6)}
            for a, c in col_scores[chosen_col]["strong_deps"]
        ]

        return {
            "col": chosen_col,
            "F": F,
            "part_names": part_names,
            "predicate_sqls": final_predicates,
            "base_predicate_sqls": list(chosen_partition["base_predicates"]),
            "partition_values": list(chosen_partition["partition_values"]),
            "predicate_kind": chosen_partition["predicate_kind"],
            "fragment_roles": list(chosen_partition["fragment_roles"]),
            "home_fragment": home_fragment,
            "movable_fragments": movable_fragments,
            "default_movable_fragment": movable_fragments[0] if movable_fragments else home_fragment,
            "overlap_ratio": overlap_ratio,
            "has_overlap": bool(overlap_ratio > 0),
            "overlap_audit": overlap_audit,
            "afd_audit": {
                "column": chosen_col,
                "mean_strong": round(float(col_scores[chosen_col]["mean_strong"]), 6),
                "coverage": round(float(col_scores[chosen_col]["coverage"]), 6),
                "score": round(float(col_scores[chosen_col]["score"]), 6),
                "strong_dependencies": strong_deps_payload,
                "afd_min_strength": afd_min_strength,
                "candidate_columns": sorted(candidates.keys()),
                "ranked_columns": [
                    {
                        "column": c,
                        "score": round(float(col_scores[c]["score"]), 6),
                        "mean_strong": round(float(col_scores[c]["mean_strong"]), 6),
                        "coverage": round(float(col_scores[c]["coverage"]), 6),
                    }
                    for c in ranked
                ],
                "engine": "desbordante" if _HAS_DESBORDANTE else "pandas_g3",
                "sample_rows": int(0 if df is None else len(df)),
            },
            # Legacy A/B fields kept (filled from the first two fragments) for
            # backwards compatibility with any legacy read sites.
            "predicate_sql_fragment_A": final_predicates[0],
            "predicate_sql_fragment_B": final_predicates[1] if F >= 2 else "",
            "fragment_role_A": chosen_partition["fragment_roles"][0],
            "fragment_role_B": chosen_partition["fragment_roles"][1] if F >= 2 else "",
            "balance": _balance_score(chosen_partition["counts"]),
            "rule_priority": 1,  # collapsed to a single rank in the AFD path.
        }
    finally:
        conn.close()


def _sanitize(s: str) -> str:
    return re.sub(r"[^a-zA-Z0-9_]+", "_", s).strip("_") or "col"


def _balance_score(counts: Sequence[int]) -> float:
    total = sum(counts)
    if total <= 0 or not counts:
        return 0.0
    return float(min(counts)) / float(total)


def choose_partition_for_table(
    schema_graph: SchemaGraph,
    tname: str,
    db_path: str,
    config: DifficultyConfig,
) -> Optional[Dict[str, Any]]:
    """AFD-based F-way partition on the full original table."""
    base = _build_name_prefix_base(tname)
    return _choose_partition_core(
        schema_graph, tname, db_path, config, base, allowed_non_pk=None
    )


def choose_partition_for_vertical_fragment(
    schema_graph: SchemaGraph,
    tname: str,
    db_path: str,
    config: DifficultyConfig,
    name_prefix: str,
    allowed_non_pk_columns: Set[str],
) -> Optional[Dict[str, Any]]:
    """AFD-based F-way partition restricted to columns present on a
    vertical fragment. Predicates still operate on the original table."""
    if not allowed_non_pk_columns:
        return None
    return _choose_partition_core(
        schema_graph,
        tname,
        db_path,
        config,
        name_prefix,
        allowed_non_pk=set(allowed_non_pk_columns),
    )


# Backwards-compatible aliases — existing imports from transforms.py keep
# working while call sites are updated.
choose_two_way_partition_for_table = choose_partition_for_table
choose_two_way_partition_for_vertical_fragment = choose_partition_for_vertical_fragment
