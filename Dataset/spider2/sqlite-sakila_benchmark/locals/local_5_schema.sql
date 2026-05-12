CREATE TABLE "filmDescriptionForLengths73And74And84And85And92And100And112And179" (
    "filmId" INT,
    "descriptionText" BLOB SUB_TYPE TEXT DEFAULT NULL,
    "languageId" SMALLINT NOT NULL,
    "updatedAt" TIMESTAMP NOT NULL,
    "runtimeMinutes" SMALLINT DEFAULT NULL,
    "originalLanguageId" SMALLINT DEFAULT NULL,
    "contentRating" VARCHAR(10) DEFAULT 'G',
    "releaseYear" VARCHAR(4) DEFAULT NULL,
    "specialFeatures" VARCHAR(100) DEFAULT NULL,
    "titleText" VARCHAR(255) NOT NULL,
    FOREIGN KEY ("languageId") REFERENCES "languageLookup"("languageId")
);

CREATE TABLE "filmTextSearchIndex" (
    "filmId" SMALLINT,
    "titleText" VARCHAR(255) NOT NULL,
    "descriptionText" BLOB SUB_TYPE TEXT
);

CREATE TABLE "languageLookup" (
    "languageId" SMALLINT,
    "languageName" CHAR(20) NOT NULL,
    "updatedAt" TIMESTAMP NOT NULL
);

CREATE TABLE "filmActorUpdatedRange155255To155306" (
    "actorId" INT,
    "filmId" INT,
    "updatedAt" TIMESTAMP NOT NULL
);

CREATE TABLE "filmActorUpdatedRange155306To155317" (
    "actorId" INT,
    "filmId" INT,
    "updatedAt" TIMESTAMP NOT NULL
);

CREATE TABLE "filmCategoryUpdatedRange155330To155332" (
    "filmId" INT,
    "categoryId" SMALLINT,
    "updatedAt" TIMESTAMP NOT NULL,
    FOREIGN KEY ("filmId") REFERENCES "filmDescriptionForLengths73And74And84And85And92And100And112And179"("filmId")
);

CREATE TABLE "filmCategoryUpdatedRange155332To155334" (
    "filmId" INT,
    "categoryId" SMALLINT,
    "updatedAt" TIMESTAMP NOT NULL,
    FOREIGN KEY ("filmId") REFERENCES "filmDescriptionForLengths73And74And84And85And92And100And112And179"("filmId")
);

CREATE TABLE "inventoryUpdatedRange155217To155226" (
    "inventoryId" INT,
    "filmId" INT NOT NULL,
    "storeId" INT NOT NULL,
    "updatedAt" TIMESTAMP NOT NULL,
    FOREIGN KEY ("filmId") REFERENCES "filmDescriptionForLengths73And74And84And85And92And100And112And179"("filmId")
);

CREATE TABLE "inventoryUpdatedRange155226To155236" (
    "inventoryId" INT,
    "filmId" INT NOT NULL,
    "storeId" INT NOT NULL,
    "updatedAt" TIMESTAMP NOT NULL,
    FOREIGN KEY ("filmId") REFERENCES "filmDescriptionForLengths73And74And84And85And92And100And112And179"("filmId")
);