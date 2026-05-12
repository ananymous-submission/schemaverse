-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct advisedBy from local_1.advisory_assignments
CREATE VIEW "advisedBy" AS
SELECT
    "local_1"."advisory_assignments"."advisee_person_id" AS "p_id",
    "local_1"."advisory_assignments"."assignment_id" AS "p_id_dummy"
FROM "local_1"."advisory_assignments";

-- Reconstruct course from row partitions (UNION (overlap))
CREATE VIEW "course" AS
SELECT "local_2"."CourseLevelFiveHundred"."CourseIdentifier" AS "course_id", "local_2"."CourseLevelFiveHundred"."AcademicLevel" AS "courseLevel" FROM "local_2"."CourseLevelFiveHundred"
UNION
SELECT "local_2"."CourseLevelThreeOrFourHundred"."CourseIdentifier" AS "course_id", "local_2"."CourseLevelThreeOrFourHundred"."AcademicLevel" AS "courseLevel" FROM "local_2"."CourseLevelThreeOrFourHundred";

-- Reconstruct person from row partitions (UNION (overlap))
CREATE VIEW "person" AS
SELECT "local_1"."people_year_zero"."person_id" AS "p_id", "local_1"."people_year_zero"."is_professor" AS "professor", "local_1"."people_year_zero"."is_student" AS "student", "local_1"."people_year_zero"."position_title" AS "hasPosition", "local_1"."people_year_zero"."program_phase" AS "inPhase", "local_1"."people_year_zero"."years_in_program" AS "yearsInProgram" FROM "local_1"."people_year_zero"
UNION
SELECT "local_1"."people_years_one_seven_twelve_or_other"."person_id" AS "p_id", "local_1"."people_years_one_seven_twelve_or_other"."is_professor" AS "professor", "local_1"."people_years_one_seven_twelve_or_other"."is_student" AS "student", "local_1"."people_years_one_seven_twelve_or_other"."position_title" AS "hasPosition", "local_1"."people_years_one_seven_twelve_or_other"."program_phase" AS "inPhase", "local_1"."people_years_one_seven_twelve_or_other"."years_in_program" AS "yearsInProgram" FROM "local_1"."people_years_one_seven_twelve_or_other"
UNION
SELECT "local_3"."peopleYearTwoFiveSix"."personId" AS "p_id", "local_3"."peopleYearTwoFiveSix"."isProfessor" AS "professor", "local_3"."peopleYearTwoFiveSix"."isStudent" AS "student", "local_3"."peopleYearTwoFiveSix"."positionTitle" AS "hasPosition", "local_3"."peopleYearTwoFiveSix"."programPhase" AS "inPhase", "local_3"."peopleYearTwoFiveSix"."programYear" AS "yearsInProgram" FROM "local_3"."peopleYearTwoFiveSix"
UNION
SELECT "local_3"."peopleYearThreeFour"."personId" AS "p_id", "local_3"."peopleYearThreeFour"."isProfessor" AS "professor", "local_3"."peopleYearThreeFour"."isStudent" AS "student", "local_3"."peopleYearThreeFour"."positionTitle" AS "hasPosition", "local_3"."peopleYearThreeFour"."programPhase" AS "inPhase", "local_3"."peopleYearThreeFour"."programYear" AS "yearsInProgram" FROM "local_3"."peopleYearThreeFour";

-- Reconstruct taughtBy from local_3.courseTeachingAssignments
CREATE VIEW "taughtBy" AS
SELECT
    "local_3"."courseTeachingAssignments"."courseId" AS "course_id",
    "local_3"."courseTeachingAssignments"."personId" AS "p_id"
FROM "local_3"."courseTeachingAssignments";
