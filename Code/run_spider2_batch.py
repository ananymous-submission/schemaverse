from _launcher import load_step_module

if __name__ == "__main__":
    mod = load_step_module("03_benchmark_construction", "run_spider2_batch.py")
    raise SystemExit(mod.main())
