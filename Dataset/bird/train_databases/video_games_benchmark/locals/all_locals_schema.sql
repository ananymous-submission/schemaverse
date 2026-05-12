-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/video_games/video_games.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "videoGame" (
    "videoGameId" INTEGER,
    "genreId" INTEGER DEFAULT NULL,
    "title" TEXT DEFAULT NULL
);

CREATE TABLE "gameGenre" (
    "genreId" INTEGER,
    "name" TEXT DEFAULT NULL
);

CREATE TABLE "hardwarePlatform" (
    "platformId" INTEGER,
    "name" TEXT DEFAULT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "platform_releases_up_to_2003" (
    "platform_release_up_to_2003_id" INTEGER,
    "publisher_ref_id" INTEGER DEFAULT NULL,
    "platform_ref_id" INTEGER DEFAULT NULL,
    "year_of_release" INTEGER DEFAULT NULL
);

CREATE TABLE "platform_releases_after_2010_or_null" (
    "platform_release_after_2010_or_null_id" INTEGER,
    "publisher_ref_id" INTEGER DEFAULT NULL,
    "platform_ref_id" INTEGER DEFAULT NULL,
    "year_of_release" INTEGER DEFAULT NULL
);

CREATE TABLE "game_publishers" (
    "publisher_id" INTEGER,
    "publisher_full_name" TEXT DEFAULT NULL
);

CREATE TABLE "sales_by_region" (
    "region_code" INTEGER DEFAULT NULL,
    "platform_release_ref_id" INTEGER DEFAULT NULL,
    "sales_quantity" REAL DEFAULT NULL,
    FOREIGN KEY ("platform_release_ref_id") REFERENCES "platform_releases_up_to_2003"("platform_release_up_to_2003_id"),
    FOREIGN KEY ("platform_release_ref_id") REFERENCES "platform_releases_after_2010_or_null"("platform_release_after_2010_or_null_id")
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "gm_pub_map" (
    "pub_map_id" INTEGER,
    "gm_id" INTEGER DEFAULT NULL,
    "pub_id" INTEGER DEFAULT NULL
);

CREATE TABLE "geo_region" (
    "reg_id" INTEGER,
    "reg_name" TEXT DEFAULT NULL
);

CREATE TABLE "gm_plat_rel_2004_2007" (
    "rel_id" INTEGER,
    "pub_map_id" INTEGER DEFAULT NULL,
    "plat_id" INTEGER DEFAULT NULL,
    "rel_yr" INTEGER DEFAULT NULL,
    FOREIGN KEY ("pub_map_id") REFERENCES "gm_pub_map"("pub_map_id")
);

CREATE TABLE "gm_plat_rel_2008_2010" (
    "rel_id" INTEGER,
    "pub_map_id" INTEGER DEFAULT NULL,
    "plat_id" INTEGER DEFAULT NULL,
    "rel_yr" INTEGER DEFAULT NULL,
    FOREIGN KEY ("pub_map_id") REFERENCES "gm_pub_map"("pub_map_id")
);

