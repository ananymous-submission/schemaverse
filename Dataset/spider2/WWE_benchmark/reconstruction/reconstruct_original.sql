-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct Belts from local_3.championship_titles
CREATE VIEW "Belts" AS
SELECT
    "local_3"."championship_titles"."title_id" AS "id",
    "local_3"."championship_titles"."title_name" AS "name"
FROM "local_3"."championship_titles";

-- Reconstruct Cards from vertical split + row partition on a fragment
CREATE VIEW "Cards" AS
SELECT t0.[snapshotId], t0.[sourceTableId], t1.[venueId], t1.[promotionId], t0.[eventDate], t1.[eventRefId], t0.[sourceUrl], t0.[infoHtml], t0.[matchHtml]
FROM [local_1].[cardEventDateSnapshot] t0
JOIN (
SELECT [cardEventDateEvents3230To8878].[__orig_rowid] AS __orig_rowid, [local_1].[cardEventDateEvents3230To8878].[partitionRecordId], [local_1].[cardEventDateEvents3230To8878].[sourceTableId], [local_1].[cardEventDateEvents3230To8878].[venueId], [local_1].[cardEventDateEvents3230To8878].[promotionId], [local_1].[cardEventDateEvents3230To8878].[eventDate], [local_1].[cardEventDateEvents3230To8878].[eventRefId], [local_1].[cardEventDateEvents3230To8878].[sourceUrl], [local_1].[cardEventDateEvents3230To8878].[matchHtml] FROM [local_1].[cardEventDateEvents3230To8878]
UNION
SELECT [cardEventDateEvents552To3229].[__orig_rowid] AS __orig_rowid, [local_1].[cardEventDateEvents552To3229].[partitionRecordId], [local_1].[cardEventDateEvents552To3229].[sourceTableId], [local_1].[cardEventDateEvents552To3229].[venueId], [local_1].[cardEventDateEvents552To3229].[promotionId], [local_1].[cardEventDateEvents552To3229].[eventDate], [local_1].[cardEventDateEvents552To3229].[eventRefId], [local_1].[cardEventDateEvents552To3229].[sourceUrl], [local_1].[cardEventDateEvents552To3229].[matchHtml] FROM [local_1].[cardEventDateEvents552To3229]
UNION
SELECT [cardEventDateEventsAbove8878OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[cardEventDateEventsAbove8878OrNull].[partitionRecordId], [local_1].[cardEventDateEventsAbove8878OrNull].[sourceTableId], [local_1].[cardEventDateEventsAbove8878OrNull].[venueId], [local_1].[cardEventDateEventsAbove8878OrNull].[promotionId], [local_1].[cardEventDateEventsAbove8878OrNull].[eventDate], [local_1].[cardEventDateEventsAbove8878OrNull].[eventRefId], [local_1].[cardEventDateEventsAbove8878OrNull].[sourceUrl], [local_1].[cardEventDateEventsAbove8878OrNull].[matchHtml] FROM [local_1].[cardEventDateEventsAbove8878OrNull]
UNION
SELECT [cardEventDateEventsUpTo551].[__orig_rowid] AS __orig_rowid, [local_1].[cardEventDateEventsUpTo551].[partitionRecordId], [local_1].[cardEventDateEventsUpTo551].[sourceTableId], [local_1].[cardEventDateEventsUpTo551].[venueId], [local_1].[cardEventDateEventsUpTo551].[promotionId], [local_1].[cardEventDateEventsUpTo551].[eventDate], [local_1].[cardEventDateEventsUpTo551].[eventRefId], [local_1].[cardEventDateEventsUpTo551].[sourceUrl], [local_1].[cardEventDateEventsUpTo551].[matchHtml] FROM [local_1].[cardEventDateEventsUpTo551]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct Events from local_1.eventCatalog
CREATE VIEW "Events" AS
SELECT
    "local_1"."eventCatalog"."eventId" AS "id",
    "local_1"."eventCatalog"."eventName" AS "name"
FROM "local_1"."eventCatalog";

-- Reconstruct Locations from local_1.venueDirectory
CREATE VIEW "Locations" AS
SELECT
    "local_1"."venueDirectory"."locationId" AS "id",
    "local_1"."venueDirectory"."locationName" AS "name"
FROM "local_1"."venueDirectory";

-- Reconstruct Match_Types from local_1.matchTypeCatalog
CREATE VIEW "Match_Types" AS
SELECT
    "local_1"."matchTypeCatalog"."matchTypeId" AS "id",
    "local_1"."matchTypeCatalog"."matchTypeName" AS "name"
FROM "local_1"."matchTypeCatalog";

-- Reconstruct Matches from vertical split + row partition on a fragment
CREATE VIEW "Matches" AS
SELECT t0.[MatchRecordId], t0.[EventCardId], t1.[WinningParticipantId], t0.[VictoryMethod], t1.[LosingParticipantId], t0.[MatchTypeCode], t0.[MatchDuration], t0.[ChampionshipId], t0.[TitleChangeFlag]
FROM (
SELECT [MatchesCardId3061To6368].[__orig_rowid] AS __orig_rowid, [local_2].[MatchesCardId3061To6368].[MatchRecordId], [local_2].[MatchesCardId3061To6368].[EventCardId], [local_2].[MatchesCardId3061To6368].[VictoryMethod], [local_2].[MatchesCardId3061To6368].[MatchTypeCode], [local_2].[MatchesCardId3061To6368].[MatchDuration], [local_2].[MatchesCardId3061To6368].[ChampionshipId], [local_2].[MatchesCardId3061To6368].[TitleChangeFlag] FROM [local_2].[MatchesCardId3061To6368]
UNION
SELECT [MatchesCardId6369To9983].[__orig_rowid] AS __orig_rowid, [local_2].[MatchesCardId6369To9983].[MatchRecordId], [local_2].[MatchesCardId6369To9983].[EventCardId], [local_2].[MatchesCardId6369To9983].[VictoryMethod], [local_2].[MatchesCardId6369To9983].[MatchTypeCode], [local_2].[MatchesCardId6369To9983].[MatchDuration], [local_2].[MatchesCardId6369To9983].[ChampionshipId], [local_2].[MatchesCardId6369To9983].[TitleChangeFlag] FROM [local_2].[MatchesCardId6369To9983]
UNION
SELECT [MatchesCardIdGreaterThan9983OrNull].[__orig_rowid] AS __orig_rowid, [local_2].[MatchesCardIdGreaterThan9983OrNull].[MatchRecordId], [local_2].[MatchesCardIdGreaterThan9983OrNull].[EventCardId], [local_2].[MatchesCardIdGreaterThan9983OrNull].[VictoryMethod], [local_2].[MatchesCardIdGreaterThan9983OrNull].[MatchTypeCode], [local_2].[MatchesCardIdGreaterThan9983OrNull].[MatchDuration], [local_2].[MatchesCardIdGreaterThan9983OrNull].[ChampionshipId], [local_2].[MatchesCardIdGreaterThan9983OrNull].[TitleChangeFlag] FROM [local_2].[MatchesCardIdGreaterThan9983OrNull]
UNION
SELECT [MatchesCardIdUpTo3060].[__orig_rowid] AS __orig_rowid, [local_2].[MatchesCardIdUpTo3060].[MatchRecordId], [local_2].[MatchesCardIdUpTo3060].[EventCardId], [local_2].[MatchesCardIdUpTo3060].[VictoryMethod], [local_2].[MatchesCardIdUpTo3060].[MatchTypeCode], [local_2].[MatchesCardIdUpTo3060].[MatchDuration], [local_2].[MatchesCardIdUpTo3060].[ChampionshipId], [local_2].[MatchesCardIdUpTo3060].[TitleChangeFlag] FROM [local_2].[MatchesCardIdUpTo3060]
) t0
JOIN [local_2].[MatchResultsByCard] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct Promotions from local_1.promotionDirectory
CREATE VIEW "Promotions" AS
SELECT
    "local_1"."promotionDirectory"."promotionId" AS "id",
    "local_1"."promotionDirectory"."promotionName" AS "name"
FROM "local_1"."promotionDirectory";

-- Reconstruct Tables from local_2.HtmlSnapshots
CREATE VIEW "Tables" AS
SELECT
    "local_2"."HtmlSnapshots"."SnapshotId" AS "id",
    "local_2"."HtmlSnapshots"."HtmlContent" AS "html",
    "local_2"."HtmlSnapshots"."SourceUrl" AS "url"
FROM "local_2"."HtmlSnapshots";

-- Reconstruct Wrestlers from local_3.roster_competitors
CREATE VIEW "Wrestlers" AS
SELECT
    "local_3"."roster_competitors"."competitor_id" AS "id",
    "local_3"."roster_competitors"."ring_name" AS "name"
FROM "local_3"."roster_competitors";
