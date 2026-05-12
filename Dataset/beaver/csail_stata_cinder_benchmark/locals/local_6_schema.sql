CREATE TABLE "QuotaUsageCreatedAfter2019Oct29OrNull" (
    "Id" INTEGER,
    "CreatedAt" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "ResourceName" TEXT DEFAULT NULL,
    "SecondsUntilRefresh" INTEGER DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "DeletedQuotaUsageSnapshot" (
    "Id" INTEGER,
    "IsDeleted" INTEGER DEFAULT NULL,
    "InUseCount" INTEGER NOT NULL,
    "ProjectId" TEXT DEFAULT NULL,
    "ReservedCount" INTEGER NOT NULL,
    "ResourceName" TEXT DEFAULT NULL,
    "SecondsUntilRefresh" INTEGER DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "QuotaCreatedOnOrBefore2015Oct26" (
    "Id" INTEGER,
    "CreatedAt" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "HardLimit" INTEGER DEFAULT NULL,
    "ProjectId" TEXT DEFAULT NULL,
    "ResourceName" TEXT NOT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "QuotaCreatedAfter2020Apr30OrNull" (
    "Id" INTEGER,
    "CreatedAt" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "HardLimit" INTEGER DEFAULT NULL,
    "ProjectId" TEXT DEFAULT NULL,
    "ResourceName" TEXT NOT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);