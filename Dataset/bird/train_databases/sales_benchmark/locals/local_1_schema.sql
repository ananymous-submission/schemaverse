CREATE TABLE "customersMiddleAOrL" (
    "customerKey" INTEGER,
    "givenName" TEXT NOT NULL,
    "middleInitialCode" TEXT,
    "familyName" TEXT NOT NULL
);

CREATE TABLE "customersMiddleMOrJ" (
    "customerKey" INTEGER,
    "givenName" TEXT NOT NULL,
    "middleInitialCode" TEXT,
    "familyName" TEXT NOT NULL
);

CREATE TABLE "customersMiddleCOrDOrSOrEOrR" (
    "customerKey" INTEGER,
    "givenName" TEXT NOT NULL,
    "middleInitialCode" TEXT,
    "familyName" TEXT NOT NULL
);

CREATE TABLE "customersMiddleOther" (
    "customerKey" INTEGER,
    "givenName" TEXT NOT NULL,
    "middleInitialCode" TEXT,
    "familyName" TEXT NOT NULL
);

CREATE TABLE "salesQuantityUpTo252" (
    "saleId" INTEGER,
    "salesRepId" INTEGER NOT NULL,
    "customerKeyRef" INTEGER NOT NULL,
    "productKeyRef" INTEGER NOT NULL,
    "orderQuantity" INTEGER NOT NULL
);

CREATE TABLE "salesQuantityAbove751OrNull" (
    "saleId" INTEGER,
    "salesRepId" INTEGER NOT NULL,
    "customerKeyRef" INTEGER NOT NULL,
    "productKeyRef" INTEGER NOT NULL,
    "orderQuantity" INTEGER NOT NULL,
    FOREIGN KEY ("customerKeyRef") REFERENCES "customersMiddleAOrL"("customerKey"),
    FOREIGN KEY ("customerKeyRef") REFERENCES "customersMiddleMOrJ"("customerKey"),
    FOREIGN KEY ("customerKeyRef") REFERENCES "customersMiddleCOrDOrSOrEOrR"("customerKey")
);