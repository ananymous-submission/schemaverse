-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";

-- Reconstruct SalesPersonQuotaHistory from row partitions (UNION (overlap))
CREATE VIEW "SalesPersonQuotaHistory" AS
SELECT "local_3"."SalesQuotaHistory_EntityIdUpTo277"."BusinessEntityKey" AS "BusinessEntityID", "local_3"."SalesQuotaHistory_EntityIdUpTo277"."QuotaEffectiveDate" AS "QuotaDate", "local_3"."SalesQuotaHistory_EntityIdUpTo277"."QuotaAmount" AS "SalesQuota", "local_3"."SalesQuotaHistory_EntityIdUpTo277"."RowGuidValue" AS "rowguid", "local_3"."SalesQuotaHistory_EntityIdUpTo277"."LastModifiedTimestamp" AS "ModifiedDate" FROM "local_3"."SalesQuotaHistory_EntityIdUpTo277"
UNION
SELECT "local_3"."SalesQuotaHistory_EntityId278To280"."BusinessEntityKey" AS "BusinessEntityID", "local_3"."SalesQuotaHistory_EntityId278To280"."QuotaEffectiveDate" AS "QuotaDate", "local_3"."SalesQuotaHistory_EntityId278To280"."QuotaAmount" AS "SalesQuota", "local_3"."SalesQuotaHistory_EntityId278To280"."RowGuidValue" AS "rowguid", "local_3"."SalesQuotaHistory_EntityId278To280"."LastModifiedTimestamp" AS "ModifiedDate" FROM "local_3"."SalesQuotaHistory_EntityId278To280"
UNION
SELECT "local_3"."SalesQuotaHistory_EntityId281To284"."BusinessEntityKey" AS "BusinessEntityID", "local_3"."SalesQuotaHistory_EntityId281To284"."QuotaEffectiveDate" AS "QuotaDate", "local_3"."SalesQuotaHistory_EntityId281To284"."QuotaAmount" AS "SalesQuota", "local_3"."SalesQuotaHistory_EntityId281To284"."RowGuidValue" AS "rowguid", "local_3"."SalesQuotaHistory_EntityId281To284"."LastModifiedTimestamp" AS "ModifiedDate" FROM "local_3"."SalesQuotaHistory_EntityId281To284"
UNION
SELECT "local_3"."SalesQuotaHistory_EntityIdGt284OrNull"."BusinessEntityKey" AS "BusinessEntityID", "local_3"."SalesQuotaHistory_EntityIdGt284OrNull"."QuotaEffectiveDate" AS "QuotaDate", "local_3"."SalesQuotaHistory_EntityIdGt284OrNull"."QuotaAmount" AS "SalesQuota", "local_3"."SalesQuotaHistory_EntityIdGt284OrNull"."RowGuidValue" AS "rowguid", "local_3"."SalesQuotaHistory_EntityIdGt284OrNull"."LastModifiedTimestamp" AS "ModifiedDate" FROM "local_3"."SalesQuotaHistory_EntityIdGt284OrNull";

-- Reconstruct countryregioncurrency from local_4.country_region_currency_map
CREATE VIEW "countryregioncurrency" AS
SELECT
    "local_4"."country_region_currency_map"."country_region_code" AS "countryregioncode",
    "local_4"."country_region_currency_map"."currency_code" AS "currencycode",
    "local_4"."country_region_currency_map"."modified_at" AS "modifieddate"
FROM "local_4"."country_region_currency_map";

-- Reconstruct currencyrate from row partitions (UNION (overlap))
CREATE VIEW "currencyrate" AS
SELECT "local_1"."currencyRateUpTo1Point0684"."currencyRateId" AS "currencyrateid", "local_1"."currencyRateUpTo1Point0684"."rateDate" AS "currencyratedate", "local_1"."currencyRateUpTo1Point0684"."sourceCurrencyCode" AS "fromcurrencycode", "local_1"."currencyRateUpTo1Point0684"."targetCurrencyCode" AS "tocurrencycode", "local_1"."currencyRateUpTo1Point0684"."averageRate" AS "averagerate", "local_1"."currencyRateUpTo1Point0684"."endOfDayRate" AS "endofdayrate", "local_1"."currencyRateUpTo1Point0684"."lastModified" AS "modifieddate" FROM "local_1"."currencyRateUpTo1Point0684"
UNION
SELECT "local_1"."currencyRateGreaterThan1Point0684UpTo1Point9812"."currencyRateId" AS "currencyrateid", "local_1"."currencyRateGreaterThan1Point0684UpTo1Point9812"."rateDate" AS "currencyratedate", "local_1"."currencyRateGreaterThan1Point0684UpTo1Point9812"."sourceCurrencyCode" AS "fromcurrencycode", "local_1"."currencyRateGreaterThan1Point0684UpTo1Point9812"."targetCurrencyCode" AS "tocurrencycode", "local_1"."currencyRateGreaterThan1Point0684UpTo1Point9812"."averageRate" AS "averagerate", "local_1"."currencyRateGreaterThan1Point0684UpTo1Point9812"."endOfDayRate" AS "endofdayrate", "local_1"."currencyRateGreaterThan1Point0684UpTo1Point9812"."lastModified" AS "modifieddate" FROM "local_1"."currencyRateGreaterThan1Point0684UpTo1Point9812"
UNION
SELECT "local_1"."currencyRateGreaterThan1Point9812UpTo8Point2871"."currencyRateId" AS "currencyrateid", "local_1"."currencyRateGreaterThan1Point9812UpTo8Point2871"."rateDate" AS "currencyratedate", "local_1"."currencyRateGreaterThan1Point9812UpTo8Point2871"."sourceCurrencyCode" AS "fromcurrencycode", "local_1"."currencyRateGreaterThan1Point9812UpTo8Point2871"."targetCurrencyCode" AS "tocurrencycode", "local_1"."currencyRateGreaterThan1Point9812UpTo8Point2871"."averageRate" AS "averagerate", "local_1"."currencyRateGreaterThan1Point9812UpTo8Point2871"."endOfDayRate" AS "endofdayrate", "local_1"."currencyRateGreaterThan1Point9812UpTo8Point2871"."lastModified" AS "modifieddate" FROM "local_1"."currencyRateGreaterThan1Point9812UpTo8Point2871"
UNION
SELECT "local_1"."currencyRateAbove8Point2871OrNull"."currencyRateId" AS "currencyrateid", "local_1"."currencyRateAbove8Point2871OrNull"."rateDate" AS "currencyratedate", "local_1"."currencyRateAbove8Point2871OrNull"."sourceCurrencyCode" AS "fromcurrencycode", "local_1"."currencyRateAbove8Point2871OrNull"."targetCurrencyCode" AS "tocurrencycode", "local_1"."currencyRateAbove8Point2871OrNull"."averageRate" AS "averagerate", "local_1"."currencyRateAbove8Point2871OrNull"."endOfDayRate" AS "endofdayrate", "local_1"."currencyRateAbove8Point2871OrNull"."lastModified" AS "modifieddate" FROM "local_1"."currencyRateAbove8Point2871OrNull";

-- Reconstruct product from vertical split + row partition on a fragment
CREATE VIEW "product" AS
SELECT t1.[productId], t0.[productName], t0.[productNumber], t0.[makeFlag], t0.[finishedGoodsFlag], t0.[colorName], t0.[safetyStockLevel], t0.[reorderPoint], t0.[standardCost], t0.[listPrice], t0.[productSize], t3.[sizeUnitMeasureCode], t3.[weightUnitMeasureCode], t0.[productWeight], t0.[daysToManufacture], t0.[productLine], t0.[productClass], t0.[productStyle], t1.[productSubcategoryId], t1.[productModelId], t2.[sellStartDate], t2.[sellEndDate], t2.[discontinuedDate], t1.[rowGuid], t2.[lastModified]
FROM (
SELECT [productClassBlack].[__orig_rowid] AS __orig_rowid, [local_1].[productClassBlack].[productName], [local_1].[productClassBlack].[productNumber], [local_1].[productClassBlack].[makeFlag], [local_1].[productClassBlack].[finishedGoodsFlag], [local_1].[productClassBlack].[colorName], [local_1].[productClassBlack].[safetyStockLevel], [local_1].[productClassBlack].[reorderPoint], [local_1].[productClassBlack].[standardCost], [local_1].[productClassBlack].[listPrice], [local_1].[productClassBlack].[productSize], [local_1].[productClassBlack].[productWeight], [local_1].[productClassBlack].[daysToManufacture], [local_1].[productClassBlack].[productLine], [local_1].[productClassBlack].[productClass], [local_1].[productClassBlack].[productStyle] FROM [local_1].[productClassBlack]
UNION
SELECT [productClassNeutralAndMixedColors].[__orig_rowid] AS __orig_rowid, [local_1].[productClassNeutralAndMixedColors].[productName], [local_1].[productClassNeutralAndMixedColors].[productNumber], [local_1].[productClassNeutralAndMixedColors].[makeFlag], [local_1].[productClassNeutralAndMixedColors].[finishedGoodsFlag], [local_1].[productClassNeutralAndMixedColors].[colorName], [local_1].[productClassNeutralAndMixedColors].[safetyStockLevel], [local_1].[productClassNeutralAndMixedColors].[reorderPoint], [local_1].[productClassNeutralAndMixedColors].[standardCost], [local_1].[productClassNeutralAndMixedColors].[listPrice], [local_1].[productClassNeutralAndMixedColors].[productSize], [local_1].[productClassNeutralAndMixedColors].[productWeight], [local_1].[productClassNeutralAndMixedColors].[daysToManufacture], [local_1].[productClassNeutralAndMixedColors].[productLine], [local_1].[productClassNeutralAndMixedColors].[productClass], [local_1].[productClassNeutralAndMixedColors].[productStyle] FROM [local_1].[productClassNeutralAndMixedColors]
UNION
SELECT [productClassNoColor].[__orig_rowid] AS __orig_rowid, [local_1].[productClassNoColor].[productName], [local_1].[productClassNoColor].[productNumber], [local_1].[productClassNoColor].[makeFlag], [local_1].[productClassNoColor].[finishedGoodsFlag], [local_1].[productClassNoColor].[colorName], [local_1].[productClassNoColor].[safetyStockLevel], [local_1].[productClassNoColor].[reorderPoint], [local_1].[productClassNoColor].[standardCost], [local_1].[productClassNoColor].[listPrice], [local_1].[productClassNoColor].[productSize], [local_1].[productClassNoColor].[productWeight], [local_1].[productClassNoColor].[daysToManufacture], [local_1].[productClassNoColor].[productLine], [local_1].[productClassNoColor].[productClass], [local_1].[productClassNoColor].[productStyle] FROM [local_1].[productClassNoColor]
UNION
SELECT [productClassWarmColors].[__orig_rowid] AS __orig_rowid, [local_1].[productClassWarmColors].[productName], [local_1].[productClassWarmColors].[productNumber], [local_1].[productClassWarmColors].[makeFlag], [local_1].[productClassWarmColors].[finishedGoodsFlag], [local_1].[productClassWarmColors].[colorName], [local_1].[productClassWarmColors].[safetyStockLevel], [local_1].[productClassWarmColors].[reorderPoint], [local_1].[productClassWarmColors].[standardCost], [local_1].[productClassWarmColors].[listPrice], [local_1].[productClassWarmColors].[productSize], [local_1].[productClassWarmColors].[productWeight], [local_1].[productClassWarmColors].[daysToManufacture], [local_1].[productClassWarmColors].[productLine], [local_1].[productClassWarmColors].[productClass], [local_1].[productClassWarmColors].[productStyle] FROM [local_1].[productClassWarmColors]
) t0
JOIN [local_1].[productManufactureInfo] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[productLifecycleDates] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[productPricingDetails] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct productcategory from local_1.productCategoryMaster
CREATE VIEW "productcategory" AS
SELECT
    "local_1"."productCategoryMaster"."productCategoryId" AS "productcategoryid",
    "local_1"."productCategoryMaster"."categoryName" AS "name",
    "local_1"."productCategoryMaster"."rowGuid" AS "rowguid",
    "local_1"."productCategoryMaster"."lastModified" AS "modifieddate"
FROM "local_1"."productCategoryMaster";

-- Reconstruct productdescription from row partitions (UNION (overlap))
CREATE VIEW "productdescription" AS
SELECT "local_1"."productDescriptionAsOf2013April30"."productDescriptionId" AS "productdescriptionid", "local_1"."productDescriptionAsOf2013April30"."descriptionText" AS "description", "local_1"."productDescriptionAsOf2013April30"."rowGuid" AS "rowguid", "local_1"."productDescriptionAsOf2013April30"."lastModified" AS "modifieddate" FROM "local_1"."productDescriptionAsOf2013April30"
UNION
SELECT "local_1"."productDescriptionAsOf2014Feb08"."productDescriptionId" AS "productdescriptionid", "local_1"."productDescriptionAsOf2014Feb08"."descriptionText" AS "description", "local_1"."productDescriptionAsOf2014Feb08"."rowGuid" AS "rowguid", "local_1"."productDescriptionAsOf2014Feb08"."lastModified" AS "modifieddate" FROM "local_1"."productDescriptionAsOf2014Feb08";

-- Reconstruct productmodelproductdescriptionculture from row partitions (UNION (overlap))
CREATE VIEW "productmodelproductdescriptionculture" AS
SELECT "local_2"."pm_desc_cult_pm_lte32"."pm_id" AS "productmodelid", "local_2"."pm_desc_cult_pm_lte32"."pd_id" AS "productdescriptionid", "local_2"."pm_desc_cult_pm_lte32"."cult_id" AS "cultureid", "local_2"."pm_desc_cult_pm_lte32"."mod_ts" AS "modifieddate" FROM "local_2"."pm_desc_cult_pm_lte32"
UNION
SELECT "local_2"."pm_desc_cult_pm_33to64"."pm_id" AS "productmodelid", "local_2"."pm_desc_cult_pm_33to64"."pd_id" AS "productdescriptionid", "local_2"."pm_desc_cult_pm_33to64"."cult_id" AS "cultureid", "local_2"."pm_desc_cult_pm_33to64"."mod_ts" AS "modifieddate" FROM "local_2"."pm_desc_cult_pm_33to64"
UNION
SELECT "local_2"."pm_desc_cult_pm_65to96"."pm_id" AS "productmodelid", "local_2"."pm_desc_cult_pm_65to96"."pd_id" AS "productdescriptionid", "local_2"."pm_desc_cult_pm_65to96"."cult_id" AS "cultureid", "local_2"."pm_desc_cult_pm_65to96"."mod_ts" AS "modifieddate" FROM "local_2"."pm_desc_cult_pm_65to96"
UNION
SELECT "local_2"."pm_desc_cult_pm_gt96_or_null"."pm_id" AS "productmodelid", "local_2"."pm_desc_cult_pm_gt96_or_null"."pd_id" AS "productdescriptionid", "local_2"."pm_desc_cult_pm_gt96_or_null"."cult_id" AS "cultureid", "local_2"."pm_desc_cult_pm_gt96_or_null"."mod_ts" AS "modifieddate" FROM "local_2"."pm_desc_cult_pm_gt96_or_null";

-- Reconstruct productreview from vertical (column) split (2 fragments)
CREATE VIEW "productreview" AS
SELECT
    t0."productReviewId" AS "productreviewid",
    t0."productId" AS "productid",
    t0."reviewerName" AS "reviewername",
    t1."reviewDate" AS "reviewdate",
    t0."reviewerEmail" AS "emailaddress",
    t0."ratingScore" AS "rating",
    t0."reviewComments" AS "comments",
    t1."modifiedDateUtc" AS "modifeddate",
    t1."modifiedDateString" AS "modifieddate"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "reviewComments" ORDER BY rowid) AS __rn FROM "local_1"."productReviewContact") t0
JOIN "local_1"."productReviewContactWithUpdateTimestamps" t1 ON t0."reviewComments" IS t1."reviewComments" AND t0.__rn = t1.__rn;

-- Reconstruct productsubcategory from local_1.productSubcategoryMaster
CREATE VIEW "productsubcategory" AS
SELECT
    "local_1"."productSubcategoryMaster"."productSubcategoryId" AS "productsubcategoryid",
    "local_1"."productSubcategoryMaster"."productCategoryId" AS "productcategoryid",
    "local_1"."productSubcategoryMaster"."subcategoryName" AS "name",
    "local_1"."productSubcategoryMaster"."rowGuid" AS "rowguid",
    "local_1"."productSubcategoryMaster"."lastModified" AS "modifieddate"
FROM "local_1"."productSubcategoryMaster";

-- Reconstruct salesorderdetail from vertical split + row partition on a fragment
CREATE VIEW "salesorderdetail" AS
SELECT t0.[so_id], t0.[sodetail_id], t0.[ctn_code], t0.[qty], t0.[prod_id], t1.[sp_off_id], t1.[unit_price], t1.[unit_price_disc], t0.[row_guid], t0.[mod_ts]
FROM (
SELECT [sod_detail_ctn_empty].[__orig_rowid] AS __orig_rowid, [local_2].[sod_detail_ctn_empty].[so_id], [local_2].[sod_detail_ctn_empty].[sodetail_id], [local_2].[sod_detail_ctn_empty].[ctn_code], [local_2].[sod_detail_ctn_empty].[qty], [local_2].[sod_detail_ctn_empty].[prod_id], [local_2].[sod_detail_ctn_empty].[row_guid], [local_2].[sod_detail_ctn_empty].[mod_ts] FROM [local_2].[sod_detail_ctn_empty]
UNION
SELECT [sod_detail_ctn_values].[__orig_rowid] AS __orig_rowid, [local_2].[sod_detail_ctn_values].[so_id], [local_2].[sod_detail_ctn_values].[sodetail_id], [local_2].[sod_detail_ctn_values].[ctn_code], [local_2].[sod_detail_ctn_values].[qty], [local_2].[sod_detail_ctn_values].[prod_id], [local_2].[sod_detail_ctn_values].[row_guid], [local_2].[sod_detail_ctn_values].[mod_ts] FROM [local_2].[sod_detail_ctn_values]
) t0
JOIN [local_2].[sod_detail_ctn_pricing] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct salesorderheader from vertical split + row partition on a fragment
CREATE VIEW "salesorderheader" AS
SELECT t2.[so_id], t2.[rev_num], t0.[ord_dt], t0.[due_dt], t0.[ship_dt], t2.[status_code], t2.[online_flg], t2.[po_num], t2.[acct_num], t3.[cust_id], t3.[salesp_id], t2.[terr_id], t3.[bill_addr_id], t3.[ship_addr_id], t2.[ship_method_id], t2.[cc_id], t2.[cc_auth_code], t3.[curr_rate_id], t1.[sub_total], t1.[tax_amt], t1.[freight_amt], t1.[total_due], t2.[note], t0.[row_guid], t0.[mod_ts]
FROM (
SELECT [soh_due_20130703_20131115].[__orig_rowid] AS __orig_rowid, [local_2].[soh_due_20130703_20131115].[ord_dt], [local_2].[soh_due_20130703_20131115].[due_dt], [local_2].[soh_due_20130703_20131115].[ship_dt], [local_2].[soh_due_20130703_20131115].[row_guid], [local_2].[soh_due_20130703_20131115].[mod_ts] FROM [local_2].[soh_due_20130703_20131115]
UNION
SELECT [soh_due_20131116_20140312].[__orig_rowid] AS __orig_rowid, [local_2].[soh_due_20131116_20140312].[ord_dt], [local_2].[soh_due_20131116_20140312].[due_dt], [local_2].[soh_due_20131116_20140312].[ship_dt], [local_2].[soh_due_20131116_20140312].[row_guid], [local_2].[soh_due_20131116_20140312].[mod_ts] FROM [local_2].[soh_due_20131116_20140312]
UNION
SELECT [soh_due_gt_20140312_or_null].[__orig_rowid] AS __orig_rowid, [local_2].[soh_due_gt_20140312_or_null].[ord_dt], [local_2].[soh_due_gt_20140312_or_null].[due_dt], [local_2].[soh_due_gt_20140312_or_null].[ship_dt], [local_2].[soh_due_gt_20140312_or_null].[row_guid], [local_2].[soh_due_gt_20140312_or_null].[mod_ts] FROM [local_2].[soh_due_gt_20140312_or_null]
UNION
SELECT [soh_due_lte_20130702].[__orig_rowid] AS __orig_rowid, [local_2].[soh_due_lte_20130702].[ord_dt], [local_2].[soh_due_lte_20130702].[due_dt], [local_2].[soh_due_lte_20130702].[ship_dt], [local_2].[soh_due_lte_20130702].[row_guid], [local_2].[soh_due_lte_20130702].[mod_ts] FROM [local_2].[soh_due_lte_20130702]
) t0
JOIN [local_2].[soh_totals_freight] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_2].[soh_status_core] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_2].[soh_status_full] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct salesperson from local_3.SalesRepresentative
CREATE VIEW "salesperson" AS
SELECT
    "local_3"."SalesRepresentative"."BusinessEntityKey" AS "businessentityid",
    "local_3"."SalesRepresentative"."SalesTerritoryKey" AS "territoryid",
    "local_3"."SalesRepresentative"."AnnualSalesQuota" AS "salesquota",
    "local_3"."SalesRepresentative"."BonusAmount" AS "bonus",
    "local_3"."SalesRepresentative"."CommissionRatePercent" AS "commissionpct",
    "local_3"."SalesRepresentative"."SalesYearToDateAmount" AS "salesytd",
    "local_3"."SalesRepresentative"."SalesPreviousYearAmount" AS "saleslastyear",
    "local_3"."SalesRepresentative"."RowGuidValue" AS "rowguid",
    "local_3"."SalesRepresentative"."LastModifiedTimestamp" AS "modifieddate"
FROM "local_3"."SalesRepresentative";

-- Reconstruct salesterritory from vertical (column) split (2 fragments)
CREATE VIEW "salesterritory" AS
SELECT
    t0."territory_id" AS "territoryid",
    t0."territory_name" AS "name",
    t0."country_region_code" AS "countryregioncode",
    t0."territory_group" AS "group",
    t0."sales_year_to_date" AS "salesytd",
    t0."sales_previous_year" AS "saleslastyear",
    t0."cost_year_to_date" AS "costytd",
    t0."cost_previous_year" AS "costlastyear",
    t1."row_guid" AS "rowguid",
    t0."modified_at" AS "modifieddate"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "territory_name" ORDER BY rowid) AS __rn FROM "local_4"."sales_territory_financials_last_year") t0
JOIN "local_4"."sales_territory_region_mapping" t1 ON t0."territory_name" IS t1."territory_name" AND t0.__rn = t1.__rn;
