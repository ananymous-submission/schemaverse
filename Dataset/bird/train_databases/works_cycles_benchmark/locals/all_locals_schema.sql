-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/works_cycles/works_cycles.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "addressForSelectedCities" (
    "addressId" INTEGER,
    "streetLine1" TEXT NOT NULL,
    "streetLine2" TEXT,
    "cityName" TEXT NOT NULL,
    "stateProvinceId" INTEGER NOT NULL,
    "postalCode" TEXT NOT NULL,
    "spatialLocation" TEXT,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "addressTypeRef" (
    "addressTypeId" INTEGER,
    "displayName" TEXT NOT NULL,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "businessEntityModifiedBefore20171213" (
    "businessEntityId" INTEGER,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "businessEntityModifiedAfter20171213OrNull" (
    "businessEntityId" INTEGER,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "contactTypeRef" (
    "contactTypeId" INTEGER,
    "displayName" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "countryRegionRef" (
    "countryRegionCode" TEXT,
    "displayName" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "creditCardExpMonthLow" (
    "creditCardId" INTEGER,
    "cardType" TEXT NOT NULL,
    "cardNumber" TEXT NOT NULL,
    "expMonth" INTEGER NOT NULL,
    "expYear" INTEGER NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "creditCardExpMonthHighOrNull" (
    "creditCardId" INTEGER,
    "cardType" TEXT NOT NULL,
    "cardNumber" TEXT NOT NULL,
    "expMonth" INTEGER NOT NULL,
    "expYear" INTEGER NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "cultureRef" (
    "cultureId" TEXT,
    "displayName" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "currencyRef" (
    "currencyCode" TEXT,
    "displayName" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "customerRecord" (
    "customerId" INTEGER,
    "personId" INTEGER,
    "storeId" INTEGER,
    "territoryId" INTEGER,
    "accountNumber" TEXT NOT NULL,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY ("storeId") REFERENCES "storeInfo"("businessEntityId"),
    FOREIGN KEY ("territoryId") REFERENCES "salesTerritoryCostsLastYear"("territoryId")
);

CREATE TABLE "departmentRef" (
    "departmentId" INTEGER,
    "displayName" TEXT NOT NULL,
    "groupName" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "documentRepository" (
    "documentKey" TEXT,
    "documentData" BLOB,
    "documentLevel" INTEGER,
    "documentSummary" TEXT,
    "fileExtension" TEXT NOT NULL,
    "fileName" TEXT NOT NULL,
    "folderFlag" INTEGER NOT NULL DEFAULT 0,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp,
    "statusCode" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "rowGuid" TEXT NOT NULL
);

CREATE TABLE "emailAddressModifiedBefore20121212" (
    "businessEntityId" INTEGER,
    "emailAddressId" INTEGER,
    "emailAddress" TEXT,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY ("businessEntityId") REFERENCES "personAdditionalContactAfterJan302014OrNull"("businessEntityId")
);

CREATE TABLE "emailAddressModifiedDec2012ToSep2013" (
    "businessEntityId" INTEGER,
    "emailAddressId" INTEGER,
    "emailAddress" TEXT,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY ("businessEntityId") REFERENCES "personAdditionalContactBefore20121212"("businessEntityId"),
    FOREIGN KEY ("businessEntityId") REFERENCES "personAdditionalContactAfterJan302014OrNull"("businessEntityId")
);

CREATE TABLE "emailAddressModifiedSep2013ToJan2014" (
    "businessEntityId" INTEGER,
    "emailAddressId" INTEGER,
    "emailAddress" TEXT,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "emailAddressModifiedAfterJan302014OrNull" (
    "businessEntityId" INTEGER,
    "emailAddressId" INTEGER,
    "emailAddress" TEXT,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY ("businessEntityId") REFERENCES "personAdditionalContactAfterJan302014OrNull"("businessEntityId")
);

CREATE TABLE "employeeCurrentFlags" (
    "businessEntityId" INTEGER,
    "currentFlag" INTEGER NOT NULL DEFAULT 1,
    "gender" TEXT NOT NULL,
    "jobTitle" TEXT NOT NULL,
    "loginId" TEXT NOT NULL,
    "maritalStatus" TEXT NOT NULL,
    "salariedFlag" INTEGER NOT NULL DEFAULT 1,
    "sickLeaveHours" INTEGER NOT NULL DEFAULT 0,
    "vacationHours" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("businessEntityId") REFERENCES "personAdditionalContactAfterJan302014OrNull"("businessEntityId")
);

CREATE TABLE "locationRef" (
    "locationId" INTEGER,
    "locationName" TEXT NOT NULL,
    "costRate" REAL NOT NULL DEFAULT 0.0000,
    "availability" REAL NOT NULL DEFAULT 0.00,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "passwordModifiedBefore20121212" (
    "businessEntityId" INTEGER,
    "passwordHash" TEXT NOT NULL,
    "passwordSalt" TEXT NOT NULL,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "passwordModifiedDec2012ToSep2013" (
    "businessEntityId" INTEGER,
    "passwordHash" TEXT NOT NULL,
    "passwordSalt" TEXT NOT NULL,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "passwordModifiedSep2013ToJan302014" (
    "businessEntityId" INTEGER,
    "passwordHash" TEXT NOT NULL,
    "passwordSalt" TEXT NOT NULL,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "passwordModifiedAfterJan302014OrNull" (
    "businessEntityId" INTEGER,
    "passwordHash" TEXT NOT NULL,
    "passwordSalt" TEXT NOT NULL,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "personAdditionalContactBefore20121212" (
    "businessEntityId" INTEGER,
    "additionalContactInfo" TEXT,
    "demographics" TEXT,
    "emailPromotion" INTEGER NOT NULL DEFAULT 0,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp,
    "nameStyle" INTEGER NOT NULL DEFAULT 0,
    "personType" TEXT NOT NULL,
    "suffix" TEXT,
    "title" TEXT,
    "rowGuid" TEXT NOT NULL,
    FOREIGN KEY ("businessEntityId") REFERENCES "businessEntityModifiedBefore20171213"("businessEntityId"),
    FOREIGN KEY ("businessEntityId") REFERENCES "businessEntityModifiedAfter20171213OrNull"("businessEntityId")
);

CREATE TABLE "personAdditionalContactAfterJan302014OrNull" (
    "businessEntityId" INTEGER,
    "additionalContactInfo" TEXT,
    "demographics" TEXT,
    "emailPromotion" INTEGER NOT NULL DEFAULT 0,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp,
    "nameStyle" INTEGER NOT NULL DEFAULT 0,
    "personType" TEXT NOT NULL,
    "suffix" TEXT,
    "title" TEXT,
    "rowGuid" TEXT NOT NULL,
    FOREIGN KEY ("businessEntityId") REFERENCES "businessEntityModifiedAfter20171213OrNull"("businessEntityId")
);

CREATE TABLE "productDetails" (
    "productId" INTEGER,
    "productClass" TEXT,
    "color" TEXT,
    "listPrice" REAL NOT NULL,
    "productName" TEXT NOT NULL,
    "productLine" TEXT,
    "productModelId" INTEGER,
    "productNumber" TEXT NOT NULL,
    "productSubcategoryId" INTEGER,
    "reorderPoint" INTEGER NOT NULL,
    "safetyStockLevel" INTEGER NOT NULL,
    "size" TEXT,
    "standardCost" REAL NOT NULL,
    "style" TEXT,
    "rowGuid" TEXT NOT NULL
);

CREATE TABLE "productDaysToManufactureZeroOrLess" (
    "productId" INTEGER,
    "daysToManufacture" INTEGER NOT NULL,
    "finishedGoodsFlag" INTEGER NOT NULL DEFAULT 1,
    "makeFlag" INTEGER NOT NULL DEFAULT 1
);

CREATE TABLE "productDaysToManufactureOne" (
    "productId" INTEGER,
    "daysToManufacture" INTEGER NOT NULL,
    "finishedGoodsFlag" INTEGER NOT NULL DEFAULT 1,
    "makeFlag" INTEGER NOT NULL DEFAULT 1
);

CREATE TABLE "productDaysToManufactureGreaterOneOrNull" (
    "productId" INTEGER,
    "daysToManufacture" INTEGER NOT NULL,
    "finishedGoodsFlag" INTEGER NOT NULL DEFAULT 1,
    "makeFlag" INTEGER NOT NULL DEFAULT 1
);

CREATE TABLE "productDiscontinuedDates" (
    "productId" INTEGER,
    "discontinuedDate" DATETIME,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp,
    "sellEndDate" DATETIME,
    "sellStartDate" DATETIME NOT NULL
);

CREATE TABLE "productCategoryRef" (
    "productCategoryId" INTEGER,
    "displayName" TEXT NOT NULL,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "productCostHistoryLowCost" (
    "productId" INTEGER,
    "startDate" DATE,
    "endDate" DATE,
    "standardCost" REAL NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureOne"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureGreaterOneOrNull"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDiscontinuedDates"("productId")
);

CREATE TABLE "productCostHistorySecondQuartile" (
    "productId" INTEGER,
    "startDate" DATE,
    "endDate" DATE,
    "standardCost" REAL NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureOne"("productId")
);

CREATE TABLE "productCostHistoryThirdQuartile" (
    "productId" INTEGER,
    "startDate" DATE,
    "endDate" DATE,
    "standardCost" REAL NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("productId") REFERENCES "productDetails"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureZeroOrLess"("productId")
);

CREATE TABLE "productCostHistoryHighOrNull" (
    "productId" INTEGER,
    "startDate" DATE,
    "endDate" DATE,
    "standardCost" REAL NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureZeroOrLess"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureOne"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureGreaterOneOrNull"("productId")
);

CREATE TABLE "productListPriceLowQuartile" (
    "productId" INTEGER,
    "startDate" DATE,
    "endDate" DATE,
    "listPrice" REAL NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("productId") REFERENCES "productDetails"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureZeroOrLess"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureOne"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDiscontinuedDates"("productId")
);

CREATE TABLE "productListPriceSecondQuartile" (
    "productId" INTEGER,
    "startDate" DATE,
    "endDate" DATE,
    "listPrice" REAL NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureOne"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDiscontinuedDates"("productId")
);

CREATE TABLE "productListPriceThirdQuartile" (
    "productId" INTEGER,
    "startDate" DATE,
    "endDate" DATE,
    "listPrice" REAL NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureZeroOrLess"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureOne"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDiscontinuedDates"("productId")
);

CREATE TABLE "productListPriceHighOrNull" (
    "productId" INTEGER,
    "startDate" DATE,
    "endDate" DATE,
    "listPrice" REAL NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("productId") REFERENCES "productDetails"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureOne"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureGreaterOneOrNull"("productId")
);

CREATE TABLE "productModelOlderModifiedBefore20120430" (
    "productModelId" INTEGER,
    "modelName" TEXT NOT NULL,
    "catalogDescription" TEXT,
    "instructions" TEXT,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "productReview" (
    "productReviewId" INTEGER,
    "productId" INTEGER NOT NULL,
    "reviewerName" TEXT NOT NULL,
    "reviewDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "emailAddress" TEXT NOT NULL,
    "rating" INTEGER NOT NULL,
    "comments" TEXT,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureOne"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureGreaterOneOrNull"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDiscontinuedDates"("productId")
);

CREATE TABLE "productSubcategoryRef" (
    "productSubcategoryId" INTEGER,
    "productCategoryId" INTEGER NOT NULL,
    "displayName" TEXT NOT NULL,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("productCategoryId") REFERENCES "productCategoryRef"("productCategoryId")
);

CREATE TABLE "purchaseOrderDetailDueDate" (
    "purchaseOrderDetailId" INTEGER,
    "dueDate" DATETIME NOT NULL,
    "lineTotal" REAL NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "orderQty" INTEGER NOT NULL,
    "unitPrice" REAL NOT NULL
);

CREATE TABLE "purchaseOrderDetailLineTotal" (
    "purchaseOrderDetailId" INTEGER,
    "lineTotal" REAL NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "orderQty" INTEGER NOT NULL,
    "productId" INTEGER NOT NULL,
    "purchaseOrderId" INTEGER NOT NULL,
    "unitPrice" REAL NOT NULL,
    FOREIGN KEY ("productId") REFERENCES "productDetails"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureGreaterOneOrNull"("productId"),
    FOREIGN KEY ("purchaseOrderId") REFERENCES "purchaseOrderHeaderModifiedBefore20131015"("purchaseOrderId")
);

CREATE TABLE "purchaseOrderDetailReceivedQtyLow" (
    "purchaseOrderDetailId" INTEGER,
    "receivedQty" REAL NOT NULL,
    "rejectedQty" REAL NOT NULL,
    "stockedQty" REAL NOT NULL
);

CREATE TABLE "purchaseOrderDetailReceivedQtyMixed" (
    "purchaseOrderDetailId" INTEGER,
    "receivedQty" REAL NOT NULL,
    "rejectedQty" REAL NOT NULL,
    "stockedQty" REAL NOT NULL
);

CREATE TABLE "purchaseOrderHeaderByEmployee" (
    "purchaseOrderId" INTEGER,
    "employeeId" INTEGER NOT NULL,
    "freight" REAL NOT NULL DEFAULT 0.0000,
    "shipMethodId" INTEGER NOT NULL,
    "status" INTEGER NOT NULL DEFAULT 1,
    "subTotal" REAL NOT NULL DEFAULT 0.0000,
    "taxAmount" REAL NOT NULL DEFAULT 0.0000,
    "vendorId" INTEGER NOT NULL,
    FOREIGN KEY ("vendorId") REFERENCES "vendorModifiedAfter20120202OrNull"("businessEntityId"),
    FOREIGN KEY ("employeeId") REFERENCES "employeeCurrentFlags"("businessEntityId")
);

CREATE TABLE "purchaseOrderHeaderFreightInfo" (
    "purchaseOrderId" INTEGER,
    "freight" REAL NOT NULL DEFAULT 0.0000,
    "revisionNumber" INTEGER NOT NULL DEFAULT 0,
    "status" INTEGER NOT NULL DEFAULT 1,
    "subTotal" REAL NOT NULL DEFAULT 0.0000,
    "taxAmount" REAL NOT NULL DEFAULT 0.0000,
    "totalDue" REAL NOT NULL
);

CREATE TABLE "purchaseOrderHeaderModifiedBefore20131015" (
    "purchaseOrderId" INTEGER,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "orderDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "revisionNumber" INTEGER NOT NULL DEFAULT 0,
    "shipDate" DATETIME
);

CREATE TABLE "purchaseOrderHeaderModifiedOct2013ToFeb2014" (
    "purchaseOrderId" INTEGER,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "orderDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "revisionNumber" INTEGER NOT NULL DEFAULT 0,
    "shipDate" DATETIME
);

CREATE TABLE "purchaseOrderHeaderModifiedFebToMay2014" (
    "purchaseOrderId" INTEGER,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "orderDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "revisionNumber" INTEGER NOT NULL DEFAULT 0,
    "shipDate" DATETIME
);

CREATE TABLE "purchaseOrderHeaderModifiedAfterMay302014OrNull" (
    "purchaseOrderId" INTEGER,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "orderDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "revisionNumber" INTEGER NOT NULL DEFAULT 0,
    "shipDate" DATETIME
);

CREATE TABLE "salesOrderDetailLowLineTotal" (
    "salesOrderDetailId" INTEGER,
    "carrierTrackingNumber" TEXT,
    "lineTotal" REAL NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "orderQty" INTEGER NOT NULL,
    "productId" INTEGER NOT NULL,
    "specialOfferId" INTEGER NOT NULL,
    "unitPrice" REAL NOT NULL,
    "unitPriceDiscount" REAL NOT NULL DEFAULT 0.0000,
    FOREIGN KEY ("specialOfferId") REFERENCES "specialOfferProductApr2011Mid"("specialOfferId")
);

CREATE TABLE "salesOrderDetailHighLineTotalOrNull" (
    "salesOrderDetailId" INTEGER,
    "carrierTrackingNumber" TEXT,
    "lineTotal" REAL NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "orderQty" INTEGER NOT NULL,
    "productId" INTEGER NOT NULL,
    "specialOfferId" INTEGER NOT NULL,
    "unitPrice" REAL NOT NULL,
    "unitPriceDiscount" REAL NOT NULL DEFAULT 0.0000
);

CREATE TABLE "salesOrderHeaderWithAccount" (
    "salesOrderId" INTEGER,
    "accountNumber" TEXT,
    "comment" TEXT,
    "creditCardApprovalCode" TEXT,
    "currencyRateId" INTEGER,
    "customerId" INTEGER NOT NULL,
    "onlineOrderFlag" INTEGER NOT NULL DEFAULT 1,
    "purchaseOrderNumber" TEXT,
    "revisionNumber" INTEGER NOT NULL DEFAULT 0,
    "salesOrderNumber" TEXT NOT NULL,
    "status" INTEGER NOT NULL DEFAULT 1,
    "territoryId" INTEGER,
    "rowGuid" TEXT NOT NULL
);

CREATE TABLE "salesOrderHeaderFullDetails" (
    "salesOrderId" INTEGER,
    "accountNumber" TEXT,
    "billToAddressId" INTEGER NOT NULL,
    "comment" TEXT,
    "creditCardApprovalCode" TEXT,
    "creditCardId" INTEGER,
    "currencyRateId" INTEGER,
    "customerId" INTEGER NOT NULL,
    "freight" REAL NOT NULL DEFAULT 0.0000,
    "onlineOrderFlag" INTEGER NOT NULL DEFAULT 1,
    "salesPersonId" INTEGER,
    "shipMethodId" INTEGER NOT NULL,
    "shipToAddressId" INTEGER NOT NULL,
    "status" INTEGER NOT NULL DEFAULT 1,
    "territoryId" INTEGER,
    "rowGuid" TEXT NOT NULL
);

CREATE TABLE "salesTaxRateRef" (
    "salesTaxRateId" INTEGER,
    "stateProvinceId" INTEGER NOT NULL,
    "taxType" INTEGER NOT NULL,
    "taxRate" REAL NOT NULL DEFAULT 0.0000,
    "taxName" TEXT NOT NULL,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("stateProvinceId") REFERENCES "stateProvinceFixedModified20080430"("stateProvinceId"),
    FOREIGN KEY ("stateProvinceId") REFERENCES "stateProvinceModifiedDateInfo"("stateProvinceId")
);

CREATE TABLE "salesTerritoryCostsLastYear" (
    "territoryId" INTEGER,
    "costLastYear" REAL NOT NULL DEFAULT 0.0000,
    "costYearToDate" REAL NOT NULL DEFAULT 0.0000,
    "countryRegionCode" TEXT NOT NULL,
    "territoryGroup" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "salesLastYear" REAL NOT NULL DEFAULT 0.0000,
    "salesYearToDate" REAL NOT NULL DEFAULT 0.0000,
    "rowGuid" TEXT NOT NULL,
    FOREIGN KEY ("countryRegionCode") REFERENCES "countryRegionRef"("countryRegionCode")
);

CREATE TABLE "scrapReasonRef" (
    "scrapReasonId" INTEGER,
    "displayName" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "shipMethodRef" (
    "shipMethodId" INTEGER,
    "displayName" TEXT NOT NULL,
    "shipBase" REAL NOT NULL DEFAULT 0.0000,
    "shipRate" REAL NOT NULL DEFAULT 0.0000,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "stateProvinceFixedModified20080430" (
    "stateProvinceId" INTEGER,
    "countryRegionCode" TEXT NOT NULL,
    "isOnlyStateProvinceFlag" INTEGER NOT NULL DEFAULT 1,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,
    "stateProvinceCode" TEXT NOT NULL,
    "territoryId" INTEGER NOT NULL
);

CREATE TABLE "stateProvinceModified20140208OrNull" (
    "stateProvinceId" INTEGER,
    "countryRegionCode" TEXT NOT NULL,
    "isOnlyStateProvinceFlag" INTEGER NOT NULL DEFAULT 1,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,
    "stateProvinceCode" TEXT NOT NULL,
    "territoryId" INTEGER NOT NULL
);

CREATE TABLE "stateProvinceModifiedDateInfo" (
    "stateProvinceId" INTEGER,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,
    "territoryId" INTEGER NOT NULL,
    "rowGuid" TEXT NOT NULL
);

CREATE TABLE "storeInfo" (
    "businessEntityId" INTEGER,
    "storeName" TEXT NOT NULL,
    "salesPersonId" INTEGER,
    "demographics" TEXT,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("businessEntityId") REFERENCES "businessEntityModifiedBefore20171213"("businessEntityId")
);

CREATE TABLE "transactionHistoryActualCostNonPositive" (
    "transactionId" INTEGER,
    "productId" INTEGER NOT NULL,
    "referenceOrderId" INTEGER NOT NULL,
    "referenceOrderLineId" INTEGER NOT NULL DEFAULT 0,
    "transactionDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "transactionType" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "actualCost" REAL NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("productId") REFERENCES "productDetails"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureZeroOrLess"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureOne"("productId")
);

CREATE TABLE "transactionHistoryActualCostRange0To21" (
    "transactionId" INTEGER,
    "productId" INTEGER NOT NULL,
    "referenceOrderId" INTEGER NOT NULL,
    "referenceOrderLineId" INTEGER NOT NULL DEFAULT 0,
    "transactionDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "transactionType" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "actualCost" REAL NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureZeroOrLess"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureOne"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureGreaterOneOrNull"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDiscontinuedDates"("productId")
);

CREATE TABLE "transactionHistoryActualCostRange21To54" (
    "transactionId" INTEGER,
    "productId" INTEGER NOT NULL,
    "referenceOrderId" INTEGER NOT NULL,
    "referenceOrderLineId" INTEGER NOT NULL DEFAULT 0,
    "transactionDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "transactionType" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "actualCost" REAL NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureZeroOrLess"("productId")
);

CREATE TABLE "transactionHistoryActualCostHighOrNull" (
    "transactionId" INTEGER,
    "productId" INTEGER NOT NULL,
    "referenceOrderId" INTEGER NOT NULL,
    "referenceOrderLineId" INTEGER NOT NULL DEFAULT 0,
    "transactionDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "transactionType" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "actualCost" REAL NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("productId") REFERENCES "productDetails"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureOne"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureGreaterOneOrNull"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDiscontinuedDates"("productId")
);

CREATE TABLE "unitMeasureRef" (
    "unitMeasureCode" TEXT,
    "displayName" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "vendorModifiedBefore20111224" (
    "businessEntityId" INTEGER,
    "accountNumber" TEXT NOT NULL,
    "vendorName" TEXT NOT NULL,
    "creditRating" INTEGER NOT NULL,
    "preferredVendorStatus" INTEGER NOT NULL DEFAULT 1,
    "activeFlag" INTEGER NOT NULL DEFAULT 1,
    "purchasingWebServiceUrl" TEXT,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "vendorModifiedAfter20120202OrNull" (
    "businessEntityId" INTEGER,
    "accountNumber" TEXT NOT NULL,
    "vendorName" TEXT NOT NULL,
    "creditRating" INTEGER NOT NULL,
    "preferredVendorStatus" INTEGER NOT NULL DEFAULT 1,
    "activeFlag" INTEGER NOT NULL DEFAULT 1,
    "purchasingWebServiceUrl" TEXT,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("businessEntityId") REFERENCES "businessEntityModifiedBefore20171213"("businessEntityId"),
    FOREIGN KEY ("businessEntityId") REFERENCES "businessEntityModifiedAfter20171213OrNull"("businessEntityId")
);

CREATE TABLE "workOrderDueDateBefore20120722" (
    "workOrderId" INTEGER,
    "dueDate" DATETIME NOT NULL,
    "endDate" DATETIME,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "productId" INTEGER NOT NULL,
    "scrapReasonId" INTEGER,
    "startDate" DATETIME NOT NULL,
    "stockedQty" INTEGER NOT NULL,
    FOREIGN KEY ("scrapReasonId") REFERENCES "scrapReasonRef"("scrapReasonId"),
    FOREIGN KEY ("productId") REFERENCES "productDetails"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureOne"("productId")
);

CREATE TABLE "workOrderDueDate20120722To20130608" (
    "workOrderId" INTEGER,
    "dueDate" DATETIME NOT NULL,
    "endDate" DATETIME,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "productId" INTEGER NOT NULL,
    "scrapReasonId" INTEGER,
    "startDate" DATETIME NOT NULL,
    "stockedQty" INTEGER NOT NULL,
    FOREIGN KEY ("productId") REFERENCES "productDiscontinuedDates"("productId")
);

CREATE TABLE "workOrderDueDate20130608To20131221" (
    "workOrderId" INTEGER,
    "dueDate" DATETIME NOT NULL,
    "endDate" DATETIME,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "productId" INTEGER NOT NULL,
    "scrapReasonId" INTEGER,
    "startDate" DATETIME NOT NULL,
    "stockedQty" INTEGER NOT NULL,
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureZeroOrLess"("productId")
);

CREATE TABLE "workOrderDueDateAfter20131221OrNull" (
    "workOrderId" INTEGER,
    "dueDate" DATETIME NOT NULL,
    "endDate" DATETIME,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "productId" INTEGER NOT NULL,
    "scrapReasonId" INTEGER,
    "startDate" DATETIME NOT NULL,
    "stockedQty" INTEGER NOT NULL,
    FOREIGN KEY ("scrapReasonId") REFERENCES "scrapReasonRef"("scrapReasonId"),
    FOREIGN KEY ("productId") REFERENCES "productDiscontinuedDates"("productId")
);

CREATE TABLE "workOrderDueDateDetails" (
    "workOrderId" INTEGER,
    "dueDate" DATETIME NOT NULL,
    "orderQty" INTEGER NOT NULL,
    "productId" INTEGER NOT NULL,
    "scrapReasonId" INTEGER,
    "scrappedQty" INTEGER NOT NULL,
    "stockedQty" INTEGER NOT NULL,
    FOREIGN KEY ("scrapReasonId") REFERENCES "scrapReasonRef"("scrapReasonId"),
    FOREIGN KEY ("productId") REFERENCES "productDetails"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureZeroOrLess"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureGreaterOneOrNull"("productId")
);

CREATE TABLE "workOrderRoutingActualCostEndDateBefore20120926" (
    "workOrderId" INTEGER,
    "productId" INTEGER,
    "operationSequence" INTEGER,
    "actualCost" REAL,
    "actualEndDate" DATETIME,
    "actualStartDate" DATETIME,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "plannedCost" REAL NOT NULL,
    "scheduledStartDate" DATETIME NOT NULL,
    FOREIGN KEY ("workOrderId") REFERENCES "workOrderDueDateBefore20120722"("workOrderId"),
    FOREIGN KEY ("workOrderId") REFERENCES "workOrderDueDate20130608To20131221"("workOrderId")
);

CREATE TABLE "workOrderRoutingActualCostEndDate20120926To20130719" (
    "workOrderId" INTEGER,
    "productId" INTEGER,
    "operationSequence" INTEGER,
    "actualCost" REAL,
    "actualEndDate" DATETIME,
    "actualStartDate" DATETIME,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "plannedCost" REAL NOT NULL,
    "scheduledStartDate" DATETIME NOT NULL,
    FOREIGN KEY ("workOrderId") REFERENCES "workOrderDueDateBefore20120722"("workOrderId"),
    FOREIGN KEY ("workOrderId") REFERENCES "workOrderDueDate20120722To20130608"("workOrderId"),
    FOREIGN KEY ("workOrderId") REFERENCES "workOrderDueDateAfter20131221OrNull"("workOrderId")
);

CREATE TABLE "workOrderRoutingActualCostEndDate20130719To20140112" (
    "workOrderId" INTEGER,
    "productId" INTEGER,
    "operationSequence" INTEGER,
    "actualCost" REAL,
    "actualEndDate" DATETIME,
    "actualStartDate" DATETIME,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "plannedCost" REAL NOT NULL,
    "scheduledStartDate" DATETIME NOT NULL,
    FOREIGN KEY ("workOrderId") REFERENCES "workOrderDueDateBefore20120722"("workOrderId"),
    FOREIGN KEY ("workOrderId") REFERENCES "workOrderDueDateDetails"("workOrderId")
);

CREATE TABLE "workOrderRoutingActualCostEndDateAfter20140112OrNull" (
    "workOrderId" INTEGER,
    "productId" INTEGER,
    "operationSequence" INTEGER,
    "actualCost" REAL,
    "actualEndDate" DATETIME,
    "actualStartDate" DATETIME,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "plannedCost" REAL NOT NULL,
    "scheduledStartDate" DATETIME NOT NULL,
    FOREIGN KEY ("workOrderId") REFERENCES "workOrderDueDate20120722To20130608"("workOrderId"),
    FOREIGN KEY ("workOrderId") REFERENCES "workOrderDueDate20130608To20131221"("workOrderId"),
    FOREIGN KEY ("workOrderId") REFERENCES "workOrderDueDateDetails"("workOrderId")
);

CREATE TABLE "workOrderRoutingActualEndDateInfo" (
    "workOrderId" INTEGER,
    "productId" INTEGER,
    "operationSequence" INTEGER,
    "actualEndDate" DATETIME,
    "actualStartDate" DATETIME,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "scheduledEndDate" DATETIME NOT NULL,
    "scheduledStartDate" DATETIME NOT NULL,
    FOREIGN KEY ("workOrderId") REFERENCES "workOrderDueDate20120722To20130608"("workOrderId"),
    FOREIGN KEY ("workOrderId") REFERENCES "workOrderDueDateAfter20131221OrNull"("workOrderId")
);

CREATE TABLE "workOrderRoutingActualResourceHours" (
    "workOrderId" INTEGER,
    "productId" INTEGER,
    "operationSequence" INTEGER,
    "actualResourceHours" REAL,
    FOREIGN KEY ("workOrderId") REFERENCES "workOrderDueDateBefore20120722"("workOrderId"),
    FOREIGN KEY ("workOrderId") REFERENCES "workOrderDueDate20130608To20131221"("workOrderId"),
    FOREIGN KEY ("workOrderId") REFERENCES "workOrderDueDateAfter20131221OrNull"("workOrderId"),
    FOREIGN KEY ("workOrderId") REFERENCES "workOrderDueDateDetails"("workOrderId")
);

CREATE TABLE "workOrderRoutingLocation" (
    "workOrderId" INTEGER,
    "productId" INTEGER,
    "operationSequence" INTEGER,
    "locationId" INTEGER NOT NULL,
    FOREIGN KEY ("locationId") REFERENCES "locationRef"("locationId"),
    FOREIGN KEY ("workOrderId") REFERENCES "workOrderDueDate20120722To20130608"("workOrderId"),
    FOREIGN KEY ("workOrderId") REFERENCES "workOrderDueDateDetails"("workOrderId")
);

CREATE TABLE "employeePayRateRange11To14" (
    "businessEntityId" INTEGER,
    "rateChangeDate" DATETIME,
    "rate" REAL NOT NULL,
    "payFrequency" INTEGER NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "employeePayRateRange14To230769" (
    "businessEntityId" INTEGER,
    "rateChangeDate" DATETIME,
    "rate" REAL NOT NULL,
    "payFrequency" INTEGER NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "productVendorAverageLeadTime" (
    "productId" INTEGER,
    "vendorId" INTEGER,
    "averageLeadTime" INTEGER NOT NULL,
    "lastReceiptCost" REAL,
    "standardPrice" REAL NOT NULL,
    "unitMeasureCode" TEXT NOT NULL,
    FOREIGN KEY ("unitMeasureCode") REFERENCES "unitMeasureRef"("unitMeasureCode"),
    FOREIGN KEY ("vendorId") REFERENCES "vendorModifiedBefore20111224"("businessEntityId"),
    FOREIGN KEY ("productId") REFERENCES "productDetails"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureZeroOrLess"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureGreaterOneOrNull"("productId")
);

CREATE TABLE "personCreditCardModifiedFebToSep2013" (
    "businessEntityId" INTEGER,
    "creditCardId" INTEGER,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY ("creditCardId") REFERENCES "creditCardExpMonthHighOrNull"("creditCardId")
);

CREATE TABLE "personCreditCardModifiedSep2013ToFeb2014" (
    "businessEntityId" INTEGER,
    "creditCardId" INTEGER,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY ("businessEntityId") REFERENCES "personAdditionalContactBefore20121212"("businessEntityId"),
    FOREIGN KEY ("creditCardId") REFERENCES "creditCardExpMonthHighOrNull"("creditCardId")
);

CREATE TABLE "productVendorMaxOrderQtyLow" (
    "productId" INTEGER,
    "vendorId" INTEGER,
    "maxOrderQty" INTEGER NOT NULL,
    "minOrderQty" INTEGER NOT NULL,
    "onOrderQty" INTEGER,
    FOREIGN KEY ("vendorId") REFERENCES "vendorModifiedBefore20111224"("businessEntityId"),
    FOREIGN KEY ("productId") REFERENCES "productDetails"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureZeroOrLess"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureOne"("productId")
);

CREATE TABLE "productVendorMaxOrderQtyMixed" (
    "productId" INTEGER,
    "vendorId" INTEGER,
    "maxOrderQty" INTEGER NOT NULL,
    "minOrderQty" INTEGER NOT NULL,
    "onOrderQty" INTEGER,
    FOREIGN KEY ("vendorId") REFERENCES "vendorModifiedBefore20111224"("businessEntityId")
);

CREATE TABLE "specialOfferProductApr2011Mid" (
    "specialOfferId" INTEGER,
    "productId" INTEGER,
    "rowGuid" TEXT NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureZeroOrLess"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureGreaterOneOrNull"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDiscontinuedDates"("productId")
);

CREATE TABLE "billOfMaterialsAssemblyLevel" (
    "billOfMaterialsId" INTEGER,
    "bomLevel" INTEGER NOT NULL,
    "endDate" DATETIME,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp,
    "perAssemblyQuantity" REAL NOT NULL DEFAULT 1.00,
    "startDate" DATETIME NOT NULL DEFAULT current_timestamp,
    "unitMeasureCode" TEXT NOT NULL
);

CREATE TABLE "billOfMaterialsModifiedMayToJun2010" (
    "billOfMaterialsId" INTEGER,
    "bomLevel" INTEGER NOT NULL,
    "componentId" INTEGER NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp,
    "perAssemblyQuantity" REAL NOT NULL DEFAULT 1.00,
    "productAssemblyId" INTEGER,
    "unitMeasureCode" TEXT NOT NULL
);

CREATE TABLE "billOfMaterialsModifiedJunToAug2010" (
    "billOfMaterialsId" INTEGER,
    "bomLevel" INTEGER NOT NULL,
    "componentId" INTEGER NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp,
    "perAssemblyQuantity" REAL NOT NULL DEFAULT 1.00,
    "productAssemblyId" INTEGER,
    "unitMeasureCode" TEXT NOT NULL
);

CREATE TABLE "productInventoryModifiedBefore20120430" (
    "productId" INTEGER,
    "locationId" INTEGER,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "quantity" INTEGER NOT NULL DEFAULT 0,
    "rowGuid" TEXT NOT NULL,
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureOne"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDiscontinuedDates"("productId")
);

CREATE TABLE "productInventoryModifiedApr2012ToJul2014" (
    "productId" INTEGER,
    "locationId" INTEGER,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "quantity" INTEGER NOT NULL DEFAULT 0,
    "rowGuid" TEXT NOT NULL,
    FOREIGN KEY ("locationId") REFERENCES "locationRef"("locationId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureGreaterOneOrNull"("productId")
);

CREATE TABLE "productInventoryModifiedJulAug2014" (
    "productId" INTEGER,
    "locationId" INTEGER,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "quantity" INTEGER NOT NULL DEFAULT 0,
    "rowGuid" TEXT NOT NULL,
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureOne"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDiscontinuedDates"("productId")
);

CREATE TABLE "businessEntityAddressByGuid" (
    "businessEntityId" INTEGER,
    "addressId" INTEGER,
    "addressTypeId" INTEGER,
    "rowGuid" TEXT NOT NULL,
    FOREIGN KEY ("businessEntityId") REFERENCES "businessEntityModifiedAfter20171213OrNull"("businessEntityId"),
    FOREIGN KEY ("addressId") REFERENCES "addressForSelectedCities"("addressId")
);

CREATE TABLE "businessEntityAddressModifiedFebSep2013" (
    "businessEntityId" INTEGER,
    "addressId" INTEGER,
    "addressTypeId" INTEGER,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp,
    "rowGuid" TEXT NOT NULL,
    FOREIGN KEY ("businessEntityId") REFERENCES "businessEntityModifiedBefore20171213"("businessEntityId"),
    FOREIGN KEY ("addressTypeId") REFERENCES "addressTypeRef"("addressTypeId")
);

CREATE TABLE "businessEntityAddressModifiedSep2013ToFeb2014" (
    "businessEntityId" INTEGER,
    "addressId" INTEGER,
    "addressTypeId" INTEGER,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp,
    "rowGuid" TEXT NOT NULL,
    FOREIGN KEY ("businessEntityId") REFERENCES "businessEntityModifiedAfter20171213OrNull"("businessEntityId"),
    FOREIGN KEY ("addressTypeId") REFERENCES "addressTypeRef"("addressTypeId")
);

CREATE TABLE "businessEntityContactByGuid" (
    "businessEntityId" INTEGER,
    "personId" INTEGER,
    "contactTypeId" INTEGER,
    "rowGuid" TEXT NOT NULL,
    FOREIGN KEY ("personId") REFERENCES "personAdditionalContactBefore20121212"("businessEntityId"),
    FOREIGN KEY ("contactTypeId") REFERENCES "contactTypeRef"("contactTypeId"),
    FOREIGN KEY ("businessEntityId") REFERENCES "businessEntityModifiedBefore20171213"("businessEntityId")
);

CREATE TABLE "businessEntityContactModifiedDec13Early2017" (
    "businessEntityId" INTEGER,
    "personId" INTEGER,
    "contactTypeId" INTEGER,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp,
    "rowGuid" TEXT NOT NULL,
    FOREIGN KEY ("personId") REFERENCES "personAdditionalContactBefore20121212"("businessEntityId"),
    FOREIGN KEY ("businessEntityId") REFERENCES "businessEntityModifiedBefore20171213"("businessEntityId")
);

CREATE TABLE "businessEntityContactModifiedDec13Mid2017" (
    "businessEntityId" INTEGER,
    "personId" INTEGER,
    "contactTypeId" INTEGER,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp,
    "rowGuid" TEXT NOT NULL,
    FOREIGN KEY ("contactTypeId") REFERENCES "contactTypeRef"("contactTypeId")
);

CREATE TABLE "currencyRateAverageRangeLowMid" (
    "currencyRateId" INTEGER,
    "currencyRateDate" DATETIME NOT NULL,
    "fromCurrencyCode" TEXT NOT NULL,
    "toCurrencyCode" TEXT NOT NULL,
    "averageRate" REAL NOT NULL,
    "endOfDayRate" REAL NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "currencyRateAverageRangeMidHigh" (
    "currencyRateId" INTEGER,
    "currencyRateDate" DATETIME NOT NULL,
    "fromCurrencyCode" TEXT NOT NULL,
    "toCurrencyCode" TEXT NOT NULL,
    "averageRate" REAL NOT NULL,
    "endOfDayRate" REAL NOT NULL,
    "modifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "productPhotoModified20080331To20110501" (
    "productId" INTEGER,
    "productPhotoId" INTEGER,
    "isPrimary" INTEGER NOT NULL DEFAULT 0,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("productId") REFERENCES "productDetails"("productId"),
    FOREIGN KEY ("productId") REFERENCES "productDaysToManufactureGreaterOneOrNull"("productId")
);

CREATE TABLE "salesOrderHeaderSalesReasonModifiedAugToNov2013" (
    "salesOrderId" INTEGER,
    "salesReasonId" INTEGER,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("salesOrderId") REFERENCES "salesOrderHeaderWithAccount"("salesOrderId"),
    FOREIGN KEY ("salesOrderId") REFERENCES "salesOrderHeaderFullDetails"("salesOrderId")
);

CREATE TABLE "salesOrderHeaderSalesReasonModifiedNov2013ToMar2014" (
    "salesOrderId" INTEGER,
    "salesReasonId" INTEGER,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "salesTerritoryHistoryModifiedDate" (
    "businessEntityId" INTEGER,
    "territoryId" INTEGER,
    "startDate" DATETIME,
    "modifiedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "rowGuid" TEXT NOT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "CountryRegionCurrencyMap" (
    "RegionCode" TEXT,
    "CurrencyIsoCode" TEXT,
    "LastModifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "EmployeePayHistoryLowestRateQuartile" (
    "EmployeeId" INTEGER,
    "RateEffectiveDate" DATETIME,
    "PayRate" REAL NOT NULL,
    "PayInterval" INTEGER NOT NULL,
    "LastModifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "EmployeePayHistoryHighestRateQuartileOrNull" (
    "EmployeeId" INTEGER,
    "RateEffectiveDate" DATETIME,
    "PayRate" REAL NOT NULL,
    "PayInterval" INTEGER NOT NULL,
    "LastModifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "PhoneNumberTypeLookup" (
    "PhoneTypeId" INTEGER,
    "TypeName" TEXT NOT NULL,
    "LastUpdated" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "ShoppingCartItemEntry" (
    "CartItemId" INTEGER,
    "CartId" TEXT NOT NULL,
    "ItemQuantity" INTEGER NOT NULL DEFAULT 1,
    "ProductRefId" INTEGER NOT NULL,
    "CreatedTimestamp" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "LastModifiedTimestamp" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "EmployeeGenderProfile" (
    "EmployeeId" INTEGER,
    "GenderCode" TEXT NOT NULL,
    "JobTitleName" TEXT NOT NULL,
    "MaritalStatusCode" TEXT NOT NULL,
    "OrgLevel" INTEGER,
    "OrgNodePath" TEXT
);

CREATE TABLE "EmployeeCurrentFlagSalariedNonPositive" (
    "EmployeeId" INTEGER,
    "IsCurrent" INTEGER NOT NULL DEFAULT 1,
    "LoginName" TEXT NOT NULL,
    "NationalIdentifier" TEXT NOT NULL,
    "SalariedIndicator" INTEGER NOT NULL DEFAULT 1,
    "RowGuidValue" TEXT NOT NULL,
    FOREIGN KEY ("EmployeeId") REFERENCES "PersonAdditionalContactInfoModifiedDateRange2012Dec12To2013Sep13"("PersonId")
);

CREATE TABLE "EmployeeCurrentFlagSalariedPositiveOrNull" (
    "EmployeeId" INTEGER,
    "IsCurrent" INTEGER NOT NULL DEFAULT 1,
    "LoginName" TEXT NOT NULL,
    "NationalIdentifier" TEXT NOT NULL,
    "SalariedIndicator" INTEGER NOT NULL DEFAULT 1,
    "RowGuidValue" TEXT NOT NULL
);

CREATE TABLE "PersonAdditionalContactInfoModifiedDateRange2012Dec12To2013Sep13" (
    "PersonId" INTEGER,
    "AdditionalContacts" TEXT,
    "DemographicData" TEXT,
    "EmailPromotionFlag" INTEGER NOT NULL DEFAULT 0,
    "ModifiedTimestamp" DATETIME NOT NULL DEFAULT current_timestamp,
    "NameStyleFlag" INTEGER NOT NULL DEFAULT 0,
    "PersonCategory" TEXT NOT NULL,
    "NameSuffix" TEXT,
    "NameTitle" TEXT,
    "RowGuidValue" TEXT NOT NULL
);

CREATE TABLE "PersonAdditionalContactInfoModifiedDateRange2013Sep13To2014Jan30" (
    "PersonId" INTEGER,
    "AdditionalContacts" TEXT,
    "DemographicData" TEXT,
    "EmailPromotionFlag" INTEGER NOT NULL DEFAULT 0,
    "ModifiedTimestamp" DATETIME NOT NULL DEFAULT current_timestamp,
    "NameStyleFlag" INTEGER NOT NULL DEFAULT 0,
    "PersonCategory" TEXT NOT NULL,
    "NameSuffix" TEXT,
    "NameTitle" TEXT,
    "RowGuidValue" TEXT NOT NULL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "currency_rate_avg_up_to_1_0684" (
    "currency_rate_id" INTEGER,
    "rate_effective_date" DATETIME NOT NULL,
    "source_currency_code" TEXT NOT NULL,
    "target_currency_code" TEXT NOT NULL,
    "average_exchange_rate" REAL NOT NULL,
    "end_of_day_exchange_rate" REAL NOT NULL,
    "last_modified_at" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "currency_rate_avg_above_8_2871_or_null" (
    "currency_rate_id" INTEGER,
    "rate_effective_date" DATETIME NOT NULL,
    "source_currency_code" TEXT NOT NULL,
    "target_currency_code" TEXT NOT NULL,
    "average_exchange_rate" REAL NOT NULL,
    "end_of_day_exchange_rate" REAL NOT NULL,
    "last_modified_at" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "job_candidate_profile" (
    "job_candidate_id" INTEGER,
    "business_entity_id" INTEGER,
    "resume_text" TEXT,
    "last_modified_at" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "product_description_as_of_2013_04_30" (
    "product_description_id" INTEGER,
    "description_text" TEXT NOT NULL,
    "row_guid" TEXT NOT NULL,
    "last_modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "product_description_as_of_2014_02_08" (
    "product_description_id" INTEGER,
    "description_text" TEXT NOT NULL,
    "row_guid" TEXT NOT NULL,
    "last_modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "product_model_description_culture_link" (
    "product_model_id" INTEGER,
    "product_description_id" INTEGER,
    "culture_code" TEXT,
    "last_modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("product_description_id") REFERENCES "product_description_as_of_2014_02_08"("product_description_id"),
    FOREIGN KEY ("product_model_id") REFERENCES "product_model_filtered_by_modified_date"("product_model_id")
);

CREATE TABLE "product_model_filtered_by_modified_date" (
    "product_model_id" INTEGER,
    "model_name" TEXT NOT NULL,
    "catalog_summary" TEXT,
    "usage_instructions" TEXT,
    "row_guid" TEXT NOT NULL,
    "last_modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "sales_order_due_on_or_before_2013_07_02" (
    "sales_order_id" INTEGER,
    "due_date" DATETIME NOT NULL,
    "last_modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "order_date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ship_date" DATETIME
);

CREATE TABLE "sales_order_due_between_2013_07_02_and_2013_11_15" (
    "sales_order_id" INTEGER,
    "due_date" DATETIME NOT NULL,
    "last_modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "order_date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ship_date" DATETIME
);

CREATE TABLE "sales_order_due_between_2013_11_15_and_2014_03_12" (
    "sales_order_id" INTEGER,
    "due_date" DATETIME NOT NULL,
    "last_modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "order_date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ship_date" DATETIME
);

CREATE TABLE "sales_order_due_after_2014_03_12_or_null" (
    "sales_order_id" INTEGER,
    "due_date" DATETIME NOT NULL,
    "last_modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "order_date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ship_date" DATETIME
);

CREATE TABLE "sales_order_freight_financials" (
    "sales_order_id" INTEGER,
    "freight_charge" REAL NOT NULL DEFAULT 0.0000,
    "subtotal_amount" REAL NOT NULL DEFAULT 0.0000,
    "tax_amount" REAL NOT NULL DEFAULT 0.0000,
    "total_due_amount" REAL NOT NULL
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "person_cc_pre20130213" (
    "be_id" INTEGER,
    "cc_id" INTEGER,
    "mod_dt" DATETIME NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY ("cc_id") REFERENCES "cc_exp_aug_oct"("cc_id")
);

CREATE TABLE "person_cc_post20140205_or_null" (
    "be_id" INTEGER,
    "cc_id" INTEGER,
    "mod_dt" DATETIME NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY ("cc_id") REFERENCES "cc_exp_aug_oct"("cc_id")
);

CREATE TABLE "prod_photo_early_20120430" (
    "photo_id" INTEGER,
    "thumb_img" BLOB,
    "thumb_fn" TEXT,
    "large_img" BLOB,
    "large_fn" TEXT,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "prod_photo_mid_20120430_20121019" (
    "photo_id" INTEGER,
    "thumb_img" BLOB,
    "thumb_fn" TEXT,
    "large_img" BLOB,
    "large_fn" TEXT,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "prod_photo_post_20121019" (
    "photo_id" INTEGER,
    "thumb_img" BLOB,
    "thumb_fn" TEXT,
    "large_img" BLOB,
    "large_fn" TEXT,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "prod_photo_xref_early_20080331" (
    "prod_id" INTEGER,
    "photo_id" INTEGER,
    "primary_flag" INTEGER NOT NULL DEFAULT 0,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("photo_id") REFERENCES "prod_photo_early_20120430"("photo_id"),
    FOREIGN KEY ("photo_id") REFERENCES "prod_photo_post_20121019"("photo_id")
);

CREATE TABLE "prod_photo_xref_post20110501" (
    "prod_id" INTEGER,
    "photo_id" INTEGER,
    "primary_flag" INTEGER NOT NULL DEFAULT 0,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("photo_id") REFERENCES "prod_photo_early_20120430"("photo_id"),
    FOREIGN KEY ("photo_id") REFERENCES "prod_photo_mid_20120430_20121019"("photo_id")
);

CREATE TABLE "sp_comp_bonus" (
    "be_id" INTEGER,
    "bonus_amt" REAL NOT NULL DEFAULT 0.0000,
    "comm_pct" REAL NOT NULL DEFAULT 0.0000,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "quota_amt" REAL,
    "territory_id" INTEGER,
    "row_guid" TEXT NOT NULL
);

CREATE TABLE "sp_territory_hist_with_end" (
    "be_id" INTEGER,
    "territory_id" INTEGER,
    "start_dt" DATETIME,
    "end_dt" DATETIME,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "row_guid" TEXT NOT NULL,
    FOREIGN KEY ("territory_id") REFERENCES "territory_country_region"("territory_id")
);

CREATE TABLE "cc_exp_may_jul" (
    "cc_id" INTEGER,
    "cc_type" TEXT NOT NULL,
    "cc_num" TEXT NOT NULL,
    "exp_mon" INTEGER NOT NULL,
    "exp_yr" INTEGER NOT NULL,
    "mod_dt" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "cc_exp_aug_oct" (
    "cc_id" INTEGER,
    "cc_type" TEXT NOT NULL,
    "cc_num" TEXT NOT NULL,
    "exp_mon" INTEGER NOT NULL,
    "exp_yr" INTEGER NOT NULL,
    "mod_dt" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "territory_country_region" (
    "territory_id" INTEGER,
    "cntry_region_cd" TEXT NOT NULL,
    "grp_name" TEXT NOT NULL,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "terr_name" TEXT NOT NULL,
    "row_guid" TEXT NOT NULL
);

CREATE TABLE "sp_quota_hist_20120115_20121016" (
    "be_id" INTEGER,
    "quota_dt" DATETIME,
    "quota_amt" REAL NOT NULL,
    "row_guid" TEXT NOT NULL,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "sp_quota_hist_20121016_20130716" (
    "be_id" INTEGER,
    "quota_dt" DATETIME,
    "quota_amt" REAL NOT NULL,
    "row_guid" TEXT NOT NULL,
    "mod_dt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "productDocumentLink" (
    "productReferenceId" INTEGER,
    "documentNodeToken" TEXT,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "salesOrderReasonModifiedOnOrBefore2013Aug02" (
    "salesOrderRefId" INTEGER,
    "salesReasonRefId" INTEGER,
    "modifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "salesOrderReasonModifiedAfter2014Mar11OrNull" (
    "salesOrderRefId" INTEGER,
    "salesReasonRefId" INTEGER,
    "modifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "salesPersonQuotaHistoryOnOrBefore2012Jan15" (
    "businessEntityRefId" INTEGER,
    "quotaEffectiveDate" DATETIME,
    "quotaAmount" REAL NOT NULL,
    "recordGuid" TEXT NOT NULL,
    "modifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "salesPersonQuotaHistoryAfter2013Jul16OrNull" (
    "businessEntityRefId" INTEGER,
    "quotaEffectiveDate" DATETIME,
    "quotaAmount" REAL NOT NULL,
    "recordGuid" TEXT NOT NULL,
    "modifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "salesReasonLookup" (
    "salesReasonRefId" INTEGER,
    "reasonName" TEXT NOT NULL,
    "reasonCategory" TEXT NOT NULL,
    "modifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "salesPersonCompensation" (
    "businessEntityRefId" INTEGER,
    "bonusAmount" REAL NOT NULL DEFAULT 0.0000,
    "commissionPercent" REAL NOT NULL DEFAULT 0.0000,
    "modifiedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "salesPreviousYearAmount" REAL NOT NULL DEFAULT 0.0000,
    "salesQuotaAmount" REAL,
    "salesYearToDate" REAL NOT NULL DEFAULT 0.0000
);

CREATE TABLE "documentRevisionTracker" (
    "documentNodeToken" TEXT,
    "changeSequence" INTEGER NOT NULL DEFAULT 0,
    "documentHierarchyLevel" INTEGER,
    "documentSummaryText" TEXT,
    "lastModifiedAt" DATETIME NOT NULL DEFAULT current_timestamp,
    "ownerId" INTEGER NOT NULL,
    "revisionLabel" TEXT NOT NULL,
    "statusCode" INTEGER NOT NULL,
    "titleText" TEXT NOT NULL,
    "recordGuid" TEXT NOT NULL
);

-- ========================================================================
-- local_6
-- DDL file: local_6_schema.sql
-- ========================================================================

CREATE TABLE "bill_of_materials_modified_on_or_before_2010_05_12" (
    "bill_of_materials_id" INTEGER,
    "assembly_level" INTEGER NOT NULL,
    "component_id" INTEGER NOT NULL,
    "modified_at" DATETIME NOT NULL DEFAULT current_timestamp,
    "quantity_per_assembly" REAL NOT NULL DEFAULT 1.00,
    "product_assembly_id" INTEGER,
    "unit_of_measure_code" TEXT NOT NULL
);

CREATE TABLE "bill_of_materials_modified_after_2010_09_01_or_null" (
    "bill_of_materials_id" INTEGER,
    "assembly_level" INTEGER NOT NULL,
    "component_id" INTEGER NOT NULL,
    "modified_at" DATETIME NOT NULL DEFAULT current_timestamp,
    "quantity_per_assembly" REAL NOT NULL DEFAULT 1.00,
    "product_assembly_id" INTEGER,
    "unit_of_measure_code" TEXT NOT NULL
);

CREATE TABLE "employee_department_history" (
    "business_entity_id" INTEGER,
    "department_id" INTEGER,
    "shift_id" INTEGER,
    "start_date" DATE,
    "end_date" DATE,
    "modified_at" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "work_shift" (
    "shift_id" INTEGER,
    "shift_name" TEXT NOT NULL,
    "start_time" TEXT NOT NULL,
    "end_time" TEXT NOT NULL,
    "modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "employee_life_dates" (
    "business_entity_id" INTEGER,
    "birth_date" DATE NOT NULL,
    "hire_date" DATE NOT NULL,
    "modified_at" DATETIME NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY ("business_entity_id") REFERENCES "person_additional_contact_info"("business_entity_id")
);

CREATE TABLE "person_additional_contact_info" (
    "business_entity_id" INTEGER,
    "additional_contact_info" TEXT,
    "name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "middle_name" TEXT,
    "modified_at" DATETIME NOT NULL DEFAULT current_timestamp,
    "name_style" INTEGER NOT NULL DEFAULT 0,
    "name_suffix" TEXT,
    "name_title" TEXT
);

-- ========================================================================
-- local_7
-- DDL file: local_7_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_8
-- DDL file: local_8_schema.sql
-- ========================================================================

CREATE TABLE "business_entity_contact_modified_earliest_quartile" (
    "business_entity_id" INTEGER,
    "person_id" INTEGER,
    "contact_type_id" INTEGER,
    "modified_at" DATETIME NOT NULL DEFAULT current_timestamp,
    "row_guid" TEXT NOT NULL,
    FOREIGN KEY ("business_entity_id") REFERENCES "business_entity_modified_quartile"("business_entity_id"),
    FOREIGN KEY ("business_entity_id") REFERENCES "business_entity_modified_quartile"("business_entity_id")
);

CREATE TABLE "business_entity_contact_modified_latest_quartile" (
    "business_entity_id" INTEGER,
    "person_id" INTEGER,
    "contact_type_id" INTEGER,
    "modified_at" DATETIME NOT NULL DEFAULT current_timestamp,
    "row_guid" TEXT NOT NULL,
    FOREIGN KEY ("business_entity_id") REFERENCES "business_entity_modified_quartile"("business_entity_id")
);

CREATE TABLE "supplier_product_lead_time" (
    "product_id" INTEGER,
    "vendor_business_entity_id" INTEGER,
    "average_lead_time_days" INTEGER NOT NULL,
    "last_receipt_cost" REAL,
    "last_receipt_date" DATETIME,
    "modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "standard_price" REAL NOT NULL,
    "unit_measure_code" TEXT NOT NULL,
    FOREIGN KEY ("vendor_business_entity_id") REFERENCES "vendor_modified_quartile"("business_entity_id"),
    FOREIGN KEY ("vendor_business_entity_id") REFERENCES "vendor_modified_quartile"("business_entity_id"),
    FOREIGN KEY ("product_id") REFERENCES "product_classification_core"("product_id")
);

CREATE TABLE "transaction_history_archive_actualcost_lowest" (
    "transaction_id" INTEGER,
    "product_id" INTEGER NOT NULL,
    "reference_order_id" INTEGER NOT NULL,
    "reference_order_line_id" INTEGER NOT NULL DEFAULT 0,
    "transaction_date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "transaction_type" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "actual_cost" REAL NOT NULL,
    "modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "transaction_history_archive_actualcost_middle" (
    "transaction_id" INTEGER,
    "product_id" INTEGER NOT NULL,
    "reference_order_id" INTEGER NOT NULL,
    "reference_order_line_id" INTEGER NOT NULL DEFAULT 0,
    "transaction_date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "transaction_type" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "actual_cost" REAL NOT NULL,
    "modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "transaction_history_archive_actualcost_highest" (
    "transaction_id" INTEGER,
    "product_id" INTEGER NOT NULL,
    "reference_order_id" INTEGER NOT NULL,
    "reference_order_line_id" INTEGER NOT NULL DEFAULT 0,
    "transaction_date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "transaction_type" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "actual_cost" REAL NOT NULL,
    "modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "vendor_modified_quartile" (
    "business_entity_id" INTEGER,
    "account_number" TEXT NOT NULL,
    "vendor_name" TEXT NOT NULL,
    "credit_rating" INTEGER NOT NULL,
    "preferred_vendor_status" INTEGER NOT NULL DEFAULT 1,
    "active_flag" INTEGER NOT NULL DEFAULT 1,
    "purchasing_webservice_url" TEXT,
    "modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("business_entity_id") REFERENCES "business_entity_modified_quartile"("business_entity_id"),
    FOREIGN KEY ("business_entity_id") REFERENCES "business_entity_modified_quartile"("business_entity_id")
);

CREATE TABLE "product_classification_core" (
    "product_id" INTEGER,
    "product_class" TEXT,
    "color" TEXT,
    "list_price" REAL NOT NULL,
    "product_name" TEXT NOT NULL,
    "product_line" TEXT,
    "product_number" TEXT NOT NULL,
    "size" TEXT,
    "size_unit_code" TEXT,
    "standard_cost" REAL NOT NULL,
    "style" TEXT,
    "weight" REAL,
    "weight_unit_code" TEXT,
    "row_guid" TEXT NOT NULL
);

CREATE TABLE "address_other_cities" (
    "address_id" INTEGER,
    "address_line_primary" TEXT NOT NULL,
    "address_line_secondary" TEXT,
    "city_name" TEXT NOT NULL,
    "state_province_id" INTEGER NOT NULL,
    "postal_code" TEXT NOT NULL,
    "spatial_location" TEXT,
    "row_guid" TEXT NOT NULL,
    "modified_at" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "business_entity_modified_quartile" (
    "business_entity_id" INTEGER,
    "row_guid" TEXT NOT NULL,
    "modified_at" DATETIME NOT NULL DEFAULT current_timestamp
);

