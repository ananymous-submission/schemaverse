import argparse
import json
import os
import sys
from typing import Dict, Optional, Tuple
import time
import shutil
from datetime import datetime

# Avoid OpenMP/BLAS thread explosions on clusters with strict process/thread limits.
# This prevents errors like:
#   libgomp: Thread creation failed: Resource temporarily unavailable
for _k in (
    "OMP_NUM_THREADS",
    "OPENBLAS_NUM_THREADS",
    "MKL_NUM_THREADS",
    "VECLIB_MAXIMUM_THREADS",
    "NUMEXPR_NUM_THREADS",
):
    os.environ.setdefault(_k, "1")

from schema_parser import (
    apply_inferred_keys,
    extract_original_ddl,
    parse_queries,
    parse_schema,
    schema_to_dict,
)
from validate_data import validate_data_equivalence
from config import DifficultyConfig, DIFFICULTY_PRESETS
from paths import (
    data_bird_root,
    data_spider2_root,
    data_table_classifications_bird,
    data_table_classifications_subdir,
    infer_original_db_path_from_instance,
)
from transforms import transform_spec_from_dict


def bird_instance_paths(
    db_name: str,
    bird_root: Optional[str] = None,
    databases_subdir: str = "dev_databases",
) -> Tuple[str, str]:
    """
    Resolve BIRD layout: {bird_root}/{databases_subdir}/{db_name}/{db_name}.sqlite
    and a queries JSON file alongside the database.

    Use databases_subdir=\"train_databases\" for BIRD train split instances.
    """
    if bird_root is None:
        bird_root = data_bird_root()
    base = os.path.join(bird_root, databases_subdir, db_name)
    db_path = os.path.join(base, f"{db_name}.sqlite")
    # BIRD convention: dev split uses dev.json, train split uses train.json.
    preferred = "train.json" if databases_subdir == "train_databases" else "dev.json"
    queries_path = os.path.join(base, preferred)
    if not os.path.isfile(queries_path):
        # Backward/alternate layouts: try the other filename if the preferred one
        # isn't present (keeps CLI ergonomic when users mix layouts).
        alt = "dev.json" if preferred == "train.json" else "train.json"
        alt_path = os.path.join(base, alt)
        if os.path.isfile(alt_path):
            queries_path = alt_path
    return db_path, queries_path


def spider2_instance_paths(
    db_name: str,
    spider2_root: Optional[str] = None,
) -> Tuple[str, Optional[str]]:
    # Spider2 ships schema + data only; no dev.json-style workload.
    if spider2_root is None:
        spider2_root = data_spider2_root()
    base = os.path.join(spider2_root, db_name)
    db_path = os.path.join(base, f"{db_name}.sqlite")
    return db_path, None


def default_benchmark_output_dir(db_name: str, output_parent: str = "output") -> str:
    """Default instance directory for --db_name: {output_parent}/{db_name}_benchmark."""
    return os.path.join(output_parent, f"{db_name}_benchmark")


def load_queries(queries_path: Optional[str]):
    # None → no workload (Spider2 has no dev.json).
    if not queries_path:
        return [], []
    with open(queries_path) as f:
        data = json.load(f)

    queries = []
    metadata = []
    for item in data:
        sql = item.get("SQL", "")
        if sql:
            queries.append(sql)
            metadata.append({
                "question_id": item.get("question_id"),
                "question": item.get("question", ""),
                "difficulty": item.get("difficulty", ""),
                "evidence": item.get("evidence", ""),
            })

    return queries, metadata


def _build_horizontal_fragmentation_audit(transform_spec, config) -> dict:
    """Surface the AFD horizontal-fragmentation decisions into metadata.json.

    For each horizontally partitioned (original) table we record:
      - predicate column (C), chosen F, overlap_ratio,
      - AFD score / mean_strong / coverage and the strong dependencies
        (C -> A with precision c).
    """
    rpart_map = getattr(transform_spec, "row_partition_map", None) or {}
    entries = []
    for key, meta in sorted(rpart_map.items(), key=lambda kv: str(kv[0])):
        audit = meta.get("afd_audit") or {}
        names = list(meta.get("partition_names") or [])
        pvals = list(meta.get("partition_values") or [])
        roles = list(meta.get("fragment_roles") or [])
        base_sqls = list(meta.get("base_predicate_sqls") or [])
        fragments_info = []
        for i, pname in enumerate(names):
            fragments_info.append({
                "fragment_name": pname,
                "role": roles[i] if i < len(roles) else None,
                "partition_value": pvals[i] if i < len(pvals) else None,
                "base_predicate_sql": base_sqls[i] if i < len(base_sqls) else None,
            })
        entries.append({
            "storage_key": key,
            "source_table": meta.get("source_table"),
            "vertical_fragment_suffix": meta.get("vertical_fragment_suffix"),
            "predicate_column": meta.get("predicate_column"),
            "predicate_kind": meta.get("predicate_kind"),
            "num_fragments_F": meta.get("num_partitions"),
            "overlap_ratio": meta.get("overlap_ratio", 0.0),
            "has_overlap": bool(meta.get("has_overlap", False)),
            "fragment_roles": roles,
            "partition_names": names,
            "partition_values": pvals,
            "fragments": fragments_info,
            "home_fragment": meta.get("home_fragment"),
            "movable_fragments": list(meta.get("movable_fragments") or []),
            "afd_mean_strong": audit.get("mean_strong"),
            "afd_coverage": audit.get("coverage"),
            "afd_score": audit.get("score"),
            "afd_min_strength": audit.get(
                "afd_min_strength", getattr(config, "afd_min_strength", 0.7)
            ),
            "strong_dependencies": audit.get("strong_dependencies") or [],
            "candidate_columns": audit.get("candidate_columns") or [],
            "ranked_columns": audit.get("ranked_columns") or [],
            "afd_engine": audit.get("engine"),
            "afd_sample_rows": audit.get("sample_rows"),
        })
    return {
        "description": (
            "AFD-based F-way horizontal fragmentation. For each partitioned "
            "table, lists the chosen predicate column, F (number of fragments, "
            "distinct from K = number of locals), the configured row "
            "overlap fraction, and the single-threshold AFD score "
            "(mean precision of strong C->A dependencies x coverage)."
        ),
        "config": {
            "afd_min_strength": getattr(config, "afd_min_strength", 0.7),
            "hf_max_num_fragments": getattr(config, "hf_max_num_fragments", 10),
            "hf_numeric_default_fragments": getattr(
                config, "hf_numeric_default_fragments", 4
            ),
            "row_partition_overlap_fraction": getattr(
                config, "row_partition_overlap_fraction", 0.12
            ),
            "afd_max_sample_rows": getattr(config, "afd_max_sample_rows", 20000),
        },
        "num_partitioned_tables": len(entries),
        "entries": entries,
    }


def generate_instance(
    db_path: str,
    queries_path: Optional[str],
    output_dir: str,
    difficulty: str = "medium",
    seed: int = 42,
    use_llm: bool = True,
    classifications_dir: str = None,
    enable_query_rewrite: bool = False,
    run_validation: bool = False,
    inferred_keys_validation_mode: Optional[str] = None,
):
    start_time = time.time()

    # Local import: `graph_partition` depends on optional heavy deps (e.g. networkx).
    # This keeps `validate_instance` usable in minimal environments.
    from graph_partition import (  # noqa: WPS433
        choose_k,
        hub_seeded_partition,
        partition_with_labels,
        compute_cut_ratio,
        compute_cohesion,
        print_partition_summary,
        load_table_classifications,
        choose_k_from_classifications,
        classification_based_partition,
    )
    from transforms import (  # noqa: WPS433
        apply_transforms,
        transform_spec_to_dict,
        TransformSpec,
    )
    from materialize_locals import materialize_locals  # noqa: WPS433
    from reconstruct import (  # noqa: WPS433
        generate_reconstruction_sql,
        materialize_reconstruction,
    )
    from query_rewriter import classify_and_rewrite_queries  # noqa: WPS433

    print(f"=" * 70)
    print(f"Benchmark Generator: Global Schema from Local Schemas")
    print(f"=" * 70)
    print(f"Database: {db_path}")
    print(f"Queries: {queries_path or '(none)'}")
    print(f"Difficulty: {difficulty}")
    print(f"Seed: {seed}")
    print(f"Output: {output_dir}")
    print()

    # Load difficulty config
    if difficulty in DIFFICULTY_PRESETS:
        config = DIFFICULTY_PRESETS[difficulty]
    else:
        config = DIFFICULTY_PRESETS["medium"]
    config.seed = seed
    config.use_llm_naming = use_llm

    # Create output directory
    os.makedirs(output_dir, exist_ok=True)

    # ─── Task 1: Parse Schema ───
    print("Task 1: Parsing original schema...")
    schema_graph = parse_schema(db_path)
    inferred_keys_used = False
    inferred_keys_audit: Dict = {}
    no_declared_pk = all(not t.primary_keys for t in schema_graph.tables.values())
    no_declared_fk = len(schema_graph.foreign_keys) == 0
    if no_declared_pk and no_declared_fk:
        print("  No declared PK/FK found; running HoPF-style key inference...")
        from hopf_inference import infer_keys_hopf_style  # noqa: WPS433

        inferred_pk_map, inferred_fks, inferred_audit = infer_keys_hopf_style(
            db_path=db_path,
            schema_graph=schema_graph,
            max_pk_arity=2,
            min_fk_inclusion=0.98,
        )
        apply_inferred_keys(
            schema_graph=schema_graph,
            inferred_pk_map=inferred_pk_map,
            inferred_fks=inferred_fks,
            audit=inferred_audit,
        )
        inferred_keys_used = True
        inferred_keys_audit = inferred_audit or {}
        print(
            f"  Inferred keys: PK tables={sum(1 for v in inferred_pk_map.values() if v)} "
            f"| FK edges={len(inferred_fks)}"
        )
    print(f"  Tables: {schema_graph.num_tables}")
    print(f"  FK edges: {schema_graph.num_edges}")
    print(f"  Hub tables: {schema_graph.hub_tables}")
    print(f"  Connected components: {schema_graph.connected_components}")

    # Load queries
    print("\nLoading queries...")
    queries, query_metadata = load_queries(queries_path)
    print(f"  Loaded {len(queries)} queries")

    # Parse query references
    query_refs = parse_queries(queries)
    print(f"  Tables referenced in queries: {sorted(query_refs.keys())}")

    # ─── Task 2: Choose K ───
    print(f"\nTask 2: Choosing K...")
    import random
    random.seed(seed)

    # Try to load LLM-generated table classifications
    db_name = os.path.splitext(os.path.basename(db_path))[0]
    classifications = load_table_classifications(db_name, classifications_dir)
    all_table_names = set(schema_graph.tables.keys())

    if classifications:
        print(f"  Table classifications loaded for '{db_name}'")
        entity_count = sum(
            1 for t in classifications.get("tables", [])
            if t["classification"].upper() == "ENTITY" and t["table"] in all_table_names
        )
        detail_count = sum(
            1 for t in classifications.get("tables", [])
            if t["classification"].upper() == "ENTITY_DETAIL" and t["table"] in all_table_names
        )
        rel_count = sum(
            1 for t in classifications.get("tables", [])
            if t["classification"].upper() == "RELATIONSHIP" and t["table"] in all_table_names
        )
        print(f"  Table types: {entity_count} Entity, {detail_count} Entity_Detail, {rel_count} Relationship")
        K = choose_k_from_classifications(classifications, schema_graph.num_tables, all_table_names)
        partition_method = "classification"
    else:
        print(f"  No table classifications found for '{db_name}', using rule-based K")
        K = choose_k(schema_graph.num_tables, seed=seed)
        partition_method = "hub_seeded"

    print(f"  K = {K} locals for {schema_graph.num_tables} tables (method: {partition_method})")

    # ─── Task 3: Partition ───
    print(f"\nTask 3: Creating cohesive partitions...")
    balance_audit: Dict = {}
    rebalance_audit: Dict = {}
    if partition_method == "classification":
        groups = classification_based_partition(
            schema_graph,
            classifications,
            K,
            seed=seed,
            balance_audit=balance_audit,
            rebalance_audit=rebalance_audit,
        )
        print(f"  Used classification-based partitioning (entity-anchored groups)")
    else:
        groups = hub_seeded_partition(
            schema_graph,
            K,
            seed=seed,
            balance_audit=balance_audit,
            rebalance_audit=rebalance_audit,
        )
        print(f"  Used hub-seeded partitioning (FK connectivity)")
    summary = print_partition_summary(groups, schema_graph)

    # ─── Task 4: Apply transforms ───
    print(f"\nTask 4: Applying lossless transforms...")
    locals_list, transform_spec = apply_transforms(
        schema_graph, groups, config, db_path, queries=queries, output_dir=output_dir
    )

    # Print transform summary
    for local in locals_list:
        print(f"\n  {local.local_name}:")
        for lt_name, transform in local.tables.items():
            suffix = ""
            if transform.is_vertical_split_fragment and transform.is_row_partition:
                suffix = " [VSPLIT+ROW]"
            elif transform.is_vertical_split_fragment:
                suffix = " [VSPLIT]"
            elif transform.is_row_partition:
                suffix = " [ROW_PARTITION]"
            print(f"    {lt_name} <- {transform.source_table}{suffix}")

    # ─── Save global artifacts ───
    print("\n\nSaving global artifacts...")
    global_dir = os.path.join(output_dir, "global")
    os.makedirs(global_dir, exist_ok=True)

    # Original schema DDL
    original_ddl = extract_original_ddl(db_path)
    with open(os.path.join(global_dir, "original_schema.sql"), "w") as f:
        f.write(original_ddl)

    # Original queries
    with open(os.path.join(global_dir, "original_queries.sql"), "w") as f:
        for q in queries:
            f.write(q + ";\n\n")

    # Original queries with metadata (JSON)
    with open(os.path.join(global_dir, "original_queries.json"), "w") as f:
        json.dump(
            [{"sql": q, **m} for q, m in zip(queries, query_metadata)],
            f, indent=2,
        )

    # ─── Task 5: Materialize locals ───
    print("\nTask 5: Materializing local databases...")
    locals_dir = os.path.join(output_dir, "locals")
    expected_sqlites = [
        os.path.join(locals_dir, f"{local.local_name}.sqlite") for local in locals_list
    ]
    expected_ddls = [
        os.path.join(locals_dir, f"{local.local_name}_schema.sql") for local in locals_list
    ]
    if all(os.path.isfile(p) for p in expected_sqlites) and all(os.path.isfile(p) for p in expected_ddls):
        print("  Reusing existing locals (skip rematerialization).")
        local_paths = {local.local_name: os.path.join(locals_dir, f"{local.local_name}.sqlite") for local in locals_list}
    else:
        local_paths = materialize_locals(
            schema_graph, locals_list, db_path, output_dir, transform_spec
        )

    # ─── Save mappings ───
    print("\nSaving mappings...")
    mappings_dir = os.path.join(output_dir, "mappings")
    os.makedirs(mappings_dir, exist_ok=True)

    spec_dict = transform_spec_to_dict(transform_spec)
    spec_dict["global_schema"] = schema_to_dict(schema_graph)

    with open(os.path.join(mappings_dir, "transform_spec.json"), "w") as f:
        json.dump(spec_dict, f, indent=2)

    with open(os.path.join(mappings_dir, "rename_map.json"), "w") as f:
        json.dump(spec_dict["rename_map"], f, indent=2)

    with open(os.path.join(mappings_dir, "split_map.json"), "w") as f:
        json.dump(spec_dict["split_map"], f, indent=2)

    def _vsplit_overlap_summary(vsplit_entry: dict) -> list:
        """
        Produce a friendlier overlap summary from column_clustering.overlap_columns.
        Each record maps the overlapping original column to fragment suffixes.
        """
        if not isinstance(vsplit_entry, dict):
            return []
        clustering = (vsplit_entry.get("column_clustering") or {}) if vsplit_entry else {}
        overlaps = clustering.get("overlap_columns") or []
        fragments = vsplit_entry.get("fragments") or []
        # fragment order matches build_vertical_split_fragments / apply_transforms ordering
        idx_to_suffix = {}
        for i, f in enumerate(fragments):
            if isinstance(f, dict) and "suffix" in f:
                idx_to_suffix[i] = f.get("suffix")

        out = []
        if not isinstance(overlaps, list):
            return out
        for rec in overlaps:
            if not isinstance(rec, dict):
                continue
            col = rec.get("column")
            src_i = rec.get("primary_fragment_index")
            dst_i = rec.get("also_in_fragment_index")
            out.append(
                {
                    "column": col,
                    "primary_fragment_index": src_i,
                    "also_in_fragment_index": dst_i,
                    "primary_fragment_suffix": idx_to_suffix.get(src_i),
                    "also_in_fragment_suffix": idx_to_suffix.get(dst_i),
                }
            )
        return out

    per_table_payload = {}
    for orig, entry in spec_dict.get("vertical_split_map", {}).items():
        if not isinstance(entry, dict):
            continue
        per_table_payload[orig] = {
            "pk_columns": entry.get("pk_columns") or [],
            "fragments": entry.get("fragments") or [],
            "column_clustering": entry.get("column_clustering") or {},
            "overlap_summary": _vsplit_overlap_summary(entry),
        }

    clustering_payload = {
        "vertical_split_selection": spec_dict.get("vertical_split_selection", {}),
        "per_table": per_table_payload,
    }
    with open(
        os.path.join(mappings_dir, "vertical_split_clustering.json"), "w"
    ) as f:
        json.dump(clustering_payload, f, indent=2)

    with open(os.path.join(mappings_dir, "fk_map.json"), "w") as f:
        json.dump(spec_dict["fk_map"], f, indent=2)

    # Save relocations separately for easy inspection
    with open(os.path.join(mappings_dir, "relocations.json"), "w") as f:
        json.dump(spec_dict.get("relocations", []), f, indent=2)

    # ─── Task 6: Reconstruction ───
    print("\nTask 6: Generating reconstruction artifacts...")
    recon_db_path = materialize_reconstruction(
        schema_graph, locals_list, transform_spec, output_dir, db_path
    )

    inferred_mode = (
        inferred_keys_validation_mode
        or getattr(config, "inferred_keys_validation_mode", "inline")
        or "inline"
    )
    run_validation_effective = bool(run_validation) or (
        inferred_keys_used and str(inferred_mode).lower() == "inline"
    )

    validation_status = "not_run"
    data_ok = None
    if run_validation_effective:
        # ─── Task 7: Validate data equivalence (original vs reconstructed) ───
        print("\nTask 7: Validating data equivalence...")
        table_names = list(schema_graph.tables.keys())
        data_ok, data_report = validate_data_equivalence(
            db_path, recon_db_path, table_names, output_dir
        )

        print(f"  Data equivalence: {'PASS' if data_ok else 'FAIL'}")
        print(f"  Tables checked: {data_report['summary']['total_tables']}")
        print(f"  Passed: {data_report['summary']['passed']}")
        print(f"  Failed: {data_report['summary']['failed']}")

        if not data_ok:
            print("\n  FAILED TABLES:")
            for tname, treport in data_report["tables"].items():
                if treport["status"] != "PASS":
                    print(f"    {tname}: {treport['status']}")
                    for check_name, check_val in treport.get("checks", {}).items():
                        if isinstance(check_val, dict) and not check_val.get("pass", True):
                            print(f"      {check_name}: {check_val.get('error', 'FAIL')}")

        validation_status = "completed"
    else:
        print("\nTask 7: Validating data equivalence... SKIP")

    # ─── Task 9: Classify & rewrite queries for local schemas ───
    # Not used in the current paper; keep as opt-in to avoid OOM on large workloads.
    query_rewrite_stats = {"skipped": True}
    if bool(enable_query_rewrite):
        print("\nTask 9: Classifying and rewriting queries for local schemas...")
        query_rewrite_stats = classify_and_rewrite_queries(
            queries=queries,
            query_metadata=query_metadata,
            locals_list=locals_list,
            transform_spec=transform_spec,
            schema_graph=schema_graph,
            original_db_path=db_path,
            output_dir=output_dir,
            validate=True,
        )
        # Note: Validation stats are already printed by classify_and_rewrite_queries
    else:
        print("\nTask 9: Classifying and rewriting queries for local schemas... SKIP")

    # ─── Task 10: Save metadata ───
    print("\nSaving metadata...")
    actual_cut_ratio = compute_cut_ratio(groups, schema_graph)

    metadata = {
        "database": os.path.basename(db_path),
        "original_db_path": os.path.abspath(db_path),
        "num_tables": schema_graph.num_tables,
        "num_fk_edges": schema_graph.num_edges,
        "num_locals": len(locals_list),
        "num_queries": len(queries),
        "difficulty": difficulty,
        "seed": seed,
        "actual_cut_ratio": actual_cut_ratio,
        "validation_status": validation_status,
        "data_equivalence_passed": data_ok,
        "partition_method": partition_method,
        "has_table_classifications": classifications is not None,
        "difficulty_config": {
            "rename_rate": config.rename_rate,
            "split_rate": config.split_rate,
            "vertical_split_max_fragments": getattr(
                config, "vertical_split_max_fragments", 4
            ),
            # Prefer the *resolved* path that the vertical splitter actually used
            # (e.g., default: beside db_path) instead of the raw config field,
            # which may remain None.
            "column_semantic_enrichment_path": (
                (transform_spec.vertical_split_selection or {}).get(
                    "column_semantic_enrichment_path_resolved"
                )
                or getattr(config, "column_semantic_enrichment_path", None)
            ),
            "vertical_split_overlap_fraction": getattr(
                config, "vertical_split_overlap_fraction", 0.15
            ),
            "vertical_split_embedding_model": getattr(
                config,
                "vertical_split_embedding_model",
                "BAAI/bge-small-en-v1.5",
            ),
            "row_partition_rate": config.row_partition_rate,
            "fragment_relocation_fraction": getattr(
                config, "fragment_relocation_fraction", 0.5
            ),
            "afd_min_strength": getattr(config, "afd_min_strength", 0.7),
            "afd_max_sample_rows": getattr(config, "afd_max_sample_rows", 20000),
            "hf_max_num_fragments": getattr(config, "hf_max_num_fragments", 10),
            "hf_numeric_default_fragments": getattr(
                config, "hf_numeric_default_fragments", 4
            ),
            "row_partition_overlap_fraction": getattr(
                config, "row_partition_overlap_fraction", 0.12
            ),
            "fk_preserve_rate_intra_local": getattr(config, "fk_preserve_rate_intra_local", 0.95),
            "fk_preserve_rate_cross_local": getattr(config, "fk_preserve_rate_cross_local", 0.0),
            "use_llm_naming": config.use_llm_naming,
            "naming_case_randomize": getattr(config, "naming_case_randomize", True),
            "naming_case_force_style": getattr(config, "naming_case_force_style", None),
            "inferred_keys_validation_mode": getattr(config, "inferred_keys_validation_mode", "inline"),
        },
        "graph_stats": {
            "hub_tables": schema_graph.hub_tables,
            "connected_components": schema_graph.connected_components,
        },
        "partition_summary": [
            {
                "local": f"local_{i+1}",
                "tables": sorted(g),
                "cohesion": compute_cohesion(g, schema_graph),
            }
            for i, g in enumerate(groups)
        ],
        "partition_balance_audit": {
            "method": "connectivity_vs_combined",
            "event_count": len((balance_audit or {}).get("events", [])),
            "events": (balance_audit or {}).get("events", []),
        },
        "partition_rebalance_audit": {
            "description": (
                "Tables moved in post-partition rebalancing (fix undersized locals by "
                "donating one table from the largest other group; up to 3 passes)."
            ),
            "move_count": len((rebalance_audit or {}).get("moves", [])),
            "moves": (rebalance_audit or {}).get("moves", []),
        },
        "horizontal_fragmentation_audit": _build_horizontal_fragmentation_audit(
            transform_spec, config
        ),
        "key_inference": {
            "used_inferred_keys": bool(inferred_keys_used),
            "triggered_on_missing_declared_constraints": bool(no_declared_pk and no_declared_fk),
            "validation_mode_for_inferred_keys": str(inferred_mode).lower(),
            "forced_inline_validation": bool(
                inferred_keys_used and str(inferred_mode).lower() == "inline" and not run_validation
            ),
            "inference_audit": inferred_keys_audit,
        },
        "query_rewrite_stats": query_rewrite_stats,
        "timestamp": datetime.now().isoformat(),
        "version": "2.1.0",
    }

    with open(os.path.join(output_dir, "metadata.json"), "w") as f:
        json.dump(metadata, f, indent=2)

    elapsed = time.time() - start_time
    print(f"\n{'=' * 70}")
    print(f"Benchmark instance generated in {elapsed:.1f}s")
    print(f"Output: {output_dir}")
    if run_validation_effective:
        print(f"Data equivalence: {'PASS' if data_ok else 'FAIL'}")
    else:
        print("Validation: SKIPPED (run `python3 -m benchmark validate_instance` later)")

    print("\n\n")
    # solve_results/<model>/ is created only by llm_solve_eval solve, not by generate_instance.
    print(
        "Next step (creates solve_results/<model>/ under the instance): "
        "from Code/ (cd Code):\n"
        f"  python3 -m llm_solve_eval solve --instance_dir {output_dir} --model gpt-5.4-mini\n"
        "Then evaluate:\n"
        f"  python3 -m llm_solve_eval evaluate_solve --instance_dir {output_dir} \\\n"
        f"    --solve_dir {output_dir}/solve_results/gpt-5.4-mini"
    )

    print(f"{'=' * 70}")



    if run_validation_effective:
        return bool(data_ok)
    return True


def validate_instance(instance_dir: str) -> bool:
    """Re-validate data equivalence (original vs reconstructed.sqlite)."""
    return validate_data_instance(instance_dir, validation_status="completed")


def validate_data_instance(
    instance_dir: str, *, validation_status: str = "data_only"
) -> bool:
    """Validate data equivalence for an existing instance (no query-level checks)."""
    print(f"Validating data equivalence: {instance_dir}")

    meta_path = os.path.join(instance_dir, "metadata.json")
    metadata: Dict = {}
    had_meta = os.path.isfile(meta_path)
    if had_meta:
        with open(meta_path) as f:
            metadata = json.load(f)

    def _resolve_original_db_path(raw_path: str) -> str:
        if raw_path and os.path.isfile(raw_path):
            return raw_path
        p = (raw_path or "")
        marker = "/data-integration/"
        if marker not in p:
            return raw_path
        rel = p.rsplit(marker, 1)[1]
        if rel.startswith("data-integration/"):
            rel = rel[len("data-integration/") :]
        inst_abs = os.path.abspath(instance_dir)
        if f"{os.sep}SchemaVerse{os.sep}" in inst_abs:
            repo_root = inst_abs.split(f"{os.sep}SchemaVerse{os.sep}", 1)[0]
        else:
            repo_root = os.path.abspath(os.path.join(inst_abs, os.pardir, os.pardir))
        cand = os.path.join(repo_root, rel)
        return cand if os.path.isfile(cand) else raw_path

    raw_meta = (metadata.get("original_db_path") or "") if isinstance(metadata, dict) else ""
    original_db = _resolve_original_db_path(raw_meta)
    if not original_db or not os.path.isfile(original_db):
        inferred = infer_original_db_path_from_instance(instance_dir)
        if inferred:
            original_db = _resolve_original_db_path(inferred)
    if not original_db or not os.path.isfile(original_db):
        raise FileNotFoundError(
            f"Could not resolve original SQLite for {instance_dir!r} "
            f"(metadata and transform_spec enrichment path both failed)."
        )
    recon_db = os.path.join(instance_dir, "reconstruction", "reconstructed.sqlite")

    schema_graph = parse_schema(original_db)
    table_names = list(schema_graph.tables.keys())

    print("\nValidating data equivalence...")
    data_ok, _data_report = validate_data_equivalence(
        original_db, recon_db, table_names, instance_dir
    )
    print(f"  Result: {'PASS' if data_ok else 'FAIL'}")

    if had_meta:
        try:
            metadata["validation_status"] = validation_status
            metadata["data_equivalence_passed"] = bool(data_ok)
            metadata.pop("query_equivalence_passed", None)
            metadata.pop("query_pass_rate", None)
            with open(meta_path, "w") as f:
                json.dump(metadata, f, indent=2)
        except Exception:
            pass

    return bool(data_ok)


def reconstruct_instance(instance_dir: str) -> bool:
    """Rebuild reconstructed.sqlite from saved transform_spec.json (no local re-materialization)."""
    print(f"Reconstructing instance: {instance_dir}")
    meta_path = os.path.join(instance_dir, "metadata.json")
    metadata: Dict = {}
    if os.path.isfile(meta_path):
        with open(meta_path) as f:
            metadata = json.load(f)

    def _resolve_original_db_path(raw_path: str) -> str:
        if raw_path and os.path.isfile(raw_path):
            return raw_path
        p = (raw_path or "")
        marker = "/data-integration/"
        if marker not in p:
            return raw_path
        rel = p.rsplit(marker, 1)[1]
        if rel.startswith("data-integration/"):
            rel = rel[len("data-integration/") :]
        inst_abs = os.path.abspath(instance_dir)
        if f"{os.sep}SchemaVerse{os.sep}" in inst_abs:
            repo_root = inst_abs.split(f"{os.sep}SchemaVerse{os.sep}", 1)[0]
        else:
            repo_root = os.path.abspath(os.path.join(inst_abs, os.pardir, os.pardir))
        cand = os.path.join(repo_root, rel)
        return cand if os.path.isfile(cand) else raw_path

    raw_meta = (metadata.get("original_db_path") or "") if isinstance(metadata, dict) else ""
    original_db = _resolve_original_db_path(raw_meta)
    if not original_db or not os.path.isfile(original_db):
        inferred = infer_original_db_path_from_instance(instance_dir)
        if inferred:
            original_db = _resolve_original_db_path(inferred)
    if not original_db or not os.path.isfile(original_db):
        raise FileNotFoundError(
            f"Could not resolve original SQLite for {instance_dir!r} "
            f"(metadata and transform_spec enrichment path both failed)."
        )
    spec_path = os.path.join(instance_dir, "mappings", "transform_spec.json")
    with open(spec_path) as f:
        spec_dict = json.load(f)

    transform_spec = transform_spec_from_dict(spec_dict)
    locals_list = transform_spec.locals
    schema_graph = parse_schema(original_db)

    from reconstruct import materialize_reconstruction  # noqa: WPS433

    materialize_reconstruction(schema_graph, locals_list, transform_spec, instance_dir, original_db)
    return True


def repair_instance(instance_dir: str) -> bool:
    """
    Re-materialize locals + reconstructed.sqlite from saved transform_spec.json,
    then re-run validation.
    """
    print(f"Repairing instance: {instance_dir}")
    meta_path = os.path.join(instance_dir, "metadata.json")
    metadata: Dict = {}
    if os.path.isfile(meta_path):
        with open(meta_path) as f:
            metadata = json.load(f)

    def _resolve_original_db_path(raw_path: str) -> str:
        if raw_path and os.path.isfile(raw_path):
            return raw_path
        p = (raw_path or "")
        marker = "/data-integration/"
        if marker not in p:
            return raw_path
        rel = p.rsplit(marker, 1)[1]
        if rel.startswith("data-integration/"):
            rel = rel[len("data-integration/") :]
        inst_abs = os.path.abspath(instance_dir)
        if f"{os.sep}SchemaVerse{os.sep}" in inst_abs:
            repo_root = inst_abs.split(f"{os.sep}SchemaVerse{os.sep}", 1)[0]
        else:
            repo_root = os.path.abspath(os.path.join(inst_abs, os.pardir, os.pardir))
        cand = os.path.join(repo_root, rel)
        return cand if os.path.isfile(cand) else raw_path

    raw_meta = (metadata.get("original_db_path") or "") if isinstance(metadata, dict) else ""
    original_db = _resolve_original_db_path(raw_meta)
    if not original_db or not os.path.isfile(original_db):
        inferred = infer_original_db_path_from_instance(instance_dir)
        if inferred:
            original_db = _resolve_original_db_path(inferred)
    if not original_db or not os.path.isfile(original_db):
        raise FileNotFoundError(
            f"Could not resolve original SQLite for {instance_dir!r} "
            f"(metadata and transform_spec enrichment path both failed)."
        )
    spec_path = os.path.join(instance_dir, "mappings", "transform_spec.json")
    with open(spec_path) as f:
        spec_dict = json.load(f)

    transform_spec = transform_spec_from_dict(spec_dict)
    locals_list = transform_spec.locals

    # Build schema graph (no heavy deps required)
    schema_graph = parse_schema(original_db)

    # Lazy imports: these can pull in optional deps in some environments
    from materialize_locals import materialize_locals  # noqa: WPS433
    from reconstruct import materialize_reconstruction  # noqa: WPS433

    print("\nRepair: Materializing locals...")
    materialize_locals(schema_graph, locals_list, original_db, instance_dir, transform_spec)

    print("\nRepair: Reconstructing...")
    materialize_reconstruction(schema_graph, locals_list, transform_spec, instance_dir, original_db)

    print("\nRepair: Re-validating...")
    return bool(validate_instance(instance_dir))


def main():
    parser = argparse.ArgumentParser(
        description=(
            "SchemaVerse instance generator (construction + validation). "
            "Run from Code/ with: python3 -m benchmark <subcommand> …"
        )
    )
    subparsers = parser.add_subparsers(dest="command", help="Command to run")

    # ── generate_instance ──
    gen_parser = subparsers.add_parser(
        "generate_instance", help="Generate a benchmark instance"
    )
    gen_parser.add_argument(
        "--corpus",
        choices=["bird", "spider2"],
        default="bird",
        help="Source corpus when using --db_name (default: bird).",
    )
    gen_parser.add_argument(
        "--db_name",
        default=None,
        help=(
            "Database folder name. BIRD: <bird_root>/<bird_databases_subdir>/<name>/…; "
            "Spider2: <spider2_root>/<name>/<name>.sqlite (see --corpus)."
        ),
    )
    gen_parser.add_argument(
        "--spider2_root",
        default=None,
        help="Spider2 tree root when --corpus spider2 (default: <Code>/data/Spider2)",
    )
    gen_parser.add_argument(
        "--bird_root",
        default=data_bird_root(),
        help="BIRD tree root when using --db_name (default: <Code>/data/BIRD)",
    )
    gen_parser.add_argument(
        "--bird_databases_subdir",
        default="dev_databases",
        help=(
            "Subfolder under --bird_root with per-database directories "
            "(default: dev_databases; use train_databases for the train split)"
        ),
    )
    gen_parser.add_argument(
        "--db_path",
        default=None,
        help="Path to SQLite database (use with --queries_path if not using --db_name)",
    )
    gen_parser.add_argument(
        "--queries_path",
        default=None,
        help="Path to queries JSON (use with --db_path if not using --db_name)",
    )
    gen_parser.add_argument(
        "--output_dir",
        default=None,
        help=(
            "Output directory (default with --db_name: output/<name>_benchmark; "
            "required with --db_path/--queries_path)"
        ),
    )
    gen_parser.add_argument("--seed", type=int, default=42, help="Random seed")
    gen_parser.add_argument(
        "--difficulty", choices=["easy", "medium", "hard", "extra_hard"], default="extra_hard",
        help="Difficulty preset"
    )
    llm_group = gen_parser.add_mutually_exclusive_group()
    llm_group.add_argument(
        "--use_llm",
        dest="use_llm",
        action="store_true",
        help="Use LLM for naming drift (requires OPENAI_API_KEY or OPENAI_KEY)",
    )
    llm_group.add_argument(
        "--no-use_llm",
        dest="use_llm",
        action="store_false",
        help="Disable LLM naming drift (deterministic naming only)",
    )
    llm_group.set_defaults(use_llm=True)
    gen_parser.add_argument(
        "--classifications_dir",
        default=data_table_classifications_bird(),
        help=(
            "Directory with table classification JSON files "
            "(default: <Code>/data/table_classifications/BIRD)"
        ),
    )
    gen_parser.add_argument(
        "--enable_query_rewrite",
        action="store_true",
        default=False,
        help=(
            "Run Task 9 (classify + rewrite queries for local schemas). "
            "Off by default because it is not used in the paper and can be memory-heavy."
        ),
    )
    gen_parser.add_argument(
        "--run_validation",
        action="store_true",
        default=False,
        help=(
            "Run data equivalence validation immediately after generation "
            "(original vs reconstructed.sqlite). Disabled by default."
        ),
    )
    gen_parser.add_argument(
        "--inferred_keys_validation_mode",
        choices=["inline", "deferred"],
        default=None,
        help=(
            "Validation policy for schemas where PK/FK were inferred. "
            "'inline' forces validation during generation; 'deferred' keeps decoupled flow."
        ),
    )

    # ── validate_instance ──
    val_parser = subparsers.add_parser(
        "validate_instance",
        help="Validate data equivalence for an existing instance (same checks as validate_data_instance)",
    )
    val_parser.add_argument("--instance_dir", required=True, help="Instance directory")

    # ── validate_data_instance ──
    vald_parser = subparsers.add_parser(
        "validate_data_instance", help="Validate data equivalence only"
    )
    vald_parser.add_argument("--instance_dir", required=True, help="Instance directory")

    # ── reconstruct_instance ──
    rec_parser = subparsers.add_parser(
        "reconstruct_instance", help="Rebuild reconstructed.sqlite only"
    )
    rec_parser.add_argument("--instance_dir", required=True, help="Instance directory")

    # ── repair_instance ──
    rep_parser = subparsers.add_parser(
        "repair_instance",
        help="Re-materialize locals + reconstruction from saved transform_spec.json",
    )
    rep_parser.add_argument("--instance_dir", required=True, help="Instance directory")

    args = parser.parse_args()

    if args.command == "generate_instance":
        if args.db_name and (args.db_path or args.queries_path):
            gen_parser.error(
                "Use either --db_name or both --db_path and --queries_path, not both."
            )
        if args.db_name:
            if args.corpus == "spider2":
                db_path, queries_path = spider2_instance_paths(
                    args.db_name,
                    args.spider2_root or data_spider2_root(),
                )
            else:
                db_path, queries_path = bird_instance_paths(
                    args.db_name, args.bird_root, args.bird_databases_subdir
                )
        elif args.db_path and args.queries_path:
            db_path, queries_path = args.db_path, args.queries_path
        else:
            gen_parser.error(
                "Provide --db_name, or both --db_path and --queries_path."
            )

        if args.output_dir is not None:
            output_dir = args.output_dir
        elif args.db_name:
            output_dir = default_benchmark_output_dir(args.db_name)
        else:
            gen_parser.error(
                "--output_dir is required when using --db_path and --queries_path."
            )

        classifications_dir = args.classifications_dir
        if args.db_name and args.corpus == "spider2" and classifications_dir == data_table_classifications_bird():
            classifications_dir = data_table_classifications_subdir("Spider2")

        success = generate_instance(
            db_path=db_path,
            queries_path=queries_path,
            output_dir=output_dir,
            difficulty=args.difficulty,
            seed=args.seed,
            use_llm=args.use_llm,
            classifications_dir=classifications_dir,
            enable_query_rewrite=args.enable_query_rewrite,
            run_validation=args.run_validation,
            inferred_keys_validation_mode=args.inferred_keys_validation_mode,
        )
        sys.exit(0 if success else 1)

    elif args.command == "validate_instance":
        success = validate_instance(args.instance_dir)
        sys.exit(0 if success else 1)

    elif args.command == "validate_data_instance":
        success = validate_data_instance(args.instance_dir)
        sys.exit(0 if success else 1)

    elif args.command == "reconstruct_instance":
        success = reconstruct_instance(args.instance_dir)
        sys.exit(0 if success else 1)

    elif args.command == "repair_instance":
        success = repair_instance(args.instance_dir)
        sys.exit(0 if success else 1)

    else:
        parser.print_help()
        sys.exit(1)


if __name__ == "__main__":
    main()
