-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/cs_semester/cs_semester.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "AcademicCourse" (
    "CourseId" INTEGER,
    "Title" TEXT,
    "CreditHours" INTEGER,
    "DifficultyRating" INTEGER
);

CREATE TABLE "EnrollmentSatUpToTwo" (
    "CourseId" INTEGER,
    "StudentId" INTEGER,
    "LetterGrade" TEXT,
    "SatScore" INTEGER
);

CREATE TABLE "EnrollmentSatAboveFourOrUnknown" (
    "CourseId" INTEGER,
    "StudentId" INTEGER,
    "LetterGrade" TEXT,
    "SatScore" INTEGER,
    FOREIGN KEY ("CourseId") REFERENCES "AcademicCourse"("CourseId")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "research_assistant" (
    "student_identifier" INTEGER,
    "competency_level" INTEGER,
    "faculty_id" INTEGER,
    "stipend_amount" TEXT,
    FOREIGN KEY ("faculty_id") REFERENCES "faculty_contact"("faculty_id"),
    FOREIGN KEY ("faculty_id") REFERENCES "faculty_profile"("faculty_id")
);

CREATE TABLE "faculty_contact" (
    "faculty_id" INTEGER,
    "contact_email" TEXT,
    "gender_identity" TEXT,
    "alma_mater" TEXT,
    "reputation_score" INTEGER,
    "teaching_proficiency" INTEGER
);

CREATE TABLE "faculty_profile" (
    "faculty_id" INTEGER,
    "primary_email" TEXT,
    "given_name" TEXT,
    "gender_identity" TEXT,
    "alma_mater" TEXT,
    "family_name" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "stud_profile" (
    "stud_id" INTEGER,
    "fst_nm" TEXT,
    "lst_nm" TEXT,
    "ph_num" TEXT,
    "eml" TEXT,
    "iq_sc" INTEGER,
    "gpa_val" REAL,
    "stud_type" TEXT
);

CREATE TABLE "reg_mid_sat" (
    "crs_id" INTEGER,
    "stud_id" INTEGER,
    "grd" TEXT,
    "sat_mid" INTEGER
);

