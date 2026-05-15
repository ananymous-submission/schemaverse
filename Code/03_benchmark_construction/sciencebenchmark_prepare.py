from __future__ import annotations

import json
import os
import re
import sqlite3
import sys
from dataclasses import dataclass, field
from typing import Dict, Iterable, Iterator, List, Optional, Sequence, Tuple


SCIENCEBENCHMARK_SCHEMAS: Dict[str, str] = {
    "cordis": "unics_cordis",
    "oncomx": "oncomx_v1_0_25",
    "sdss": "lite",
}


# ─────────────────────────────────────────────────────────────────────────────
#  pg_dump parsing
# ─────────────────────────────────────────────────────────────────────────────


@dataclass
class _ColumnDef:
    name: str
    pg_type: str
    not_null: bool = False
    default_sql: Optional[str] = None


@dataclass
class _TableDef:
    schema: str
    name: str
    columns: List[_ColumnDef] = field(default_factory=list)
    primary_key: List[str] = field(default_factory=list)
    foreign_keys: List[Dict[str, object]] = field(default_factory=list)
    copy_columns: List[str] = field(default_factory=list)
    dat_file: Optional[str] = None

    @property
    def column_names(self) -> List[str]:
        return [c.name for c in self.columns]

    @property
    def column_index(self) -> Dict[str, _ColumnDef]:
        return {c.name: c for c in self.columns}


_QUOTED_OR_BARE = r'(?:"((?:[^"]|"")+)"|([A-Za-z_][A-Za-z0-9_]*))'


def _strip_quotes(token: str) -> str:
    """Strip surrounding double quotes and decode doubled quotes ("" → ")."""
    if token is None:
        return token
    token = token.strip()
    if len(token) >= 2 and token[0] == '"' and token[-1] == '"':
        return token[1:-1].replace('""', '"')
    return token


def _split_qualified(qualified: str) -> Tuple[Optional[str], str]:
    """Split a possibly qualified identifier (schema.table) into (schema, name)."""
    schema: Optional[str] = None
    rest = qualified.strip()
    parts: List[str] = []
    cur: List[str] = []
    in_quote = False
    i = 0
    while i < len(rest):
        ch = rest[i]
        if ch == '"':
            cur.append(ch)
            in_quote = not in_quote
            i += 1
            continue
        if ch == "." and not in_quote:
            parts.append("".join(cur))
            cur = []
            i += 1
            continue
        cur.append(ch)
        i += 1
    parts.append("".join(cur))
    if len(parts) == 1:
        return None, _strip_quotes(parts[0])
    if len(parts) == 2:
        return _strip_quotes(parts[0]), _strip_quotes(parts[1])
    # Too many dots — keep the last as table and join the rest as schema.
    return _strip_quotes(".".join(parts[:-1])), _strip_quotes(parts[-1])


def _parse_column_list(raw: str) -> List[str]:
    """
    Parse a parenthesised, comma-separated identifier list as found in
    COPY (...), ALTER TABLE ... PRIMARY KEY (...), FOREIGN KEY (...) etc.
    Honours double-quoted identifiers (which may contain commas).
    """
    items: List[str] = []
    cur: List[str] = []
    in_quote = False
    for ch in raw:
        if ch == '"':
            cur.append(ch)
            in_quote = not in_quote
            continue
        if ch == "," and not in_quote:
            items.append(_strip_quotes("".join(cur)))
            cur = []
            continue
        cur.append(ch)
    if cur:
        items.append(_strip_quotes("".join(cur)))
    return [c for c in (s.strip() for s in items) if c]


def _split_top_level_commas(body: str) -> List[str]:
    """
    Split a CREATE TABLE column-list body on top-level commas, ignoring
    commas inside parentheses or double-quoted identifiers. Returns the
    raw segments (column definitions and table-level constraints).
    """
    out: List[str] = []
    cur: List[str] = []
    depth = 0
    in_quote = False
    for ch in body:
        if ch == '"':
            cur.append(ch)
            in_quote = not in_quote
            continue
        if not in_quote:
            if ch == "(":
                depth += 1
            elif ch == ")":
                depth -= 1
            elif ch == "," and depth == 0:
                out.append("".join(cur).strip())
                cur = []
                continue
        cur.append(ch)
    if cur:
        s = "".join(cur).strip()
        if s:
            out.append(s)
    return out


_COLUMN_LEAD_RE = re.compile(r'^(?:"((?:[^"]|"")+)"|([A-Za-z_][A-Za-z0-9_]*))\s+(.*)$', re.DOTALL)


def _parse_column_def(segment: str) -> Optional[_ColumnDef]:
    """
    Parse a single column line such as ``name character varying(255) NOT NULL``
    or ``"dec" double precision``. Returns None for table-level constraints
    (PRIMARY KEY, FOREIGN KEY, UNIQUE, CONSTRAINT …).
    """
    s = segment.strip().rstrip(",")
    head_upper = s.lstrip().upper()
    for kw in (
        "PRIMARY KEY",
        "FOREIGN KEY",
        "UNIQUE",
        "CHECK",
        "CONSTRAINT",
        "EXCLUDE",
        "LIKE ",
    ):
        if head_upper.startswith(kw):
            return None

    m = _COLUMN_LEAD_RE.match(s)
    if not m:
        return None
    name = _strip_quotes(m.group(1) if m.group(1) is not None else m.group(2))
    rest = m.group(3).strip()

    # Pull off NOT NULL / DEFAULT clauses; everything else is the type.
    not_null = False
    default_sql: Optional[str] = None

    upper_rest = rest.upper()
    if " NOT NULL" in (" " + upper_rest):
        not_null = True
        # We don't strip the literal NOT NULL from rest — type detection below
        # tolerates it because we strip non-type tokens manually.

    # DEFAULT extraction (best-effort).
    m_def = re.search(r"\bDEFAULT\b", rest, flags=re.IGNORECASE)
    if m_def:
        default_sql = rest[m_def.end():].strip()
        rest = rest[: m_def.start()].strip()

    # Drop NOT NULL / NULL trailing modifiers from the type string.
    rest = re.sub(r"\bNOT\s+NULL\b", "", rest, flags=re.IGNORECASE).strip()
    rest = re.sub(r"\bNULL\b", "", rest, flags=re.IGNORECASE).strip()
    pg_type = rest.strip().rstrip(",").strip() or "text"

    return _ColumnDef(
        name=name,
        pg_type=pg_type,
        not_null=not_null,
        default_sql=default_sql,
    )


_CREATE_TABLE_RE = re.compile(
    r"CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?(?P<qualified>[^\s(]+)\s*\((?P<body>[\s\S]*?)\)\s*;",
    re.IGNORECASE,
)
_COPY_RE = re.compile(
    r"COPY\s+(?P<qualified>[^\s(]+)\s*\((?P<cols>[^)]*)\)\s+FROM\s+'(?P<src>[^']+)'\s*;",
    re.IGNORECASE,
)
# psql ``\i $$PATH$$/<id>.dat`` directives; the table is named in the
# immediately preceding ``-- Data for Name: <table>; Type: TABLE DATA;
# Schema: <schema>;`` comment block, so we parse them with a linear scan.
_DATA_FOR_NAME_RE = re.compile(
    r"--\s*Data\s+for\s+Name:\s+(?P<name>[^;]+);\s*Type:\s+TABLE\s+DATA;\s*Schema:\s+(?P<schema>[^;]+);",
    re.IGNORECASE,
)
_INCLUDE_RE = re.compile(
    r"^\s*\\i\s+'?(?P<src>\$\$PATH\$\$/[^'\s]+\.dat)'?\s*$",
    re.IGNORECASE | re.MULTILINE,
)
_PRIMARY_KEY_RE = re.compile(
    r"ALTER\s+TABLE\s+(?:ONLY\s+)?(?P<qualified>[^\s]+)\s+ADD\s+CONSTRAINT\s+\S+\s+PRIMARY\s+KEY\s*\((?P<cols>[^)]*)\)",
    re.IGNORECASE,
)
_FOREIGN_KEY_RE = re.compile(
    r"ALTER\s+TABLE\s+(?:ONLY\s+)?(?P<qualified>[^\s]+)\s+ADD\s+CONSTRAINT\s+\S+\s+"
    r"FOREIGN\s+KEY\s*\((?P<cols>[^)]*)\)\s+REFERENCES\s+(?P<ref>[^\s(]+)\s*\((?P<refcols>[^)]*)\)",
    re.IGNORECASE,
)


def _parse_pg_dump(restore_sql_path: str, target_schema: str) -> Dict[str, _TableDef]:
    """
    Parse a single PostgreSQL ``restore.sql`` and return the table definitions
    for the requested schema (qualified by ``schema.table``). Tables outside the
    target schema are skipped. The returned dict is keyed by bare table name
    (the schema prefix is stripped because SQLite has no schemas).
    """
    with open(restore_sql_path, "r", encoding="utf-8", errors="replace") as fh:
        sql = fh.read()

    tables: Dict[str, _TableDef] = {}

    for m in _CREATE_TABLE_RE.finditer(sql):
        schema, name = _split_qualified(m.group("qualified"))
        if schema != target_schema:
            continue
        body = m.group("body")
        cols: List[_ColumnDef] = []
        for seg in _split_top_level_commas(body):
            c = _parse_column_def(seg)
            if c is not None:
                cols.append(c)
        # If the same table appears twice (defensive), keep the last definition.
        tables[name] = _TableDef(schema=schema, name=name, columns=cols)

    # The COPY blocks come in pairs:
    #   COPY <schema>.<tbl> (...) FROM stdin;
    #   \.
    #   COPY <schema>.<tbl> (...) FROM '$$PATH$$/<id>.dat';
    # The second one carries the actual data file path; the inline ``FROM stdin``
    # form is always followed by ``\.`` (i.e. empty payload). We capture the
    # external-file form below; the ``stdin`` form is ignored automatically
    # because it does not match the regex (no quoted source).
    for m in _COPY_RE.finditer(sql):
        schema, name = _split_qualified(m.group("qualified"))
        if schema != target_schema:
            continue
        if name not in tables:
            continue
        cols = _parse_column_list(m.group("cols"))
        src = m.group("src").strip()
        # Resolve $$PATH$$ to the real ``db/`` directory beside restore.sql.
        # In ScienceBenchmark, .dat files live at ``<db>/db/<id>.dat`` and
        # restore.sql lives at the same path, so $$PATH$$ resolves to ``.``.
        dat_relative = src.split("/")[-1]
        dat_path = os.path.join(os.path.dirname(restore_sql_path), dat_relative)
        tables[name].copy_columns = cols
        tables[name].dat_file = dat_path

    # ``\i $$PATH$$/<id>.dat`` directives (used by oncomx). Each include is
    # preceded a few lines earlier by ``-- Data for Name: <table>; Type:
    # TABLE DATA; Schema: <schema>;``. We walk the file linearly, tracking
    # the most-recent "Data for Name" header and assigning each include to
    # that table.
    last_data_table: Optional[Tuple[str, str]] = None
    for m in re.finditer(
        r"(?P<header>--\s*Data\s+for\s+Name:[^\n]+)|(?P<inc>^\s*\\i\s+'?\$\$PATH\$\$/[^'\s]+\.dat'?\s*$)",
        sql,
        flags=re.IGNORECASE | re.MULTILINE,
    ):
        header = m.group("header")
        inc = m.group("inc")
        if header is not None:
            hm = _DATA_FOR_NAME_RE.match(header)
            if hm:
                last_data_table = (
                    _strip_quotes(hm.group("schema").strip()),
                    _strip_quotes(hm.group("name").strip()),
                )
            else:
                last_data_table = None
            continue
        if inc is not None and last_data_table is not None:
            schema_for_data, name_for_data = last_data_table
            if schema_for_data != target_schema or name_for_data not in tables:
                last_data_table = None
                continue
            # Extract just the .dat filename from the include payload.
            inc_match = re.search(
                r"\$\$PATH\$\$/([^'\s]+\.dat)", inc, flags=re.IGNORECASE
            )
            if not inc_match:
                last_data_table = None
                continue
            dat_relative = inc_match.group(1)
            dat_path = os.path.join(os.path.dirname(restore_sql_path), dat_relative)
            tdef = tables[name_for_data]
            # Don't override an explicit COPY (cordis/sdss); only set if missing.
            if tdef.dat_file is None:
                tdef.dat_file = dat_path
                if not tdef.copy_columns:
                    # INSERT-format files don't carry a column list — fall back
                    # to the CREATE TABLE order, which is what
                    # ``INSERT INTO <t> VALUES (...)`` implicitly assumes.
                    tdef.copy_columns = list(tdef.column_names)
            last_data_table = None

    for m in _PRIMARY_KEY_RE.finditer(sql):
        schema, name = _split_qualified(m.group("qualified"))
        if schema != target_schema or name not in tables:
            continue
        tables[name].primary_key = _parse_column_list(m.group("cols"))

    for m in _FOREIGN_KEY_RE.finditer(sql):
        schema, name = _split_qualified(m.group("qualified"))
        if schema != target_schema or name not in tables:
            continue
        ref_schema, ref_name = _split_qualified(m.group("ref"))
        if ref_schema and ref_schema != target_schema:
            # Cross-schema FK — skip (the benchmark only uses production schema).
            continue
        tables[name].foreign_keys.append({
            "columns": _parse_column_list(m.group("cols")),
            "ref_table": ref_name,
            "ref_columns": _parse_column_list(m.group("refcols")),
        })

    return tables


# ─────────────────────────────────────────────────────────────────────────────
#  PostgreSQL → SQLite type mapping
# ─────────────────────────────────────────────────────────────────────────────


def _normalise_pg_type(pg_type: str) -> str:
    """Lowercase and strip parameterisation from a Postgres type spec."""
    t = pg_type.strip().lower()
    # Drop ``::regclass`` and similar casts that can appear in DEFAULTs (defensive).
    t = t.split("default")[0].strip()
    return t


def _is_boolean_type(pg_type: str) -> bool:
    return _normalise_pg_type(pg_type).startswith(("boolean", "bool"))


def _pg_to_sqlite_affinity(pg_type: str) -> str:
    """
    Map a Postgres type spec to a SQLite affinity. SQLite uses dynamic typing,
    so the affinity mostly drives downstream metadata (e.g. ``schema_parser``
    PRAGMA results). We err on the side of TEXT for things like dates so
    string comparisons in queries continue to behave the same way they do
    in PostgreSQL/SQLite text storage.
    """
    t = _normalise_pg_type(pg_type)
    if t.startswith(("smallint", "integer", "int", "bigint", "smallserial", "serial", "bigserial", "boolean", "bool")):
        return "INTEGER"
    if t.startswith(("real", "double precision", "double", "float", "money")):
        return "REAL"
    if t.startswith(("numeric", "decimal")):
        # NUMERIC affinity — preserves integer-vs-real best-effort but accepts text.
        return "NUMERIC"
    if t.startswith(("date", "time", "timestamp", "interval")):
        return "TEXT"
    if t.startswith(("uuid", "json", "jsonb", "xml", "bytea", "bit")):
        return "TEXT"
    # ``character`` / ``character varying`` / ``text`` and friends.
    return "TEXT"


def _quote_ident(name: str) -> str:
    return '"' + name.replace('"', '""') + '"'


def _build_create_table_sql(
    table: _TableDef,
    *,
    known_tables: Optional[Iterable[str]] = None,
) -> str:
    """
    Render a SQLite-compatible CREATE TABLE for the given parsed PG table.

    Notes:
      * Schema prefix is dropped (SQLite has no schemas).
      * PRIMARY KEY is rendered as a table-level constraint when present.
      * Foreign keys are emitted as table-level ``FOREIGN KEY`` clauses (no
        ``ON UPDATE/DELETE`` actions): they are not enforced during the bulk
        load (we set ``PRAGMA foreign_keys=OFF``) but they remain visible to
        ``PRAGMA foreign_key_list``, which the benchmark's schema parser
        relies on to build the FK graph used by partitioning and relocation.
      * FKs whose referenced table is not part of the materialised schema
        are dropped silently (defensive — matches the cross-schema filter in
        ``_parse_pg_dump``).
      * Column-level NOT NULL is omitted to be tolerant of ``\\N`` payloads
        in optional columns; the benchmark's downstream materializer uses
        relaxed constraints anyway (see materialize_locals.py).
    """
    known = set(known_tables) if known_tables is not None else None
    cols_sql: List[str] = []
    for c in table.columns:
        cols_sql.append(f"  {_quote_ident(c.name)} {_pg_to_sqlite_affinity(c.pg_type)}")
    constraints: List[str] = []
    if table.primary_key:
        pk_cols = ", ".join(_quote_ident(c) for c in table.primary_key)
        constraints.append(f"  PRIMARY KEY ({pk_cols})")
    for fk in table.foreign_keys:
        ref_table = fk.get("ref_table")
        if known is not None and ref_table not in known:
            continue
        cols = fk.get("columns") or []
        ref_cols = fk.get("ref_columns") or []
        if not cols or not ref_cols or len(cols) != len(ref_cols):
            continue
        col_list = ", ".join(_quote_ident(c) for c in cols)
        ref_list = ", ".join(_quote_ident(c) for c in ref_cols)
        constraints.append(
            f"  FOREIGN KEY ({col_list}) REFERENCES {_quote_ident(ref_table)} ({ref_list})"
        )
    body_lines = cols_sql + constraints
    return (
        f"CREATE TABLE {_quote_ident(table.name)} (\n"
        + ",\n".join(body_lines)
        + "\n);"
    )


# ─────────────────────────────────────────────────────────────────────────────
#  PostgreSQL TSV (.dat) reader
# ─────────────────────────────────────────────────────────────────────────────


_PG_ESCAPES = {
    "\\": "\\",
    "b": "\b",
    "f": "\f",
    "n": "\n",
    "r": "\r",
    "t": "\t",
    "v": "\v",
}


def _decode_pg_field(raw: str) -> Optional[str]:
    """
    Decode a single TSV field as written by ``COPY ... TO STDOUT`` (the same
    format ``pg_dump`` writes to .dat files): handles ``\\N`` (NULL), the
    standard backslash escapes (``\\t``, ``\\n``, ``\\r``, ``\\\\`` …),
    and ``\\xHH`` / ``\\OOO`` (hex / octal) sequences. Anything else after a
    backslash is passed through verbatim, matching ``COPY``'s behaviour.

    Hot path: most fields contain no backslash; we short-circuit those.
    """
    # Hot path: ~99% of fields in numeric/text data have no backslash.
    if "\\" not in raw:
        return raw
    if raw == "\\N":
        return None
    out: List[str] = []
    i = 0
    n = len(raw)
    while i < n:
        ch = raw[i]
        if ch != "\\" or i + 1 >= n:
            out.append(ch)
            i += 1
            continue
        nxt = raw[i + 1]
        if nxt in _PG_ESCAPES:
            out.append(_PG_ESCAPES[nxt])
            i += 2
            continue
        if nxt == "x" and i + 3 < n and all(
            c in "0123456789abcdefABCDEF" for c in raw[i + 2:i + 4]
        ):
            out.append(chr(int(raw[i + 2:i + 4], 16)))
            i += 4
            continue
        if nxt in "01234567":
            j = i + 1
            while j < min(i + 4, n) and raw[j] in "01234567":
                j += 1
            out.append(chr(int(raw[i + 1:j], 8)))
            i = j
            continue
        out.append(nxt)
        i += 2
    return "".join(out)


# Coercion strategy per column. Computed once per column and reused per row.
#   "TEXT"    → pass through (None or str)
#   "INT"     → int() with float() fallback for "1.0"-style values
#   "REAL"    → float()
#   "BOOL"    → t/f/true/false/1/0 → 1/0
_COERCE_KIND_TEXT = "TEXT"
_COERCE_KIND_INT = "INT"
_COERCE_KIND_REAL = "REAL"
_COERCE_KIND_BOOL = "BOOL"


def _column_coerce_kind(pg_type: str) -> str:
    if _is_boolean_type(pg_type):
        return _COERCE_KIND_BOOL
    affinity = _pg_to_sqlite_affinity(pg_type)
    if affinity == "INTEGER":
        return _COERCE_KIND_INT
    if affinity in ("REAL", "NUMERIC"):
        return _COERCE_KIND_REAL
    return _COERCE_KIND_TEXT


def _coerce_int(raw: Optional[str]):
    if raw is None or raw == "":
        return raw
    try:
        return int(raw)
    except ValueError:
        try:
            return int(float(raw))
        except ValueError:
            return raw


def _coerce_real(raw: Optional[str]):
    if raw is None or raw == "":
        return raw
    try:
        return float(raw)
    except ValueError:
        return raw


_BOOL_TRUE = frozenset({"t", "true", "y", "yes", "1"})
_BOOL_FALSE = frozenset({"f", "false", "n", "no", "0"})


def _coerce_bool(raw: Optional[str]):
    if raw is None:
        return None
    v = raw.strip().lower()
    if v in _BOOL_TRUE:
        return 1
    if v in _BOOL_FALSE:
        return 0
    return raw


def _iter_pg_dat_rows(path: str, num_columns: int) -> Iterator[List[Optional[str]]]:
    """
    Yield decoded rows from a PostgreSQL ``COPY`` .dat file. Returns NULLs
    for ``\\N`` fields. Empty trailing newlines and ``\\.`` end-of-data
    markers are tolerated. We expect ``num_columns`` per row and warn when
    a row is shorter.
    """
    with open(path, "r", encoding="utf-8", errors="replace", newline="") as fh:
        for raw_line in fh:
            line = raw_line.rstrip("\n")
            if line.endswith("\r"):
                line = line[:-1]
            if line == "\\.":
                break
            if line == "":
                # pg_dump occasionally emits a trailing blank line at end of file.
                continue
            fields = line.split("\t")
            if len(fields) < num_columns:
                # Pad with NULLs to keep the executemany cursor happy.
                fields = fields + ["\\N"] * (num_columns - len(fields))
            elif len(fields) > num_columns:
                # Glue extra fields back together into the last column. This
                # should never happen for well-formed pg_dump output; we keep
                # it as defensive insurance.
                head = fields[: num_columns - 1]
                tail = "\t".join(fields[num_columns - 1:])
                fields = head + [tail]
            yield [_decode_pg_field(f) for f in fields]


# ─────────────────────────────────────────────────────────────────────────────
#  INSERT-format .dat parser (used by oncomx).
#
#  Each row is a single line of the form
#    INSERT INTO <schema>.<table> [(<cols>)] VALUES (<v1>, <v2>, …);
#  The values are SQL literals: NULL, numbers, 'string' (with '' escape),
#  TRUE/FALSE, and occasionally E'…' (PostgreSQL C-style strings, although
#  oncomx emits standard-conforming literals throughout). We assume one
#  INSERT per line — verified empirically over the oncomx corpus — and fall
#  back to buffering subsequent lines if a literal happens to span multiple
#  lines (e.g. an embedded newline).
# ─────────────────────────────────────────────────────────────────────────────


def _split_sql_values(values: str) -> List[str]:
    """
    Split a parenthesised, comma-separated SQL ``VALUES`` body into individual
    raw literals (still as strings). Honours ``'…'`` literals with ``''``
    escape and tracks parenthesis depth defensively.
    """
    out: List[str] = []
    cur: List[str] = []
    in_str = False
    depth = 0
    n = len(values)
    i = 0
    while i < n:
        ch = values[i]
        if in_str:
            if ch == "'":
                if i + 1 < n and values[i + 1] == "'":
                    cur.append("''")
                    i += 2
                    continue
                in_str = False
                cur.append(ch)
                i += 1
                continue
            cur.append(ch)
            i += 1
            continue
        if ch == "'":
            in_str = True
            cur.append(ch)
            i += 1
            continue
        if ch == "(":
            depth += 1
            cur.append(ch)
            i += 1
            continue
        if ch == ")":
            if depth > 0:
                depth -= 1
                cur.append(ch)
                i += 1
                continue
            cur.append(ch)
            i += 1
            continue
        if ch == "," and depth == 0:
            out.append("".join(cur).strip())
            cur = []
            i += 1
            continue
        cur.append(ch)
        i += 1
    tail = "".join(cur).strip()
    if tail:
        out.append(tail)
    return out


_C_ESCAPE = {
    "n": "\n",
    "r": "\r",
    "t": "\t",
    "b": "\b",
    "f": "\f",
    "v": "\v",
    "\\": "\\",
    "'": "'",
    '"': '"',
    "0": "\x00",
}


def _decode_e_string(body: str) -> str:
    """Decode a PostgreSQL C-style string body (the part between E'…')."""
    out: List[str] = []
    i = 0
    n = len(body)
    while i < n:
        ch = body[i]
        if ch == "\\" and i + 1 < n:
            nxt = body[i + 1]
            if nxt in _C_ESCAPE:
                out.append(_C_ESCAPE[nxt])
                i += 2
                continue
            if nxt == "x" and i + 3 < n and all(
                c in "0123456789abcdefABCDEF" for c in body[i + 2:i + 4]
            ):
                out.append(chr(int(body[i + 2:i + 4], 16)))
                i += 4
                continue
            if nxt in "01234567":
                j = i + 1
                while j < min(i + 4, n) and body[j] in "01234567":
                    j += 1
                out.append(chr(int(body[i + 1:j], 8)))
                i = j
                continue
            out.append(nxt)
            i += 2
            continue
        if ch == "'" and i + 1 < n and body[i + 1] == "'":
            out.append("'")
            i += 2
            continue
        out.append(ch)
        i += 1
    return "".join(out)


def _decode_sql_literal(token: str):
    """
    Decode a single SQL literal as it appears inside an INSERT VALUES list.
    """
    s = token.strip()
    if not s:
        return None
    upper = s.upper()
    if upper == "NULL":
        return None
    if upper == "TRUE":
        return 1
    if upper == "FALSE":
        return 0
    # E'...' C-style string.
    if (s.startswith("E'") or s.startswith("e'")) and s.endswith("'") and len(s) >= 3:
        return _decode_e_string(s[2:-1])
    # Standard '...'  string with '' escape.
    if s.startswith("'") and s.endswith("'") and len(s) >= 2:
        return s[1:-1].replace("''", "'")
    # Numeric literal.
    try:
        if any(c in s for c in ".eE"):
            return float(s)
        return int(s)
    except ValueError:
        return s


_INSERT_PREFIX_RE = re.compile(
    r"^\s*INSERT\s+INTO\s+(?:[A-Za-z_][\w]*\.)?[A-Za-z_\"][\w\"]*"
    r"(?:\s*\([^)]*\))?\s*VALUES\s*\(",
    re.IGNORECASE,
)


def _iter_pg_insert_rows(path: str, num_columns: int) -> Iterator[List[Optional[object]]]:
    """
    Yield decoded rows from a PostgreSQL ``\\i``-included .dat file (oncomx
    format) containing one ``INSERT INTO … VALUES (…);`` per line.

    Lines that don't end the statement (e.g. ``);``) are accumulated until
    they do; this handles the rare case of a string literal containing a
    raw newline.
    """
    buffered: List[str] = []
    with open(path, "r", encoding="utf-8", errors="replace") as fh:
        for raw_line in fh:
            line = raw_line.rstrip("\n").rstrip("\r")
            if not line:
                continue
            if not buffered:
                if not line.lstrip().upper().startswith("INSERT INTO"):
                    # SET / COMMENT / blank lines from psql include header.
                    continue
                buffered.append(line)
            else:
                buffered.append(line)
            joined = "\n".join(buffered)
            # Quick check: count unescaped quotes — if odd, we're mid-string.
            # We rely on the trailing ``);`` to close the statement.
            if not joined.rstrip().endswith(");"):
                continue
            buffered = []
            m = _INSERT_PREFIX_RE.match(joined)
            if not m:
                continue
            # Slice from the opening paren of VALUES to the closing one (last
            # ``)`` before the trailing ``;``).
            start = m.end()
            end = joined.rstrip().rstrip(";").rstrip().rfind(")")
            if end < start:
                continue
            body = joined[start:end]
            tokens = _split_sql_values(body)
            row = [_decode_sql_literal(t) for t in tokens]
            if len(row) < num_columns:
                row = row + [None] * (num_columns - len(row))
            elif len(row) > num_columns:
                row = row[:num_columns]
            yield row


def _detect_dat_format(path: str) -> str:
    """Return ``"insert"`` or ``"copy"`` based on the first non-empty line."""
    try:
        with open(path, "r", encoding="utf-8", errors="replace") as fh:
            for line in fh:
                stripped = line.lstrip()
                if not stripped or stripped.startswith("--"):
                    continue
                if stripped.upper().startswith("INSERT INTO"):
                    return "insert"
                if stripped.upper().startswith("SET "):
                    # psql include preamble (oncomx) — keep scanning.
                    continue
                return "copy"
    except OSError:
        pass
    return "copy"


# ─────────────────────────────────────────────────────────────────────────────
#  SQLite materialisation
# ─────────────────────────────────────────────────────────────────────────────


def _populate_table(
    conn: sqlite3.Connection,
    table: _TableDef,
    *,
    batch_size: int = 50000,
    progress: bool = True,
    progress_every: int = 1_000_000,
) -> int:
    """
    Bulk-insert rows from ``table.dat_file`` using ``executemany``.

    Tuned for the SDSS-scale tables (>100M rows): coercion lambdas are
    resolved once per column (avoiding per-row dispatch on type strings),
    the encoded TSV stream is yielded as already-coerced tuples, and we
    flush in 50k-row batches inside an explicit ``BEGIN/COMMIT`` window.
    """
    if not table.dat_file or not os.path.isfile(table.dat_file):
        return 0
    cols = table.copy_columns or table.column_names
    if not cols:
        return 0
    col_idx = table.column_index
    pg_types = [col_idx[c].pg_type if c in col_idx else "text" for c in cols]
    kinds = [_column_coerce_kind(t) for t in pg_types]

    # Pre-bind coercion callables per column index. This dispatches once per
    # column instead of once per cell at insert time.
    def _identity(x):
        return x

    coercers = []
    for k in kinds:
        if k == _COERCE_KIND_INT:
            coercers.append(_coerce_int)
        elif k == _COERCE_KIND_REAL:
            coercers.append(_coerce_real)
        elif k == _COERCE_KIND_BOOL:
            coercers.append(_coerce_bool)
        else:
            coercers.append(_identity)

    placeholders = ", ".join(["?"] * len(cols))
    quoted_cols = ", ".join(_quote_ident(c) for c in cols)
    insert_sql = (
        f"INSERT INTO {_quote_ident(table.name)} ({quoted_cols}) VALUES ({placeholders})"
    )

    fmt = _detect_dat_format(table.dat_file)
    if progress:
        try:
            size_bytes = os.path.getsize(table.dat_file)
        except OSError:
            size_bytes = 0
        size_mb = size_bytes / (1024 * 1024) if size_bytes else 0.0
        print(
            f"[prepare:load] {table.name}: loading {table.dat_file} "
            f"({size_mb:,.1f} MB, fmt={fmt})",
            flush=True,
        )

    if fmt == "insert":
        # Values from INSERT have already been decoded to Python types
        # (int/float/str/None) by ``_decode_sql_literal``. We still apply the
        # type coercer to normalise booleans (``TRUE``/``t``) and to coerce
        # ``"123"`` style strings into the column's affinity if present.
        row_iter = _iter_pg_insert_rows(table.dat_file, num_columns=len(cols))
    else:
        row_iter = _iter_pg_dat_rows(table.dat_file, num_columns=len(cols))

    cur = conn.cursor()
    inserted = 0
    next_progress_threshold = progress_every
    batch: List[Tuple[object, ...]] = []
    batch_append = batch.append

    # One BEGIN/COMMIT around the whole table for max throughput.
    cur.execute("BEGIN")
    try:
        for raw_row in row_iter:
            row_out = [None] * len(cols)
            for i in range(len(cols)):
                v = raw_row[i]
                # INSERT-format already returns native Python types: pass
                # them through unless the column is boolean (where we may
                # still receive an int 0/1 — fine — or a string like 't').
                if fmt == "insert":
                    if v is None or isinstance(v, (int, float)):
                        row_out[i] = v
                    elif kinds[i] == _COERCE_KIND_BOOL and isinstance(v, str):
                        row_out[i] = _coerce_bool(v)
                    else:
                        row_out[i] = v
                else:
                    row_out[i] = coercers[i](v)
            batch_append(tuple(row_out))
            if len(batch) >= batch_size:
                cur.executemany(insert_sql, batch)
                inserted += len(batch)
                batch.clear()
                if progress and inserted >= next_progress_threshold:
                    print(
                        f"[prepare:load] {table.name}: {inserted:,} rows…",
                        flush=True,
                    )
                    next_progress_threshold += progress_every
        if batch:
            cur.executemany(insert_sql, batch)
            inserted += len(batch)
            batch.clear()
        cur.execute("COMMIT")
    except Exception:
        cur.execute("ROLLBACK")
        raise

    if progress:
        print(
            f"[prepare:load] {table.name}: done ({inserted:,} rows)",
            flush=True,
        )
    return inserted


def build_sqlite_from_pg_dump(
    *,
    restore_sql_path: str,
    target_schema: str,
    sqlite_path: str,
    only_tables: Optional[Iterable[str]] = None,
) -> Dict[str, int]:
    """
    Convert ``restore_sql_path`` into ``sqlite_path``. If ``sqlite_path`` already
    exists with at least one table populated, the conversion is skipped.

    Returns a ``{table_name: row_count}`` summary.
    """
    if os.path.isfile(sqlite_path):
        # Treat any existing sqlite with tables as already-prepared.
        try:
            with sqlite3.connect(sqlite_path) as conn:
                cur = conn.cursor()
                cur.execute("SELECT name FROM sqlite_master WHERE type='table'")
                names = [r[0] for r in cur.fetchall() if not r[0].startswith("sqlite_")]
                if names:
                    counts: Dict[str, int] = {}
                    for n in names:
                        cur.execute(f"SELECT COUNT(*) FROM {_quote_ident(n)}")
                        counts[n] = int(cur.fetchone()[0])
                    return counts
        except sqlite3.DatabaseError:
            os.remove(sqlite_path)

    tables = _parse_pg_dump(restore_sql_path, target_schema)
    if only_tables is not None:
        keep = set(only_tables)
        tables = {k: v for k, v in tables.items() if k in keep}
    if not tables:
        raise RuntimeError(
            f"No tables matched schema={target_schema!r} in {restore_sql_path}"
        )

    os.makedirs(os.path.dirname(os.path.abspath(sqlite_path)) or ".", exist_ok=True)
    if os.path.exists(sqlite_path):
        os.remove(sqlite_path)

    counts: Dict[str, int] = {}
    with sqlite3.connect(sqlite_path) as conn:
        # Speed up bulk loads.
        conn.execute("PRAGMA journal_mode=OFF")
        conn.execute("PRAGMA synchronous=OFF")
        conn.execute("PRAGMA temp_store=MEMORY")
        conn.execute("PRAGMA foreign_keys=OFF")

        known_table_names = list(tables.keys())
        for name, tdef in tables.items():
            conn.execute(_build_create_table_sql(tdef, known_tables=known_table_names))

        for name, tdef in tables.items():
            counts[name] = _populate_table(conn, tdef)

        conn.commit()

    return counts


# ─────────────────────────────────────────────────────────────────────────────
#  dev.json → BIRD-format queries.json
# ─────────────────────────────────────────────────────────────────────────────


def _looks_like_select(sql: str) -> bool:
    s = sql.lstrip().lower()
    return s.startswith(("select", "with", "(select", "(with"))


def convert_devjson_to_bird(
    *,
    dev_json_path: str,
    out_path: str,
    db_id: str,
    deduplicate: bool = True,
) -> int:
    """
    Convert a ScienceBenchmark ``dev.json`` workload into the BIRD-style schema
    consumed by ``benchmark_generator/main.py::load_queries`` (a list of
    ``{SQL, question_id, question, difficulty, evidence}``).

    ScienceBenchmark intentionally repeats every query under multiple
    ``rule_label`` rewritings; ``deduplicate=True`` (default) collapses those
    duplicates, keeping each unique SQL once. ``question_id`` is assigned
    from the deduplicated index so downstream BIRD-style validators see a
    sane stable id.

    Returns the number of records written.
    """
    with open(dev_json_path, "r", encoding="utf-8") as fh:
        records = json.load(fh)
    if not isinstance(records, list):
        raise RuntimeError(f"{dev_json_path}: expected a JSON array of records")

    seen: set = set()
    out: List[Dict[str, object]] = []
    qid = 0
    for rec in records:
        if not isinstance(rec, dict):
            continue
        sql = rec.get("query") or rec.get("SQL") or ""
        if not isinstance(sql, str):
            continue
        sql = sql.strip().rstrip(";").strip()
        if not sql or not _looks_like_select(sql):
            continue
        if deduplicate:
            key = sql.lower()
            if key in seen:
                continue
            seen.add(key)
        out.append({
            "question_id": qid,
            "db_id": db_id,
            "question": rec.get("question", ""),
            "evidence": "",
            "SQL": sql,
            "difficulty": "",
        })
        qid += 1

    os.makedirs(os.path.dirname(os.path.abspath(out_path)) or ".", exist_ok=True)
    with open(out_path, "w", encoding="utf-8") as fh:
        json.dump(out, fh, indent=2)
    return len(out)


# ─────────────────────────────────────────────────────────────────────────────
#  High-level helper for one ScienceBenchmark database
# ─────────────────────────────────────────────────────────────────────────────


@dataclass
class PreparedScienceDb:
    """Filesystem locations of the prepared artefacts for one DB."""
    name: str  # cordis | oncomx | sdss
    schema: str  # the PG schema we materialised
    sqlite_path: str
    queries_path: str
    enrich_source: str
    enrich_path: str
    classification_path: str
    table_counts: Dict[str, int] = field(default_factory=dict)
    num_queries: int = 0


def prepare_sciencebenchmark_db(
    *,
    name: str,
    sciencebenchmark_root: str,
    column_enrichment_root: str,
    classifications_dir: str,
    output_root: str,
    deduplicate_queries: bool = True,
    progress: bool = True,
) -> PreparedScienceDb:
    """
    Idempotently materialise one ScienceBenchmark database into a SQLite +
    BIRD-style queries pair, with the column enrichment file colocated next
    to the SQLite (so the benchmark generator's ``transforms.vertical_split``
    finds it via the default path).

    Layout::
        output_root/_staging/<name>/<name>.sqlite
        output_root/_staging/<name>/dev.json   (BIRD-style queries)
        output_root/_staging/<name>/column_semantic_enrichment.json (copy)

    Verifies that the table_classifications/ScienceBenchmark/<name>.json file
    exists, but does not copy it — the benchmark generator reads it directly
    from ``classifications_dir`` based on ``db_name``.
    """
    if name not in SCIENCEBENCHMARK_SCHEMAS:
        raise ValueError(f"Unknown ScienceBenchmark database: {name!r}")
    schema = SCIENCEBENCHMARK_SCHEMAS[name]

    db_root = os.path.join(sciencebenchmark_root, name)
    restore_sql = os.path.join(db_root, "db", "restore.sql")
    dev_json = os.path.join(db_root, "dev.json")
    if not os.path.isfile(restore_sql):
        raise FileNotFoundError(restore_sql)
    if not os.path.isfile(dev_json):
        raise FileNotFoundError(dev_json)

    enrich_src = os.path.join(column_enrichment_root, name, "column_semantic_enrichment.json")
    if not os.path.isfile(enrich_src):
        raise FileNotFoundError(
            f"Missing column_semantic_enrichment.json for {name!r}: {enrich_src}"
        )
    cls_path = os.path.join(classifications_dir, f"{name}.json")
    if not os.path.isfile(cls_path):
        raise FileNotFoundError(f"Missing table classification for {name!r}: {cls_path}")

    staging_dir = os.path.join(output_root, "_staging", name)
    os.makedirs(staging_dir, exist_ok=True)
    sqlite_path = os.path.join(staging_dir, f"{name}.sqlite")
    queries_path = os.path.join(staging_dir, "dev.json")
    enrich_dest = os.path.join(staging_dir, "column_semantic_enrichment.json")

    if progress:
        print(f"[prepare:{name}] schema={schema} sqlite={sqlite_path}", flush=True)

    counts = build_sqlite_from_pg_dump(
        restore_sql_path=restore_sql,
        target_schema=schema,
        sqlite_path=sqlite_path,
    )
    if progress:
        total_rows = sum(counts.values())
        print(
            f"[prepare:{name}] sqlite ready: {len(counts)} tables, "
            f"{total_rows} rows total",
            flush=True,
        )

    if not os.path.isfile(queries_path):
        n = convert_devjson_to_bird(
            dev_json_path=dev_json,
            out_path=queries_path,
            db_id=name,
            deduplicate=deduplicate_queries,
        )
    else:
        with open(queries_path, "r", encoding="utf-8") as fh:
            n = len(json.load(fh))
    if progress:
        print(f"[prepare:{name}] queries: {n} unique SELECTs at {queries_path}", flush=True)

    if not os.path.isfile(enrich_dest) or os.path.getsize(enrich_dest) == 0:
        # Copy (rather than symlink) so the staging directory is portable.
        with open(enrich_src, "r", encoding="utf-8") as src_fh:
            payload = src_fh.read()
        with open(enrich_dest, "w", encoding="utf-8") as dst_fh:
            dst_fh.write(payload)

    return PreparedScienceDb(
        name=name,
        schema=schema,
        sqlite_path=sqlite_path,
        queries_path=queries_path,
        enrich_source=enrich_src,
        enrich_path=enrich_dest,
        classification_path=cls_path,
        table_counts=counts,
        num_queries=n,
    )


# ─────────────────────────────────────────────────────────────────────────────
#  CLI helper (useful for smoke-testing the converter without generating)
# ─────────────────────────────────────────────────────────────────────────────


def _cli(argv: Optional[Sequence[str]] = None) -> int:
    import argparse

    p = argparse.ArgumentParser(
        description=(
            "Prepare ScienceBenchmark databases for the benchmark generator: "
            "build SQLite from the pg_dump + .dat payload and convert dev.json "
            "to a BIRD-style queries file."
        )
    )
    p.add_argument(
        "--names",
        nargs="*",
        default=list(SCIENCEBENCHMARK_SCHEMAS.keys()),
        choices=list(SCIENCEBENCHMARK_SCHEMAS.keys()),
        help="Subset of databases to prepare (default: all three).",
    )
    p.add_argument(
        "--sciencebenchmark-root",
        default=os.path.abspath(
            os.path.join(os.path.dirname(__file__), "..", "sciencebenchmark_dataset")
        ),
    )
    p.add_argument(
        "--column-enrichment-root",
        default=os.path.abspath(
            os.path.join(os.path.dirname(__file__), "..", "column_enrichment")
        ),
    )
    p.add_argument(
        "--classifications-dir",
        default=os.path.abspath(
            os.path.join(
                os.path.dirname(__file__),
                "..",
                "table_classifications",
                "ScienceBenchmark",
            )
        ),
    )
    p.add_argument("--output-root", default="output_sciencebenchmark")
    p.add_argument("--no-dedup", action="store_true", help="Keep duplicate dev.json queries.")
    args = p.parse_args(argv)

    for name in args.names:
        prepared = prepare_sciencebenchmark_db(
            name=name,
            sciencebenchmark_root=os.path.abspath(args.sciencebenchmark_root),
            column_enrichment_root=os.path.abspath(args.column_enrichment_root),
            classifications_dir=os.path.abspath(args.classifications_dir),
            output_root=os.path.abspath(args.output_root),
            deduplicate_queries=not args.no_dedup,
        )
        print(
            f"[done:{prepared.name}] {prepared.sqlite_path} "
            f"({sum(prepared.table_counts.values())} rows in "
            f"{len(prepared.table_counts)} tables); "
            f"{prepared.num_queries} queries -> {prepared.queries_path}",
            flush=True,
        )
    return 0


if __name__ == "__main__":
    raise SystemExit(_cli(sys.argv[1:]))
