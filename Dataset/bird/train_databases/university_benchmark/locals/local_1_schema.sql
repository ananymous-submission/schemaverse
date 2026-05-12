CREATE TABLE "AcademicInstitution" (
    "AcademicInstitutionId" INTEGER,
    "CountryReferenceId" INTEGER DEFAULT NULL,
    "OfficialName" TEXT DEFAULT NULL
);

CREATE TABLE "InstitutionYearlyStatistics" (
    "AcademicInstitutionId" INTEGER DEFAULT NULL,
    "AcademicYear" INTEGER DEFAULT NULL,
    "StudentCount" INTEGER DEFAULT NULL,
    "StudentToStaffRatio" REAL DEFAULT NULL,
    "InternationalStudentPercentage" INTEGER DEFAULT NULL,
    "FemaleStudentPercentage" INTEGER DEFAULT NULL
);