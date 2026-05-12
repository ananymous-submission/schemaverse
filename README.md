# SchemaVerse

**SchemaVerse** is a benchmark for **global schema construction from fragmented local schemas**: systems must infer how several autonomous **local** database schemas fit together and express a coherent **global** view—typically as **GAV** (`CREATE VIEW`) rules over locals—such that data and workload behavior align with a hidden **original** database from which the locals were derived.

This file is the **main project overview**. The tree is organized into `**Dataset/`** (benchmark material and dataset documentation) and `**Code/**` (generators, enrichment, solve, and evaluation).


| Part        | What it is                                                                                                                                                              | Read more                                      |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| **Dataset** | Benchmark **instances** and evaluation artifacts: multi-local SQLite layouts, mappings, global schema and queries, and difficulty tiers (as released under `Dataset/`). | `**[Dataset/DATASET.md](Dataset/DATASET.md)`** |
| **Code**    | Programs that **build** instances from BIRD / Spider2 / Beaver / ScienceBenchmark, LLM enrichment, **GAV solve**, and **evaluation**.                                   | `**[Code/CODE.md](Code/CODE.md)`**             |


---

## Description

SchemaVerse **synthesizes controlled schema-integration scenarios** by:

1. Taking a **source** relational benchmark (DB + annotated SQL).
2. **Partitioning** the schema into multiple **locals** (notional separate data sources).
3. Applying **structural and lexical transformations**.
4. Emitting **ground-truth mappings** so instances are **auditable** and **evaluable** (data equivalence) and LLM-focused metrics such as compile rate, attribute provenance, and data correctness.

Together, the **Dataset** and **Code** support research on schema integration, federated/global view learning, and LLM evaluation under realistic fragmentation.

---

## Source datasets

SchemaVerse is **derived from** publicly available datasets:

- **BIRD**  
- **Spider2**  
- **Beaver**  
- **ScienceBenchmark**

We follow the **licenses and terms of use** of the original datasets.

---

## License

Materials in this distribution are released **subject to the licenses of the original datasets** and to any license file(s) shipped with this project, where applicable.

---

## Intended use

This benchmark is intended for **research** in schema integration, data management under fragmentation, and evaluation of **language models** on non-trivial integration structure.

---

## Contact

Anonymous submission.

---

## Quick navigation


| Document                                       | Contents                                                  |
| ---------------------------------------------- | --------------------------------------------------------- |
| `**[Dataset/DATASET.md](Dataset/DATASET.md)`** | What is under `Dataset/`, sources, license, intended use. |
| `**[Code/CODE.md](Code/CODE.md)**`             | Package layout, dependencies, evaluation vs generation.   |


