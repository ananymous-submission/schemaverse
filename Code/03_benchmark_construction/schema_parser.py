import sqlite3
import re
import json
try:
    import networkx as nx
except ModuleNotFoundError:  # pragma: no cover
    # Minimal fallback so validation can run in environments without networkx.
    # Only supports the small subset of APIs used in this project.
    class _MiniGraph:
        def __init__(self, directed: bool = True):
            self._directed = directed
            self._nodes = set()
            self._adj = {}  # u -> v -> attrs

        def add_node(self, n):
            self._nodes.add(n)
            self._adj.setdefault(n, {})

        def add_edge(self, u, v, **attrs):
            self.add_node(u)
            self.add_node(v)
            self._adj[u].setdefault(v, {}).update(attrs)
            if not self._directed:
                self._adj[v].setdefault(u, {}).update(attrs)

        def has_edge(self, u, v):
            return u in self._adj and v in self._adj[u]

        def __getitem__(self, u):
            return self._adj[u]

        def to_undirected(self):
            g = _MiniGraph(directed=False)
            for n in self._nodes:
                g.add_node(n)
            for u, nbrs in self._adj.items():
                for v, attrs in nbrs.items():
                    g.add_edge(u, v, **attrs)
            return g

        def degree(self):
            # For undirected graph, compute neighbor counts.
            deg = {n: 0 for n in self._nodes}
            for u, nbrs in self._adj.items():
                for v in nbrs:
                    deg[u] += 1
                    if self._directed:
                        # directed degree() not needed in this project
                        pass
            if not self._directed:
                # Ensure symmetric counts (edges stored in both directions)
                return list(deg.items())
            return list(deg.items())

        @property
        def nodes(self):
            return list(self._nodes)

    def _num_connected_components_undirected(g: _MiniGraph) -> int:
        seen = set()
        comps = 0
        for start in g.nodes:
            if start in seen:
                continue
            comps += 1
            stack = [start]
            seen.add(start)
            while stack:
                u = stack.pop()
                for v in g._adj.get(u, {}):
                    if v not in seen:
                        seen.add(v)
                        stack.append(v)
        return comps

    class _MiniNx:
        DiGraph = _MiniGraph

        @staticmethod
        def number_connected_components(g):
            return _num_connected_components_undirected(g)

    nx = _MiniNx()
from dataclasses import dataclass, field
from typing import List, Dict, Tuple, Optional, Set


@dataclass
class Column:
    name: str
    type: str
    is_pk: bool = False
    nullable: bool = True
    default: Optional[str] = None


@dataclass
class ForeignKey:
    from_table: str
    from_column: str
    to_table: str
    to_column: str
    origin: str = "declared"


@dataclass
class Table:
    name: str
    columns: List[Column] = field(default_factory=list)
    primary_keys: List[str] = field(default_factory=list)
    pk_origin: str = "none"
    foreign_keys: List[ForeignKey] = field(default_factory=list)
    row_count: int = 0


@dataclass
class SchemaGraph:
    tables: Dict[str, Table]
    foreign_keys: List[ForeignKey]
    graph: nx.DiGraph
    num_tables: int = 0
    num_edges: int = 0
    hub_tables: List[str] = field(default_factory=list)
    connected_components: int = 0
    has_declared_keys: bool = False
    used_inferred_keys: bool = False
    inferred_key_audit: Dict = field(default_factory=dict)


def parse_schema(db_path: str) -> SchemaGraph:
    """Parse SQLite database and build schema graph."""
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    # Get all table names (exclude sqlite internal tables)
    cursor.execute(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'"
    )
    table_names = [row[0] for row in cursor.fetchall()]

    tables = {}
    all_fks = []

    for tname in table_names:
        # Get column info
        cursor.execute(f"PRAGMA table_info('{tname}')")
        col_rows = cursor.fetchall()

        columns = []
        primary_keys = []
        for col in col_rows:
            # cid, name, type, notnull, dflt_value, pk
            cid, cname, ctype, notnull, dflt, pk = col
            c = Column(
                name=cname,
                type=ctype if ctype else "TEXT",
                is_pk=(pk > 0),
                nullable=(notnull == 0),
                default=dflt,
            )
            columns.append(c)
            if pk > 0:
                primary_keys.append(cname)

        # Get foreign key info
        cursor.execute(f"PRAGMA foreign_key_list('{tname}')")
        fk_rows = cursor.fetchall()

        fks = []
        for fk in fk_rows:
            # id, seq, table, from, to, on_update, on_delete, match
            _, _, ref_table, from_col, to_col, _, _, _ = fk
            fk_obj = ForeignKey(
                from_table=tname,
                from_column=from_col,
                to_table=ref_table,
                to_column=to_col,
            )
            fks.append(fk_obj)
            all_fks.append(fk_obj)

        # Get row count
        cursor.execute(f"SELECT COUNT(*) FROM [{tname}]")
        row_count = cursor.fetchone()[0]

        tables[tname] = Table(
            name=tname,
            columns=columns,
            primary_keys=primary_keys,
            pk_origin=("declared" if primary_keys else "none"),
            foreign_keys=fks,
            row_count=row_count,
        )

    conn.close()

    # Build graph
    G = nx.DiGraph()
    for tname in tables:
        G.add_node(tname)
    for fk in all_fks:
        if G.has_edge(fk.from_table, fk.to_table):
            G[fk.from_table][fk.to_table]["weight"] += 1
        else:
            G.add_edge(fk.from_table, fk.to_table, weight=1)

    # Compute stats on undirected version
    G_undirected = G.to_undirected()
    degrees = dict(G_undirected.degree())
    sorted_by_degree = sorted(degrees.items(), key=lambda x: x[1], reverse=True)
    hub_tables = [t for t, d in sorted_by_degree[:5] if d > 0]

    num_components = nx.number_connected_components(G_undirected)

    schema_graph = SchemaGraph(
        tables=tables,
        foreign_keys=all_fks,
        graph=G,
        num_tables=len(tables),
        num_edges=len(all_fks),
        hub_tables=hub_tables,
        connected_components=num_components,
        has_declared_keys=bool(any(t.primary_keys for t in tables.values()) or all_fks),
        used_inferred_keys=False,
        inferred_key_audit={},
    )

    return schema_graph


def apply_inferred_keys(
    schema_graph: SchemaGraph,
    inferred_pk_map: Dict[str, List[str]],
    inferred_fks: List[ForeignKey],
    audit: Optional[Dict] = None,
) -> None:
    """Inject inferred PK/FK constraints into schema graph for internal use."""
    for tname, table in schema_graph.tables.items():
        pks = list(inferred_pk_map.get(tname) or [])
        table.primary_keys = pks
        table.pk_origin = "inferred" if pks else "none"

    schema_graph.foreign_keys = list(inferred_fks)
    for table in schema_graph.tables.values():
        table.foreign_keys = []
    for fk in inferred_fks:
        if fk.from_table in schema_graph.tables:
            schema_graph.tables[fk.from_table].foreign_keys.append(fk)

    G = nx.DiGraph()
    for tname in schema_graph.tables:
        G.add_node(tname)
    for fk in schema_graph.foreign_keys:
        if G.has_edge(fk.from_table, fk.to_table):
            G[fk.from_table][fk.to_table]["weight"] += 1
        else:
            G.add_edge(fk.from_table, fk.to_table, weight=1)
    schema_graph.graph = G
    schema_graph.num_edges = len(schema_graph.foreign_keys)
    G_undirected = G.to_undirected()
    degrees = dict(G_undirected.degree())
    sorted_by_degree = sorted(degrees.items(), key=lambda x: x[1], reverse=True)
    schema_graph.hub_tables = [t for t, d in sorted_by_degree[:5] if d > 0]
    schema_graph.connected_components = nx.number_connected_components(G_undirected)
    schema_graph.used_inferred_keys = True
    schema_graph.inferred_key_audit = dict(audit or {})


def parse_queries(queries: List[str]) -> Dict[str, Set[str]]:
    """
    Parse SQL queries to extract referenced tables and columns.
    Returns dict mapping table_name -> set of column names referenced.
    """
    table_columns = {}

    for sql in queries:
        # Extract table names from FROM/JOIN clauses
        # Handle aliases like "table AS alias" or "table alias"
        table_pattern = r'(?:FROM|JOIN)\s+(\w+)(?:\s+(?:AS\s+)?(\w+))?'
        matches = re.findall(table_pattern, sql, re.IGNORECASE)

        alias_map = {}
        for table, alias in matches:
            # Skip common SQL keywords that might be caught
            if table.upper() in ('SELECT', 'WHERE', 'AND', 'OR', 'ON', 'SET',
                                  'VALUES', 'INTO', 'GROUP', 'ORDER', 'HAVING',
                                  'LIMIT', 'UNION', 'EXCEPT', 'INTERSECT'):
                continue
            actual_alias = alias if alias else table
            alias_map[actual_alias] = table
            if table not in table_columns:
                table_columns[table] = set()

        # Extract column references (T.column patterns)
        col_pattern = r'(\w+)\.(\w+)'
        col_matches = re.findall(col_pattern, sql)
        for prefix, col in col_matches:
            if prefix in alias_map:
                table_columns.setdefault(alias_map[prefix], set()).add(col)

    return table_columns


def extract_original_ddl(db_path: str) -> str:
    """Extract the original CREATE TABLE DDL from the database."""
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    cursor.execute(
        "SELECT sql FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' ORDER BY name"
    )
    ddl_statements = [row[0] for row in cursor.fetchall() if row[0]]
    conn.close()

    return ";\n\n".join(ddl_statements) + ";"


def schema_to_dict(schema_graph: SchemaGraph) -> dict:
    """Convert schema graph to a JSON-serializable dictionary."""
    result = {
        "tables": {},
        "foreign_keys": [],
        "stats": {
            "num_tables": schema_graph.num_tables,
            "num_fk_edges": schema_graph.num_edges,
            "hub_tables": schema_graph.hub_tables,
            "connected_components": schema_graph.connected_components,
        },
    }

    for tname, table in schema_graph.tables.items():
        result["tables"][tname] = {
            "columns": [
                {
                    "name": c.name,
                    "type": c.type,
                    "is_pk": c.is_pk,
                    "nullable": c.nullable,
                    "default": c.default,
                }
                for c in table.columns
            ],
            "primary_keys": table.primary_keys,
            "pk_origin": table.pk_origin,
            "row_count": table.row_count,
        }

    for fk in schema_graph.foreign_keys:
        result["foreign_keys"].append(
            {
                "from_table": fk.from_table,
                "from_column": fk.from_column,
                "to_table": fk.to_table,
                "to_column": fk.to_column,
                "origin": getattr(fk, "origin", "declared"),
            }
        )

    return result
