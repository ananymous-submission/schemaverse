CREATE TABLE "awards_coaches"
(
    id      INTEGER
        primary key autoincrement,
    year    INTEGER,
    coachID TEXT,
    award   TEXT,
    lgID    TEXT,
    note    TEXT,
    foreign key (coachID, year) references coaches (coachID, year)
        on update cascade on delete cascade
);

CREATE TABLE awards_players
(
    playerID TEXT not null,
    award    TEXT not null,
    year     INTEGER          not null,
    lgID     TEXT null,
    note     TEXT null,
    pos      TEXT null,
    primary key (playerID, year, award),
    foreign key (playerID) references players (playerID)
            on update cascade on delete cascade
);

CREATE TABLE coaches
(
    coachID     TEXT not null,
    year        INTEGER          not null,
    tmID        TEXT not null,
    lgID        TEXT null,
    stint       INTEGER          not null,
    won         INTEGER          null,
    lost        INTEGER          null,
    post_wins   INTEGER          null,
    post_losses INTEGER          null,
    primary key (coachID, year, tmID, stint),
    foreign key (tmID, year) references teams (tmID, year)
            on update cascade on delete cascade
);

CREATE TABLE draft
(
    id             INTEGER default 0 not null
        primary key,
    draftYear      INTEGER           null,
    draftRound     INTEGER           null,
    draftSelection INTEGER           null,
    draftOverall   INTEGER          null,
    tmID           TEXT  null,
    firstName      TEXT  null,
    lastName       TEXT  null,
    suffixName     TEXT  null,
    playerID       TEXT  null,
    draftFrom      TEXT  null,
    lgID           TEXT  null,
    foreign key (tmID, draftYear) references teams (tmID, year)
            on update cascade on delete cascade
);

CREATE TABLE player_allstar
(
    playerID        TEXT not null,
    last_name       TEXT null,
    first_name      TEXT null,
    season_id       INTEGER          not null,
    conference      TEXT null,
    league_id       TEXT null,
    games_played    INTEGER          null,
    minutes         INTEGER          null,
    points          INTEGER          null,
    o_rebounds      INTEGER          null,
    d_rebounds      INTEGER          null,
    rebounds        INTEGER          null,
    assists         INTEGER          null,
    steals          INTEGER          null,
    blocks          INTEGER          null,
    turnovers       INTEGER          null,
    personal_fouls  INTEGER          null,
    fg_attempted    INTEGER          null,
    fg_made         INTEGER          null,
    ft_attempted    INTEGER          null,
    ft_made         INTEGER          null,
    three_attempted INTEGER          null,
    three_made      INTEGER          null,
    primary key (playerID, season_id),
    foreign key (playerID) references players (playerID)
            on update cascade on delete cascade
);

CREATE TABLE players
(
    playerID      TEXT not null
        primary key,
    useFirst      TEXT null,
    firstName     TEXT null,
    middleName    TEXT null,
    lastName      TEXT null,
    nameGiven     TEXT null,
    fullGivenName TEXT null,
    nameSuffix    TEXT null,
    nameNick      TEXT null,
    pos           TEXT null,
    firstseason   INTEGER          null,
    lastseason    INTEGER         null,
    height        REAL        null,
    weight        INTEGER         null,
    college       TEXT null,
    collegeOther  TEXT null,
    birthDate     DATE         null,
    birthCity     TEXT null,
    birthState    TEXT null,
    birthCountry  TEXT null,
    highSchool    TEXT null,
    hsCity        TEXT null,
    hsState       TEXT null,
    hsCountry     TEXT null,
    deathDate     DATE         null,
    race          TEXT null
);

CREATE TABLE "players_teams"
(
    id                 INTEGER
        primary key autoincrement,
    playerID           TEXT not null
        references players
            on update cascade on delete cascade,
    year               INTEGER,
    stint              INTEGER,
    tmID               TEXT,
    lgID               TEXT,
    GP                 INTEGER,
    GS                 INTEGER,
    minutes            INTEGER,
    points             INTEGER,
    oRebounds          INTEGER,
    dRebounds          INTEGER,
    rebounds           INTEGER,
    assists            INTEGER,
    steals             INTEGER,
    blocks             INTEGER,
    turnovers          INTEGER,
    PF                 INTEGER,
    fgAttempted        INTEGER,
    fgMade             INTEGER,
    ftAttempted        INTEGER,
    ftMade             INTEGER,
    threeAttempted     INTEGER,
    threeMade          INTEGER,
    PostGP             INTEGER,
    PostGS             INTEGER,
    PostMinutes        INTEGER,
    PostPoints         INTEGER,
    PostoRebounds      INTEGER,
    PostdRebounds      INTEGER,
    PostRebounds       INTEGER,
    PostAssists        INTEGER,
    PostSteals         INTEGER,
    PostBlocks         INTEGER,
    PostTurnovers      INTEGER,
    PostPF             INTEGER,
    PostfgAttempted    INTEGER,
    PostfgMade         INTEGER,
    PostftAttempted    INTEGER,
    PostftMade         INTEGER,
    PostthreeAttempted INTEGER,
    PostthreeMade      INTEGER,
    note               TEXT,
    foreign key (tmID, year) references teams (tmID, year)
        on update cascade on delete cascade
);

CREATE TABLE "series_post"
(
    id         INTEGER
        primary key autoincrement,
    year       INTEGER,
    round      TEXT,
    series     TEXT,
    tmIDWinner TEXT,
    lgIDWinner TEXT,
    tmIDLoser  TEXT,
    lgIDLoser  TEXT,
    W          INTEGER,
    L          INTEGER,
    foreign key (tmIDWinner, year) references teams (tmID, year)
        on update cascade on delete cascade,
    foreign key (tmIDLoser, year) references teams (tmID, year)
        on update cascade on delete cascade
);

CREATE TABLE teams
(
    year        INTEGER          not null,
    lgID        TEXT null,
    tmID        TEXT not null,
    franchID    TEXT null,
    confID      TEXT null,
    divID       TEXT null,
    `rank`      INTEGER          null,
    confRank    INTEGER          null,
    playoff     TEXT null,
    name        TEXT null,
    o_fgm       INTEGER          null,
--     o_fga       int          null,
    o_ftm       INTEGER          null,
--     o_fta       int          null,
--     o_3pm       int          null,
--     o_3pa       int          null,
--     o_oreb      int          null,
--     o_dreb      int          null,
--     o_reb       int          null,
--     o_asts      int          null,
--     o_pf        int          null,
--     o_stl       int          null,
--     o_to        int          null,
--     o_blk       int          null,
     o_pts       INTEGER          null,
--     d_fgm       int          null,
--     d_fga       int          null,
--     d_ftm       int          null,
--     d_fta       int          null,
--     d_3pm       int          null,
--     d_3pa       int          null,
--     d_oreb      int          null,
--     d_dreb      int          null,
--     d_reb       int          null,
--     d_asts      int          null,
--     d_pf        int          null,
--     d_stl       int          null,
--     d_to        int          null,
--     d_blk       int          null,
     d_pts       INTEGER          null,
--     o_tmRebound int          null,
--     d_tmRebound int          null,
    homeWon     INTEGER          null,
    homeLost    INTEGER          null,
    awayWon     INTEGER          null,
    awayLost    INTEGER          null,
--     neutWon     int          null,
--     neutLoss    int          null,
--     confWon     int          null,
--     confLoss    int          null,
--     divWon      int          null,
--     divLoss     int          null,
--     pace        int          null,
    won         INTEGER          null,
    lost        INTEGER          null,
    games       INTEGER          null,
--     min         int          null,
    arena       TEXT null,
--     attendance  int          null,
--     bbtmID      varchar(255) null,
    primary key (year, tmID)
);