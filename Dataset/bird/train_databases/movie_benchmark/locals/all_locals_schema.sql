-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/movie/movie.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "MovieCastRoles" (
    "MovieIdentifier" INTEGER,
    "ActorIdentifier" INTEGER,
    "CharacterName" TEXT,
    "CreditSequence" INTEGER,
    "Compensation" TEXT,
    "ScreenTime" TEXT,
    FOREIGN KEY ("MovieIdentifier") REFERENCES "MoviesBudgetGreaterThan38000000UpTo80000000"("MovieIdentifier"),
    FOREIGN KEY ("MovieIdentifier") REFERENCES "MoviesBudgetGreaterThan80000000UpTo140000000"("MovieIdentifier"),
    FOREIGN KEY ("ActorIdentifier") REFERENCES "ActorBiographyHeightAbove67To72Inches"("ActorIdentifier")
);

CREATE TABLE "MovieGenreMetadata" (
    "MovieIdentifier" INTEGER,
    "GenreName" TEXT,
    "MpaaRating" TEXT,
    "AverageRating" REAL,
    "ReleaseDate" TEXT,
    "SummaryText" TEXT,
    "TitleName" TEXT
);

CREATE TABLE "ActorBiographyHeightUpTo63Inches" (
    "ActorIdentifier" INTEGER,
    "BiographyText" TEXT,
    "EthnicBackground" TEXT,
    "GenderIdentity" TEXT,
    "HeightInches" INTEGER,
    "FullName" TEXT,
    "EstimatedNetWorth" TEXT
);

CREATE TABLE "ActorBiographyHeightAbove63To67Inches" (
    "ActorIdentifier" INTEGER,
    "BiographyText" TEXT,
    "EthnicBackground" TEXT,
    "GenderIdentity" TEXT,
    "HeightInches" INTEGER,
    "FullName" TEXT,
    "EstimatedNetWorth" TEXT
);

CREATE TABLE "ActorBiographyHeightAbove67To72Inches" (
    "ActorIdentifier" INTEGER,
    "BiographyText" TEXT,
    "EthnicBackground" TEXT,
    "GenderIdentity" TEXT,
    "HeightInches" INTEGER,
    "FullName" TEXT,
    "EstimatedNetWorth" TEXT
);

CREATE TABLE "MoviesBudgetGreaterThan38000000UpTo80000000" (
    "MovieIdentifier" INTEGER,
    "BudgetAmount" INTEGER,
    "GenreName" TEXT,
    "BoxOfficeGross" INTEGER,
    "AverageRating" REAL,
    "RatingCount" INTEGER,
    "ReleaseDate" TEXT,
    "RuntimeMinutes" INTEGER,
    "SummaryText" TEXT
);

CREATE TABLE "MoviesBudgetGreaterThan80000000UpTo140000000" (
    "MovieIdentifier" INTEGER,
    "BudgetAmount" INTEGER,
    "GenreName" TEXT,
    "BoxOfficeGross" INTEGER,
    "AverageRating" REAL,
    "RatingCount" INTEGER,
    "ReleaseDate" TEXT,
    "RuntimeMinutes" INTEGER,
    "SummaryText" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "actor_biographies_height_over_72" (
    "actor_id" INTEGER,
    "biography_text" TEXT,
    "ethnic_background" TEXT,
    "gender_identity" TEXT,
    "height_inches" INTEGER,
    "full_name" TEXT,
    "net_worth_estimate" TEXT
);

CREATE TABLE "actor_birth_locations" (
    "actor_id" INTEGER,
    "birth_city" TEXT,
    "birth_country" TEXT,
    "birth_date" DATE,
    "ethnic_background" TEXT,
    "height_inches" INTEGER,
    "full_name" TEXT,
    "net_worth_estimate" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "mv_bud_le_38m" (
    "mv_id" INTEGER,
    "budg_usd" INTEGER,
    "genre_cat" TEXT,
    "gross_usd" INTEGER,
    "avg_rating" REAL,
    "rating_cnt" INTEGER,
    "rel_date" TEXT,
    "run_mins" INTEGER,
    "synopsis" TEXT
);

CREATE TABLE "mv_bud_gt_140m_or_null" (
    "mv_id" INTEGER,
    "budg_usd" INTEGER,
    "genre_cat" TEXT,
    "gross_usd" INTEGER,
    "avg_rating" REAL,
    "rating_cnt" INTEGER,
    "rel_date" TEXT,
    "run_mins" INTEGER,
    "synopsis" TEXT
);

