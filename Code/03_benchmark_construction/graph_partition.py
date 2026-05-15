import json
import os
import random
import math
import networkx as nx
from typing import List, Dict, Set, Tuple, Optional
from collections import defaultdict

from schema_parser import SchemaGraph, Table, ForeignKey


# ---------------------------------------------------------------------------
# Table-classification helpers
# ---------------------------------------------------------------------------

def load_table_classifications(
    schema_name: str,
    classifications_dir: Optional[str] = None,
) -> Optional[Dict]:
    """Load LLM-generated table classifications for *schema_name*.

    Searches in *classifications_dir* (default:
    ``<Code>/data/table_classifications/BIRD/``).
    Returns the parsed JSON dict, or ``None`` if the file is absent.
    """
    if classifications_dir is None:
        from paths import data_table_classifications_bird

        classifications_dir = data_table_classifications_bird()

    path = os.path.join(classifications_dir, f"{schema_name}.json")
    if not os.path.exists(path):
        return None
    with open(path) as f:
        return json.load(f)


def _build_entity_groups(
    classifications: Dict,
    all_table_names: Set[str],
) -> Tuple[List[Set[str]], Dict[str, str]]:
    """Build initial groups: each Entity table + its Entity_Detail dependants.

    Returns
    -------
    entity_groups : list[set[str]]
        One group per Entity table (order matches classification order).
    table_type : dict[str, str]
        Mapping ``table_name -> "ENTITY" | "ENTITY_DETAIL" | "RELATIONSHIP"``.
    """
    table_info = {t["table"]: t for t in classifications.get("tables", [])}
    table_type: Dict[str, str] = {}

    # Normalise: only keep tables that actually exist in the schema
    for t in classifications.get("tables", []):
        name = t["table"]
        if name in all_table_names:
            table_type[name] = t["classification"].upper()

    # Any table present in schema but missing from classification → treat
    # as RELATIONSHIP (conservative: will be assigned by connectivity).
    for t in all_table_names:
        if t not in table_type:
            table_type[t] = "RELATIONSHIP"

    # Build entity groups
    # Sort entity tables to ensure deterministic ordering independent of
    # dict/set iteration order.
    entity_tables = sorted(
        [t for t, tp in table_type.items() if tp == "ENTITY"]
    )
    entity_groups: List[Set[str]] = [set([e]) for e in entity_tables]
    entity_index = {e: i for i, e in enumerate(entity_tables)}

    # Attach Entity_Detail tables to their associated entity
    for t, tp in table_type.items():
        if tp != "ENTITY_DETAIL":
            continue
        info = table_info.get(t, {})
        assoc = info.get("associated_entity", "none")
        if assoc and assoc != "none" and assoc in entity_index:
            entity_groups[entity_index[assoc]].add(t)
        else:
            # Associated entity not found — assign to closest entity via FK
            # (will be handled in assignment phase later)
            pass

    return entity_groups, table_type


def _merge_entity_groups(
    groups: List[Set[str]],
    target_k: int,
    schema_graph: SchemaGraph,
) -> List[Set[str]]:
    """Merge entity groups until we have *target_k* groups.

    At each step the two groups with the strongest FK connectivity
    (most FK edges between them) are merged.
    """
    # Deep copy and normalise to sets
    groups = [set(g) for g in groups]

    while len(groups) > target_k:
        best_pair = (0, 1)
        best_score = -1

        for i in range(len(groups)):
            for j in range(i + 1, len(groups)):
                score = 0
                for fk in schema_graph.foreign_keys:
                    a_in_i = fk.from_table in groups[i] or fk.to_table in groups[i]
                    a_in_j = fk.from_table in groups[j] or fk.to_table in groups[j]
                    cross = (
                        (fk.from_table in groups[i] and fk.to_table in groups[j])
                        or (fk.from_table in groups[j] and fk.to_table in groups[i])
                    )
                    if cross:
                        score += 1
                # Tie-break: prefer merging smaller groups
                size_sum = len(groups[i]) + len(groups[j])
                composite = (score, -size_sum)
                if composite > (best_score, 0) or best_score == -1:
                    best_score = score
                    best_pair = (i, j)

        i, j = best_pair
        groups[i] = groups[i] | groups[j]
        del groups[j]

    return groups


def choose_k_from_classifications(
    classifications: Dict,
    num_tables: int,
    all_table_names: Set[str],
) -> int:
    """Determine K from table classifications.

    Policy (paper rule):
      - Let N be the number of logical tables.
      - Let S_E be the number of initial entity-centered groups (Entity + attached Entity_Details).
      - Choose:
          K = min(S_E, floor(N / 3))
        then clamp to a fixed range (default: 3 <= K <= 8).
    """
    entity_groups, _ = _build_entity_groups(classifications, all_table_names)
    s_e = len(entity_groups)
    k = min(int(s_e), int(num_tables // 3))
    k = max(3, min(k, 8))
    return k


def classification_based_partition(
    schema_graph: SchemaGraph,
    classifications: Dict,
    K: int,
    seed: int = 42,
    balance_audit: Optional[Dict] = None,
    rebalance_audit: Optional[Dict] = None,
) -> List[Set[str]]:
    """Partition tables using LLM-classified table types.

    Strategy
    --------
    1. Build entity groups (Entity + Entity_Detail).
    2. If more groups than K, merge the closest pairs.
    3. Assign unplaced Entity_Detail and Relationship tables by FK
       connectivity (same scoring as hub-seeded approach).
    4. Rebalance if any group is too small.

    Falls back to :func:`hub_seeded_partition` when classifications give
    fewer than 3 entity groups.
    """
    rng = random.Random(seed)
    all_tables = set(schema_graph.tables.keys())

    entity_groups, table_type = _build_entity_groups(classifications, all_tables)

    if len(entity_groups) < 3:
        # Not enough entities to form meaningful groups — fall back
        return hub_seeded_partition(
            schema_graph,
            K,
            seed=seed,
            balance_audit=balance_audit,
            rebalance_audit=rebalance_audit,
        )

    # --- Phase 1: start with entity groups (may need merging) ---
    if len(entity_groups) > K:
        groups = _merge_entity_groups(entity_groups, K, schema_graph)
    elif len(entity_groups) < K:
        # Fewer entity groups than K — split largest groups or fall back
        # Copy to avoid mutating original lists and ensure deterministic ordering
        groups = [set(sorted(g)) for g in entity_groups]
        # Pad with empty groups that will be filled during assignment
        while len(groups) < K:
            # Split the largest group if it has >2 tables
            largest_idx = max(range(len(groups)), key=lambda i: len(groups[i]))
            if len(groups[largest_idx]) > 2:
                largest = groups[largest_idx]
                # Move the Entity_Detail (non-entity) tables out
                entities_in = [t for t in largest if table_type.get(t) == "ENTITY"]
                non_entities = [t for t in largest if table_type.get(t) != "ENTITY"]
                if non_entities:
                    new_group = set()
                    for t in non_entities[:len(non_entities)//2 + 1]:
                        largest.remove(t)
                        new_group.add(t)
                    groups.append(new_group)
                else:
                    # All entities — just create an empty group
                    groups.append(set())
            else:
                groups.append(set())
    else:
        groups = [set(sorted(g)) for g in entity_groups]

    # --- Phase 2: assign remaining tables ---
    assigned: Set[str] = set()
    for g in groups:
        assigned |= g

    remaining = all_tables - assigned

    # Sort remaining: Entity_Detail first (try to place near entity),
    # then Relationship tables
    def sort_key(t):
        tp = table_type.get(t, "RELATIONSHIP")
        if tp == "ENTITY_DETAIL":
            return 0
        elif tp == "ENTITY":
            return 1
        else:
            return 2

    # Sort remaining deterministically by type, then by table name
    remaining_sorted = sorted(remaining, key=lambda t: (sort_key(t), t))

    N = len(all_tables)
    target_size = N / K

    for table in remaining_sorted:
        # Score each group. Also optionally audit whether balance terms change the
        # assignment compared to connectivity-only.
        per_group = []
        for i, group in enumerate(groups):
            connectivity = _connectivity_score(table, group, schema_graph)
            # Balance penalty
            size_ratio = len(group) / target_size if target_size > 0 else 0
            if size_ratio > 1.0:
                balance_penalty = (size_ratio - 1.0) * 3
            else:
                balance_penalty = 0
            # Bonus for undersized groups
            balance_bonus = 2 if len(group) < 2 else 0
            combined = connectivity - balance_penalty + balance_bonus
            per_group.append(
                {
                    "group_idx": i,
                    "connectivity": int(connectivity),
                    "balance_penalty": float(balance_penalty),
                    "balance_bonus": float(balance_bonus),
                    "combined": float(combined),
                    "group_size": int(len(group)),
                }
            )

        max_score = max(x["combined"] for x in per_group)
        # Deterministic tie-breaking: smallest group size, then lowest index
        best_groups = [x["group_idx"] for x in per_group if x["combined"] == max_score]
        chosen = min(best_groups, key=lambda i: (len(groups[i]), i))

        if balance_audit is not None:
            # Connectivity-only winner using the same tie-break policy.
            max_conn = max(x["connectivity"] for x in per_group)
            conn_groups = [x["group_idx"] for x in per_group if x["connectivity"] == max_conn]
            chosen_conn = min(conn_groups, key=lambda i: (len(groups[i]), i))
            if chosen_conn != chosen:
                events = balance_audit.setdefault("events", [])
                events.append(
                    {
                        "table": table,
                        "connectivity_only_choice": int(chosen_conn),
                        "combined_choice": int(chosen),
                        "per_group": per_group,
                        "note": "Choice differs only because of balance_penalty/bonus terms",
                    }
                )
        groups[chosen].add(table)

    # --- Phase 3: rebalance undersized groups (including a single singleton) ---
    # Previously, `if len(small) <= 1: break` skipped all work when exactly one
    # local had one table (e.g. Country alone). Donate one well-connected table
    # from the largest other local until every group has >= 2 tables or no move
    # is possible.
    for _pass in range(3):
        small = [i for i, g in enumerate(groups) if len(g) < 2]
        if not small:
            break
        moved_any = False
        pass_no = _pass + 1
        for sg_idx in sorted(small):
            donors = [
                i
                for i in range(len(groups))
                # Never donate a table if it would leave the donor undersized.
                # This prevents rebalancing from creating a new singleton local.
                if i != sg_idx and len(groups[i]) > 2
            ]
            if not donors:
                continue
            largest_idx = max(donors, key=lambda i: (len(groups[i]), -i))
            candidates = sorted(groups[largest_idx])
            if not candidates:
                continue
            best_table = max(
                candidates,
                key=lambda t: (
                    _connectivity_score(t, groups[sg_idx], schema_graph)
                    - _connectivity_score(t, groups[largest_idx] - {t}, schema_graph)
                ),
            )
            groups[largest_idx].remove(best_table)
            groups[sg_idx].add(best_table)
            if rebalance_audit is not None:
                rebalance_audit.setdefault("moves", []).append(
                    {
                        "table": best_table,
                        "from_group_idx": int(largest_idx),
                        "to_group_idx": int(sg_idx),
                        "from_local": f"local_{largest_idx + 1}",
                        "to_local": f"local_{sg_idx + 1}",
                        "rebalance_pass": int(pass_no),
                        "partition_algorithm": "classification_based",
                        "reason": "post_partition_rebalancing_undersized_local",
                    }
                )
            moved_any = True
        if not moved_any:
            break

    # Remove any empty groups
    groups = [g for g in groups if g]

    return groups


def choose_k(num_tables: int, seed: int = 42) -> int:
    """Choose number of local schemas based on table count (Task 2).
    
    Args:
        num_tables: Number of tables in the schema
        seed: Random seed for deterministic choice when multiple options exist
    """
    # Rule-based fallback when classifications are unavailable.
    # Keep K deterministic and aligned with the paper rule-of-thumb:
    #   K = clamp(floor(N/3), 3, 8)
    _ = seed  # seed kept for API compatibility (no randomness here).
    k = int(num_tables // 3)
    k = max(3, min(k, 8))
    return k


def compute_cohesion(
    group_tables: Set[str], schema_graph: SchemaGraph
) -> float:
    """
    Compute cohesion of a group:
    cohesion = internal_fk_edges / total_fk_edges_involving_group_tables
    """
    internal = 0
    total = 0
    for fk in schema_graph.foreign_keys:
        involves = (fk.from_table in group_tables) or (fk.to_table in group_tables)
        if involves:
            total += 1
            if (fk.from_table in group_tables) and (fk.to_table in group_tables):
                internal += 1
    if total == 0:
        return 1.0
    return internal / total


def compute_cut_ratio(
    groups: List[Set[str]], schema_graph: SchemaGraph
) -> float:
    """
    Compute cut ratio: fraction of FK edges that cross locals.
    """
    cross = 0
    total = len(schema_graph.foreign_keys)
    if total == 0:
        return 0.0

    # Build table -> group mapping
    table_group = {}
    for i, group in enumerate(groups):
        for t in group:
            table_group[t] = i

    for fk in schema_graph.foreign_keys:
        g1 = table_group.get(fk.from_table)
        g2 = table_group.get(fk.to_table)
        if g1 is not None and g2 is not None and g1 != g2:
            cross += 1

    return cross / total


def _connectivity_score(table: str, group: Set[str], schema_graph: SchemaGraph) -> int:
    """Count FK edges between a table and a group."""
    score = 0
    for fk in schema_graph.foreign_keys:
        if fk.from_table == table and fk.to_table in group:
            score += 1
        elif fk.to_table == table and fk.from_table in group:
            score += 1
    return score


def hub_seeded_partition(
    schema_graph: SchemaGraph,
    K: int,
    seed: int = 42,
    min_cohesion: float = 0.25,
    balance_audit: Optional[Dict] = None,
    rebalance_audit: Optional[Dict] = None,
) -> List[Set[str]]:
    """
    Hub-seeded grouping algorithm (Task 3A) with balanced allocation.

    1. Select K seed tables by highest degree, ensuring diversity.
    2. Initialize K groups with seeds.
    3. Assign remaining tables using connectivity + balance penalty.
    4. Rebalance to meet minimum size constraints (at least 2 per group,
       except at most one utility local with 1).
    """
    rng = random.Random(seed)

    G_undirected = schema_graph.graph.to_undirected()
    degrees = dict(G_undirected.degree())
    N = len(schema_graph.tables)
    target_size = N / K  # ideal group size

    # Sort tables by degree descending
    sorted_tables = sorted(degrees.items(), key=lambda x: (-x[1], x[0]))
    all_tables = set(schema_graph.tables.keys())

    # Select K seed tables: pick top-degree tables that are far apart
    seeds = []
    used = set()

    for table, deg in sorted_tables:
        if len(seeds) >= K:
            break
        # Check that seed is not a direct neighbor of any existing seed
        neighbors = set(G_undirected.neighbors(table)) if table in G_undirected else set()
        if not (neighbors & used):
            seeds.append(table)
            used.add(table)

    # If we couldn't get K diverse seeds, fill with remaining highest-degree tables
    if len(seeds) < K:
        for table, deg in sorted_tables:
            if table not in used:
                seeds.append(table)
                used.add(table)
            if len(seeds) >= K:
                break

    # Initialize groups
    groups = [set([s]) for s in seeds]
    assigned = set(seeds)
    remaining = all_tables - assigned

    # Sort remaining by total degree descending (assign high-connectivity first)
    remaining_sorted = sorted(remaining, key=lambda t: degrees.get(t, 0), reverse=True)

    # Assign each remaining table to best group, penalizing oversized groups
    max_group_size = math.ceil(target_size * 1.5)

    for table in remaining_sorted:
        per_group = []
        for i, group in enumerate(groups):
            connectivity = _connectivity_score(table, group, schema_graph)
            # Balance penalty: penalize groups already at or above target size
            size_ratio = len(group) / target_size
            if size_ratio > 1.0:
                balance_penalty = (size_ratio - 1.0) * 3  # strong penalty for oversized
            else:
                balance_penalty = 0
            # Bonus for undersized groups
            if len(group) < 2:
                balance_bonus = 2
            else:
                balance_bonus = 0
            combined = connectivity - balance_penalty + balance_bonus
            per_group.append(
                {
                    "group_idx": i,
                    "connectivity": int(connectivity),
                    "balance_penalty": float(balance_penalty),
                    "balance_bonus": float(balance_bonus),
                    "combined": float(combined),
                    "group_size": int(len(group)),
                }
            )

        # Find max score; break ties by preferring smaller groups
        max_score = max(x["combined"] for x in per_group)
        best_groups = [x["group_idx"] for x in per_group if x["combined"] == max_score]
        # Among tied groups, pick smallest
        chosen = min(best_groups, key=lambda i: len(groups[i]))

        if balance_audit is not None:
            max_conn = max(x["connectivity"] for x in per_group)
            conn_groups = [x["group_idx"] for x in per_group if x["connectivity"] == max_conn]
            chosen_conn = min(conn_groups, key=lambda i: len(groups[i]))
            if chosen_conn != chosen:
                events = balance_audit.setdefault("events", [])
                events.append(
                    {
                        "table": table,
                        "connectivity_only_choice": int(chosen_conn),
                        "combined_choice": int(chosen),
                        "per_group": per_group,
                        "note": "Choice differs only because of balance_penalty/bonus terms",
                    }
                )
        groups[chosen].add(table)

    # Rebalance: ensure each group has >= 2 tables (except 1 utility local allowed)
    utility_allowed = 1
    for _rebalance_pass in range(3):  # multiple passes
        small_groups = [i for i, g in enumerate(groups) if len(g) < 2]
        if len(small_groups) <= utility_allowed:
            break

        pass_no = _rebalance_pass + 1
        for sg_idx in small_groups[utility_allowed:]:
            # Find largest group to steal from
            largest_idx = max(range(len(groups)), key=lambda i: len(groups[i]))
            if len(groups[largest_idx]) <= 2:
                continue
            # Pick table with best connectivity to the small group but lowest
            # connectivity to its current group (easiest to lose)
            candidates = [t for t in groups[largest_idx] if t not in seeds]
            if not candidates:
                candidates = list(groups[largest_idx])

            best_table = max(
                candidates,
                key=lambda t: (
                    _connectivity_score(t, groups[sg_idx], schema_graph)
                    - _connectivity_score(t, groups[largest_idx] - {t}, schema_graph)
                ),
            )
            groups[largest_idx].remove(best_table)
            groups[sg_idx].add(best_table)
            if rebalance_audit is not None:
                rebalance_audit.setdefault("moves", []).append(
                    {
                        "table": best_table,
                        "from_group_idx": int(largest_idx),
                        "to_group_idx": int(sg_idx),
                        "from_local": f"local_{largest_idx + 1}",
                        "to_local": f"local_{sg_idx + 1}",
                        "rebalance_pass": int(pass_no),
                        "partition_algorithm": "hub_seeded",
                        "reason": "post_partition_rebalancing_undersized_local",
                    }
                )

    return groups


def partition_with_labels(
    schema_graph: SchemaGraph,
    K: int,
    seed: int = 42,
) -> Tuple[List[Set[str]], Dict[int, str]]:
    """
    Partition tables into K groups and generate descriptive labels.
    Returns (groups, labels_dict).
    """
    groups = hub_seeded_partition(schema_graph, K, seed=seed)

    # Generate descriptive labels based on table content
    labels = {}
    for i, group in enumerate(groups):
        tables = sorted(group)
        # Simple heuristic: use the most "hub-like" table's domain
        labels[i] = f"local_{i+1}"

    return groups, labels


def print_partition_summary(
    groups: List[Set[str]], schema_graph: SchemaGraph
) -> str:
    """Print and return a summary of the partition."""
    lines = []
    lines.append(f"\n=== Partition Summary (K={len(groups)}) ===")

    for i, group in enumerate(groups):
        cohesion = compute_cohesion(group, schema_graph)
        tables = sorted(group)
        total_rows = sum(schema_graph.tables[t].row_count for t in tables)
        lines.append(
            f"\nLocal {i+1}: {len(tables)} tables, {total_rows} total rows, cohesion={cohesion:.3f}"
        )
        for t in tables:
            tbl = schema_graph.tables[t]
            lines.append(f"  - {t} ({len(tbl.columns)} cols, {tbl.row_count} rows)")

    cut_ratio = compute_cut_ratio(groups, schema_graph)
    lines.append(f"\nCut ratio: {cut_ratio:.3f}")
    lines.append(f"Total FK edges: {len(schema_graph.foreign_keys)}")

    # Count cross-local edges
    table_group = {}
    for i, group in enumerate(groups):
        for t in group:
            table_group[t] = i
    cross = sum(
        1
        for fk in schema_graph.foreign_keys
        if table_group.get(fk.from_table) != table_group.get(fk.to_table)
    )
    lines.append(f"Cross-local FK edges: {cross}")

    summary = "\n".join(lines)
    print(summary)
    return summary
