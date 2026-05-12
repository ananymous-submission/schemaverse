CREATE TABLE "playerGameParticipation" (
    "eliteIdentifier" INTEGER,
    "hasGamesPlayed" TEXT,
    "sevenYearGamesSum" INTEGER,
    "sevenYearTimeOnIce" INTEGER
);

CREATE TABLE "playerCssRanking" (
    "eliteIdentifier" INTEGER,
    "cssRankScore" INTEGER,
    "playerFullName" TEXT,
    "birthDateString" TEXT,
    "birthDayOfMonth" INTEGER,
    "birthMonthNumber" INTEGER,
    "birthLocation" TEXT,
    "birthYearValue" DATE,
    "draftRoundNumber" INTEGER,
    "draftYearNumber" INTEGER,
    "overallSelection" INTEGER,
    "overallAssignedBy" TEXT
);

CREATE TABLE "weightMeasurements" (
    "weightRecordId" INTEGER,
    "weightKilograms" INTEGER,
    "weightPounds" INTEGER
);