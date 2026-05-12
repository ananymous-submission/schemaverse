-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/computer_student/computer_student.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "advisory_assignments" (
    "advisee_person_id" INTEGER,
    "assignment_id" INTEGER,
    FOREIGN KEY ("advisee_person_id") REFERENCES "people_years_one_seven_twelve_or_other"("person_id")
);

CREATE TABLE "people_year_zero" (
    "person_id" INTEGER,
    "is_professor" INTEGER,
    "is_student" INTEGER,
    "position_title" TEXT,
    "program_phase" TEXT,
    "years_in_program" TEXT
);

CREATE TABLE "people_years_one_seven_twelve_or_other" (
    "person_id" INTEGER,
    "is_professor" INTEGER,
    "is_student" INTEGER,
    "position_title" TEXT,
    "program_phase" TEXT,
    "years_in_program" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "CourseLevelFiveHundred" (
    "CourseIdentifier" INTEGER,
    "AcademicLevel" TEXT
);

CREATE TABLE "CourseLevelThreeOrFourHundred" (
    "CourseIdentifier" INTEGER,
    "AcademicLevel" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "courseTeachingAssignments" (
    "courseId" INTEGER,
    "personId" INTEGER,
    FOREIGN KEY ("personId") REFERENCES "peopleYearTwoFiveSix"("personId")
);

CREATE TABLE "peopleYearTwoFiveSix" (
    "personId" INTEGER,
    "isProfessor" INTEGER,
    "isStudent" INTEGER,
    "positionTitle" TEXT,
    "programPhase" TEXT,
    "programYear" TEXT
);

CREATE TABLE "peopleYearThreeFour" (
    "personId" INTEGER,
    "isProfessor" INTEGER,
    "isStudent" INTEGER,
    "positionTitle" TEXT,
    "programPhase" TEXT,
    "programYear" TEXT
);

