-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/world/world.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "countryCapitalOtherGovernmentForms" (
    "countryCode" TEXT DEFAULT '',
    "capitalCityId" INTEGER DEFAULT NULL,
    "alternateCountryCode" TEXT NOT NULL DEFAULT '',
    "governmentType" TEXT NOT NULL DEFAULT '',
    "headOfStateName" TEXT DEFAULT NULL,
    "independenceYear" INTEGER DEFAULT NULL,
    "averageLifeExpectancy" REAL DEFAULT NULL,
    "localLanguageName" TEXT NOT NULL DEFAULT '',
    "commonName" TEXT NOT NULL DEFAULT '',
    "landAreaKm2" REAL NOT NULL DEFAULT 0.00
);

CREATE TABLE "countryCapitalListedGovernmentForms" (
    "countryCode" TEXT DEFAULT '',
    "capitalCityId" INTEGER DEFAULT NULL,
    "alternateCountryCode" TEXT NOT NULL DEFAULT '',
    "continentName" TEXT NOT NULL DEFAULT 'Asia',
    "gnpCurrent" REAL DEFAULT NULL,
    "gnpHistorical" REAL DEFAULT NULL,
    "governmentType" TEXT NOT NULL DEFAULT '',
    "independenceYear" INTEGER DEFAULT NULL,
    "averageLifeExpectancy" REAL DEFAULT NULL,
    "populationCount" INTEGER NOT NULL DEFAULT 0,
    "regionName" TEXT NOT NULL DEFAULT '',
    "landAreaKm2" REAL NOT NULL DEFAULT 0.00
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "UrbanLocality" (
    "UrbanLocalityId" INTEGER,
    "LocalityName" TEXT NOT NULL DEFAULT '',
    "NationIsoCode" TEXT NOT NULL DEFAULT '',
    "AdministrativeDistrict" TEXT NOT NULL DEFAULT '',
    "ResidentPopulation" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("NationIsoCode") REFERENCES "CountryConstitutionalMonarchy"("IsoCode")
);

CREATE TABLE "CountryRepublic" (
    "IsoCode" TEXT DEFAULT '',
    "CapitalCityId" INTEGER DEFAULT NULL,
    "SecondaryIsoCode" TEXT NOT NULL DEFAULT '',
    "GovernmentStructure" TEXT NOT NULL DEFAULT '',
    "HeadOfStateName" TEXT DEFAULT NULL,
    "IndependenceYear" INTEGER DEFAULT NULL,
    "AverageLifeExpectancy" REAL DEFAULT NULL,
    "NativeName" TEXT NOT NULL DEFAULT '',
    "OfficialEnglishName" TEXT NOT NULL DEFAULT '',
    "TotalSurfaceArea" REAL NOT NULL DEFAULT 0.00
);

CREATE TABLE "CountryConstitutionalMonarchy" (
    "IsoCode" TEXT DEFAULT '',
    "CapitalCityId" INTEGER DEFAULT NULL,
    "SecondaryIsoCode" TEXT NOT NULL DEFAULT '',
    "GovernmentStructure" TEXT NOT NULL DEFAULT '',
    "HeadOfStateName" TEXT DEFAULT NULL,
    "IndependenceYear" INTEGER DEFAULT NULL,
    "AverageLifeExpectancy" REAL DEFAULT NULL,
    "NativeName" TEXT NOT NULL DEFAULT '',
    "OfficialEnglishName" TEXT NOT NULL DEFAULT '',
    "TotalSurfaceArea" REAL NOT NULL DEFAULT 0.00
);

CREATE TABLE "CountryOtherGovernmentForms" (
    "IsoCode" TEXT DEFAULT '',
    "CapitalCityId" INTEGER DEFAULT NULL,
    "SecondaryIsoCode" TEXT NOT NULL DEFAULT '',
    "GovernmentStructure" TEXT NOT NULL DEFAULT '',
    "HeadOfStateName" TEXT DEFAULT NULL,
    "IndependenceYear" INTEGER DEFAULT NULL,
    "AverageLifeExpectancy" REAL DEFAULT NULL,
    "NativeName" TEXT NOT NULL DEFAULT '',
    "OfficialEnglishName" TEXT NOT NULL DEFAULT '',
    "TotalSurfaceArea" REAL NOT NULL DEFAULT 0.00
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "country_language_share_pct_le_1_2" (
    "country_iso_code" TEXT DEFAULT '',
    "language_name" TEXT DEFAULT '',
    "official_language_flag" TEXT NOT NULL DEFAULT 'F',
    "share_percentage" REAL NOT NULL DEFAULT 0.0
);

CREATE TABLE "country_language_share_pct_gt_1_2_le_5_3" (
    "country_iso_code" TEXT DEFAULT '',
    "language_name" TEXT DEFAULT '',
    "official_language_flag" TEXT NOT NULL DEFAULT 'F',
    "share_percentage" REAL NOT NULL DEFAULT 0.0
);

CREATE TABLE "country_language_share_pct_gt_5_3_le_21_1" (
    "country_iso_code" TEXT DEFAULT '',
    "language_name" TEXT DEFAULT '',
    "official_language_flag" TEXT NOT NULL DEFAULT 'F',
    "share_percentage" REAL NOT NULL DEFAULT 0.0
);

CREATE TABLE "country_language_share_pct_gt_21_1_or_null" (
    "country_iso_code" TEXT DEFAULT '',
    "language_name" TEXT DEFAULT '',
    "official_language_flag" TEXT NOT NULL DEFAULT 'F',
    "share_percentage" REAL NOT NULL DEFAULT 0.0
);

