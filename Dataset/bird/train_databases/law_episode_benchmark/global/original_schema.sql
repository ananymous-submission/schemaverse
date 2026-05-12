CREATE TABLE Award
(
    award_id       INTEGER
            primary key,
    organization   TEXT,
    year           INTEGER,
    award_category TEXT,
    award          TEXT,
    series         TEXT,
    episode_id     TEXT,
    person_id      TEXT,
    role           TEXT,
    result         TEXT,
    foreign key (episode_id) references Episode(episode_id),
    foreign key (person_id) references Person(person_id)
);

CREATE TABLE Credit
(
    episode_id TEXT,
    person_id  TEXT,
    category   TEXT,
    role       TEXT,
    credited   TEXT,
    primary key (episode_id, person_id),
    foreign key (episode_id) references Episode(episode_id),
    foreign key (person_id) references Person(person_id)
);

CREATE TABLE Episode
(
    episode_id       TEXT
            primary key,
    series           TEXT,
    season           INTEGER,
    episode          INTEGER,
    number_in_series INTEGER,
    title            TEXT,
    summary          TEXT,
    air_date         DATE,
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
    person_id     TEXT
            primary key,
    name          TEXT,
    birthdate     DATE,
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