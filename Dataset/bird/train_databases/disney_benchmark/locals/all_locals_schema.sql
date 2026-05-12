-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/disney/disney.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "mov_info" (
    "mov_title" TEXT,
    "rel_date" TEXT,
    "lead_char" TEXT,
    "antag_char" TEXT,
    "feat_song" TEXT
);

CREATE TABLE "gross_mpaa_comedy" (
    "mov_title" TEXT,
    "rel_date" TEXT,
    "mpaa_rt" TEXT,
    "genre_cat" TEXT
);

CREATE TABLE "gross_mpaa_adventure" (
    "mov_title" TEXT,
    "rel_date" TEXT,
    "mpaa_rt" TEXT,
    "genre_cat" TEXT,
    FOREIGN KEY ("mov_title") REFERENCES "mov_info"("mov_title")
);

CREATE TABLE "gross_mpaa_drama" (
    "mov_title" TEXT,
    "rel_date" TEXT,
    "mpaa_rt" TEXT,
    "genre_cat" TEXT
);

CREATE TABLE "gross_mpaa_act_thr_rom" (
    "mov_title" TEXT,
    "rel_date" TEXT,
    "mpaa_rt" TEXT,
    "genre_cat" TEXT
);

CREATE TABLE "gross_mpaa_other_doc_mus" (
    "mov_title" TEXT,
    "rel_date" TEXT,
    "mpaa_rt" TEXT,
    "genre_cat" TEXT
);

CREATE TABLE "gross_mpaa_full" (
    "mov_title" TEXT,
    "rel_date" TEXT,
    "mpaa_rt" TEXT,
    "genre_cat" TEXT,
    "infl_adj_gross" TEXT,
    "tot_gross" TEXT,
    FOREIGN KEY ("mov_title") REFERENCES "mov_info"("mov_title")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "film_credits" (
    "film_title" TEXT,
    "director_full_name" TEXT
);

CREATE TABLE "annual_revenue_summary" (
    "fiscal_year" INTEGER,
    "studio_entertainment_revenue" REAL,
    "consumer_products_revenue" REAL,
    "interactive_media_revenue" INTEGER,
    "parks_and_resorts_revenue" REAL,
    "media_networks_segment" TEXT,
    "total_revenue" INTEGER
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "VoicePerformances" (
    "CharacterName" TEXT,
    "PerformerName" TEXT,
    "FilmTitle" TEXT
);

