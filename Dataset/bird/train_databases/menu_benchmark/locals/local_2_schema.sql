CREATE TABLE "menuCatalogEntry" (
    "callRecordId" INTEGER,
    "callNumberValue" TEXT,
    "dishCount" INTEGER,
    "pageCount" INTEGER
);

CREATE TABLE "menuIssuedOnOrBefore19000819" (
    "menuRecordId" INTEGER,
    "currencyCode" TEXT,
    "currencySymbol" TEXT,
    "issueDate" DATE,
    "eventName" TEXT,
    "subjectKeywords" TEXT,
    "menuLanguage" TEXT,
    "menuTitle" TEXT,
    "editorialNotes" TEXT,
    "occasionDescription" TEXT,
    "physicalDescription" TEXT,
    "sponsorName" TEXT,
    "publicationStatus" TEXT,
    "venueName" TEXT
);

CREATE TABLE "menuPageHeight2989To3630" (
    "pageId" INTEGER,
    "menuRecordId" INTEGER,
    "pageIndex" INTEGER,
    "imageReference" REAL,
    "fullHeightPixels" INTEGER,
    "fullWidthPixels" INTEGER,
    "imageUuid" TEXT
);

CREATE TABLE "menuPageHeight3631To4617" (
    "pageId" INTEGER,
    "menuRecordId" INTEGER,
    "pageIndex" INTEGER,
    "imageReference" REAL,
    "fullHeightPixels" INTEGER,
    "fullWidthPixels" INTEGER,
    "imageUuid" TEXT,
    FOREIGN KEY ("menuRecordId") REFERENCES "menuIssuedOnOrBefore19000819"("menuRecordId")
);