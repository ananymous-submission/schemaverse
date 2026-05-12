CREATE TABLE "BlobAssetLocations" (
    "LocationId" TEXT,
    "ChecksumId" TEXT NOT NULL,
    "LocationValue" TEXT NOT NULL,
    "CreatedTimestamp" TEXT NOT NULL,
    "UpdatedTimestamp" TEXT NOT NULL,
    "DisplayOrder" INTEGER DEFAULT NULL,
    "LifecycleStatus" TEXT DEFAULT NULL,
    FOREIGN KEY ("ChecksumId") REFERENCES "BlobChecksums"("ChecksumId")
);

CREATE TABLE "NamespaceResourceTypeRecords" (
    "ResourceTypeId" INTEGER,
    "NamespaceId" INTEGER,
    "AssociationCreatedAt" TEXT NOT NULL,
    "NamePrefix" TEXT DEFAULT NULL,
    "TargetProperties" TEXT DEFAULT NULL,
    "AssociationUpdatedAt" TEXT DEFAULT NULL,
    FOREIGN KEY ("ResourceTypeId") REFERENCES "ResourceTypeDefinitions"("ResourceTypeId")
);

CREATE TABLE "ResourceTypeDefinitions" (
    "ResourceTypeId" INTEGER,
    "TypeName" TEXT NOT NULL,
    "IsProtected" INTEGER NOT NULL,
    "CreatedTimestamp" TEXT NOT NULL,
    "UpdatedTimestamp" TEXT DEFAULT NULL
);

CREATE TABLE "BlobChecksums" (
    "ChecksumId" TEXT,
    "Digest" TEXT DEFAULT NULL,
    "CreatedTimestamp" TEXT NOT NULL,
    "ObjectKey" TEXT DEFAULT NULL,
    "OrderIndex" INTEGER DEFAULT NULL,
    "ByteSize" INTEGER NOT NULL,
    "UpdatedTimestamp" TEXT NOT NULL
);