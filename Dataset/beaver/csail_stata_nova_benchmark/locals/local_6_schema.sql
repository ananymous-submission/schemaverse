CREATE TABLE "instanceTypeProjectLinksDeletedZeroOrLess" (
    "createdAt" TEXT DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "recordId" INTEGER,
    "instanceTypeRefId" INTEGER NOT NULL,
    "projectId" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    FOREIGN KEY ("instanceTypeRefId") REFERENCES "instanceTypesByCreationTimestamp"("recordId"),
    FOREIGN KEY ("instanceTypeRefId") REFERENCES "instanceTypesMemoryAtMost2048"("recordId")
);

CREATE TABLE "instanceTypeProjectLinksDeletedAbove206OrNull" (
    "createdAt" TEXT DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "recordId" INTEGER,
    "instanceTypeRefId" INTEGER NOT NULL,
    "projectId" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    FOREIGN KEY ("instanceTypeRefId") REFERENCES "instanceTypesMemoryAtMost2048"("recordId"),
    FOREIGN KEY ("instanceTypeRefId") REFERENCES "instanceTypesMemoryAbove8192To24576"("recordId")
);

CREATE TABLE "shadowReservationsCreatedBefore2015Mar01" (
    "recordId" INTEGER,
    "createdAt" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "expiresAt" TEXT DEFAULT NULL,
    "resourceName" TEXT DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "shadowReservationsCreatedAfter2015Mar01To2015Apr13" (
    "recordId" INTEGER,
    "createdAt" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "expiresAt" TEXT DEFAULT NULL,
    "resourceName" TEXT DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "shadowReservationsCreatedAfter2015Apr13To2015Dec08" (
    "recordId" INTEGER,
    "createdAt" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "expiresAt" TEXT DEFAULT NULL,
    "resourceName" TEXT DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "shadowReservationsCreatedAfter2015Dec08OrNull" (
    "recordId" INTEGER,
    "createdAt" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "expiresAt" TEXT DEFAULT NULL,
    "resourceName" TEXT DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "shadowReservationsUsageDelta" (
    "recordId" INTEGER,
    "createdAt" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deltaChange" INTEGER NOT NULL,
    "expiresAt" TEXT DEFAULT NULL,
    "resourceName" TEXT DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL,
    "usageId" INTEGER NOT NULL
);

CREATE TABLE "shadowReservationsByProject" (
    "recordId" INTEGER,
    "projectId" TEXT DEFAULT NULL,
    "userId" TEXT DEFAULT NULL,
    "reservationUuid" TEXT NOT NULL
);

CREATE TABLE "securityGroupInstanceLinksShadow" (
    "createdAt" TEXT DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "recordId" INTEGER,
    "securityGroupRefId" INTEGER DEFAULT NULL,
    "instanceUuidRef" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL
);

CREATE TABLE "volumeIdMappingsShadow" (
    "createdAt" TEXT DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "recordId" INTEGER,
    "volumeUuid" TEXT NOT NULL,
    "isDeleted" INTEGER DEFAULT NULL
);

CREATE TABLE "volumeUsageCacheByAvailabilityZoneShadow" (
    "recordId" INTEGER,
    "availabilityZone" TEXT DEFAULT NULL,
    "createdAt" TEXT DEFAULT NULL,
    "currLastRefreshed" TEXT DEFAULT NULL,
    "currWrites" INTEGER DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "instanceUuid" TEXT DEFAULT NULL,
    "totLastRefreshed" TEXT DEFAULT NULL,
    "totReads" INTEGER DEFAULT NULL,
    "totWrites" INTEGER DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "volumeUsageCacheBytesByAvailabilityZoneShadow" (
    "recordId" INTEGER,
    "availabilityZone" TEXT DEFAULT NULL,
    "currLastRefreshed" TEXT DEFAULT NULL,
    "currReadBytes" INTEGER DEFAULT NULL,
    "currReads" INTEGER DEFAULT NULL,
    "currWriteBytes" INTEGER DEFAULT NULL,
    "currWrites" INTEGER DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "totLastRefreshed" TEXT DEFAULT NULL,
    "totReadBytes" INTEGER DEFAULT NULL,
    "totReads" INTEGER DEFAULT NULL,
    "totWriteBytes" INTEGER DEFAULT NULL,
    "totWrites" INTEGER DEFAULT NULL
);

CREATE TABLE "volumeUsageCacheByInstanceShadow" (
    "recordId" INTEGER,
    "instanceUuid" TEXT DEFAULT NULL,
    "projectId" TEXT DEFAULT NULL,
    "userId" TEXT DEFAULT NULL,
    "volumeId" TEXT NOT NULL
);

CREATE TABLE "instanceTypesByCreationTimestamp" (
    "recordId" INTEGER,
    "createdAt" TEXT DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "instanceTypesMemoryAtMost2048" (
    "recordId" INTEGER,
    "isDeleted" INTEGER DEFAULT NULL,
    "isDisabled" INTEGER DEFAULT NULL,
    "flavorIdentifier" TEXT DEFAULT NULL,
    "isPublic" INTEGER DEFAULT NULL,
    "memoryMb" INTEGER NOT NULL,
    "typeName" TEXT DEFAULT NULL,
    "rxtxFactor" REAL DEFAULT NULL,
    "vcpuWeight" INTEGER DEFAULT NULL,
    "vcpusCount" INTEGER NOT NULL
);

CREATE TABLE "instanceTypesMemoryAbove2048To8192" (
    "recordId" INTEGER,
    "isDeleted" INTEGER DEFAULT NULL,
    "isDisabled" INTEGER DEFAULT NULL,
    "flavorIdentifier" TEXT DEFAULT NULL,
    "isPublic" INTEGER DEFAULT NULL,
    "memoryMb" INTEGER NOT NULL,
    "typeName" TEXT DEFAULT NULL,
    "rxtxFactor" REAL DEFAULT NULL,
    "vcpuWeight" INTEGER DEFAULT NULL,
    "vcpusCount" INTEGER NOT NULL
);

CREATE TABLE "instanceTypesMemoryAbove8192To24576" (
    "recordId" INTEGER,
    "isDeleted" INTEGER DEFAULT NULL,
    "isDisabled" INTEGER DEFAULT NULL,
    "flavorIdentifier" TEXT DEFAULT NULL,
    "isPublic" INTEGER DEFAULT NULL,
    "memoryMb" INTEGER NOT NULL,
    "typeName" TEXT DEFAULT NULL,
    "rxtxFactor" REAL DEFAULT NULL,
    "vcpuWeight" INTEGER DEFAULT NULL,
    "vcpusCount" INTEGER NOT NULL
);