CREATE TABLE "chapters"
(
    id          INTEGER
        primary key autoincrement,
    Act         INTEGER not null,
    Scene       INTEGER not null,
    Description TEXT    not null,
    work_id     INTEGER not null
        references works
);

CREATE TABLE "characters"
(
    id          INTEGER
        primary key autoincrement,
    CharName    TEXT not null,
    Abbrev      TEXT not null,
    Description TEXT not null
);

CREATE TABLE "paragraphs"
(
    id           INTEGER
        primary key autoincrement,
    ParagraphNum INTEGER           not null,
    PlainText    TEXT              not null,
    character_id INTEGER           not null
        references characters,
    chapter_id   INTEGER default 0 not null
        references chapters
);

CREATE TABLE "works"
(
    id        INTEGER
        primary key autoincrement,
    Title     TEXT    not null,
    LongTitle TEXT    not null,
    Date      INTEGER not null,
    GenreType TEXT    not null
);