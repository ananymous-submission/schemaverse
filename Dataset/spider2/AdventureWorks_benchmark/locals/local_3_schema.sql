CREATE TABLE "SalesQuotaHistory_EntityIdUpTo277" (
    "BusinessEntityKey" INTEGER,
    "QuotaEffectiveDate" TEXT,
    "QuotaAmount" REAL,
    "RowGuidValue" TEXT,
    "LastModifiedTimestamp" TEXT
);

CREATE TABLE "SalesQuotaHistory_EntityId278To280" (
    "BusinessEntityKey" INTEGER,
    "QuotaEffectiveDate" TEXT,
    "QuotaAmount" REAL,
    "RowGuidValue" TEXT,
    "LastModifiedTimestamp" TEXT
);

CREATE TABLE "SalesQuotaHistory_EntityId281To284" (
    "BusinessEntityKey" INTEGER,
    "QuotaEffectiveDate" TEXT,
    "QuotaAmount" REAL,
    "RowGuidValue" TEXT,
    "LastModifiedTimestamp" TEXT
);

CREATE TABLE "SalesQuotaHistory_EntityIdGt284OrNull" (
    "BusinessEntityKey" INTEGER,
    "QuotaEffectiveDate" TEXT,
    "QuotaAmount" REAL,
    "RowGuidValue" TEXT,
    "LastModifiedTimestamp" TEXT
);

CREATE TABLE "SalesRepresentative" (
    "BusinessEntityKey" INTEGER,
    "SalesTerritoryKey" INTEGER,
    "AnnualSalesQuota" INTEGER,
    "BonusAmount" INTEGER,
    "CommissionRatePercent" FLOAT,
    "SalesYearToDateAmount" FLOAT,
    "SalesPreviousYearAmount" FLOAT,
    "RowGuidValue" TEXT,
    "LastModifiedTimestamp" DATE
);