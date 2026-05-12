-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/imdb_movies/imdb_movies.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "obj_prop_grid" (
    "lbl" TEXT,
    "score_a" REAL,
    "score_b" REAL,
    "category" TEXT,
    "metric_a" REAL,
    "metric_b" REAL,
    "metric_c" REAL,
    "metric_d" REAL,
    "metric_e" REAL,
    "metric_f" REAL,
    "note" TEXT,
    "src_col" TEXT
);

CREATE TABLE "obj_prop_grid_ext" (
    "tag" TEXT,
    "score_a" REAL,
    "score_b" REAL,
    "category" TEXT,
    "note" TEXT,
    "src_col" TEXT,
    "src_table" TEXT
);

CREATE TABLE "dir_map" (
    "mv_id" TEXT,
    "nm_id" TEXT
);

CREATE TABLE "rtg_avg_5_to_6" (
    "mv_id" TEXT,
    "avg_rtg" REAL,
    "vote_cnt" INTEGER,
    "med_rtg" REAL
);

CREATE TABLE "rtg_avg_6_to_6_7" (
    "mv_id" TEXT,
    "avg_rtg" REAL,
    "vote_cnt" INTEGER,
    "med_rtg" REAL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "MoviesByGenreDrama" (
    "MovieId" TEXT,
    "GenreValue" TEXT
);

CREATE TABLE "MoviesByGenreComedy" (
    "MovieId" TEXT,
    "GenreValue" TEXT
);

CREATE TABLE "MoviesByGenreThriller" (
    "MovieId" TEXT,
    "GenreValue" TEXT
);

CREATE TABLE "MoviesByGenreActionOrHorror" (
    "MovieId" TEXT,
    "GenreValue" TEXT
);

CREATE TABLE "MoviesByGenreRomanceAndCrime" (
    "MovieId" TEXT,
    "GenreValue" TEXT
);

CREATE TABLE "MoviesByGenreAdventureMysteryOther" (
    "MovieId" TEXT,
    "GenreValue" TEXT
);

CREATE TABLE "MovieCountryDetails" (
    "MovieId" TEXT,
    "Country" TEXT,
    "ReleaseDate" TIMESTAMP,
    "Languages" TEXT,
    "ProductionCompany" TEXT,
    "Title" TEXT,
    "WorldwideGrossIncome" TEXT,
    "ReleaseYear" INTEGER
);

CREATE TABLE "MoviesDurationUpTo90" (
    "MovieId" TEXT,
    "DurationMinutes" INTEGER,
    "Languages" TEXT,
    "ProductionCompany" TEXT,
    "Title" TEXT,
    "WorldwideGrossIncome" TEXT
);

CREATE TABLE "MoviesDuration91To99" (
    "MovieId" TEXT,
    "DurationMinutes" INTEGER,
    "Languages" TEXT,
    "ProductionCompany" TEXT,
    "Title" TEXT,
    "WorldwideGrossIncome" TEXT
);

CREATE TABLE "MoviesDuration100To114" (
    "MovieId" TEXT,
    "DurationMinutes" INTEGER,
    "Languages" TEXT,
    "ProductionCompany" TEXT,
    "Title" TEXT,
    "WorldwideGrossIncome" TEXT
);

CREATE TABLE "MoviesDurationAbove114OrUnknown" (
    "MovieId" TEXT,
    "DurationMinutes" INTEGER,
    "Languages" TEXT,
    "ProductionCompany" TEXT,
    "Title" TEXT,
    "WorldwideGrossIncome" TEXT
);

CREATE TABLE "MovieRatingsAvgAtMostFive" (
    "MovieId" TEXT,
    "AverageRating" REAL,
    "TotalVotes" INTEGER,
    "MedianRating" REAL
);

CREATE TABLE "MovieRatingsAvgAboveSixPointSevenOrUnknown" (
    "MovieId" TEXT,
    "AverageRating" REAL,
    "TotalVotes" INTEGER,
    "MedianRating" REAL
);

CREATE TABLE "MovieRoleMappingsActress" (
    "MovieId" TEXT,
    "PersonId" TEXT,
    "RoleCategory" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "personProfiles" (
    "personId" TEXT,
    "fullName" TEXT,
    "heightMeters" REAL,
    "birthDate" TEXT,
    "knownForFilms" TEXT
);

CREATE TABLE "actorCastings" (
    "filmId" TEXT,
    "personId" TEXT,
    "roleCategory" TEXT
);

