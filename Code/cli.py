from _launcher import load_step_module

if __name__ == "__main__":
    mod = load_step_module("04_llm_solve_eval", "cli.py", register_name="_schemaverse_cli")
    raise SystemExit(mod.main())
