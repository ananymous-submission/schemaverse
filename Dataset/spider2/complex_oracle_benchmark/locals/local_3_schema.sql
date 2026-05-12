CREATE TABLE "salesTransactions" (
    "productId" INTEGER NOT NULL,
    "customerId" INTEGER NOT NULL,
    "timeId" DATE NOT NULL,
    "channelId" INTEGER NOT NULL,
    "promotionId" INTEGER NOT NULL,
    "quantitySold" INTEGER NOT NULL,
    "amountSold" REAL NOT NULL,
    FOREIGN KEY ("timeId") REFERENCES "calendarMonthIdentifiers"("timeId"),
    FOREIGN KEY ("customerId") REFERENCES "customerIncomeBracketE90kTo109k"("customerId"),
    FOREIGN KEY ("customerId") REFERENCES "customerIncomeBucketsG130kTo149kAndD70kTo89k"("customerId"),
    FOREIGN KEY ("customerId") REFERENCES "customerIncomeBucketsI170kTo189kAndC50kTo69k"("customerId"),
    FOREIGN KEY ("customerId") REFERENCES "customerIncomeBucketOther"("customerId")
);

CREATE TABLE "calendarMonthDescription" (
    "timeId" DATE,
    "calendarMonthDescription" TEXT NOT NULL,
    "calendarMonthId" INTEGER NOT NULL,
    "calendarMonthName" TEXT NOT NULL,
    "calendarMonthNumber" INTEGER NOT NULL,
    "dayName" TEXT NOT NULL,
    "dayNumberInMonth" INTEGER NOT NULL,
    "daysInCalendarMonth" INTEGER NOT NULL,
    "endOfCalendarMonth" DATE NOT NULL,
    "endOfCalendarYear" DATE NOT NULL,
    "endOfFiscalMonth" DATE NOT NULL,
    "endOfFiscalYear" DATE NOT NULL,
    "fiscalMonthDescription" TEXT NOT NULL,
    "fiscalMonthId" INTEGER NOT NULL,
    "fiscalMonthName" TEXT NOT NULL,
    "fiscalMonthNumber" INTEGER NOT NULL
);

CREATE TABLE "calendarMonthIdentifiers" (
    "timeId" DATE,
    "calendarMonthId" INTEGER NOT NULL,
    "calendarQuarterId" INTEGER NOT NULL,
    "calendarYear" INTEGER NOT NULL,
    "calendarYearId" INTEGER NOT NULL,
    "daysInCalendarYear" INTEGER NOT NULL,
    "endOfCalendarMonth" DATE NOT NULL,
    "endOfCalendarQuarter" DATE NOT NULL,
    "endOfCalendarYear" DATE NOT NULL,
    "endOfFiscalMonth" DATE NOT NULL,
    "endOfFiscalQuarter" DATE NOT NULL,
    "endOfFiscalYear" DATE NOT NULL,
    "fiscalMonthId" INTEGER NOT NULL,
    "fiscalYear" INTEGER NOT NULL,
    "fiscalYearId" INTEGER NOT NULL
);

CREATE TABLE "customerProfile" (
    "customerId" INTEGER,
    "effectiveFrom" DATE,
    "effectiveTo" DATE,
    "maritalStatus" TEXT,
    "sourceId" INTEGER,
    "validFlag" CHAR(1),
    "birthYear" INTEGER NOT NULL
);

CREATE TABLE "customerIncomeBracketF110kTo129k" (
    "customerId" INTEGER,
    "creditLimit" REAL,
    "emailAddress" TEXT,
    "gender" CHAR(1) NOT NULL,
    "incomeLevel" TEXT,
    "postalCode" TEXT NOT NULL,
    "totalCategory" TEXT NOT NULL,
    "totalCategoryId" INTEGER NOT NULL
);

CREATE TABLE "customerIncomeBracketE90kTo109k" (
    "customerId" INTEGER,
    "creditLimit" REAL,
    "emailAddress" TEXT,
    "gender" CHAR(1) NOT NULL,
    "incomeLevel" TEXT,
    "postalCode" TEXT NOT NULL,
    "totalCategory" TEXT NOT NULL,
    "totalCategoryId" INTEGER NOT NULL
);

CREATE TABLE "customerIncomeBucketsG130kTo149kAndD70kTo89k" (
    "customerId" INTEGER,
    "creditLimit" REAL,
    "emailAddress" TEXT,
    "gender" CHAR(1) NOT NULL,
    "incomeLevel" TEXT,
    "postalCode" TEXT NOT NULL,
    "totalCategory" TEXT NOT NULL,
    "totalCategoryId" INTEGER NOT NULL
);

CREATE TABLE "customerIncomeBucketsH150kTo169kAndJ190kTo249kAndB30kTo49k" (
    "customerId" INTEGER,
    "creditLimit" REAL,
    "emailAddress" TEXT,
    "gender" CHAR(1) NOT NULL,
    "incomeLevel" TEXT,
    "postalCode" TEXT NOT NULL,
    "totalCategory" TEXT NOT NULL,
    "totalCategoryId" INTEGER NOT NULL
);

CREATE TABLE "customerIncomeBucketsI170kTo189kAndC50kTo69k" (
    "customerId" INTEGER,
    "creditLimit" REAL,
    "emailAddress" TEXT,
    "gender" CHAR(1) NOT NULL,
    "incomeLevel" TEXT,
    "postalCode" TEXT NOT NULL,
    "totalCategory" TEXT NOT NULL,
    "totalCategoryId" INTEGER NOT NULL
);

CREATE TABLE "customerIncomeBucketOther" (
    "customerId" INTEGER,
    "creditLimit" REAL,
    "emailAddress" TEXT,
    "gender" CHAR(1) NOT NULL,
    "incomeLevel" TEXT,
    "postalCode" TEXT NOT NULL,
    "totalCategory" TEXT NOT NULL,
    "totalCategoryId" INTEGER NOT NULL
);

CREATE TABLE "promotionsBegin20190925To20200330" (
    "promotionId" INTEGER,
    "promotionName" TEXT NOT NULL,
    "promotionSubcategory" TEXT NOT NULL,
    "promotionSubcategoryId" INTEGER NOT NULL,
    "promotionCategory" TEXT NOT NULL,
    "promotionCategoryId" INTEGER NOT NULL,
    "promotionCost" REAL NOT NULL,
    "promotionStartDate" DATE NOT NULL,
    "promotionEndDate" DATE NOT NULL,
    "promotionTotal" TEXT NOT NULL,
    "promotionTotalId" INTEGER NOT NULL
);

CREATE TABLE "promotionsBeginAfter20200330To20210228" (
    "promotionId" INTEGER,
    "promotionName" TEXT NOT NULL,
    "promotionSubcategory" TEXT NOT NULL,
    "promotionSubcategoryId" INTEGER NOT NULL,
    "promotionCategory" TEXT NOT NULL,
    "promotionCategoryId" INTEGER NOT NULL,
    "promotionCost" REAL NOT NULL,
    "promotionStartDate" DATE NOT NULL,
    "promotionEndDate" DATE NOT NULL,
    "promotionTotal" TEXT NOT NULL,
    "promotionTotalId" INTEGER NOT NULL
);