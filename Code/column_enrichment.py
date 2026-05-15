from _launcher import load_step_module

if __name__ == "__main__":
    mod = load_step_module("02_column_enrichment", "column_enrichment.py")
    raise SystemExit(mod.main())
