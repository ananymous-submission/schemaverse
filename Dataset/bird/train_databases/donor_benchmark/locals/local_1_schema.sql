CREATE TABLE "projectMatchingEligibility" (
    "projectId" TEXT,
    "almostHomeMatchEligible" TEXT,
    "doubleYourImpactMatchEligible" TEXT,
    "studentsReached" INTEGER
);

CREATE TABLE "projectPostings" (
    "projectId" TEXT,
    "postingDate" DATE,
    "gradeLevel" TEXT,
    "povertyLevel" TEXT,
    "resourceType" TEXT,
    "schoolCharterIndicator" TEXT,
    "charterReadyPromise" TEXT,
    "schoolCity" TEXT,
    "schoolCounty" TEXT,
    "schoolDistrict" TEXT,
    "schoolKippIndicator" TEXT,
    "schoolLatitude" REAL,
    "schoolLongitude" REAL,
    "schoolMagnetProgram" TEXT,
    "schoolMetroIndicator" TEXT,
    "schoolNcesId" TEXT,
    "schoolNlns" TEXT,
    "schoolState" TEXT,
    "schoolYearRound" TEXT,
    "schoolZip" INTEGER,
    "teacherNyTeachingFellow" TEXT,
    "teacherTfaParticipant" TEXT
);

CREATE TABLE "projectPrimaryFocus" (
    "projectId" TEXT,
    "primaryFocusArea" TEXT,
    "primaryFocusSubject" TEXT,
    "resourceType" TEXT,
    "secondaryFocusArea" TEXT,
    "secondaryFocusSubject" TEXT
);

CREATE TABLE "projectSchoolCharterDetails" (
    "projectId" TEXT,
    "charterReadyPromise" TEXT,
    "schoolCity" TEXT,
    "schoolKippIndicator" TEXT,
    "schoolNcesId" TEXT,
    "schoolNlns" TEXT,
    "schoolState" TEXT,
    "schoolYearRound" TEXT,
    "schoolZip" INTEGER,
    "schoolId" TEXT,
    "teacherAccountId" TEXT,
    "teacherNyTeachingFellow" TEXT,
    "teacherPrefix" TEXT,
    "teacherTfaParticipant" TEXT
);

CREATE TABLE "resourceItemsPriceUpToSixPointTwoNine" (
    "resourceId" TEXT,
    "itemName" TEXT,
    "itemNumber" TEXT,
    "itemQuantity" INTEGER,
    "itemUnitPrice" REAL,
    "projectResourceType" TEXT,
    "vendorName" TEXT
);

CREATE TABLE "resourceItemsPriceOverSixPointTwoNineToThirteenPointNineEight" (
    "resourceId" TEXT,
    "itemName" TEXT,
    "itemNumber" TEXT,
    "itemQuantity" INTEGER,
    "itemUnitPrice" REAL,
    "projectResourceType" TEXT,
    "vendorName" TEXT
);

CREATE TABLE "resourceItemsPriceOverThirteenPointNineEightToThirtySix" (
    "resourceId" TEXT,
    "itemName" TEXT,
    "itemNumber" TEXT,
    "itemQuantity" INTEGER,
    "itemUnitPrice" REAL,
    "projectResourceType" TEXT,
    "vendorName" TEXT
);

CREATE TABLE "resourceItemsPriceOverThirtySixOrNull" (
    "resourceId" TEXT,
    "itemName" TEXT,
    "itemNumber" TEXT,
    "itemQuantity" INTEGER,
    "itemUnitPrice" REAL,
    "projectResourceType" TEXT,
    "vendorName" TEXT
);

CREATE TABLE "resourceItemsByIdentifier" (
    "resourceId" TEXT,
    "itemNumber" TEXT,
    "itemQuantity" INTEGER,
    "itemUnitPrice" REAL,
    "projectResourceType" TEXT,
    "projectId" TEXT,
    "vendorId" INTEGER,
    FOREIGN KEY ("projectId") REFERENCES "projectPostings"("projectId"),
    FOREIGN KEY ("projectId") REFERENCES "projectSchoolCharterDetails"("projectId")
);