import json
import os
import re
import time
import urllib.error
import urllib.request
from typing import Any, Dict, List, Optional, Tuple
from datetime import datetime


# ──────────────────────────────────────────────
# Helpers
# ──────────────────────────────────────────────

def _is_gpt5_family_model(model: str) -> bool:
    """
    OpenAI's newer model families (GPT-5.x) use different chat.completions params.

    In particular, `max_tokens` is rejected in favor of `max_completion_tokens`.
    """
    m = (model or "").lower()
    return m.startswith("gpt-5") or m.startswith("gpt5")


def _is_deepseek_model(model: str) -> bool:
    m = (model or "").lower()
    return m.startswith("deepseek-") or m.startswith("deepseek/")


def _is_gemini_model(model: str) -> bool:
    m = (model or "").lower()
    return m.startswith("gemini-") or m.startswith("gemini/")


def _is_claude_model(model: str) -> bool:
    """Anthropic Claude (Messages API), e.g. claude-opus-4-6 or anthropic:claude-sonnet-4-6."""
    raw = (model or "").strip().lower()
    if raw.startswith("anthropic:"):
        return True
    key = raw.replace(" ", "-").replace("_", "-")
    key = re.sub(r"-+", "-", key)
    return key.startswith("claude-")


def _normalize_claude_model_id(model: str) -> str:
    """Map friendly names to Anthropic API model ids (see Anthropic models overview)."""
    raw = (model or "").strip()
    if raw.lower().startswith("anthropic:"):
        raw = raw.split(":", 1)[1].strip()
    key = raw.lower().replace(" ", "-").replace("_", "-")
    key = re.sub(r"-+", "-", key)
    aliases = {
        "claude-opus-4.6": "claude-opus-4-6",
        "opus-4.6": "claude-opus-4-6",
        "claude-opus-4-6": "claude-opus-4-6",
        "claude-sonnet-4.6": "claude-sonnet-4-6",
        "sonnet-4.6": "claude-sonnet-4-6",
        "claude-sonnet-4-6": "claude-sonnet-4-6",
    }
    if key in aliases:
        return aliases[key]
    if re.match(r"^claude-[a-z]+-\d+-\d+$", key):
        return key
    return key


def _anthropic_max_output_tokens(model_id: str) -> int:
    if "opus" in (model_id or "").lower():
        return 128_000
    return 64_000


def _anthropic_messages_create(
    *,
    model_id: str,
    system_msg: str,
    prompt: str,
    temperature: Optional[float],
) -> Tuple[str, Dict]:
    """Claude via Anthropic Messages REST API (stdlib only — no extra packages)."""
    api_key = os.environ.get("ANTHROPIC_API_KEY")
    if not api_key:
        raise ValueError(
            "ANTHROPIC_API_KEY must be set in the environment to use Claude models."
        )

    payload: Dict[str, Any] = {
        "model": model_id,
        "max_tokens": _anthropic_max_output_tokens(model_id),
        "system": system_msg,
        "messages": [{"role": "user", "content": prompt}],
    }
    if temperature is not None:
        payload["temperature"] = float(temperature)

    body = json.dumps(payload).encode("utf-8")
    req = urllib.request.Request(
        "https://api.anthropic.com/v1/messages",
        data=body,
        method="POST",
        headers={
            "x-api-key": api_key,
            "anthropic-version": "2023-06-01",
            "content-type": "application/json",
        },
    )
    try:
        with urllib.request.urlopen(req, timeout=600) as resp:
            raw = resp.read().decode("utf-8")
    except urllib.error.HTTPError as e:
        err_body = e.read().decode("utf-8", errors="replace")[:2000]
        raise RuntimeError(
            f"Anthropic API error {e.code}: {err_body}"
        ) from e

    data = json.loads(raw)

    parts: List[str] = []
    for block in data.get("content") or []:
        if isinstance(block, dict) and block.get("type") == "text":
            parts.append(str(block.get("text") or ""))
    text = "".join(parts).strip()

    usage = data.get("usage") or {}
    pt = usage.get("input_tokens")
    ct = usage.get("output_tokens")
    usage_meta = {
        "prompt_tokens": pt,
        "completion_tokens": ct,
        "total_tokens": None,
    }
    if pt is not None and ct is not None:
        usage_meta["total_tokens"] = int(pt) + int(ct)

    return text, usage_meta


def _is_nebius_model(model: str) -> bool:
    """
    Nebius TokenFactory provides an OpenAI-compatible API surface.

    We treat Qwen/* and meta-llama/* models (and optional nebius:* prefixes)
    as Nebius-routed.
    """
    m = (model or "").strip()
    ml = m.lower()
    if ml.startswith("nebius:"):
        return True
    return ml.startswith("qwen/") or ml.startswith("meta-llama/")


def _strip_nebius_prefix(model: str) -> str:
    m = (model or "").strip()
    return m.split(":", 1)[1].strip() if m.lower().startswith("nebius:") else m


def _normalize_model_id(model: str) -> str:
    """
    Allow friendly aliases while keeping provider model IDs correct.

    User-facing alias supported:
      - deepseek-R1 / deepseek-r1 -> deepseek-reasoner (DeepSeek reasoning model)
    """
    m = (model or "").strip()
    ml = m.lower()
    if ml in {"deepseek-r1", "deepseek_r1"}:
        return "deepseek-reasoner"
    return m


def _resolve_gemini_api_key() -> str:
    api_key = os.environ.get("GEMINI_API_KEY") or os.environ.get("GOOGLE_API_KEY")
    if not api_key:
        raise ValueError(
            "GEMINI_API_KEY (preferred) or GOOGLE_API_KEY must be set to use Gemini models."
        )
    return api_key


def _resolve_nebius_api_key() -> str:
    api_key = os.environ.get("NEBIUS_API_KEY")
    if not api_key:
        raise ValueError(
            "NEBIUS_API_KEY must be set in the environment to use Nebius models."
        )
    return api_key


def _gemini_generate_content(*, model_id: str, system_msg: str, prompt: str) -> Tuple[str, Dict]:
    """
    Call Gemini via Google GenAI SDK and return (text, usage_meta).
    """
    try:
        from google import genai  # type: ignore
    except Exception as e:  # pragma: no cover
        raise RuntimeError(
            "Gemini support requires the Google GenAI SDK. Install with: pip install google-genai"
        ) from e

    api_key = _resolve_gemini_api_key()
    client = genai.Client(api_key=api_key)

    resp = client.models.generate_content(
        model=model_id,
        contents=[system_msg, prompt],
    )

    text = getattr(resp, "text", None)
    if text is None and isinstance(resp, dict):
        text = resp.get("text")
    text = (text or "").strip()

    usage = getattr(resp, "usage_metadata", None)
    if usage is None and isinstance(resp, dict):
        usage = resp.get("usage_metadata") or resp.get("usageMetadata")

    def g(obj, key: str):
        if obj is None:
            return None
        if isinstance(obj, dict):
            return obj.get(key)
        return getattr(obj, key, None)

    usage_meta = {
        "prompt_tokens": g(usage, "prompt_token_count") or g(usage, "promptTokenCount"),
        "completion_tokens": g(usage, "candidates_token_count")
        or g(usage, "candidatesTokenCount"),
        "total_tokens": g(usage, "total_token_count") or g(usage, "totalTokenCount"),
        "raw_usage_metadata": (
            usage if isinstance(usage, dict) else getattr(usage, "__dict__", None)
        ),
    }
    return text, usage_meta


def _make_client(*, model: str, instance_dir: str):
    """
    Create an OpenAI-compatible client for the requested model/provider.

    - OpenAI models use default OpenAI base URL and OPENAI_API_KEY resolution.
    - DeepSeek models use base_url=https://api.deepseek.com and DEEPSEEK_API_KEY.
    """
    from openai import OpenAI

    if _is_gemini_model(model):
        raise RuntimeError(
            "Gemini models are not OpenAI-compatible in this solver. "
            "Use the Gemini provider path in construct_gav_rules()."
        )

    if _is_claude_model(model):
        raise RuntimeError(
            "Claude models are not OpenAI-compatible in this solver. "
            "Use the Anthropic provider path in construct_gav_rules()."
        )

    if _is_nebius_model(model):
        api_key = _resolve_nebius_api_key()
        return OpenAI(
            api_key=api_key,
            # base_url="https://api.tokenfactory.us-central1.nebius.com/v1/",
            base_url="https://api.tokenfactory.nebius.com/v1/",
            # base_url="https://api.studio.nebius.ai/v1/",
        )

    if _is_deepseek_model(model):
        api_key = os.environ.get("DEEPSEEK_API_KEY")
        if not api_key:
            raise ValueError(
                "DEEPSEEK_API_KEY must be set in the environment to use DeepSeek models."
            )
        return OpenAI(api_key=api_key, base_url="https://api.deepseek.com")

    # OpenAI
    _resolve_api_key(instance_dir)
    return OpenAI()


def _apply_output_token_limit(api_params: Dict, *, model: str, max_out: int) -> None:
    """
    Mutate api_params in-place to set the correct max output token parameter.
    """
    if _is_gpt5_family_model(model):
        api_params["max_completion_tokens"] = int(max_out)
    else:
        api_params["max_tokens"] = int(max_out)


def _model_supports_temperature(model: str) -> bool:
    # Keep aligned with transforms.py's GPT-5 rules: no temperature for gpt-5* family.
    # DeepSeek reasoning models also ignore/forbid temperature-like sampling params.
    return not (_is_gpt5_family_model(model) or _is_deepseek_model(model))


def _load_local_schemas(instance_dir: str) -> Dict[str, str]:
    """Load all local schema DDL files from the instance directory."""
    locals_dir = os.path.join(instance_dir, "locals")
    schemas = {}
    for f in sorted(os.listdir(locals_dir)):
        # Only include true per-local schemas. Some instances include
        # `all_locals_schema.sql` as a convenience aggregate, which would
        # duplicate tables and make the prompt easier/noisier.
        if f.startswith("local_") and f.endswith("_schema.sql"):
            local_name = f.replace("_schema.sql", "")
            with open(os.path.join(locals_dir, f), encoding="utf-8") as fh:
                schemas[local_name] = fh.read()
    return schemas


def _prompts_dir() -> str:
    return os.path.join(os.path.dirname(__file__), "prompts")


def _load_prompt_text(filename: str) -> str:
    path = os.path.join(_prompts_dir(), filename)
    with open(path, "r", encoding="utf-8") as f:
        return f.read().strip() + "\n"


def _strip_code_fences(text: str) -> str:
    """Remove markdown code fences if present."""
    text = text.strip()
    if text.startswith("```"):
        text = re.sub(r'^```\w*\n?', '', text)
        text = re.sub(r'\n?```$', '', text)
    return text.strip()


def _resolve_api_key(instance_dir: str = ".") -> str:
    """Resolve OpenAI API key from environment or .env files."""
    api_key = os.environ.get("OPENAI_API_KEY") or os.environ.get("OPENAI_KEY")

    if not api_key:
        for env_path in [
            os.path.join(instance_dir, ".env"),
            os.path.join(os.path.dirname(instance_dir), ".env"),
            os.path.expanduser("~/.env"),
            ".env",
        ]:
            if os.path.exists(env_path):
                with open(env_path) as ef:
                    for line in ef:
                        line = line.strip()
                        if line.startswith("OPENAI_API_KEY="):
                            api_key = line.split("=", 1)[1].strip().strip('"').strip("'")
                        elif line.startswith("OPENAI_KEY="):
                            api_key = line.split("=", 1)[1].strip().strip('"').strip("'")
                if api_key:
                    break

    if not api_key:
        raise ValueError(
            "OPENAI_API_KEY or OPENAI_KEY must be set in the environment, "
            "in a .env file, or passed via --api_key."
        )

    os.environ["OPENAI_API_KEY"] = api_key
    return api_key


# ──────────────────────────────────────────────
# GAV Rule Generation (single LLM call)
# ──────────────────────────────────────────────

def construct_gav_rules(
    instance_dir: str,
    model: str = "gpt-5.4-mini",
    temperature: Optional[float] = None,
) -> Tuple[str, str, str, Dict]:
    """
    Zero-shot GAV rule generation.

    The LLM receives ONLY the local schema DDLs — no transformation
    logs, no hints about the original schema, no example queries.
    It must infer the unified global schema and express it as
    SQL CREATE VIEW statements.

    Returns:
        (gav_rules_text, prompt_text, raw_response_text, llm_metadata)
    """
    model_id = _normalize_model_id(model)
    if _is_nebius_model(model_id):
        model_id = _strip_nebius_prefix(model_id)
    provider = (
        "google"
        if _is_gemini_model(model_id)
        else (
            "anthropic"
            if _is_claude_model(model_id)
            else (
                "nebius"
                if _is_nebius_model(model)
                else ("deepseek" if _is_deepseek_model(model_id) else "openai")
            )
        )
    )
    client = (
        None
        if _is_gemini_model(model_id) or _is_claude_model(model_id)
        else _make_client(model=model_id, instance_dir=instance_dir)
    )

    local_schemas = _load_local_schemas(instance_dir)

    schemas_section = []
    for local_name, ddl in local_schemas.items():
        schemas_section.append(f"### {local_name}\n```sql\n{ddl}\n```")

    system_msg = _load_prompt_text("gav_system.txt")
    user_template = _load_prompt_text("gav_user.txt")
    prompt = user_template.format(
        num_locals=len(local_schemas),
        schemas_section=chr(10).join(schemas_section),
    )

    print(f"  Sending GAV rule generation prompt to {model_id}...")
    print(f"  Prompt size: ~{len(prompt)} chars")

    start_time = time.time()
    raw_response = ""
    provider_usage: Dict = {}
    prompt_tokens = None
    completion_tokens = None
    total_tokens = None

    if _is_gemini_model(model_id):
        raw_response, usage_meta = _gemini_generate_content(
            model_id=model_id,
            system_msg=system_msg,
            prompt=prompt,
        )
        elapsed = time.time() - start_time
        provider_usage = usage_meta or {}
        prompt_tokens = provider_usage.get("prompt_tokens")
        completion_tokens = provider_usage.get("completion_tokens")
        total_tokens = provider_usage.get("total_tokens")
    elif _is_claude_model(model_id):
        claude_mid = _normalize_claude_model_id(model_id)
        raw_response, usage_meta = _anthropic_messages_create(
            model_id=claude_mid,
            system_msg=system_msg,
            prompt=prompt,
            temperature=temperature
            if temperature is not None and _model_supports_temperature(model)
            else None,
        )
        elapsed = time.time() - start_time
        provider_usage = usage_meta or {}
        prompt_tokens = provider_usage.get("prompt_tokens")
        completion_tokens = provider_usage.get("completion_tokens")
        total_tokens = provider_usage.get("total_tokens")
        model_id = claude_mid
    else:
        api_params = {
            "model": model_id,
            "messages": [
                {"role": "system", "content": system_msg},
                {"role": "user", "content": prompt},
            ],
        }
        # Temperature/top_p/etc.: only pass through when explicitly provided AND supported.
        # For GPT-5 family models, omitting yields API/model defaults (requested behavior).
        if temperature is not None and _model_supports_temperature(model):
            api_params["temperature"] = temperature
        # Intentionally do NOT set max output tokens here. We rely on the provider/model
        # defaults so callers can get full outputs when needed.
        response = client.chat.completions.create(**api_params)  # type: ignore[union-attr]
        elapsed = time.time() - start_time
        raw_response = response.choices[0].message.content
        prompt_tokens = getattr(response.usage, "prompt_tokens", None)
        completion_tokens = getattr(response.usage, "completion_tokens", None)
        total_tokens = getattr(response.usage, "total_tokens", None)
    gav_rules = _strip_code_fences(raw_response)

    meta = {
        "model": model_id,
        "model_alias": model if model_id != model else None,
        "provider": provider,
        "temperature": temperature,
        "prompt_chars": len(prompt),
        "response_chars": len(raw_response),
        "latency_seconds": round(elapsed, 2),
        "prompt_tokens": prompt_tokens,
        "completion_tokens": completion_tokens,
        "total_tokens": total_tokens,
        "provider_usage": provider_usage or None,
        "timestamp": datetime.now().isoformat(),
    }

    print(f"  Response received in {elapsed:.1f}s")
    print(f"  Tokens: {meta.get('total_tokens', '?')}")
    print(f"  GAV rules length: {len(gav_rules)} chars")

    return gav_rules, prompt, raw_response, meta


# ──────────────────────────────────────────────
# Master: run the solver
# ──────────────────────────────────────────────

def run_solver(
    instance_dir: str,
    model: str = "gpt-5.4-mini",
    temperature: Optional[float] = None,
) -> str:
    """
    Run the LLM solver to generate GAV rules.

    Saves GAV rules, prompt, and LLM response to
    instance_dir/solve_results/<model>/

    Returns the output directory path.
    """
    model_slug = model.replace("/", "_").replace(":", "_")
    output_dir = os.path.join(instance_dir, "solve_results", model_slug)
    # Skip by default if this model already has a completed solve directory.
    existing_summary = os.path.join(output_dir, "solver_summary.json")
    existing_gav = os.path.join(output_dir, "gav_rules.sql")
    if os.path.exists(existing_summary) or os.path.exists(existing_gav):
        print(
            f"\n{'=' * 70}\n"
            f"LLM Solver: GAV Rule Generation from Local Schemas\n"
            f"{'=' * 70}\n"
            f"Instance: {instance_dir}\n"
            f"Model:    {model}\n\n"
            f"Existing solve_results found for this model; skipping LLM call.\n"
            f"  Summary: {existing_summary if os.path.exists(existing_summary) else '(none)'}\n"
            f"  GAV SQL: {existing_gav if os.path.exists(existing_gav) else '(none)'}\n"
            f"{'=' * 70}",
        )
        return output_dir

    os.makedirs(output_dir, exist_ok=True)

    prompts_dir = os.path.join(output_dir, "prompts")
    os.makedirs(prompts_dir, exist_ok=True)

    total_start = time.time()

    print(f"\n{'=' * 70}")
    print(f"LLM Solver: GAV Rule Generation from Local Schemas")
    print(f"{'=' * 70}")
    print(f"Instance: {instance_dir}")
    print(f"Model:    {model}")
    print()

    print("Generating GAV (Global-As-View) rules...")
    gav_rules, prompt, raw_response, meta = construct_gav_rules(
        instance_dir, model=model, temperature=temperature
    )

    gav_path = os.path.join(output_dir, "gav_rules.sql")
    with open(gav_path, "w") as f:
        f.write(gav_rules)
    print(f"  Saved: {gav_path}")

    prompt_path = os.path.join(prompts_dir, "gav_generation.txt")
    with open(prompt_path, "w") as f:
        f.write("=" * 80 + "\n")
        f.write("GAV Rule Generation (zero-shot)\n")
        f.write("=" * 80 + "\n")
        f.write(f"Model:       {model}\n")
        f.write(
            f"Temperature: {temperature if temperature is not None else '(API default / omitted)'}\n"
        )
        f.write(f"Timestamp:   {meta.get('timestamp', '')}\n")
        f.write(f"Latency:     {meta.get('latency_seconds', '?')}s\n")
        f.write(f"Tokens:      prompt={meta.get('prompt_tokens', '?')}, "
                f"completion={meta.get('completion_tokens', '?')}, "
                f"total={meta.get('total_tokens', '?')}\n")
        f.write("\n")
        f.write("-" * 80 + "\n")
        f.write("PROMPT:\n")
        f.write("-" * 80 + "\n\n")
        f.write(prompt)
        f.write("\n\n")
        f.write("-" * 80 + "\n")
        f.write("LLM RESPONSE:\n")
        f.write("-" * 80 + "\n\n")
        f.write(raw_response)
        f.write("\n")
    print(f"  Saved prompt/response: {prompt_path}")

    with open(os.path.join(output_dir, "solver_meta.json"), "w") as f:
        json.dump(meta, f, indent=2, default=str)

    total_elapsed = time.time() - total_start

    summary = {
        "model": model,
        "temperature": temperature,
        "instance_dir": instance_dir,
        "total_time_seconds": round(total_elapsed, 2),
        "gav_generation": meta,
        "total_tokens": meta.get("total_tokens") or 0,
        "prompts_saved_to": prompts_dir,
        "timestamp": datetime.now().isoformat(),
    }
    with open(os.path.join(output_dir, "solver_summary.json"), "w") as f:
        json.dump(summary, f, indent=2, default=str)

    print(f"\n{'=' * 70}")
    print(f"Solver Complete ({model})")
    print(f"{'=' * 70}")
    print(f"  GAV rules:      {len(gav_rules)} chars")
    print(f"  Total tokens:   {summary['total_tokens']}")
    print(f"  Total time:     {total_elapsed:.1f}s")
    print(f"  Output dir:     {output_dir}")
    print()
    print(f"  Next step: evaluate with:")
    print(f"    cd Code && python3 -m llm_solve_eval evaluate_solve \\")
    print(f"        --instance_dir {instance_dir} \\")
    print(f"        --solve_dir {output_dir}")
    print(f"{'=' * 70}")

    return output_dir
