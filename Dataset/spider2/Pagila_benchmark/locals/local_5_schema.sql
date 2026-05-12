CREATE TABLE "FilmDescriptionOtherFeatures" (
    "FilmId" INT,
    "DescriptionText" BLOB SUB_TYPE TEXT DEFAULT NULL,
    "LanguageId" SMALLINT NOT NULL,
    "LastUpdatedAt" TIMESTAMP NOT NULL,
    "OriginalLanguageId" SMALLINT DEFAULT NULL,
    "ContentRating" VARCHAR(10) DEFAULT 'G',
    "ReleaseYear" VARCHAR(4) DEFAULT NULL,
    "SpecialFeatures" VARCHAR(100) DEFAULT NULL,
    "Title" VARCHAR(255) NOT NULL,
    FOREIGN KEY ("LanguageId") REFERENCES "LanguageReference"("LanguageId")
);

CREATE TABLE "FilmLifecycleMetadata" (
    "FilmId" INT,
    "LastUpdatedAt" TIMESTAMP NOT NULL,
    "LengthMinutes" SMALLINT DEFAULT NULL,
    "ContentRating" VARCHAR(10) DEFAULT 'G',
    "ReleaseYear" VARCHAR(4) DEFAULT NULL,
    "RentalDuration" SMALLINT NOT NULL DEFAULT 3,
    "RentalRate" DECIMAL(4,2) NOT NULL DEFAULT 4.99,
    "ReplacementCost" DECIMAL(5,2) NOT NULL DEFAULT 19.99,
    "SpecialFeatures" VARCHAR(100) DEFAULT NULL,
    "Title" VARCHAR(255) NOT NULL
);

CREATE TABLE "FilmTextContent" (
    "FilmId" SMALLINT,
    "Title" VARCHAR(255) NOT NULL,
    "DescriptionText" BLOB SUB_TYPE TEXT
);

CREATE TABLE "LanguageReference" (
    "LanguageId" SMALLINT,
    "LanguageName" CHAR(20) NOT NULL,
    "LastUpdatedAt" TIMESTAMP NOT NULL
);