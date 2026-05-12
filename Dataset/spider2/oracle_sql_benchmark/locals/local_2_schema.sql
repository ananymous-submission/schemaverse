CREATE TABLE "packageType" (
    "packageTypeId" INTEGER,
    "displayName" TEXT NOT NULL
);

CREATE TABLE "packageComposition" (
    "containerTypeId" INTEGER,
    "containedTypeId" INTEGER,
    "quantity" INTEGER NOT NULL,
    FOREIGN KEY ("containerTypeId") REFERENCES "packageType"("packageTypeId")
);

CREATE TABLE "webPageCounterHistory" (
    "applicationId" INTEGER,
    "pageNumber" INTEGER,
    "counterDate" TEXT,
    "viewCount" INTEGER NOT NULL
);