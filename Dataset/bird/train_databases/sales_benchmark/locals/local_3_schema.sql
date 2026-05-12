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