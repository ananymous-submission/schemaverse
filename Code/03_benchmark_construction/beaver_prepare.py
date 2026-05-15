from __future__ import annotations

import json
import os
import re
import sqlite3
import sys
from dataclasses import dataclass
from typing import Dict, Iterable, Iterator, List, Optional, Sequence, Tuple


BEAVER_DBS: Tuple[str, ...] = (
    "new_dw",
    "csail_stata_cinder",
    "csail_stata_glance",
    "csail_stata_neutron",
    "csail_stata_nova",
    "keystone",
)


@dataclass(frozen=True)
class PreparedBeaverDb:
    name: str
    sqlite_path: str
    queries_path: str
    enrichment_path: str
    num_tables: int
    num_queries: int


def _repo_root() -> str:
    return os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))


def _staging_dir(output_root: str, db_name: str) -> str:
    return os.path.join(output_root, "_staging", db_name)


def _mysql_dump_path(*, beaver_root: str, db_name: str) -> str:
    if db_name == "new_dw":
        return os.path.join(beaver_root, "databases", "DW", "new_dw_indexed.sql")
    return os.path.join(beaver_root, "databases", "NW", "exportedsql", f"{db_name}.sql")


def _enrichment_src_path(*, column_enrichment_root: str, db_name: str) -> str:
    return os.path.join(
        column_enrichment_root, db_name, "column_semantic_enrichment.json"
    )


def _copy_if_missing(src: str, dst: str) -> None:
    if os.path.isfile(dst):
        return
    os.makedirs(os.path.dirname(dst), exist_ok=True)
    with open(src, "rb") as fsrc, open(dst, "wb") as fdst:
        while True:
            chunk = fsrc.read(1024 * 1024)
            if not chunk:
                break
            fdst.write(chunk)


def _sqlite_has_tables(sqlite_path: str) -> bool:
    if not os.path.isfile(sqlite_path):
        return False
    try:
        con = sqlite3.connect(sqlite_path)
        try:
            cur = con.execute(
                "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' LIMIT 1"
            )
            return cur.fetchone() is not None
        finally:
            con.close()
    except Exception:
        return False


def _iter_sql_statements(path: str) -> Iterator[str]:
    """
    Stream a SQL dump file and yield statements separated by ';' while respecting:
    - single quotes
    - double quotes
    - backticks (MySQL identifiers)
    - /* ... */ comments and MySQL /*! ... */ version comments
    - -- and # line comments
    """

    def flush(buf: List[str]) -> Optional[str]:
        s = "".join(buf).strip()
        buf.clear()
        return s if s else None

    in_sq = False
    in_dq = False
    in_bt = False
    in_block_comment = False
    buf: List[str] = []

    with open(path, "r", encoding="utf-8", errors="replace") as f:
        while True:
            chunk = f.read(1024 * 1024)
            if not chunk:
                break
            i = 0
            n = len(chunk)
            while i < n:
                c = chunk[i]

                if in_block_comment:
                    if c == "*" and i + 1 < n and chunk[i + 1] == "/":
                        in_block_comment = False
                        i += 2
                        continue
                    i += 1
                    continue

                # MySQL-style backslash escapes inside string literals.
                # Important: this affects statement splitting, because an escaped
                # quote (e.g. \') must NOT toggle in_sq.
                if in_sq and c == "\\":
                    if i + 1 < n:
                        buf.append(c)
                        buf.append(chunk[i + 1])
                        i += 2
                        continue
                    buf.append(c)
                    i += 1
                    continue

                if not (in_sq or in_dq or in_bt):
                    # Line comments: -- ... or # ...
                    if c == "#":
                        # skip until newline
                        j = chunk.find("\n", i + 1)
                        if j == -1:
                            break
                        i = j + 1
                        continue
                    if c == "-" and i + 1 < n and chunk[i + 1] == "-":
                        # MySQL treats '-- ' as comment; we accept '--' broadly.
                        j = chunk.find("\n", i + 2)
                        if j == -1:
                            break
                        i = j + 1
                        continue
                    # Block comments
                    if c == "/" and i + 1 < n and chunk[i + 1] == "*":
                        in_block_comment = True
                        i += 2
                        continue

                if c == "'" and not (in_dq or in_bt):
                    # handle escaped single quote inside string: ''
                    if in_sq and i + 1 < n and chunk[i + 1] == "'":
                        buf.append("''")
                        i += 2
                        continue
                    in_sq = not in_sq
                    buf.append(c)
                    i += 1
                    continue

                if c == '"' and not (in_sq or in_bt):
                    in_dq = not in_dq
                    buf.append(c)
                    i += 1
                    continue

                if c == "`" and not (in_sq or in_dq):
                    in_bt = not in_bt
                    buf.append(c)
                    i += 1
                    continue

                if c == ";" and not (in_sq or in_dq or in_bt):
                    stmt = flush(buf)
                    if stmt:
                        yield stmt
                    i += 1
                    continue

                buf.append(c)
                i += 1

    last = flush(buf)
    if last:
        yield last


def _rewrite_mysql_string_literals(stmt: str) -> str:
    """
    Convert MySQL backslash-escaped string literals into SQLite-safe literals.
    SQLite does not treat backslash as an escape in SQL strings.

    We scan the statement and for each single-quoted literal:
    - interpret common MySQL escapes: \\' \\\" \\\\ \\n \\r \\t \\0 \\b \\Z
    - output a new single-quoted literal where internal quotes are doubled.
    """

    out: List[str] = []
    i = 0
    n = len(stmt)
    while i < n:
        c = stmt[i]
        if c != "'":
            out.append(c)
            i += 1
            continue

        # inside string literal
        out.append("'")
        i += 1
        buf: List[str] = []
        while i < n:
            ch = stmt[i]
            if ch == "\\" and i + 1 < n:
                nxt = stmt[i + 1]
                if nxt == "n":
                    buf.append("\n")
                elif nxt == "r":
                    buf.append("\r")
                elif nxt == "t":
                    buf.append("\t")
                elif nxt == "0":
                    buf.append("\x00")
                elif nxt == "b":
                    buf.append("\b")
                elif nxt == "Z":
                    buf.append("\x1a")
                elif nxt in ("\\", "'", '"'):
                    buf.append(nxt)
                else:
                    # unknown escape: keep the escaped char (drop the backslash)
                    buf.append(nxt)
                i += 2
                continue
            if ch == "'":
                # MySQL doubles single quotes too; accept '' as a single quote.
                if i + 1 < n and stmt[i + 1] == "'":
                    buf.append("'")
                    i += 2
                    continue
                i += 1
                break
            buf.append(ch)
            i += 1

        # emit literal content; escape single quote by doubling
        lit = "".join(buf).replace("'", "''")
        out.append(lit)
        out.append("'")
    return "".join(out)


_RE_TRAILING_TABLE_OPTIONS = re.compile(
    r"\)\s*ENGINE\s*=\s*\w+.*$", re.IGNORECASE | re.DOTALL
)
_RE_TABLE_OPTIONS = re.compile(
    r"(ENGINE\s*=\s*\w+|DEFAULT\s+CHARSET\s*=\s*\w+|CHARSET\s*=\s*\w+|COLLATE\s*=\s*\w+|AUTO_INCREMENT\s*=\s*\d+)",
    re.IGNORECASE,
)
_RE_COMMENT = re.compile(r"\bCOMMENT\s+'([^']|'')*'", re.IGNORECASE)
_RE_UNSIGNED = re.compile(r"\bUNSIGNED\b", re.IGNORECASE)
_RE_USING_BTREE = re.compile(r"\bUSING\s+BTREE\b", re.IGNORECASE)
_RE_ON_DUP = re.compile(r"\bON\s+DUPLICATE\s+KEY\s+UPDATE\b", re.IGNORECASE)
_RE_COL_CHARSET = re.compile(r"\bCHARACTER\s+SET\s+\w+\b", re.IGNORECASE)
_RE_COL_COLLATE = re.compile(r"\bCOLLATE\s+\w+\b", re.IGNORECASE)


def _translate_create_table(stmt: str) -> str:
    # Normalize identifier quoting for SQLite.
    s = stmt.replace("`", '"')

    # Strip trailing MySQL options (ENGINE/CHARSET/etc).
    s = _RE_TRAILING_TABLE_OPTIONS.sub(")", s)
    s = _RE_TABLE_OPTIONS.sub("", s)
    s = _RE_USING_BTREE.sub("", s)

    # Remove column/table comments and UNSIGNED modifiers.
    s = _RE_COMMENT.sub("", s)
    s = _RE_UNSIGNED.sub("", s)
    s = _RE_COL_CHARSET.sub("", s)
    s = _RE_COL_COLLATE.sub("", s)

    # Remove KEY / INDEX definitions inside the CREATE TABLE body (keep PK + FK).
    m = re.search(r"CREATE\s+TABLE\s+.*?\(", s, flags=re.IGNORECASE | re.DOTALL)
    if not m:
        return s
    open_paren = m.end() - 1
    close_paren = s.rfind(")")
    if close_paren <= open_paren:
        return s

    body = s[open_paren + 1 : close_paren]
    parts = [p.strip() for p in body.splitlines() if p.strip()]
    kept: List[str] = []
    for line in parts:
        # trim trailing comma now; we'll re-add later
        line0 = line.rstrip().rstrip(",").strip()
        u = line0.upper()
        if u.startswith("KEY ") or u.startswith("INDEX ") or u.startswith("FULLTEXT "):
            continue
        if u.startswith("UNIQUE KEY ") or u.startswith("UNIQUE INDEX "):
            continue
        kept.append(line0)

    # Clean up types a bit (best-effort; SQLite is flexible).
    # (Do after filtering, to avoid touching KEY lines.)
    def fix_types(x: str) -> str:
        # MySQL ENUM/SET are not supported by SQLite: coerce to TEXT.
        y = re.sub(r"\bENUM\s*\([^)]*\)", "TEXT", x, flags=re.IGNORECASE)
        y = re.sub(r"\bSET\s*\([^)]*\)", "TEXT", y, flags=re.IGNORECASE)
        y = re.sub(r"\bTINYINT\s*\(\s*1\s*\)\b", "INTEGER", y, flags=re.IGNORECASE)
        y = re.sub(r"\b(TINYINT|SMALLINT|MEDIUMINT|INT|INTEGER)\b(\s*\(\s*\d+\s*\))?", "INTEGER", y, flags=re.IGNORECASE)
        y = re.sub(r"\bBIGINT\b(\s*\(\s*\d+\s*\))?", "INTEGER", y, flags=re.IGNORECASE)
        y = re.sub(r"\bDOUBLE\b(\s*\(\s*\d+\s*,\s*\d+\s*\))?", "REAL", y, flags=re.IGNORECASE)
        y = re.sub(r"\bFLOAT\b(\s*\(\s*\d+\s*,\s*\d+\s*\))?", "REAL", y, flags=re.IGNORECASE)
        y = re.sub(r"\bDECIMAL\b(\s*\(\s*\d+\s*,\s*\d+\s*\))?", "REAL", y, flags=re.IGNORECASE)
        y = re.sub(r"\b(NUMERIC)\b(\s*\(\s*\d+\s*,\s*\d+\s*\))?", "REAL", y, flags=re.IGNORECASE)
        y = re.sub(r"\b(VARCHAR|CHAR)\b\s*\(\s*\d+\s*\)", "TEXT", y, flags=re.IGNORECASE)
        y = re.sub(r"\b(LONGTEXT|MEDIUMTEXT|TEXT)\b", "TEXT", y, flags=re.IGNORECASE)
        y = re.sub(r"\b(DATETIME|TIMESTAMP|DATE|TIME)\b", "TEXT", y, flags=re.IGNORECASE)
        y = re.sub(r"\bBLOB\b", "BLOB", y, flags=re.IGNORECASE)
        y = re.sub(r"\bAUTO_INCREMENT\b", "", y, flags=re.IGNORECASE)
        return y

    kept = [fix_types(x) for x in kept]
    new_body = ",\n  ".join(kept)

    prefix = s[: open_paren + 1]
    suffix = s[close_paren:]
    out = f"{prefix}\n  {new_body}\n{suffix}"
    out = re.sub(r",\s*\)", "\n)", out)
    return out.strip()


def _translate_insert(stmt: str) -> str:
    s = stmt.replace("`", '"')
    s = re.sub(r"^\s*INSERT\s+IGNORE\s+INTO\b", "INSERT OR IGNORE INTO", s, flags=re.IGNORECASE)

    # Drop ON DUPLICATE KEY UPDATE clause (not needed for our dumps; if present, ignore).
    m = _RE_ON_DUP.search(s)
    if m:
        s = s[: m.start()].rstrip()
    s = _rewrite_mysql_string_literals(s)
    return s.strip()


def _translate_statement(stmt: str) -> Optional[str]:
    s = stmt.strip()
    if not s:
        return None

    head = s.lstrip()[:40].upper()
    if head.startswith("CREATE DATABASE") or head.startswith("DROP DATABASE"):
        return None
    if head.startswith("USE "):
        return None
    if head.startswith("LOCK TABLES") or head.startswith("UNLOCK TABLES"):
        return None
    if head.startswith("SET ") or head.startswith("/*!"):
        return None
    if head.startswith("DELIMITER"):
        return None

    if re.match(r"^\s*CREATE\s+TABLE\b", s, flags=re.IGNORECASE):
        return _translate_create_table(s)
    if re.match(r"^\s*INSERT\b", s, flags=re.IGNORECASE):
        return _translate_insert(s)

    # Basic identifier quote normalization for everything else (DROP TABLE, etc.)
    return s.replace("`", '"')


def build_sqlite_from_mysql_dump(*, mysql_sql_path: str, sqlite_path: str) -> int:
    """
    Returns number of tables created (best-effort).
    """
    if _sqlite_has_tables(sqlite_path):
        con = sqlite3.connect(sqlite_path)
        try:
            cur = con.execute(
                "SELECT COUNT(*) FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'"
            )
            return int(cur.fetchone()[0])
        finally:
            con.close()

    os.makedirs(os.path.dirname(sqlite_path), exist_ok=True)
    # Remove DB + WAL/SHM remnants from aborted runs.
    for p in (sqlite_path, sqlite_path + "-wal", sqlite_path + "-shm"):
        if os.path.isfile(p):
            os.remove(p)

    # Generous timeout + busy_timeout to avoid transient "database is locked"
    # if another process briefly holds the file.
    con = sqlite3.connect(sqlite_path, timeout=120.0)
    try:
        con.execute("PRAGMA busy_timeout=120000;")
        con.execute("PRAGMA journal_mode=WAL;")
        con.execute("PRAGMA synchronous=OFF;")
        con.execute("PRAGMA temp_store=MEMORY;")
        con.execute("PRAGMA cache_size=-200000;")  # ~200MB
        con.execute("PRAGMA foreign_keys=OFF;")

        cur = con.cursor()
        cur.execute("BEGIN;")
        executed = 0
        for stmt in _iter_sql_statements(mysql_sql_path):
            t = _translate_statement(stmt)
            if not t:
                continue
            try:
                cur.execute(t)
            except sqlite3.Error as e:
                raise RuntimeError(
                    f"SQLite error executing translated statement from {mysql_sql_path}:\n"
                    f"  error: {e}\n"
                    f"  statement (first 500 chars): {t[:500]!r}"
                ) from e
            executed += 1
            if executed % 5000 == 0:
                con.commit()
                cur.execute("BEGIN;")
                print(
                    f"[beaver_prepare] executed {executed:,} statements for {os.path.basename(mysql_sql_path)}",
                    file=sys.stderr,
                    flush=True,
                )
        con.commit()

        cur2 = con.execute(
            "SELECT COUNT(*) FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'"
        )
        return int(cur2.fetchone()[0])
    finally:
        con.close()


def _load_json(path: str) -> object:
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)


def _write_json(path: str, obj: object) -> None:
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        json.dump(obj, f, ensure_ascii=False, indent=2)


def _extract_queries_for_db(*, dev_items: Sequence[dict], db_id: str) -> List[dict]:
    out: List[dict] = []
    for item in dev_items:
        if item.get("db_id") != db_id:
            continue
        sql = item.get("sql") or ""
        question = item.get("question") or ""
        out.append(
            {
                # main.load_queries expects uppercase "SQL"
                "SQL": sql,
                "question_id": len(out),
                "question": question,
                "difficulty": "",
                "evidence": "",
            }
        )
    return out


def prepare_beaver_db(
    *,
    name: str,
    beaver_root: str,
    column_enrichment_root: str,
    classifications_dir: str,
    output_root: str,
) -> PreparedBeaverDb:
    if name not in BEAVER_DBS:
        raise ValueError(f"Unknown BEAVER database: {name!r}")

    mysql_path = _mysql_dump_path(beaver_root=beaver_root, db_name=name)
    if not os.path.isfile(mysql_path):
        raise RuntimeError(f"Missing MySQL dump for {name!r}: {mysql_path}")

    enrich_src = _enrichment_src_path(column_enrichment_root=column_enrichment_root, db_name=name)
    if not os.path.isfile(enrich_src):
        raise RuntimeError(f"Missing enrichment for {name!r}: {enrich_src}")

    cls_path = os.path.join(classifications_dir, f"{name}.json")
    if not os.path.isfile(cls_path):
        raise RuntimeError(f"Missing table classification for {name!r}: {cls_path}")

    stage_dir = _staging_dir(output_root, name)
    sqlite_path = os.path.join(stage_dir, f"{name}.sqlite")
    queries_path = os.path.join(stage_dir, "dev.json")
    enrichment_dst = os.path.join(stage_dir, "column_semantic_enrichment.json")

    # 1) Build SQLite (idempotent).
    num_tables = build_sqlite_from_mysql_dump(
        mysql_sql_path=mysql_path,
        sqlite_path=sqlite_path,
    )

    # 2) Split queries.
    dev_dw = os.path.join(beaver_root, "dev_dw.json")
    dev_nw = os.path.join(beaver_root, "dev_nw.json")
    if not os.path.isfile(dev_dw) or not os.path.isfile(dev_nw):
        raise RuntimeError(f"Missing dev query files under {beaver_root}")

    def _build_queries() -> List[dict]:
        if name == "new_dw":
            items = _load_json(dev_dw)
            if not isinstance(items, list):
                raise RuntimeError(f"Unexpected JSON structure in {dev_dw}")
            return _extract_queries_for_db(dev_items=items, db_id="dw")
        items = _load_json(dev_nw)
        if not isinstance(items, list):
            raise RuntimeError(f"Unexpected JSON structure in {dev_nw}")
        return _extract_queries_for_db(dev_items=items, db_id=name)

    if not os.path.isfile(queries_path):
        qs = _build_queries()
        if not qs:
            raise RuntimeError(f"No queries found for db={name!r} in BEAVER dev JSONs")
        _write_json(queries_path, qs)
    else:
        # Backward-compat: older staging may have used lowercase "sql".
        existing = _load_json(queries_path)
        if isinstance(existing, list) and existing:
            first = existing[0]
            if isinstance(first, dict) and "SQL" not in first and "sql" in first:
                qs = _build_queries()
                if not qs:
                    raise RuntimeError(f"No queries found for db={name!r} in BEAVER dev JSONs")
                _write_json(queries_path, qs)

    # 3) Copy enrichment next to SQLite so vertical fragmentation can find it.
    _copy_if_missing(enrich_src, enrichment_dst)

    # 4) Count queries.
    q_items = _load_json(queries_path)
    if not isinstance(q_items, list):
        raise RuntimeError(f"Unexpected queries JSON structure at {queries_path}")
    # Count only queries that have "SQL" non-empty, matching main.load_queries
    num_queries = sum(1 for it in q_items if isinstance(it, dict) and (it.get("SQL") or "").strip())

    return PreparedBeaverDb(
        name=name,
        sqlite_path=sqlite_path,
        queries_path=queries_path,
        enrichment_path=enrichment_dst,
        num_tables=num_tables,
        num_queries=num_queries,
    )

