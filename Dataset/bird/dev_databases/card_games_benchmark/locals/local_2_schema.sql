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