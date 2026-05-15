from __future__ import annotations

import itertools
import re
import sqlite3
from dataclasses import dataclass
from typing import Any, Dict, List, Optional, Sequence, Tuple

from schema_parser import ForeignKey, SchemaGraph

try:
    import desbordante  # type: ignore
    _HAS_DESBORDANTE = True
except Exception:  # pragma: no cover
    desbordante = None  # type: ignore
    _HAS_DESBORDANTE = False


@dataclass
class PKCandidate:
    table: str
    columns: Tuple[str, ...]
    uniqueness: float
    non_null_ratio: float
    name_score: float
    score: float


@dataclass
class FKCandidate:
    from_table: str
    from_column: str
    to_table: str
    to_column: str
    inclusion_ratio: float
    type_score: float
    name_score: float
    score: float


def _name_score(col_names: Sequence[str]) -> float:
    text = "_".join(col_names).lower()
    score = 0.0
    if re.search(r"(^|_)id($|_)", text):
        score += 0.6
    if text.endswith("_id"):
        score += 0.25
    if "code" in text or "key" in text:
        score += 0.15
    return min(1.0, score)


def _column_type(conn: sqlite3.Connection, table: str, column: str) -> str:
    rows = conn.execute(f'PRAGMA table_info("{table}")').fetchall()
    for _cid, name, ctype, _nn, _dflt, _pk in rows:
        if name == column:
            return str(ctype or "TEXT").upper()
    return "TEXT"


def _is_type_compatible(lhs_type: str, rhs_type: str) -> float:
    l = lhs_type.upper()
    r = rhs_type.upper()
    num = ("INT", "REAL", "FLOAT", "DOUBLE", "NUMERIC", "DECIMAL")
    if any(t in l for t in num) and any(t in r for t in num):
        return 1.0
    if l == r:
        return 1.0
    if "TEXT" in l and "TEXT" in r:
        return 0.9
    return 0.4


def _table_count(conn: sqlite3.Connection, table: str) -> int:
    return int(conn.execute(f'SELECT COUNT(*) FROM "{table}"').fetchone()[0] or 0)


def _candidate_uccs(
    conn: sqlite3.Connection,
    table: str,
    columns: List[str],
    max_arity: int = 2,
    *,
    sample_limit: Optional[int] = None,
) -> List[PKCandidate]:
    if sample_limit is None or sample_limit <= 0:
        n = _table_count(conn, table)
        sample_from = f'"{table}"'
    else:
        # Heuristic profiling: use the first N rows as sample.
        n = int(
            conn.execute(
                f'SELECT COUNT(*) FROM (SELECT * FROM "{table}" LIMIT {int(sample_limit)})'
            ).fetchone()[0]
            or 0
        )
        sample_from = f'(SELECT * FROM "{table}" LIMIT {int(sample_limit)})'
    if n <= 0:
        return []

    cands: List[PKCandidate] = []
    for arity in range(1, min(max_arity, len(columns)) + 1):
        for cols in itertools.combinations(columns, arity):
            cols_sql = ", ".join(f'"{c}"' for c in cols)
            null_pred = " OR ".join(f'"{c}" IS NULL' for c in cols)
            nn = int(
                conn.execute(
                    f'SELECT COUNT(*) FROM {sample_from} WHERE NOT ({null_pred})'
                ).fetchone()[0]
                or 0
            )
            if nn <= 0:
                continue
            nd = int(
                conn.execute(
                    f'SELECT COUNT(*) FROM (SELECT DISTINCT {cols_sql} FROM {sample_from} WHERE NOT ({null_pred}))'
                ).fetchone()[0]
                or 0
            )
            uniqueness = float(nd) / float(nn) if nn else 0.0
            non_null_ratio = float(nn) / float(n)
            if uniqueness < 0.999:
                continue
            nscore = _name_score(cols)
            compact_penalty = 0.08 * (len(cols) - 1)
            score = 0.55 * uniqueness + 0.35 * non_null_ratio + 0.20 * nscore - compact_penalty
            cands.append(
                PKCandidate(
                    table=table,
                    columns=tuple(cols),
                    uniqueness=uniqueness,
                    non_null_ratio=non_null_ratio,
                    name_score=nscore,
                    score=score,
                )
            )
    cands.sort(key=lambda x: (-x.score, len(x.columns), x.columns))
    return cands


def _pick_pk_for_table(cands: List[PKCandidate]) -> Optional[PKCandidate]:
    if not cands:
        return None
    return cands[0]


def _inclusion_ratio_unary(
    conn: sqlite3.Connection,
    from_table: str,
    from_col: str,
    to_table: str,
    to_col: str,
) -> float:
    q = (
        f'SELECT COUNT(*) FROM ('
        f'  SELECT DISTINCT f."{from_col}" AS v'
        f'  FROM "{from_table}" f'
        f'  WHERE f."{from_col}" IS NOT NULL'
        f'    AND NOT EXISTS ('
        f'      SELECT 1 FROM "{to_table}" t'
        f'      WHERE t."{to_col}" = f."{from_col}"'
        f'    )'
        f')'
    )
    missing = int(conn.execute(q).fetchone()[0] or 0)
    domain = int(
        conn.execute(
            f'SELECT COUNT(*) FROM (SELECT DISTINCT "{from_col}" FROM "{from_table}" WHERE "{from_col}" IS NOT NULL)'
        ).fetchone()[0]
        or 0
    )
    if domain <= 0:
        return 0.0
    return max(0.0, 1.0 - (float(missing) / float(domain)))


def _distinct_values(
    conn: sqlite3.Connection,
    table: str,
    col: str,
    *,
    sample_limit: Optional[int] = None,
) -> List[Any]:
    if sample_limit is None or sample_limit <= 0:
        sql = f'SELECT DISTINCT "{col}" FROM "{table}" WHERE "{col}" IS NOT NULL'
    else:
        sql = (
            f'SELECT DISTINCT "{col}" FROM (SELECT * FROM "{table}" LIMIT {int(sample_limit)}) '
            f'WHERE "{col}" IS NOT NULL'
        )
    rows = conn.execute(sql).fetchall()
    return [r[0] for r in rows]


def _inclusion_ratio_unary_fast(
    conn: sqlite3.Connection,
    *,
    from_table: str,
    from_col: str,
    rhs_values: Optional[set],
    to_table: str,
    to_col: str,
    sample_limit: Optional[int],
) -> float:
    # If RHS distinct values are small enough we can do a fast in-memory membership check.
    if rhs_values is not None:
        domain_vals = _distinct_values(
            conn, from_table, from_col, sample_limit=sample_limit
        )
        if not domain_vals:
            return 0.0
        missing = sum(1 for v in domain_vals if v not in rhs_values)
        return max(0.0, 1.0 - (float(missing) / float(len(domain_vals))))

    # Fallback: SQL inclusion computed over a sample to avoid long full-table NOT EXISTS.
    if sample_limit is None or sample_limit <= 0:
        return _inclusion_ratio_unary(conn, from_table, from_col, to_table, to_col)
    # Compute missing domain values from the sampled DISTINCT set.
    q = (
        f'SELECT COUNT(*) FROM ('
        f'  SELECT DISTINCT f."{from_col}" AS v'
        f'  FROM (SELECT * FROM "{from_table}" LIMIT {int(sample_limit)}) f'
        f'  WHERE f."{from_col}" IS NOT NULL'
        f') domain'
        f'WHERE NOT EXISTS ('
        f'  SELECT 1 FROM "{to_table}" t WHERE t."{to_col}" = domain.v'
        f')'
    )
    missing = int(conn.execute(q).fetchone()[0] or 0)
    domain_count = int(
        conn.execute(
            f'SELECT COUNT(*) FROM ('
            f'  SELECT DISTINCT f."{from_col}" AS v'
            f'  FROM (SELECT * FROM "{from_table}" LIMIT {int(sample_limit)}) f'
            f'  WHERE f."{from_col}" IS NOT NULL'
            f')'
        ).fetchone()[0]
        or 0
    )
    if domain_count <= 0:
        return 0.0
    return max(0.0, 1.0 - (float(missing) / float(domain_count)))


def infer_keys_hopf_style(
    db_path: str,
    schema_graph: SchemaGraph,
    *,
    max_pk_arity: int = 2,
    min_fk_inclusion: float = 0.98,
    profile_max_rows: int = 20000,
    max_distinct_set_size: int = 200000,
    max_fk_lhs_cols_per_table: int = 14,
    max_pk_candidates_per_table: int = 6,
) -> Tuple[Dict[str, List[str]], List[ForeignKey], Dict[str, Any]]:
    """
    Infer PK/FK for key-empty schemas using HoPF-style scoring and pruning.
    """
    conn = sqlite3.connect(db_path)
    try:
        tables = list(schema_graph.tables.keys())
        print(
            f"    [HoPF] Profiling {len(tables)} tables (sample_limit={profile_max_rows})...",
            flush=True,
        )
        pk_candidates_by_table: Dict[str, List[PKCandidate]] = {}
        chosen_pk_map: Dict[str, List[str]] = {}
        chosen_pk_details: Dict[str, Any] = {}

        # Unary-first PK inference for speed:
        # If a high-uniqueness unary candidate exists, avoid expensive composite enumeration.
        for ti, t in enumerate(tables):
            cols = [c.name for c in schema_graph.tables[t].columns]
            if not cols:
                pk_candidates_by_table[t] = []
                chosen_pk_map[t] = []
                chosen_pk_details[t] = {"columns": [], "score": 0.0}
                continue

            if ti % 5 == 0:
                print(
                    f"    [HoPF] PK profiling table {ti+1}/{len(tables)}: {t}",
                    flush=True,
                )

            unary_cands = _candidate_uccs(
                conn,
                t,
                cols,
                max_arity=1,
                sample_limit=profile_max_rows,
            )
            unary_cands.sort(key=lambda x: -x.score)
            unary_best = _pick_pk_for_table(unary_cands)
            if unary_best and unary_best.uniqueness >= 0.999:
                chosen = unary_best
                cands = unary_cands[:max_pk_candidates_per_table]
            else:
                # Only try composite keys when unary doesn't look like a key.
                composite_cands = _candidate_uccs(
                    conn,
                    t,
                    cols,
                    max_arity=min(2, max_pk_arity),
                    sample_limit=profile_max_rows,
                )
                composite_cands.sort(key=lambda x: -x.score)
                cands = composite_cands[:max_pk_candidates_per_table]
                chosen = _pick_pk_for_table(cands)

            pk_candidates_by_table[t] = cands
            if chosen:
                chosen_pk_map[t] = list(chosen.columns)
                chosen_pk_details[t] = {
                    "columns": list(chosen.columns),
                    "score": round(chosen.score, 6),
                    "uniqueness": round(chosen.uniqueness, 6),
                    "non_null_ratio": round(chosen.non_null_ratio, 6),
                    "name_score": round(chosen.name_score, 6),
                }
            else:
                chosen_pk_map[t] = []
                chosen_pk_details[t] = {"columns": [], "score": 0.0}

        # FK candidate generation:
        # Cache RHS distinct values for unary PK columns when it is not huge.
        rhs_values_cache: Dict[Tuple[str, str], Optional[set]] = {}
        rhs_cache_hits = 0
        rhs_cache_misses = 0
        for rhs_t in tables:
            rhs_pk = chosen_pk_map.get(rhs_t) or []
            if len(rhs_pk) != 1:
                continue
            rhs_col = rhs_pk[0]
            # Approximate distinct count using sample_limit; avoids expensive COUNT DISTINCT on full tables.
            distinct_count = int(
                conn.execute(
                    f'SELECT COUNT(*) FROM ('
                    f'  SELECT DISTINCT "{rhs_col}" AS v'
                    f'  FROM (SELECT * FROM "{rhs_t}" LIMIT {int(profile_max_rows)})'
                    f'  WHERE "{rhs_col}" IS NOT NULL'
                    f')'
                ).fetchone()[0]
                or 0
            )
            if distinct_count <= max_distinct_set_size and distinct_count > 0:
                rhs_vals = _distinct_values(
                    conn, rhs_t, rhs_col, sample_limit=profile_max_rows
                )
                rhs_values_cache[(rhs_t, rhs_col)] = set(rhs_vals)
                rhs_cache_hits += 1
            else:
                rhs_values_cache[(rhs_t, rhs_col)] = None
                rhs_cache_misses += 1

        print(
            f"    [HoPF] RHS distinct-cache computed: hits={rhs_cache_hits} misses={rhs_cache_misses}",
            flush=True,
        )

        fk_candidates: List[FKCandidate] = []
        for li, lhs_t in enumerate(tables):
            if li % 5 == 0:
                print(
                    f"    [HoPF] FK profiling from-table {li+1}/{len(tables)}: {lhs_t}",
                    flush=True,
                )

            lhs_cols = [c.name for c in schema_graph.tables[lhs_t].columns]

            # Reduce work: only consider columns with decent "id-like" naming.
            lhs_col_scores = []
            for c in lhs_cols:
                nscore = _name_score([c])
                if not c:
                    continue
                if nscore < 0.15 and not c.lower().endswith("_id"):
                    continue
                lhs_col_scores.append((nscore, c))
            lhs_col_scores.sort(reverse=True, key=lambda x: x[0])
            lhs_cols_filtered = [c for _s, c in lhs_col_scores[:max_fk_lhs_cols_per_table]]
            if not lhs_cols_filtered:
                continue

            for rhs_t in tables:
                if lhs_t == rhs_t:
                    continue
                rhs_pk = chosen_pk_map.get(rhs_t) or []
                if len(rhs_pk) != 1:
                    continue
                rhs_col = rhs_pk[0]
                rhs_type = _column_type(conn, rhs_t, rhs_col)
                rhs_values = rhs_values_cache.get((rhs_t, rhs_col))

                for lhs_col in lhs_cols_filtered:
                    if lhs_col == rhs_col and lhs_t == rhs_t:
                        continue
                    lhs_type = _column_type(conn, lhs_t, lhs_col)
                    tscore = _is_type_compatible(lhs_type, rhs_type)
                    if tscore < 0.4:
                        continue

                    inclusion = _inclusion_ratio_unary_fast(
                        conn,
                        from_table=lhs_t,
                        from_col=lhs_col,
                        rhs_values=rhs_values,
                        to_table=rhs_t,
                        to_col=rhs_col,
                        sample_limit=profile_max_rows,
                    )
                    if inclusion < min_fk_inclusion:
                        continue

                    nscore = 0.0
                    if lhs_col.lower().endswith("_id") and rhs_col.lower().endswith("_id"):
                        nscore += 0.3
                    if rhs_t.lower() in lhs_col.lower():
                        nscore += 0.25
                    score = 0.7 * inclusion + 0.2 * tscore + 0.1 * min(1.0, nscore)
                    fk_candidates.append(
                        FKCandidate(
                            from_table=lhs_t,
                            from_column=lhs_col,
                            to_table=rhs_t,
                            to_column=rhs_col,
                            inclusion_ratio=inclusion,
                            type_score=tscore,
                            name_score=min(1.0, nscore),
                            score=score,
                        )
                    )

        # Holistic pruning: keep strongest incoming relationship per (from_table, from_column)
        fk_candidates.sort(key=lambda x: (-x.score, x.from_table, x.from_column, x.to_table))
        used_lhs: set = set()
        chosen_fks: List[ForeignKey] = []
        chosen_fk_audit: List[Dict[str, Any]] = []
        for cand in fk_candidates:
            lhs_key = (cand.from_table, cand.from_column)
            if lhs_key in used_lhs:
                continue
            used_lhs.add(lhs_key)
            chosen_fks.append(
                ForeignKey(
                    from_table=cand.from_table,
                    from_column=cand.from_column,
                    to_table=cand.to_table,
                    to_column=cand.to_column,
                    origin="inferred",
                )
            )
            chosen_fk_audit.append(
                {
                    "from_table": cand.from_table,
                    "from_column": cand.from_column,
                    "to_table": cand.to_table,
                    "to_column": cand.to_column,
                    "score": round(cand.score, 6),
                    "inclusion_ratio": round(cand.inclusion_ratio, 6),
                    "type_score": round(cand.type_score, 6),
                    "name_score": round(cand.name_score, 6),
                }
            )

        audit = {
            "method": "hopf_style_heuristic",
            "desbordante_available": bool(_HAS_DESBORDANTE),
            "max_pk_arity": int(max_pk_arity),
            "min_fk_inclusion": float(min_fk_inclusion),
            "profile_max_rows": int(profile_max_rows),
            "max_distinct_set_size": int(max_distinct_set_size),
            "rhs_cache_hits": rhs_cache_hits,
            "rhs_cache_misses": rhs_cache_misses,
            "pk_candidates_per_table": {
                t: [
                    {
                        "columns": list(c.columns),
                        "score": round(c.score, 6),
                        "uniqueness": round(c.uniqueness, 6),
                        "non_null_ratio": round(c.non_null_ratio, 6),
                    }
                    for c in cands[:10]
                ]
                for t, cands in pk_candidates_by_table.items()
            },
            "chosen_primary_keys": chosen_pk_details,
            "fk_candidates_count": len(fk_candidates),
            "chosen_foreign_keys": chosen_fk_audit,
        }
        return chosen_pk_map, chosen_fks, audit
    finally:
        conn.close()

