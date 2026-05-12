-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/food_inspection/food_inspection.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "businessLocationRecord" (
    "businessId" INTEGER,
    "streetAddress" TEXT DEFAULT NULL,
    "applicationDate" DATE DEFAULT NULL,
    "certificateNumber" INTEGER NOT NULL,
    "cityName" TEXT DEFAULT NULL,
    "latitudeCoordinate" REAL DEFAULT NULL,
    "longitudeCoordinate" REAL DEFAULT NULL,
    "businessName" TEXT NOT NULL,
    "ownerFullName" TEXT NOT NULL,
    "ownerStateCode" TEXT DEFAULT NULL,
    "contactPhoneNumber" INTEGER DEFAULT NULL
);

CREATE TABLE "businessOwnerPostalInfo" (
    "businessId" INTEGER,
    "ownerPostalCode" TEXT DEFAULT NULL,
    "businessPostalCode" TEXT DEFAULT NULL,
    "taxIdentifier" TEXT DEFAULT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "biz_inspect" (
    "biz_id" INTEGER NOT NULL,
    "insp_score" INTEGER DEFAULT NULL,
    "insp_dt" DATE NOT NULL,
    "insp_type" TEXT NOT NULL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "inspection_violations" (
    "establishment_id" INTEGER NOT NULL,
    "violation_date" DATE NOT NULL,
    "violation_type_code" TEXT NOT NULL,
    "risk_level" TEXT NOT NULL,
    "violation_description" TEXT NOT NULL,
    FOREIGN KEY ("establishment_id") REFERENCES "establishments_address_until_2008_01_15"("establishment_id"),
    FOREIGN KEY ("establishment_id") REFERENCES "establishments_address_2008_01_15_to_2012_07_03"("establishment_id"),
    FOREIGN KEY ("establishment_id") REFERENCES "establishments_address_2012_07_03_to_2014_09_11"("establishment_id")
);

CREATE TABLE "establishments_address_until_2008_01_15" (
    "establishment_id" INTEGER,
    "street_address" TEXT DEFAULT NULL,
    "application_received_date" DATE DEFAULT NULL,
    "city_name" TEXT DEFAULT NULL,
    "establishment_name" TEXT NOT NULL,
    "proprietor_address" TEXT DEFAULT NULL,
    "proprietor_city" TEXT DEFAULT NULL,
    "proprietor_name" TEXT NOT NULL,
    "proprietor_state" TEXT DEFAULT NULL
);

CREATE TABLE "establishments_address_2008_01_15_to_2012_07_03" (
    "establishment_id" INTEGER,
    "street_address" TEXT DEFAULT NULL,
    "application_received_date" DATE DEFAULT NULL,
    "city_name" TEXT DEFAULT NULL,
    "establishment_name" TEXT NOT NULL,
    "proprietor_address" TEXT DEFAULT NULL,
    "proprietor_city" TEXT DEFAULT NULL,
    "proprietor_name" TEXT NOT NULL,
    "proprietor_state" TEXT DEFAULT NULL
);

CREATE TABLE "establishments_address_2012_07_03_to_2014_09_11" (
    "establishment_id" INTEGER,
    "street_address" TEXT DEFAULT NULL,
    "application_received_date" DATE DEFAULT NULL,
    "city_name" TEXT DEFAULT NULL,
    "establishment_name" TEXT NOT NULL,
    "proprietor_address" TEXT DEFAULT NULL,
    "proprietor_city" TEXT DEFAULT NULL,
    "proprietor_name" TEXT NOT NULL,
    "proprietor_state" TEXT DEFAULT NULL
);

CREATE TABLE "establishments_address_after_2014_09_11_or_null" (
    "establishment_id" INTEGER,
    "street_address" TEXT DEFAULT NULL,
    "application_received_date" DATE DEFAULT NULL,
    "city_name" TEXT DEFAULT NULL,
    "establishment_name" TEXT NOT NULL,
    "proprietor_address" TEXT DEFAULT NULL,
    "proprietor_city" TEXT DEFAULT NULL,
    "proprietor_name" TEXT NOT NULL,
    "proprietor_state" TEXT DEFAULT NULL
);

