-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/human_resources/human_resources.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "StaffMember" (
    "SocialSecurityNumber" TEXT,
    "FamilyName" TEXT,
    "GivenName" TEXT,
    "EmploymentStartDate" TEXT,
    "AnnualSalary" TEXT,
    "GenderIdentity" TEXT,
    "PerformanceRating" TEXT,
    "RoleIdentifier" INTEGER,
    "WorksiteIdentifier" INTEGER
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "site" (
    "siteId" INTEGER,
    "cityName" TEXT,
    "streetAddress" TEXT,
    "stateCode" TEXT,
    "postalCode" INTEGER,
    "officePhoneNumber" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "job_role" (
    "job_role_id" INTEGER,
    "job_title" TEXT,
    "required_education" TEXT,
    "minimum_salary" TEXT,
    "maximum_salary" TEXT
);

