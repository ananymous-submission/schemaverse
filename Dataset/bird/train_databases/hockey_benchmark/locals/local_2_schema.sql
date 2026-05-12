CREATE TABLE "CoachAwards" (
    "CoachId" TEXT,
    "AwardName" TEXT,
    "AwardYear" INTEGER,
    "LeagueId" TEXT,
    "NoteText" TEXT
);

CREATE TABLE "HallOfFameThrough1962" (
    "InductionYear" INTEGER,
    "HallMemberId" TEXT,
    "FullName" TEXT,
    "InductionCategory" TEXT
);

CREATE TABLE "HallOfFame1963To1972" (
    "InductionYear" INTEGER,
    "HallMemberId" TEXT,
    "FullName" TEXT,
    "InductionCategory" TEXT
);

CREATE TABLE "HallOfFame1973To1990" (
    "InductionYear" INTEGER,
    "HallMemberId" TEXT,
    "FullName" TEXT,
    "InductionCategory" TEXT
);

CREATE TABLE "HallOfFameSince1991OrUnknown" (
    "InductionYear" INTEGER,
    "HallMemberId" TEXT,
    "FullName" TEXT,
    "InductionCategory" TEXT
);

CREATE TABLE "CoachSeasonStatsGames38To70" (
    "CoachId" TEXT,
    "SeasonYear" INTEGER,
    "TeamId" TEXT,
    "StintNumber" INTEGER,
    "GamesPlayed" INTEGER,
    "PostseasonGames" TEXT,
    "PostseasonLosses" TEXT,
    "PostseasonTies" TEXT,
    "PostseasonWins" TEXT,
    "SeasonTies" INTEGER
);

CREATE TABLE "CoachSeasonStatsGames71To80" (
    "CoachId" TEXT,
    "SeasonYear" INTEGER,
    "TeamId" TEXT,
    "StintNumber" INTEGER,
    "GamesPlayed" INTEGER,
    "PostseasonGames" TEXT,
    "PostseasonLosses" TEXT,
    "PostseasonTies" TEXT,
    "PostseasonWins" TEXT,
    "SeasonTies" INTEGER
);