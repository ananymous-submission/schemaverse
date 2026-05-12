-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct country from local_3.geo_ctry
CREATE VIEW "country" AS
SELECT
    "local_3"."geo_ctry"."ctry_id" AS "id",
    "local_3"."geo_ctry"."ctry_name" AS "country_name"
FROM "local_3"."geo_ctry";

-- Reconstruct ranking_criteria from local_2.score_metric
CREATE VIEW "ranking_criteria" AS
SELECT
    "local_2"."score_metric"."metric_id" AS "id",
    "local_2"."score_metric"."scoring_system_id" AS "ranking_system_id",
    "local_2"."score_metric"."metric_label" AS "criteria_name"
FROM "local_2"."score_metric";

-- Reconstruct ranking_system from local_3.rank_sys
CREATE VIEW "ranking_system" AS
SELECT
    "local_3"."rank_sys"."rank_id" AS "id",
    "local_3"."rank_sys"."rank_label" AS "system_name"
FROM "local_3"."rank_sys";

-- Reconstruct university from local_1.AcademicInstitution
CREATE VIEW "university" AS
SELECT
    "local_1"."AcademicInstitution"."AcademicInstitutionId" AS "id",
    "local_1"."AcademicInstitution"."CountryReferenceId" AS "country_id",
    "local_1"."AcademicInstitution"."OfficialName" AS "university_name"
FROM "local_1"."AcademicInstitution";

-- Reconstruct university_ranking_year from local_2.institution_ranking_snapshot
CREATE VIEW "university_ranking_year" AS
SELECT
    "local_2"."institution_ranking_snapshot"."institution_id" AS "university_id",
    "local_2"."institution_ranking_snapshot"."metric_id" AS "ranking_criteria_id",
    "local_2"."institution_ranking_snapshot"."assessment_year" AS "year",
    "local_2"."institution_ranking_snapshot"."metric_score" AS "score"
FROM "local_2"."institution_ranking_snapshot";

-- Reconstruct university_year from local_1.InstitutionYearlyStatistics
CREATE VIEW "university_year" AS
SELECT
    "local_1"."InstitutionYearlyStatistics"."AcademicInstitutionId" AS "university_id",
    "local_1"."InstitutionYearlyStatistics"."AcademicYear" AS "year",
    "local_1"."InstitutionYearlyStatistics"."StudentCount" AS "num_students",
    "local_1"."InstitutionYearlyStatistics"."StudentToStaffRatio" AS "student_staff_ratio",
    "local_1"."InstitutionYearlyStatistics"."InternationalStudentPercentage" AS "pct_international_students",
    "local_1"."InstitutionYearlyStatistics"."FemaleStudentPercentage" AS "pct_female_students"
FROM "local_1"."InstitutionYearlyStatistics";
