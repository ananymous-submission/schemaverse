from dataclasses import dataclass, field
from typing import Optional


@dataclass
class DifficultyConfig:
    """Parameters that control the difficulty of a benchmark instance."""
    # Fraction of identifiers to rename (0..1)
    rename_rate: float = 0.8
    # Fraction of tables to vertically fragment (column-split; JOIN on PK) (0..1)
    # Note: tables with >= 10 non-PK columns are always split regardless of rate
    split_rate: float = 0.3
    # Max fragments per vertically split table (>= 2)
    vertical_split_max_fragments: int = 5
    # Optional path to column_semantic_enrichment.json (default: beside db_path)
    column_semantic_enrichment_path: Optional[str] = None
    # Fraction of columns (by border score) duplicated into a second fragment
    vertical_split_overlap_fraction: float = 0.15
    # HuggingFace sentence-transformers model id (TF-IDF used if load/encode fails)
    vertical_split_embedding_model: str = "BAAI/bge-small-en-v1.5"
    # Fraction of tables to horizontally fragment (row partition; UNION ALL) (0..1)
    row_partition_rate: float = 0.15
    # Horizontal fragmentation: minimum rows on the original table
    min_rows_for_hfrag: int = 40
    # Each of the two partitions must hold at least this fraction of rows
    min_partition_ratio: float = 0.1
    # Exclude columns whose COUNT(DISTINCT)/COUNT(*) exceeds this (near-unique)
    max_column_uniqueness_ratio: float = 0.5
    # Exclude columns with too many NULLs
    max_column_null_ratio: float = 0.6
    # Optional: propagate parent row splits to FK children (not used by default)
    enable_derived_horizontal_fragmentation: bool = False
    # Preserve rate for FK constraints inside a local schema (0..1)
    fk_preserve_rate_intra_local: float = 0.95
    # Preserve rate for FK constraints across locals (0..1). Note: constraints are
    # never materialized cross-local, but this rate controls what is recorded/kept.
    fk_preserve_rate_cross_local: float = 0.0
    # Use LLM for naming drift
    use_llm_naming: bool = True
    # OpenAI model for naming
    llm_model: str = "gpt-5-mini"
    # Randomly select naming casing style per local (non-deterministic)
    naming_case_randomize: bool = True
    # Optional forced casing style (overrides random choice)
    naming_case_force_style: Optional[str] = None
    # Random seed
    seed: int = 42
    # Relocation budget fraction rho in:
    #   R = max(1, ceil(rho * F))
    # where F is the number of fragments for a fragmented logical table. The
    # realized move budget is then capped so at least the anchor fragment stays
    # pinned on the home local.
    fragment_relocation_fraction: float = 0.5
    # ── AFD-based horizontal fragmentation (HF) ──────────────────────────────
    # Approximate FD strength threshold (precision cutoff). A dependency
    # C -> A counts as "strong" when c(C->A) = 1 - g3(C->A) >= afd_min_strength.
    # This is the only strength knob for the scorer. Error threshold passed to
    # desbordante is (1 - afd_min_strength).
    afd_min_strength: float = 0.6
    # Row-count cost bound for AFD mining per table. Tables larger than this
    # are sampled deterministically; smaller tables use all rows.
    afd_max_sample_rows: int = 20000
    # Cap on the number of horizontal fragments (F) per table. F is distinct
    # from K (the number of locals chosen by partitioning).
    hf_max_num_fragments: int = 10
    # Default F for numeric / date-like predicate columns (quantile buckets).
    hf_numeric_default_fragments: int = 4
    # Per-fragment row-overlap band. Each fragment mirrors a fraction o in
    # [0, 1] of its rows into one neighbour fragment. Reconstruction switches
    # from UNION ALL to UNION when overlap > 0.
    row_partition_overlap_fraction: float = 0.15
    # Validation behavior when PK/FK are inferred for key-empty schemas.
    # - inline: force validation during generate_instance
    # - deferred: keep validation decoupled
    inferred_keys_validation_mode: str = "inline"


# Preset configurations
DIFFICULTY_PRESETS = {
    "easy": DifficultyConfig(
        rename_rate=0.8,
        split_rate=0.35,
        row_partition_rate=0.3,
        fragment_relocation_fraction=0.30,
        vertical_split_overlap_fraction=0.15,
        row_partition_overlap_fraction=0.15,
        fk_preserve_rate_intra_local=0.95,
        afd_min_strength=0.6,
        use_llm_naming=True,
    ),
    "medium": DifficultyConfig(
        rename_rate=1.0,
        split_rate=0.7,
        row_partition_rate=0.50,
        fragment_relocation_fraction=0.50,
        vertical_split_overlap_fraction=0.20,
        row_partition_overlap_fraction=0.20,
        fk_preserve_rate_intra_local=0.9,
        afd_min_strength=0.6,
        use_llm_naming=True,
    ),
    "hard": DifficultyConfig(
        rename_rate=1.0,
        split_rate=0.8,
        row_partition_rate=0.70,
        fragment_relocation_fraction=0.80,
        vertical_split_overlap_fraction=0.40,
        row_partition_overlap_fraction=0.40,
        fk_preserve_rate_intra_local=0.5,
        afd_min_strength=0.6,
        use_llm_naming=True,
    ),
}
