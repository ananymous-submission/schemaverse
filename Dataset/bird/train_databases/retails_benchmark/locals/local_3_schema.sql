CREATE TABLE "partSupplyAvailAtMost2508" (
    "partId" INTEGER,
    "supplierId" INTEGER,
    "supplyCost" REAL NOT NULL,
    "availableQuantity" INTEGER,
    "supplyComment" TEXT,
    FOREIGN KEY ("partId") REFERENCES "partOtherBrandsOrNull"("partId")
);

CREATE TABLE "partSupplyAvailAbove7498OrNull" (
    "partId" INTEGER,
    "supplierId" INTEGER,
    "supplyCost" REAL NOT NULL,
    "availableQuantity" INTEGER,
    "supplyComment" TEXT,
    FOREIGN KEY ("partId") REFERENCES "partOtherBrandsOrNull"("partId")
);

CREATE TABLE "supplierDirectory" (
    "supplierId" INTEGER,
    "nationId" INTEGER,
    "supplierComment" TEXT,
    "supplierName" TEXT,
    "supplierAddress" TEXT,
    "supplierPhone" TEXT,
    "accountBalance" REAL
);

CREATE TABLE "partIncludedBrands14And55And52And44" (
    "partId" INTEGER,
    "brandName" TEXT,
    "commentText" TEXT,
    "containerType" TEXT,
    "manufacturer" TEXT,
    "partName" TEXT,
    "retailPrice" REAL,
    "size" INTEGER
);

CREATE TABLE "partOtherBrandsOrNull" (
    "partId" INTEGER,
    "brandName" TEXT,
    "commentText" TEXT,
    "containerType" TEXT,
    "manufacturer" TEXT,
    "partName" TEXT,
    "retailPrice" REAL,
    "size" INTEGER
);

CREATE TABLE "lineItemStatusShipping" (
    "orderId" INTEGER,
    "lineNumber" INTEGER,
    "commentText" TEXT,
    "lineStatus" TEXT,
    "quantity" INTEGER NOT NULL,
    "returnFlag" TEXT,
    "shippingInstruction" TEXT,
    "shippingMode" TEXT
);

CREATE TABLE "lineItemPricing" (
    "orderId" INTEGER,
    "lineNumber" INTEGER,
    "discountRate" REAL NOT NULL,
    "extendedPrice" REAL NOT NULL,
    "taxAmount" REAL NOT NULL
);