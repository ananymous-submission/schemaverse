CREATE TABLE "accessGrant" (
    "assignmentType" TEXT,
    "principalId" TEXT,
    "resourceId" TEXT,
    "roleId" TEXT,
    "isInherited" INTEGER
);

CREATE TABLE "roleDefinition" (
    "roleId" TEXT,
    "roleName" TEXT DEFAULT NULL,
    "metadata" TEXT,
    "domainId" TEXT NOT NULL DEFAULT '<<null>>'
);

CREATE TABLE "groupMembership" (
    "userId" TEXT,
    "groupId" TEXT
);