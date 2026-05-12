CREATE TABLE "employeesEmptyMiddleInitial" (
    "employeeId" TEXT,
    "firstName" TEXT NOT NULL,
    "hireDate" DATETIME NOT NULL,
    "jobLevel" INTEGER,
    "lastName" TEXT NOT NULL,
    "middleInitial" TEXT
);

CREATE TABLE "employeesMiddleInitialAorHorJ" (
    "employeeId" TEXT,
    "firstName" TEXT NOT NULL,
    "hireDate" DATETIME NOT NULL,
    "jobLevel" INTEGER,
    "lastName" TEXT NOT NULL,
    "middleInitial" TEXT
);

CREATE TABLE "employeesMiddleInitialFOrP" (
    "employeeId" TEXT,
    "firstName" TEXT NOT NULL,
    "hireDate" DATETIME NOT NULL,
    "jobLevel" INTEGER,
    "lastName" TEXT NOT NULL,
    "middleInitial" TEXT
);

CREATE TABLE "employeesMiddleInitialMorBorG" (
    "employeeId" TEXT,
    "firstName" TEXT NOT NULL,
    "hireDate" DATETIME NOT NULL,
    "jobLevel" INTEGER,
    "lastName" TEXT NOT NULL,
    "middleInitial" TEXT
);

CREATE TABLE "employeesMiddleInitialOther" (
    "employeeId" TEXT,
    "firstName" TEXT NOT NULL,
    "hireDate" DATETIME NOT NULL,
    "jobLevel" INTEGER,
    "lastName" TEXT NOT NULL,
    "middleInitial" TEXT
);

CREATE TABLE "employeeHireRecords" (
    "employeeId" TEXT,
    "hireDate" DATETIME NOT NULL,
    "jobId" INTEGER NOT NULL,
    "jobLevel" INTEGER,
    "middleInitial" TEXT,
    "publisherId" TEXT NOT NULL
);

CREATE TABLE "jobRoles" (
    "jobId" INTEGER,
    "jobDescription" TEXT NOT NULL,
    "minLevel" INTEGER NOT NULL,
    "maxLevel" INTEGER NOT NULL
);

CREATE TABLE "publisherAssets" (
    "publisherId" TEXT,
    "logoImage" BLOB,
    "publicityInfo" TEXT,
    FOREIGN KEY ("publisherId") REFERENCES "publisherDirectory"("publisherId")
);

CREATE TABLE "publisherDirectory" (
    "publisherId" TEXT,
    "publisherName" TEXT,
    "headquartersCity" TEXT,
    "headquartersState" TEXT,
    "headquartersCountry" TEXT
);

CREATE TABLE "royaltySchedules" (
    "titleId" TEXT NOT NULL,
    "lowRange" INTEGER,
    "highRange" INTEGER,
    "royaltyRate" INTEGER
);

CREATE TABLE "bookAdvanceDetails" (
    "titleId" TEXT,
    "advanceAmount" REAL,
    "listPrice" REAL,
    "publisherId" TEXT,
    "publicationDate" DATETIME NOT NULL,
    "royaltyRate" INTEGER,
    "titleName" TEXT NOT NULL,
    "yearToDateSales" INTEGER
);