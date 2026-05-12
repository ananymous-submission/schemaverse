-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/restaurant/restaurant.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "RestaurantProfile" (
    "RestaurantId" INTEGER,
    "RestaurantName" TEXT,
    "CuisineType" TEXT,
    "CityName" TEXT,
    "ReviewScore" REAL,
    FOREIGN KEY ("CityName") REFERENCES "ContraCostaMarinNapaGeography"("CityName"),
    FOREIGN KEY ("CityName") REFERENCES "AlamedaSantaClaraGeography"("CityName"),
    FOREIGN KEY ("CityName") REFERENCES "SonomaMontereyGeography"("CityName")
);

CREATE TABLE "LocationStreetNumRangeGt518To1459" (
    "RestaurantId" INTEGER,
    "StreetNumber" INTEGER,
    "StreetName" TEXT,
    "CityName" TEXT,
    FOREIGN KEY ("CityName") REFERENCES "SanMateoCountyGeography"("CityName"),
    FOREIGN KEY ("CityName") REFERENCES "AlamedaSantaClaraGeography"("CityName"),
    FOREIGN KEY ("CityName") REFERENCES "SonomaMontereyGeography"("CityName")
);

CREATE TABLE "LocationStreetNumRangeGt1459To3080" (
    "RestaurantId" INTEGER,
    "StreetNumber" INTEGER,
    "StreetName" TEXT,
    "CityName" TEXT,
    FOREIGN KEY ("CityName") REFERENCES "SanMateoCountyGeography"("CityName"),
    FOREIGN KEY ("CityName") REFERENCES "SonomaMontereyGeography"("CityName")
);

CREATE TABLE "SanMateoCountyGeography" (
    "CityName" TEXT,
    "CountyName" TEXT,
    "RegionName" TEXT
);

CREATE TABLE "ContraCostaMarinNapaGeography" (
    "CityName" TEXT,
    "CountyName" TEXT,
    "RegionName" TEXT
);

CREATE TABLE "AlamedaSantaClaraGeography" (
    "CityName" TEXT,
    "CountyName" TEXT,
    "RegionName" TEXT
);

CREATE TABLE "SonomaMontereyGeography" (
    "CityName" TEXT,
    "CountyName" TEXT,
    "RegionName" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "cities_unknown_county" (
    "city_name" TEXT,
    "county_name" TEXT,
    "region_name" TEXT
);

CREATE TABLE "cities_other_or_null_county" (
    "city_name" TEXT,
    "county_name" TEXT,
    "region_name" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "rst_loc_le518" (
    "rst_id" INTEGER,
    "st_no" INTEGER,
    "st_name" TEXT,
    "cty" TEXT
);

CREATE TABLE "rst_loc_gt3080_or_null" (
    "rst_id" INTEGER,
    "st_no" INTEGER,
    "st_name" TEXT,
    "cty" TEXT
);

