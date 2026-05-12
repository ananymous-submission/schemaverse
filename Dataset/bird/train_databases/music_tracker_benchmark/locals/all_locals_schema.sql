-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/music_tracker/music_tracker.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "tag_assoc" (
    "assoc_pk" INTEGER,
    "media_ref" INTEGER,
    "tag_lbl" TEXT
);

CREATE TABLE "media_grp_2006_2011" (
    "grp_name" TEXT,
    "snatch_cnt" INTEGER,
    "artist_name" TEXT,
    "grp_year" INTEGER,
    "rel_type" TEXT,
    "grp_key" INTEGER,
    "media_pk" INTEGER
);

CREATE TABLE "media_grp_2012_2014" (
    "grp_name" TEXT,
    "snatch_cnt" INTEGER,
    "artist_name" TEXT,
    "grp_year" INTEGER,
    "rel_type" TEXT,
    "grp_key" INTEGER,
    "media_pk" INTEGER
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "torrentGroupsThrough2005" (
    "groupTitle" TEXT,
    "totalSnatchCount" INTEGER,
    "primaryArtist" TEXT,
    "releaseYear" INTEGER,
    "releaseCategory" TEXT,
    "groupIdentifier" INTEGER,
    "recordId" INTEGER
);

CREATE TABLE "torrentGroupsFrom2015OrUnknown" (
    "groupTitle" TEXT,
    "totalSnatchCount" INTEGER,
    "primaryArtist" TEXT,
    "releaseYear" INTEGER,
    "releaseCategory" TEXT,
    "groupIdentifier" INTEGER,
    "recordId" INTEGER
);

