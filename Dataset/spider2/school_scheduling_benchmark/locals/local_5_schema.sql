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