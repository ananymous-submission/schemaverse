-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/sales/sales.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "emp_rec" (
    "emp_id" INTEGER,
    "emp_fn" TEXT NOT NULL,
    "emp_mi" TEXT,
    "emp_ln" TEXT NOT NULL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "ProductCatalog" (
    "CatalogItemId" INTEGER,
    "Title" TEXT NOT NULL,
    "UnitPrice" REAL
);

CREATE TABLE "SalesQuantity253To500" (
    "SaleRecordId" INTEGER,
    "SalesRepresentativeId" INTEGER NOT NULL,
    "ClientId" INTEGER NOT NULL,
    "CatalogItemId" INTEGER NOT NULL,
    "UnitsSold" INTEGER NOT NULL,
    FOREIGN KEY ("CatalogItemId") REFERENCES "ProductCatalog"("CatalogItemId")
);

CREATE TABLE "SalesQuantity501To751" (
    "SaleRecordId" INTEGER,
    "SalesRepresentativeId" INTEGER NOT NULL,
    "ClientId" INTEGER NOT NULL,
    "CatalogItemId" INTEGER NOT NULL,
    "UnitsSold" INTEGER NOT NULL,
    FOREIGN KEY ("CatalogItemId") REFERENCES "ProductCatalog"("CatalogItemId")
);

