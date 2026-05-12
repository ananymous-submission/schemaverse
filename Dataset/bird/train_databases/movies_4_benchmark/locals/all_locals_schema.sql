-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/movies_4/movies_4.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "nation" (
    "nationId" INTEGER,
    "isoCode" TEXT DEFAULT NULL,
    "commonName" TEXT DEFAULT NULL
);

CREATE TABLE "orgUnit" (
    "unitId" INTEGER,
    "unitName" TEXT DEFAULT NULL
);

CREATE TABLE "genderCategory" (
    "categoryId" INTEGER,
    "categoryLabel" TEXT DEFAULT NULL
);

CREATE TABLE "contentGenre" (
    "genreKey" INTEGER,
    "genreLabel" TEXT DEFAULT NULL
);

CREATE TABLE "searchTerm" (
    "termId" INTEGER,
    "termText" TEXT DEFAULT NULL
);

CREATE TABLE "locale" (
    "localeId" INTEGER,
    "isoLanguageCode" TEXT DEFAULT NULL,
    "localName" TEXT DEFAULT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "lang_role" (
    "role_pk" INTEGER,
    "role_lbl" TEXT DEFAULT NULL
);

CREATE TABLE "film_genre_map" (
    "film_id" INTEGER DEFAULT NULL,
    "genre_fk" INTEGER DEFAULT NULL
);

CREATE TABLE "film_lang_map" (
    "film_id" INTEGER DEFAULT NULL,
    "lang_fk" INTEGER DEFAULT NULL,
    "role_fk" INTEGER DEFAULT NULL,
    FOREIGN KEY ("role_fk") REFERENCES "lang_role"("role_pk")
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "movies_budget_under_one_million" (
    "movie_uid" INTEGER,
    "budget_amount" INTEGER DEFAULT NULL,
    "status_label" TEXT DEFAULT NULL,
    "synopsis" TEXT DEFAULT NULL,
    "popularity_score" REAL DEFAULT NULL,
    "released_on" DATE DEFAULT NULL,
    "duration_minutes" INTEGER DEFAULT NULL,
    "average_rating" REAL DEFAULT NULL
);

CREATE TABLE "movies_budget_over_forty_million_or_null" (
    "movie_uid" INTEGER,
    "budget_amount" INTEGER DEFAULT NULL,
    "status_label" TEXT DEFAULT NULL,
    "synopsis" TEXT DEFAULT NULL,
    "popularity_score" REAL DEFAULT NULL,
    "released_on" DATE DEFAULT NULL,
    "duration_minutes" INTEGER DEFAULT NULL,
    "average_rating" REAL DEFAULT NULL
);

CREATE TABLE "film_cast_members" (
    "movie_uid" INTEGER DEFAULT NULL,
    "person_uid" INTEGER DEFAULT NULL,
    "role_name" TEXT DEFAULT NULL,
    "gender_ref" INTEGER DEFAULT NULL,
    "billing_order" INTEGER DEFAULT NULL
);

CREATE TABLE "film_keyword_associations" (
    "movie_uid" INTEGER DEFAULT NULL,
    "keyword_ref" INTEGER DEFAULT NULL
);

CREATE TABLE "film_production_countries" (
    "movie_uid" INTEGER DEFAULT NULL,
    "country_ref" INTEGER DEFAULT NULL,
    FOREIGN KEY ("movie_uid") REFERENCES "movies_budget_under_one_million"("movie_uid")
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "MovieCrewAssignment" (
    "MovieId" INTEGER DEFAULT NULL,
    "PersonId" INTEGER DEFAULT NULL,
    "DepartmentId" INTEGER DEFAULT NULL,
    "CrewRole" TEXT DEFAULT NULL,
    FOREIGN KEY ("MovieId") REFERENCES "MovieBudgetBetween1MillionAnd15Million"("MovieId")
);

CREATE TABLE "PersonRecord" (
    "PersonId" INTEGER,
    "FullName" TEXT DEFAULT NULL
);

CREATE TABLE "MovieWebPresence" (
    "MovieId" INTEGER,
    "HomepageUrl" TEXT DEFAULT NULL,
    "Tagline" TEXT DEFAULT NULL,
    "OfficialTitle" TEXT DEFAULT NULL
);

CREATE TABLE "MovieBudgetBetween1MillionAnd15Million" (
    "MovieId" INTEGER,
    "ProductionBudget" INTEGER DEFAULT NULL,
    "ReleaseStatus" TEXT DEFAULT NULL,
    "Synopsis" TEXT DEFAULT NULL,
    "PopularityScore" REAL DEFAULT NULL,
    "ReleaseDate" DATE DEFAULT NULL,
    "RuntimeMinutes" INTEGER DEFAULT NULL,
    "AverageVote" REAL DEFAULT NULL
);

CREATE TABLE "MovieBudgetBetween15MillionAnd40Million" (
    "MovieId" INTEGER,
    "ProductionBudget" INTEGER DEFAULT NULL,
    "ReleaseStatus" TEXT DEFAULT NULL,
    "Synopsis" TEXT DEFAULT NULL,
    "PopularityScore" REAL DEFAULT NULL,
    "ReleaseDate" DATE DEFAULT NULL,
    "RuntimeMinutes" INTEGER DEFAULT NULL,
    "AverageVote" REAL DEFAULT NULL
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "filmStudioRelations" (
    "filmId" INTEGER DEFAULT NULL,
    "studioId" INTEGER DEFAULT NULL
);

CREATE TABLE "productionStudios" (
    "studioId" INTEGER,
    "studioName" TEXT DEFAULT NULL
);

CREATE TABLE "filmFinancials" (
    "filmId" INTEGER,
    "productionBudget" INTEGER DEFAULT NULL,
    "synopsis" TEXT DEFAULT NULL,
    "releaseDate" DATE DEFAULT NULL,
    "boxOfficeRevenue" INTEGER DEFAULT NULL,
    "durationMinutes" INTEGER DEFAULT NULL,
    "averageRating" REAL DEFAULT NULL,
    "ratingCount" INTEGER DEFAULT NULL
);

