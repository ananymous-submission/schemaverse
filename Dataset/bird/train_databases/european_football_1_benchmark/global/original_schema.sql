CREATE TABLE divisions
(
    division TEXT not null
        primary key,
    name     TEXT,
    country  TEXT
);

CREATE TABLE matchs
(
    Div      TEXT,
    Date     DATE,
    HomeTeam TEXT,
    AwayTeam TEXT,
    FTHG     INTEGER,
    FTAG     INTEGER,
    FTR      TEXT,
    season   INTEGER,
    foreign key (Div) references divisions(division)
);