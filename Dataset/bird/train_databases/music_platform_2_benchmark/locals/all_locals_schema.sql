-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/music_platform_2/music_platform_2.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "PodcastSeries" (
    "SeriesId" TEXT,
    "ItunesIdentifier" INTEGER NOT NULL,
    "UrlSlug" TEXT NOT NULL,
    "ItunesLink" TEXT NOT NULL,
    "SeriesTitle" TEXT NOT NULL
);

CREATE TABLE "PodcastReview" (
    "SeriesId" TEXT NOT NULL,
    "ReviewTitle" TEXT NOT NULL,
    "ReviewContent" TEXT NOT NULL,
    "RatingScore" INTEGER NOT NULL,
    "ReviewerId" TEXT NOT NULL,
    "SubmittedAt" TEXT NOT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "batch_executions" (
    "executed_at" TEXT NOT NULL,
    "highest_record_id" INTEGER NOT NULL,
    "inserted_reviews_count" INTEGER NOT NULL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "pod_cat_map" (
    "pod_id" TEXT,
    "cat_tag" TEXT
);

