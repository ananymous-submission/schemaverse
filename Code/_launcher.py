from __future__ import annotations

import importlib.util
import sys
from pathlib import Path
from types import ModuleType

CODE_ROOT = Path(__file__).resolve().parent


def load_step_module(step_dir: str, module_filename: str, *, register_name: str | None = None) -> ModuleType:
    step_path = CODE_ROOT / step_dir
    file_path = step_path / module_filename
    if not file_path.is_file():
        raise FileNotFoundError(f"Missing step module: {file_path}")

    mod_name = register_name or f"_schemaverse_{step_dir.replace('/', '_')}_{file_path.stem}"
    step_str = str(step_path)
    if step_str not in sys.path:
        sys.path.insert(0, step_str)

    spec = importlib.util.spec_from_file_location(mod_name, file_path)
    if spec is None or spec.loader is None:
        raise ImportError(f"Cannot load module spec for {file_path}")
    mod = importlib.util.module_from_spec(spec)
    sys.modules[mod_name] = mod
    spec.loader.exec_module(mod)
    return mod
