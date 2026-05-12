-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/college_completion/college_completion.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "InstitutionAidProfile" (
    "InstitutionId" INTEGER,
    "TotalAidAmount" INTEGER,
    "AwardsPerNationalAverage" REAL,
    "AwardsPerStateAverage" REAL,
    "AwardsPerInstitutionAverage" REAL,
    "BasicCategory" TEXT,
    "CarnegieClassification" INTEGER,
    "ChronicleName" TEXT,
    "CityName" TEXT,
    "CohortSize" INTEGER,
    "ControlType" TEXT,
    "EndowmentValue" TEXT,
    "ExpectedAwardsNational" INTEGER,
    "ExpectedAwardsState" INTEGER,
    "ExpectedAwardsInstitution" INTEGER,
    "FlagshipIndicator" TEXT,
    "FullTimeFacultyFte" REAL,
    "GraduationRateReference" REAL,
    "HistoricallyBlackCollegeIndicator" TEXT,
    "Latitude" REAL,
    "EducationLevel" TEXT,
    "Longitude" REAL,
    "MedianSatScore" TEXT,
    "NicknamesList" TEXT,
    "PellGrantRate" REAL,
    "RetentionRate" REAL,
    "SimilarInstitutions" TEXT,
    "WebsiteUrl" TEXT,
    "StateCode" TEXT,
    "StateSectorCount" INTEGER,
    "VsaYear" TEXT
);

CREATE TABLE "InstitutionVsaDetails" (
    "InstitutionId" INTEGER,
    "VsaEnrollmentAfterFourYearsFirstTime" TEXT,
    "VsaEnrollmentAfterFourYearsTransfer" TEXT,
    "VsaEnrollmentAfterSixYearsFirstTime" TEXT,
    "VsaEnrollmentAfterSixYearsTransfer" TEXT,
    "VsaEnrollmentElsewhereAfterFourYearsFirstTime" TEXT,
    "VsaEnrollmentElsewhereAfterFourYearsTransfer" TEXT,
    "VsaEnrollmentElsewhereAfterSixYearsFirstTime" TEXT,
    "VsaEnrollmentElsewhereAfterSixYearsTransfer" TEXT,
    "VsaGraduationAfterFourYearsFirstTime" TEXT,
    "VsaGraduationAfterFourYearsTransfer" TEXT,
    "VsaGraduationAfterSixYearsFirstTime" TEXT,
    "VsaGraduationAfterSixYearsTransfer" TEXT,
    "VsaGraduationElsewhereAfterFourYearsFirstTime" TEXT,
    "VsaGraduationElsewhereAfterFourYearsTransfer" TEXT,
    "VsaGraduationElsewhereAfterSixYearsFirstTime" TEXT,
    "VsaGraduationElsewhereAfterSixYearsTransfer" TEXT
);

CREATE TABLE "InstitutionGraduationRecords" (
    "InstitutionId" INTEGER,
    "GraduationYear" INTEGER,
    "Gender" TEXT,
    "RaceEthnicity" TEXT,
    "CohortIdentifier" TEXT,
    "GraduatedCohort" TEXT,
    "GraduationCountStandardTerm" TEXT,
    "GraduationCountExtendedTerm" TEXT,
    "GraduationRateStandardTerm" TEXT,
    "GraduationRateExtendedTerm" TEXT
);

CREATE TABLE "StateSectorProfile" (
    "StateSectorIdentifier" INTEGER,
    "SectorLevel" TEXT,
    "ControlCategory" TEXT,
    "StateCode" TEXT,
    "StatePostalCode" TEXT,
    FOREIGN KEY ("StateCode") REFERENCES "InstitutionAidProfile"("StateCode")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "stateSectorAwardsNationalValue" (
    "stateIdentifier" INTEGER,
    "educationLevel" TEXT,
    "institutionControl" TEXT,
    "awardsPerNationalValue" REAL,
    "awardsByRank" TEXT,
    "stateAwardValue" TEXT,
    "expectedAwardNationalValue" INTEGER,
    "institutionCount" INTEGER,
    "stateApprovalValue" TEXT
);

CREATE TABLE "stateSectorAwardsRankings" (
    "stateIdentifier" INTEGER,
    "educationLevel" TEXT,
    "institutionControl" TEXT,
    "awardsByRank" TEXT,
    "graduationRateRank" TEXT,
    "stateApprovalRank" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "state_sector_graduation_stats" (
    "state_id" INTEGER,
    "state_name" TEXT,
    "state_abbreviation" TEXT,
    "control_type" TEXT,
    "institution_level" TEXT,
    "academic_year" INTEGER,
    "gender" TEXT,
    "race_ethnicity" TEXT,
    "cohort_label" TEXT,
    "graduation_cohort_label" TEXT,
    "grad_within_100_pct" TEXT,
    "grad_within_150_pct" TEXT,
    "grad_within_100_rate" TEXT,
    "grad_within_150_rate" TEXT,
    "grad_cohort_count" INTEGER,
    FOREIGN KEY ("state_id") REFERENCES "state_sector_awards_per_national_schools_lte_1"("state_id"),
    FOREIGN KEY ("state_id") REFERENCES "state_sector_awards_per_national_schools_7_to_16"("state_id"),
    FOREIGN KEY ("state_id") REFERENCES "state_sector_awards_per_national_schools_gt_16_or_null"("state_id")
);

CREATE TABLE "institution_aid_stats_awards_per_lte_17_3" (
    "institution_id" INTEGER,
    "aid_amount" INTEGER,
    "awards_per_value_rate" REAL,
    "basic_category" TEXT,
    "carnegie_classification_id" INTEGER,
    "official_name" TEXT,
    "city_name" TEXT,
    "cohort_population" INTEGER,
    "control_type" TEXT,
    "counted_percentage" TEXT,
    "endowment_value_text" TEXT,
    "expected_award_amount" INTEGER,
    "flagship_designation" TEXT,
    "full_time_faculty_count" REAL,
    "full_time_percentage" REAL,
    "fte_count" INTEGER,
    "graduation_100_value" REAL,
    "graduation_150_value" REAL,
    "hbcu_indicator" TEXT,
    "latitude" REAL,
    "institution_level" TEXT,
    "longitude" REAL,
    "median_sat_value" TEXT,
    "nickname_list" TEXT,
    "pell_value_amount" REAL,
    "retention_rate_value" REAL,
    "comparable_institutions" TEXT,
    "website_url" TEXT,
    "state_sector_count" INTEGER,
    "total_enrollment" INTEGER,
    "vsa_report_year" TEXT
);

CREATE TABLE "institution_aid_stats_awards_per_17_3_to_21_3" (
    "institution_id" INTEGER,
    "aid_amount" INTEGER,
    "awards_per_value_rate" REAL,
    "basic_category" TEXT,
    "carnegie_classification_id" INTEGER,
    "official_name" TEXT,
    "city_name" TEXT,
    "cohort_population" INTEGER,
    "control_type" TEXT,
    "counted_percentage" TEXT,
    "endowment_value_text" TEXT,
    "expected_award_amount" INTEGER,
    "flagship_designation" TEXT,
    "full_time_faculty_count" REAL,
    "full_time_percentage" REAL,
    "fte_count" INTEGER,
    "graduation_100_value" REAL,
    "graduation_150_value" REAL,
    "hbcu_indicator" TEXT,
    "latitude" REAL,
    "institution_level" TEXT,
    "longitude" REAL,
    "median_sat_value" TEXT,
    "nickname_list" TEXT,
    "pell_value_amount" REAL,
    "retention_rate_value" REAL,
    "comparable_institutions" TEXT,
    "website_url" TEXT,
    "state_sector_count" INTEGER,
    "total_enrollment" INTEGER,
    "vsa_report_year" TEXT
);

CREATE TABLE "institution_aid_stats_awards_per_21_3_to_26_5" (
    "institution_id" INTEGER,
    "aid_amount" INTEGER,
    "awards_per_value_rate" REAL,
    "basic_category" TEXT,
    "carnegie_classification_id" INTEGER,
    "official_name" TEXT,
    "city_name" TEXT,
    "cohort_population" INTEGER,
    "control_type" TEXT,
    "counted_percentage" TEXT,
    "endowment_value_text" TEXT,
    "expected_award_amount" INTEGER,
    "flagship_designation" TEXT,
    "full_time_faculty_count" REAL,
    "full_time_percentage" REAL,
    "fte_count" INTEGER,
    "graduation_100_value" REAL,
    "graduation_150_value" REAL,
    "hbcu_indicator" TEXT,
    "latitude" REAL,
    "institution_level" TEXT,
    "longitude" REAL,
    "median_sat_value" TEXT,
    "nickname_list" TEXT,
    "pell_value_amount" REAL,
    "retention_rate_value" REAL,
    "comparable_institutions" TEXT,
    "website_url" TEXT,
    "state_sector_count" INTEGER,
    "total_enrollment" INTEGER,
    "vsa_report_year" TEXT
);

CREATE TABLE "institution_aid_stats_awards_per_gt_26_5_or_null" (
    "institution_id" INTEGER,
    "aid_amount" INTEGER,
    "awards_per_value_rate" REAL,
    "basic_category" TEXT,
    "carnegie_classification_id" INTEGER,
    "official_name" TEXT,
    "city_name" TEXT,
    "cohort_population" INTEGER,
    "control_type" TEXT,
    "counted_percentage" TEXT,
    "endowment_value_text" TEXT,
    "expected_award_amount" INTEGER,
    "flagship_designation" TEXT,
    "full_time_faculty_count" REAL,
    "full_time_percentage" REAL,
    "fte_count" INTEGER,
    "graduation_100_value" REAL,
    "graduation_150_value" REAL,
    "hbcu_indicator" TEXT,
    "latitude" REAL,
    "institution_level" TEXT,
    "longitude" REAL,
    "median_sat_value" TEXT,
    "nickname_list" TEXT,
    "pell_value_amount" REAL,
    "retention_rate_value" REAL,
    "comparable_institutions" TEXT,
    "website_url" TEXT,
    "state_sector_count" INTEGER,
    "total_enrollment" INTEGER,
    "vsa_report_year" TEXT
);

CREATE TABLE "state_sector_awards_per_national_schools_lte_1" (
    "state_id" INTEGER,
    "institution_level" TEXT,
    "control_type" TEXT,
    "awards_per_national_value" REAL,
    "expected_award_national_value" INTEGER,
    "expected_award_state_value_text" TEXT,
    "schools_count_in_sector" INTEGER,
    "state_approval_value" TEXT
);

CREATE TABLE "state_sector_awards_per_national_schools_1_to_7" (
    "state_id" INTEGER,
    "institution_level" TEXT,
    "control_type" TEXT,
    "awards_per_national_value" REAL,
    "expected_award_national_value" INTEGER,
    "expected_award_state_value_text" TEXT,
    "schools_count_in_sector" INTEGER,
    "state_approval_value" TEXT
);

CREATE TABLE "state_sector_awards_per_national_schools_7_to_16" (
    "state_id" INTEGER,
    "institution_level" TEXT,
    "control_type" TEXT,
    "awards_per_national_value" REAL,
    "expected_award_national_value" INTEGER,
    "expected_award_state_value_text" TEXT,
    "schools_count_in_sector" INTEGER,
    "state_approval_value" TEXT
);

CREATE TABLE "state_sector_awards_per_national_schools_gt_16_or_null" (
    "state_id" INTEGER,
    "institution_level" TEXT,
    "control_type" TEXT,
    "awards_per_national_value" REAL,
    "expected_award_national_value" INTEGER,
    "expected_award_state_value_text" TEXT,
    "schools_count_in_sector" INTEGER,
    "state_approval_value" TEXT
);

CREATE TABLE "institution_financial_percentiles" (
    "institution_id" INTEGER,
    "grant_aid_percentile" INTEGER,
    "endowment_percentile" TEXT,
    "expected_award_percentile" INTEGER,
    "full_time_faculty_percentile" INTEGER,
    "full_time_equivalent_percentile" INTEGER,
    "graduation_100_percentile" INTEGER,
    "graduation_150_percentile" INTEGER,
    "median_sat_percentile" TEXT,
    "pell_recipient_percentile" INTEGER,
    "retention_percentile" INTEGER
);

CREATE TABLE "state_sector_counted_percentage" (
    "state_id" INTEGER,
    "institution_level" TEXT,
    "control_type" TEXT,
    "counted_percentage" TEXT
);

