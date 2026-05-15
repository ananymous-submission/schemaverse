from __future__ import annotations

import math
import random
from collections import defaultdict
from dataclasses import dataclass
from typing import Any, Dict, List, Optional, Set, Tuple

from schema_parser import SchemaGraph
from fragment_workload import (
    NEED_ALL,
    collect_needed_original_columns,
    extract_table_refs,
)


@dataclass
class FragmentSnap:
    """One physical local table that maps to a logical source_table."""

    local_table: str
    source_table: str
    local_name: str
    is_vertical: bool
    is_row_partition: bool
    projected_orig_cols: Set[str]


def _orig_cols_for_transform(tr) -> Set[str]:
    cols = set(tr.column_map.values())
    if tr.projected_columns:
        cols |= set(tr.projected_columns)
    return cols


def build_fixed_snapshot(locals_list) -> Dict[str, Any]:
    """Read-only map: local_table -> FragmentSnap; logical -> list of local_table."""
    fragment_by_lt: Dict[str, FragmentSnap] = {}
    logical_fragments: Dict[str, List[str]] = defaultdict(list)
    for loc in locals_list:
        for lt, tr in loc.tables.items():
            snap = FragmentSnap(
                local_table=lt,
                source_table=tr.source_table,
                local_name=loc.local_name,
                is_vertical=bool(tr.is_vertical_split_fragment),
                is_row_partition=bool(tr.is_row_partition),
                projected_orig_cols=_orig_cols_for_transform(tr),
            )
            fragment_by_lt[lt] = snap
            logical_fragments[tr.source_table].append(lt)
    for k in logical_fragments:
        logical_fragments[k] = sorted(logical_fragments[k])
    return {
        "fragment_by_lt": fragment_by_lt,
        "logical_fragments": dict(logical_fragments),
    }


def _row_partition_physical_pairs(locals_list, orig_table: str) -> List[Tuple[str, str]]:
    """Undirected row-partition pairs (local_table, partner) for one logical source_table."""
    seen: Set[Tuple[str, str]] = set()
    out: List[Tuple[str, str]] = []
    for loc in locals_list:
        for lt, tr in loc.tables.items():
            if tr.source_table != orig_table or not tr.is_row_partition:
                continue
            buddy = tr.row_partition_partner
            if not buddy:
                continue
            a, b = sorted([lt, buddy])
            if (a, b) not in seen:
                seen.add((a, b))
                out.append((a, b))
    return out


def logical_home_local(orig_table: str, groups: List[Set[str]]) -> str:
    for i, g in enumerate(groups):
        if orig_table in g:
            return f"local_{i + 1}"
    return ""


def is_boundary_table(orig_table: str, schema_graph: SchemaGraph, groups: List[Set[str]]) -> bool:
    """True if some FK touches another logical table assigned to a different local."""
    home = logical_home_local(orig_table, groups)
    if not home:
        return False
    for fk in schema_graph.foreign_keys:
        if fk.from_table == orig_table:
            other = fk.to_table
            if logical_home_local(other, groups) != home:
                return True
        if fk.to_table == orig_table:
            other = fk.from_table
            if logical_home_local(other, groups) != home:
                return True
    return False


def _touch_basis_vertical(
    orig_table: str,
    local_table: str,
    pk_cols: Set[str],
    snapshot: Dict[str, Any],
) -> Set[str]:
    snap = snapshot["fragment_by_lt"][local_table]
    cols = set(snap.projected_orig_cols)
    non_pk = cols - pk_cols
    return non_pk if non_pk else cols


def _touch_basis_row(local_table: str, snapshot: Dict[str, Any]) -> Set[str]:
    return set(snapshot["fragment_by_lt"][local_table].projected_orig_cols)


def _fragments_touched_for_table(
    orig_table: str,
    needed: Dict[str, Set[str]],
    snapshot: Dict[str, Any],
    schema_graph: SchemaGraph,
    pk_by_table: Dict[str, Set[str]],
) -> Set[str]:
    """Local fragment table names for orig_table touched by this query."""
    nset = needed.get(orig_table, {NEED_ALL})
    pk = pk_by_table.get(orig_table, set())
    touched: Set[str] = set()
    for lt in snapshot["logical_fragments"].get(orig_table, []):
        snap = snapshot["fragment_by_lt"][lt]
        if snap.is_vertical:
            basis = _touch_basis_vertical(orig_table, lt, pk, snapshot)
        else:
            basis = _touch_basis_row(lt, snapshot)
        if NEED_ALL in nset or (nset & basis):
            touched.add(lt)
    return touched


def build_cross_local_fragment_pair_weights(
    queries: List[str],
    known_tables: Set[str],
    schema_graph: SchemaGraph,
    snapshot: Dict[str, Any],
    groups: List[Set[str]],
) -> Tuple[Dict[Tuple[str, str], int], Dict[Tuple[str, str], Set[str]]]:
    """
    Undirected pair weights for relocation scoring.

    For each workload query that references fragments in **at least two locals**,
    we increment, for every **unordered pair of fragments from two different
    original tables** (f1, f2) that the query touches, pair_counts[(f1,f2)].

    So the count is **co-occurrences of that fragment pair in cross-local queries**,
    not “queries that would become single-local if we co-locate f1 with f2”
    (those queries may also need a third local, another fragment of the same table, etc.).
    """
    pk_by_table = {
        t: set(schema_graph.tables[t].primary_keys or []) for t in schema_graph.tables
    }
    pair_counts: Dict[Tuple[str, str], int] = defaultdict(int)
    pair_queries: Dict[Tuple[str, str], Set[str]] = defaultdict(set)
    q_idx = 0
    for sql in queries:
        refs = extract_table_refs(sql, known_tables)
        if not refs:
            continue
        needed = collect_needed_original_columns(sql, refs, schema_graph)
        tables_in_q = {t[0] for t in refs}
        per_orig: Dict[str, Set[str]] = {}
        for ot in tables_in_q:
            per_orig[ot] = _fragments_touched_for_table(ot, needed, snapshot, schema_graph, pk_by_table)
        locals_in_q: Set[str] = set()
        for lt_sets in per_orig.values():
            for lt in lt_sets:
                locals_in_q.add(snapshot["fragment_by_lt"][lt].local_name)
        if len(locals_in_q) < 2:
            q_idx += 1
            continue
        frags = [(ot, lt) for ot in sorted(per_orig) for lt in sorted(per_orig[ot])]
        for i, (o1, f1) in enumerate(frags):
            for o2, f2 in frags[i + 1 :]:
                if o1 == o2:
                    continue
                l1 = snapshot["fragment_by_lt"][f1].local_name
                l2 = snapshot["fragment_by_lt"][f2].local_name
                if l1 == l2:
                    continue
                a, b = (f1, f2) if f1 < f2 else (f2, f1)
                pair_counts[(a, b)] += 1
                pair_queries[(a, b)].add(sql)
        q_idx += 1
    return dict(pair_counts), {k: set(v) for k, v in pair_queries.items()}


def _directed_weight(
    f_lt: str, p_lt: str, undirected: Dict[Tuple[str, str], int]
) -> int:
    k = (f_lt, p_lt) if f_lt < p_lt else (p_lt, f_lt)
    return undirected.get(k, 0)


def fk_neighbor_partner_weights(
    orig_table: str,
    schema_graph: SchemaGraph,
    groups: List[Set[str]],
    snapshot: Dict[str, Any],
) -> List[Tuple[str, str, int]]:
    """
    Returns list of (partner_orig_table, partner_local_table, score) for neighbors
    in other locals. partner_local_table is one concrete fragment on that local.
    """
    home = logical_home_local(orig_table, groups)
    scores: Dict[str, int] = defaultdict(int)
    for fk in schema_graph.foreign_keys:
        if fk.from_table == orig_table:
            other = fk.to_table
            if logical_home_local(other, groups) == home:
                continue
            scores[other] += 1
        elif fk.to_table == orig_table:
            other = fk.from_table
            if logical_home_local(other, groups) == home:
                continue
            scores[other] += 1
    out: List[Tuple[str, str, int]] = []
    for u, sc in scores.items():
        frags = snapshot["logical_fragments"].get(u, [])
        if not frags:
            continue
        ploc = logical_home_local(u, groups)
        # Prefer smallest local_table name for determinism
        cand = sorted((f for f in frags if snapshot["fragment_by_lt"][f].local_name == ploc))
        if not cand:
            cand = sorted(frags)
        partner_lt = cand[0]
        out.append((u, partner_lt, sc))
    out.sort(key=lambda x: (-x[2], len(snapshot["logical_fragments"].get(x[0], [])), x[0], x[1]))
    return out


def _local_size(local_name: str, locals_list) -> int:
    for loc in locals_list:
        if loc.local_name == local_name:
            return len(loc.tables)
    return 999


def choose_partner_fk_fallback(
    orig_table: str,
    schema_graph: SchemaGraph,
    groups: List[Set[str]],
    snapshot: Dict[str, Any],
    locals_list,
) -> Optional[Tuple[str, str, str]]:
    """Returns (partner_orig, partner_local_table, partner_local_name) or None."""
    cands = fk_neighbor_partner_weights(orig_table, schema_graph, groups, snapshot)
    if not cands:
        return None
    best_sc = cands[0][2]
    tied = [c for c in cands if c[2] == best_sc]
    tied.sort(
        key=lambda x: (
            _local_size(snapshot["fragment_by_lt"][x[1]].local_name, locals_list),
            snapshot["fragment_by_lt"][x[1]].local_name,
            int(snapshot["fragment_by_lt"][x[1]].local_name.replace("local_", "") or 0),
            x[1],
        )
    )
    u, plt, _ = tied[0]
    pln = snapshot["fragment_by_lt"][plt].local_name
    return (u, plt, pln)


def strongest_external_partner_for_fragment(
    f_lt: str,
    home_local: str,
    pair_weights: Dict[Tuple[str, str], int],
    snapshot: Dict[str, Any],
    local_table_counts: Optional[Dict[str, int]] = None,
) -> Optional[Tuple[str, int, str]]:
    """
    Returns (partner_local_table, weight, evidence) where evidence is
    'fragment' or 'table' (table if partner side collapsed to single lt).
    """
    best_p: Optional[str] = None
    best_w = -1
    for (a, b), w in pair_weights.items():
        if a != f_lt and b != f_lt:
            continue
        other = b if a == f_lt else a
        oloc = snapshot["fragment_by_lt"][other].local_name
        if oloc == home_local:
            continue
        if w > best_w:
            best_w = w
            best_p = other
            continue
        if w == best_w:
            # Tie-break: prefer partner that lives in a smaller local (fewer physical tables/fragments),
            # then lexicographic partner fragment name for determinism.
            if local_table_counts is not None and best_p is not None:
                cur_sz = int(local_table_counts.get(oloc, 10**9))
                best_loc = snapshot["fragment_by_lt"][best_p].local_name
                best_sz = int(local_table_counts.get(best_loc, 10**9))
                if cur_sz < best_sz:
                    best_p = other
                    continue
                if cur_sz > best_sz:
                    continue
            if other < (best_p or ""):
                best_p = other
    if best_p is None or best_w <= 0:
        return None
    return (best_p, best_w, "fragment")


def _vertical_intent_for_fragment(
    ot: str,
    f_lt: str,
    anchor_lt: str,
    home: str,
    pair_weights: Dict[Tuple[str, str], int],
    pair_sql: Dict[Tuple[str, str], Set[str]],
    snapshot: Dict[str, Any],
    schema_graph: SchemaGraph,
    groups: List[Set[str]],
    locals_list,
    local_table_counts: Optional[Dict[str, int]] = None,
) -> Optional[Dict[str, Any]]:
    """Build one vertical-split relocation intent, or None if this fragment cannot move."""
    sp = strongest_external_partner_for_fragment(
        f_lt, home, pair_weights, snapshot, local_table_counts=local_table_counts
    )
    if sp is None:
        w = 0
        p_lt: Optional[str] = None
        ev = "fragment"
    else:
        p_lt, w, ev = sp

    if w <= 0 or not p_lt:
        fb = choose_partner_fk_fallback(ot, schema_graph, groups, snapshot, locals_list)
        if not fb:
            return None
        _, p_lt, _ = fb
        w = 0
        ev = "fk_fallback"
        nq = 0
    else:
        k = (f_lt, p_lt) if f_lt < p_lt else (p_lt, f_lt)
        nq = len(pair_sql.get(k, set()))

    assert p_lt is not None
    ploc = snapshot["fragment_by_lt"][p_lt].local_name
    src_idx = int(home.replace("local_", "")) - 1
    tgt_idx = int(ploc.replace("local_", "")) - 1
    if src_idx == tgt_idx:
        return None

    return {
        "source_table": ot,
        "kind": "vertical_split_fragment",
        "movable_fragment": f_lt,
        "anchor_fragment": anchor_lt,
        "partner_fragment": p_lt,
        "partner_logical_table": snapshot["fragment_by_lt"][p_lt].source_table,
        "partner_weight": w,
        "cross_local_query_count": nq,
        "evidence_type": ev,
        "source_local_idx": src_idx,
        "target_local_idx": tgt_idx,
    }


def run_one_shot_relocation(
    locals_list,
    schema_graph: SchemaGraph,
    groups: List[Set[str]],
    queries: List[str],
    vsplit_tables: Set[str],
    rpart_tables: Set[str],
    anchor_by_table: Dict[str, str],
    movable_row_by_table: Dict[str, str],
    rng: random.Random,
    config: Optional[Any] = None,
) -> Tuple[Dict[str, Any], Dict[Tuple[str, int], int], Dict[Tuple[str, int], Dict[str, Any]]]:
    """
    Returns (debug_dict, pending_moves, justifications).
    pending_moves: (fragment_name, source_local_idx) -> target_local_idx
    """
    known_tables = set(schema_graph.tables.keys())
    rho = float(getattr(config, "fragment_relocation_fraction", 0.5) if config is not None else 0.5)
    # Clamp to [0, 1] to avoid surprises from bad configs.
    if rho < 0.0:
        rho = 0.0
    if rho > 1.0:
        rho = 1.0
    snapshot = build_fixed_snapshot(locals_list)
    # Physical table counts per local in the pre-relocation snapshot. Used for:
    # - tie-breaking partner selection (prefer smaller target locals)
    # - guarding against creating singleton locals by moving fragments out.
    local_table_counts: Dict[str, int] = defaultdict(int)
    for lt, snap in snapshot["fragment_by_lt"].items():
        local_table_counts[str(snap.local_name)] += 1
    pair_weights, pair_sql = build_cross_local_fragment_pair_weights(
        queries or [], known_tables, schema_graph, snapshot, groups
    )

    debug: Dict[str, Any] = {
        "pair_weights_sample": {f"{a}|{b}": w for (a, b), w in sorted(pair_weights.items())[:80]},
        "pair_weight_meaning": (
            "Weights count co-occurrences of two fragments (from different original tables) "
            "inside workload queries that already span 2+ locals. They rank relocation candidates; "
            "they do not equal the number of queries that will become single-local after a move."
        ),
        "pre_relocation_fragment_locals": {
            lt: snapshot["fragment_by_lt"][lt].local_name for lt in sorted(snapshot["fragment_by_lt"])
        },
        "singleton_local_guard": {
            "min_physical_tables_per_local_after_move": 2,
            "enabled": True,
        },
    }

    intents: List[Dict[str, Any]] = []
    vertical_R_debug: Dict[str, Dict[str, int]] = {}

    # --- Vertical fragmented boundary tables ---
    # Same relocation budget as row partitions:
    #   R = max(1, ceil(rho * F))
    # where F is the number of fragments for this logical table on the home local.
    # We still cap the budget so the anchor stays pinned on the home local.
    for ot in sorted(vsplit_tables):
        if not is_boundary_table(ot, schema_graph, groups):
            continue
        home = logical_home_local(ot, groups)
        anchor_lt = anchor_by_table.get(ot)
        if not anchor_lt:
            continue
        all_frags = snapshot["logical_fragments"].get(ot, [])
        F = len(all_frags)
        if F < 2:
            continue
        candidates = [
            lt
            for lt in all_frags
            if lt != anchor_lt
            and snapshot["fragment_by_lt"][lt].local_name == home
        ]
        if not candidates:
            continue
        # F in the formula counts home fragments only; cap R so at least the
        # anchor stays on the home local, then bound by movable candidates.
        F_home = 1 + len(candidates)
        R = max(1, int(math.ceil(rho * F_home)))
        R = min(R, F_home - 1)
        R = min(R, len(candidates))
        # Leave at least one non-anchor fragment on the home local when possible (e.g., F=3 -> move at most 1).
        if len(candidates) > 1:
            R = min(R, len(candidates) - 1)
        vertical_R_debug[ot] = {"R": R, "F": F_home, "rho": rho}

        ranked_rows: List[Tuple[str, int, int, int]] = []
        for f_lt in candidates:
            sp = strongest_external_partner_for_fragment(
                f_lt, home, pair_weights, snapshot, local_table_counts=local_table_counts
            )
            w = sp[1] if sp else 0
            snap_f = snapshot["fragment_by_lt"][f_lt]
            ov = len(
                snap_f.projected_orig_cols
                & snapshot["fragment_by_lt"][anchor_lt].projected_orig_cols
            )
            ranked_rows.append((f_lt, w, len(snap_f.projected_orig_cols), ov))
        ranked_rows.sort(key=lambda t: (-t[1], t[2], t[3], t[0]))

        moves_added = 0
        for f_lt, _, _, _ in ranked_rows:
            if moves_added >= R:
                break
            intent = _vertical_intent_for_fragment(
                ot,
                f_lt,
                anchor_lt,
                home,
                pair_weights,
                pair_sql,
                snapshot,
                schema_graph,
                groups,
                locals_list,
                local_table_counts,
            )
            if intent is None:
                continue
            intents.append(intent)
            moves_added += 1

        if moves_added == 0:
            intents.append(
                {
                    "source_table": ot,
                    "skipped": True,
                    "reason": "no_vertical_reloc_candidate_succeeded",
                }
            )

    # --- Horizontal row partitions (F-ary: same R budget as vertical) ---
    row_R_debug: Dict[str, Dict[str, int]] = {}
    rpart_home_anchor: Dict[str, str] = {}

    for ot in sorted(rpart_tables):
        if not is_boundary_table(ot, schema_graph, groups):
            continue
        home = logical_home_local(ot, groups)
        home_fragments = sorted(
            lt
            for lt in snapshot["logical_fragments"].get(ot, [])
            if snapshot["fragment_by_lt"][lt].is_row_partition
            and snapshot["fragment_by_lt"][lt].local_name == home
        )
        if len(home_fragments) < 2:
            continue
        # Pin one fragment to home (the preferred movable from transforms
        # acts as a secondary hint; we anchor a deterministic one so at
        # least one partition stays with the home local).
        preferred = movable_row_by_table.get(ot, "")
        anchor = next(
            (lt for lt in home_fragments if lt != preferred),
            home_fragments[0],
        )
        rpart_home_anchor[ot] = anchor
        candidates = [lt for lt in home_fragments if lt != anchor]
        if not candidates:
            continue
        F_home = len(home_fragments)
        if F_home < 2:
            continue
        R = max(1, int(math.ceil(rho * F_home)))
        R = min(R, F_home - 1)
        R = min(R, len(candidates))
        if len(candidates) > 1:
            R = min(R, len(candidates) - 1)
        row_R_debug[ot] = {
            "R": R,
            "F": F_home,
            "home_fragments": len(home_fragments),
            "rho": rho,
        }

        ranked: List[Tuple[int, str, Optional[str], str]] = []
        for f_lt in candidates:
            sp = strongest_external_partner_for_fragment(
                f_lt, home, pair_weights, snapshot, local_table_counts=local_table_counts
            )
            if sp:
                p_lt, w, ev = sp
                ranked.append((w, f_lt, p_lt, ev))
            else:
                ranked.append((0, f_lt, None, "fragment"))
        ranked.sort(key=lambda x: (-x[0], x[1]))

        moves_added = 0
        for best_w, chosen_f, best_p, ev in ranked:
            if moves_added >= R:
                break
            if best_w <= 0 or not best_p:
                fb = choose_partner_fk_fallback(ot, schema_graph, groups, snapshot, locals_list)
                if not fb:
                    continue
                _, p_lt_fb, _ = fb
                best_p = p_lt_fb
                best_w = 0
                ev = "fk_fallback"
                nq = 0
            else:
                k = (chosen_f, best_p) if chosen_f < best_p else (best_p, chosen_f)
                nq = len(pair_sql.get(k, set()))

            ploc = snapshot["fragment_by_lt"][best_p].local_name
            src_idx = int(home.replace("local_", "")) - 1
            tgt_idx = int(ploc.replace("local_", "")) - 1
            if src_idx == tgt_idx:
                continue

            intents.append(
                {
                    "source_table": ot,
                    "kind": "row_partition",
                    "movable_fragment": chosen_f,
                    "partner_fragment": best_p,
                    "partner_logical_table": snapshot["fragment_by_lt"][best_p].source_table,
                    "partner_weight": best_w,
                    "cross_local_query_count": nq,
                    "evidence_type": ev,
                    "source_local_idx": src_idx,
                    "target_local_idx": tgt_idx,
                    "anchor_fragment": anchor,
                }
            )
            moves_added += 1

        if moves_added == 0:
            intents.append(
                {"source_table": ot, "skipped": True, "reason": "no_row_reloc_candidate_succeeded"}
            )

    # Global ordering
    actives = [x for x in intents if not x.get("skipped")]
    actives.sort(
        key=lambda x: (
            -int(x.get("partner_weight", 0)),
            -int(x.get("cross_local_query_count", 0)),
            x.get("source_table", ""),
        )
    )

    # Scheduling policy after a successful intent (partner pinning + reuse):
    # - Freeze moved fragments (A): a fragment can be scheduled to move at most once
    #   in this relocation pass.
    # - Pin partner fragments (P): once a fragment has been used as a partner/attractor,
    #   it must not be moved later in the same relocation pass (to avoid move-chains
    #   where A moves toward P and then P moves away).
    # - Allow partner reuse: multiple moved fragments may target the same partner P.
    moved_fragments: Set[str] = set()
    pinned_fragments: Set[str] = set()
    pending: Dict[Tuple[str, int], int] = {}
    justifications: Dict[Tuple[str, int], Dict[str, Any]] = {}
    skipped_after_order: List[Dict[str, Any]] = []

    for it in actives:
        fn = it["movable_fragment"]
        pf = it.get("partner_fragment") or ""
        pt = it["partner_logical_table"]

        # Movable cannot be moved twice; also a fragment that has acted as a partner
        # is pinned and must not be moved later in this pass.
        if fn in moved_fragments:
            skipped_after_order.append({**it, "reason": "movable_already_moved"})
            continue
        if fn in pinned_fragments:
            skipped_after_order.append({**it, "reason": "movable_is_pinned_partner"})
            continue
        # Avoid moving onto a partner that is itself scheduled to move (move-chains).
        if pf and pf in moved_fragments:
            skipped_after_order.append({**it, "reason": "partner_scheduled_to_move"})
            continue

        src_i = it["source_local_idx"]
        tgt_i = it["target_local_idx"]
        src_local_name = f"local_{int(src_i) + 1}"
        tgt_local_name = f"local_{int(tgt_i) + 1}"
        # Guard: never move a fragment out if that would leave the source local
        # with fewer than 2 physical tables in total.
        if int(local_table_counts.get(src_local_name, 0)) - 1 < 2:
            skipped_after_order.append({**it, "reason": "would_create_singleton_local"})
            continue
        pending[(fn, src_i)] = tgt_i
        ev = it.get("evidence_type")
        justifications[(fn, src_i)] = {
            "method": "one_shot_partner_relocation",
            "partner_fragment": it.get("partner_fragment"),
            "partner_logical_table": pt,
            "partner_weight": it.get("partner_weight"),
            "cross_local_query_count": it.get("cross_local_query_count"),
            "cross_local_query_count_interpretation": (
                "Distinct cross-local workload queries where this fragment pair "
                "(different original tables) co-occurs; not an estimate of "
                "single-local queries after relocation."
            ),
            "evidence_type": ev,
            "anchor_fragment": it.get("anchor_fragment"),
            "target_local_reason": "partner_residence_in_pre_relocation_snapshot",
            "partner_selection_rule": (
                "max_cross_local_query_co_usage"
                if int(it.get("partner_weight") or 0) > 0
                else "fk_neighbor_fallback"
            ),
            "decision_signal": "query_evidence" if ev != "fk_fallback" else "fk_fallback",
        }
        # Freeze moved fragment (A).
        moved_fragments.add(fn)
        # Pin partner fragment (P) so it cannot be moved later in this pass.
        if pf:
            pinned_fragments.add(pf)
        # Update physical table counts for subsequent moves in this global ordering.
        local_table_counts[src_local_name] = int(local_table_counts.get(src_local_name, 0)) - 1
        local_table_counts[tgt_local_name] = int(local_table_counts.get(tgt_local_name, 0)) + 1

        if it.get("kind") == "row_partition":
            # Pin only the deterministic anchor on the home local so that at
            # least one fragment stays with the home; other fragments remain
            # eligible for subsequent intents in the same table.
            anchor_lt = it.get("anchor_fragment") or rpart_home_anchor.get(it["source_table"])
            if anchor_lt:
                pinned_fragments.add(anchor_lt)

    skipped = [x for x in intents if x.get("skipped")]
    debug["vertical_relocation_R_by_table"] = vertical_R_debug
    debug["row_relocation_R_by_table"] = row_R_debug
    debug["row_partition_home_anchor"] = rpart_home_anchor
    debug["intents"] = intents
    debug["moved_fragments"] = sorted(moved_fragments)
    debug["pinned_fragments"] = sorted(pinned_fragments)
    debug["skipped"] = skipped
    debug["skipped_after_order"] = skipped_after_order
    return debug, pending, justifications
