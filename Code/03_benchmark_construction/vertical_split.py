from __future__ import annotations

import json
import math
import os
import random
import re
import warnings
from typing import Any, Dict, List, Optional, Set, Tuple

import numpy as np

# Suppress sklearn kmeans lloyd convergence warnings on tiny data (when sklearn is loaded)
warnings.filterwarnings("ignore", category=UserWarning, module="sklearn")

# Lazy-loaded SentenceTransformer models (keyed by HuggingFace id or local path)
_ST_MODEL_CACHE: Dict[str, Any] = {}


def _tokens(name: str) -> List[str]:
    s = re.sub(r"([a-z])([A-Z])", r"\1_\2", name)
    return [t for t in s.lower().split("_") if t]


def _common_prefix_tokens(names: List[str]) -> List[str]:
    if not names:
        return []
    tok_lists = [_tokens(n) for n in names]
    m = min(len(t) for t in tok_lists)
    out: List[str] = []
    for i in range(m):
        w = tok_lists[0][i]
        if all(len(tl) > i and tl[i] == w for tl in tok_lists):
            out.append(w)
        else:
            break
    return out


def _sanitize_suffix(s: str, rng: random.Random) -> str:
    s = re.sub(r"[^a-z0-9_]+", "_", s.lower()).strip("_")
    s = re.sub(r"_+", "_", s)
    if not s or len(s) < 2:
        return f"frag_{rng.randint(1, 99999)}"
    return s[:40]


def load_column_enrichment_json(path: str) -> Optional[Dict[str, Any]]:
    """Load full column_semantic_enrichment.json; return None if missing/unreadable."""
    if not path or not os.path.isfile(path):
        return None
    try:
        with open(path, "r", encoding="utf-8") as f:
            return json.load(f)
    except (OSError, json.JSONDecodeError):
        return None


def _column_semantic_text(
    table_name: str,
    col_name: str,
    enrichment: Optional[Dict[str, Any]],
) -> str:
    """Build a single string for embedding / TF-IDF from enrichment + column name."""
    parts: List[str] = [col_name.replace("_", " ")]
    if not enrichment:
        return " ".join(parts)
    tables = enrichment.get("tables") or {}
    tnode = tables.get(table_name)
    if not isinstance(tnode, dict):
        return " ".join(parts)
    cols = tnode.get("columns") or {}
    ent = cols.get(col_name)
    if not isinstance(ent, dict):
        return " ".join(parts)
    alts = ent.get("alternative_names") or []
    if isinstance(alts, list):
        for a in alts:
            if a:
                parts.append(str(a).strip())
    desc = ent.get("description")
    if desc:
        parts.append(str(desc).strip())
    return " ".join(parts) if len(parts) > 1 else " ".join(parts)


def _merge_undersized_clusters(
    clusters: List[List[int]],
    X: np.ndarray,
    min_size: int,
) -> List[List[int]]:
    """Merge smallest cluster into nearest cluster by centroid distance until all >= min_size."""
    if min_size <= 0:
        return clusters
    clusters = [list(c) for c in clusters if c]
    while clusters:
        sizes = [len(c) for c in clusters]
        if all(s >= min_size for s in sizes):
            break
        if len(clusters) < 2:
            break
        # index of smallest cluster
        si = min(range(len(clusters)), key=lambda i: (sizes[i], i))
        if sizes[si] >= min_size:
            break
        small = clusters.pop(si)
        if not clusters:
            clusters = [small]
            break
        centroids = []
        for c in clusters:
            centroids.append(X[c].mean(axis=0))
        small_cent = X[small].mean(axis=0)
        dists = [float(np.linalg.norm(small_cent - cc)) for cc in centroids]
        ti = int(np.argmin(dists))
        clusters[ti] = sorted(set(clusters[ti] + small))
    return clusters


def _cluster_score(X: np.ndarray, labels: np.ndarray, k: int) -> float:
    """Higher is better. Prefer silhouette when defined, else Calinski-Harabasz."""
    from sklearn.metrics import calinski_harabasz_score, silhouette_score

    n = X.shape[0]
    if k < 2 or n < k + 1:
        return -1.0
    try:
        if len(set(labels)) < 2:
            return -1.0
        sil = silhouette_score(X, labels, metric="euclidean")
        if not math.isnan(sil):
            return float(sil)
    except ValueError:
        pass
    try:
        ch = calinski_harabasz_score(X, labels)
        return float(ch) / (n * k + 1.0)
    except ValueError:
        return -1.0


def _effective_pk_width(pk_columns: Optional[List[str]]) -> int:
    """If PK unknown (tests), assume one key column for min-fragment math."""
    if pk_columns is None:
        return 1
    return max(1, len(pk_columns))


def _tfidf_matrix(texts: List[str]) -> np.ndarray:
    from sklearn.feature_extraction.text import TfidfVectorizer

    vec = TfidfVectorizer(max_features=256, ngram_range=(1, 2), min_df=1)
    try:
        return vec.fit_transform(texts).toarray()
    except ValueError:
        return np.zeros((len(texts), 1), dtype=float)


def _column_feature_matrix(
    texts: List[str],
    embedding_model: str,
    meta: Dict[str, Any],
) -> np.ndarray:
    """
    Dense features for KMeans and border overlap: sentence-transformers first, else TF-IDF.
    Sets meta['embedding_backend'] and optionally meta['embedding_model'] / fallback reason.
    """
    if not embedding_model or not str(embedding_model).strip():
        meta["embedding_backend"] = "tfidf"
        meta["embedding_fallback_reason"] = "empty_embedding_model"
        return _tfidf_matrix(texts)

    try:
        from sentence_transformers import SentenceTransformer
    except ImportError as e:
        meta["embedding_backend"] = "tfidf"
        meta["embedding_fallback_reason"] = f"sentence_transformers_import: {e}"
        return _tfidf_matrix(texts)

    model_name = str(embedding_model).strip()
    try:
        if model_name not in _ST_MODEL_CACHE:
            _ST_MODEL_CACHE[model_name] = SentenceTransformer(model_name)
        st_model = _ST_MODEL_CACHE[model_name]
        X = st_model.encode(
            texts,
            normalize_embeddings=True,
            show_progress_bar=False,
        )
        X = np.asarray(X, dtype=np.float32)
        meta["embedding_backend"] = "sentence_transformers"
        meta["embedding_model"] = model_name
        return X
    except Exception as e:
        meta["embedding_backend"] = "tfidf"
        meta["embedding_fallback_reason"] = str(e)
        return _tfidf_matrix(texts)


def plan_vertical_column_groups_semantic(
    non_pk_columns: List[str],
    table_name: str,
    pk_columns: Optional[List[str]],
    enrichment: Optional[Dict[str, Any]],
    rng: random.Random,
    max_fragments: int,
    embedding_model: str = "BAAI/bge-small-en-v1.5",
) -> Tuple[Optional[List[List[str]]], Dict[str, Any], Optional[np.ndarray]]:
    """
    Cluster non-PK columns with sentence embeddings (or TF-IDF fallback) + KMeans;
    choose k in {2,3,4,5} by score.

    Returns (None, meta, None) if no valid split before features; (None, meta, X) if
    features built but clustering failed; else (groups, meta, X) for overlap step.
    """
    try:
        from sklearn.cluster import KMeans
    except ImportError as e:
        raise ImportError(
            "Vertical semantic clustering requires scikit-learn. "
            "Install with: pip install scikit-learn"
        ) from e

    cols = list(non_pk_columns)
    n = len(cols)
    pk_w = _effective_pk_width(pk_columns)
    min_np = max(0, 4 - pk_w)
    meta: Dict[str, Any] = {
        "table_name": table_name,
        "primary_path": "semantic_kmeans",
        "max_fragments_cap": max_fragments,
        "num_non_pk_columns": n,
        "min_non_pk_per_fragment": min_np,
        "pk_width": pk_w,
    }

    if n < 2:
        meta["skip_reason"] = "fewer_than_2_non_pk_columns"
        return None, meta, None

    texts = [_column_semantic_text(table_name, c, enrichment) for c in cols]
    X = _column_feature_matrix(texts, embedding_model, meta)

    rng_seed = rng.randint(0, 2**31 - 1)
    meta["kmeans_random_state"] = rng_seed
    max_k = min(max_fragments, 5, n)
    candidate_ks = [k for k in (2, 3, 4, 5) if k <= max_k and k <= n]

    # Feasibility: need enough columns to give each cluster at least min_np (rough lower bound)
    candidate_ks = [k for k in candidate_ks if n >= k * min_np or min_np == 0]

    if not candidate_ks:
        meta["skip_reason"] = "no_feasible_k_for_min_fragment_width"
        return None, meta, X

    def run_kmeans_pick(X_run: np.ndarray) -> Tuple[
        Optional[List[List[str]]],
        Dict[int, float],
        int,
        float,
    ]:
        bg: Optional[List[List[str]]] = None
        bscore = -float("inf")
        bk = -1
        sbk: Dict[int, float] = {}
        for k in candidate_ks:
            km = KMeans(
                n_clusters=k,
                random_state=rng_seed,
                n_init=10,
                max_iter=100,
            )
            with warnings.catch_warnings():
                warnings.simplefilter("ignore")
                labels = km.fit_predict(X_run)
            buckets: Dict[int, List[int]] = {}
            for i, lab in enumerate(labels):
                buckets.setdefault(int(lab), []).append(i)
            clusters_idx = [sorted(buckets[j]) for j in sorted(buckets.keys())]

            clusters_idx = _merge_undersized_clusters(clusters_idx, X_run, min_np)
            if len(clusters_idx) < 2:
                continue
            if any(len(c) < min_np for c in clusters_idx):
                continue

            merged_labels = np.zeros(n, dtype=int)
            for cid, idxs in enumerate(clusters_idx):
                for i in idxs:
                    merged_labels[i] = cid
            sc = _cluster_score(X_run, merged_labels, len(clusters_idx))
            sbk[k] = sc
            if sc > bscore:
                bscore = sc
                bk = len(clusters_idx)
                bg = [[cols[i] for i in idxs] for idxs in clusters_idx]
                bg = [sorted(g) for g in bg]
                bg.sort(key=lambda g: (g[0],))
        return bg, sbk, bk, bscore

    best_groups, scores_by_k, best_k, best_score = run_kmeans_pick(X)

    # ST embeddings can be too tight for near-duplicate column text; only k=2 may be
    # feasible (min fragment width), and KMeans+merge can collapse to one cluster.
    if (
        (not best_groups or len(best_groups) < 2)
        and meta.get("embedding_backend") == "sentence_transformers"
    ):
        meta["clustering_tfidf_retry"] = True
        X = _tfidf_matrix(texts)
        meta["clustering_feature_matrix"] = "tfidf_after_st_no_valid_layout"
        best_groups, scores_by_k, best_k, best_score = run_kmeans_pick(X)

    meta["scores_by_k"] = scores_by_k
    meta["chosen_k"] = best_k
    meta["best_metric_score"] = best_score

    if not best_groups or len(best_groups) < 2:
        meta["skip_reason"] = "no_valid_clustering_after_constraints"
        return None, meta, X

    meta["num_final_clusters"] = len(best_groups)
    meta["column_clusters"] = [list(g) for g in best_groups]
    return best_groups, meta, X


def _apply_border_overlap(
    groups: List[List[str]],
    col_index: Dict[str, int],
    X: np.ndarray,
    labels: np.ndarray,
    centroids: np.ndarray,
    overlap_fraction: float,
    _rng: random.Random,
) -> Tuple[List[List[str]], List[Dict[str, Any]]]:
    """
    Duplicate border columns into one nearest other fragment each.
    groups: partition lists; returns new lists (may share column names across lists).
    """
    n = X.shape[0]
    if n == 0 or overlap_fraction <= 0 or len(groups) < 2:
        return [list(g) for g in groups], []

    k = len(groups)
    col_to_g: Dict[str, int] = {}
    for gi, g in enumerate(groups):
        for c in g:
            col_to_g[c] = gi

    scores: List[Tuple[float, str]] = []
    for col, i in col_index.items():
        own = int(labels[i])
        if own < 0 or own >= centroids.shape[0]:
            continue
        d_own = float(np.linalg.norm(X[i] - centroids[own]))
        others = [
            float(np.linalg.norm(X[i] - centroids[j]))
            for j in range(centroids.shape[0])
            if j != own
        ]
        if not others:
            continue
        min_o = min(others)
        ratio = d_own / max(min_o, 1e-12)
        scores.append((ratio, col))

    scores.sort(key=lambda x: -x[0])
    take = max(1, int(math.ceil(n * overlap_fraction))) if n else 0
    take = min(take, len(scores))
    border_cols = [c for _r, c in scores[:take]]

    overlap_records: List[Dict[str, Any]] = []
    new_groups = [list(g) for g in groups]

    for col in border_cols:
        i = col_index.get(col)
        if i is None:
            continue
        own = int(labels[i])
        dists = [
            (j, float(np.linalg.norm(X[i] - centroids[j])))
            for j in range(centroids.shape[0])
            if j != own
        ]
        if not dists:
            continue
        target_g = int(min(dists, key=lambda t: t[1])[0])
        if target_g >= len(new_groups):
            continue
        source_g = col_to_g.get(col, own)
        if target_g == source_g:
            continue
        if col not in new_groups[target_g]:
            new_groups[target_g].append(col)
            new_groups[target_g].sort()
            overlap_records.append(
                {
                    "column": col,
                    "primary_fragment_index": source_g,
                    "also_in_fragment_index": target_g,
                }
            )

    return new_groups, overlap_records


def plan_vertical_column_groups(
    non_pk_columns: List[str],
    table_name: str,
    rng: random.Random,
    max_fragments: int,
    pk_columns: Optional[List[str]] = None,
    enrichment: Optional[Dict[str, Any]] = None,
    overlap_fraction: float = 0.15,
    embedding_model: str = "BAAI/bge-small-en-v1.5",
) -> Tuple[Optional[List[List[str]]], Dict[str, Any]]:
    """
    Semantic clustering entry point (replaces legacy union-find/LCP).

    Returns (None, meta) if splitting is not possible; else (groups_with_overlap, meta).
    """
    base_groups, meta, X = plan_vertical_column_groups_semantic(
        non_pk_columns,
        table_name,
        pk_columns,
        enrichment,
        rng,
        max_fragments,
        embedding_model=embedding_model,
    )
    if base_groups is None:
        return None, meta

    cols = list(non_pk_columns)
    if X is None:
        texts = [_column_semantic_text(table_name, c, enrichment) for c in cols]
        X = _tfidf_matrix(texts)

    col_index = {c: i for i, c in enumerate(cols)}
    # Labels for final base_groups assignment
    lab = np.zeros(len(cols), dtype=int)
    for gi, g in enumerate(base_groups):
        for c in g:
            if c in col_index:
                lab[col_index[c]] = gi

    k = len(base_groups)
    centroids = np.array([X[lab == j].mean(axis=0) for j in range(k)])
    if centroids.shape[0] < 2 or centroids.shape[1] == 0:
        meta["overlap_columns"] = []
        meta["overlap_fraction_applied"] = overlap_fraction
        return base_groups, meta

    final_groups, overlap_records = _apply_border_overlap(
        base_groups,
        col_index,
        X,
        lab,
        centroids,
        overlap_fraction,
        rng,
    )
    meta["overlap_fraction_applied"] = overlap_fraction
    meta["overlap_columns"] = overlap_records
    meta["column_clusters_after_overlap"] = [list(g) for g in final_groups]
    return final_groups, meta


def suffix_for_column_group(
    group_cols: List[str],
    table_name: str,
    rng: random.Random,
    index: int,
) -> str:
    """Derive a short meaningful suffix for a vertical fragment."""
    unique_cols = sorted(set(group_cols))
    if not unique_cols:
        return f"frag_{index}"
    cp = _common_prefix_tokens(unique_cols)
    if cp:
        raw = "_".join(cp)
        ttoks = _tokens(table_name)
        if len(ttoks) >= 1 and cp[: len(ttoks)] == ttoks:
            raw = "_".join(cp[len(ttoks) :]) or raw
    else:
        raw = unique_cols[0][:24]
    suf = _sanitize_suffix(raw, rng)
    if suf in ("pk", "id", "key"):
        suf = f"{suf}_{index}"
    return suf


def build_vertical_split_fragments(
    table_name: str,
    pk_columns: List[str],
    non_pk_columns: List[str],
    rng: random.Random,
    max_fragments: int,
    enrichment: Optional[Dict[str, Any]] = None,
    overlap_fraction: float = 0.15,
    embedding_model: str = "BAAI/bge-small-en-v1.5",
) -> Optional[Tuple[List[Tuple[str, List[str]]], Dict[str, Any]]]:
    """
    Returns None if vertical split is not possible for this table.

    Otherwise returns (fragments, clustering_record) where fragments are
    [(suffix, non_pk_cols_in_fragment), ...]; non_pk lists may repeat column names
    across fragments when overlap is applied.
    """
    planned, cluster_meta = plan_vertical_column_groups(
        non_pk_columns,
        table_name,
        rng,
        max_fragments,
        pk_columns=pk_columns,
        enrichment=enrichment,
        overlap_fraction=overlap_fraction,
        embedding_model=embedding_model,
    )
    if planned is None:
        return None

    out: List[Tuple[str, List[str]]] = []
    used: Set[str] = set()
    for i, g in enumerate(planned):
        suf = suffix_for_column_group(g, table_name, rng, i)
        base = suf
        n = 1
        while suf in used:
            n += 1
            suf = f"{base}_{n}"
        used.add(suf)
        out.append((suf, list(g)))

    cluster_meta = dict(cluster_meta)
    cluster_meta["pk_columns"] = list(pk_columns)
    cluster_meta["fragments"] = [
        {"suffix": suf, "non_pk_columns": list(cols)} for suf, cols in out
    ]
    return out, cluster_meta
