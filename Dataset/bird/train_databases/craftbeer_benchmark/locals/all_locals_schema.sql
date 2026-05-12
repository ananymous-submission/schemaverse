-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/craftbeer/craftbeer.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "beersAbvAtMost0Point05" (
    "beerId" INTEGER,
    "breweryId" INTEGER NOT NULL,
    "alcoholByVolume" REAL,
    "bitternessIbu" REAL,
    "beerName" TEXT NOT NULL,
    "beerStyle" TEXT,
    "volumeOunces" REAL NOT NULL
);

CREATE TABLE "beersAbvGreaterThan0Point067OrNull" (
    "beerId" INTEGER,
    "breweryId" INTEGER NOT NULL,
    "alcoholByVolume" REAL,
    "bitternessIbu" REAL,
    "beerName" TEXT NOT NULL,
    "beerStyle" TEXT,
    "volumeOunces" REAL NOT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "brw_registry" (
    "brw_id" INTEGER,
    "brw_nm" TEXT,
    "loc_city" TEXT,
    "loc_state" TEXT
);

CREATE TABLE "beer_abv_0p05_0p056" (
    "beer_id" INTEGER,
    "brw_id_fk" INTEGER NOT NULL,
    "alc_frac" REAL,
    "ibu_val" REAL,
    "beer_nm" TEXT NOT NULL,
    "beer_style" TEXT,
    "vol_oz" REAL NOT NULL
);

CREATE TABLE "beer_abv_0p056_0p067" (
    "beer_id" INTEGER,
    "brw_id_fk" INTEGER NOT NULL,
    "alc_frac" REAL,
    "ibu_val" REAL,
    "beer_nm" TEXT NOT NULL,
    "beer_style" TEXT,
    "vol_oz" REAL NOT NULL
);

