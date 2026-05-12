CREATE TABLE "ArchivedBowlerHandicapScore" (
    "MatchIdentifier" INT DEFAULT 0,
    "GameSequence" smallint DEFAULT 0,
    "BowlerIdentifier" INT DEFAULT 0,
    "HandicapScoreValue" smallint DEFAULT 0,
    "RawScoreValue" smallint DEFAULT 0,
    FOREIGN KEY ("MatchIdentifier") REFERENCES "ArchivedMatchGame"("MatchIdentifier"),
    FOREIGN KEY ("GameSequence") REFERENCES "ArchivedMatchGame"("GameSequence")
);

CREATE TABLE "ArchivedBowlerHandicapResult" (
    "MatchIdentifier" INT DEFAULT 0,
    "GameSequence" smallint DEFAULT 0,
    "BowlerIdentifier" INT DEFAULT 0,
    "HandicapScoreValue" smallint DEFAULT 0,
    "RawScoreValue" smallint DEFAULT 0,
    "GameWonFlag" BOOLEAN NOT NULL DEFAULT 0,
    FOREIGN KEY ("GameSequence") REFERENCES "ArchivedMatchGame"("GameSequence")
);

CREATE TABLE "ArchivedMatchGame" (
    "MatchIdentifier" INT DEFAULT 0,
    "GameSequence" smallint DEFAULT 0,
    "WinningTeamIdentifier" INT DEFAULT 0
);

CREATE TABLE "WashingtonZipDirectory" (
    "ZipCode" TEXT,
    "CityName" TEXT,
    "StateName" TEXT
);