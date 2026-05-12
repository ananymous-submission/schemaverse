CREATE TABLE "BusinessAddressModifiedOnOrBefore20130209" (
    "BusinessEntityKey" INTEGER,
    "AddressKey" INTEGER,
    "AddressTypeKey" INTEGER,
    "LastModifiedAt" DATETIME NOT NULL DEFAULT current_timestamp,
    "RowGuidValue" TEXT NOT NULL
);

CREATE TABLE "BusinessAddressModifiedAfter20140210OrNull" (
    "BusinessEntityKey" INTEGER,
    "AddressKey" INTEGER,
    "AddressTypeKey" INTEGER,
    "LastModifiedAt" DATETIME NOT NULL DEFAULT current_timestamp,
    "RowGuidValue" TEXT NOT NULL
);

CREATE TABLE "ProductInventoryBinAssignment" (
    "ProductKey" INTEGER,
    "LocationKey" INTEGER,
    "BinNumber" INTEGER NOT NULL,
    "QuantityOnHand" INTEGER NOT NULL DEFAULT 0,
    "ShelfCode" TEXT NOT NULL,
    "RowGuidValue" TEXT NOT NULL
);

CREATE TABLE "ProductInventoryModifiedAfter20140809OrNull" (
    "ProductKey" INTEGER,
    "LocationKey" INTEGER,
    "InventoryModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "QuantityOnHand" INTEGER NOT NULL DEFAULT 0,
    "RowGuidValue" TEXT NOT NULL
);

CREATE TABLE "SpecialOfferCategoryCore" (
    "SpecialOfferKey" INTEGER,
    "OfferCategory" TEXT NOT NULL,
    "OfferDescription" TEXT NOT NULL,
    "DiscountPercentage" REAL NOT NULL DEFAULT 0.0000,
    "MaximumQuantity" INTEGER,
    "MinimumQuantity" INTEGER NOT NULL DEFAULT 0,
    "OfferType" TEXT NOT NULL,
    "RowGuidValue" TEXT NOT NULL
);

CREATE TABLE "SpecialOfferCategoryWithDates" (
    "SpecialOfferKey" INTEGER,
    "OfferCategory" TEXT NOT NULL,
    "OfferDescription" TEXT NOT NULL,
    "DiscountPercentage" REAL NOT NULL DEFAULT 0.0000,
    "EndAt" DATETIME NOT NULL,
    "LastModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "StartAt" DATETIME NOT NULL,
    "RowGuidValue" TEXT NOT NULL
);

CREATE TABLE "SpecialOfferProductModifiedOnOrBefore20110401" (
    "SpecialOfferKey" INTEGER,
    "ProductKey" INTEGER,
    "RowGuidValue" TEXT NOT NULL,
    "LastModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "SpecialOfferProductModifiedAfter20110501OrNull" (
    "SpecialOfferKey" INTEGER,
    "ProductKey" INTEGER,
    "RowGuidValue" TEXT NOT NULL,
    "LastModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("SpecialOfferKey") REFERENCES "SpecialOfferCategoryCore"("SpecialOfferKey"),
    FOREIGN KEY ("SpecialOfferKey") REFERENCES "SpecialOfferCategoryWithDates"("SpecialOfferKey")
);

CREATE TABLE "OrderDetailCarrierWithSplitOfferLinks" (
    "OrderDetailKey" INTEGER,
    "CarrierTrackingCode" TEXT,
    "DetailModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ProductKey" INTEGER NOT NULL,
    "SalesOrderKey" INTEGER NOT NULL,
    "SpecialOfferKey" INTEGER NOT NULL,
    "RowGuidValue" TEXT NOT NULL,
    FOREIGN KEY ("SpecialOfferKey") REFERENCES "SpecialOfferProductModifiedOnOrBefore20110401"("SpecialOfferKey"),
    FOREIGN KEY ("ProductKey") REFERENCES "SpecialOfferProductModifiedAfter20110501OrNull"("ProductKey")
);

CREATE TABLE "OrderDetailCarrierLineTotalOver25To135" (
    "OrderDetailKey" INTEGER,
    "CarrierTrackingCode" TEXT,
    "LineTotalAmount" REAL NOT NULL,
    "DetailModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "OrderQuantity" INTEGER NOT NULL,
    "ProductKey" INTEGER NOT NULL,
    "SpecialOfferKey" INTEGER NOT NULL,
    "UnitPriceAmount" REAL NOT NULL,
    "UnitPriceDiscountAmount" REAL NOT NULL DEFAULT 0.0000,
    FOREIGN KEY ("SpecialOfferKey") REFERENCES "SpecialOfferProductModifiedOnOrBefore20110401"("SpecialOfferKey")
);

CREATE TABLE "OrderDetailCarrierLineTotalOver135To1120" (
    "OrderDetailKey" INTEGER,
    "CarrierTrackingCode" TEXT,
    "LineTotalAmount" REAL NOT NULL,
    "DetailModifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "OrderQuantity" INTEGER NOT NULL,
    "ProductKey" INTEGER NOT NULL,
    "SpecialOfferKey" INTEGER NOT NULL,
    "UnitPriceAmount" REAL NOT NULL,
    "UnitPriceDiscountAmount" REAL NOT NULL DEFAULT 0.0000
);