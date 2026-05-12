CREATE TABLE Award
(
    award_id       INTEGER
            primary key,
    organization   TEXT,
    year           INTEGER,
    award_category TEXT,
    award          TEXT,
    person         TEXT,
    role           TEXT,
    episode_id     TEXT,
    season         TEXT,
    song           TEXT,
    result         TEXT,
    foreign key (person) references Person(name),
    foreign key (episode_id) references Episode(episode_id)
);

CREATE TABLE Character_Award
(
    award_id  INTEGER,
    character TEXT,
    foreign key (award_id) references Award(award_id)
);

CREATE TABLE Credit
(
    episode_id TEXT,
    category   TEXT,
    person     TEXT,
    role       TEXT,
    credited   TEXT,
    foreign key (episode_id) references Episode(episode_id),
    foreign key (person) references Person(name)
);

CREATE TABLE "Episode"
(
    episode_id       TEXT
        constraint Episode_pk
            primary key,
    season           INTEGER,
    episode          INTEGER,
    number_in_series INTEGER,
    title            TEXT,
    summary          TEXT,
    air_date         TEXT,
    episode_image    TEXT,
    rating           REAL,
    votes            INTEGER
);

CREATE TABLE Keyword
(
    episode_id TEXT,
    keyword    TEXT,
    primary key (episode_id, keyword),
    foreign key (episode_id) references Episode(episode_id)
);

CREATE TABLE Person
(
    name          TEXT
        constraint Person_pk
            primary key,
    birthdate     TEXT,
    birth_name    TEXT,
    birth_place   TEXT,
    birth_region  TEXT,
    birth_country TEXT,
    height_meters REAL,
    nickname      TEXT
);

CREATE TABLE Vote
(
    episode_id TEXT,
    stars      INTEGER,
    votes      INTEGER,
    percent    REAL,
    foreign key (episode_id) references Episode(episode_id)
);