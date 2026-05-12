CREATE TABLE "TaskDetails" (
    "TaskIdentifier" TEXT,
    "InputPayload" TEXT,
    "OutputResult" TEXT,
    "StatusMessage" TEXT
);

CREATE TABLE "TaskLifecycle" (
    "LifecycleId" TEXT,
    "CreationTimestamp" TEXT NOT NULL,
    "IsDeleted" INTEGER NOT NULL,
    "DeletionTimestamp" TEXT DEFAULT NULL,
    "ExpirationTimestamp" TEXT DEFAULT NULL,
    "OwnerIdentifier" TEXT NOT NULL,
    "TaskCategory" TEXT NOT NULL,
    "ModificationTimestamp" TEXT DEFAULT NULL
);

CREATE TABLE "TaskDeletionLog" (
    "DeletionRecordId" TEXT,
    "WasDeleted" INTEGER NOT NULL,
    "ExpirationTimestamp" TEXT DEFAULT NULL,
    "OwnerIdentifier" TEXT NOT NULL,
    "DeletionStatus" TEXT NOT NULL,
    "TaskCategory" TEXT NOT NULL
);