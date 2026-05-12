# SchemaVerse — Dataset

This file is the **field guide** to what appears under `**Dataset/`**: how corpora are grouped, what a **single instance** directory contains, and what `**global/`**, `**locals/**`, `**mappings/**`, and `**reconstruction/**` are for. For benchmark motivation, difficulty presets, and the generation pipeline, see **[`../README.md`](../README.md)** and **[`../Code/CODE.md`](../Code/CODE.md)**. For license and intended use at the distribution level, see  **[`../README.md`](../README.md)**.

---

## How Dataset/ is organized

Paths are relative to **Dataset/**.


| Path                                                                               | Contents                                                                                                                                                           |
| ---------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **bird/**, **spider2/**, **beaver/**, **sciencebenchmark/**                | One subtree per upstream-style corpus. Under each, instances usually live under paths such as **train_databases/<instance_name>/** (exact names vary by corpus). |
| **evaluate_solve_*.json**, **evaluate_solve_batch_report.json** (when present) | Corpus- or batch-level **evaluation summaries** produced after running solvers; not part of a single instance’s folder tree.                                       |
| **DATASET.md**                                                                   | This document.                                                                                                                                                     |


Each **instance** is a directory (for example `bird/train_databases/world_benchmark/`) that holds the integration problem in a fixed **four-folder** shape plus optional checks.

---

## Instance directory tree (typical)

Below is a representative layout. File counts may vary (e.g. three locals vs four, SQLite files if your copy includes them).

```
<corpus>/…/<instance_name>/
├── global/
│   ├── original_schema.sql      # DDL of the unified “original” schema (ground-truth global view)
│   ├── original_queries.sql     # SQL workload over that schema (text)
│   └── original_queries.json    # Same workload in structured form (ids, SQL, metadata)
├── locals/
│   ├── local_1_schema.sql       # DDL for synthetic source 1 (what a model usually sees)
│   ├── local_2_schema.sql
│   ├── local_3_schema.sql
│   ├── …                        # local_K_schema.sql for K locals
│   ├── all_locals_schema.sql    # Concatenation / union of local DDLs for convenience
│   └── (optional) *.sqlite      # Per-local databases when the release includes binaries
├── mappings/
│   ├── transform_spec.json              # Master spec: splits, renames, seeds, enrichment paths, etc.
│   ├── rename_map.json                  # Identifier rename trace (original ↔ local names)
│   ├── split_map.json                   # Vertical / horizontal split structure linking fragments
│   ├── vertical_split_clustering.json   # Column clustering used for vertical fragmentation
│   ├── fk_map.json                      # Foreign-key alignment across locals / original
│   └── relocations.json                 # Which fragments moved to which local
├── reconstruction/
    └── reconstruct_original.sql         # Reference SQL tying locals back to the original (sanity / rebuild)

```

---

## `global/` — the hidden unified world

Everything here describes the **original** single-database world **before** fragmentation. Evaluators and humans use it as **ground truth**; a typical **solver prompt** only exposes **locals/** so the model must infer a global view.


| File                        | Role                                                                                              |
| --------------------------- | ------------------------------------------------------------------------------------------------- |
| **original_schema.sql**   | Full **CREATE TABLE** / view definitions and constraints for the unified schema.                  |
| **original_queries.sql**  | Benchmark **queries** expressed against that unified schema (plain SQL).                          |
| **original_queries.json** | Machine-readable query list (identifiers, SQL text, and any bundled annotations used by tooling). |


---

## `locals/` — what “sources” look like

Each `**local_*_schema.sql**` is the **DDL of one synthetic autonomous database** after partitioning and perturbation. Together they are **informationally related** to `**global/`**, but names, splits, and placement are intentionally messy.


| File                        | Role                                                                                                   |
| --------------------------- | ------------------------------------------------------------------------------------------------------ |
| `**local_i_schema.sql**`    | Schema for **local *i*** only—the primary artifact for **GAV**-style tasks (“write views over these”). |
| `**all_locals_schema.sql`** | Single file combining all local DDLs for batch tools or quick inspection.                              |
| `***.sqlite` / `*.db**`     | **Materialized** local databases, when shipped; some snapshots are **schema-only** and omit binaries.  |


---

## `mappings/` — ground truth between worlds

These JSON files encode **how** the generator moved from the original database to the locals. **Evaluation** (attribute provenance, tuple checks, reconstruction) reads them to score a proposed global schema.


| File                                 | Role                                                                                                                                                                                                                                  |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `**transform_spec.json`**            | **Authoritative** generation record: difficulty, RNG seeds, vertical/horizontal split choices, relocation, LLM naming hooks, paths to enrichment inputs, etc. Other mapping files are either summarized here or cross-linked from it. |
| `**rename_map.json`**                | Maps **original identifiers** to **fragment / local identifiers** after renaming and duplication.                                                                                                                                     |
| `**split_map.json`**                 | Describes **which columns / rows** live in which fragment after vertical or horizontal splits.                                                                                                                                        |
| `**vertical_split_clustering.json`** | Column groupings used when the schema is **cut vertically** across locals.                                                                                                                                                            |
| `**fk_map.json`**                    | How **foreign keys** were preserved, redirected, or split across locals.                                                                                                                                                              |
| `**relocations.json`**               | Which **table fragments** were **moved** to which local (cross-source integration stress).                                                                                                                                            |


---

## `reconstruction/` — reference bridge back to the original


| File                           | Role                                                                                                                                                                                                                                                                                                   |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `**reconstruct_original.sql`** | **Reference SQL** expressing how data and relations on locals relate to the original layout—useful for **validation**, debugging, and understanding the intended merge semantics. It is **not** what you hand to an LLM as the task statement; it documents the intended inverse of the fragmentation. |


---

## Navigating this release

- Pick a corpus (**bird/**, **spider2/**, …), then open **train_databases/<instance>/** (or the path your tree uses) and walk **global/ → locals/ → mappings/** in that order the first time you read an instance.
- For **regenerating** instances or changing difficulty, use **../Code/** as documented in **../README.md**.

---

← Project overview & pipeline: [`../README.md`](../README.md) · Code layout: [`../Code/CODE.md`](../Code/CODE.md)