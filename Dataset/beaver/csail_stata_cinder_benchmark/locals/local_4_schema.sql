CREATE TABLE "qualityOfServiceSpecsSnapshot" (
    "qosSpecId" TEXT,
    "createdAt" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "specKey" TEXT DEFAULT NULL,
    "parentSpecId" TEXT DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "reservationsAllocatedDeltaAtMostMinusOne" (
    "reservationId" INTEGER,
    "allocatedQuotaId" INTEGER DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deltaAmount" INTEGER NOT NULL,
    "projectId" TEXT DEFAULT NULL,
    "resourceName" TEXT DEFAULT NULL,
    "usageId" INTEGER DEFAULT NULL,
    "reservationUuid" TEXT NOT NULL
);

CREATE TABLE "reservationsAllocatedDeltaBetweenMinusOneAndOneInclusive" (
    "reservationId" INTEGER,
    "allocatedQuotaId" INTEGER DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deltaAmount" INTEGER NOT NULL,
    "projectId" TEXT DEFAULT NULL,
    "resourceName" TEXT DEFAULT NULL,
    "usageId" INTEGER DEFAULT NULL,
    "reservationUuid" TEXT NOT NULL,
    FOREIGN KEY ("allocatedQuotaId") REFERENCES "quotaAllocations"("quotaId"),
    FOREIGN KEY ("allocatedQuotaId") REFERENCES "quotaCreatedAfter2015Oct26T081449AndOnOrBefore2017Jun15T032250"("quotaId"),
    FOREIGN KEY ("allocatedQuotaId") REFERENCES "quotaCreatedAfter2017Jun15T032250AndOnOrBefore2020Apr30T142201"("quotaId"),
    FOREIGN KEY ("usageId") REFERENCES "quotaUsageCreatedOnOrBefore2015Aug05T141702"("usageId"),
    FOREIGN KEY ("usageId") REFERENCES "quotaUsageCreatedAfter2015Aug05T141702AndOnOrBefore2017Apr15T064739"("usageId")
);

CREATE TABLE "reservationsAllocatedDeltaGreaterThanOneOrNull" (
    "reservationId" INTEGER,
    "allocatedQuotaId" INTEGER DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deltaAmount" INTEGER NOT NULL,
    "projectId" TEXT DEFAULT NULL,
    "resourceName" TEXT DEFAULT NULL,
    "usageId" INTEGER DEFAULT NULL,
    "reservationUuid" TEXT NOT NULL,
    FOREIGN KEY ("allocatedQuotaId") REFERENCES "quotaCreatedAfter2015Oct26T081449AndOnOrBefore2017Jun15T032250"("quotaId"),
    FOREIGN KEY ("allocatedQuotaId") REFERENCES "quotaCreatedAfter2017Jun15T032250AndOnOrBefore2020Apr30T142201"("quotaId")
);

CREATE TABLE "reservationsByCreatedAt" (
    "reservationId" INTEGER,
    "createdAt" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "deltaAmount" INTEGER NOT NULL,
    "expiresAt" TEXT DEFAULT NULL,
    "projectId" TEXT DEFAULT NULL,
    "resourceName" TEXT DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL,
    "reservationUuid" TEXT NOT NULL
);

CREATE TABLE "quotaUsageCreatedOnOrBefore2015Aug05T141702" (
    "usageId" INTEGER,
    "createdAt" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "resourceName" TEXT DEFAULT NULL,
    "untilRefresh" INTEGER DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "quotaUsageCreatedAfter2015Aug05T141702AndOnOrBefore2017Apr15T064739" (
    "usageId" INTEGER,
    "createdAt" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "resourceName" TEXT DEFAULT NULL,
    "untilRefresh" INTEGER DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "quotaUsageCreatedAfter2017Apr15T064739AndOnOrBefore2019Oct29T195722" (
    "usageId" INTEGER,
    "createdAt" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "resourceName" TEXT DEFAULT NULL,
    "untilRefresh" INTEGER DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "quotaAllocations" (
    "quotaId" INTEGER,
    "allocatedAmount" INTEGER DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "hardLimit" INTEGER DEFAULT NULL,
    "projectId" TEXT DEFAULT NULL,
    "resourceName" TEXT NOT NULL
);

CREATE TABLE "quotaCreatedAfter2015Oct26T081449AndOnOrBefore2017Jun15T032250" (
    "quotaId" INTEGER,
    "createdAt" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "hardLimit" INTEGER DEFAULT NULL,
    "projectId" TEXT DEFAULT NULL,
    "resourceName" TEXT NOT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "quotaCreatedAfter2017Jun15T032250AndOnOrBefore2020Apr30T142201" (
    "quotaId" INTEGER,
    "createdAt" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "hardLimit" INTEGER DEFAULT NULL,
    "projectId" TEXT DEFAULT NULL,
    "resourceName" TEXT NOT NULL,
    "updatedAt" TEXT DEFAULT NULL
);