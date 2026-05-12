CREATE TABLE "CustomerSegmentSme" (
    "ClientId" INTEGER,
    "CustomerSegment" TEXT,
    "CurrencyCode" TEXT
);

CREATE TABLE "CustomerSegmentLamKamOrNull" (
    "ClientId" INTEGER,
    "CustomerSegment" TEXT,
    "CurrencyCode" TEXT
);

CREATE TABLE "CustomerMonthlyConsumption" (
    "ClientId" INTEGER,
    "BillingMonth" TEXT,
    "MonthlyConsumption" REAL
);