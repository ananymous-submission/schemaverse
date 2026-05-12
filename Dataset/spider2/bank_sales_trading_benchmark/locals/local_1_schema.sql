CREATE TABLE "cryptoAccountMembers" (
    "memberId" TEXT,
    "givenName" TEXT,
    "homeRegion" TEXT
);

CREATE TABLE "weeklySalesByAgeBand" (
    "weekStartDate" TEXT,
    "totalSales" INTEGER,
    "ageBand" TEXT,
    "customerSegment" TEXT
);

CREATE TABLE "weeklySalesAvgTransactionByRegion" (
    "weekStartDate" TEXT,
    "totalSales" INTEGER,
    "avgTransactionValue" REAL,
    "calendarYear" INTEGER,
    "monthNumber" INTEGER,
    "regionCode" TEXT,
    "transactionCount" INTEGER
);

CREATE TABLE "weeklySalesAvgTransactionByRegionWithWeekNumber" (
    "weekStartDate" TEXT,
    "totalSales" INTEGER,
    "avgTransactionValue" REAL,
    "calendarYear" INTEGER,
    "monthNumber" INTEGER,
    "regionCode" TEXT,
    "transactionCount" INTEGER,
    "weekOfYear" INTEGER
);

CREATE TABLE "weeklySalesExistingCustomers" (
    "weekStartDate" TEXT,
    "totalSales" INTEGER,
    "customerType" TEXT,
    "demographicGroup" TEXT
);

CREATE TABLE "weeklySalesNewOrGuestCustomers" (
    "weekStartDate" TEXT,
    "totalSales" INTEGER,
    "customerType" TEXT,
    "demographicGroup" TEXT
);

CREATE TABLE "weeklySalesByPlatform" (
    "weekStartDate" TEXT,
    "totalSales" INTEGER,
    "salesPlatform" TEXT,
    "weekStartFormatted" TEXT
);

CREATE TABLE "regionLookup" (
    "regionId" INTEGER,
    "regionName" TEXT
);

CREATE TABLE "interestMapCreatedUpTo2017Mar27" (
    "interestId" INTEGER,
    "interestName" TEXT,
    "interestSummary" TEXT,
    "createdAt" TEXT,
    "lastModified" TEXT
);

CREATE TABLE "interestMapCreatedAfter2017Mar27Until2018May15" (
    "interestId" INTEGER,
    "interestName" TEXT,
    "interestSummary" TEXT,
    "createdAt" TEXT,
    "lastModified" TEXT
);

CREATE TABLE "interestMapCreatedAfter2018May15Until2018Oct22" (
    "interestId" INTEGER,
    "interestName" TEXT,
    "interestSummary" TEXT,
    "createdAt" TEXT,
    "lastModified" TEXT
);

CREATE TABLE "interestMapCreatedAfter2018Oct22OrNull" (
    "interestId" INTEGER,
    "interestName" TEXT,
    "interestSummary" TEXT,
    "createdAt" TEXT,
    "lastModified" TEXT
);

CREATE TABLE "interestMetricsByMonth" (
    "monthYear" TEXT,
    "interestId" REAL,
    "monthNumeric" REAL,
    "yearNumeric" REAL,
    "composition" REAL,
    "indexValue" REAL,
    "ranking" INTEGER
);

CREATE TABLE "interestCompositionAtMost2Point22" (
    "monthYear" TEXT,
    "interestId" REAL,
    "composition" REAL,
    "indexValue" REAL,
    "percentileRanking" REAL,
    "ranking" INTEGER
);

CREATE TABLE "interestCompositionBetween2Point22And2Point86" (
    "monthYear" TEXT,
    "interestId" REAL,
    "composition" REAL,
    "indexValue" REAL,
    "percentileRanking" REAL,
    "ranking" INTEGER
);

CREATE TABLE "interestCompositionBetween2Point86And3Point87" (
    "monthYear" TEXT,
    "interestId" REAL,
    "composition" REAL,
    "indexValue" REAL,
    "percentileRanking" REAL,
    "ranking" INTEGER
);

CREATE TABLE "interestCompositionAbove3Point87OrNull" (
    "monthYear" TEXT,
    "interestId" REAL,
    "composition" REAL,
    "indexValue" REAL,
    "percentileRanking" REAL,
    "ranking" INTEGER
);

CREATE TABLE "shoppingCartUsersStartedOnOrBefore2020Feb01" (
    "userId" INTEGER,
    "cookieId" TEXT,
    "startDate" TEXT
);

CREATE TABLE "shoppingCartUsersStartedAfter2020Mar09OrNull" (
    "userId" INTEGER,
    "cookieId" TEXT,
    "startDate" TEXT
);