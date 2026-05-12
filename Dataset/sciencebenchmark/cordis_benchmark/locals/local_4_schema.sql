CREATE TABLE "memberRoleCatalog" (
    "roleCode" TEXT,
    "roleDescription" TEXT
);

CREATE TABLE "projectProgramAssignments" (
    "projectId" INTEGER,
    "programmeCode" TEXT
);

CREATE TABLE "memberEcContributionRecords" (
    "unicsId" INTEGER,
    "ecContributionAmount" REAL,
    "memberRoleCode" TEXT,
    "projectId" INTEGER,
    "rcnIdentifier" TEXT
);

CREATE TABLE "memberInstitutionIdentifiers" (
    "unicsId" INTEGER,
    "institutionId" INTEGER,
    "picNumber" TEXT,
    "vatRegistrationNumber" TEXT
);

CREATE TABLE "memberActivityMajorEuropeanCities" (
    "unicsId" INTEGER,
    "activityType" TEXT,
    "cityName" TEXT,
    "countryName" TEXT,
    "geocodeRegionLevel3" TEXT,
    "latitudeValue" NUMERIC,
    "longitudeValue" NUMERIC,
    "postalCode" TEXT,
    "regionCode" TEXT,
    "regionName" TEXT,
    "streetAddress" TEXT
);

CREATE TABLE "memberActivityOtherCities" (
    "unicsId" INTEGER,
    "activityType" TEXT,
    "cityName" TEXT,
    "countryName" TEXT,
    "geocodeRegionLevel3" TEXT,
    "latitudeValue" NUMERIC,
    "longitudeValue" NUMERIC,
    "postalCode" TEXT,
    "regionCode" TEXT,
    "regionName" TEXT,
    "streetAddress" TEXT
);