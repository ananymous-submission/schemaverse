import random
import re
import json
import secrets
import os
import hashlib
import csv
from typing import List, Dict, Set, Tuple, Optional, Any
from dataclasses import dataclass, field
from copy import deepcopy

from schema_parser import SchemaGraph, Table, Column, ForeignKey
from config import DifficultyConfig
try:
    from vertical_split import build_vertical_split_fragments, load_column_enrichment_json
except ModuleNotFoundError:  # pragma: no cover
    build_vertical_split_fragments = None
    load_column_enrichment_json = None

try:
    from horizontal_partition import (
        choose_partition_for_table,
        choose_partition_for_vertical_fragment,
    )
except ModuleNotFoundError:  # pragma: no cover
    choose_partition_for_table = None
    choose_partition_for_vertical_fragment = None

try:
    from relocation_one_shot import run_one_shot_relocation
except ModuleNotFoundError:  # pragma: no cover
    run_one_shot_relocation = None


def _connectivity_score(*args, **kwargs):
    """
    Optional dependency shim.

    Some environments used for validation/analysis don't have `networkx` installed
    (and cannot install it). Importing `graph_partition` would then fail at import
    time and break unrelated commands (e.g., `validate_instance`).
    """
    from graph_partition import _connectivity_score as _real  # noqa: WPS433

    return _real(*args, **kwargs)


# ──────────────────────────────────────────────
# Helper functions for LLM API calls
# ──────────────────────────────────────────────

def _load_database_descriptions(
    db_path: str,
    schema_name: Optional[str] = None,
) -> Optional[Dict[str, Dict[str, Dict[str, str]]]]:
    """Load database description CSVs for tables and columns.
    
    Returns a nested dict: {table_name: {column_name: {field: value}}}
    where field can be 'column_description', 'value_description', 'data_format'.
    
    Returns None if descriptions directory doesn't exist or is empty.
    """
    if schema_name is None:
        # Extract schema name from db_path (e.g. "formula_1" from
        # "BIRD/dev_databases/formula_1/formula_1.sqlite")
        db_dir = os.path.dirname(os.path.abspath(db_path))
        schema_name = os.path.basename(db_dir)
    
    # Look for database_description directory
    db_dir = os.path.dirname(os.path.abspath(db_path))
    desc_dir = os.path.join(db_dir, "database_description")
    
    if not os.path.exists(desc_dir) or not os.path.isdir(desc_dir):
        return None
    
    descriptions = {}
    
    # Look for CSV files matching table names
    for filename in os.listdir(desc_dir):
        if not filename.endswith('.csv'):
            continue
        
        table_name = filename[:-4]  # Remove .csv extension
        
        csv_path = os.path.join(desc_dir, filename)
        try:
            with open(csv_path, 'r', encoding='utf-8') as f:
                reader = csv.DictReader(f)
                table_desc = {}
                
                for row in reader:
                    col_name = row.get('original_column_name', '').strip()
                    if not col_name:
                        continue
                    
                    table_desc[col_name] = {
                        'column_description': row.get('column_description', '').strip(),
                        'value_description': row.get('value_description', '').strip(),
                        'data_format': row.get('data_format', '').strip(),
                    }
                
                if table_desc:
                    descriptions[table_name] = table_desc
        except Exception as e:
            # Skip files that can't be read
            continue
    
    return descriptions if descriptions else None


def _is_gpt5_model(model: str) -> bool:
    """Check if a model is in the GPT-5 family, including `gpt-5-mini`."""
    return model.startswith("gpt-5") or model.startswith("gpt5")


def _model_supports_temperature(model: str) -> bool:
    """Check if a model supports the temperature parameter.
    
    GPT-5 models do not support temperature, so we exclude it for those models.
    """
    return not _is_gpt5_model(model)


# ──────────────────────────────────────────────
# Data structures for transformation tracking
# ──────────────────────────────────────────────

@dataclass
class ColumnMapping:
    """Maps original column to local column."""
    original_table: str
    original_column: str
    local_table: str
    local_column: str


@dataclass
class TableTransform:
    """Describes how a local table relates to original tables."""
    local_table: str
    source_table: str
    # Column mappings: local_col -> original_col
    column_map: Dict[str, str] = field(default_factory=dict)
    # For vertical (column) splits: which columns this fragment has
    projected_columns: Optional[List[str]] = None
    # For horizontal row partitions: the predicate used
    row_predicate: Optional[str] = None
    # Fragment of a vertical (column-wise) split of an original table
    is_vertical_split_fragment: bool = False
    vertical_split_peers: Optional[List[str]] = None  # other local fragment table names
    # Suffix of the vertical fragment plan (when row-split is applied on a vertical fragment)
    vertical_fragment_suffix: Optional[str] = None
    # Fragment of a horizontal row partition
    is_row_partition: bool = False
    # One peer (kept for backwards compatibility with legacy 2-way code paths)
    row_partition_partner: Optional[str] = None
    # Full ring of peers (len = F - 1). peers[0] == row_partition_partner.
    row_partition_peers: Optional[List[str]] = None
    # True when the owning partition has row overlap: downstream reconstruction
    # and query rewriting switch from UNION ALL to UNION (set union) for sets
    # of fragments marked True.
    row_partition_has_overlap: bool = False


@dataclass
class LocalSchema:
    """Complete description of a local schema."""
    local_id: int
    local_name: str
    tables: Dict[str, TableTransform]
    # Renamed table map: original_name -> local_name
    table_rename_map: Dict[str, str] = field(default_factory=dict)
    # Inverse rename map: local_name -> original_name
    table_rename_inv: Dict[str, str] = field(default_factory=dict)


@dataclass
class TransformSpec:
    """Complete specification of all transformations applied."""
    locals: List[LocalSchema]
    # Global rename maps
    rename_map: Dict  # per-local rename details
    vertical_split_map: Dict  # vertical (column) split metadata per original table
    row_partition_map: Dict  # horizontal row partition details
    fk_map: Dict  # FK info
    difficulty_config: Dict
    seed: int
    # How OP3 chose which tables to split (hyperparameters + selected list)
    vertical_split_selection: Dict = field(default_factory=dict)
    # Relocation log: list of fragment/partition moves applied
    relocations: List[Dict] = field(default_factory=list)
    # One-shot relocation engine debug (snapshot, skipped intents, pair weights sample)
    relocation_engine_debug: Dict = field(default_factory=dict)


# ──────────────────────────────────────────────
# OP1: Naming Drift
# ──────────────────────────────────────────────

# Naming convention converters
def _to_snake_case(name: str) -> str:
    """Convert camelCase/PascalCase to snake_case."""
    s1 = re.sub(r'(.)([A-Z][a-z]+)', r'\1_\2', name)
    return re.sub(r'([a-z0-9])([A-Z])', r'\1_\2', s1).lower()


def _to_camel_case(name: str) -> str:
    """Convert snake_case to camelCase."""
    components = name.split('_')
    return components[0].lower() + ''.join(x.title() for x in components[1:])


def _abbreviate(name: str) -> str:
    """Create abbreviated version of a name."""
    # Remove vowels from middle of words for abbreviation
    parts = re.split(r'[_\s]', name)
    abbreviated = []
    for p in parts:
        if len(p) <= 3:
            abbreviated.append(p)
        else:
            # Keep first letter + consonants
            abbr = p[0] + re.sub(r'[aeiouAEIOU]', '', p[1:])
            if len(abbr) < 2:
                abbr = p[:3]
            abbreviated.append(abbr[:5])
    return '_'.join(abbreviated)


# Fallback deterministic naming (used when LLM is not available)
FALLBACK_TABLE_RENAMES = {
    "circuits": ["track_info", "venue_circuits", "circuit_data", "trk_venues"],
    "constructors": ["teams", "team_registry", "constructor_info", "mfg_teams"],
    "drivers": ["racers", "driver_roster", "pilot_info", "drv_profiles"],
    "seasons": ["championship_years", "season_calendar", "yr_seasons", "szn_data"],
    "races": ["grand_prix_events", "race_schedule", "gp_events", "race_catalog"],
    "constructorResults": ["team_race_results", "constructor_perf", "tm_results", "team_scores"],
    "constructorStandings": ["team_rankings", "constructor_rank", "tm_standings", "team_leaderboard"],
    "driverStandings": ["driver_rankings", "pilot_standings", "drv_rank", "racer_leaderboard"],
    "lapTimes": ["lap_records", "circuit_laps", "lap_timing_data", "per_lap_times"],
    "pitStops": ["pit_visits", "pitstop_log", "pit_events", "service_stops"],
    "qualifying": ["quali_sessions", "grid_qualifying", "qual_results", "time_trials"],
    "status": ["race_outcomes", "finish_status", "result_codes", "status_lookup"],
    "results": ["race_results", "finish_data", "gp_results", "competition_results"],
}

FALLBACK_COLUMN_RENAMES = {
    "Id": ["_id", "_key", "_ref", "_num"],
    "name": ["title", "label", "designation", "display_name"],
    "url": ["web_link", "page_url", "href", "resource_uri"],
    "nationality": ["country_origin", "nation", "origin_country", "ntl"],
    "position": ["rank", "place", "standing", "pos"],
    "points": ["score", "pts", "tally", "point_total"],
    "wins": ["victories", "win_count", "num_wins", "w"],
    "time": ["elapsed", "duration", "timing", "clock"],
    "milliseconds": ["ms", "elapsed_ms", "time_ms", "duration_ms"],
    "lap": ["lap_number", "lap_num", "circuit_lap", "lap_idx"],
    "grid": ["start_position", "grid_pos", "starting_grid", "grid_slot"],
    "laps": ["total_laps", "laps_completed", "lap_count", "num_laps"],
    "number": ["car_number", "num", "vehicle_no", "car_no"],
    "year": ["season_year", "yr", "championship_year", "calendar_year"],
    "round": ["race_round", "rnd", "event_round", "round_num"],
    "date": ["event_date", "race_date", "dt", "scheduled_date"],
    "location": ["city", "locale", "venue_city", "site_location"],
    "country": ["nation", "territory", "country_name", "region"],
    "lat": ["latitude", "lat_coord", "geo_lat", "y_coord"],
    "lng": ["longitude", "lng_coord", "geo_lng", "x_coord"],
    "alt": ["altitude", "elevation", "height_m", "alt_meters"],
    "code": ["driver_code", "abbrev", "short_code", "id_code"],
    "forename": ["first_name", "given_name", "fname", "name_first"],
    "surname": ["last_name", "family_name", "lname", "name_last"],
    "dob": ["birth_date", "date_of_birth", "birthday", "born_on"],
    "stop": ["stop_number", "pit_num", "stop_seq", "visit_num"],
    "duration": ["pit_duration", "stop_time", "elapsed_time", "time_spent"],
    "q1": ["qual_1", "q1_time", "first_quali", "session_1"],
    "q2": ["qual_2", "q2_time", "second_quali", "session_2"],
    "q3": ["qual_3", "q3_time", "third_quali", "session_3"],
    "rank": ["fastest_rank", "speed_rank", "performance_rank", "rnk"],
    "fastestLap": ["best_lap", "fastest_lap_num", "quick_lap", "fl_lap"],
    "fastestLapTime": ["best_lap_time", "fl_time", "quickest_time", "fastest_time"],
    "fastestLapSpeed": ["top_speed", "fl_speed", "peak_speed", "max_lap_speed"],
    "positionText": ["position_str", "pos_text", "rank_text", "standing_text"],
    "positionOrder": ["final_order", "pos_order", "rank_order", "finish_order"],
    "status": ["outcome", "result_status", "race_status", "finish_type"],
}


def _generate_local_themes(
    schema_graph: SchemaGraph,
    groups: List[Set[str]],
    client,
    config: DifficultyConfig,
    db_path: Optional[str] = None,
    descriptions: Optional[Dict[str, Dict[str, Dict[str, str]]]] = None,
    output_dir: Optional[str] = None,
) -> List[str]:
    """
    Use the LLM to generate contextual microservice themes for each local
    based on the actual tables assigned to it.

    Returns a list of theme strings (one per local group).
    """
    # Load descriptions if not provided
    if descriptions is None and db_path:
        descriptions = _load_database_descriptions(db_path)
    
    # Build a description of ALL locals and their tables
    locals_description = []
    for i, group in enumerate(groups):
        tables = sorted(group)
        table_info = []
        for t in tables:
            tbl = schema_graph.tables[t]
            cols = [c.name for c in tbl.columns]
            
            # Build table description with semantic info if available
            table_desc = f"    - {t}"
            if descriptions and t in descriptions:
                # Include column descriptions for context
                col_descs = []
                for col in cols[:8]:  # Limit to first 8 columns to avoid too long
                    if col in descriptions[t]:
                        desc = descriptions[t][col].get('column_description', '')
                        if desc:
                            col_descs.append(f"{col} ({desc})")
                        else:
                            col_descs.append(col)
                    else:
                        col_descs.append(col)
                
                if len(cols) > 8:
                    col_descs.append("...")
                
                table_desc += f": {', '.join(col_descs)}"
            else:
                # Fallback: just column names
                table_desc += f" (columns: {', '.join(cols[:6])}{'...' if len(cols) > 6 else ''})"
            
            table_info.append(table_desc)
        locals_description.append(
            f"  Local {i + 1}:\n" + "\n".join(table_info)
        )

    locals_text = "\n".join(locals_description)

    prompt_tmpl_path = os.path.join(os.path.dirname(__file__), "prompts", "theme_user.txt")
    with open(prompt_tmpl_path, "r", encoding="utf-8") as f:
        prompt_tmpl = f.read()
    prompt = prompt_tmpl.format(num_locals=len(groups), locals_text=locals_text)

    try:
        # Build API call parameters
        system_tmpl_path = os.path.join(os.path.dirname(__file__), "prompts", "theme_system.txt")
        with open(system_tmpl_path, "r", encoding="utf-8") as f:
            system_msg = f.read().strip()
        api_params = {
            "model": config.llm_model,
            "messages": [
                {"role": "system", "content": system_msg},
                {"role": "user", "content": prompt},
            ],
        }
        # Do not send any explicit output token cap here. Large schemas may need
        # substantial reasoning/output budget, and provider defaults are safer.
        if _model_supports_temperature(config.llm_model):
            api_params["temperature"] = 0.7
        
        response = client.chat.completions.create(**api_params)
        content = response.choices[0].message.content.strip()

        # Save prompt and response
        if output_dir:
            prompts_dir = os.path.join(output_dir, "llm_prompts")
            os.makedirs(prompts_dir, exist_ok=True)
            with open(os.path.join(prompts_dir, "theme_generation_prompt.txt"), "w", encoding="utf-8") as fp:
                fp.write(prompt)
            with open(os.path.join(prompts_dir, "theme_generation_response.txt"), "w", encoding="utf-8") as fp:
                fp.write(content)

        if content.startswith("```"):
            content = re.sub(r'^```\w*\n?', '', content)
            content = re.sub(r'\n?```$', '', content)
        result = json.loads(content)
        themes = result.get("themes", [])
        if len(themes) >= len(groups):
            print(f"  LLM-generated themes:")
            for i, theme in enumerate(themes[:len(groups)]):
                print(f"    Local {i + 1}: \"{theme}\"")
            return themes[:len(groups)]
    except Exception as e:
        print(f"  Warning: Theme generation failed: {e}")

    # Fallback: generate generic themes from table names
    fallback_themes = []
    for group in groups:
        tables = sorted(group)
        fallback_themes.append(f"{' and '.join(tables[:2])} management service")
    return fallback_themes


def generate_llm_naming(
    schema_graph: SchemaGraph,
    groups: List[Set[str]],
    config: DifficultyConfig,
    db_path: Optional[str] = None,
    cache_dir: Optional[str] = None,
    output_dir: Optional[str] = None,
) -> Tuple[Dict[int, Dict[str, str]], Dict[int, Dict[str, Dict[str, str]]]]:
    """
    Use OpenAI API to generate realistic naming variations for tables and columns.
    Returns (table_renames_per_local, column_renames_per_local).
    
    Each local gets a different naming convention to simulate different teams
    having developed their own microservice schemas.
    
    Uses a preliminary LLM call to generate contextual themes for each local
    based on the actual tables it contains (rather than using hardcoded themes).
    
    If db_path is provided, loads database descriptions to enhance prompts with
    semantic context (column descriptions, value descriptions).
    
    NOTE: Caching is disabled by the caller; this function will call the LLM
    on every run when used from apply_transforms.
    """
    
    try:
        from openai import OpenAI
        client = OpenAI()  # Uses OPENAI_API_KEY env var
    except Exception as e:
        print(f"Warning: Could not initialize OpenAI client: {e}")
        print("Falling back to deterministic naming.")
        return _fallback_naming(schema_graph, groups, config)

    table_renames = {}  # local_idx -> {original_table -> new_name}
    column_renames = {}  # local_idx -> {original_table -> {orig_col -> new_col}}

    # Load database descriptions if available
    descriptions = _load_database_descriptions(db_path) if db_path else None
    if descriptions:
        print("  Database descriptions loaded - enhancing LLM prompts with semantic context")

    # Generate context-aware themes via LLM
    print("  Generating microservice themes via LLM...")
    local_themes = _generate_local_themes(schema_graph, groups, client, config, db_path, descriptions, output_dir)

    for local_idx, group in enumerate(groups):
        tables = sorted(group)
        theme = local_themes[local_idx % len(local_themes)]

        # Build a description of the tables and their columns
        table_descriptions = []
        for t in tables:
            tbl = schema_graph.tables[t]
            cols = [c.name for c in tbl.columns]
            
            # Build enhanced description with semantic info if available
            if descriptions and t in descriptions:
                col_details = []
                for col in cols:
                    if col in descriptions[t]:
                        desc = descriptions[t][col]
                        col_desc_text = desc.get('column_description', '')
                        value_desc_text = desc.get('value_description', '')
                        
                        col_info = f"{col}"
                        if col_desc_text:
                            col_info += f" ({col_desc_text})"
                        if value_desc_text and len(value_desc_text) < 100:  # Include short value descriptions
                            col_info += f" [{value_desc_text[:80]}]"
                        
                        col_details.append(col_info)
                    else:
                        col_details.append(col)
                
                table_descriptions.append(f"  Table '{t}':\n    Columns: {', '.join(col_details)}")
            else:
                # Fallback: just column names
                table_descriptions.append(f"  Table '{t}': columns = {cols}")

        tables_text = "\n".join(table_descriptions)
        
        # Add context about descriptions if available
        description_note = ""
        if descriptions:
            description_note = "\n\nNote: Column descriptions in parentheses indicate the semantic meaning of each column. Use this context to generate more appropriate and domain-specific renames."

        prompt_tmpl_path = os.path.join(os.path.dirname(__file__), "prompts", "naming_user.txt")
        with open(prompt_tmpl_path, "r", encoding="utf-8") as f:
            prompt_tmpl = f.read()
        prompt = prompt_tmpl.format(
            theme=theme,
            description_note=description_note,
            tables_text=tables_text,
        )

        try:
            # Build API call parameters
            system_tmpl_path = os.path.join(os.path.dirname(__file__), "prompts", "naming_system.txt")
            with open(system_tmpl_path, "r", encoding="utf-8") as f:
                system_msg = f.read().strip()
            api_params = {
                "model": config.llm_model,
                "messages": [
                    {"role": "system", "content": system_msg},
                    {"role": "user", "content": prompt},
                ],
            }
            # Do not send any explicit output token cap here. Large schemas may
            # need substantial reasoning/output budget, and provider defaults are safer.
            if _model_supports_temperature(config.llm_model):
                api_params["temperature"] = 0.7
            
            response = client.chat.completions.create(**api_params)

            content = response.choices[0].message.content.strip()

            # Save prompt and response
            if output_dir:
                prompts_dir = os.path.join(output_dir, "llm_prompts")
                os.makedirs(prompts_dir, exist_ok=True)
                with open(os.path.join(prompts_dir, f"naming_drift_local_{local_idx + 1}_prompt.txt"), "w", encoding="utf-8") as fp:
                    fp.write(prompt)
                with open(os.path.join(prompts_dir, f"naming_drift_local_{local_idx + 1}_response.txt"), "w", encoding="utf-8") as fp:
                    fp.write(content)

            # Remove markdown code fences if present
            if content.startswith("```"):
                content = re.sub(r'^```\w*\n?', '', content)
                content = re.sub(r'\n?```$', '', content)

            result = json.loads(content)

            table_renames[local_idx] = result.get("table_renames", {})
            column_renames[local_idx] = result.get("column_renames", {})

        except Exception as e:
            print(f"Warning: LLM naming failed for local {local_idx}: {e}")
            # Fallback for this specific local
            tr, cr = _fallback_naming_single(schema_graph, group, local_idx, config)
            table_renames[local_idx] = tr
            column_renames[local_idx] = cr

    # Save to cache if cache_dir provided
    # if cache_file:
    #     try:
    #         with open(cache_file, 'w') as f:
    #             json.dump({
    #                 "table_renames": table_renames,
    #                 "column_renames": column_renames,
    #             }, f, indent=2)
    #         print(f"  Saved LLM naming to cache: {cache_file}")
    #     except Exception as e:
    #         print(f"  Warning: Failed to save cache: {e}")

    return table_renames, column_renames


def _pick_naming_case_styles(locals_list: List[LocalSchema], config: DifficultyConfig) -> Dict[str, str]:
    """
    Choose a naming casing style per local. This is intentionally non-deterministic
    (uses SystemRandom) to avoid always repeating the same style across runs.
    """
    forced = getattr(config, "naming_case_force_style", None)
    if forced:
        return {l.local_name: str(forced) for l in locals_list}

    if not getattr(config, "naming_case_randomize", True):
        return {l.local_name: "snake_case" for l in locals_list}

    styles = ["snake_case", "camelCase", "PascalCase", "abbrev_snake"]
    r = secrets.SystemRandom()
    r.shuffle(styles)
    out: Dict[str, str] = {}
    for i, loc in enumerate(locals_list):
        if i < len(styles):
            out[loc.local_name] = styles[i]
        else:
            out[loc.local_name] = r.choice(styles)
    return out


def _apply_case_style(name: str, style: str) -> str:
    if style == "camelCase":
        return _to_camel_case(_to_snake_case(name))
    if style == "PascalCase":
        base = _to_camel_case(_to_snake_case(name))
        return base[:1].upper() + base[1:] if base else base
    if style == "abbrev_snake":
        return _abbreviate(_to_snake_case(name))
    return _to_snake_case(name)


_ORDINAL_TOKEN_RE = re.compile(
    r"(?i)\b(q[0-9]+|part[_\s-]*[0-9]+|segment[_\s-]*[0-9]+|frag(?:ment)?[_\s-]*[0-9]+)\b"
)


def _clean_llm_identifier(name: str, fallback: str) -> str:
    """
    Remove explicit ordinal markers from LLM-generated identifiers.
    """
    candidate = (name or "").strip()
    if not candidate:
        candidate = fallback
    candidate = _ORDINAL_TOKEN_RE.sub("", candidate)
    candidate = re.sub(r"(?i)(?:^|[_\s-])(first|second|third|fourth|fifth)(?:$|[_\s-])", "_", candidate)
    candidate = re.sub(r"[_\s-]+", "_", candidate).strip("_")
    if not candidate:
        candidate = fallback
    return candidate


def fallback_naming_final(
    schema_graph: SchemaGraph,
    locals_list: List[LocalSchema],
    config: DifficultyConfig,
) -> Tuple[Dict[int, Dict[str, str]], Dict[int, Dict[str, Dict[str, str]]], Dict[str, str]]:
    """
    Deterministic fallback when no LLM key is available.
    Renames every local table/column according to a per-local casing style.
    """
    casing = _pick_naming_case_styles(locals_list, config)
    table_renames: Dict[int, Dict[str, str]] = {}
    column_renames: Dict[int, Dict[str, Dict[str, str]]] = {}

    for local_idx, local in enumerate(locals_list):
        style = casing.get(local.local_name, "snake_case")
        tr: Dict[str, str] = {}
        cr: Dict[str, Dict[str, str]] = {}
        for lt_name, lt in local.tables.items():
            new_t = _apply_case_style(lt_name, style)
            if not new_t or new_t == lt_name:
                new_t = f"{_apply_case_style(lt_name, style)}_{local_idx}"
            tr[lt_name] = new_t
            cmap: Dict[str, str] = {}
            for local_col in lt.column_map.keys():
                new_c = _apply_case_style(local_col, style)
                if not new_c or new_c == local_col:
                    new_c = f"{_apply_case_style(local_col, style)}_{local_idx}"
                cmap[local_col] = new_c
            cr[lt_name] = cmap
        table_renames[local_idx] = tr
        column_renames[local_idx] = cr
    return table_renames, column_renames, casing


def _parse_llm_json_payload(content: str) -> Dict[str, Any]:
    """Parse JSON from an LLM response, tolerating fences and extra prose."""
    text = (content or "").strip()
    if not text:
        raise ValueError("empty LLM response")
    if text.startswith("```"):
        text = re.sub(r'^```\w*\n?', '', text)
        text = re.sub(r'\n?```$', '', text)
        text = text.strip()
    try:
        return json.loads(text)
    except json.JSONDecodeError:
        pass

    start = text.find("{")
    end = text.rfind("}")
    if start != -1 and end != -1 and end > start:
        candidate = text[start:end + 1].strip()
        if candidate:
            return json.loads(candidate)
    raise ValueError("LLM response did not contain valid JSON")


def _serialize_openai_response(response: Any) -> str:
    """Best-effort serialization for debugging malformed/empty LLM outputs."""
    try:
        if hasattr(response, "model_dump_json"):
            return response.model_dump_json(indent=2)
    except Exception:
        pass
    try:
        if hasattr(response, "model_dump"):
            return json.dumps(response.model_dump(), indent=2, default=str)
    except Exception:
        pass
    return repr(response)


def generate_llm_naming_final(
    schema_graph: SchemaGraph,
    locals_list: List[LocalSchema],
    fk_map: Dict,
    config: DifficultyConfig,
    db_path: Optional[str] = None,
    output_dir: Optional[str] = None,
    row_partition_map: Optional[Dict[str, Any]] = None,
) -> Tuple[Dict[int, Dict[str, str]], Dict[int, Dict[str, Dict[str, str]]], Dict[str, str]]:
    """
    LLM naming drift on FINAL per-local schemas (post-split, post-relocation, post-FK-dropping).
    The LLM only sees local table/column names, types, PKs, and preserved intra-local FKs.
    """
    try:
        from openai import OpenAI

        client = OpenAI()
    except Exception as e:
        raise RuntimeError(f"Could not initialize OpenAI client for naming drift: {e}")

    casing = _pick_naming_case_styles(locals_list, config)

    table_renames: Dict[int, Dict[str, str]] = {}
    column_renames: Dict[int, Dict[str, Dict[str, str]]] = {}

    fk_entries = (fk_map or {}).get("foreign_keys") or []

    def _selected_tables_for_local(local_idx: int, table_names: List[str]) -> Set[str]:
        """
        Deterministically choose which tables in this local keep LLM renames.

        Semantics for rename_rate under LLM naming:
        - rate is the fraction of tables per local whose table/column renames
          are accepted from the LLM output.
        - remaining tables are forced back to identity names.
        """
        rate = float(getattr(config, "rename_rate", 1.0))
        if rate <= 0.0 or not table_names:
            return set()
        if rate >= 1.0:
            return set(table_names)
        k = int(round(len(table_names) * rate))
        if k <= 0:
            return set()
        k = min(k, len(table_names))
        rng = random.Random(int(getattr(config, "seed", 42)) + (local_idx + 1) * 1009)
        chosen = list(sorted(table_names))
        rng.shuffle(chosen)
        return set(chosen[:k])

    for local_idx, local in enumerate(locals_list):
        style = casing.get(local.local_name, "snake_case")
        source_table_by_local_table = {
            lt_name: lt.source_table for lt_name, lt in local.tables.items()
        }

        # Build per-local schema text: only local identifiers + types + intra-local FKs.
        table_descs = []
        for lt_name, lt in sorted(local.tables.items(), key=lambda x: x[0]):
            src_tbl = schema_graph.tables[lt.source_table]
            pk_set = set(src_tbl.primary_keys) if getattr(src_tbl, "pk_origin", "declared") == "declared" else set()
            col_by_orig_name = {c.name: c for c in src_tbl.columns}

            # Build lookup of intra-local FK constraints out of this table
            fk_out = []
            for fk_entry in fk_entries:
                if fk_entry.get("original", {}).get("origin") == "inferred":
                    continue
                for pair in fk_entry.get("intra_local_pairs", []) or []:
                    if pair.get("local") != local.local_name:
                        continue
                    if pair.get("from_local_table") != lt_name:
                        continue
                    src_from = source_table_by_local_table.get(pair.get("from_local_table"))
                    src_to = source_table_by_local_table.get(pair.get("to_local_table"))
                    # Hide synthetic sibling links produced by fragmentation of one source table.
                    if (
                        src_from
                        and src_to
                        and src_from == src_to
                        and pair.get("from_local_table") != pair.get("to_local_table")
                    ):
                        continue
                    fk_out.append(pair)

            fk_from_col = {}
            for pair in fk_out:
                fk_from_col.setdefault(pair.get("from_local_column"), []).append(
                    (pair.get("to_local_table"), pair.get("to_local_column"))
                )

            col_lines = []
            for local_col, orig_col in lt.column_map.items():
                oc = col_by_orig_name.get(orig_col)
                ctype = (oc.type if oc and oc.type else "TEXT").upper()
                tags = []
                if orig_col in pk_set:
                    tags.append("PK")
                if local_col in fk_from_col:
                    refs = fk_from_col[local_col]
                    refs_txt = ", ".join(f"{t}({c})" for t, c in refs if t and c)
                    if refs_txt:
                        tags.append(f"FK->{refs_txt}")
                tag_txt = f" [{' | '.join(tags)}]" if tags else ""
                col_lines.append(f"    - {local_col}: {ctype}{tag_txt}")

            table_descs.append(f"  Table {lt_name}:\n" + "\n".join(col_lines))

        tables_text = "\n".join(table_descs)

        local_tables_set = set(local.tables.keys())
        hint_lines = _build_naming_semantic_hints_for_local(
            row_partition_map or {}, local_tables_set
        )
        hints_block = ""
        if hint_lines.strip():
            # Instruction lives only here—not in Requirements—so the model ties hints to renames.
            hints_block = (
                "\n\nRow-level semantics (consider these when renaming tables and columns):\n"
                f"{hint_lines.strip()}\n"
                "\nWhen a table above is described by a specific value, value set, or "
                "range of a column, feel free to bake that value or range into the new "
                "table name so siblings remain distinguishable. Do NOT invent "
                "values that are not listed above. Avoid ordinal naming such as "
                "'q1/q2', 'part1/part2', or numeric suffix-only distinctions.\n"
            )

        style_req = {
            "snake_case": "snake_case (lowercase_with_underscores)",
            "camelCase": "camelCase",
            "PascalCase": "PascalCase",
            "abbrev_snake": "abbreviated_snake_case (short underscores)",
        }.get(style, style)

        prompts_base = os.path.join(os.path.dirname(__file__), "prompts")
        with open(os.path.join(prompts_base, "naming_final_user.txt"), "r", encoding="utf-8") as f:
            prompt_tmpl = f.read()
        prompt = prompt_tmpl.format(
            style_req=style_req,
            tables_text=tables_text,
            hints_block=hints_block,
        )

        with open(os.path.join(prompts_base, "naming_final_system.txt"), "r", encoding="utf-8") as f:
            system_msg = f.read().strip()
        api_params = {
            "model": config.llm_model,
            "messages": [
                {"role": "system", "content": system_msg},
                {"role": "user", "content": prompt},
            ],
            "response_format": {"type": "json_object"},
        }
        if _model_supports_temperature(config.llm_model):
            api_params["temperature"] = 0.7

        response = client.chat.completions.create(**api_params)
        raw_content = response.choices[0].message.content or ""
        content = raw_content.strip()

        if output_dir:
            prompts_dir = os.path.join(output_dir, "llm_prompts")
            os.makedirs(prompts_dir, exist_ok=True)
            with open(os.path.join(prompts_dir, f"naming_drift_local_{local_idx + 1}_prompt.txt"), "w", encoding="utf-8") as fp:
                fp.write(prompt)
            with open(os.path.join(prompts_dir, f"naming_drift_local_{local_idx + 1}_response.txt"), "w", encoding="utf-8") as fp:
                fp.write(content)
            with open(os.path.join(prompts_dir, f"naming_drift_local_{local_idx + 1}_raw_response.json"), "w", encoding="utf-8") as fp:
                fp.write(_serialize_openai_response(response))

        if not content:
            finish_reason = None
            try:
                finish_reason = response.choices[0].finish_reason
            except Exception:
                pass
            raise RuntimeError(
                f"LLM naming returned empty content for local {local_idx} "
                f"(finish_reason={finish_reason!r}, model={config.llm_model})"
            )

        result = _parse_llm_json_payload(content)
        llm_table_renames = result.get("table_renames", {}) or {}
        llm_column_renames = result.get("column_renames", {}) or {}

        local_table_names = sorted(local.tables.keys())
        selected_tables = _selected_tables_for_local(local_idx, local_table_names)

        # Start from identity everywhere, then keep only the selected subset's LLM renames.
        final_tmap: Dict[str, str] = {}
        final_cmap: Dict[str, Dict[str, str]] = {}
        for lt_name, lt in local.tables.items():
            if lt_name in selected_tables:
                new_t = _clean_llm_identifier(
                    llm_table_renames.get(lt_name, lt_name),
                    fallback=lt_name,
                )
                final_tmap[lt_name] = new_t
                llm_cols = llm_column_renames.get(lt_name, {}) or {}
                col_map: Dict[str, str] = {}
                for local_col in lt.column_map.keys():
                    col_map[local_col] = _clean_llm_identifier(
                        llm_cols.get(local_col, local_col),
                        fallback=local_col,
                    )
                final_cmap[lt_name] = col_map
            else:
                final_tmap[lt_name] = lt_name
                final_cmap[lt_name] = {local_col: local_col for local_col in lt.column_map.keys()}

        # If a selected table has an intra-local FK to an unselected table, preserve the
        # FK endpoint column names on the selected side. This avoids LLM-chosen names that
        # semantically depend on a target table name we intentionally kept unchanged.
        for fk_entry in fk_entries:
            for pair in fk_entry.get("intra_local_pairs", []) or []:
                if pair.get("local") != local.local_name:
                    continue
                from_t = pair.get("from_local_table")
                to_t = pair.get("to_local_table")
                from_c = pair.get("from_local_column")
                to_c = pair.get("to_local_column")
                if not from_t or not to_t or not from_c or not to_c:
                    continue
                if from_t in selected_tables and to_t not in selected_tables:
                    if from_t in final_cmap and from_c in final_cmap[from_t]:
                        final_cmap[from_t][from_c] = from_c
                if to_t in selected_tables and from_t not in selected_tables:
                    if to_t in final_cmap and to_c in final_cmap[to_t]:
                        final_cmap[to_t][to_c] = to_c

        table_renames[local_idx] = final_tmap
        column_renames[local_idx] = final_cmap

    return table_renames, column_renames, casing


def apply_final_renames_in_place(
    schema_graph: SchemaGraph,
    locals_list: List[LocalSchema],
    fk_map: Dict,
    vertical_split_map: Dict,
    row_partition_map: Dict,
    table_renames: Dict[int, Dict[str, str]],
    column_renames: Dict[int, Dict[str, Dict[str, str]]],
    casing_meta: Dict[str, str],
) -> Dict:
    """
    Apply table/column renames to locals_list and update FK endpoints + mapping dicts.
    Returns rename_map_full to store in TransformSpec.
    """
    # Build per-local full mapping (old->new) for tables
    per_local_table_map: Dict[str, Dict[str, str]] = {}
    per_local_col_map: Dict[str, Dict[str, Dict[str, str]]] = {}
    rename_map_full: Dict[str, Dict] = {}

    for local_idx, local in enumerate(locals_list):
        tmap = table_renames.get(local_idx, {}) or {}
        cmap = column_renames.get(local_idx, {}) or {}
        per_local_table_map[local.local_name] = tmap
        per_local_col_map[local.local_name] = cmap
        rename_map_full[local.local_name] = {
            "table_renames": tmap,
            "column_renames": cmap,
            "naming_case_style": casing_meta.get(local.local_name),
        }

    # Apply to locals_list
    for local_idx, local in enumerate(locals_list):
        tmap = per_local_table_map.get(local.local_name, {})
        cmap_by_table = per_local_col_map.get(local.local_name, {})
        new_tables: Dict[str, TableTransform] = {}

        for old_name, tt in list(local.tables.items()):
            new_name = tmap.get(old_name, old_name)
            tt.local_table = new_name

            # Update peer/partner references
            if tt.vertical_split_peers:
                tt.vertical_split_peers = [tmap.get(p, p) for p in tt.vertical_split_peers]
            if tt.row_partition_partner:
                tt.row_partition_partner = tmap.get(tt.row_partition_partner, tt.row_partition_partner)
            if tt.row_partition_peers:
                tt.row_partition_peers = [tmap.get(p, p) for p in tt.row_partition_peers]

            # Apply column renames for this table
            col_rename = cmap_by_table.get(old_name, {}) or {}
            new_cmap: Dict[str, str] = {}
            for old_col_local, orig_col in tt.column_map.items():
                new_col_local = col_rename.get(old_col_local, old_col_local)
                new_cmap[new_col_local] = orig_col
            tt.column_map = new_cmap
            new_tables[new_name] = tt

        local.tables = new_tables

    # Update FK map endpoints to renamed local tables/columns
    fk_entries = (fk_map or {}).get("foreign_keys") or []
    for fk_entry in fk_entries:
        for key in ("intra_local_pairs", "dropped_intra_local_pairs"):
            pairs = fk_entry.get(key) or []
            for p in pairs:
                loc = p.get("local")
                if not loc:
                    continue
                tmap = per_local_table_map.get(loc, {})
                cmap_by_table = per_local_col_map.get(loc, {})
                old_from_t = p.get("from_local_table")
                old_to_t = p.get("to_local_table")
                p["from_local_table"] = tmap.get(old_from_t, old_from_t)
                p["to_local_table"] = tmap.get(old_to_t, old_to_t)
                # Columns
                from_col_map = cmap_by_table.get(old_from_t, {}) or {}
                to_col_map = cmap_by_table.get(old_to_t, {}) or {}
                fc = p.get("from_local_column")
                tc = p.get("to_local_column")
                p["from_local_column"] = from_col_map.get(fc, fc)
                p["to_local_column"] = to_col_map.get(tc, tc)

        for key in ("cross_local_pairs", "dropped_cross_local_pairs"):
            pairs = fk_entry.get(key) or []
            for p in pairs:
                from_loc = p.get("from_local")
                to_loc = p.get("to_local")
                if from_loc:
                    tmap = per_local_table_map.get(from_loc, {})
                    cmap_by_table = per_local_col_map.get(from_loc, {})
                    old_from_t = p.get("from_local_table")
                    p["from_local_table"] = tmap.get(old_from_t, old_from_t)
                    fc = p.get("from_local_column")
                    p["from_local_column"] = (cmap_by_table.get(old_from_t, {}) or {}).get(fc, fc)
                if to_loc:
                    tmap = per_local_table_map.get(to_loc, {})
                    cmap_by_table = per_local_col_map.get(to_loc, {})
                    old_to_t = p.get("to_local_table")
                    p["to_local_table"] = tmap.get(old_to_t, old_to_t)
                    tc = p.get("to_local_column")
                    p["to_local_column"] = (cmap_by_table.get(old_to_t, {}) or {}).get(tc, tc)

    # Update vertical_split_map / row_partition_map local_table fields
    for orig, entry in (vertical_split_map or {}).items():
        for frag in entry.get("fragments", []) or []:
            loc = frag.get("local_name")
            if not loc:
                continue
            tmap = per_local_table_map.get(loc, {})
            old_lt = frag.get("local_table")
            frag["local_table"] = tmap.get(old_lt, old_lt)
            rpn = frag.get("row_partition_names")
            if rpn:
                frag["row_partition_names"] = [tmap.get(x, x) for x in rpn]

    for orig, entry in (row_partition_map or {}).items():
        # New multi-way format
        if "partition_names" in entry and "partition_locals" in entry:
            old_names = list(entry.get("partition_names", []))
            new_names = []
            for pname, ploc in zip(old_names, entry.get("partition_locals", [])):
                tmap = per_local_table_map.get(ploc, {}) if ploc else {}
                new_names.append(tmap.get(pname, pname))
            entry["partition_names"] = new_names
            pmap = dict(zip(old_names, new_names))
            for key in ("home_fragment", "movable_fragment", "default_movable_fragment"):
                v = entry.get(key)
                if isinstance(v, str) and v in pmap:
                    entry[key] = pmap[v]
            if isinstance(entry.get("movable_fragments"), list):
                entry["movable_fragments"] = [
                    pmap.get(x, x) for x in entry["movable_fragments"]
                ]
            continue

        # Legacy two-way format (backward compatibility)
        a_loc = entry.get("partition_a_local")
        b_loc = entry.get("partition_b_local")
        if a_loc:
            tmap = per_local_table_map.get(a_loc, {})
            entry["partition_a"] = tmap.get(entry.get("partition_a"), entry.get("partition_a"))
        if b_loc:
            tmap = per_local_table_map.get(b_loc, {})
            entry["partition_b"] = tmap.get(entry.get("partition_b"), entry.get("partition_b"))

    return rename_map_full

def _fallback_naming(
    schema_graph: SchemaGraph,
    groups: List[Set[str]],
    config: DifficultyConfig,
) -> Tuple[Dict[int, Dict[str, str]], Dict[int, Dict[str, Dict[str, str]]]]:
    """Deterministic fallback naming when LLM is not available."""
    table_renames = {}
    column_renames = {}

    for local_idx, group in enumerate(groups):
        tr, cr = _fallback_naming_single(schema_graph, group, local_idx, config)
        table_renames[local_idx] = tr
        column_renames[local_idx] = cr

    return table_renames, column_renames


def _fallback_naming_single(
    schema_graph: SchemaGraph,
    group: Set[str],
    local_idx: int,
    config: DifficultyConfig,
) -> Tuple[Dict[str, str], Dict[str, Dict[str, str]]]:
    """Generate deterministic renames for a single local."""
    rng = random.Random(config.seed + local_idx * 1000)
    
    # Naming convention per local
    conventions = [_to_snake_case, _to_camel_case, _abbreviate, _to_snake_case]
    conv = conventions[local_idx % len(conventions)]

    table_renames = {}
    column_renames = {}

    def _stable_int(s: str) -> int:
        """Stable hash -> int, independent of PYTHONHASHSEED / process."""
        import hashlib
        return int(hashlib.md5(s.encode("utf-8")).hexdigest(), 16)

    for table_name in sorted(group):
        # Table rename
        if table_name in FALLBACK_TABLE_RENAMES:
            options = FALLBACK_TABLE_RENAMES[table_name]
            chosen_idx = (local_idx + _stable_int(table_name)) % len(options)
            table_renames[table_name] = options[chosen_idx]
        else:
            table_renames[table_name] = conv(table_name)

        # Column renames
        tbl = schema_graph.tables[table_name]
        col_renames = {}
        for col in tbl.columns:
            if rng.random() < config.rename_rate:
                # Check if we have a pre-built rename
                base_name = col.name
                # Strip table prefix for lookup
                for suffix in ['Id', 'Ref', 'Name']:
                    if base_name.endswith(suffix) and len(base_name) > len(suffix):
                        base_name_root = base_name[:-len(suffix)]
                        break
                else:
                    base_name_root = base_name

                if col.name in FALLBACK_COLUMN_RENAMES:
                    options = FALLBACK_COLUMN_RENAMES[col.name]
                    chosen_idx = (local_idx + _stable_int(col.name)) % len(options)
                    col_renames[col.name] = options[chosen_idx]
                elif col.name.endswith('Id'):
                    # Rename ID columns
                    prefix = _to_snake_case(col.name[:-2])
                    suffixes = ['_key', '_ref', '_num', '_fk']
                    col_renames[col.name] = prefix + suffixes[local_idx % len(suffixes)]
                else:
                    col_renames[col.name] = conv(col.name)
            else:
                col_renames[col.name] = col.name  # keep original

        column_renames[table_name] = col_renames

    return table_renames, column_renames


# ──────────────────────────────────────────────
# OP3: Vertical fragmentation (column-wise split)
# ──────────────────────────────────────────────


@dataclass
class VerticalSplitPlan:
    """Lossless vertical split: PK repeated in every fragment; non-PK columns clustered (may overlap)."""

    original_table: str
    pk_columns: List[str]
    fragments: List[Tuple[str, List[str]]]  # (suffix, non_pk_columns)
    # Diagnostics from vertical_split.plan_vertical_column_groups (JSON-serializable)
    clustering_meta: Optional[Dict] = None


def select_tables_for_vertical_split(
    schema_graph: SchemaGraph,
    groups: List[Set[str]],
    config: DifficultyConfig,
    db_path: str,
) -> Tuple[List[VerticalSplitPlan], Dict]:
    """
    Select tables for vertical (column-wise) splitting.

    Uses sentence-transformer embeddings (default BGE-small-en-v1.5) with TF-IDF
    fallback, KMeans on column_semantic_enrichment.json (alternative_names +
    description), k in {2,3,4}, min fragment width, and optional border overlap.
    Tables without a loadable enrichment file still cluster on column names only.

    Returns (plans, selection_meta). selection_meta documents which tables were
    chosen and why (rates, wide-table rule); see DOCUMENTATION.md.
    """
    rng = random.Random(config.seed + 7)
    max_frag = getattr(config, "vertical_split_max_fragments", 4)
    overlap_frac = getattr(config, "vertical_split_overlap_fraction", 0.15)
    embed_model = getattr(
        config,
        "vertical_split_embedding_model",
        "BAAI/bge-small-en-v1.5",
    )
    enrich_override = getattr(config, "column_semantic_enrichment_path", None)
    enrich_path = enrich_override or os.path.join(
        os.path.dirname(os.path.abspath(db_path)),
        "column_semantic_enrichment.json",
    )
    enrichment_data = load_column_enrichment_json(enrich_path)
    
    all_tables = []
    for group in groups:
        all_tables.extend(group)

    candidates = []
    for tname in all_tables:
        tbl = schema_graph.tables[tname]
        if not tbl.primary_keys:
            continue
        non_pk_cols = [c.name for c in tbl.columns if not c.is_pk]
        if len(non_pk_cols) >= 2:
            candidates.append((tname, len(non_pk_cols)))

    candidates.sort(key=lambda x: (-x[1], x[0]))

    num_from_rate = max(1, round(len(all_tables) * config.split_rate))
    wide_count = sum(1 for _, ncols in candidates if ncols >= 10)
    num_to_split = max(num_from_rate, wide_count)
    num_to_split = min(num_to_split, len(candidates))

    selected = [c[0] for c in candidates[:num_to_split]]
    plans: List[VerticalSplitPlan] = []

    selection_meta: Dict = {
        "split_rate": config.split_rate,
        "vertical_split_max_fragments": max_frag,
        "rng_seed_additive": 7,
        "total_tables_across_locals": len(all_tables),
        "eligible_candidate_count": len(candidates),
        "num_selected_for_vertical_split": len(selected),
        "num_from_rate_alone": num_from_rate,
        "wide_non_pk_threshold": 10,
        "count_wide_eligible_tables": wide_count,
        "selected_original_tables": list(selected),
        "sort_order": "descending by non_pk_column_count, then table name",
        "column_semantic_enrichment_path_resolved": enrich_path,
        "column_semantic_enrichment_loaded": enrichment_data is not None,
        "vertical_split_overlap_fraction": overlap_frac,
        "vertical_split_embedding_model": embed_model,
    }

    skipped: List[Dict[str, str]] = []
    for tname in selected:
        tbl = schema_graph.tables[tname]
        pk_cols = list(tbl.primary_keys)
        non_pk_cols = [c.name for c in tbl.columns if c.name not in pk_cols]
        built = build_vertical_split_fragments(
            tname,
            pk_cols,
            non_pk_cols,
            rng,
            max_frag,
            enrichment=enrichment_data,
            overlap_fraction=overlap_frac,
            embedding_model=embed_model,
        )
        if built is None:
            skipped.append(
                {
                    "table": tname,
                    "reason": "semantic_clustering_infeasible_or_no_valid_k",
                }
            )
            continue
        frags, clustering_meta = built
        plans.append(
            VerticalSplitPlan(
            original_table=tname,
            pk_columns=pk_cols,
                fragments=frags,
                clustering_meta=clustering_meta,
        )
        )

    selection_meta["vertical_split_skipped_after_clustering"] = skipped
    return plans, selection_meta


# ──────────────────────────────────────────────
# Horizontal fragmentation (AFD-based F-way row partition)
# ──────────────────────────────────────────────


@dataclass
class RowPartition:
    """F-way horizontal row partition (UNION / set union when overlap > 0).

    F = ``num_partitions`` — number of fragments this table is split into.
    Separate from K (the number of locals). The list-valued fields below are
    all length F and ordered identically; the first entry is the
    ``home_fragment``.
    """
    original_table: str
    predicate_column: str
    num_partitions: int  # == F (number of fragments for this table)
    partition_names: List[str]
    partition_values: List[object]
    predicate_sqls: List[str]
    # Predicates before overlap injection; same length as ``predicate_sqls``.
    base_predicate_sqls: List[str] = field(default_factory=list)
    predicate_kind: str = ""
    fragment_roles: List[str] = field(default_factory=list)
    home_fragment: str = ""
    movable_fragments: List[str] = field(default_factory=list)
    default_movable_fragment: str = ""
    # 10-15% row overlap added to mirror rows into neighbour fragments.
    overlap_ratio: float = 0.0
    has_overlap: bool = False
    # AFD audit for metadata (chosen column, coverage, mean_strong, score).
    afd_audit: Dict[str, Any] = field(default_factory=dict)
    # Legacy A/B fields retained for backwards compatibility with any
    # downstream consumer that hasn't migrated to the list-valued fields.
    predicate_sql_fragment_A: str = ""
    predicate_sql_fragment_B: str = ""
    fragment_role_A: str = ""
    fragment_role_B: str = ""
    # Deprecated: first non-home fragment, kept for backwards compatibility.
    movable_fragment: str = ""
    # When set, row split applies to this vertical fragment only (predicates on original DB)
    vertical_fragment_suffix: Optional[str] = None


def select_tables_for_row_partition(
    schema_graph: SchemaGraph,
    groups: List[Set[str]],
    config: DifficultyConfig,
    db_path: str,
    vsplit_plans: Optional[Dict[str, VerticalSplitPlan]] = None,
) -> List[RowPartition]:
    """Pick tables for AFD-based F-way row splits.

    Predicates are always evaluated on the **original** SQLite table (same row
    universe as vertical fragments). At most one horizontal plan per logical
    original table is kept (best among whole-table vs each vertical fragment),
    ranked by AFD ``score = mean_strong * coverage``.
    """
    all_tables: List[str] = []
    for group in groups:
        all_tables.extend(sorted(group))

    unique_tables = sorted(set(all_tables))
    num_to_partition = max(0, round(len(unique_tables) * config.row_partition_rate))

    vsplit_plans = vsplit_plans or {}
    raw_plans: List[Dict[str, object]] = []

    for tname in unique_tables:
        if tname not in vsplit_plans:
            plan = choose_partition_for_table(schema_graph, tname, db_path, config)
            if not plan:
                continue
            plan["source_table"] = tname
            plan["vertical_fragment_suffix"] = None
            raw_plans.append(plan)
            continue

        vplan = vsplit_plans[tname]
        base_renamed = tname
        for suf, non_pk in vplan.fragments:
            fname = f"{base_renamed}_{suf}"
            allowed = set(non_pk)
            plan = choose_partition_for_vertical_fragment(
                schema_graph,
                tname,
                db_path,
                config,
                fname,
                allowed,
            )
            if not plan:
                continue
            plan["source_table"] = tname
            plan["vertical_fragment_suffix"] = suf
            raw_plans.append(plan)

    if not raw_plans:
        return []

    def _afd_score(p: Dict[str, Any]) -> float:
        audit = p.get("afd_audit") or {}
        return float(audit.get("score", 0.0) or 0.0)

    def _mean_strong(p: Dict[str, Any]) -> float:
        return float((p.get("afd_audit") or {}).get("mean_strong", 0.0) or 0.0)

    def _coverage(p: Dict[str, Any]) -> float:
        return float((p.get("afd_audit") or {}).get("coverage", 0.0) or 0.0)

    by_table: Dict[str, List[Dict[str, Any]]] = {}
    for p in raw_plans:
        st = str(p["source_table"])
        by_table.setdefault(st, []).append(p)

    one_per_table: List[Dict[str, Any]] = []
    for tname in sorted(by_table.keys()):
        cands = sorted(
            by_table[tname],
            key=lambda p: (
                -_afd_score(p),
                -_mean_strong(p),
                -_coverage(p),
                -float(p.get("balance", 0)),
                str(p.get("vertical_fragment_suffix") or ""),
            ),
        )
        one_per_table.append(cands[0])

    one_per_table.sort(
        key=lambda p: (
            -_afd_score(p),
            -_mean_strong(p),
            -_coverage(p),
            -float(p.get("balance", 0)),
            str(p["source_table"]),
        )
    )
    num_to_partition = min(num_to_partition, len(one_per_table))
    selected = one_per_table[:num_to_partition]

    partitions: List[RowPartition] = []
    for p in selected:
        tname = str(p["source_table"])
        col = str(p["col"])
        vfs = p.get("vertical_fragment_suffix")
        part_names = list(p["part_names"])
        F_val = int(p.get("F", len(part_names)))
        roles = list(p.get("fragment_roles", []))
        movables = list(p.get("movable_fragments", []))
        partitions.append(
            RowPartition(
                original_table=tname,
                predicate_column=col,
                num_partitions=F_val,
                partition_names=part_names,
                partition_values=list(p.get("partition_values", [])),
                predicate_sqls=list(p["predicate_sqls"]),
                base_predicate_sqls=list(p.get("base_predicate_sqls", [])),
                predicate_kind=str(p.get("predicate_kind", "")),
                fragment_roles=roles,
                home_fragment=str(p.get("home_fragment", part_names[0])),
                movable_fragments=movables,
                default_movable_fragment=str(
                    p.get("default_movable_fragment", movables[0] if movables else "")
                ),
                overlap_ratio=float(p.get("overlap_ratio", 0.0) or 0.0),
                has_overlap=bool(p.get("has_overlap", False)),
                afd_audit=dict(p.get("afd_audit") or {}),
                predicate_sql_fragment_A=str(p.get("predicate_sql_fragment_A", "")),
                predicate_sql_fragment_B=str(p.get("predicate_sql_fragment_B", "")),
                fragment_role_A=str(p.get("fragment_role_A", "")),
                fragment_role_B=str(p.get("fragment_role_B", "")),
                movable_fragment=str(movables[0] if movables else ""),
                vertical_fragment_suffix=str(vfs) if vfs is not None else None,
            )
        )
    return partitions


# ──────────────────────────────────────────────
# OP5: Boundary-table relocation
# ──────────────────────────────────────────────

def relocate_boundary_tables(
    groups: List[Set[str]],
    schema_graph: SchemaGraph,
    config: DifficultyConfig,
) -> Tuple[List[Set[str]], List[Dict]]:
    """
    Move peripheral tables across locals to create cross-local dependencies.
    Returns updated groups and list of moves made.
    """
    rng = random.Random(config.seed + 17)
    moves = []
    groups = [set(g) for g in groups]  # deep copy

    for _ in range(config.boundary_move_count):
        # Find peripheral tables (degree 1 in undirected FK graph)
        G_undirected = schema_graph.graph.to_undirected()
        candidates = []

        for i, group in enumerate(groups):
            if len(group) <= 2:
                continue
            for table in group:
                deg = G_undirected.degree(table) if table in G_undirected else 0
                if deg <= 2:
                    # Check if moving it would be meaningful
                    # (connected to tables in a different group)
                    for j, other_group in enumerate(groups):
                        if i == j:
                            continue
                        conn_score = _connectivity_score(table, other_group, schema_graph)
                        if conn_score > 0:
                            candidates.append((table, i, j, conn_score))

        if not candidates:
            break

        # Pick a move
        candidates.sort(key=lambda x: x[3], reverse=True)
        # Choose from top candidates
        table, from_idx, to_idx, score = candidates[0]

        groups[from_idx].remove(table)
        groups[to_idx].add(table)
        moves.append({
            "table": table,
            "from_local": from_idx,
            "to_local": to_idx,
            "connectivity_score": score,
        })

    return groups, moves


def _vertical_fragment_fk_touch_count(
    orig_table: str,
    non_pk: List[str],
    pk_cols: List[str],
    schema_graph: SchemaGraph,
) -> int:
    frag_cols = set(non_pk) | set(pk_cols)
    n = 0
    for fk in schema_graph.foreign_keys:
        if fk.from_table == orig_table and fk.from_column in frag_cols:
            n += 1
        if fk.to_table == orig_table and fk.to_column in frag_cols:
            n += 1
    return n


def _format_literal_for_hint(val: object) -> str:
    if val is None:
        return "NULL"
    if isinstance(val, str):
        return repr(val)
    return str(val)


def _describe_row_partitions_for_naming(
    meta: Dict[str, Any],
    allowed: Optional[Set[str]] = None,
) -> List[str]:
    """
    Plain-language row semantics per physical table name — no split / original-table jargon.

    Handles AFD-based F-way fragments (1..N) as well as the legacy two-way
    predicate_kind vocabulary. If ``allowed`` is set, only lines for table
    names in that set are included (per-local prompts).
    """
    def want(n: str) -> bool:
        return allowed is None or n in allowed

    names = list(meta.get("partition_names") or [])
    col = meta.get("predicate_column") or ""
    kind = str(meta.get("predicate_kind") or "")
    pvals = list(meta.get("partition_values") or [])
    roles = list(meta.get("fragment_roles") or [])
    has_overlap = bool(meta.get("has_overlap", False))
    if not names or not col:
        return []

    # Intentionally omit overlap wording from naming hints: overlap is a
    # reconstruction/internal detail and including it makes the prompt easier.
    overlap_suffix = ""

    lines: List[str] = []

    # Legacy two-way kinds (retained for any leftover maps that predate the
    # AFD-based selector).
    if kind == "binary_categorical" and len(names) >= 2 and len(pvals) >= 2:
        v0, v1 = pvals[0], pvals[1]
        if want(names[0]):
            lines.append(
                f"- Table `{names[0]}`: every row has `{col}` = {_format_literal_for_hint(v0)}."
            )
        if want(names[1]):
            lines.append(
                f"- Table `{names[1]}`: every row has `{col}` = {_format_literal_for_hint(v1)}, "
                f"or `{col}` is NULL."
            )
        return lines
    if kind == "categorical_one_vs_rest" and len(names) >= 2 and pvals:
        dominant = pvals[0]
        if want(names[0]):
            lines.append(
                f"- Table `{names[0]}`: every row has `{col}` = {_format_literal_for_hint(dominant)}."
            )
        if want(names[1]):
            lines.append(
                f"- Table `{names[1]}`: every row has `{col}` different from that value, "
                f"or `{col}` is NULL."
            )
        return lines
    if kind in ("median_numeric", "median_date") and len(names) >= 2 and pvals:
        med = pvals[0]
        if want(names[0]):
            lines.append(
                f"- Table `{names[0]}`: non-null `{col}` is always ≤ the median "
                f"({_format_literal_for_hint(med)})."
            )
        if want(names[1]):
            lines.append(
                f"- Table `{names[1]}`: non-null `{col}` is always > that median, "
                f"or `{col}` is NULL."
            )
        return lines

    # AFD-based F-way (and fallback) path: emit one line per fragment.
    if kind.startswith("afd_"):
        F = len(names)
        quantile_labels: List[str] = []
        if kind in ("afd_numeric_quantile", "afd_date_quantile"):
            if F == 2:
                quantile_labels = ["lower half", "upper half"]
            elif F == 3:
                quantile_labels = ["lowest third", "middle third", "highest third"]
            elif F == 4:
                quantile_labels = ["lowest quartile", "second quartile",
                                   "third quartile", "highest quartile"]
            elif F == 5:
                quantile_labels = ["lowest quintile", "second quintile", "middle quintile",
                                   "fourth quintile", "highest quintile"]
            else:
                alpha = "abcdefghijklmnopqrstuvwxyz"
                quantile_labels = [
                    f"quantile bucket {alpha[i] if i < len(alpha) else f'group_{hex(i + 1)[2:]}' }"
                    for i in range(F)
                ]

        for i, pname in enumerate(names):
            if not want(pname):
                continue
            pv = pvals[i] if i < len(pvals) else None
            # Build the value descriptor piece that names can key on.
            value_hint: str = ""
            if isinstance(pv, dict):
                if pv.get("value") == "__OTHER__":
                    excluded = pv.get("excluded_values") or []
                    excl_txt = ", ".join(_format_literal_for_hint(v) for v in excluded)
                    value_hint = (
                        f"every row has `{col}` NOT IN ({excl_txt}) or `{col}` IS NULL "
                        f"(catch-all 'OTHER' bucket)"
                    )
                elif "value" in pv:
                    v = pv.get("value")
                    incl_null = bool(pv.get("includes_null", False))
                    null_tail = " (or `{col}` is NULL)".format(col=col) if incl_null else ""
                    value_hint = (
                        f"every row has `{col}` = {_format_literal_for_hint(v)}{null_tail}"
                    )
                elif "lower" in pv or "upper" in pv:
                    lo = pv.get("lower")
                    hi = pv.get("upper")
                    if lo is not None and hi is not None:
                        band = (
                            f"`{col}` is in the range ({_format_literal_for_hint(lo)}, "
                            f"{_format_literal_for_hint(hi)}]"
                        )
                    elif lo is not None:
                        band = f"`{col}` > {_format_literal_for_hint(lo)}"
                    elif hi is not None:
                        band = f"`{col}` <= {_format_literal_for_hint(hi)}"
                    else:
                        band = f"a fixed `{col}` band"
                    qtag = (
                        f" — {quantile_labels[i]} of `{col}`"
                        if i < len(quantile_labels)
                        else ""
                    )
                    incl_null = bool(pv.get("includes_null", False))
                    null_tail = f" (or `{col}` is NULL)" if incl_null else ""
                    value_hint = f"{band}{null_tail}{qtag}"

            if value_hint:
                lines.append(f"- Table `{pname}`: {value_hint}{overlap_suffix}.")
                continue

            role = roles[i] if i < len(roles) else None
            if role:
                lines.append(f"- Table `{pname}`: {role}{overlap_suffix}.")
            else:
                lines.append(
                    f"- Table `{pname}`: rows follow a fixed rule on `{col}`{overlap_suffix}."
                )
        return lines

    # Generic fallback.
    for i, pname in enumerate(names):
        if not want(pname):
            continue
        pv = pvals[i] if i < len(pvals) else None
        if pv is not None:
            lines.append(
                f"- Table `{pname}`: rows are tied to `{col}` = {_format_literal_for_hint(pv)}."
            )
        else:
            lines.append(f"- Table `{pname}`: rows follow a fixed rule on `{col}` (see schema).")
    return lines


def _build_naming_semantic_hints_for_local(
    row_partition_map: Dict[str, Any],
    local_table_names: Set[str],
) -> str:
    """Row-level hints only for physical tables that exist in this local schema."""
    lines: List[str] = []
    for _key, meta in sorted(row_partition_map.items(), key=lambda kv: str(kv[0])):
        lines.extend(_describe_row_partitions_for_naming(meta, allowed=local_table_names))
    return "\n".join(lines) if lines else ""


def _row_partition_storage_key(rp: RowPartition) -> str:
    """Stable key for row_partition_map JSON (composite when split is on a vertical fragment)."""
    if not rp.vertical_fragment_suffix:
        return rp.original_table
    return f"{rp.original_table}||vfrag={rp.vertical_fragment_suffix}"


def _refresh_vertical_split_local_names(
    vertical_split_map: Dict,
    locals_list: List[LocalSchema],
) -> None:
    """After relocating fragments, sync each fragment's local_name."""
    for meta in vertical_split_map.values():
        for fr in meta.get("fragments", []):
            names: List[str] = []
            if fr.get("row_partition_names"):
                names.extend(fr["row_partition_names"])
            elif fr.get("local_table"):
                names.append(fr["local_table"])
            for lt in names:
                for loc in locals_list:
                    if lt in loc.tables:
                        fr["local_name"] = loc.local_name
                        break


# ──────────────────────────────────────────────
# Task 4 logging (per-stage method + outcome)
# ──────────────────────────────────────────────


def _print_vertical_stage_report(
    selection_meta: Dict[str, Any],
    plans: List[VerticalSplitPlan],
) -> None:
    print("\n  [Transforms] Vertical split (column fragmentation)")
    print(
        f"    method: semantic_kmeans | split_rate={selection_meta.get('split_rate')} "
        f"| max_fragments={selection_meta.get('vertical_split_max_fragments')} "
        f"| embedding_model={selection_meta.get('vertical_split_embedding_model')}"
    )
    print(
        f"    selection: num_selected={selection_meta.get('num_selected_for_vertical_split')} "
        f"| wide_threshold={selection_meta.get('wide_non_pk_threshold')} "
        f"| enrichment_loaded={selection_meta.get('column_semantic_enrichment_loaded')}"
    )
    skipped = selection_meta.get("vertical_split_skipped_after_clustering") or []
    if skipped:
        print(f"    skipped_after_clustering ({len(skipped)}):")
        for s in skipped:
            print(
                f"      [skip] table={s.get('table')} reason={s.get('reason')}"
            )
    else:
        print("    skipped_after_clustering: none")
    if not plans:
        print("    result: [ok] no vertical splits applied (empty plan list)")
        return
    for p in plans:
        meta = p.clustering_meta or {}
        backend = meta.get("embedding_backend", "?")
        chosen_k = meta.get("chosen_k", len(p.fragments))
        path = meta.get("primary_path", "semantic_kmeans")
        status = "ok"
        if meta.get("skip_reason"):
            status = f"meta_has_skip_reason={meta.get('skip_reason')!r}"
        print(
            f"    [{status}] table={p.original_table} "
            f"path={path} embedding_backend={backend} chosen_k={chosen_k} "
            f"fragments_built={len(p.fragments)}"
        )
        if meta.get("clustering_tfidf_retry"):
            print("      note: clustering_tfidf_retry=True (ST retry path)")
        for suf, cols in p.fragments:
            print(
                f"      · fragment suffix={suf!r} non_pk_columns={len(cols)}"
            )


def _print_horizontal_stage_report(partitions: List[RowPartition]) -> None:
    print("\n  [Transforms] Horizontal row partition (AFD-based F-way split)")
    if not partitions:
        print("    result: [ok] no row partitions selected")
        return
    print(f"    applied: {len(partitions)} table(s)/fragment target(s)")
    for rp in partitions:
        vfs = rp.vertical_fragment_suffix
        scope = (
            f"vertical_fragment={vfs!r}"
            if vfs is not None
            else "whole_table"
        )
        audit = rp.afd_audit or {}
        print(
            f"    [ok] table={rp.original_table} scope={scope} "
            f"predicate_column={rp.predicate_column!r} predicate_kind={rp.predicate_kind!r} "
            f"F={rp.num_partitions} overlap={rp.overlap_ratio:.3f} "
            f"afd_score={audit.get('score', 0.0):.3f} "
            f"coverage={audit.get('coverage', 0.0):.3f} "
            f"partitions={list(rp.partition_names)}"
        )


def _print_relocation_stage_report(
    debug: Dict[str, Any],
    pending: Dict[Tuple[str, int], int],
) -> None:
    print("\n  [Transforms] Relocation (one-shot partner-based)")
    intents = debug.get("intents") or []
    skipped_early = debug.get("skipped") or []
    skipped_late = debug.get("skipped_after_order") or []
    print(
        f"    summary: intents_total={len(intents)} "
        f"| pending_moves={len(pending)} "
        f"| skipped_pre_order={len(skipped_early)} "
        f"| skipped_post_order={len(skipped_late)}"
    )
    print(
        "    note: the scorer emits ordered intents; fragment-level freezing may skip "
        "later intents. Only the fragments selected by the engine are moved (no automatic "
        "paired row-partition co-move)."
    )
    if skipped_early:
        for s in skipped_early:
            print(
                f"    [skip] source_table={s.get('source_table')} "
                f"reason={s.get('reason')}"
            )
    if skipped_late:
        for s in skipped_late[:20]:
            print(
                f"    [skip_after_order] source_table={s.get('source_table')} "
                f"reason={s.get('reason')}"
            )
        if len(skipped_late) > 20:
            print(f"    ... ({len(skipped_late) - 20} more skipped_after_order)")
    for (frag, src_i), tgt_i in sorted(pending.items()):
        print(
            f"    [ok] move fragment={frag!r} from local_{src_i + 1} -> local_{tgt_i + 1}"
        )
    if not intents:
        print("    result: [ok] no relocation intents (boundary/workload rules)")


# ──────────────────────────────────────────────
# Master transform orchestrator
# ──────────────────────────────────────────────

def apply_transforms(
    schema_graph: SchemaGraph,
    groups: List[Set[str]],
    config: DifficultyConfig,
    db_path: str,
    queries: Optional[List[str]] = None,
    output_dir: Optional[str] = None,
) -> Tuple[List[LocalSchema], TransformSpec]:
    """
    Apply all transformation operators to create local schemas.
    Returns local schemas and the full transform specification.
    """
    rng = random.Random(config.seed)
    reloc_rng = random.Random(config.seed + 1337)

    # Vertical (column-wise) split
    vsplits, vertical_split_selection_meta = select_tables_for_vertical_split(
        schema_graph,
        groups,
        config,
        db_path,
    )
    vsplit_tables = {p.original_table: p for p in vsplits}
    _print_vertical_stage_report(vertical_split_selection_meta, vsplits)

    # Horizontal two-way row partition (may target a vertical fragment; predicates use original DB)
    row_partitions = select_tables_for_row_partition(
        schema_graph, groups, config, db_path, vsplit_plans=vsplit_tables
    )
    _print_horizontal_stage_report(row_partitions)
    rpart_by_key = {(rp.original_table, rp.vertical_fragment_suffix or ""): rp for rp in row_partitions}
    rpart_orig_tables = {rp.original_table for rp in row_partitions}

    # Naming drift is applied LAST (after splits, relocation, and FK map).
    table_renames: Dict[int, Dict[str, str]] = {}
    column_renames: Dict[int, Dict[str, Dict[str, str]]] = {}

    locals_list: List[LocalSchema] = []
    rename_map_full = {}
    vertical_split_map_full: Dict = {}
    rpart_map_full: Dict = {}
    relocation_log: List[Dict] = []

    for local_idx, group in enumerate(groups):
        local_name = f"local_{local_idx + 1}"
        local_tables = {}
        local_table_rename: Dict[str, str] = {}
        local_col_rename: Dict[str, Dict[str, str]] = {}

        local_table_rename_inv = {v: k for k, v in local_table_rename.items()}

        for orig_table in sorted(group):
            col_map: Dict[str, str] = {}

            if orig_table in vsplit_tables:
                plan = vsplit_tables[orig_table]
                base_renamed = orig_table
                frag_meta: List[Tuple[str, List[str], str]] = []
                all_frag_names = [f"{base_renamed}_{suf}" for suf, _ in plan.fragments]

                for suf, non_pk in plan.fragments:
                    fname = f"{base_renamed}_{suf}"
                    cols_full = list(plan.pk_columns) + list(non_pk)
                    col_map_f = {c: c for c in cols_full}
                    peers = sorted(x for x in all_frag_names if x != fname)
                    rp = rpart_by_key.get((orig_table, suf))
                    if rp:
                        part_names = list(rp.partition_names)
                        F_here = len(part_names)
                        for i, (pname, pred_sql) in enumerate(zip(part_names, rp.predicate_sqls)):
                            rp_peers = [
                                part_names[(i + k) % F_here] for k in range(1, F_here)
                            ]
                            local_tables[pname] = TableTransform(
                                local_table=pname,
                    source_table=orig_table,
                                column_map=col_map_f,
                                projected_columns=list(cols_full),
                                row_predicate=pred_sql,
                                is_vertical_split_fragment=True,
                                is_row_partition=True,
                                vertical_fragment_suffix=suf,
                                vertical_split_peers=peers,
                                row_partition_partner=rp_peers[0] if rp_peers else None,
                                row_partition_peers=rp_peers,
                                row_partition_has_overlap=bool(rp.has_overlap),
                            )
                            local_table_rename_inv[pname] = orig_table
                        frag_meta.append((suf, list(non_pk), part_names[0]))
                    else:
                        local_tables[fname] = TableTransform(
                            local_table=fname,
                    source_table=orig_table,
                            column_map=col_map_f,
                            projected_columns=cols_full,
                            is_vertical_split_fragment=True,
                            vertical_fragment_suffix=suf,
                            vertical_split_peers=peers,
                        )
                        frag_meta.append((suf, list(non_pk), fname))
                        local_table_rename_inv[fname] = orig_table

                frag_indices = list(range(len(frag_meta)))
                anchor_fi = max(
                    frag_indices,
                    key=lambda i: (
                        len(frag_meta[i][1]),
                        _vertical_fragment_fk_touch_count(
                            orig_table,
                            frag_meta[i][1],
                            list(plan.pk_columns),
                            schema_graph,
                        ),
                        frag_meta[i][2],
                    ),
                )
                anchor_fname = frag_meta[anchor_fi][2]
                movable_candidates = sorted(
                    fname for _suf, _npk, fname in frag_meta if fname != anchor_fname
                )
                fk_touch = _vertical_fragment_fk_touch_count(
                    orig_table,
                    frag_meta[anchor_fi][1],
                    list(plan.pk_columns),
                    schema_graph,
                )
                local_table_rename[orig_table] = anchor_fname

                frag_dicts: List[Dict] = []
                for suf, non_pk, rep in frag_meta:
                    rp_here = rpart_by_key.get((orig_table, suf))
                    fd: Dict = {
                        "suffix": suf,
                        "non_pk_columns": non_pk,
                        "local_table": rep,
                        "local_name": local_name,
                        "vertical_fragment_base": f"{base_renamed}_{suf}",
                    }
                    if rp_here:
                        fd["row_partition_names"] = list(rp_here.partition_names)
                        fd["row_partition_predicate_column"] = rp_here.predicate_column
                    frag_dicts.append(fd)

                vertical_split_map_full[orig_table] = {
                    "pk_columns": list(plan.pk_columns),
                    "fragments": frag_dicts,
                    "column_clustering": plan.clustering_meta or {},
                    "anchor_fragment": anchor_fname,
                    "movable_candidates": movable_candidates,
                    "anchor_selection_reason": (
                        f"max_non_pk_columns={len(frag_meta[anchor_fi][1])};"
                        f"fk_column_endpoints_on_fragment={fk_touch}"
                    ),
                }

                for rp in row_partitions:
                    if rp.original_table != orig_table:
                        continue
                    if rp.vertical_fragment_suffix:
                        rk = _row_partition_storage_key(rp)
                        partitions_local = [local_name] * rp.num_partitions
                        rpart_map_full[rk] = {
                            "source_table": orig_table,
                            "vertical_fragment_suffix": rp.vertical_fragment_suffix,
                            "num_partitions": rp.num_partitions,
                            "partition_names": list(rp.partition_names),
                            "partition_locals": list(partitions_local),
                            "predicate_column": rp.predicate_column,
                            "partition_values": list(rp.partition_values),
                            "predicate_sqls": list(rp.predicate_sqls),
                            "base_predicate_sqls": list(rp.base_predicate_sqls),
                            "predicate_kind": rp.predicate_kind,
                            "fragment_roles": list(rp.fragment_roles),
                            "home_fragment": rp.home_fragment,
                            "movable_fragments": list(rp.movable_fragments),
                            "movable_fragment": rp.movable_fragment,
                            "default_movable_fragment": rp.default_movable_fragment,
                            "overlap_ratio": rp.overlap_ratio,
                            "has_overlap": rp.has_overlap,
                            "afd_audit": dict(rp.afd_audit or {}),
                            "predicate_sql_fragment_A": rp.predicate_sql_fragment_A,
                            "predicate_sql_fragment_B": rp.predicate_sql_fragment_B,
                            "fragment_role_A": rp.fragment_role_A,
                            "fragment_role_B": rp.fragment_role_B,
                        }

            elif orig_table in rpart_orig_tables and orig_table not in vsplit_tables:
                rp = rpart_by_key[(orig_table, "")]

                all_cols = [c.name for c in schema_graph.tables[orig_table].columns]
                col_map_full = {c: c for c in all_cols}

                part_names = list(rp.partition_names)
                F_here = len(part_names)
                for i, (pname, pred_sql) in enumerate(zip(part_names, rp.predicate_sqls)):
                    rp_peers = [
                        part_names[(i + k) % F_here] for k in range(1, F_here)
                    ]
                    local_tables[pname] = TableTransform(
                        local_table=pname,
                    source_table=orig_table,
                    column_map=col_map_full,
                        row_predicate=pred_sql,
                    is_row_partition=True,
                        vertical_fragment_suffix=None,
                        row_partition_partner=rp_peers[0] if rp_peers else None,
                        row_partition_peers=rp_peers,
                        row_partition_has_overlap=bool(rp.has_overlap),
                    )
                    local_table_rename_inv[pname] = orig_table

                local_table_rename[orig_table] = part_names[0]

                partitions_local = [local_name] * rp.num_partitions

                rpart_map_full[_row_partition_storage_key(rp)] = {
                    "source_table": orig_table,
                    "vertical_fragment_suffix": None,
                    "num_partitions": rp.num_partitions,
                    "partition_names": list(part_names),
                    "partition_locals": list(partitions_local),
                    "predicate_column": rp.predicate_column,
                    "partition_values": list(rp.partition_values),
                    "predicate_sqls": list(rp.predicate_sqls),
                    "base_predicate_sqls": list(rp.base_predicate_sqls),
                    "predicate_kind": rp.predicate_kind,
                    "fragment_roles": list(rp.fragment_roles),
                    "home_fragment": rp.home_fragment,
                    "movable_fragments": list(rp.movable_fragments),
                    "movable_fragment": rp.movable_fragment,
                    "default_movable_fragment": rp.default_movable_fragment,
                    "overlap_ratio": rp.overlap_ratio,
                    "has_overlap": rp.has_overlap,
                    "afd_audit": dict(rp.afd_audit or {}),
                    "predicate_sql_fragment_A": rp.predicate_sql_fragment_A,
                    "predicate_sql_fragment_B": rp.predicate_sql_fragment_B,
                    "fragment_role_A": rp.fragment_role_A,
                    "fragment_role_B": rp.fragment_role_B,
                }

            else:
                # Normal table: just rename
                new_name = orig_table
                all_cols = [c.name for c in schema_graph.tables[orig_table].columns]
                col_map_final = {c: c for c in all_cols}

                local_tables[new_name] = TableTransform(
                    local_table=new_name,
                    source_table=orig_table,
                    column_map=col_map_final,
                )
                local_table_rename_inv[new_name] = orig_table

        local_schema = LocalSchema(
            local_id=local_idx,
            local_name=local_name,
            tables=local_tables,
            table_rename_map=local_table_rename,
            table_rename_inv=local_table_rename_inv,
        )
        locals_list.append(local_schema)

        rename_map_full[local_name] = {
            "table_renames": local_table_rename,
            "column_renames": local_col_rename,
        }

    anchor_by_table: Dict[str, str] = {}
    for ot, meta in vertical_split_map_full.items():
        af = meta.get("anchor_fragment")
        if af:
            anchor_by_table[ot] = af

    movable_row_by_table: Dict[str, str] = {}
    for rp in row_partitions:
        movable_row_by_table[rp.original_table] = (
            rp.default_movable_fragment
            if rp.default_movable_fragment
            else (rp.partition_names[1] if len(rp.partition_names) > 1 else "")
        )

    reloc_engine_debug, pending_fragment_relocations, relocation_justifications = run_one_shot_relocation(
        locals_list,
        schema_graph,
        groups,
        queries or [],
        set(vsplit_tables.keys()),
        set(rpart_orig_tables),
        anchor_by_table,
        movable_row_by_table,
        reloc_rng,
        config=config,
    )
    _print_relocation_stage_report(reloc_engine_debug, pending_fragment_relocations)

    for (fn, src_i), tgt_i in pending_fragment_relocations.items():
        for _ot, meta in rpart_map_full.items():
            pns = meta.get("partition_names") or []
            if fn in pns:
                pi = int(pns.index(fn))
                pl = list(meta["partition_locals"])
                pl[pi] = f"local_{tgt_i + 1}"
                meta["partition_locals"] = pl
                break

    for (fragment_name, source_local_idx), target_local_idx in pending_fragment_relocations.items():
        source_local = locals_list[source_local_idx]
        target_local = locals_list[target_local_idx]
        
        if fragment_name in source_local.tables:
            # Safety: do not apply a relocation that would create a singleton local
            # (min 2 physical tables per local). The planner should already avoid this,
            # but we enforce it here too for robustness.
            if len(source_local.tables) - 1 < 2:
                print(
                    f"    [skip] relocation would create singleton local: "
                    f"{source_local.local_name} losing {fragment_name!r}",
                    flush=True,
                )
                continue
            fragment_transform = source_local.tables[fragment_name]
            extra = dict(relocation_justifications.get((fragment_name, source_local_idx), {}))
            if not extra:
                extra = {"method": "relocation_move", "note": "No engine justification entry (unexpected)."}
            relocation_log.append(
                {
                    "local_table": fragment_name,
                    "source_table": fragment_transform.source_table,
                    "kind": "row_partition" if fragment_transform.is_row_partition else "vertical_split_fragment",
                    "from_local": source_local.local_name,
                    "to_local": target_local.local_name,
                    "justification": extra,
                }
            )
            del source_local.tables[fragment_name]
            target_local.tables[fragment_name] = fragment_transform
            if fragment_name in source_local.table_rename_inv:
                otab = source_local.table_rename_inv[fragment_name]
                del source_local.table_rename_inv[fragment_name]
                target_local.table_rename_inv[fragment_name] = otab

    _refresh_vertical_split_local_names(vertical_split_map_full, locals_list)

    # Build FK map
    fk_map = _build_fk_map(schema_graph, locals_list, config, rng)

    # OP1 (last): Naming drift + theme generation on FINAL per-local schemas
    # Support both OPENAI_API_KEY and OPENAI_KEY env vars
    has_api_key = os.environ.get("OPENAI_API_KEY") or os.environ.get("OPENAI_KEY")
    if has_api_key and not os.environ.get("OPENAI_API_KEY"):
        os.environ["OPENAI_API_KEY"] = os.environ["OPENAI_KEY"]

    if getattr(config, "use_llm_naming", True):
        if has_api_key:
            print("\n  [Transforms] Naming drift (final locals)")
            print("    method: LLM (generate_llm_naming_final)")
            print("Using LLM-powered naming drift on final locals (no cache)...")
            try:
                tr, cr, casing_meta = generate_llm_naming_final(
                    schema_graph=schema_graph,
                    locals_list=locals_list,
                    fk_map=fk_map,
                    config=config,
                    db_path=db_path,
                    output_dir=output_dir,
                    row_partition_map=rpart_map_full,
                )
                print("    [ok] LLM naming completed")
            except Exception as e:
                print(f"    [ERROR] LLM naming failed: {e}")
                raise
        else:
            raise RuntimeError(
                "LLM naming drift is required, but OPENAI_API_KEY / OPENAI_KEY is not set."
            )
        table_renames = tr
        column_renames = cr
    else:
        print("\n  [Transforms] Naming drift — skipped (use_llm_naming=False)")
        casing_meta = {}

    # Apply renames to locals_list + maps (tables/columns + FK endpoints)
    rename_map_full = apply_final_renames_in_place(
        schema_graph=schema_graph,
        locals_list=locals_list,
        fk_map=fk_map,
        vertical_split_map=vertical_split_map_full,
        row_partition_map=rpart_map_full,
        table_renames=table_renames,
        column_renames=column_renames,
        casing_meta=casing_meta,
    )

    transform_spec = TransformSpec(
        locals=locals_list,
        rename_map=rename_map_full,
        vertical_split_map=vertical_split_map_full,
        row_partition_map=rpart_map_full,
        fk_map=fk_map,
        difficulty_config={
            "rename_rate": config.rename_rate,
            "split_rate": config.split_rate,
            "vertical_split_max_fragments": getattr(
                config, "vertical_split_max_fragments", 4
            ),
            "vertical_split_embedding_model": getattr(
                config,
                "vertical_split_embedding_model",
                "BAAI/bge-small-en-v1.5",
            ),
            "row_partition_rate": config.row_partition_rate,
            "fk_preserve_rate_intra_local": getattr(config, "fk_preserve_rate_intra_local", 0.95),
            "fk_preserve_rate_cross_local": getattr(config, "fk_preserve_rate_cross_local", 0.0),
            "use_llm_naming": config.use_llm_naming,
            "llm_model": config.llm_model,
            "naming_case_randomize": getattr(config, "naming_case_randomize", True),
            "naming_case_force_style": getattr(config, "naming_case_force_style", None),
        },
        seed=config.seed,
        vertical_split_selection=vertical_split_selection_meta,
        relocations=relocation_log,
        relocation_engine_debug=reloc_engine_debug,
    )

    return locals_list, transform_spec


def _build_fk_map(
    schema_graph: SchemaGraph,
    locals_list: List[LocalSchema],
    config: DifficultyConfig,
    rng: random.Random,
) -> Dict:
    """Build a map of where FK endpoints ended up in locals.
    
    Also tracks which FKs are intra-local (both endpoints in same local)
    vs cross-local (endpoints in different locals).
    """
    # Build table -> local mapping
    table_to_local = {}
    for local in locals_list:
        for lt_name, lt in local.tables.items():
            if lt.source_table not in table_to_local:
                table_to_local[lt.source_table] = []
            orig_to_local = {orig: local for local, orig in lt.column_map.items()}
            table_to_local[lt.source_table].append({
                "local": local.local_name,
                "local_table": lt_name,
                "column_map": lt.column_map,
                "orig_to_local": orig_to_local,
            })

    keep_intra = getattr(config, "fk_preserve_rate_intra_local", 0.95)
    keep_cross = getattr(config, "fk_preserve_rate_cross_local", 0.0)

    fk_entries = []
    for fk in schema_graph.foreign_keys:
        from_locations = table_to_local.get(fk.from_table, [])
        to_locations = table_to_local.get(fk.to_table, [])
        
        intra_local_pairs = []
        dropped_intra_local_pairs = []
        cross_local_pairs = []
        dropped_cross_local_pairs = []
        for from_loc in from_locations:
            for to_loc in to_locations:
                if from_loc["local"] == to_loc["local"]:
                    # Both fragments are in the same local
                    pair = {
                        "local": from_loc["local"],
                        "from_local_table": from_loc["local_table"],
                        "to_local_table": to_loc["local_table"],
                        "from_local_column": from_loc["orig_to_local"].get(fk.from_column),
                        "to_local_column": to_loc["orig_to_local"].get(fk.to_column),
                    }
                    # If a column is not present in a fragment (vertical split), skip this pair
                    if not pair["from_local_column"] or not pair["to_local_column"]:
                        continue
                    if rng.random() <= keep_intra:
                        intra_local_pairs.append(pair)
                    else:
                        dropped_intra_local_pairs.append(pair)
                else:
                    pair = {
                        "from_local": from_loc["local"],
                        "to_local": to_loc["local"],
                        "from_local_table": from_loc["local_table"],
                        "to_local_table": to_loc["local_table"],
                        "from_local_column": from_loc["orig_to_local"].get(fk.from_column),
                        "to_local_column": to_loc["orig_to_local"].get(fk.to_column),
                    }
                    if not pair["from_local_column"] or not pair["to_local_column"]:
                        continue
                    if rng.random() <= keep_cross:
                        cross_local_pairs.append(pair)
                    else:
                        dropped_cross_local_pairs.append(pair)
        
        entry = {
            "original": {
                "from_table": fk.from_table,
                "from_column": fk.from_column,
                "to_table": fk.to_table,
                "to_column": fk.to_column,
                "origin": getattr(fk, "origin", "declared"),
            },
            "from_locations": from_locations,
            "to_locations": to_locations,
            "intra_local_pairs": intra_local_pairs,
            "dropped_intra_local_pairs": dropped_intra_local_pairs,
            "cross_local_pairs": cross_local_pairs,
            "dropped_cross_local_pairs": dropped_cross_local_pairs,
        }
        fk_entries.append(entry)

    return {"foreign_keys": fk_entries}


def transform_spec_to_dict(spec: TransformSpec) -> Dict:
    """Convert TransformSpec to JSON-serializable dictionary."""
    locals_data = []
    for local in spec.locals:
        tables_data = {}
        for lt_name, lt in local.tables.items():
            peers = lt.vertical_split_peers or []
            tables_data[lt_name] = {
                "source_table": lt.source_table,
                "column_map": lt.column_map,
                "projected_columns": lt.projected_columns,
                "row_predicate": lt.row_predicate,
                "is_vertical_split_fragment": lt.is_vertical_split_fragment,
                "vertical_split_peers": peers,
                # Legacy aliases for older tooling
                "is_hsplit_fragment": lt.is_vertical_split_fragment,
                "hsplit_partner": peers[0] if peers else None,
                "is_row_partition": lt.is_row_partition,
                "row_partition_partner": lt.row_partition_partner,
                "row_partition_peers": list(lt.row_partition_peers or []),
                "row_partition_has_overlap": bool(lt.row_partition_has_overlap),
                "vertical_fragment_suffix": getattr(lt, "vertical_fragment_suffix", None),
            }
        locals_data.append({
            "local_id": local.local_id,
            "local_name": local.local_name,
            "tables": tables_data,
            "table_rename_map": local.table_rename_map,
        })

    vmap = spec.vertical_split_map
    return {
        "locals": locals_data,
        "rename_map": spec.rename_map,
        "vertical_split_map": vmap,
        "split_map": vmap,
        "vertical_split_selection": spec.vertical_split_selection,
        "row_partition_map": spec.row_partition_map,
        "fk_map": spec.fk_map,
        "relocations": getattr(spec, "relocations", []),
        "relocation_engine_debug": getattr(spec, "relocation_engine_debug", {}) or {},
        "difficulty_config": spec.difficulty_config,
        "seed": spec.seed,
    }


def transform_spec_from_dict(d: Dict) -> TransformSpec:
    """Re-hydrate a TransformSpec from `transform_spec.json`."""
    locals_list: List[LocalSchema] = []
    for loc in d.get("locals", []):
        tables: Dict[str, TableTransform] = {}
        for lt_name, td in (loc.get("tables") or {}).items():
            tables[lt_name] = TableTransform(
                local_table=lt_name,
                source_table=td.get("source_table"),
                column_map=dict(td.get("column_map") or {}),
                projected_columns=td.get("projected_columns"),
                row_predicate=td.get("row_predicate"),
                is_vertical_split_fragment=bool(td.get("is_vertical_split_fragment")),
                vertical_split_peers=list(td.get("vertical_split_peers") or []),
                vertical_fragment_suffix=td.get("vertical_fragment_suffix"),
                is_row_partition=bool(td.get("is_row_partition")),
                row_partition_partner=td.get("row_partition_partner"),
                row_partition_peers=list(td.get("row_partition_peers") or []),
                row_partition_has_overlap=bool(td.get("row_partition_has_overlap")),
            )
        local_schema = LocalSchema(
            local_id=int(loc.get("local_id", 0)),
            local_name=loc.get("local_name"),
            tables=tables,
            table_rename_map=dict(loc.get("table_rename_map") or {}),
        )
        locals_list.append(local_schema)

    return TransformSpec(
        locals=locals_list,
        rename_map=d.get("rename_map") or {},
        vertical_split_map=(d.get("vertical_split_map") or d.get("split_map") or {}),
        row_partition_map=d.get("row_partition_map") or {},
        fk_map=d.get("fk_map") or {},
        difficulty_config=d.get("difficulty_config") or {},
        seed=int(d.get("seed", 0)),
        vertical_split_selection=d.get("vertical_split_selection") or {},
        relocations=list(d.get("relocations") or []),
        relocation_engine_debug=d.get("relocation_engine_debug") or {},
    )
