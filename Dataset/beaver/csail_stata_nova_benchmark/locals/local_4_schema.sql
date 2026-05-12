CREATE TABLE "consoleCreationRecords" (
    "recordId" INTEGER,
    "createdTimestamp" TEXT DEFAULT NULL,
    "deletedFlag" INTEGER DEFAULT NULL,
    "deletedTimestamp" TEXT DEFAULT NULL,
    "accessPassword" TEXT DEFAULT NULL,
    "poolEntryId" INTEGER DEFAULT NULL,
    "portNumber" INTEGER DEFAULT NULL,
    "updatedTimestamp" TEXT DEFAULT NULL,
    FOREIGN KEY ("poolEntryId") REFERENCES "consolePoolEntries"("poolEntryId")
);

CREATE TABLE "consoleDeletionArchive" (
    "archiveId" INTEGER,
    "deletedFlag" INTEGER DEFAULT NULL,
    "instanceDisplayName" TEXT DEFAULT NULL,
    "instanceUuid" TEXT DEFAULT NULL,
    "accessPassword" TEXT DEFAULT NULL,
    "poolEntryId" INTEGER DEFAULT NULL,
    "portNumber" INTEGER DEFAULT NULL
);

CREATE TABLE "floatingIpAllocations" (
    "allocationId" INTEGER,
    "ipAddress" TEXT DEFAULT NULL,
    "autoAssignedFlag" INTEGER DEFAULT NULL,
    "deletedFlag" INTEGER DEFAULT NULL,
    "fixedIpId" INTEGER DEFAULT NULL,
    "hostName" TEXT DEFAULT NULL,
    "networkInterface" TEXT DEFAULT NULL,
    "addressPool" TEXT DEFAULT NULL,
    "projectId" TEXT DEFAULT NULL
);

CREATE TABLE "floatingIpAllocationHistory" (
    "allocationId" INTEGER,
    "ipAddress" TEXT DEFAULT NULL,
    "autoAssignedFlag" INTEGER DEFAULT NULL,
    "createdTimestamp" TEXT DEFAULT NULL,
    "deletedFlag" INTEGER DEFAULT NULL,
    "deletedTimestamp" TEXT DEFAULT NULL,
    "networkInterface" TEXT DEFAULT NULL,
    "projectId" TEXT DEFAULT NULL,
    "updatedTimestamp" TEXT DEFAULT NULL
);

CREATE TABLE "instanceGroupMembers" (
    "createdTimestamp" TEXT DEFAULT NULL,
    "updatedTimestamp" TEXT DEFAULT NULL,
    "deletedTimestamp" TEXT DEFAULT NULL,
    "deletedFlag" INTEGER DEFAULT NULL,
    "membershipId" INTEGER,
    "instanceId" TEXT DEFAULT NULL,
    "groupId" INTEGER NOT NULL
);

CREATE TABLE "serviceBinariesDeletedZeroOrOne" (
    "binaryId" INTEGER,
    "binaryName" TEXT DEFAULT NULL,
    "deletedCount" INTEGER DEFAULT NULL,
    "disabledReason" TEXT DEFAULT NULL,
    "hostName" TEXT DEFAULT NULL,
    "reportCount" INTEGER NOT NULL,
    "serviceTopic" TEXT DEFAULT NULL,
    "updatedTimestamp" TEXT DEFAULT NULL,
    "versionNumber" INTEGER DEFAULT NULL
);

CREATE TABLE "serviceBinariesDeletedGreaterThanOneUpTo139" (
    "binaryId" INTEGER,
    "binaryName" TEXT DEFAULT NULL,
    "deletedCount" INTEGER DEFAULT NULL,
    "disabledReason" TEXT DEFAULT NULL,
    "hostName" TEXT DEFAULT NULL,
    "reportCount" INTEGER NOT NULL,
    "serviceTopic" TEXT DEFAULT NULL,
    "updatedTimestamp" TEXT DEFAULT NULL,
    "versionNumber" INTEGER DEFAULT NULL
);

CREATE TABLE "serviceBinariesDeletedOver139OrNull" (
    "binaryId" INTEGER,
    "binaryName" TEXT DEFAULT NULL,
    "deletedCount" INTEGER DEFAULT NULL,
    "disabledReason" TEXT DEFAULT NULL,
    "hostName" TEXT DEFAULT NULL,
    "reportCount" INTEGER NOT NULL,
    "serviceTopic" TEXT DEFAULT NULL,
    "updatedTimestamp" TEXT DEFAULT NULL,
    "versionNumber" INTEGER DEFAULT NULL
);

CREATE TABLE "serviceStatusTimestamps" (
    "statusId" INTEGER,
    "createdTimestamp" TEXT DEFAULT NULL,
    "deletedTimestamp" TEXT DEFAULT NULL,
    "lastSeenUpTimestamp" TEXT DEFAULT NULL,
    "reportCount" INTEGER NOT NULL,
    "updatedTimestamp" TEXT DEFAULT NULL
);

CREATE TABLE "serviceDeletionRecords" (
    "recordId" INTEGER,
    "deletedFlag" INTEGER DEFAULT NULL,
    "isDisabledFlag" INTEGER DEFAULT NULL,
    "disabledReason" TEXT DEFAULT NULL,
    "forcedDownFlag" INTEGER DEFAULT NULL,
    "serviceTopic" TEXT DEFAULT NULL,
    "versionNumber" INTEGER DEFAULT NULL
);

CREATE TABLE "taskLogTimestamps" (
    "logId" INTEGER,
    "createdTimestamp" TEXT DEFAULT NULL,
    "deletedTimestamp" TEXT DEFAULT NULL,
    "updatedTimestamp" TEXT DEFAULT NULL
);

CREATE TABLE "taskLogDeletionRecords" (
    "logId" INTEGER,
    "deletedFlag" INTEGER DEFAULT NULL,
    "errorCount" INTEGER DEFAULT NULL,
    "hostName" TEXT NOT NULL,
    "messageText" TEXT NOT NULL,
    "stateName" TEXT NOT NULL,
    "taskItemCount" INTEGER DEFAULT NULL,
    "taskName" TEXT NOT NULL
);

CREATE TABLE "taskLogDeletionSummaries" (
    "summaryId" INTEGER,
    "deletedFlag" INTEGER DEFAULT NULL,
    "errorCount" INTEGER DEFAULT NULL,
    "messageText" TEXT NOT NULL,
    "periodStart" TEXT NOT NULL,
    "periodEnd" TEXT NOT NULL,
    "stateName" TEXT NOT NULL,
    "taskItemCount" INTEGER DEFAULT NULL
);

CREATE TABLE "consolePoolEntries" (
    "poolEntryId" INTEGER,
    "endpointAddress" TEXT DEFAULT NULL,
    "computeHostName" TEXT DEFAULT NULL,
    "consoleTypeName" TEXT DEFAULT NULL,
    "deletedFlag" INTEGER DEFAULT NULL,
    "localHostName" TEXT DEFAULT NULL,
    "accessPassword" TEXT DEFAULT NULL,
    "publicHostName" TEXT DEFAULT NULL,
    "accessUsername" TEXT DEFAULT NULL
);