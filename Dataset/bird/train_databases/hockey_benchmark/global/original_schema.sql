CREATE TABLE AwardsCoaches
(
    coachID TEXT,
    award   TEXT,
    year    INTEGER,
    lgID    TEXT,
    note    TEXT,
    foreign key (coachID) references Coaches (coachID)
);

CREATE TABLE AwardsMisc
(
    name  TEXT not null
        primary key,
    ID    TEXT,
    award TEXT,
    year  INTEGER,
    lgID  TEXT,
    note  TEXT
);

CREATE TABLE AwardsPlayers
(
    playerID TEXT    not null,
    award    TEXT    not null,
    year     INTEGER not null,
    lgID     TEXT,
    note     TEXT,
    pos      TEXT,
    primary key (playerID, award, year),
    foreign key (playerID) references Master (playerID)
            on update cascade on delete cascade
);

CREATE TABLE Coaches
(
    coachID TEXT    not null,
    year    INTEGER not null,
    tmID    TEXT    not null,
    lgID    TEXT,
    stint   INTEGER not null,
    notes   TEXT,
    g       INTEGER,
    w       INTEGER,
    l       INTEGER,
    t       INTEGER,
    postg   TEXT,
    postw   TEXT,
    postl   TEXT,
    postt   TEXT,
    primary key (coachID, year, tmID, stint),
    foreign key (year, tmID) references Teams (year, tmID)
        on update cascade on delete cascade
);

CREATE TABLE CombinedShutouts
(
    year      INTEGER,
    month     INTEGER,
    date      INTEGER,
    tmID      TEXT,
    oppID     TEXT,
    "R/P"     TEXT,
    IDgoalie1 TEXT,
    IDgoalie2 TEXT,
    foreign key (IDgoalie1) references Master (playerID)
            on update cascade on delete cascade,
    foreign key (IDgoalie2) references  Master (playerID)
            on update cascade on delete cascade
);

CREATE TABLE Goalies
(
    playerID TEXT    not null,
    year     INTEGER not null,
    stint    INTEGER not null,
    tmID     TEXT,
    lgID     TEXT,
    GP       TEXT,
    Min      TEXT,
    W        TEXT,
    L        TEXT,
    "T/OL"   TEXT,
    ENG      TEXT,
    SHO      TEXT,
    GA       TEXT,
    SA       TEXT,
    PostGP   TEXT,
    PostMin  TEXT,
    PostW    TEXT,
    PostL    TEXT,
    PostT    TEXT,
    PostENG  TEXT,
    PostSHO  TEXT,
    PostGA   TEXT,
    PostSA   TEXT,
    primary key (playerID, year, stint),
    foreign key (year, tmID) references Teams (year, tmID)
        on update cascade on delete cascade,
    foreign key (playerID) references Master (playerID)
            on update cascade on delete cascade
);

CREATE TABLE GoaliesSC
(
    playerID TEXT    not null,
    year     INTEGER not null,
    tmID     TEXT,
    lgID     TEXT,
    GP       INTEGER,
    Min      INTEGER,
    W        INTEGER,
    L        INTEGER,
    T        INTEGER,
    SHO      INTEGER,
    GA       INTEGER,
    primary key (playerID, year),
    foreign key (year, tmID) references Teams (year, tmID)
        on update cascade on delete cascade,
    foreign key (playerID) references Master (playerID)
            on update cascade on delete cascade
);

CREATE TABLE GoaliesShootout
(
    playerID TEXT,
    year     INTEGER,
    stint    INTEGER,
    tmID     TEXT,
    W        INTEGER,
    L        INTEGER,
    SA       INTEGER,
    GA       INTEGER,
    foreign key (year, tmID) references Teams (year, tmID)
        on update cascade on delete cascade,
    foreign key (playerID)  references Master (playerID)
            on update cascade on delete cascade
);

CREATE TABLE HOF
(
    year     INTEGER,
    hofID    TEXT not null
        primary key,
    name     TEXT,
    category TEXT
);

CREATE TABLE Master
(
    playerID     TEXT,
    coachID      TEXT,
    hofID        TEXT,
    firstName    TEXT,
    lastName     TEXT not null,
    nameNote     TEXT,
    nameGiven    TEXT,
    nameNick     TEXT,
    height       TEXT,
    weight       TEXT,
    shootCatch   TEXT,
    legendsID    TEXT,
    ihdbID       TEXT,
    hrefID       TEXT,
    firstNHL     TEXT,
    lastNHL      TEXT,
    firstWHA     TEXT,
    lastWHA     TEXT,
    pos          TEXT,
    birthYear    TEXT,
    birthMon     TEXT,
    birthDay     TEXT,
    birthCountry TEXT,
    birthState   TEXT,
    birthCity    TEXT,
    deathYear    TEXT,
    deathMon     TEXT,
    deathDay     TEXT,
    deathCountry TEXT,
    deathState   TEXT,
    deathCity    TEXT,
    foreign key (coachID) references Coaches (coachID)
            on update cascade on delete cascade
);

CREATE TABLE Scoring
(
    playerID  TEXT,
    year      INTEGER,
    stint     INTEGER,
    tmID      TEXT,
    lgID      TEXT,
    pos       TEXT,
    GP        INTEGER,
    G         INTEGER,
    A         INTEGER,
    Pts       INTEGER,
    PIM       INTEGER,
    "+/-"     TEXT,
    PPG       TEXT,
    PPA       TEXT,
    SHG       TEXT,
    SHA       TEXT,
    GWG       TEXT,
    GTG       TEXT,
    SOG       TEXT,
    PostGP    TEXT,
    PostG     TEXT,
    PostA     TEXT,
    PostPts   TEXT,
    PostPIM   TEXT,
    "Post+/-" TEXT,
    PostPPG   TEXT,
    PostPPA   TEXT,
    PostSHG   TEXT,
    PostSHA   TEXT,
    PostGWG  TEXT,
    PostSOG   TEXT,
    foreign key (year, tmID) references Teams (year, tmID)
        on update cascade on delete cascade,
    foreign key (playerID) references Master (playerID)
            on update cascade on delete cascade
);

CREATE TABLE ScoringSC
(
    playerID TEXT,
    year     INTEGER,
    tmID     TEXT,
    lgID     TEXT,
    pos      TEXT,
    GP       INTEGER,
    G        INTEGER,
    A        INTEGER,
    Pts      INTEGER,
    PIM      INTEGER,
    foreign key (year, tmID) references Teams (year, tmID)
        on update cascade on delete cascade,
    foreign key (playerID) references Master (playerID)
            on update cascade on delete cascade
);

CREATE TABLE ScoringShootout
(
    playerID TEXT,
    year     INTEGER,
    stint    INTEGER,
    tmID     TEXT,
    S        INTEGER,
    G        INTEGER,
    GDG      INTEGER,
     foreign key (year, tmID) references Teams (year, tmID)
        on update cascade on delete cascade,
    foreign key (playerID) references Master (playerID)
            on update cascade on delete cascade
);

CREATE TABLE ScoringSup
(
    playerID TEXT,
    year     INTEGER,
    PPA      TEXT,
    SHA      TEXT,
     foreign key (playerID) references Master (playerID)
            on update cascade on delete cascade
);

CREATE TABLE SeriesPost
(
    year        INTEGER,
    round       TEXT,
    series      TEXT,
    tmIDWinner  TEXT,
    lgIDWinner  TEXT,
    tmIDLoser   TEXT,
    lgIDLoser   TEXT,
    W           INTEGER,
    L           INTEGER,
    T           INTEGER,
    GoalsWinner INTEGER,
    GoalsLoser  INTEGER,
    note        TEXT,
    foreign key (year, tmIDWinner) references Teams (year, tmID)
        on update cascade on delete cascade,
    foreign key (year, tmIDLoser) references Teams (year, tmID)
        on update cascade on delete cascade
);

CREATE TABLE TeamSplits
(
    year  INTEGER          not null,
    lgID  TEXT,
    tmID  TEXT not null,
    hW    INTEGER,
    hL    INTEGER,
    hT    INTEGER,
    hOTL  TEXT,
    rW    INTEGER,
    rL    INTEGER,
    rT    INTEGER,
    rOTL  TEXT,
    SepW  TEXT,
    SepL  TEXT,
    SepT  TEXT,
    SepOL TEXT,
    OctW TEXT,
    OctL  TEXT,
    OctT  TEXT,
    OctOL TEXT,
    NovW  TEXT,
    NovL  TEXT,
    NovT  TEXT,
    NovOL TEXT,
    DecW  TEXT,
    DecL  TEXT,
    DecT  TEXT,
    DecOL TEXT,
    JanW  INTEGER,
    JanL  INTEGER,
    JanT  INTEGER,
    JanOL TEXT,
    FebW  INTEGER,
    FebL  INTEGER,
    FebT  INTEGER,
    FebOL TEXT,
    MarW  TEXT,
    MarL  TEXT,
    MarT  TEXT,
    MarOL TEXT,
    AprW  TEXT,
    AprL  TEXT,
    AprT  TEXT,
    AprOL TEXT,
    primary key (year, tmID),
    foreign key (year, tmID) references Teams (year, tmID)
        on update cascade on delete cascade
);

CREATE TABLE TeamVsTeam
(
    year  INTEGER          not null,
    lgID  TEXT,
    tmID  TEXT not null,
    oppID TEXT not null,
    W     INTEGER,
    L     INTEGER,
    T     INTEGER,
    OTL   TEXT,
    primary key (year, tmID, oppID),
    foreign key (year, tmID) references Teams (year, tmID)
        on update cascade on delete cascade,
    foreign key (oppID, year) references Teams (tmID, year)
        on update cascade on delete cascade
);

CREATE TABLE Teams
(
    year       INTEGER          not null,
    lgID       TEXT,
    tmID       TEXT not null,
    franchID   TEXT,
    confID     TEXT,
    divID      TEXT,
    rank       INTEGER,
    playoff    TEXT,
    G          INTEGER,
    W          INTEGER,
    L          INTEGER,
    T          INTEGER,
    OTL        TEXT,
    Pts        INTEGER,
    SoW        TEXT,
    SoL        TEXT,
    GF         INTEGER,
    GA         INTEGER,
    name       TEXT,
    PIM        TEXT,
    BenchMinor TEXT,
    PPG        TEXT,
    PPC       TEXT,
    SHA        TEXT,
    PKG       TEXT,
    PKC        TEXT,
    SHF        TEXT,
    primary key (year, tmID)
);

CREATE TABLE TeamsHalf
(
    year INTEGER          not null,
    lgID TEXT,
    tmID TEXT not null,
    half INTEGER          not null,
    rank INTEGER,
    G    INTEGER,
    W    INTEGER,
    L    INTEGER,
    T    INTEGER,
    GF   INTEGER,
    GA   INTEGER,
    primary key (year, tmID, half),
    foreign key (tmID, year) references Teams (tmID, year)
        on update cascade on delete cascade
);

CREATE TABLE TeamsPost
(
    year       INTEGER          not null,
    lgID       TEXT,
    tmID       TEXT not null,
    G          INTEGER,
    W          INTEGER,
    L          INTEGER,
    T          INTEGER,
    GF         INTEGER,
    GA         INTEGER,
    PIM        TEXT,
    BenchMinor TEXT,
    PPG        TEXT,
    PPC        TEXT,
    SHA        TEXT,
    PKG        TEXT,
    PKC        TEXT,
    SHF        TEXT,
    primary key (year, tmID),
    foreign key (year, tmID) references Teams (year, tmID)
        on update cascade on delete cascade
);

CREATE TABLE TeamsSC
(
    year INTEGER          not null,
    lgID TEXT,
    tmID TEXT not null,
    G    INTEGER,
    W    INTEGER,
    L    INTEGER,
    T    INTEGER,
    GF   INTEGER,
    GA   INTEGER,
    PIM  TEXT,
    primary key (year, tmID),
    foreign key (year, tmID) references Teams (year, tmID)
        on update cascade on delete cascade
);

CREATE TABLE abbrev
(
    Type     TEXT not null,
    Code     TEXT not null,
    Fullname TEXT,
    primary key (Type, Code)
);