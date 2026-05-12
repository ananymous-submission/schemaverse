CREATE TABLE "municipality" (
    "municipalityId" INTEGER,
    "municipalityName" TEXT NOT NULL,
    "nationId" INTEGER NOT NULL,
    "lastModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "nation" (
    "nationId" INTEGER,
    "nationName" TEXT NOT NULL,
    "lastModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);