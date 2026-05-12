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