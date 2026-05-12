CREATE TABLE PlayerInfo
(
    ELITEID           INTEGER
            primary key,
    PlayerName        TEXT,
    birthdate         TEXT,
    birthyear         DATE,
    birthmonth        INTEGER,
    birthday          INTEGER,
    birthplace        TEXT,
    nation            TEXT,
    height            INTEGER,
    weight            INTEGER,
    position_info     TEXT,
    shoots            TEXT,
    draftyear         INTEGER,
    draftround        INTEGER,
    overall           INTEGER,
    overallby         TEXT,
    CSS_rank          INTEGER,
    sum_7yr_GP        INTEGER,
    sum_7yr_TOI       INTEGER,
    GP_greater_than_0 TEXT,
    foreign key (height) references height_info(height_id),
    foreign key (weight) references weight_info(weight_id)
);

CREATE TABLE SeasonStatus
(
    ELITEID   INTEGER,
    SEASON    TEXT,
    TEAM      TEXT,
    LEAGUE    TEXT,
    GAMETYPE  TEXT,
    GP        INTEGER,
    G         INTEGER,
    A         INTEGER,
    P         INTEGER,
    PIM       INTEGER,
    PLUSMINUS INTEGER,
    foreign key (ELITEID) references PlayerInfo(ELITEID)
);

CREATE TABLE height_info
(
    height_id      INTEGER
            primary key,
    height_in_cm   INTEGER,
    height_in_inch TEXT
);

CREATE TABLE weight_info
(
    weight_id     INTEGER
            primary key,
    weight_in_kg  INTEGER,
    weight_in_lbs INTEGER
);