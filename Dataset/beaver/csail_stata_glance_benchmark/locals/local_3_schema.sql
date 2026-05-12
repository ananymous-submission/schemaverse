CREATE TABLE "namespaceDefinitions" (
    "namespaceId" INTEGER,
    "namespaceKey" TEXT NOT NULL,
    "displayName" TEXT DEFAULT NULL,
    "descriptionText" TEXT,
    "visibilityPolicy" TEXT DEFAULT NULL,
    "isProtected" INTEGER DEFAULT NULL,
    "ownerName" TEXT NOT NULL,
    "createdAt" TEXT NOT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "metadataObjects" (
    "objectId" INTEGER,
    "namespaceId" INTEGER NOT NULL,
    "objectName" TEXT NOT NULL,
    "descriptionText" TEXT,
    "requiredFields" TEXT,
    "jsonSchema" TEXT NOT NULL,
    "createdAt" TEXT NOT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "metadataProperties" (
    "propertyId" INTEGER,
    "namespaceId" INTEGER NOT NULL,
    "propertyName" TEXT NOT NULL,
    "jsonSchema" TEXT NOT NULL,
    "createdAt" TEXT NOT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "metadataTags" (
    "tagId" INTEGER,
    "namespaceId" INTEGER NOT NULL,
    "tagName" TEXT NOT NULL,
    "createdAt" TEXT NOT NULL,
    "updatedAt" TEXT DEFAULT NULL,
    FOREIGN KEY ("namespaceId") REFERENCES "namespaceDefinitions"("namespaceId")
);

CREATE TABLE "namespaceResourceTypePrefixes" (
    "resourceTypeId" INTEGER,
    "namespaceId" INTEGER,
    "resourcePrefix" TEXT DEFAULT NULL,
    "propertiesTarget" TEXT DEFAULT NULL,
    FOREIGN KEY ("namespaceId") REFERENCES "namespaceDefinitions"("namespaceId")
);