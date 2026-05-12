-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/school_scheduling/school_scheduling.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "bldg_meta" (
    "bldg_cd" TEXT,
    "bldg_nm" TEXT,
    "flr_cnt" INTEGER,
    "elev_avail" BOOLEAN NOT NULL DEFAULT 0,
    "prk_site_avail" BOOLEAN NOT NULL DEFAULT 0
);

CREATE TABLE "cat_meta" (
    "cat_id" TEXT,
    "cat_desc" TEXT,
    "dept_id" INTEGER DEFAULT 0
);

CREATE TABLE "cls_rm_phn_no" (
    "cls_rm_id" INTEGER,
    "bldg_cd" TEXT,
    "phn_avail" BOOLEAN NOT NULL DEFAULT 0
);

CREATE TABLE "cls_rm_phn_opt" (
    "cls_rm_id" INTEGER,
    "bldg_cd" TEXT,
    "phn_avail" BOOLEAN NOT NULL DEFAULT 0,
    FOREIGN KEY ("bldg_cd") REFERENCES "bldg_meta"("bldg_cd")
);

CREATE TABLE "cls_credit" (
    "cls_id" INTEGER,
    "cred_cnt" INTEGER DEFAULT 0,
    "dur_len" INTEGER DEFAULT 0,
    "start_dt" DATE,
    "start_tm" TIME,
    "sched_tue" BOOLEAN NOT NULL DEFAULT 0,
    "sched_wed" BOOLEAN NOT NULL DEFAULT 0
);

CREATE TABLE "cls_sched_days" (
    "cls_id" INTEGER,
    "sched_fri" BOOLEAN NOT NULL DEFAULT 0,
    "sched_mon" BOOLEAN NOT NULL DEFAULT 0,
    "sched_sat" BOOLEAN NOT NULL DEFAULT 0,
    "start_dt" DATE,
    "sched_thu" BOOLEAN NOT NULL DEFAULT 0,
    "sched_tue" BOOLEAN NOT NULL DEFAULT 0,
    "sched_wed" BOOLEAN NOT NULL DEFAULT 0
);

CREATE TABLE "subj_meta" (
    "subj_id" INTEGER,
    "cat_id" TEXT,
    "subj_cd" TEXT,
    "subj_nm" TEXT,
    "prereq_cd" TEXT DEFAULT NULL,
    "subj_desc" TEXT,
    FOREIGN KEY ("prereq_cd") REFERENCES "subj_meta"("subj_cd"),
    FOREIGN KEY ("cat_id") REFERENCES "cat_meta"("cat_id")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "academicDepartments" (
    "departmentKey" INTEGER,
    "departmentName" TEXT,
    "departmentChairStaffKey" INTEGER DEFAULT 0,
    FOREIGN KEY ("departmentChairStaffKey") REFERENCES "staffPayrollRecords"("staffKey")
);

CREATE TABLE "facultyProfiles" (
    "staffKey" INTEGER DEFAULT 0,
    "jobTitle" TEXT,
    "employmentStatus" TEXT,
    "isTenured" BOOLEAN NOT NULL DEFAULT 0
);

CREATE TABLE "staffHireRecords" (
    "staffKey" INTEGER,
    "hireDate" DATE,
    "positionTitle" TEXT,
    "startingSalary" REAL,
    "city" TEXT,
    "contactPhone" TEXT,
    "state" TEXT,
    "streetAddress" TEXT
);

CREATE TABLE "staffPayrollRecords" (
    "staffKey" INTEGER,
    "currentSalary" REAL,
    "phoneAreaCode" TEXT,
    "contactPhone" TEXT,
    "state" TEXT,
    "streetAddress" TEXT,
    "postalCode" TEXT
);

CREATE TABLE "facultySubjectProficienciesEightToNine" (
    "staffKeyRef" INTEGER DEFAULT 0,
    "subjectKey" INTEGER DEFAULT 0,
    "proficiencyRatingEightToNine" REAL DEFAULT 0
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "staff_category_memberships" (
    "staff_member_id" INTEGER,
    "category_identifier" TEXT DEFAULT 'ACC'
);

CREATE TABLE "academic_programs" (
    "program_id" INTEGER,
    "program_name" TEXT
);

CREATE TABLE "student_profiles" (
    "student_id" INTEGER,
    "study_area_code" TEXT,
    "name" TEXT,
    "last_name" TEXT,
    "phone_number" TEXT,
    "state_code" TEXT,
    "street_address" TEXT,
    "postal_code" TEXT
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "FacultyClassAssignment" (
    "ClassId" INTEGER,
    "StaffId" INTEGER,
    FOREIGN KEY ("ClassId") REFERENCES "ClassSectionDuration51To110"("ClassId"),
    FOREIGN KEY ("ClassId") REFERENCES "ClassSectionDurationAbove110OrNull"("ClassId")
);

CREATE TABLE "EnrollmentStatus" (
    "StatusCode" INTEGER,
    "StatusDescription" TEXT
);

CREATE TABLE "StudentEnrollment" (
    "StudentId" INTEGER,
    "ClassId" INTEGER,
    "StatusCode" INTEGER DEFAULT 0,
    "GradeValue" REAL DEFAULT 0
);

CREATE TABLE "ClassSectionDurationUpTo50" (
    "ClassId" INTEGER,
    "ClassroomId" INTEGER DEFAULT 0,
    "CreditUnits" INTEGER DEFAULT 0,
    "DurationMinutes" INTEGER DEFAULT 0,
    "SubjectId" INTEGER DEFAULT 0
);

CREATE TABLE "ClassSectionDuration51To110" (
    "ClassId" INTEGER,
    "ClassroomId" INTEGER DEFAULT 0,
    "CreditUnits" INTEGER DEFAULT 0,
    "DurationMinutes" INTEGER DEFAULT 0,
    "SubjectId" INTEGER DEFAULT 0
);

CREATE TABLE "ClassSectionDurationAbove110OrNull" (
    "ClassId" INTEGER,
    "ClassroomId" INTEGER DEFAULT 0,
    "CreditUnits" INTEGER DEFAULT 0,
    "DurationMinutes" INTEGER DEFAULT 0,
    "SubjectId" INTEGER DEFAULT 0
);

CREATE TABLE "StaffMember" (
    "StaffId" INTEGER,
    "PositionTitle" TEXT,
    "FirstName" TEXT,
    "LastName" TEXT
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "facultyProficiencyAtMostEight" (
    "facultyMemberId" INTEGER DEFAULT 0,
    "subjectCode" INTEGER DEFAULT 0,
    "proficiencyScore" REAL DEFAULT 0
);

CREATE TABLE "facultyProficiencyAboveNineOrUnspecified" (
    "facultyMemberId" INTEGER DEFAULT 0,
    "subjectCode" INTEGER DEFAULT 0,
    "proficiencyScore" REAL DEFAULT 0
);

CREATE TABLE "studentProfiles" (
    "studentRecordId" INTEGER,
    "homeCity" TEXT,
    "givenName" TEXT,
    "gradePointAverage" REAL DEFAULT 0,
    "familyName" TEXT,
    "majorDepartmentId" INTEGER,
    "homeState" TEXT,
    "streetAddress" TEXT
);

