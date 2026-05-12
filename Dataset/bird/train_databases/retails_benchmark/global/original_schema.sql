CREATE TABLE `customer` (
  `c_custkey` INTEGER NOT NULL,
  `c_mktsegment` TEXT DEFAULT NULL,
  `c_nationkey` INTEGER DEFAULT NULL,
  `c_name` TEXT DEFAULT NULL,
  `c_address` TEXT DEFAULT NULL,
  `c_phone` TEXT DEFAULT NULL,
  `c_acctbal` REAL DEFAULT NULL,
  `c_comment` TEXT DEFAULT NULL,
  PRIMARY KEY (`c_custkey`),
  FOREIGN KEY (`c_nationkey`) REFERENCES `nation` (`n_nationkey`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE lineitem
(
    l_shipdate      DATE           null,
    l_orderkey      INTEGER         not null,
    l_discount      REAL not null,
    l_extendedprice REAL not null,
    l_suppkey       INTEGER            not null,
    l_quantity      INTEGER         not null,
    l_returnflag    TEXT           null,
    l_partkey       INTEGER         not null,
    l_linestatus    TEXT           null,
    l_tax           REAL not null,
    l_commitdate    DATE           null,
    l_receiptdate   DATE           null,
    l_shipmode      TEXT       null,
    l_linenumber    INTEGER         not null,
    l_shipinstruct  TEXT       null,
    l_comment       TEXT    null,
    primary key (l_orderkey, l_linenumber),
    foreign key (l_orderkey) references orders (o_orderkey)
            on update cascade on delete cascade,
    foreign key (l_partkey, l_suppkey) references partsupp (ps_partkey, ps_suppkey)
            on update cascade on delete cascade
);

CREATE TABLE nation
(
    n_nationkey INTEGER          not null
        primary key,
    n_name      TEXT     null,
    n_regionkey INTEGER          null,
    n_comment   TEXT null,
    foreign key (n_regionkey) references region (r_regionkey)
            on update cascade on delete cascade
);

CREATE TABLE orders
(
    o_orderdate     DATE           null,
    o_orderkey      INTEGER         not null
        primary key,
    o_custkey       INTEGER         not null,
    o_orderpriority TEXT       null,
    o_shippriority  INTEGER            null,
    o_clerk         TEXT       null,
    o_orderstatus   TEXT           null,
    o_totalprice    REAL null,
    o_comment       TEXT    null,
    foreign key (o_custkey) references customer (c_custkey)
            on update cascade on delete cascade
);

CREATE TABLE part
(
    p_partkey     INTEGER         not null
        primary key,
    p_type        TEXT    null,
    p_size        INTEGER            null,
    p_brand       TEXT       null,
    p_name        TEXT    null,
    p_container   TEXT       null,
    p_mfgr        TEXT       null,
    p_retailprice REAL null,
    p_comment     TEXT    null
);

CREATE TABLE partsupp
(
    ps_partkey    INTEGER         not null,
    ps_suppkey    INTEGER            not null,
    ps_supplycost REAL not null,
    ps_availqty   INTEGER            null,
    ps_comment    TEXT   null,
    primary key (ps_partkey, ps_suppkey),
    foreign key (ps_partkey) references part (p_partkey)
            on update cascade on delete cascade,
    foreign key (ps_suppkey) references supplier (s_suppkey)
            on update cascade on delete cascade
);

CREATE TABLE region
(
    r_regionkey INTEGER          not null
        primary key,
    r_name      TEXT     null,
    r_comment   TEXT null
);

CREATE TABLE supplier
(
    s_suppkey   INTEGER            not null
        primary key,
    s_nationkey INTEGER            null,
    s_comment   TEXT   null,
    s_name      TEXT       null,
    s_address   TEXT    null,
    s_phone     TEXT       null,
    s_acctbal   REAL null,
    foreign key (s_nationkey) references nation (n_nationkey)
);