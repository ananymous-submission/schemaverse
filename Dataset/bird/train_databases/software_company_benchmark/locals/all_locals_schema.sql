-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/software_company/software_company.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "customersEducationLowerThird" (
    "customerId" INTEGER,
    "gender" TEXT,
    "maritalStatus" TEXT,
    "geographicId" INTEGER,
    "educationLevel" INTEGER,
    "jobTitle" TEXT,
    "ageYears" INTEGER
);

CREATE TABLE "customersEducationAboveSevenOrMissing" (
    "customerId" INTEGER,
    "gender" TEXT,
    "maritalStatus" TEXT,
    "geographicId" INTEGER,
    "educationLevel" INTEGER,
    "jobTitle" TEXT,
    "ageYears" INTEGER
);

CREATE TABLE "mailingsFeb2007Snapshot" (
    "mailingRefId" INTEGER,
    "mailingDate" DATETIME,
    "responseStatus" TEXT
);

CREATE TABLE "mailingsMar2007Snapshot" (
    "mailingRefId" INTEGER,
    "mailingDate" DATETIME,
    "responseStatus" TEXT
);

CREATE TABLE "salesAmountBetweenTwelvePointFiveAndFifteenPointZeroZeroOne" (
    "saleEventId" INTEGER,
    "mailingRefId" INTEGER,
    "transactionDate" DATETIME,
    "saleAmount" REAL
);

CREATE TABLE "salesAmountBetweenFifteenPointZeroZeroOneAndSeventeenPointFive" (
    "saleEventId" INTEGER,
    "mailingRefId" INTEGER,
    "transactionDate" DATETIME,
    "saleAmount" REAL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "sls_amt_le_12_5" (
    "sale_evt_id" INTEGER,
    "mail_ref_id" INTEGER,
    "sale_evt_ts" DATETIME,
    "amt_val" REAL
);

CREATE TABLE "sls_amt_gt_17_5_or_null" (
    "sale_evt_id" INTEGER,
    "mail_ref_id" INTEGER,
    "sale_evt_ts" DATETIME,
    "amt_val" REAL
);

CREATE TABLE "mail_ref" (
    "mail_ref_id" INTEGER,
    "mail_ref_ts" DATETIME,
    "resp_text" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "AreaDemographics" (
    "GeoAreaId" INTEGER,
    "PopulationThousands" REAL,
    "IncomeThousands" REAL,
    "HouseholdSizeAverage" REAL,
    "EmploymentRate" REAL,
    "EducationAttainmentScore" REAL,
    "UrbanizationShare" REAL,
    "RuralPopulationShare" REAL,
    "MedianAge" REAL,
    "PopulationGrowthRate" REAL,
    "PovertyRate" REAL,
    "AccessibilityIndex" REAL,
    "HealthOutcomeIndex" REAL,
    "CrimeIncidenceRate" REAL,
    "InternetPenetrationRate" REAL,
    "PublicTransportUsage" REAL,
    "GreenSpacePercentage" REAL,
    "CommercialDensityIndex" REAL,
    "SchoolDensity" REAL,
    "HospitalDensity" REAL,
    "RecreationFacilityIndex" REAL
);

CREATE TABLE "CustomerProfilesEducationMiddleThird" (
    "CustomerId" INTEGER,
    "Gender" TEXT,
    "RelationshipStatus" TEXT,
    "GeoAreaId" INTEGER,
    "EducationLevelMiddleThird" INTEGER,
    "OccupationTitle" TEXT,
    "AgeYears" INTEGER
);

