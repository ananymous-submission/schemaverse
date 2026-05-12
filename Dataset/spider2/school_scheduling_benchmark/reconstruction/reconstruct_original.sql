-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";

-- Reconstruct Buildings from local_1.bldg_meta
CREATE VIEW "Buildings" AS
SELECT
    "local_1"."bldg_meta"."bldg_cd" AS "BuildingCode",
    "local_1"."bldg_meta"."bldg_nm" AS "BuildingName",
    "local_1"."bldg_meta"."flr_cnt" AS "NumberOfFloors",
    "local_1"."bldg_meta"."elev_avail" AS "ElevatorAccess",
    "local_1"."bldg_meta"."prk_site_avail" AS "SiteParkingAvailable"
FROM "local_1"."bldg_meta";

-- Reconstruct Categories from local_1.cat_meta
CREATE VIEW "Categories" AS
SELECT
    "local_1"."cat_meta"."cat_id" AS "CategoryID",
    "local_1"."cat_meta"."cat_desc" AS "CategoryDescription",
    "local_1"."cat_meta"."dept_id" AS "DepartmentID"
FROM "local_1"."cat_meta";

-- Reconstruct Class_Rooms from row partitions (UNION (overlap))
CREATE VIEW "Class_Rooms" AS
SELECT "local_1"."cls_rm_phn_no"."cls_rm_id" AS "ClassRoomID", "local_1"."cls_rm_phn_no"."bldg_cd" AS "BuildingCode", "local_1"."cls_rm_phn_no"."phn_avail" AS "PhoneAvailable" FROM "local_1"."cls_rm_phn_no"
UNION
SELECT "local_1"."cls_rm_phn_opt"."cls_rm_id" AS "ClassRoomID", "local_1"."cls_rm_phn_opt"."bldg_cd" AS "BuildingCode", "local_1"."cls_rm_phn_opt"."phn_avail" AS "PhoneAvailable" FROM "local_1"."cls_rm_phn_opt";

-- Reconstruct Classes from vertical split + row partition on a fragment
CREATE VIEW "Classes" AS
SELECT t0.[ClassId], t0.[SubjectId], t0.[ClassroomId], t0.[CreditUnits], t1.[start_dt], t1.[start_tm], t0.[DurationMinutes], t2.[sched_mon], t1.[sched_tue], t1.[sched_wed], t2.[sched_thu], t2.[sched_fri], t2.[sched_sat]
FROM (
SELECT [ClassSectionDuration51To110].[__orig_rowid] AS __orig_rowid, [local_4].[ClassSectionDuration51To110].[ClassId], [local_4].[ClassSectionDuration51To110].[SubjectId], [local_4].[ClassSectionDuration51To110].[ClassroomId], [local_4].[ClassSectionDuration51To110].[CreditUnits], [local_4].[ClassSectionDuration51To110].[DurationMinutes] FROM [local_4].[ClassSectionDuration51To110]
UNION
SELECT [ClassSectionDurationAbove110OrNull].[__orig_rowid] AS __orig_rowid, [local_4].[ClassSectionDurationAbove110OrNull].[ClassId], [local_4].[ClassSectionDurationAbove110OrNull].[SubjectId], [local_4].[ClassSectionDurationAbove110OrNull].[ClassroomId], [local_4].[ClassSectionDurationAbove110OrNull].[CreditUnits], [local_4].[ClassSectionDurationAbove110OrNull].[DurationMinutes] FROM [local_4].[ClassSectionDurationAbove110OrNull]
UNION
SELECT [ClassSectionDurationUpTo50].[__orig_rowid] AS __orig_rowid, [local_4].[ClassSectionDurationUpTo50].[ClassId], [local_4].[ClassSectionDurationUpTo50].[SubjectId], [local_4].[ClassSectionDurationUpTo50].[ClassroomId], [local_4].[ClassSectionDurationUpTo50].[CreditUnits], [local_4].[ClassSectionDurationUpTo50].[DurationMinutes] FROM [local_4].[ClassSectionDurationUpTo50]
) t0
JOIN [local_1].[cls_credit] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[cls_sched_days] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct Departments from local_2.academicDepartments
CREATE VIEW "Departments" AS
SELECT
    "local_2"."academicDepartments"."departmentKey" AS "DepartmentID",
    "local_2"."academicDepartments"."departmentName" AS "DeptName",
    "local_2"."academicDepartments"."departmentChairStaffKey" AS "DeptChair"
FROM "local_2"."academicDepartments";

-- Reconstruct Faculty from local_2.facultyProfiles
CREATE VIEW "Faculty" AS
SELECT
    "local_2"."facultyProfiles"."staffKey" AS "StaffID",
    "local_2"."facultyProfiles"."jobTitle" AS "Title",
    "local_2"."facultyProfiles"."employmentStatus" AS "Status",
    "local_2"."facultyProfiles"."isTenured" AS "Tenured"
FROM "local_2"."facultyProfiles";

-- Reconstruct Faculty_Categories from local_3.staff_category_memberships
CREATE VIEW "Faculty_Categories" AS
SELECT
    "local_3"."staff_category_memberships"."staff_member_id" AS "StaffID",
    "local_3"."staff_category_memberships"."category_identifier" AS "CategoryID"
FROM "local_3"."staff_category_memberships";

-- Reconstruct Faculty_Classes from local_4.FacultyClassAssignment
CREATE VIEW "Faculty_Classes" AS
SELECT
    "local_4"."FacultyClassAssignment"."ClassId" AS "ClassID",
    "local_4"."FacultyClassAssignment"."StaffId" AS "StaffID"
FROM "local_4"."FacultyClassAssignment";

-- Reconstruct Faculty_Subjects from row partitions (UNION (overlap))
CREATE VIEW "Faculty_Subjects" AS
SELECT "local_2"."facultySubjectProficienciesEightToNine"."staffKeyRef" AS "StaffID", "local_2"."facultySubjectProficienciesEightToNine"."subjectKey" AS "SubjectID", "local_2"."facultySubjectProficienciesEightToNine"."proficiencyRatingEightToNine" AS "ProficiencyRating" FROM "local_2"."facultySubjectProficienciesEightToNine"
UNION
SELECT "local_5"."facultyProficiencyAtMostEight"."facultyMemberId" AS "StaffID", "local_5"."facultyProficiencyAtMostEight"."subjectCode" AS "SubjectID", "local_5"."facultyProficiencyAtMostEight"."proficiencyScore" AS "ProficiencyRating" FROM "local_5"."facultyProficiencyAtMostEight"
UNION
SELECT "local_5"."facultyProficiencyAboveNineOrUnspecified"."facultyMemberId" AS "StaffID", "local_5"."facultyProficiencyAboveNineOrUnspecified"."subjectCode" AS "SubjectID", "local_5"."facultyProficiencyAboveNineOrUnspecified"."proficiencyScore" AS "ProficiencyRating" FROM "local_5"."facultyProficiencyAboveNineOrUnspecified";

-- Reconstruct Majors from local_3.academic_programs
CREATE VIEW "Majors" AS
SELECT
    "local_3"."academic_programs"."program_id" AS "MajorID",
    "local_3"."academic_programs"."program_name" AS "Major"
FROM "local_3"."academic_programs";

-- Reconstruct Staff from vertical (column) split (3 fragments)
CREATE VIEW "Staff" AS
SELECT
    t0."StaffId" AS "StaffID",
    t0."FirstName" AS "StfFirstName",
    t0."LastName" AS "StfLastname",
    t1."streetAddress" AS "StfStreetAddress",
    t1."city" AS "StfCity",
    t1."state" AS "StfState",
    t2."postalCode" AS "StfZipCode",
    t2."phoneAreaCode" AS "StfAreaCode",
    t1."contactPhone" AS "StfPhoneNumber",
    t1."startingSalary" AS "Salary",
    t1."hireDate" AS "DateHired",
    t0."PositionTitle" AS "Position"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "StaffId" ORDER BY rowid) AS __rn FROM "local_4"."StaffMember") t0
JOIN "local_2"."staffHireRecords" t1 ON t0."StaffId" IS t1."staffKey" AND t0.__rn = t1.__rn
JOIN "local_2"."staffPayrollRecords" t2 ON t0."StaffId" IS t2."staffKey" AND t0.__rn = t2.__rn;

-- Reconstruct Student_Class_Status from local_4.EnrollmentStatus
CREATE VIEW "Student_Class_Status" AS
SELECT
    "local_4"."EnrollmentStatus"."StatusCode" AS "ClassStatus",
    "local_4"."EnrollmentStatus"."StatusDescription" AS "ClassStatusDescription"
FROM "local_4"."EnrollmentStatus";

-- Reconstruct Student_Schedules from local_4.StudentEnrollment
CREATE VIEW "Student_Schedules" AS
SELECT
    "local_4"."StudentEnrollment"."StudentId" AS "StudentID",
    "local_4"."StudentEnrollment"."ClassId" AS "ClassID",
    "local_4"."StudentEnrollment"."StatusCode" AS "ClassStatus",
    "local_4"."StudentEnrollment"."GradeValue" AS "Grade"
FROM "local_4"."StudentEnrollment";

-- Reconstruct Students from vertical (column) split (2 fragments)
CREATE VIEW "Students" AS
SELECT
    t0."studentRecordId" AS "StudentID",
    t0."givenName" AS "StudFirstName",
    t0."familyName" AS "StudLastName",
    t0."streetAddress" AS "StudStreetAddress",
    t0."homeCity" AS "StudCity",
    t0."homeState" AS "StudState",
    t1."postal_code" AS "StudZipCode",
    t1."study_area_code" AS "StudAreaCode",
    t1."phone_number" AS "StudPhoneNumber",
    t0."gradePointAverage" AS "StudGPA",
    t0."majorDepartmentId" AS "StudMajor"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "studentRecordId" ORDER BY rowid) AS __rn FROM "local_5"."studentProfiles") t0
JOIN "local_3"."student_profiles" t1 ON t0."studentRecordId" IS t1."student_id" AND t0.__rn = t1.__rn;

-- Reconstruct Subjects from local_1.subj_meta
CREATE VIEW "Subjects" AS
SELECT
    "local_1"."subj_meta"."subj_id" AS "SubjectID",
    "local_1"."subj_meta"."cat_id" AS "CategoryID",
    "local_1"."subj_meta"."subj_cd" AS "SubjectCode",
    "local_1"."subj_meta"."subj_nm" AS "SubjectName",
    "local_1"."subj_meta"."prereq_cd" AS "SubjectPreReq",
    "local_1"."subj_meta"."subj_desc" AS "SubjectDescription"
FROM "local_1"."subj_meta";
