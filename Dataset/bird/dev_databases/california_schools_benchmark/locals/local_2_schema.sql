CREATE TABLE "frpmCalpadsFallCert2013to2014" (
    "cdsUniqueId" TEXT,
    "calpadsFallCertificationStatus2013to2014" INTEGER,
    "academicYearLabel" TEXT,
    "countyCode" TEXT,
    "countyName" TEXT,
    "districtId" INTEGER,
    "districtLabel" TEXT,
    "districtCategory" TEXT,
    "educationOptionCategory" TEXT,
    "enrollmentK12" REAL,
    "instructionResourceCode" INTEGER,
    "nslpProvisionClassification" TEXT,
    "schoolId" TEXT,
    "schoolLabel" TEXT,
    "schoolCategory" TEXT
);

CREATE TABLE "frpmDistrictClassification" (
    "cdsUniqueId" TEXT,
    "districtCategory" TEXT,
    "educationOptionCategory" TEXT,
    "highestGradeServed" TEXT,
    "lowestGradeServed" TEXT,
    "schoolCategory" TEXT
);

CREATE TABLE "schoolAddressCity" (
    "cdsUniqueId" TEXT,
    "cityName" TEXT,
    "phoneExtension" TEXT,
    "fundingModel" TEXT,
    "latitudeDecimal" REAL,
    "longitudeDecimal" REAL,
    "magnetProgramFlag" INTEGER,
    "mailingCity" TEXT,
    "mailingState" TEXT,
    "mailingStreetAbbrev" TEXT,
    "mailingStreet" TEXT,
    "mailingZipCode" TEXT,
    "operationalStatus" TEXT NOT NULL,
    "streetName" TEXT,
    "streetAbbrev" TEXT,
    "virtualInstructionModel" TEXT,
    "websiteUrl" TEXT,
    "zipCode" TEXT
);

CREATE TABLE "schoolAttributesCounty" (
    "cdsUniqueId" TEXT,
    "countyName" TEXT NOT NULL,
    "docCode" TEXT NOT NULL,
    "docTypeCode" TEXT NOT NULL,
    "districtLabel" TEXT NOT NULL,
    "eilProgramCode" TEXT,
    "educationalOperationsCode" TEXT,
    "mailingState" TEXT,
    "ncesDistrictId" TEXT,
    "ncesSchoolId" TEXT,
    "stateOrganizationCode" TEXT,
    "schoolLabel" TEXT,
    "stateCode" TEXT
);