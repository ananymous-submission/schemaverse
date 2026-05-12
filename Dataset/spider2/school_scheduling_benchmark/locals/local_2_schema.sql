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