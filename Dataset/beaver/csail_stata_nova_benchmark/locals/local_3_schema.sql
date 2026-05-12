CREATE TABLE "QuotaUsageCreatedOnOrBefore20150701" (
    "Id" INTEGER,
    "CreatedAt" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "ReservedCount" INTEGER NOT NULL,
    "ResourceType" TEXT NOT NULL,
    "SecondsUntilRefresh" INTEGER DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "QuotaUsageCreatedAfter20150701OnOrBefore20170309" (
    "Id" INTEGER,
    "CreatedAt" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "ReservedCount" INTEGER NOT NULL,
    "ResourceType" TEXT NOT NULL,
    "SecondsUntilRefresh" INTEGER DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "QuotaUsageCreatedAfter20170309OnOrBefore20191121" (
    "Id" INTEGER,
    "CreatedAt" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "ReservedCount" INTEGER NOT NULL,
    "ResourceType" TEXT NOT NULL,
    "SecondsUntilRefresh" INTEGER DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "QuotaUsageCreatedAfter20191121OrNull" (
    "Id" INTEGER,
    "CreatedAt" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "ReservedCount" INTEGER NOT NULL,
    "ResourceType" TEXT NOT NULL,
    "SecondsUntilRefresh" INTEGER DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "QuotaUsageDeletedRecords" (
    "Id" INTEGER,
    "IsDeleted" INTEGER DEFAULT NULL,
    "InUseCount" INTEGER NOT NULL,
    "ProjectId" TEXT DEFAULT NULL,
    "ReservedCount" INTEGER NOT NULL,
    "ResourceType" TEXT NOT NULL,
    "SecondsUntilRefresh" INTEGER DEFAULT NULL,
    "UserId" TEXT DEFAULT NULL
);

CREATE TABLE "ReservationCreatedOnOrBefore20200528" (
    "Id" INTEGER,
    "CreatedAt" TEXT DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "ExpiresAt" TEXT DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "ReservationCreatedAfter20200528OnOrBefore20210521" (
    "Id" INTEGER,
    "CreatedAt" TEXT DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "ExpiresAt" TEXT DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "ReservationCreatedAfter20210521OnOrBefore20220805" (
    "Id" INTEGER,
    "CreatedAt" TEXT DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "ExpiresAt" TEXT DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "ReservationCreatedAfter20220805OrNull" (
    "Id" INTEGER,
    "CreatedAt" TEXT DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "ExpiresAt" TEXT DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "ReservationDeletedRecords" (
    "Id" INTEGER,
    "IsDeleted" INTEGER DEFAULT NULL,
    "Delta" INTEGER NOT NULL,
    "ResourceType" TEXT DEFAULT NULL,
    "UsageId" INTEGER NOT NULL,
    "UserId" TEXT DEFAULT NULL,
    "Uuid" TEXT NOT NULL,
    FOREIGN KEY ("UsageId") REFERENCES "QuotaUsageCreatedOnOrBefore20150701"("Id"),
    FOREIGN KEY ("UsageId") REFERENCES "QuotaUsageCreatedAfter20170309OnOrBefore20191121"("Id"),
    FOREIGN KEY ("UsageId") REFERENCES "QuotaUsageCreatedAfter20191121OrNull"("Id")
);

CREATE TABLE "ReservationDeletedProjectScope" (
    "Id" INTEGER,
    "IsDeleted" INTEGER DEFAULT NULL,
    "ExpiresAt" TEXT DEFAULT NULL,
    "ProjectId" TEXT DEFAULT NULL,
    "UsageId" INTEGER NOT NULL,
    "UserId" TEXT DEFAULT NULL,
    "Uuid" TEXT NOT NULL,
    FOREIGN KEY ("UsageId") REFERENCES "QuotaUsageCreatedAfter20150701OnOrBefore20170309"("Id"),
    FOREIGN KEY ("UsageId") REFERENCES "QuotaUsageDeletedRecords"("Id")
);

CREATE TABLE "AggregateHostAggregateIdLe2" (
    "CreatedAt" TEXT DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "Id" INTEGER,
    "HostName" TEXT DEFAULT NULL,
    "AggregateId" INTEGER NOT NULL,
    "IsDeleted" INTEGER DEFAULT NULL
);

CREATE TABLE "AggregateHostAggregateIdRange3To7" (
    "CreatedAt" TEXT DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "Id" INTEGER,
    "HostName" TEXT DEFAULT NULL,
    "AggregateId" INTEGER NOT NULL,
    "IsDeleted" INTEGER DEFAULT NULL
);

CREATE TABLE "AggregateHostAggregateIdGt7OrNull" (
    "CreatedAt" TEXT DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "Id" INTEGER,
    "HostName" TEXT DEFAULT NULL,
    "AggregateId" INTEGER NOT NULL,
    "IsDeleted" INTEGER DEFAULT NULL
);

CREATE TABLE "SecurityGroupRuleCidrShadow" (
    "Id" INTEGER,
    "Cidr" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "PortFrom" INTEGER DEFAULT NULL,
    "GroupId" INTEGER DEFAULT NULL,
    "Protocol" TEXT DEFAULT NULL,
    "PortTo" INTEGER DEFAULT NULL
);

CREATE TABLE "SecurityGroupRuleCidrParentGroupIdLe22" (
    "Id" INTEGER,
    "Cidr" TEXT DEFAULT NULL,
    "CreatedAt" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "GroupId" INTEGER DEFAULT NULL,
    "ParentGroupId" INTEGER DEFAULT NULL,
    "Protocol" TEXT DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "SecurityGroupRuleCidrParentGroupId23To55" (
    "Id" INTEGER,
    "Cidr" TEXT DEFAULT NULL,
    "CreatedAt" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "GroupId" INTEGER DEFAULT NULL,
    "ParentGroupId" INTEGER DEFAULT NULL,
    "Protocol" TEXT DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "SecurityGroupRuleCidrParentGroupIdGt55OrNull" (
    "Id" INTEGER,
    "Cidr" TEXT DEFAULT NULL,
    "CreatedAt" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "GroupId" INTEGER DEFAULT NULL,
    "ParentGroupId" INTEGER DEFAULT NULL,
    "Protocol" TEXT DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "SecurityGroupShadowCreatedAt" (
    "Id" INTEGER,
    "CreatedAt" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "Description" TEXT DEFAULT NULL,
    "Name" TEXT DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL,
    "UserId" TEXT DEFAULT NULL
);

CREATE TABLE "SecurityGroupShadowDeleted" (
    "Id" INTEGER,
    "IsDeleted" INTEGER DEFAULT NULL,
    "Description" TEXT DEFAULT NULL,
    "Name" TEXT DEFAULT NULL,
    "ProjectId" TEXT DEFAULT NULL,
    "UserId" TEXT DEFAULT NULL
);