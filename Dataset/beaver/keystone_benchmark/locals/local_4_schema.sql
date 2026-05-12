CREATE TABLE "projectEmptyMetadata" (
    "projectId" TEXT,
    "projectName" TEXT NOT NULL,
    "metadata" TEXT,
    "descriptionText" TEXT,
    "isEnabled" INTEGER DEFAULT NULL,
    "domainId" TEXT NOT NULL,
    "parentProjectId" TEXT DEFAULT NULL,
    "isDomainScope" INTEGER NOT NULL DEFAULT '0',
    FOREIGN KEY ("parentProjectId") REFERENCES "projectEmptyMetadata"("projectId")
);

CREATE TABLE "projectSupervisorSet" (
    "projectId" TEXT,
    "projectName" TEXT NOT NULL,
    "supervisorInfo" TEXT,
    "descriptionText" TEXT,
    "isEnabled" INTEGER DEFAULT NULL,
    "domainId" TEXT NOT NULL,
    "parentProjectId" TEXT DEFAULT NULL,
    "isDomainScope" INTEGER NOT NULL DEFAULT '0',
    FOREIGN KEY ("parentProjectId") REFERENCES "projectSupervisorSet"("projectId")
);

CREATE TABLE "projectOtherMetadata" (
    "projectId" TEXT,
    "projectName" TEXT NOT NULL,
    "metadataVariant" TEXT,
    "descriptionText" TEXT,
    "isEnabled" INTEGER DEFAULT NULL,
    "domainId" TEXT NOT NULL,
    "parentProjectId" TEXT DEFAULT NULL,
    "isDomainScope" INTEGER NOT NULL DEFAULT '0',
    FOREIGN KEY ("parentProjectId") REFERENCES "projectOtherMetadata"("projectId")
);

CREATE TABLE "accessTokenRevocationEvent" (
    "recordId" INTEGER,
    "accessTokenId" TEXT DEFAULT NULL,
    "auditChainId" TEXT DEFAULT NULL,
    "auditEventId" TEXT DEFAULT NULL,
    "consumerId" TEXT DEFAULT NULL,
    "domainId" TEXT DEFAULT NULL,
    "issuedBefore" TEXT NOT NULL,
    "projectId" TEXT DEFAULT NULL,
    "roleId" TEXT DEFAULT NULL,
    "trustId" TEXT DEFAULT NULL,
    "userId" TEXT DEFAULT NULL
);

CREATE TABLE "accessTokenRevocationTiming" (
    "timingId" INTEGER,
    "accessTokenId" TEXT DEFAULT NULL,
    "auditChainId" TEXT DEFAULT NULL,
    "auditEventId" TEXT DEFAULT NULL,
    "expiresAt" TEXT DEFAULT NULL,
    "issuedBefore" TEXT NOT NULL,
    "revokedAt" TEXT NOT NULL,
    "roleId" TEXT DEFAULT NULL
);

CREATE TABLE "trustRoleAssignment" (
    "trustId" TEXT,
    "roleId" TEXT
);