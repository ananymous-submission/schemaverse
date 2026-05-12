CREATE TABLE "categoryRegistry" (
    "categoryId" SMALLINT,
    "categoryName" VARCHAR(25) NOT NULL,
    "lastUpdatedAt" TIMESTAMP NOT NULL
);

CREATE TABLE "filmCategoryOldestUpdates" (
    "filmId" INT,
    "categoryId" SMALLINT,
    "lastUpdatedAt" TIMESTAMP NOT NULL,
    FOREIGN KEY ("categoryId") REFERENCES "categoryRegistry"("categoryId")
);

CREATE TABLE "filmCategorySecondQuartileUpdates" (
    "filmId" INT,
    "categoryId" SMALLINT,
    "lastUpdatedAt" TIMESTAMP NOT NULL,
    FOREIGN KEY ("categoryId") REFERENCES "categoryRegistry"("categoryId"),
    FOREIGN KEY ("filmId") REFERENCES "filmDescriptionBehindScenesCombinations"("filmId"),
    FOREIGN KEY ("filmId") REFERENCES "filmDescriptionTrailersCombinations"("filmId")
);

CREATE TABLE "filmCategoryThirdQuartileUpdates" (
    "filmId" INT,
    "categoryId" SMALLINT,
    "lastUpdatedAt" TIMESTAMP NOT NULL,
    FOREIGN KEY ("filmId") REFERENCES "filmDescriptionBehindScenesVariants"("filmId")
);

CREATE TABLE "filmCategoryNewestOrNullUpdates" (
    "filmId" INT,
    "categoryId" SMALLINT,
    "lastUpdatedAt" TIMESTAMP NOT NULL,
    FOREIGN KEY ("filmId") REFERENCES "filmDescriptionTrailersOrDeletedBehind"("filmId")
);

CREATE TABLE "filmDescriptionBehindScenesCombinations" (
    "filmId" INT,
    "descriptionText" BLOB SUB_TYPE TEXT DEFAULT NULL,
    "languageId" SMALLINT NOT NULL,
    "lastUpdatedAt" TIMESTAMP NOT NULL,
    "originalLanguageId" SMALLINT DEFAULT NULL,
    "contentRating" VARCHAR(10) DEFAULT 'G',
    "releaseYear" VARCHAR(4) DEFAULT NULL,
    "specialFeatures" VARCHAR(100) DEFAULT NULL,
    "titleText" VARCHAR(255) NOT NULL
);

CREATE TABLE "filmDescriptionTrailersOrDeletedBehind" (
    "filmId" INT,
    "descriptionText" BLOB SUB_TYPE TEXT DEFAULT NULL,
    "languageId" SMALLINT NOT NULL,
    "lastUpdatedAt" TIMESTAMP NOT NULL,
    "originalLanguageId" SMALLINT DEFAULT NULL,
    "contentRating" VARCHAR(10) DEFAULT 'G',
    "releaseYear" VARCHAR(4) DEFAULT NULL,
    "specialFeatures" VARCHAR(100) DEFAULT NULL,
    "titleText" VARCHAR(255) NOT NULL
);

CREATE TABLE "filmDescriptionTrailersCombinations" (
    "filmId" INT,
    "descriptionText" BLOB SUB_TYPE TEXT DEFAULT NULL,
    "languageId" SMALLINT NOT NULL,
    "lastUpdatedAt" TIMESTAMP NOT NULL,
    "originalLanguageId" SMALLINT DEFAULT NULL,
    "contentRating" VARCHAR(10) DEFAULT 'G',
    "releaseYear" VARCHAR(4) DEFAULT NULL,
    "specialFeatures" VARCHAR(100) DEFAULT NULL,
    "titleText" VARCHAR(255) NOT NULL
);

CREATE TABLE "filmDescriptionBehindScenesVariants" (
    "filmId" INT,
    "descriptionText" BLOB SUB_TYPE TEXT DEFAULT NULL,
    "languageId" SMALLINT NOT NULL,
    "lastUpdatedAt" TIMESTAMP NOT NULL,
    "originalLanguageId" SMALLINT DEFAULT NULL,
    "contentRating" VARCHAR(10) DEFAULT 'G',
    "releaseYear" VARCHAR(4) DEFAULT NULL,
    "specialFeatures" VARCHAR(100) DEFAULT NULL,
    "titleText" VARCHAR(255) NOT NULL
);