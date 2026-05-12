-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/university/university.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "AcademicInstitution" (
    "AcademicInstitutionId" INTEGER,
    "CountryReferenceId" INTEGER DEFAULT NULL,
    "OfficialName" TEXT DEFAULT NULL
);

CREATE TABLE "InstitutionYearlyStatistics" (
    "AcademicInstitutionId" INTEGER DEFAULT NULL,
    "AcademicYear" INTEGER DEFAULT NULL,
    "StudentCount" INTEGER DEFAULT NULL,
    "StudentToStaffRatio" REAL DEFAULT NULL,
    "InternationalStudentPercentage" INTEGER DEFAULT NULL,
    "FemaleStudentPercentage" INTEGER DEFAULT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "score_metric" (
    "metric_id" INTEGER,
    "scoring_system_id" INTEGER DEFAULT NULL,
    "metric_label" TEXT DEFAULT NULL
);

CREATE TABLE "institution_ranking_snapshot" (
    "institution_id" INTEGER DEFAULT NULL,
    "metric_id" INTEGER DEFAULT NULL,
    "assessment_year" INTEGER DEFAULT NULL,
    "metric_score" INTEGER DEFAULT NULL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "geo_ctry" (
    "ctry_id" INTEGER,
    "ctry_name" TEXT DEFAULT NULL
);

CREATE TABLE "rank_sys" (
    "rank_id" INTEGER,
    "rank_label" TEXT DEFAULT NULL
);

