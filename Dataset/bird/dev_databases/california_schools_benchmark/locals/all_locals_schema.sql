-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/dev_databases/california_schools/california_schools.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "CharterSchoolDirectory" (
    "SchoolCdsCode" TEXT,
    "IsCharter" INTEGER,
    "CharterNumber" TEXT,
    "CityName" TEXT,
    "CountyName" TEXT NOT NULL,
    "DocCode" TEXT NOT NULL,
    "DocType" TEXT NOT NULL,
    "DistrictName" TEXT NOT NULL,
    "EilCode" TEXT,
    "EilName" TEXT,
    "EdOpsAreaCode" TEXT,
    "EdOpsAreaName" TEXT,
    "PhoneExtension" TEXT,
    "FundingTypeCategory" TEXT,
    "GsOfferStatus" TEXT,
    "GsServedCount" TEXT,
    "GeoLatitude" REAL,
    "GeoLongitude" REAL,
    "IsMagnetSchool" INTEGER,
    "PhoneNumber" TEXT,
    "SocCode" TEXT,
    "SocType" TEXT,
    "SchoolDisplayName" TEXT,
    "StateCode" TEXT,
    "OperationalStatus" TEXT NOT NULL,
    "IsVirtualSchool" TEXT,
    "WebsiteUrl" TEXT,
    "ZipCode" TEXT
);

CREATE TABLE "SchoolsLastUpdateUpTo20091002" (
    "SchoolCdsCode" TEXT,
    "SchoolClosedDate" DATE,
    "LastUpdatedDate" DATE NOT NULL,
    "SchoolOpenDate" DATE
);

CREATE TABLE "SchoolsLastUpdateAfter20091002To20150618" (
    "SchoolCdsCode" TEXT,
    "SchoolClosedDate" DATE,
    "LastUpdatedDate" DATE NOT NULL,
    "SchoolOpenDate" DATE
);

CREATE TABLE "SchoolsLastUpdateAfter20150618To20160303" (
    "SchoolCdsCode" TEXT,
    "SchoolClosedDate" DATE,
    "LastUpdatedDate" DATE NOT NULL,
    "SchoolOpenDate" DATE
);

CREATE TABLE "SchoolsLastUpdateAfter20160303OrNull" (
    "SchoolCdsCode" TEXT,
    "SchoolClosedDate" DATE,
    "LastUpdatedDate" DATE NOT NULL,
    "SchoolOpenDate" DATE
);

CREATE TABLE "SatAverageScores" (
    "SchoolCdsCode" TEXT,
    "AverageSatMath" INTEGER,
    "AverageSatReading" INTEGER,
    "AverageSatWriting" INTEGER,
    FOREIGN KEY ("SchoolCdsCode") REFERENCES "SchoolsLastUpdateAfter20091002To20150618"("SchoolCdsCode"),
    FOREIGN KEY ("SchoolCdsCode") REFERENCES "SchoolsLastUpdateAfter20150618To20160303"("SchoolCdsCode"),
    FOREIGN KEY ("SchoolCdsCode") REFERENCES "SchoolsLastUpdateAfter20160303OrNull"("SchoolCdsCode")
);

CREATE TABLE "CalpadsFall2013To2014Certification" (
    "SchoolCdsCode" TEXT,
    "CalpadsFall2013To2014CertificationStatus" INTEGER,
    "AcademicYear" TEXT,
    "CharterFundingType" TEXT,
    "IsCharterSchool" INTEGER,
    "CharterSchoolNumber" TEXT,
    "CountyCode" TEXT,
    "CountyName" TEXT,
    "IrcIndicator" INTEGER,
    "NslpProvisionStatus" TEXT,
    "SchoolCode" TEXT,
    "SchoolNameDisplay" TEXT,
    FOREIGN KEY ("SchoolCdsCode") REFERENCES "SchoolsLastUpdateUpTo20091002"("SchoolCdsCode"),
    FOREIGN KEY ("SchoolCdsCode") REFERENCES "SchoolsLastUpdateAfter20150618To20160303"("SchoolCdsCode")
);

CREATE TABLE "EnrollmentAges5To17" (
    "SchoolCdsCode" TEXT,
    "EnrollmentAges5To17" REAL,
    "FrpmCountAges5To17" REAL,
    "FreeMealCountAges5To17" REAL,
    "PercentEligibleFrpmAges5To17" REAL,
    "PercentEligibleFreeAges5To17" REAL,
    FOREIGN KEY ("SchoolCdsCode") REFERENCES "CharterSchoolDirectory"("SchoolCdsCode"),
    FOREIGN KEY ("SchoolCdsCode") REFERENCES "SchoolsLastUpdateUpTo20091002"("SchoolCdsCode"),
    FOREIGN KEY ("SchoolCdsCode") REFERENCES "SchoolsLastUpdateAfter20091002To20150618"("SchoolCdsCode"),
    FOREIGN KEY ("SchoolCdsCode") REFERENCES "SchoolsLastUpdateAfter20160303OrNull"("SchoolCdsCode")
);

CREATE TABLE "EnrollmentK12UpTo303" (
    "SchoolCdsCode" TEXT,
    "EnrollmentK12" REAL,
    "FrpmCountK12" REAL,
    "FreeMealCountK12" REAL,
    "PercentEligibleFrpmK12" REAL,
    "PercentEligibleFreeK12" REAL,
    FOREIGN KEY ("SchoolCdsCode") REFERENCES "CharterSchoolDirectory"("SchoolCdsCode"),
    FOREIGN KEY ("SchoolCdsCode") REFERENCES "SchoolsLastUpdateAfter20150618To20160303"("SchoolCdsCode")
);

CREATE TABLE "EnrollmentK12Over303UpTo528" (
    "SchoolCdsCode" TEXT,
    "EnrollmentK12" REAL,
    "FrpmCountK12" REAL,
    "FreeMealCountK12" REAL,
    "PercentEligibleFrpmK12" REAL,
    "PercentEligibleFreeK12" REAL,
    FOREIGN KEY ("SchoolCdsCode") REFERENCES "SchoolsLastUpdateUpTo20091002"("SchoolCdsCode"),
    FOREIGN KEY ("SchoolCdsCode") REFERENCES "SchoolsLastUpdateAfter20091002To20150618"("SchoolCdsCode"),
    FOREIGN KEY ("SchoolCdsCode") REFERENCES "SchoolsLastUpdateAfter20150618To20160303"("SchoolCdsCode")
);

CREATE TABLE "EnrollmentK12Over528UpTo758" (
    "SchoolCdsCode" TEXT,
    "EnrollmentK12" REAL,
    "FrpmCountK12" REAL,
    "FreeMealCountK12" REAL,
    "PercentEligibleFrpmK12" REAL,
    "PercentEligibleFreeK12" REAL,
    FOREIGN KEY ("SchoolCdsCode") REFERENCES "SchoolsLastUpdateAfter20091002To20150618"("SchoolCdsCode")
);

CREATE TABLE "EnrollmentK12Over758OrNull" (
    "SchoolCdsCode" TEXT,
    "EnrollmentK12" REAL,
    "FrpmCountK12" REAL,
    "FreeMealCountK12" REAL,
    "PercentEligibleFrpmK12" REAL,
    "PercentEligibleFreeK12" REAL,
    FOREIGN KEY ("SchoolCdsCode") REFERENCES "SchoolsLastUpdateUpTo20091002"("SchoolCdsCode"),
    FOREIGN KEY ("SchoolCdsCode") REFERENCES "SchoolsLastUpdateAfter20091002To20150618"("SchoolCdsCode"),
    FOREIGN KEY ("SchoolCdsCode") REFERENCES "SchoolsLastUpdateAfter20150618To20160303"("SchoolCdsCode"),
    FOREIGN KEY ("SchoolCdsCode") REFERENCES "SchoolsLastUpdateAfter20160303OrNull"("SchoolCdsCode")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "sat_scores_over_1500_by_school" (
    "school_cds_code" TEXT,
    "students_with_sat_ge_1500" INTEGER,
    "total_test_takers" INTEGER NOT NULL,
    "county_name" TEXT,
    "enrollment_grade_12" INTEGER NOT NULL,
    "report_type" TEXT NOT NULL,
    FOREIGN KEY ("school_cds_code") REFERENCES "school_administration_contacts"("school_cds_code")
);

CREATE TABLE "sat_scores_over_1500_district_view" (
    "school_cds_code" TEXT,
    "students_with_sat_ge_1500" INTEGER,
    "county_name" TEXT,
    "district_name" TEXT,
    "enrollment_grade_12" INTEGER NOT NULL,
    "report_type" TEXT NOT NULL,
    "school_name" TEXT
);

CREATE TABLE "school_administration_contacts" (
    "school_cds_code" TEXT,
    "admin_primary_email" TEXT,
    "admin_secondary_email" TEXT,
    "admin_tertiary_email" TEXT,
    "admin_primary_name" TEXT,
    "admin_secondary_name" TEXT,
    "admin_tertiary_name" TEXT,
    "admin_primary_last_name" TEXT,
    "admin_secondary_last_name" TEXT,
    "admin_tertiary_last_name" TEXT
);

