CREATE TABLE "districtDirectory" (
    "districtId" INTEGER,
    "districtFullName" TEXT,
    "contactEmail" TEXT,
    "contactFax" TEXT,
    "contactPhone" TEXT,
    "ttyNumber" TEXT,
    "twitterHandle" TEXT,
    "postalCode" INTEGER
);

CREATE TABLE "wardProfile" (
    "wardId" INTEGER,
    "populationCount" INTEGER,
    "aldermanNameSuffix" TEXT,
    "contactEmail" TEXT,
    "officeAddress" TEXT,
    "officeFax" TEXT,
    "officePhone" TEXT,
    "officePostalCode" TEXT
);