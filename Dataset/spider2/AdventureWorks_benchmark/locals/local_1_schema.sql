CREATE TABLE "currencyRateUpTo1Point0684" (
    "currencyRateId" INTEGER,
    "rateDate" DATE,
    "sourceCurrencyCode" TEXT,
    "targetCurrencyCode" TEXT,
    "averageRate" FLOAT,
    "endOfDayRate" FLOAT,
    "lastModified" DATE
);

CREATE TABLE "currencyRateGreaterThan1Point0684UpTo1Point9812" (
    "currencyRateId" INTEGER,
    "rateDate" DATE,
    "sourceCurrencyCode" TEXT,
    "targetCurrencyCode" TEXT,
    "averageRate" FLOAT,
    "endOfDayRate" FLOAT,
    "lastModified" DATE
);

CREATE TABLE "currencyRateGreaterThan1Point9812UpTo8Point2871" (
    "currencyRateId" INTEGER,
    "rateDate" DATE,
    "sourceCurrencyCode" TEXT,
    "targetCurrencyCode" TEXT,
    "averageRate" FLOAT,
    "endOfDayRate" FLOAT,
    "lastModified" DATE
);

CREATE TABLE "currencyRateAbove8Point2871OrNull" (
    "currencyRateId" INTEGER,
    "rateDate" DATE,
    "sourceCurrencyCode" TEXT,
    "targetCurrencyCode" TEXT,
    "averageRate" FLOAT,
    "endOfDayRate" FLOAT,
    "lastModified" DATE
);

CREATE TABLE "productClassNoColor" (
    "productName" TEXT,
    "productClass" TEXT,
    "colorName" TEXT,
    "daysToManufacture" INTEGER,
    "finishedGoodsFlag" BOOLEAN,
    "listPrice" FLOAT,
    "makeFlag" BOOLEAN,
    "productLine" TEXT,
    "productNumber" TEXT,
    "reorderPoint" INTEGER,
    "safetyStockLevel" INTEGER,
    "productSize" TEXT,
    "standardCost" FLOAT,
    "productStyle" TEXT,
    "productWeight" FLOAT
);

CREATE TABLE "productClassBlack" (
    "productName" TEXT,
    "productClass" TEXT,
    "colorName" TEXT,
    "daysToManufacture" INTEGER,
    "finishedGoodsFlag" BOOLEAN,
    "listPrice" FLOAT,
    "makeFlag" BOOLEAN,
    "productLine" TEXT,
    "productNumber" TEXT,
    "reorderPoint" INTEGER,
    "safetyStockLevel" INTEGER,
    "productSize" TEXT,
    "standardCost" FLOAT,
    "productStyle" TEXT,
    "productWeight" FLOAT
);

CREATE TABLE "productClassNeutralAndMixedColors" (
    "productName" TEXT,
    "productClass" TEXT,
    "colorName" TEXT,
    "daysToManufacture" INTEGER,
    "finishedGoodsFlag" BOOLEAN,
    "listPrice" FLOAT,
    "makeFlag" BOOLEAN,
    "productLine" TEXT,
    "productNumber" TEXT,
    "reorderPoint" INTEGER,
    "safetyStockLevel" INTEGER,
    "productSize" TEXT,
    "standardCost" FLOAT,
    "productStyle" TEXT,
    "productWeight" FLOAT
);

CREATE TABLE "productClassWarmColors" (
    "productName" TEXT,
    "productClass" TEXT,
    "colorName" TEXT,
    "daysToManufacture" INTEGER,
    "finishedGoodsFlag" BOOLEAN,
    "listPrice" FLOAT,
    "makeFlag" BOOLEAN,
    "productLine" TEXT,
    "productNumber" TEXT,
    "reorderPoint" INTEGER,
    "safetyStockLevel" INTEGER,
    "productSize" TEXT,
    "standardCost" FLOAT,
    "productStyle" TEXT,
    "productWeight" FLOAT
);

CREATE TABLE "productLifecycleDates" (
    "productName" TEXT,
    "discontinuedDate" DATE,
    "lastModified" DATE,
    "sellEndDate" DATE,
    "sellStartDate" DATE
);

CREATE TABLE "productPricingDetails" (
    "productName" TEXT,
    "listPrice" FLOAT,
    "productSize" TEXT,
    "sizeUnitMeasureCode" TEXT,
    "standardCost" FLOAT,
    "productWeight" FLOAT,
    "weightUnitMeasureCode" TEXT
);

CREATE TABLE "productManufactureInfo" (
    "productName" TEXT,
    "daysToManufacture" INTEGER,
    "productId" INTEGER,
    "productLine" TEXT,
    "productModelId" INTEGER,
    "productNumber" TEXT,
    "productSubcategoryId" INTEGER,
    "reorderPoint" INTEGER,
    "rowGuid" TEXT,
    "safetyStockLevel" INTEGER,
    "productStyle" TEXT
);

CREATE TABLE "productCategoryMaster" (
    "productCategoryId" INTEGER,
    "categoryName" TEXT,
    "rowGuid" TEXT,
    "lastModified" DATE
);

CREATE TABLE "productDescriptionAsOf2013April30" (
    "productDescriptionId" INTEGER,
    "descriptionText" TEXT,
    "rowGuid" TEXT,
    "lastModified" DATE
);

CREATE TABLE "productDescriptionAsOf2014Feb08" (
    "productDescriptionId" INTEGER,
    "descriptionText" TEXT,
    "rowGuid" TEXT,
    "lastModified" DATE
);

CREATE TABLE "productReviewContact" (
    "reviewComments" TEXT,
    "reviewerEmail" TEXT,
    "productId" INTEGER,
    "productReviewId" INTEGER,
    "ratingScore" INTEGER,
    "reviewerName" TEXT
);

CREATE TABLE "productReviewContactWithUpdateTimestamps" (
    "reviewComments" TEXT,
    "reviewerEmail" TEXT,
    "modifiedDateUtc" DATE,
    "modifiedDateString" VARCHAR(19),
    "productReviewId" INTEGER,
    "ratingScore" INTEGER,
    "reviewDate" DATE,
    "reviewerName" TEXT
);

CREATE TABLE "productSubcategoryMaster" (
    "productSubcategoryId" INTEGER,
    "productCategoryId" INTEGER,
    "subcategoryName" TEXT,
    "rowGuid" TEXT,
    "lastModified" DATE
);