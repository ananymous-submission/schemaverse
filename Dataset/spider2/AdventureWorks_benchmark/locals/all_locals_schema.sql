-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/AdventureWorks/AdventureWorks.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "pm_desc_cult_pm_lte32" (
    "pm_id" INTEGER,
    "pd_id" INTEGER,
    "cult_id" TEXT,
    "mod_ts" DATE
);

CREATE TABLE "pm_desc_cult_pm_33to64" (
    "pm_id" INTEGER,
    "pd_id" INTEGER,
    "cult_id" TEXT,
    "mod_ts" DATE
);

CREATE TABLE "pm_desc_cult_pm_65to96" (
    "pm_id" INTEGER,
    "pd_id" INTEGER,
    "cult_id" TEXT,
    "mod_ts" DATE
);

CREATE TABLE "pm_desc_cult_pm_gt96_or_null" (
    "pm_id" INTEGER,
    "pd_id" INTEGER,
    "cult_id" TEXT,
    "mod_ts" DATE
);

CREATE TABLE "sod_detail_ctn_empty" (
    "row_guid" TEXT,
    "ctn_code" TEXT,
    "mod_ts" DATE,
    "qty" INTEGER,
    "prod_id" INTEGER,
    "sodetail_id" INTEGER,
    "so_id" INTEGER
);

CREATE TABLE "sod_detail_ctn_values" (
    "row_guid" TEXT,
    "ctn_code" TEXT,
    "mod_ts" DATE,
    "qty" INTEGER,
    "prod_id" INTEGER,
    "sodetail_id" INTEGER,
    "so_id" INTEGER
);

CREATE TABLE "sod_detail_ctn_pricing" (
    "row_guid" TEXT,
    "ctn_code" TEXT,
    "mod_ts" DATE,
    "qty" INTEGER,
    "so_id" INTEGER,
    "sp_off_id" INTEGER,
    "unit_price" FLOAT,
    "unit_price_disc" FLOAT
);

CREATE TABLE "soh_status_core" (
    "row_guid" TEXT,
    "status_code" TEXT,
    "acct_num" TEXT,
    "note" TEXT,
    "cc_auth_code" TEXT,
    "cc_id" INTEGER,
    "online_flg" BOOLEAN,
    "po_num" TEXT,
    "rev_num" INTEGER,
    "so_id" INTEGER,
    "ship_method_id" INTEGER,
    "terr_id" INTEGER
);

CREATE TABLE "soh_status_full" (
    "row_guid" TEXT,
    "status_code" TEXT,
    "acct_num" TEXT,
    "bill_addr_id" INTEGER,
    "note" TEXT,
    "cc_auth_code" TEXT,
    "cc_id" INTEGER,
    "curr_rate_id" INTEGER,
    "cust_id" INTEGER,
    "online_flg" BOOLEAN,
    "po_num" TEXT,
    "so_id" INTEGER,
    "salesp_id" INTEGER,
    "ship_method_id" INTEGER,
    "ship_addr_id" INTEGER,
    "terr_id" INTEGER
);

CREATE TABLE "soh_due_lte_20130702" (
    "row_guid" TEXT,
    "due_dt" DATE,
    "mod_ts" DATE,
    "ord_dt" DATE,
    "ship_dt" DATE
);

CREATE TABLE "soh_due_20130703_20131115" (
    "row_guid" TEXT,
    "due_dt" DATE,
    "mod_ts" DATE,
    "ord_dt" DATE,
    "ship_dt" DATE
);

CREATE TABLE "soh_due_20131116_20140312" (
    "row_guid" TEXT,
    "due_dt" DATE,
    "mod_ts" DATE,
    "ord_dt" DATE,
    "ship_dt" DATE
);

CREATE TABLE "soh_due_gt_20140312_or_null" (
    "row_guid" TEXT,
    "due_dt" DATE,
    "mod_ts" DATE,
    "ord_dt" DATE,
    "ship_dt" DATE
);

CREATE TABLE "soh_totals_freight" (
    "row_guid" TEXT,
    "freight_amt" FLOAT,
    "sub_total" FLOAT,
    "tax_amt" FLOAT,
    "total_due" FLOAT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "SalesQuotaHistory_EntityIdUpTo277" (
    "BusinessEntityKey" INTEGER,
    "QuotaEffectiveDate" TEXT,
    "QuotaAmount" REAL,
    "RowGuidValue" TEXT,
    "LastModifiedTimestamp" TEXT
);

CREATE TABLE "SalesQuotaHistory_EntityId278To280" (
    "BusinessEntityKey" INTEGER,
    "QuotaEffectiveDate" TEXT,
    "QuotaAmount" REAL,
    "RowGuidValue" TEXT,
    "LastModifiedTimestamp" TEXT
);

CREATE TABLE "SalesQuotaHistory_EntityId281To284" (
    "BusinessEntityKey" INTEGER,
    "QuotaEffectiveDate" TEXT,
    "QuotaAmount" REAL,
    "RowGuidValue" TEXT,
    "LastModifiedTimestamp" TEXT
);

CREATE TABLE "SalesQuotaHistory_EntityIdGt284OrNull" (
    "BusinessEntityKey" INTEGER,
    "QuotaEffectiveDate" TEXT,
    "QuotaAmount" REAL,
    "RowGuidValue" TEXT,
    "LastModifiedTimestamp" TEXT
);

CREATE TABLE "SalesRepresentative" (
    "BusinessEntityKey" INTEGER,
    "SalesTerritoryKey" INTEGER,
    "AnnualSalesQuota" INTEGER,
    "BonusAmount" INTEGER,
    "CommissionRatePercent" FLOAT,
    "SalesYearToDateAmount" FLOAT,
    "SalesPreviousYearAmount" FLOAT,
    "RowGuidValue" TEXT,
    "LastModifiedTimestamp" DATE
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "country_region_currency_map" (
    "country_region_code" TEXT,
    "currency_code" TEXT,
    "modified_at" DATE
);

CREATE TABLE "sales_territory_financials_last_year" (
    "territory_name" TEXT,
    "cost_previous_year" FLOAT,
    "cost_year_to_date" FLOAT,
    "country_region_code" TEXT,
    "territory_group" TEXT,
    "modified_at" DATE,
    "sales_previous_year" FLOAT,
    "sales_year_to_date" FLOAT,
    "territory_id" INTEGER
);

CREATE TABLE "sales_territory_region_mapping" (
    "territory_name" TEXT,
    "country_region_code" TEXT,
    "territory_group" TEXT,
    "modified_at" DATE,
    "row_guid" TEXT,
    "territory_id" INTEGER
);

