from _launcher import load_step_module

if __name__ == "__main__":
    mod = load_step_module("03_benchmark_construction", "main.py", register_name="_schemaverse_benchmark_main")
    mod.main()
