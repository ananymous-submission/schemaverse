-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/Db-IMDB/Db-IMDB.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "country_reference" (
    "sort_rank" INTEGER,
    "common_name" TEXT,
    "country_id" INTEGER
);

CREATE TABLE "genre_reference" (
    "display_order" INTEGER,
    "genre_label" TEXT,
    "genre_id" INTEGER
);

CREATE TABLE "language_reference" (
    "priority_rank" INTEGER,
    "language_name" TEXT,
    "language_id" INTEGER
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "loc_ref" (
    "rec_idx" INTEGER,
    "loc_name" TEXT,
    "loc_id" INTEGER
);

CREATE TABLE "mv_cast_rel" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "prsn_id" TEXT,
    "ent_id" INTEGER
);

CREATE TABLE "mv_genre_gid_lte19" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "gen_id" INTEGER,
    "ent_id" INTEGER
);

CREATE TABLE "mv_genre_gid_20to46" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "gen_id" INTEGER,
    "ent_id" INTEGER
);

CREATE TABLE "mv_genre_gid_47to76" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "gen_id" INTEGER,
    "ent_id" INTEGER
);

CREATE TABLE "mv_genre_gid_gt76_or_null" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "gen_id" INTEGER,
    "ent_id" INTEGER
);

CREATE TABLE "mv_lang_rel" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "lang_id" INTEGER,
    "ent_id" INTEGER
);

CREATE TABLE "mv_loc_lid_lte35" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "loc_id" REAL,
    "ent_id" INTEGER
);

CREATE TABLE "mv_loc_lid_36to124" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "loc_id" REAL,
    "ent_id" INTEGER
);

CREATE TABLE "mv_loc_lid_125to259" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "loc_id" REAL,
    "ent_id" INTEGER
);

CREATE TABLE "mv_loc_lid_gt259_or_null" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "loc_id" REAL,
    "ent_id" INTEGER
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "MovieCountryRelation" (
    "RowIndex" INTEGER,
    "MovieIdentifier" TEXT,
    "CountryIdentifier" REAL,
    "RelationId" INTEGER
);

CREATE TABLE "MovieProducerRelation" (
    "RowIndex" INTEGER,
    "MovieIdentifier" TEXT,
    "ProducerIdentifier" TEXT,
    "RelationId" INTEGER
);

CREATE TABLE "MovieRatingAtMost5Point1" (
    "RowIndex" INTEGER,
    "MovieIdentifier" TEXT,
    "MovieTitle" TEXT,
    "ReleaseYear" TEXT,
    "RatingScore" REAL,
    "VoteCount" INTEGER
);

CREATE TABLE "MovieRatingGreaterThan5Point1UpTo6Point2" (
    "RowIndex" INTEGER,
    "MovieIdentifier" TEXT,
    "MovieTitle" TEXT,
    "ReleaseYear" TEXT,
    "RatingScore" REAL,
    "VoteCount" INTEGER
);

CREATE TABLE "MovieRatingGreaterThan6Point2UpTo7Point1" (
    "RowIndex" INTEGER,
    "MovieIdentifier" TEXT,
    "MovieTitle" TEXT,
    "ReleaseYear" TEXT,
    "RatingScore" REAL,
    "VoteCount" INTEGER
);

CREATE TABLE "MovieRatingGreaterThan7Point1OrMissing" (
    "RowIndex" INTEGER,
    "MovieIdentifier" TEXT,
    "MovieTitle" TEXT,
    "ReleaseYear" TEXT,
    "RatingScore" REAL,
    "VoteCount" INTEGER
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "movieDirectorship" (
    "creditOrder" INTEGER,
    "movieId" TEXT,
    "personId" TEXT,
    "directorshipId" INTEGER
);

CREATE TABLE "malePerson" (
    "recordIndex" INTEGER,
    "personId" TEXT,
    "fullName" TEXT,
    "gender" TEXT
);

CREATE TABLE "femaleOrNullPerson" (
    "recordIndex" INTEGER,
    "personId" TEXT,
    "fullName" TEXT,
    "gender" TEXT
);

