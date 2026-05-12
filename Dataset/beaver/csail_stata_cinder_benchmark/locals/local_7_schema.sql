CREATE TABLE "ServiceBackendStatus" (
    "ServiceStatusId" INTEGER,
    "ActiveBackendIdentifier" TEXT DEFAULT NULL,
    "AvailabilityZone" TEXT DEFAULT NULL,
    "ServiceBinary" TEXT DEFAULT NULL,
    "DisabledReason" TEXT DEFAULT NULL,
    "Hostname" TEXT DEFAULT NULL,
    "ReplicationStatus" TEXT DEFAULT NULL,
    "ReportCount" INTEGER NOT NULL,
    "MessageTopic" TEXT DEFAULT NULL
);

CREATE TABLE "ServiceLifecycleTimestamps" (
    "LifecycleId" INTEGER,
    "CreatedAtTimestamp" TEXT DEFAULT NULL,
    "DeletedAtTimestamp" TEXT DEFAULT NULL,
    "ModifiedAtTimestamp" TEXT DEFAULT NULL,
    "UpdatedAtTimestamp" TEXT DEFAULT NULL
);

CREATE TABLE "ServiceBackendDetails" (
    "DetailsId" INTEGER,
    "ActiveBackendIdentifier" TEXT DEFAULT NULL,
    "AvailabilityZone" TEXT DEFAULT NULL,
    "ServiceBinary" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "IsDisabled" INTEGER DEFAULT NULL,
    "DisabledReason" TEXT DEFAULT NULL,
    "IsFrozen" INTEGER DEFAULT NULL,
    "Hostname" TEXT DEFAULT NULL,
    "ReplicationStatus" TEXT DEFAULT NULL,
    "ReportCount" INTEGER NOT NULL,
    "MessageTopic" TEXT DEFAULT NULL
);

CREATE TABLE "ServiceVersionCompatibility" (
    "VersionRecordId" INTEGER,
    "ObjectAvailableVersion" TEXT DEFAULT NULL,
    "ObjectCurrentVersion" TEXT DEFAULT NULL,
    "RpcAvailableVersion" TEXT DEFAULT NULL,
    "RpcCurrentVersion" TEXT DEFAULT NULL
);

CREATE TABLE "VolumeTypeProjectAssignments" (
    "AssignmentId" INTEGER,
    "CreatedAtTimestamp" TEXT DEFAULT NULL,
    "UpdatedAtTimestamp" TEXT DEFAULT NULL,
    "DeletedAtTimestamp" TEXT DEFAULT NULL,
    "VolumeTypeId" TEXT DEFAULT NULL,
    "ProjectId" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL
);