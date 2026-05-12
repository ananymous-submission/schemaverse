-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/coinmarketcap/coinmarketcap.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "CoinClassification" (
    "Id" INTEGER,
    "CategoryCode" TEXT,
    "Description" TEXT,
    "DisplayName" TEXT,
    "Notice" TEXT,
    "PlatformId" INTEGER,
    "Status" TEXT,
    "Symbol" TEXT,
    "TagNames" TEXT,
    "Tags" TEXT
);

CREATE TABLE "CoinReleaseAddedOnOrBefore2017Dec06" (
    "Id" INTEGER,
    "DateAdded" TEXT,
    "LaunchDate" TEXT,
    "Description" TEXT,
    "Name" TEXT,
    "Notice" TEXT,
    "PlatformId" INTEGER,
    "Slug" TEXT,
    "Status" TEXT,
    "Subreddit" TEXT,
    "Symbol" TEXT,
    "Website" TEXT
);

CREATE TABLE "CoinReleaseAddedAfter2017Dec06Through2020Mar18" (
    "Id" INTEGER,
    "DateAdded" TEXT,
    "LaunchDate" TEXT,
    "Description" TEXT,
    "Name" TEXT,
    "Notice" TEXT,
    "PlatformId" INTEGER,
    "Slug" TEXT,
    "Status" TEXT,
    "Subreddit" TEXT,
    "Symbol" TEXT,
    "Website" TEXT
);

CREATE TABLE "CoinReleaseAddedAfter2020Mar18Through2021Jan29" (
    "Id" INTEGER,
    "DateAdded" TEXT,
    "LaunchDate" TEXT,
    "Description" TEXT,
    "Name" TEXT,
    "Notice" TEXT,
    "PlatformId" INTEGER,
    "Slug" TEXT,
    "Status" TEXT,
    "Subreddit" TEXT,
    "Symbol" TEXT,
    "Website" TEXT
);

CREATE TABLE "CoinReleaseAddedAfter2021Jan29OrNull" (
    "Id" INTEGER,
    "DateAdded" TEXT,
    "LaunchDate" TEXT,
    "Description" TEXT,
    "Name" TEXT,
    "Notice" TEXT,
    "PlatformId" INTEGER,
    "Slug" TEXT,
    "Status" TEXT,
    "Subreddit" TEXT,
    "Symbol" TEXT,
    "Website" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "coin_price_history" (
    "snapshot_date" DATE,
    "asset_id" INTEGER,
    "market_rank" INTEGER,
    "market_capitalization" REAL,
    "last_price" REAL,
    "opening_price" REAL,
    "highest_price" REAL,
    "lowest_price" REAL,
    "closing_price" REAL,
    "high_timestamp" TEXT,
    "low_timestamp" TEXT,
    "volume_past_day" REAL,
    "percent_change_one_hour" REAL,
    "percent_change_one_day" REAL,
    "percent_change_one_week" REAL,
    "circulating_supply_amount" REAL,
    "total_supply_amount" REAL,
    "maximum_supply_amount" REAL,
    "market_pair_count" INTEGER
);

