CREATE TABLE "Inventory_UpToQty26" (
    "InventoryRecordId" INTEGER,
    "StorageLocationId" INTEGER NOT NULL,
    "ProductRefId" INTEGER NOT NULL,
    "PurchaseReferenceId" INTEGER NOT NULL,
    "Quantity" REAL NOT NULL,
    FOREIGN KEY ("PurchaseReferenceId") REFERENCES "Purchases_Above88OrNull"("PurchaseId")
);

CREATE TABLE "Inventory_Above42OrNull" (
    "InventoryRecordId" INTEGER,
    "StorageLocationId" INTEGER NOT NULL,
    "ProductRefId" INTEGER NOT NULL,
    "PurchaseLinkId" INTEGER NOT NULL,
    "Quantity" REAL NOT NULL
);

CREATE TABLE "Purchases_UpToQty37" (
    "PurchaseId" INTEGER,
    "PurchasedAt" TEXT NOT NULL,
    "BreweryRefId" INTEGER NOT NULL,
    "ProductRefId" INTEGER NOT NULL,
    "Quantity" INTEGER NOT NULL,
    "CostAmount" REAL NOT NULL
);

CREATE TABLE "Purchases_Above88OrNull" (
    "PurchaseId" INTEGER,
    "PurchasedAt" TEXT NOT NULL,
    "BreweryRefId" INTEGER NOT NULL,
    "ProductRefId" INTEGER NOT NULL,
    "Quantity" INTEGER NOT NULL,
    "CostAmount" REAL NOT NULL
);

CREATE TABLE "ServerHeartbeatLog" (
    "ServerIdentifier" TEXT NOT NULL,
    "HeartbeatTime" TEXT NOT NULL
);