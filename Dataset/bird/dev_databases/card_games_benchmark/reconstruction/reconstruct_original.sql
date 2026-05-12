-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct cards from vertical split + row partition on a fragment
CREATE VIEW "cards" AS
SELECT t0.[artistProfileId], t0.[artistName], t0.[artistAscii], t1.[avail_flags], t0.[borderVariant], t2.[marketplaceFoilId], t2.[marketplaceId], t1.[color_iden], t1.[color_hint], t0.[colorIdentity], t0.[cmcValue], t1.[duel_deck], t0.[edhrecRanking], t0.[faceCmcValue], t0.[faceDisplayName], t0.[flavorTitle], t3.[FlavorTextContent], t1.[frame_effects], t1.[frame_ver], t0.[handModifier], t4.[alternativeDeckLimitFlag], t4.[contentWarningFlag], t4.[hasFoilFlag], t4.[hasNonFoilFlag], t4.[alternativeFlag], t4.[fullArtFlag], t4.[onlineOnlyFlag], t4.[oversizedFlag], t4.[promoFlag], t4.[reprintFlag], t4.[reservedFlag], t4.[starterFlag], t4.[storySpotlightFlag], t4.[textlessFlag], t4.[timeshiftedFlag], t0.[keywordList], t0.[cardLayout], t1.[leader_skills], t0.[lifeTotal], t0.[loyaltyValue], t0.[manaCostString], t2.[mcmIdentifier], t2.[mcmMetaIdentifier], t1.[arena_id], t2.[mtgjsonV4Identifier], t2.[mtgoFoilIdentifier], t2.[mtgoIdentifier], t2.[multiverseIdentifier], t0.[cardName], t0.[collectorNumber], t1.[orig_release], t3.[OriginalLanguageText], t1.[orig_type], t0.[alternateFaceIds], t0.[powerValue], t1.[printing_sets], t1.[promo_types], t1.[purchase_urls], t1.[rarity_code], t2.[scryfallIdentifier], t2.[scryfallIllustrationIdentifier], t2.[scryfallOracleIdentifier], t1.[set_code], t0.[cardSide], t1.[subtypes_list], t1.[supertypes_list], t2.[tcgplayerProductIdentifier], t3.[RenderedText], t0.[toughnessValue], t1.[card_type], t1.[types_list], t1.[card_uuid], t0.[variationList], t0.[watermarkSymbol]
FROM [local_3].[cardArtistProfiles] t0
JOIN [local_1].[card_art_meta] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_3].[cardExternalIdentifiers] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_2].[CardColorIdentityEntries] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN (
SELECT [cardFlagsHasFoilOrUnknown].[__orig_rowid] AS __orig_rowid, [local_3].[cardFlagsHasFoilOrUnknown].[flagsRecordIdHasFoil], [local_3].[cardFlagsHasFoilOrUnknown].[alternativeDeckLimitFlag], [local_3].[cardFlagsHasFoilOrUnknown].[contentWarningFlag], [local_3].[cardFlagsHasFoilOrUnknown].[hasFoilFlag], [local_3].[cardFlagsHasFoilOrUnknown].[hasNonFoilFlag], [local_3].[cardFlagsHasFoilOrUnknown].[alternativeFlag], [local_3].[cardFlagsHasFoilOrUnknown].[fullArtFlag], [local_3].[cardFlagsHasFoilOrUnknown].[onlineOnlyFlag], [local_3].[cardFlagsHasFoilOrUnknown].[oversizedFlag], [local_3].[cardFlagsHasFoilOrUnknown].[promoFlag], [local_3].[cardFlagsHasFoilOrUnknown].[reprintFlag], [local_3].[cardFlagsHasFoilOrUnknown].[reservedFlag], [local_3].[cardFlagsHasFoilOrUnknown].[starterFlag], [local_3].[cardFlagsHasFoilOrUnknown].[storySpotlightFlag], [local_3].[cardFlagsHasFoilOrUnknown].[textlessFlag], [local_3].[cardFlagsHasFoilOrUnknown].[timeshiftedFlag] FROM [local_3].[cardFlagsHasFoilOrUnknown]
UNION
SELECT [cardFlagsNoFoil].[__orig_rowid] AS __orig_rowid, [local_3].[cardFlagsNoFoil].[flagsRecordIdNoFoil], [local_3].[cardFlagsNoFoil].[alternativeDeckLimitFlag], [local_3].[cardFlagsNoFoil].[contentWarningFlag], [local_3].[cardFlagsNoFoil].[hasFoilFlag], [local_3].[cardFlagsNoFoil].[hasNonFoilFlag], [local_3].[cardFlagsNoFoil].[alternativeFlag], [local_3].[cardFlagsNoFoil].[fullArtFlag], [local_3].[cardFlagsNoFoil].[onlineOnlyFlag], [local_3].[cardFlagsNoFoil].[oversizedFlag], [local_3].[cardFlagsNoFoil].[promoFlag], [local_3].[cardFlagsNoFoil].[reprintFlag], [local_3].[cardFlagsNoFoil].[reservedFlag], [local_3].[cardFlagsNoFoil].[starterFlag], [local_3].[cardFlagsNoFoil].[storySpotlightFlag], [local_3].[cardFlagsNoFoil].[textlessFlag], [local_3].[cardFlagsNoFoil].[timeshiftedFlag] FROM [local_3].[cardFlagsNoFoil]
) t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct foreign_data from row partitions (UNION (overlap))
CREATE VIEW "foreign_data" AS
SELECT "local_1"."card_foreign_flavor"."foreign_id" AS "id", "local_1"."card_foreign_flavor"."flavor_text" AS "flavorText", "local_1"."card_foreign_flavor"."lang_code" AS "language", "local_1"."card_foreign_flavor"."multiverse_id" AS "multiverseid", "local_1"."card_foreign_flavor"."local_name" AS "name", "local_1"."card_foreign_flavor"."card_text" AS "text", "local_1"."card_foreign_flavor"."type_line" AS "type", "local_1"."card_foreign_flavor"."card_uuid" AS "uuid" FROM "local_1"."card_foreign_flavor"
UNION
SELECT "local_3"."foreignLocalizedTextsSelectedFlavors"."foreignTextId" AS "id", "local_3"."foreignLocalizedTextsSelectedFlavors"."flavorTextOriginal" AS "flavorText", "local_3"."foreignLocalizedTextsSelectedFlavors"."languageCode" AS "language", "local_3"."foreignLocalizedTextsSelectedFlavors"."multiverseIdentifier" AS "multiverseid", "local_3"."foreignLocalizedTextsSelectedFlavors"."localizedName" AS "name", "local_3"."foreignLocalizedTextsSelectedFlavors"."localizedText" AS "text", "local_3"."foreignLocalizedTextsSelectedFlavors"."typeLine" AS "type", "local_3"."foreignLocalizedTextsSelectedFlavors"."sourceExternalUuid" AS "uuid" FROM "local_3"."foreignLocalizedTextsSelectedFlavors";

-- Reconstruct legalities from local_3.cardFormatLegalities
CREATE VIEW "legalities" AS
SELECT
    "local_3"."cardFormatLegalities"."legalityRecordId" AS "id",
    "local_3"."cardFormatLegalities"."formatName" AS "format",
    "local_3"."cardFormatLegalities"."legalityStatus" AS "status",
    "local_3"."cardFormatLegalities"."sourceUuid" AS "uuid"
FROM "local_3"."cardFormatLegalities";

-- Reconstruct rulings from local_1.card_ruling_log
CREATE VIEW "rulings" AS
SELECT
    "local_1"."card_ruling_log"."ruling_id" AS "id",
    "local_1"."card_ruling_log"."issued_date" AS "date",
    "local_1"."card_ruling_log"."ruling_text" AS "text",
    "local_1"."card_ruling_log"."card_uuid" AS "uuid"
FROM "local_1"."card_ruling_log";

-- Reconstruct set_translations from row partitions (UNION (overlap))
CREATE VIEW "set_translations" AS
SELECT "local_2"."SetTranslationsChineseSimplified"."SetTranslationId" AS "id", "local_2"."SetTranslationsChineseSimplified"."LanguageLabel" AS "language", "local_2"."SetTranslationsChineseSimplified"."ReleaseSetCode" AS "setCode", "local_2"."SetTranslationsChineseSimplified"."TranslatedSetName" AS "translation" FROM "local_2"."SetTranslationsChineseSimplified"
UNION
SELECT "local_2"."SetTranslationsChineseTraditional"."SetTranslationId" AS "id", "local_2"."SetTranslationsChineseTraditional"."LanguageLabel" AS "language", "local_2"."SetTranslationsChineseTraditional"."ReleaseSetCode" AS "setCode", "local_2"."SetTranslationsChineseTraditional"."TranslatedSetName" AS "translation" FROM "local_2"."SetTranslationsChineseTraditional"
UNION
SELECT "local_2"."SetTranslationsFrench"."SetTranslationId" AS "id", "local_2"."SetTranslationsFrench"."LanguageLabel" AS "language", "local_2"."SetTranslationsFrench"."ReleaseSetCode" AS "setCode", "local_2"."SetTranslationsFrench"."TranslatedSetName" AS "translation" FROM "local_2"."SetTranslationsFrench"
UNION
SELECT "local_2"."SetTranslationsGerman"."SetTranslationId" AS "id", "local_2"."SetTranslationsGerman"."LanguageLabel" AS "language", "local_2"."SetTranslationsGerman"."ReleaseSetCode" AS "setCode", "local_2"."SetTranslationsGerman"."TranslatedSetName" AS "translation" FROM "local_2"."SetTranslationsGerman"
UNION
SELECT "local_2"."SetTranslationsItalian"."SetTranslationId" AS "id", "local_2"."SetTranslationsItalian"."LanguageLabel" AS "language", "local_2"."SetTranslationsItalian"."ReleaseSetCode" AS "setCode", "local_2"."SetTranslationsItalian"."TranslatedSetName" AS "translation" FROM "local_2"."SetTranslationsItalian"
UNION
SELECT "local_2"."SetTranslationsJapanese"."SetTranslationId" AS "id", "local_2"."SetTranslationsJapanese"."LanguageLabel" AS "language", "local_2"."SetTranslationsJapanese"."ReleaseSetCode" AS "setCode", "local_2"."SetTranslationsJapanese"."TranslatedSetName" AS "translation" FROM "local_2"."SetTranslationsJapanese"
UNION
SELECT "local_2"."SetTranslationsKorean"."SetTranslationId" AS "id", "local_2"."SetTranslationsKorean"."LanguageLabel" AS "language", "local_2"."SetTranslationsKorean"."ReleaseSetCode" AS "setCode", "local_2"."SetTranslationsKorean"."TranslatedSetName" AS "translation" FROM "local_2"."SetTranslationsKorean"
UNION
SELECT "local_2"."SetTranslationsPortugueseBrazil"."SetTranslationId" AS "id", "local_2"."SetTranslationsPortugueseBrazil"."LanguageLabel" AS "language", "local_2"."SetTranslationsPortugueseBrazil"."ReleaseSetCode" AS "setCode", "local_2"."SetTranslationsPortugueseBrazil"."TranslatedSetName" AS "translation" FROM "local_2"."SetTranslationsPortugueseBrazil"
UNION
SELECT "local_2"."SetTranslationsRussian"."SetTranslationId" AS "id", "local_2"."SetTranslationsRussian"."LanguageLabel" AS "language", "local_2"."SetTranslationsRussian"."ReleaseSetCode" AS "setCode", "local_2"."SetTranslationsRussian"."TranslatedSetName" AS "translation" FROM "local_2"."SetTranslationsRussian"
UNION
SELECT "local_2"."SetTranslationsSpanishNullable"."SetTranslationId" AS "id", "local_2"."SetTranslationsSpanishNullable"."LanguageLabel" AS "language", "local_2"."SetTranslationsSpanishNullable"."ReleaseSetCode" AS "setCode", "local_2"."SetTranslationsSpanishNullable"."TranslatedSetName" AS "translation" FROM "local_2"."SetTranslationsSpanishNullable";

-- Reconstruct sets from vertical split + row partition on a fragment
CREATE VIEW "sets" AS
SELECT t0.[SetBaseSizeId], t0.[BaseSetCardCount], t0.[BlockName], t0.[BoosterConfiguration], t2.[ReleaseSetCodeValue], t3.[FoilOnlyFlag], t3.[ForeignOnlyFlag], t3.[NonFoilOnlyFlag], t3.[OnlineOnlyFlag], t0.[PartialPreviewFlag], t2.[KeyruneIdentifier], t1.[CardMarketId], t1.[CardMarketExtrasId], t0.[CardMarketName], t2.[MtgoIdentifier], t0.[SetName], t0.[ParentSetCode], t0.[OfficialReleaseDate], t1.[TcgplayerGroupIdentifier], t0.[TotalSetCardCount], t0.[SetType]
FROM (
SELECT [SetsBaseSizeOverOneSixtyFiveOrNull].[__orig_rowid] AS __orig_rowid, [local_2].[SetsBaseSizeOverOneSixtyFiveOrNull].[SetBaseSizeId], [local_2].[SetsBaseSizeOverOneSixtyFiveOrNull].[BaseSetCardCount], [local_2].[SetsBaseSizeOverOneSixtyFiveOrNull].[BlockName], [local_2].[SetsBaseSizeOverOneSixtyFiveOrNull].[BoosterConfiguration], [local_2].[SetsBaseSizeOverOneSixtyFiveOrNull].[PartialPreviewFlag], [local_2].[SetsBaseSizeOverOneSixtyFiveOrNull].[CardMarketName], [local_2].[SetsBaseSizeOverOneSixtyFiveOrNull].[SetName], [local_2].[SetsBaseSizeOverOneSixtyFiveOrNull].[ParentSetCode], [local_2].[SetsBaseSizeOverOneSixtyFiveOrNull].[OfficialReleaseDate], [local_2].[SetsBaseSizeOverOneSixtyFiveOrNull].[TotalSetCardCount], [local_2].[SetsBaseSizeOverOneSixtyFiveOrNull].[SetType] FROM [local_2].[SetsBaseSizeOverOneSixtyFiveOrNull]
UNION
SELECT [SetsBaseSizeSixToTwentySix].[__orig_rowid] AS __orig_rowid, [local_2].[SetsBaseSizeSixToTwentySix].[SetBaseSizeId], [local_2].[SetsBaseSizeSixToTwentySix].[BaseSetCardCount], [local_2].[SetsBaseSizeSixToTwentySix].[BlockName], [local_2].[SetsBaseSizeSixToTwentySix].[BoosterConfiguration], [local_2].[SetsBaseSizeSixToTwentySix].[PartialPreviewFlag], [local_2].[SetsBaseSizeSixToTwentySix].[CardMarketName], [local_2].[SetsBaseSizeSixToTwentySix].[SetName], [local_2].[SetsBaseSizeSixToTwentySix].[ParentSetCode], [local_2].[SetsBaseSizeSixToTwentySix].[OfficialReleaseDate], [local_2].[SetsBaseSizeSixToTwentySix].[TotalSetCardCount], [local_2].[SetsBaseSizeSixToTwentySix].[SetType] FROM [local_2].[SetsBaseSizeSixToTwentySix]
UNION
SELECT [SetsBaseSizeTwentySevenToOneSixtyFive].[__orig_rowid] AS __orig_rowid, [local_2].[SetsBaseSizeTwentySevenToOneSixtyFive].[SetBaseSizeId], [local_2].[SetsBaseSizeTwentySevenToOneSixtyFive].[BaseSetCardCount], [local_2].[SetsBaseSizeTwentySevenToOneSixtyFive].[BlockName], [local_2].[SetsBaseSizeTwentySevenToOneSixtyFive].[BoosterConfiguration], [local_2].[SetsBaseSizeTwentySevenToOneSixtyFive].[PartialPreviewFlag], [local_2].[SetsBaseSizeTwentySevenToOneSixtyFive].[CardMarketName], [local_2].[SetsBaseSizeTwentySevenToOneSixtyFive].[SetName], [local_2].[SetsBaseSizeTwentySevenToOneSixtyFive].[ParentSetCode], [local_2].[SetsBaseSizeTwentySevenToOneSixtyFive].[OfficialReleaseDate], [local_2].[SetsBaseSizeTwentySevenToOneSixtyFive].[TotalSetCardCount], [local_2].[SetsBaseSizeTwentySevenToOneSixtyFive].[SetType] FROM [local_2].[SetsBaseSizeTwentySevenToOneSixtyFive]
UNION
SELECT [SetsBaseSizeUpToFive].[__orig_rowid] AS __orig_rowid, [local_2].[SetsBaseSizeUpToFive].[SetBaseSizeId], [local_2].[SetsBaseSizeUpToFive].[BaseSetCardCount], [local_2].[SetsBaseSizeUpToFive].[BlockName], [local_2].[SetsBaseSizeUpToFive].[BoosterConfiguration], [local_2].[SetsBaseSizeUpToFive].[PartialPreviewFlag], [local_2].[SetsBaseSizeUpToFive].[CardMarketName], [local_2].[SetsBaseSizeUpToFive].[SetName], [local_2].[SetsBaseSizeUpToFive].[ParentSetCode], [local_2].[SetsBaseSizeUpToFive].[OfficialReleaseDate], [local_2].[SetsBaseSizeUpToFive].[TotalSetCardCount], [local_2].[SetsBaseSizeUpToFive].[SetType] FROM [local_2].[SetsBaseSizeUpToFive]
) t0
JOIN [local_2].[SetBaseSizeDetails] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_2].[ReleaseSetCodes] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_2].[SetReleaseFlags] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];
