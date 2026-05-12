-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/european_football_1/european_football_1.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "org_divs" (
    "div_id" TEXT,
    "div_lbl" TEXT,
    "ctry_cd" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "MatchRecord" (
    "DivisionCode" TEXT,
    "MatchDate" DATE,
    "HomeTeamName" TEXT,
    "AwayTeamName" TEXT,
    "FullTimeHomeGoals" INTEGER,
    "FullTimeAwayGoals" INTEGER,
    "FullTimeResult" TEXT,
    "SeasonYear" INTEGER
);

