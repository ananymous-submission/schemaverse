CREATE TABLE "InstitutionAidProfile" (
    "InstitutionId" INTEGER,
    "TotalAidAmount" INTEGER,
    "AwardsPerNationalAverage" REAL,
    "AwardsPerStateAverage" REAL,
    "AwardsPerInstitutionAverage" REAL,
    "BasicCategory" TEXT,
    "CarnegieClassification" INTEGER,
    "ChronicleName" TEXT,
    "CityName" TEXT,
    "CohortSize" INTEGER,
    "ControlType" TEXT,
    "EndowmentValue" TEXT,
    "ExpectedAwardsNational" INTEGER,
    "ExpectedAwardsState" INTEGER,
    "ExpectedAwardsInstitution" INTEGER,
    "FlagshipIndicator" TEXT,
    "FullTimeFacultyFte" REAL,
    "GraduationRateReference" REAL,
    "HistoricallyBlackCollegeIndicator" TEXT,
    "Latitude" REAL,
    "EducationLevel" TEXT,
    "Longitude" REAL,
    "MedianSatScore" TEXT,
    "NicknamesList" TEXT,
    "PellGrantRate" REAL,
    "RetentionRate" REAL,
    "SimilarInstitutions" TEXT,
    "WebsiteUrl" TEXT,
    "StateCode" TEXT,
    "StateSectorCount" INTEGER,
    "VsaYear" TEXT
);

CREATE TABLE "InstitutionVsaDetails" (
    "InstitutionId" INTEGER,
    "VsaEnrollmentAfterFourYearsFirstTime" TEXT,
    "VsaEnrollmentAfterFourYearsTransfer" TEXT,
    "VsaEnrollmentAfterSixYearsFirstTime" TEXT,
    "VsaEnrollmentAfterSixYearsTransfer" TEXT,
    "VsaEnrollmentElsewhereAfterFourYearsFirstTime" TEXT,
    "VsaEnrollmentElsewhereAfterFourYearsTransfer" TEXT,
    "VsaEnrollmentElsewhereAfterSixYearsFirstTime" TEXT,
    "VsaEnrollmentElsewhereAfterSixYearsTransfer" TEXT,
    "VsaGraduationAfterFourYearsFirstTime" TEXT,
    "VsaGraduationAfterFourYearsTransfer" TEXT,
    "VsaGraduationAfterSixYearsFirstTime" TEXT,
    "VsaGraduationAfterSixYearsTransfer" TEXT,
    "VsaGraduationElsewhereAfterFourYearsFirstTime" TEXT,
    "VsaGraduationElsewhereAfterFourYearsTransfer" TEXT,
    "VsaGraduationElsewhereAfterSixYearsFirstTime" TEXT,
    "VsaGraduationElsewhereAfterSixYearsTransfer" TEXT
);

CREATE TABLE "InstitutionGraduationRecords" (
    "InstitutionId" INTEGER,
    "GraduationYear" INTEGER,
    "Gender" TEXT,
    "RaceEthnicity" TEXT,
    "CohortIdentifier" TEXT,
    "GraduatedCohort" TEXT,
    "GraduationCountStandardTerm" TEXT,
    "GraduationCountExtendedTerm" TEXT,
    "GraduationRateStandardTerm" TEXT,
    "GraduationRateExtendedTerm" TEXT
);

CREATE TABLE "StateSectorProfile" (
    "StateSectorIdentifier" INTEGER,
    "SectorLevel" TEXT,
    "ControlCategory" TEXT,
    "StateCode" TEXT,
    "StatePostalCode" TEXT,
    FOREIGN KEY ("StateCode") REFERENCES "InstitutionAidProfile"("StateCode")
);