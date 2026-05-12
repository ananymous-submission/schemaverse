CREATE TABLE authors
(
    au_id    TEXT
        primary key,
    au_lname TEXT not null,
    au_fname TEXT not null,
    phone    TEXT    not null,
    address  TEXT,
    city     TEXT,
    state    TEXT,
    zip      TEXT,
    contract TEXT     not null
);

CREATE TABLE discounts
(
    discounttype TEXT   not null,
    stor_id      TEXT,
    lowqty       INTEGER,
    highqty      INTEGER,
    discount     REAL not null,
    foreign key (stor_id)  references stores(stor_id)
            on update cascade on delete cascade
);

CREATE TABLE employee
(
    emp_id    TEXT
        primary key,
    fname     TEXT not null,
    minit     TEXT,
    lname     TEXT not null,
    job_id    INTEGER     not null,
    job_lvl   INTEGER,
    pub_id    TEXT     not null,
    hire_date DATETIME    not null,
    foreign key (job_id) references jobs(job_id)
            on update cascade on delete cascade,
    foreign key (pub_id) references publishers(pub_id)
            on update cascade on delete cascade
);

CREATE TABLE jobs
(
    job_id   INTEGER
        primary key,
    job_desc TEXT not null,
    min_lvl  INTEGER     not null,
    max_lvl  INTEGER     not null
);

CREATE TABLE pub_info
(
    pub_id  TEXT
        primary key,
    logo    BLOB,
    pr_info TEXT,
    foreign key (pub_id) references publishers(pub_id)
            on update cascade on delete cascade
);

CREATE TABLE publishers
(
    pub_id   TEXT
        primary key,
    pub_name TEXT,
    city     TEXT,
    state    TEXT,
    country  TEXT
);

CREATE TABLE roysched
(
    title_id TEXT not null,
    lorange  INTEGER,
    hirange  INTEGER,
    royalty  INTEGER,
    foreign key (title_id)  references titles(title_id)
            on update cascade on delete cascade
);

CREATE TABLE sales
(
    stor_id  TEXT     not null,
    ord_num  TEXT  not null,
    ord_date DATETIME    not null,
    qty      INTEGER     not null,
    payterms TEXT  not null,
    title_id TEXT   not null,
    primary key (stor_id, ord_num, title_id),
    foreign key (stor_id)   references stores(stor_id)
            on update cascade on delete cascade,
    foreign key (title_id)  references titles(title_id)
            on update cascade on delete cascade

);

CREATE TABLE stores
(
    stor_id     TEXT
        primary key,
    stor_name    TEXT,
    stor_address TEXT,
    city         TEXT,
    state        TEXT,
    zip          TEXT
);

CREATE TABLE titleauthor
(
    au_id      TEXT not null,
    title_id   TEXT  not null,
    au_ord     INTEGER,
    royaltyper INTEGER,
    primary key (au_id, title_id),
    foreign key (au_id) references authors(au_id)
            on update cascade on delete cascade,
    foreign key (title_id)    references titles (title_id)
            on update cascade on delete cascade
);

CREATE TABLE titles
(
    title_id  TEXT
        primary key,
    title     TEXT not null,
    type      TEXT    not null,
    pub_id    TEXT,
    price     REAL,
    advance   REAL,
    royalty   INTEGER,
    ytd_sales INTEGER,
    notes     TEXT,
    pubdate   DATETIME    not null,
    foreign key (pub_id) references publishers(pub_id)
            on update cascade on delete cascade
);