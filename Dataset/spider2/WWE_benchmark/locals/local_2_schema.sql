CREATE TABLE "MatchesCardIdUpTo3060" (
    "MatchRecordId" INTEGER,
    "EventCardId" INTEGER,
    "MatchDuration" TEXT,
    "MatchTypeCode" TEXT,
    "TitleChangeFlag" INTEGER,
    "ChampionshipId" TEXT,
    "VictoryMethod" TEXT
);

CREATE TABLE "MatchesCardId3061To6368" (
    "MatchRecordId" INTEGER,
    "EventCardId" INTEGER,
    "MatchDuration" TEXT,
    "MatchTypeCode" TEXT,
    "TitleChangeFlag" INTEGER,
    "ChampionshipId" TEXT,
    "VictoryMethod" TEXT
);

CREATE TABLE "MatchesCardId6369To9983" (
    "MatchRecordId" INTEGER,
    "EventCardId" INTEGER,
    "MatchDuration" TEXT,
    "MatchTypeCode" TEXT,
    "TitleChangeFlag" INTEGER,
    "ChampionshipId" TEXT,
    "VictoryMethod" TEXT
);

CREATE TABLE "MatchesCardIdGreaterThan9983OrNull" (
    "MatchRecordId" INTEGER,
    "EventCardId" INTEGER,
    "MatchDuration" TEXT,
    "MatchTypeCode" TEXT,
    "TitleChangeFlag" INTEGER,
    "ChampionshipId" TEXT,
    "VictoryMethod" TEXT
);

CREATE TABLE "MatchResultsByCard" (
    "MatchResultId" INTEGER,
    "EventCardId" INTEGER,
    "LosingParticipantId" TEXT,
    "MatchTypeCode" TEXT,
    "TitleChangeFlag" INTEGER,
    "ChampionshipId" TEXT,
    "WinningParticipantId" TEXT
);

CREATE TABLE "HtmlSnapshots" (
    "SnapshotId" INTEGER,
    "HtmlContent" TEXT,
    "SourceUrl" TEXT
);