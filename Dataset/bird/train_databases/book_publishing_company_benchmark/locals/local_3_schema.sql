CREATE TABLE "TieredDiscounts" (
    "DiscountCategory" TEXT NOT NULL,
    "OutletId" TEXT,
    "MinimumQuantity" INTEGER,
    "MaximumQuantity" INTEGER,
    "DiscountRate" REAL NOT NULL,
    FOREIGN KEY ("OutletId") REFERENCES "RetailOutlets"("OutletId")
);

CREATE TABLE "RetailOutlets" (
    "OutletId" TEXT,
    "OutletName" TEXT,
    "AddressLine" TEXT,
    "CityName" TEXT,
    "StateCode" TEXT,
    "PostalCode" TEXT
);