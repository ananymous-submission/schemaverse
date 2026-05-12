CREATE TABLE "MigrationRecordsWithCreatedAt" (
    "Id" INTEGER,
    "CreatedAt" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "DestinationHost" TEXT DEFAULT NULL,
    "DiskTotal" INTEGER DEFAULT NULL,
    "IsHidden" INTEGER DEFAULT NULL,
    "InstanceUuid" TEXT DEFAULT NULL,
    "MigrationType" TEXT DEFAULT NULL,
    "SourceNode" TEXT DEFAULT NULL,
    "Status" TEXT DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "MigrationDeletionRecords" (
    "Id" INTEGER,
    "IsDeleted" INTEGER DEFAULT NULL,
    "DestinationComputeService" TEXT DEFAULT NULL,
    "DestinationHost" TEXT DEFAULT NULL,
    "DestinationNode" TEXT DEFAULT NULL,
    "IsHidden" INTEGER DEFAULT NULL,
    "SourceComputeService" TEXT DEFAULT NULL,
    "SourceNode" TEXT DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "VirtualInterfaceAddressShadow" (
    "Id" INTEGER,
    "AddressValue" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "InstanceUuid" TEXT DEFAULT NULL,
    "NetworkId" INTEGER DEFAULT NULL,
    "Uuid" TEXT DEFAULT NULL
);

CREATE TABLE "VirtualInterfaceAddressShadowWithTimestamps" (
    "Id" INTEGER,
    "AddressValue" TEXT DEFAULT NULL,
    "CreatedAt" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "NetworkId" INTEGER DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL,
    "Uuid" TEXT DEFAULT NULL
);

CREATE TABLE "SnapshotIdentifierMappings" (
    "CreatedAt" TEXT DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "Id" INTEGER,
    "SnapshotUuid" TEXT NOT NULL,
    "IsDeleted" INTEGER DEFAULT NULL
);

CREATE TABLE "SnapshotCreateTimestamps" (
    "SnapshotId" TEXT,
    "CreatedAt" TEXT DEFAULT NULL,
    "IsDeletedFlag" TEXT DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "DisplayName" TEXT DEFAULT NULL,
    "Progress" TEXT DEFAULT NULL,
    "ScheduledAt" TEXT DEFAULT NULL,
    "Status" TEXT DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "SnapshotDeletionRecords" (
    "SnapshotId" TEXT,
    "IsDeleted" TEXT DEFAULT NULL,
    "DisplayDescription" TEXT DEFAULT NULL,
    "DisplayName" TEXT DEFAULT NULL,
    "Progress" TEXT DEFAULT NULL,
    "Status" TEXT DEFAULT NULL,
    "VolumeSize" INTEGER DEFAULT NULL
);

CREATE TABLE "SnapshotDisplayDetails" (
    "SnapshotId" TEXT,
    "DisplayDescription" TEXT DEFAULT NULL,
    "ProjectId" TEXT DEFAULT NULL,
    "UserId" TEXT DEFAULT NULL,
    "VolumeId" TEXT NOT NULL,
    "VolumeSize" INTEGER DEFAULT NULL
);

CREATE TABLE "ResourceTags" (
    "ResourceId" TEXT,
    "Tag" TEXT
);

CREATE TABLE "InstanceTimestamps" (
    "Id" INTEGER,
    "CreatedAt" TEXT DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "LaunchedAt" TEXT DEFAULT NULL,
    "ScheduledAt" TEXT DEFAULT NULL,
    "TerminatedAt" TEXT DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "InstanceDiskConfigMemoryUpTo1024Mb" (
    "Id" INTEGER,
    "AutoDiskConfigEnabled" INTEGER DEFAULT NULL,
    "DefaultEphemeralDevice" TEXT DEFAULT NULL,
    "DefaultSwapDevice" TEXT DEFAULT NULL,
    "EphemeralGb" INTEGER DEFAULT NULL,
    "MemoryMb" INTEGER DEFAULT NULL,
    "RootDeviceName" TEXT DEFAULT NULL,
    "RootGb" INTEGER DEFAULT NULL,
    "VcpuCount" INTEGER DEFAULT NULL
);

CREATE TABLE "InstanceDiskConfigMemory1025To4096Mb" (
    "Id" INTEGER,
    "AutoDiskConfigEnabled" INTEGER DEFAULT NULL,
    "DefaultEphemeralDevice" TEXT DEFAULT NULL,
    "DefaultSwapDevice" TEXT DEFAULT NULL,
    "EphemeralGb" INTEGER DEFAULT NULL,
    "MemoryMb" INTEGER DEFAULT NULL,
    "RootDeviceName" TEXT DEFAULT NULL,
    "RootGb" INTEGER DEFAULT NULL,
    "VcpuCount" INTEGER DEFAULT NULL
);

CREATE TABLE "InstanceDiskConfigMemory4097To16384Mb" (
    "Id" INTEGER,
    "AutoDiskConfigEnabled" INTEGER DEFAULT NULL,
    "DefaultEphemeralDevice" TEXT DEFAULT NULL,
    "DefaultSwapDevice" TEXT DEFAULT NULL,
    "EphemeralGb" INTEGER DEFAULT NULL,
    "MemoryMb" INTEGER DEFAULT NULL,
    "RootDeviceName" TEXT DEFAULT NULL,
    "RootGb" INTEGER DEFAULT NULL,
    "VcpuCount" INTEGER DEFAULT NULL
);

CREATE TABLE "InstanceDiskConfigMemoryGreaterThan16384MbOrNull" (
    "Id" INTEGER,
    "AutoDiskConfigEnabled" INTEGER DEFAULT NULL,
    "DefaultEphemeralDevice" TEXT DEFAULT NULL,
    "DefaultSwapDevice" TEXT DEFAULT NULL,
    "EphemeralGb" INTEGER DEFAULT NULL,
    "MemoryMb" INTEGER DEFAULT NULL,
    "RootDeviceName" TEXT DEFAULT NULL,
    "RootGb" INTEGER DEFAULT NULL,
    "VcpuCount" INTEGER DEFAULT NULL
);

CREATE TABLE "InstanceAccessIpV4Records" (
    "Id" INTEGER,
    "Ipv4Address" TEXT DEFAULT NULL,
    "Ipv6Address" TEXT DEFAULT NULL,
    "AvailabilityZone" TEXT DEFAULT NULL,
    "CellName" TEXT DEFAULT NULL,
    "DisplayDescription" TEXT DEFAULT NULL,
    "DisplayName" TEXT DEFAULT NULL,
    "HostService" TEXT DEFAULT NULL,
    "HostName" TEXT DEFAULT NULL,
    "KeyPairName" TEXT DEFAULT NULL,
    "LaunchedOn" TEXT,
    "ComputeNode" TEXT DEFAULT NULL,
    "ProgressPercent" INTEGER DEFAULT NULL,
    "TaskState" TEXT DEFAULT NULL
);