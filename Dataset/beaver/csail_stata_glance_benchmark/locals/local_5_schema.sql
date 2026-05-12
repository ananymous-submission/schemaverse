CREATE TABLE "imageShareForMember09ad0543" (
    "shareId" INTEGER,
    "isShareable" INTEGER NOT NULL,
    "isDeleted" INTEGER NOT NULL,
    "imageId" TEXT NOT NULL,
    "memberId" TEXT NOT NULL,
    "shareStatus" TEXT NOT NULL DEFAULT 'pending',
    "lastUpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "imageShareForOtherMembers" (
    "shareId" INTEGER,
    "isShareable" INTEGER NOT NULL,
    "isDeleted" INTEGER NOT NULL,
    "imageId" TEXT NOT NULL,
    "memberId" TEXT NOT NULL,
    "shareStatus" TEXT NOT NULL DEFAULT 'pending',
    "lastUpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "migrationRepositoryVersion" (
    "repositoryId" TEXT,
    "repositoryPath" TEXT,
    "schemaVersion" INTEGER DEFAULT NULL
);