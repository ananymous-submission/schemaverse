from _launcher import load_step_module

if __name__ == "__main__":
    mod = load_step_module("02_column_enrichment", "run_beaver_profiles.py")
    raise SystemExit(mod.main())
