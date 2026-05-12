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