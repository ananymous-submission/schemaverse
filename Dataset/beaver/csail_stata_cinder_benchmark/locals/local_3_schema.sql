CREATE TABLE "ImageVolumeCacheRecords" (
    "ImageUpdatedAt" TEXT DEFAULT NULL,
    "CacheEntryId" INTEGER,
    "HostName" TEXT NOT NULL,
    "ImageIdentifier" TEXT NOT NULL,
    "VolumeIdentifier" TEXT NOT NULL,
    "SizeBytes" INTEGER NOT NULL,
    "LastAccessedAt" TEXT NOT NULL
);

CREATE TABLE "MigrationVersion" (
    "RepositoryIdentifier" TEXT,
    "RepositoryLocation" TEXT,
    "VersionNumber" INTEGER DEFAULT NULL
);