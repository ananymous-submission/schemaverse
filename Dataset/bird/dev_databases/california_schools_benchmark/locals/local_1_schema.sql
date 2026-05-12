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