CREATE TABLE "productDocumentLink" (
    "productReferenceId" INTEGER,
    "documentNodeToken" TEXT,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "salesOrderReasonModifiedOnOrBefore2013Aug02" (
    "salesOrderRefId" INTEGER,
    "salesReasonRefId" INTEGER,
    "modifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "salesOrderReasonModifiedAfter2014Mar11OrNull" (
    "salesOrderRefId" INTEGER,
    "salesReasonRefId" INTEGER,
    "modifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "salesPersonQuotaHistoryOnOrBefore2012Jan15" (
    "businessEntityRefId" INTEGER,
    "quotaEffectiveDate" DATETIME,
    "quotaAmount" REAL NOT NULL,
    "recordGuid" TEXT NOT NULL,
    "modifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "salesPersonQuotaHistoryAfter2013Jul16OrNull" (
    "businessEntityRefId" INTEGER,
    "quotaEffectiveDate" DATETIME,
    "quotaAmount" REAL NOT NULL,
    "recordGuid" TEXT NOT NULL,
    "modifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "salesReasonLookup" (
    "salesReasonRefId" INTEGER,
    "reasonName" TEXT NOT NULL,
    "reasonCategory" TEXT NOT NULL,
    "modifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "salesPersonCompensation" (
    "businessEntityRefId" INTEGER,
    "bonusAmount" REAL NOT NULL DEFAULT 0.0000,
    "commissionPercent" REAL NOT NULL DEFAULT 0.0000,
    "modifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "salesPreviousYearAmount" REAL NOT NULL DEFAULT 0.0000,
    "salesQuotaAmount" REAL,
    "salesYearToDate" REAL NOT NULL DEFAULT 0.0000
);

CREATE TABLE "documentRevisionTracker" (
    "documentNodeToken" TEXT,
    "changeSequence" INTEGER NOT NULL DEFAULT 0,
    "documentHierarchyLevel" INTEGER,
    "documentSummaryText" TEXT,
    "lastModifiedAt" DATETIME NOT NULL DEFAULT current_timestamp,
    "ownerId" INTEGER NOT NULL,
    "revisionLabel" TEXT NOT NULL,
    "statusCode" INTEGER NOT NULL,
    "titleText" TEXT NOT NULL,
    "recordGuid" TEXT NOT NULL
);