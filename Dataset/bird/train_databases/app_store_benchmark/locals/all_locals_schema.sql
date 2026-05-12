-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/app_store/app_store.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "apps_repo" (
    "app_name" TEXT,
    "app_cat" TEXT,
    "avg_rating" REAL,
    "rev_count" INTEGER,
    "app_size" TEXT,
    "inst_count" TEXT,
    "app_type" TEXT,
    "price_amt" TEXT,
    "age_rating" TEXT,
    "genre_list" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "app_feedback" (
    "app_name" TEXT,
    "translated_review_text" TEXT,
    "sentiment_label" TEXT,
    "sentiment_polarity_score" TEXT,
    "sentiment_subjectivity_score" TEXT
);

