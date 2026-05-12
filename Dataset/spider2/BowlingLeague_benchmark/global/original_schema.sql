CREATE TABLE Bowler_Scores (
    MatchID int NOT NULL DEFAULT 0,
    GameNumber smallint NOT NULL DEFAULT 0,
    BowlerID int NOT NULL DEFAULT 0,
    RawScore smallint NULL DEFAULT 0,
    HandiCapScore smallint NULL DEFAULT 0,
    WonGame BOOLEAN NOT NULL DEFAULT 0,
    PRIMARY KEY (MatchID, GameNumber, BowlerID),
    FOREIGN KEY (BowlerID) REFERENCES Bowlers(BowlerID),
    FOREIGN KEY (MatchID, GameNumber) REFERENCES Match_Games(MatchID, GameNumber)
);

CREATE TABLE Bowler_Scores_Archive (
    MatchID int NOT NULL DEFAULT 0,
    GameNumber smallint NOT NULL DEFAULT 0,
    BowlerID int NOT NULL DEFAULT 0,
    RawScore smallint NULL DEFAULT 0,
    HandiCapScore smallint NULL DEFAULT 0,
    WonGame BOOLEAN NOT NULL DEFAULT 0,
    PRIMARY KEY (MatchID, GameNumber, BowlerID),
    FOREIGN KEY (MatchID, GameNumber) REFERENCES Match_Games_Archive(MatchID, GameNumber)
);

CREATE TABLE Bowlers (
    BowlerID INTEGER PRIMARY KEY AUTOINCREMENT,
    BowlerLastName TEXT NULL,
    BowlerFirstName TEXT NULL,
    BowlerMiddleInit TEXT NULL,
    BowlerAddress TEXT NULL,
    BowlerCity TEXT NULL,
    BowlerState TEXT NULL,
    BowlerZip TEXT NULL,
    BowlerPhoneNumber TEXT NULL,
    TeamID int NULL,
    BowlerTotalPins int NULL DEFAULT 0,
    BowlerGamesBowled int NULL DEFAULT 0,
    BowlerCurrentAverage smallint NULL DEFAULT 0,
    BowlerCurrentHcp smallint NULL DEFAULT 0,
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
);

CREATE TABLE Match_Games (
    MatchID int NOT NULL DEFAULT 0,
    GameNumber smallint NOT NULL DEFAULT 0,
    WinningTeamID int NULL DEFAULT 0,
    PRIMARY KEY (MatchID, GameNumber)
);

CREATE TABLE Match_Games_Archive (
    MatchID int NOT NULL DEFAULT 0,
    GameNumber smallint NOT NULL DEFAULT 0,
    WinningTeamID int NULL DEFAULT 0,
    PRIMARY KEY (MatchID, GameNumber)
);

CREATE TABLE Teams (
    TeamID INTEGER PRIMARY KEY AUTOINCREMENT,
    TeamName TEXT NOT NULL,
    CaptainID int NULL
);

CREATE TABLE Tournaments (
    TourneyID INTEGER PRIMARY KEY AUTOINCREMENT,
    TourneyDate DATE NULL,
    TourneyLocation TEXT NULL
);

CREATE TABLE Tournaments_Archive (
    TourneyID int NOT NULL DEFAULT 0,
    TourneyDate DATE NULL,
    TourneyLocation TEXT NULL,
    PRIMARY KEY (TourneyID)
);

CREATE TABLE Tourney_Matches (
    MatchID INTEGER PRIMARY KEY AUTOINCREMENT,
    TourneyID int NULL DEFAULT 0,
    Lanes TEXT NULL,
    OddLaneTeamID int NULL DEFAULT 0,
    EvenLaneTeamID int NULL DEFAULT 0,
    FOREIGN KEY (EvenLaneTeamID) REFERENCES Teams(TeamID),
    FOREIGN KEY (OddLaneTeamID) REFERENCES Teams(TeamID),
    FOREIGN KEY (TourneyID) REFERENCES Tournaments(TourneyID)
);

CREATE TABLE Tourney_Matches_Archive (
    MatchID int NOT NULL DEFAULT 0,
    TourneyID int NULL DEFAULT 0,
    Lanes TEXT NULL,
    OddLaneTeamID int NULL DEFAULT 0,
    EvenLaneTeamID int NULL DEFAULT 0,
    PRIMARY KEY (MatchID),
    FOREIGN KEY (TourneyID) REFERENCES Tournaments_Archive(TourneyID)
);

CREATE TABLE WAZips (
    ZIP TEXT NOT NULL,
    City TEXT NULL,
    State TEXT NULL,
    PRIMARY KEY (ZIP)
);