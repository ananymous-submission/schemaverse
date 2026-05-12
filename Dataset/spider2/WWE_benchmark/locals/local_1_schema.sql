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