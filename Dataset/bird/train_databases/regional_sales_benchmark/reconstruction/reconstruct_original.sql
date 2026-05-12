-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct Customers from local_1.ClientAccount
CREATE VIEW "Customers" AS
SELECT
    "local_1"."ClientAccount"."ClientAccountId" AS "CustomerID",
    "local_1"."ClientAccount"."CustomerFullName" AS "Customer Names"
FROM "local_1"."ClientAccount";

-- Reconstruct Products from local_1.InventoryProduct
CREATE VIEW "Products" AS
SELECT
    "local_1"."InventoryProduct"."ProductIdentifier" AS "ProductID",
    "local_1"."InventoryProduct"."ProductTitle" AS "Product Name"
FROM "local_1"."InventoryProduct";

-- Reconstruct Regions from row partitions (UNION (overlap))
CREATE VIEW "Regions" AS
SELECT "local_2"."ref_reg_south"."st_cd" AS "StateCode", "local_2"."ref_reg_south"."st_nm" AS "State", "local_2"."ref_reg_south"."reg_nm" AS "Region" FROM "local_2"."ref_reg_south"
UNION
SELECT "local_2"."ref_reg_midwest"."st_cd" AS "StateCode", "local_2"."ref_reg_midwest"."st_nm" AS "State", "local_2"."ref_reg_midwest"."reg_nm" AS "Region" FROM "local_2"."ref_reg_midwest"
UNION
SELECT "local_2"."ref_reg_west"."st_cd" AS "StateCode", "local_2"."ref_reg_west"."st_nm" AS "State", "local_2"."ref_reg_west"."reg_nm" AS "Region" FROM "local_2"."ref_reg_west"
UNION
SELECT "local_2"."ref_reg_ne"."st_cd" AS "StateCode", "local_2"."ref_reg_ne"."st_nm" AS "State", "local_2"."ref_reg_ne"."reg_nm" AS "Region" FROM "local_2"."ref_reg_ne";

-- Reconstruct Sales Orders from vertical split + row partition on a fragment
CREATE VIEW "Sales Orders" AS
SELECT t0.[SalesOrderReference], t0.[SalesChannel], t0.[WarehouseIdentifier], t2.[procuredOn], t2.[orderedOn], t2.[shippedOn], t2.[deliveredOn], t0.[CurrencyIsoCode], t1.[assignedSalesTeamKey], t1.[customerReferenceId], t1.[fulfillmentStoreLocationId], t1.[productReferenceId], t0.[QuantityOrdered], t0.[AppliedDiscount], t0.[PricePerUnit], t0.[CostPerUnit]
FROM (
SELECT [SalesOrdersByCurrencyQuantityGreaterThan3To5].[__orig_rowid] AS __orig_rowid, [local_1].[SalesOrdersByCurrencyQuantityGreaterThan3To5].[SalesOrderReference], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan3To5].[SalesChannel], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan3To5].[WarehouseIdentifier], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan3To5].[CurrencyIsoCode], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan3To5].[QuantityOrdered], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan3To5].[AppliedDiscount], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan3To5].[PricePerUnit], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan3To5].[CostPerUnit] FROM [local_1].[SalesOrdersByCurrencyQuantityGreaterThan3To5]
UNION
SELECT [SalesOrdersByCurrencyQuantityGreaterThan5To7].[__orig_rowid] AS __orig_rowid, [local_1].[SalesOrdersByCurrencyQuantityGreaterThan5To7].[SalesOrderReference], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan5To7].[SalesChannel], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan5To7].[WarehouseIdentifier], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan5To7].[CurrencyIsoCode], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan5To7].[QuantityOrdered], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan5To7].[AppliedDiscount], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan5To7].[PricePerUnit], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan5To7].[CostPerUnit] FROM [local_1].[SalesOrdersByCurrencyQuantityGreaterThan5To7]
UNION
SELECT [SalesOrdersByCurrencyQuantityGreaterThan7OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[SalesOrdersByCurrencyQuantityGreaterThan7OrNull].[SalesOrderReference], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan7OrNull].[SalesChannel], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan7OrNull].[WarehouseIdentifier], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan7OrNull].[CurrencyIsoCode], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan7OrNull].[QuantityOrdered], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan7OrNull].[AppliedDiscount], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan7OrNull].[PricePerUnit], [local_1].[SalesOrdersByCurrencyQuantityGreaterThan7OrNull].[CostPerUnit] FROM [local_1].[SalesOrdersByCurrencyQuantityGreaterThan7OrNull]
UNION
SELECT [SalesOrdersByCurrencyQuantityUpTo3].[__orig_rowid] AS __orig_rowid, [local_1].[SalesOrdersByCurrencyQuantityUpTo3].[SalesOrderReference], [local_1].[SalesOrdersByCurrencyQuantityUpTo3].[SalesChannel], [local_1].[SalesOrdersByCurrencyQuantityUpTo3].[WarehouseIdentifier], [local_1].[SalesOrdersByCurrencyQuantityUpTo3].[CurrencyIsoCode], [local_1].[SalesOrdersByCurrencyQuantityUpTo3].[QuantityOrdered], [local_1].[SalesOrdersByCurrencyQuantityUpTo3].[AppliedDiscount], [local_1].[SalesOrdersByCurrencyQuantityUpTo3].[PricePerUnit], [local_1].[SalesOrdersByCurrencyQuantityUpTo3].[CostPerUnit] FROM [local_1].[SalesOrdersByCurrencyQuantityUpTo3]
) t0
JOIN [local_3].[salesOrdersCurrencySegment] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_3].[salesOrderDates] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct Sales Team from local_3.salesTeamDirectory
CREATE VIEW "Sales Team" AS
SELECT
    "local_3"."salesTeamDirectory"."salesTeamKey" AS "SalesTeamID",
    "local_3"."salesTeamDirectory"."teamName" AS "Sales Team",
    "local_3"."salesTeamDirectory"."regionName" AS "Region"
FROM "local_3"."salesTeamDirectory";

-- Reconstruct Store Locations from vertical split + row partition on a fragment
CREATE VIEW "Store Locations" AS
SELECT t0.[store_id], t1.[cityName], t0.[cnty_name], t0.[st_cd], t1.[stateName], t0.[loc_type], t1.[latitude], t1.[longitude], t0.[area_cd], t0.[pop], t0.[hh_inc], t0.[med_inc], t0.[land_area], t0.[water_area], t0.[tz]
FROM (
SELECT [store_loc_ac_gt832].[__orig_rowid] AS __orig_rowid, [local_2].[store_loc_ac_gt832].[store_id], [local_2].[store_loc_ac_gt832].[cnty_name], [local_2].[store_loc_ac_gt832].[st_cd], [local_2].[store_loc_ac_gt832].[loc_type], [local_2].[store_loc_ac_gt832].[area_cd], [local_2].[store_loc_ac_gt832].[pop], [local_2].[store_loc_ac_gt832].[hh_inc], [local_2].[store_loc_ac_gt832].[med_inc], [local_2].[store_loc_ac_gt832].[land_area], [local_2].[store_loc_ac_gt832].[water_area], [local_2].[store_loc_ac_gt832].[tz] FROM [local_2].[store_loc_ac_gt832]
UNION
SELECT [store_loc_ac_le410].[__orig_rowid] AS __orig_rowid, [local_2].[store_loc_ac_le410].[store_id], [local_2].[store_loc_ac_le410].[cnty_name], [local_2].[store_loc_ac_le410].[st_cd], [local_2].[store_loc_ac_le410].[loc_type], [local_2].[store_loc_ac_le410].[area_cd], [local_2].[store_loc_ac_le410].[pop], [local_2].[store_loc_ac_le410].[hh_inc], [local_2].[store_loc_ac_le410].[med_inc], [local_2].[store_loc_ac_le410].[land_area], [local_2].[store_loc_ac_le410].[water_area], [local_2].[store_loc_ac_le410].[tz] FROM [local_2].[store_loc_ac_le410]
UNION
SELECT [storeLocationsAreaCodeRange411To630].[__orig_rowid] AS __orig_rowid, [local_3].[storeLocationsAreaCodeRange411To630].[locationId], [local_3].[storeLocationsAreaCodeRange411To630].[countyName], [local_3].[storeLocationsAreaCodeRange411To630].[stateIsoCode], [local_3].[storeLocationsAreaCodeRange411To630].[locationType], [local_3].[storeLocationsAreaCodeRange411To630].[areaCodeValue], [local_3].[storeLocationsAreaCodeRange411To630].[populationCount], [local_3].[storeLocationsAreaCodeRange411To630].[householdIncome], [local_3].[storeLocationsAreaCodeRange411To630].[medianHouseholdIncome], [local_3].[storeLocationsAreaCodeRange411To630].[landArea], [local_3].[storeLocationsAreaCodeRange411To630].[waterArea], [local_3].[storeLocationsAreaCodeRange411To630].[timeZoneName] FROM [local_3].[storeLocationsAreaCodeRange411To630]
UNION
SELECT [storeLocationsAreaCodeRange631To832].[__orig_rowid] AS __orig_rowid, [local_3].[storeLocationsAreaCodeRange631To832].[locationId], [local_3].[storeLocationsAreaCodeRange631To832].[countyName], [local_3].[storeLocationsAreaCodeRange631To832].[stateIsoCode], [local_3].[storeLocationsAreaCodeRange631To832].[locationType], [local_3].[storeLocationsAreaCodeRange631To832].[areaCodeValue], [local_3].[storeLocationsAreaCodeRange631To832].[populationCount], [local_3].[storeLocationsAreaCodeRange631To832].[householdIncome], [local_3].[storeLocationsAreaCodeRange631To832].[medianHouseholdIncome], [local_3].[storeLocationsAreaCodeRange631To832].[landArea], [local_3].[storeLocationsAreaCodeRange631To832].[waterArea], [local_3].[storeLocationsAreaCodeRange631To832].[timeZoneName] FROM [local_3].[storeLocationsAreaCodeRange631To832]
) t0
JOIN [local_3].[storeLocationsAreaCodeMaster] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];
