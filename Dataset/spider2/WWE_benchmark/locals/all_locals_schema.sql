-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/WWE/WWE.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "cardEventDateSnapshot" (
    "snapshotId" INTEGER,
    "eventDate" TEXT,
    "infoHtml" TEXT,
    "matchHtml" TEXT,
    "sourceTableId" INTEGER,
    "sourceUrl" TEXT
);

CREATE TABLE "cardEventDateEventsUpTo551" (
    "partitionRecordId" INTEGER,
    "eventDate" TEXT,
    "eventRefId" INTEGER,
    "venueId" INTEGER,
    "matchHtml" TEXT,
    "promotionId" INTEGER,
    "sourceTableId" INTEGER,
    "sourceUrl" TEXT
);

CREATE TABLE "cardEventDateEvents552To3229" (
    "partitionRecordId" INTEGER,
    "eventDate" TEXT,
    "eventRefId" INTEGER,
    "venueId" INTEGER,
    "matchHtml" TEXT,
    "promotionId" INTEGER,
    "sourceTableId" INTEGER,
    "sourceUrl" TEXT
);

CREATE TABLE "cardEventDateEvents3230To8878" (
    "partitionRecordId" INTEGER,
    "eventDate" TEXT,
    "eventRefId" INTEGER,
    "venueId" INTEGER,
    "matchHtml" TEXT,
    "promotionId" INTEGER,
    "sourceTableId" INTEGER,
    "sourceUrl" TEXT
);

CREATE TABLE "cardEventDateEventsAbove8878OrNull" (
    "partitionRecordId" INTEGER,
    "eventDate" TEXT,
    "eventRefId" INTEGER,
    "venueId" INTEGER,
    "matchHtml" TEXT,
    "promotionId" INTEGER,
    "sourceTableId" INTEGER,
    "sourceUrl" TEXT
);

CREATE TABLE "eventCatalog" (
    "eventId" INTEGER,
    "eventName" TEXT
);

CREATE TABLE "venueDirectory" (
    "locationId" INTEGER,
    "locationName" TEXT
);

CREATE TABLE "matchTypeCatalog" (
    "matchTypeId" INTEGER,
    "matchTypeName" TEXT
);

CREATE TABLE "promotionDirectory" (
    "promotionId" INTEGER,
    "promotionName" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "championship_titles" (
    "title_id" INTEGER,
    "title_name" TEXT
);

CREATE TABLE "roster_competitors" (
    "competitor_id" INTEGER,
    "ring_name" TEXT
);

