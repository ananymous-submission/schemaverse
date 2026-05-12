CREATE TABLE "tags"
(
    "index" INTEGER
        constraint tags_pk
            primary key,
    id      INTEGER
        constraint tags_torrents_id_fk
            references torrents,
    tag     TEXT
);

CREATE TABLE "torrents"
(
    groupName     TEXT,
    totalSnatched INTEGER,
    artist        TEXT,
    groupYear     INTEGER,
    releaseType   TEXT,
    groupId       INTEGER,
    id            INTEGER
        constraint torrents_pk
            primary key
);