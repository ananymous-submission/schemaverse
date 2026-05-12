CREATE TABLE "fundCenterHierarchyStructure" (
    "fundCenterKey" TEXT DEFAULT NULL,
    "fundCenterCode" TEXT DEFAULT NULL,
    "fundCenterName" TEXT DEFAULT NULL,
    "fundCenterLevelOneCode" TEXT DEFAULT NULL,
    "fundCenterLevelOneName" TEXT DEFAULT NULL,
    "fundCenterLevelTwoCode" TEXT DEFAULT NULL,
    "fundCenterLevelTwoName" TEXT DEFAULT NULL,
    "fundCenterLevelThreeCode" TEXT DEFAULT NULL,
    "fundCenterLevelThreeName" TEXT DEFAULT NULL,
    "fundCenterLevelFourCode" TEXT DEFAULT NULL,
    "fundCenterLevelFourName" TEXT DEFAULT NULL,
    "fundCenterLevelFiveCode" TEXT DEFAULT NULL,
    "fundCenterLevelFiveName" TEXT DEFAULT NULL,
    "fundCenterLevelSixCode" TEXT DEFAULT NULL,
    "fundCenterLevelSixName" TEXT DEFAULT NULL,
    "fundCenterLevelSevenCode" TEXT DEFAULT NULL,
    "fundCenterLevelSevenName" TEXT DEFAULT NULL,
    "fundCenterLevelEightCode" TEXT DEFAULT NULL,
    "fundCenterLevelEightName" TEXT DEFAULT NULL,
    "fundCenterLevelNineCode" TEXT DEFAULT NULL,
    "fundCenterLevelNineName" TEXT DEFAULT NULL,
    "fundCenterLevelTenCode" TEXT DEFAULT NULL,
    "fundCenterLevelTenName" TEXT DEFAULT NULL,
    "warehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "iapSubjectDetails" (
    "iapSubjectCategoryId" TEXT DEFAULT NULL,
    "iapSubjectSponsorId" TEXT DEFAULT NULL,
    "iapSubjectSessionId" TEXT DEFAULT NULL,
    "iapSubjectPersonId" TEXT DEFAULT NULL,
    "activityTitle" TEXT DEFAULT NULL,
    "activityDescription" TEXT DEFAULT NULL,
    "termCode" TEXT DEFAULT NULL,
    "enrollmentType" TEXT DEFAULT NULL,
    "maxEnrollment" INTEGER DEFAULT NULL,
    "attendance" TEXT DEFAULT NULL,
    "prerequisites" TEXT DEFAULT NULL,
    "feeAmount" INTEGER DEFAULT NULL,
    "feeReason" TEXT DEFAULT NULL,
    "preregistrationDeadline" TEXT DEFAULT NULL,
    "createdDate" TEXT DEFAULT NULL,
    "lastActivityDate" TEXT DEFAULT NULL,
    "multipleSessionFlag" TEXT DEFAULT NULL,
    "cancelledFlag" TEXT DEFAULT NULL,
    "warehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "studentEthnicSubgroupCode50" (
    "studentEthnicSubgroupId" TEXT DEFAULT NULL,
    "ethnicGroupName" TEXT DEFAULT NULL,
    "ethnicSubgroupName" TEXT DEFAULT NULL,
    "ethnicCode" TEXT DEFAULT NULL,
    "ethnicSubgroupCode" TEXT DEFAULT NULL,
    "warehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "studentEthnicSubgroupCode20" (
    "studentEthnicSubgroupId" TEXT DEFAULT NULL,
    "ethnicGroupName" TEXT DEFAULT NULL,
    "ethnicSubgroupName" TEXT DEFAULT NULL,
    "ethnicCode" TEXT DEFAULT NULL,
    "ethnicSubgroupCode" TEXT DEFAULT NULL,
    "warehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "studentEthnicSubgroupCode40" (
    "studentEthnicSubgroupId" TEXT DEFAULT NULL,
    "ethnicGroupName" TEXT DEFAULT NULL,
    "ethnicSubgroupName" TEXT DEFAULT NULL,
    "ethnicCode" TEXT DEFAULT NULL,
    "ethnicSubgroupCode" TEXT DEFAULT NULL,
    "warehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "studentEthnicSubgroupCode10And60" (
    "studentEthnicSubgroupId" TEXT DEFAULT NULL,
    "ethnicGroupName" TEXT DEFAULT NULL,
    "ethnicSubgroupName" TEXT DEFAULT NULL,
    "ethnicCode" TEXT DEFAULT NULL,
    "ethnicSubgroupCode" TEXT DEFAULT NULL,
    "warehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "studentEthnicSubgroupCode30" (
    "studentEthnicSubgroupId" TEXT DEFAULT NULL,
    "ethnicGroupName" TEXT DEFAULT NULL,
    "ethnicSubgroupName" TEXT DEFAULT NULL,
    "ethnicCode" TEXT DEFAULT NULL,
    "ethnicSubgroupCode" TEXT DEFAULT NULL,
    "warehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "studentEthnicSubgroupOtherBucket" (
    "studentEthnicSubgroupId" TEXT DEFAULT NULL,
    "ethnicGroupName" TEXT DEFAULT NULL,
    "ethnicSubgroupName" TEXT DEFAULT NULL,
    "ethnicCode" TEXT DEFAULT NULL,
    "ethnicSubgroupCode" TEXT DEFAULT NULL,
    "warehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "iapSponsorAdministrativeDepartment" (
    "iapSubjectSponsorId" TEXT DEFAULT NULL,
    "sponsorName" TEXT DEFAULT NULL,
    "sponsorType" TEXT DEFAULT NULL,
    "warehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "iapSponsorStudentGroup" (
    "iapSubjectSponsorId" TEXT DEFAULT NULL,
    "sponsorName" TEXT DEFAULT NULL,
    "sponsorType" TEXT DEFAULT NULL,
    "warehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "academicTermsSeventies" (
    "academicTermId" TEXT DEFAULT NULL,
    "academicYear" TEXT DEFAULT NULL,
    "academicYearDescription" TEXT DEFAULT NULL,
    "degreeYear" TEXT DEFAULT NULL,
    "financialAidYear" TEXT DEFAULT NULL,
    "termDescription" TEXT DEFAULT NULL
);

CREATE TABLE "academicTermsOtherYears" (
    "academicTermId" TEXT DEFAULT NULL,
    "academicYear" TEXT DEFAULT NULL,
    "academicYearDescription" TEXT DEFAULT NULL,
    "degreeYear" TEXT DEFAULT NULL,
    "financialAidYear" TEXT DEFAULT NULL,
    "termDescription" TEXT DEFAULT NULL
);