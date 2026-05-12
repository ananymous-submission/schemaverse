-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct RA from local_2.research_assistant
CREATE VIEW "RA" AS
SELECT
    "local_2"."research_assistant"."student_identifier" AS "student_id",
    "local_2"."research_assistant"."competency_level" AS "capability",
    "local_2"."research_assistant"."faculty_id" AS "prof_id",
    "local_2"."research_assistant"."stipend_amount" AS "salary"
FROM "local_2"."research_assistant";

-- Reconstruct course from local_1.AcademicCourse
CREATE VIEW "course" AS
SELECT
    "local_1"."AcademicCourse"."CourseId" AS "course_id",
    "local_1"."AcademicCourse"."Title" AS "name",
    "local_1"."AcademicCourse"."CreditHours" AS "credit",
    "local_1"."AcademicCourse"."DifficultyRating" AS "diff"
FROM "local_1"."AcademicCourse";

-- Reconstruct prof from vertical (column) split (2 fragments)
CREATE VIEW "prof" AS
SELECT
    t0."faculty_id" AS "prof_id",
    t0."gender_identity" AS "gender",
    t1."given_name" AS "first_name",
    t1."family_name" AS "last_name",
    t0."contact_email" AS "email",
    t0."reputation_score" AS "popularity",
    t0."teaching_proficiency" AS "teachingability",
    t0."alma_mater" AS "graduate_from"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "faculty_id" ORDER BY rowid) AS __rn FROM "local_2"."faculty_contact") t0
JOIN "local_2"."faculty_profile" t1 ON t0."faculty_id" IS t1."faculty_id" AND t0.__rn = t1.__rn;

-- Reconstruct registration from row partitions (UNION (overlap))
CREATE VIEW "registration" AS
SELECT "local_1"."EnrollmentSatUpToTwo"."CourseId" AS "course_id", "local_1"."EnrollmentSatUpToTwo"."StudentId" AS "student_id", "local_1"."EnrollmentSatUpToTwo"."LetterGrade" AS "grade", "local_1"."EnrollmentSatUpToTwo"."SatScore" AS "sat" FROM "local_1"."EnrollmentSatUpToTwo"
UNION
SELECT "local_1"."EnrollmentSatAboveFourOrUnknown"."CourseId" AS "course_id", "local_1"."EnrollmentSatAboveFourOrUnknown"."StudentId" AS "student_id", "local_1"."EnrollmentSatAboveFourOrUnknown"."LetterGrade" AS "grade", "local_1"."EnrollmentSatAboveFourOrUnknown"."SatScore" AS "sat" FROM "local_1"."EnrollmentSatAboveFourOrUnknown"
UNION
SELECT "local_3"."reg_mid_sat"."crs_id" AS "course_id", "local_3"."reg_mid_sat"."stud_id" AS "student_id", "local_3"."reg_mid_sat"."grd" AS "grade", "local_3"."reg_mid_sat"."sat_mid" AS "sat" FROM "local_3"."reg_mid_sat";

-- Reconstruct student from local_3.stud_profile
CREATE VIEW "student" AS
SELECT
    "local_3"."stud_profile"."stud_id" AS "student_id",
    "local_3"."stud_profile"."fst_nm" AS "f_name",
    "local_3"."stud_profile"."lst_nm" AS "l_name",
    "local_3"."stud_profile"."ph_num" AS "phone_number",
    "local_3"."stud_profile"."eml" AS "email",
    "local_3"."stud_profile"."iq_sc" AS "intelligence",
    "local_3"."stud_profile"."gpa_val" AS "gpa",
    "local_3"."stud_profile"."stud_type" AS "type"
FROM "local_3"."stud_profile";
