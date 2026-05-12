CREATE TABLE "customersEducationLowerThird" (
    "customerId" INTEGER,
    "gender" TEXT,
    "maritalStatus" TEXT,
    "geographicId" INTEGER,
    "educationLevel" INTEGER,
    "jobTitle" TEXT,
    "ageYears" INTEGER
);

CREATE TABLE "customersEducationAboveSevenOrMissing" (
    "customerId" INTEGER,
    "gender" TEXT,
    "maritalStatus" TEXT,
    "geographicId" INTEGER,
    "educationLevel" INTEGER,
    "jobTitle" TEXT,
    "ageYears" INTEGER
);

CREATE TABLE "mailingsFeb2007Snapshot" (
    "mailingRefId" INTEGER,
    "mailingDate" DATETIME,
    "responseStatus" TEXT
);

CREATE TABLE "mailingsMar2007Snapshot" (
    "mailingRefId" INTEGER,
    "mailingDate" DATETIME,
    "responseStatus" TEXT
);

CREATE TABLE "salesAmountBetweenTwelvePointFiveAndFifteenPointZeroZeroOne" (
    "saleEventId" INTEGER,
    "mailingRefId" INTEGER,
    "transactionDate" DATETIME,
    "saleAmount" REAL
);

CREATE TABLE "salesAmountBetweenFifteenPointZeroZeroOneAndSeventeenPointFive" (
    "saleEventId" INTEGER,
    "mailingRefId" INTEGER,
    "transactionDate" DATETIME,
    "saleAmount" REAL
);