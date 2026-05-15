# SchemaVerse — Code

Programs that **build** SchemaVerse instances, **enrich** inputs, **solve** with LLMs, and **evaluate** solutions.

---

## Working directory

**Change into `Code/` before running anything:**

```text
cd Code
```

All commands below assume your shell’s **current working directory is `Code/`**. Paths are relative to that folder (for example `data/BIRD/...`, `runs/instances/...`).

**Entry points** live at the top of `Code/` (`classify_sqlite_db.py`, `column_enrichment.py`, `benchmark.py`, `llm_solve_eval.py`). Run them with:

```text
python3 -m <module> ...
```


| Step                             | Module               | Example                                         |
| -------------------------------- | -------------------- | ----------------------------------------------- |
| 1 — table roles                  | `classify_sqlite_db` | `python3 -m classify_sqlite_db --help`          |
| 2 — column semantics             | `column_enrichment`  | `python3 -m column_enrichment --help`           |
| 3 — generate / validate instance | `benchmark`          | `python3 -m benchmark generate_instance --help` |
| 4 — GAV solve / evaluate         | `llm_solve_eval`     | `python3 -m llm_solve_eval --help`              |


Implementation code for each step remains under `01_entity_assignment/`, `02_column_enrichment/`, `03_benchmark_construction/`, and `04_llm_solve_eval/`.

---

## Python and dependencies

**Python version:** **3.11 or newer** (developed and tested with **3.11.4** in the project).

**Install dependencies** (from `Code/`):

```text
python3 -m venv .venv
source .venv/bin/activate
pip install -U pip
pip install -r requirements.txt
```

**API keys (required for real LLM runs).** Steps **01** and **02** try **OpenAI** first (`gpt-5-mini` by default) when `OPENAI_API_KEY` or `OPENAI_KEY` is set, then **Gemini** (`GEMINI_API_KEY` / `GOOGLE_API_KEY`). At least one provider is required for steps **01–02**. Step **03** uses OpenAI for naming unless you pass `--no-use_llm`. Step **04** needs `OPENAI_API_KEY` or `OPENAI_KEY`.

---

## Exact commands (`california_schools`, BIRD dev)

Activate your venv (see above), export API keys, then:

```text
cd Code
```

**1 — Table classification** — default output is `data/table_classifications/BIRD/<schema_name>.json`:

```text
python3 -m classify_sqlite_db \
  --db_path data/BIRD/dev_databases/california_schools/california_schools.sqlite \
  --schema_name california_schools \
  --bird-shape
```

**2 — Column enrichment** — writes `column_semantic_enrichment.json` next to the SQLite:

```text
python3 -m column_enrichment \
  --bird-root data/BIRD \
  --db california_schools
```

**3 — Generate instance**:

```text
python3 -m benchmark generate_instance \
  --db_name california_schools \
  --bird_root data/BIRD \
  --output_dir runs/instances/california_schools_benchmark \
  --difficulty extra_hard \
  --seed 42
```

Add `**--no-use_llm**` for deterministic naming without OpenAI on this step.

**4 — Solve + evaluate**:

```text
python3 -m llm_solve_eval solve \
  --instance_dir runs/instances/california_schools_benchmark \
  --model gpt-5.4-mini

python3 -m llm_solve_eval evaluate_solve \
  --instance_dir runs/instances/california_schools_benchmark \
  --solve_dir runs/instances/california_schools_benchmark/solve_results/gpt-5.4-mini
```

Optional scripted run (still starts from `Code/` internally): `python3 scripts/run_e2e_california_schools.sh`

---

## Layout


| Path                                                          | Purpose                                          |
| ------------------------------------------------------------- | ------------------------------------------------ |
| `**classify_sqlite_db.py**` (and `**01_entity_assignment/**`) | Step **01** — table role assignment              |
| `**column_enrichment.py`** (and `**02_column_enrichment/`**)  | Step **02** — column semantic enrichment         |
| `**benchmark.py`** (and `**03_benchmark_construction/`**)     | Step **03** — instance generation and validation |
| `**llm_solve_eval.py`** (and `**04_llm_solve_eval/`**)        | Step **04** — GAV solve and evaluation           |
| `data/` | Corpus inputs; step **01** → `data/table_classifications/`; step **02** enrichment beside each `.sqlite` |
| `data/table_classifications/` | Step **01** table-role JSON (`BIRD/`, `Spider2/`, …) |
| `runs/`                                                       | Recommended output root for generated instances  |
| `requirements.txt`                                            | Minimum dependency versions (Python **3.11+**)   |
| `requirements-env_gcc14.txt`                                  | Exact pins from project `ENV_gcc14`              |


---

## BIRD corpus under `data/BIRD/`

```
data/BIRD/
├── dev_databases/
│   └── <db_name>/
│       ├── <db_name>.sqlite
│       ├── dev.json
│       └── column_semantic_enrichment.json   # step 02
└── train_databases/
    └── …

data/table_classifications/BIRD/
  <db_name>.json              # step 01 (default; use --corpus bird)
  <db_name>.full.json           # with --bird-shape
  <db_name>_schema.sql          # with --bird-shape
```

If `**california_schools.sqlite**` is missing:

```text
python3 scripts/ensure_bird_california_schools_sqlite.py
```

(run from `**Code/**`)

---

## Spider2 corpus under `data/Spider2/`

Example `**AdventureWorks**`:

```
data/Spider2/AdventureWorks/
  AdventureWorks.sqlite
  database_description/*.json
  column_semantic_enrichment.json   # step 02

data/table_classifications/Spider2/
  AdventureWorks.json               # step 01 (default)
```

From `Code/`:

```text
python3 -m classify_sqlite_db \
  --db_path data/Spider2/AdventureWorks/AdventureWorks.sqlite \
  --schema_name AdventureWorks \
  --corpus spider2

python3 -m column_enrichment \
  --corpus spider2 \
  --spider2-root data/Spider2 \
  --db AdventureWorks

python3 -m benchmark generate_instance \
  --corpus spider2 \
  --db_name AdventureWorks \
  --spider2_root data/Spider2 \
  --output_dir runs/instances/AdventureWorks_benchmark \
  --difficulty extra_hard \
  --seed 42

python3 -m benchmark validate_instance \
  --instance_dir runs/instances/AdventureWorks_benchmark

python3 -m llm_solve_eval solve \
  --instance_dir runs/instances/AdventureWorks_benchmark \
  --model gpt-5.4-mini

python3 -m llm_solve_eval evaluate_solve \
  --instance_dir runs/instances/AdventureWorks_benchmark \
  --solve_dir runs/instances/AdventureWorks_benchmark/solve_results/gpt-5.4-mini
```

Batch (all DBs under `data/Spider2/` after steps 01–02): `python3 -m run_spider2_batch`

---

## Step outputs and chaining


| Step   | Reads                                                      | Writes                                                                 |
| ------ | ---------------------------------------------------------- | ---------------------------------------------------------------------- |
| **01** | `data/.../<db>.sqlite`                                     | `--out_dir` or default `data/table_classifications/<corpus>/<db>.json` |
| **02** | SQLite (+ Spider2 `database_description/` when applicable) | `column_semantic_enrichment.json` beside the `.sqlite`                 |
| **03** | SQLite, classifications, enrichment                        | Instance tree under `--output_dir`                                     |
| **04** | Instance                                                   | `solve_results/<model>/`                                               |


Default `**--output_dir`** for `generate_instance` is `output/<db>_benchmark` relative to `**Code/`** unless you pass e.g. `**runs/instances/<db>_benchmark`**.

---

## Evaluation vs generation

- **Generation and validation:** `python3 -m benchmark …`
- **LLM solve and evaluation:** `python3 -m llm_solve_eval …` (alias: `python3 -m cli`)

---

## Relationship to `Dataset/`

Generated instances should match the per-instance layout in `**[../Dataset/DATASET.md](../Dataset/DATASET.md)`** (`global/`, `locals/`, `mappings/`, `reconstruction/`, …).

---

← Overview: `[README.md](../README.md)` · Dataset: `[../Dataset/DATASET.md](../Dataset/DATASET.md)`