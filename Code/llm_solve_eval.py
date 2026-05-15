from _launcher import load_step_module

if __name__ == "__main__":
    mod = load_step_module("04_llm_solve_eval", "llm_solve_eval.py", register_name="_schemaverse_llm_solve_eval_cli")
    raise SystemExit(mod.main())
