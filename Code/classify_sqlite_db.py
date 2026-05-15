from _launcher import load_step_module

if __name__ == "__main__":
    mod = load_step_module("01_entity_assignment", "classify_sqlite_db.py")
    raise SystemExit(mod.main())
