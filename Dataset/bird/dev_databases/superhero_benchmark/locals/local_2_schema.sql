CREATE TABLE "attributeType" (
    "attributeTypeId" INTEGER,
    "attributeLabel" TEXT DEFAULT NULL
);

CREATE TABLE "heroAttributeAssignment" (
    "heroId" INTEGER DEFAULT NULL,
    "attributeTypeId" INTEGER DEFAULT NULL,
    "attributeValue" INTEGER DEFAULT NULL
);