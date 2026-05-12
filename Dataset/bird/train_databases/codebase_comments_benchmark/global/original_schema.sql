CREATE TABLE "Method"
(
    Id            INTEGER not null
        primary key autoincrement,
    Name          TEXT,
    FullComment   TEXT,
    Summary       TEXT,
    ApiCalls      TEXT,
    CommentIsXml  INTEGER,
    SampledAt     INTEGER,
    SolutionId    INTEGER,
    Lang          TEXT,
    NameTokenized TEXT
);

CREATE TABLE "MethodParameter"
(
    Id       INTEGER not null
        primary key autoincrement,
    MethodId TEXT,
    Type     TEXT,
    Name     TEXT
);

CREATE TABLE Repo
(
    Id            INTEGER not null
        primary key autoincrement,
    Url           TEXT,
    Stars         INTEGER,
    Forks         INTEGER,
    Watchers      INTEGER,
    ProcessedTime INTEGER
);

CREATE TABLE Solution
(
    Id            INTEGER not null
        primary key autoincrement,
    RepoId        INTEGER,
    Path          TEXT,
    ProcessedTime INTEGER,
    WasCompiled   INTEGER
);