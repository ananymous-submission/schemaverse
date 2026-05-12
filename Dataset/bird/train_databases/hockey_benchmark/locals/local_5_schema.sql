CREATE TABLE "PlayerAwardWinnersByLeague" (
    "PlayerId" TEXT,
    "AwardName" TEXT,
    "AwardYear" INTEGER,
    "LeagueId" TEXT,
    "PlayerPosition" TEXT
);

CREATE TABLE "PlayerAwardsByLeagueAnnotated" (
    "PlayerId" TEXT,
    "AwardName" TEXT,
    "AwardYear" INTEGER,
    "LeagueId" TEXT,
    "AwardNote" TEXT,
    "PlayerPosition" TEXT
);

CREATE TABLE "AbbreviationMappings" (
    "AbbrevCategory" TEXT,
    "ShortCode" TEXT,
    "FullName" TEXT
);