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