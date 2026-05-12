-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/dev_databases/card_games/card_games.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "card_art_meta" (
    "card_id" INTEGER,
    "art_credit" TEXT,
    "avail_flags" TEXT,
    "border_color" TEXT,
    "color_iden" TEXT,
    "color_hint" TEXT,
    "colors_list" TEXT,
    "duel_deck" TEXT,
    "edhrec_rank" INTEGER,
    "frame_effects" TEXT,
    "frame_ver" TEXT,
    "hand_size" TEXT,
    "keywords_list" TEXT,
    "layout_type" TEXT,
    "leader_skills" TEXT,
    "life_total" TEXT,
    "loyalty_val" TEXT,
    "mana_cost" TEXT,
    "arena_id" TEXT,
    "card_number" TEXT,
    "orig_release" TEXT,
    "orig_type" TEXT,
    "other_face_refs" TEXT,
    "power_val" TEXT,
    "printing_sets" TEXT,
    "promo_types" TEXT,
    "purchase_urls" TEXT,
    "rarity_code" TEXT,
    "set_code" TEXT,
    "subtypes_list" TEXT,
    "supertypes_list" TEXT,
    "toughness_val" TEXT,
    "card_type" TEXT,
    "types_list" TEXT,
    "card_uuid" TEXT NOT NULL,
    "variant_list" TEXT,
    "watermark_sym" TEXT
);

CREATE TABLE "card_ruling_log" (
    "ruling_id" INTEGER,
    "issued_date" DATE,
    "ruling_text" TEXT,
    "card_uuid" TEXT,
    FOREIGN KEY ("card_uuid") REFERENCES "card_art_meta"("card_uuid")
);

CREATE TABLE "card_foreign_flavor" (
    "foreign_id" INTEGER,
    "flavor_text" TEXT,
    "lang_code" TEXT,
    "multiverse_id" INTEGER,
    "local_name" TEXT,
    "card_text" TEXT,
    "type_line" TEXT,
    "card_uuid" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "SetTranslationsChineseSimplified" (
    "SetTranslationId" INTEGER,
    "LanguageLabel" TEXT,
    "ReleaseSetCode" TEXT,
    "TranslatedSetName" TEXT
);

CREATE TABLE "SetTranslationsChineseTraditional" (
    "SetTranslationId" INTEGER,
    "LanguageLabel" TEXT,
    "ReleaseSetCode" TEXT,
    "TranslatedSetName" TEXT,
    FOREIGN KEY ("ReleaseSetCode") REFERENCES "ReleaseSetCodes"("ReleaseSetCodeValue")
);

CREATE TABLE "SetTranslationsFrench" (
    "SetTranslationId" INTEGER,
    "LanguageLabel" TEXT,
    "ReleaseSetCode" TEXT,
    "TranslatedSetName" TEXT,
    FOREIGN KEY ("ReleaseSetCode") REFERENCES "ReleaseSetCodes"("ReleaseSetCodeValue")
);

CREATE TABLE "SetTranslationsGerman" (
    "SetTranslationId" INTEGER,
    "LanguageLabel" TEXT,
    "ReleaseSetCode" TEXT,
    "TranslatedSetName" TEXT,
    FOREIGN KEY ("ReleaseSetCode") REFERENCES "ReleaseSetCodes"("ReleaseSetCodeValue")
);

CREATE TABLE "SetTranslationsItalian" (
    "SetTranslationId" INTEGER,
    "LanguageLabel" TEXT,
    "ReleaseSetCode" TEXT,
    "TranslatedSetName" TEXT
);

CREATE TABLE "SetTranslationsJapanese" (
    "SetTranslationId" INTEGER,
    "LanguageLabel" TEXT,
    "ReleaseSetCode" TEXT,
    "TranslatedSetName" TEXT
);

CREATE TABLE "SetTranslationsKorean" (
    "SetTranslationId" INTEGER,
    "LanguageLabel" TEXT,
    "ReleaseSetCode" TEXT,
    "TranslatedSetName" TEXT,
    FOREIGN KEY ("ReleaseSetCode") REFERENCES "ReleaseSetCodes"("ReleaseSetCodeValue")
);

CREATE TABLE "SetTranslationsPortugueseBrazil" (
    "SetTranslationId" INTEGER,
    "LanguageLabel" TEXT,
    "ReleaseSetCode" TEXT,
    "TranslatedSetName" TEXT
);

CREATE TABLE "SetTranslationsRussian" (
    "SetTranslationId" INTEGER,
    "LanguageLabel" TEXT,
    "ReleaseSetCode" TEXT,
    "TranslatedSetName" TEXT
);

CREATE TABLE "SetTranslationsSpanishNullable" (
    "SetTranslationId" INTEGER,
    "LanguageLabel" TEXT,
    "ReleaseSetCode" TEXT,
    "TranslatedSetName" TEXT
);

CREATE TABLE "SetsBaseSizeUpToFive" (
    "SetBaseSizeId" INTEGER,
    "BaseSetCardCount" INTEGER,
    "BlockName" TEXT,
    "BoosterConfiguration" TEXT,
    "PartialPreviewFlag" INTEGER NOT NULL DEFAULT 0,
    "CardMarketName" TEXT,
    "SetName" TEXT,
    "ParentSetCode" TEXT,
    "OfficialReleaseDate" DATE,
    "TotalSetCardCount" INTEGER,
    "SetType" TEXT
);

CREATE TABLE "SetsBaseSizeSixToTwentySix" (
    "SetBaseSizeId" INTEGER,
    "BaseSetCardCount" INTEGER,
    "BlockName" TEXT,
    "BoosterConfiguration" TEXT,
    "PartialPreviewFlag" INTEGER NOT NULL DEFAULT 0,
    "CardMarketName" TEXT,
    "SetName" TEXT,
    "ParentSetCode" TEXT,
    "OfficialReleaseDate" DATE,
    "TotalSetCardCount" INTEGER,
    "SetType" TEXT
);

CREATE TABLE "SetsBaseSizeTwentySevenToOneSixtyFive" (
    "SetBaseSizeId" INTEGER,
    "BaseSetCardCount" INTEGER,
    "BlockName" TEXT,
    "BoosterConfiguration" TEXT,
    "PartialPreviewFlag" INTEGER NOT NULL DEFAULT 0,
    "CardMarketName" TEXT,
    "SetName" TEXT,
    "ParentSetCode" TEXT,
    "OfficialReleaseDate" DATE,
    "TotalSetCardCount" INTEGER,
    "SetType" TEXT
);

CREATE TABLE "SetsBaseSizeOverOneSixtyFiveOrNull" (
    "SetBaseSizeId" INTEGER,
    "BaseSetCardCount" INTEGER,
    "BlockName" TEXT,
    "BoosterConfiguration" TEXT,
    "PartialPreviewFlag" INTEGER NOT NULL DEFAULT 0,
    "CardMarketName" TEXT,
    "SetName" TEXT,
    "ParentSetCode" TEXT,
    "OfficialReleaseDate" DATE,
    "TotalSetCardCount" INTEGER,
    "SetType" TEXT
);

CREATE TABLE "SetBaseSizeDetails" (
    "SetBaseSizeId" INTEGER,
    "BaseSetCardCount" INTEGER,
    "BlockName" TEXT,
    "BoosterConfiguration" TEXT,
    "CardMarketId" INTEGER,
    "CardMarketExtrasId" INTEGER,
    "CardMarketName" TEXT,
    "OfficialReleaseDate" DATE,
    "TcgplayerGroupIdentifier" INTEGER,
    "SetType" TEXT
);

CREATE TABLE "ReleaseSetCodes" (
    "ReleaseSetCodeId" INTEGER,
    "ReleaseSetCodeValue" TEXT NOT NULL,
    "KeyruneIdentifier" TEXT,
    "MtgoIdentifier" TEXT,
    "ParentReleaseSetCode" TEXT
);

CREATE TABLE "SetReleaseFlags" (
    "SetReleaseFlagsId" INTEGER,
    "FoilOnlyFlag" INTEGER NOT NULL DEFAULT 0,
    "ForeignOnlyFlag" INTEGER NOT NULL DEFAULT 0,
    "NonFoilOnlyFlag" INTEGER NOT NULL DEFAULT 0,
    "OnlineOnlyFlag" INTEGER NOT NULL DEFAULT 0,
    "PartialPreviewFlag" INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE "CardColorIdentityEntries" (
    "CardColorIdentityId" INTEGER,
    "ColorIdentityCode" TEXT,
    "FlavorTextContent" TEXT,
    "OriginalLanguageText" TEXT,
    "ScryfallOracleGuid" TEXT,
    "RenderedText" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "foreignLocalizedTextsSelectedFlavors" (
    "foreignTextId" INTEGER,
    "flavorTextOriginal" TEXT,
    "languageCode" TEXT,
    "multiverseIdentifier" INTEGER,
    "localizedName" TEXT,
    "localizedText" TEXT,
    "typeLine" TEXT,
    "sourceExternalUuid" TEXT,
    FOREIGN KEY ("sourceExternalUuid") REFERENCES "cardExternalIdentifiers"("externalResourceUuid")
);

CREATE TABLE "cardFormatLegalities" (
    "legalityRecordId" INTEGER,
    "formatName" TEXT,
    "legalityStatus" TEXT,
    "sourceUuid" TEXT
);

CREATE TABLE "cardExternalIdentifiers" (
    "externalId" INTEGER,
    "marketplaceFoilId" TEXT,
    "marketplaceId" TEXT,
    "duelDeckName" TEXT,
    "frameEffectFlags" TEXT,
    "frameVariant" TEXT,
    "leadershipAbilities" TEXT,
    "mcmIdentifier" TEXT,
    "mcmMetaIdentifier" TEXT,
    "arenaId" TEXT,
    "mtgjsonV4Identifier" TEXT,
    "mtgoFoilIdentifier" TEXT,
    "mtgoIdentifier" TEXT,
    "multiverseIdentifier" TEXT,
    "releaseDate" TEXT,
    "printingVariants" TEXT,
    "purchaseLinks" TEXT,
    "rarityLevel" TEXT,
    "scryfallIdentifier" TEXT,
    "scryfallIllustrationIdentifier" TEXT,
    "scryfallOracleIdentifier" TEXT,
    "setCodeValue" TEXT,
    "printSide" TEXT,
    "tcgplayerProductIdentifier" TEXT,
    "externalResourceUuid" TEXT NOT NULL
);

CREATE TABLE "cardArtistProfiles" (
    "artistProfileId" INTEGER,
    "artistName" TEXT,
    "artistAscii" TEXT,
    "borderVariant" TEXT,
    "colorIdentity" TEXT,
    "cmcValue" REAL,
    "edhrecRanking" INTEGER,
    "faceCmcValue" REAL,
    "faceDisplayName" TEXT,
    "flavorTitle" TEXT,
    "handModifier" TEXT,
    "keywordList" TEXT,
    "cardLayout" TEXT,
    "lifeTotal" TEXT,
    "loyaltyValue" TEXT,
    "manaCostString" TEXT,
    "cardName" TEXT,
    "collectorNumber" TEXT,
    "alternateFaceIds" TEXT,
    "powerValue" TEXT,
    "cardSide" TEXT,
    "toughnessValue" TEXT,
    "variationList" TEXT,
    "watermarkSymbol" TEXT
);

CREATE TABLE "cardFlagsNoFoil" (
    "flagsRecordIdNoFoil" INTEGER,
    "alternativeDeckLimitFlag" INTEGER NOT NULL DEFAULT 0,
    "contentWarningFlag" INTEGER NOT NULL DEFAULT 0,
    "hasFoilFlag" INTEGER NOT NULL DEFAULT 0,
    "hasNonFoilFlag" INTEGER NOT NULL DEFAULT 0,
    "alternativeFlag" INTEGER NOT NULL DEFAULT 0,
    "fullArtFlag" INTEGER NOT NULL DEFAULT 0,
    "onlineOnlyFlag" INTEGER NOT NULL DEFAULT 0,
    "oversizedFlag" INTEGER NOT NULL DEFAULT 0,
    "promoFlag" INTEGER NOT NULL DEFAULT 0,
    "reprintFlag" INTEGER NOT NULL DEFAULT 0,
    "reservedFlag" INTEGER NOT NULL DEFAULT 0,
    "starterFlag" INTEGER NOT NULL DEFAULT 0,
    "storySpotlightFlag" INTEGER NOT NULL DEFAULT 0,
    "textlessFlag" INTEGER NOT NULL DEFAULT 0,
    "timeshiftedFlag" INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE "cardFlagsHasFoilOrUnknown" (
    "flagsRecordIdHasFoil" INTEGER,
    "alternativeDeckLimitFlag" INTEGER NOT NULL DEFAULT 0,
    "contentWarningFlag" INTEGER NOT NULL DEFAULT 0,
    "hasFoilFlag" INTEGER NOT NULL DEFAULT 0,
    "hasNonFoilFlag" INTEGER NOT NULL DEFAULT 0,
    "alternativeFlag" INTEGER NOT NULL DEFAULT 0,
    "fullArtFlag" INTEGER NOT NULL DEFAULT 0,
    "onlineOnlyFlag" INTEGER NOT NULL DEFAULT 0,
    "oversizedFlag" INTEGER NOT NULL DEFAULT 0,
    "promoFlag" INTEGER NOT NULL DEFAULT 0,
    "reprintFlag" INTEGER NOT NULL DEFAULT 0,
    "reservedFlag" INTEGER NOT NULL DEFAULT 0,
    "starterFlag" INTEGER NOT NULL DEFAULT 0,
    "storySpotlightFlag" INTEGER NOT NULL DEFAULT 0,
    "textlessFlag" INTEGER NOT NULL DEFAULT 0,
    "timeshiftedFlag" INTEGER NOT NULL DEFAULT 0
);

