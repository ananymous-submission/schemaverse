-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct city from row partitions (UNION (overlap))
CREATE VIEW "city" AS
SELECT "local_1"."california_city_registry"."city_key" AS "city_id", "local_1"."california_city_registry"."city_label" AS "city_name", "local_1"."california_city_registry"."state_name" AS "state", "local_1"."california_city_registry"."population_count" AS "population", "local_1"."california_city_registry"."surface_area" AS "area" FROM "local_1"."california_city_registry"
UNION
SELECT "local_1"."other_states_city_registry"."city_key" AS "city_id", "local_1"."other_states_city_registry"."city_label" AS "city_name", "local_1"."other_states_city_registry"."state_name" AS "state", "local_1"."other_states_city_registry"."population_count" AS "population", "local_1"."other_states_city_registry"."surface_area" AS "area" FROM "local_1"."other_states_city_registry"
UNION
SELECT "local_2"."city_tx_fl"."cty_uid" AS "city_id", "local_2"."city_tx_fl"."cty_name" AS "city_name", "local_2"."city_tx_fl"."st_code" AS "state", "local_2"."city_tx_fl"."pop_count" AS "population", "local_2"."city_tx_fl"."area_sq_mi" AS "area" FROM "local_2"."city_tx_fl"
UNION
SELECT "local_2"."city_il_mi_ma_oh_nc_mn"."cty_uid" AS "city_id", "local_2"."city_il_mi_ma_oh_nc_mn"."cty_name" AS "city_name", "local_2"."city_il_mi_ma_oh_nc_mn"."st_code" AS "state", "local_2"."city_il_mi_ma_oh_nc_mn"."pop_count" AS "population", "local_2"."city_il_mi_ma_oh_nc_mn"."area_sq_mi" AS "area" FROM "local_2"."city_il_mi_ma_oh_nc_mn";

-- Reconstruct customer from vertical split + row partition on a fragment
CREATE VIEW "customer" AS
SELECT t0.[customer_key], t0.[customer_name], t0.[annual_revenue_amount], t0.[customer_category], t0.[street_address], t0.[city_name], t1.[state_name], t1.[postal_code_value], t0.[phone_number]
FROM (
SELECT [manufacturer_customer_addresses].[__orig_rowid] AS __orig_rowid, [local_1].[manufacturer_customer_addresses].[customer_key], [local_1].[manufacturer_customer_addresses].[customer_name], [local_1].[manufacturer_customer_addresses].[annual_revenue_amount], [local_1].[manufacturer_customer_addresses].[customer_category], [local_1].[manufacturer_customer_addresses].[street_address], [local_1].[manufacturer_customer_addresses].[city_name], [local_1].[manufacturer_customer_addresses].[phone_number] FROM [local_1].[manufacturer_customer_addresses]
UNION
SELECT [cust_addr_retail].[__orig_rowid] AS __orig_rowid, [local_2].[cust_addr_retail].[cust_uid], [local_2].[cust_addr_retail].[cust_nm], [local_2].[cust_addr_retail].[rev_annual], [local_2].[cust_addr_retail].[cust_cat], [local_2].[cust_addr_retail].[addr_line], [local_2].[cust_addr_retail].[cty_name], [local_2].[cust_addr_retail].[phone_no] FROM [local_2].[cust_addr_retail]
UNION
SELECT [cust_addr_wholesale].[__orig_rowid] AS __orig_rowid, [local_2].[cust_addr_wholesale].[cust_uid], [local_2].[cust_addr_wholesale].[cust_nm], [local_2].[cust_addr_wholesale].[rev_annual], [local_2].[cust_addr_wholesale].[cust_cat], [local_2].[cust_addr_wholesale].[addr_line], [local_2].[cust_addr_wholesale].[cty_name], [local_2].[cust_addr_wholesale].[phone_no] FROM [local_2].[cust_addr_wholesale]
) t0
JOIN [local_1].[customer_address_records] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct driver from local_2.drv_profile
CREATE VIEW "driver" AS
SELECT
    "local_2"."drv_profile"."drv_uid" AS "driver_id",
    "local_2"."drv_profile"."fname" AS "first_name",
    "local_2"."drv_profile"."lname" AS "last_name",
    "local_2"."drv_profile"."addr_line" AS "address",
    "local_2"."drv_profile"."drv_city" AS "city",
    "local_2"."drv_profile"."st_code" AS "state",
    "local_2"."drv_profile"."zip_cd" AS "zip_code",
    "local_2"."drv_profile"."phone_no" AS "phone"
FROM "local_2"."drv_profile";

-- Reconstruct shipment from local_2.ship_manifest
CREATE VIEW "shipment" AS
SELECT
    "local_2"."ship_manifest"."shp_uid" AS "ship_id",
    "local_2"."ship_manifest"."cust_uid" AS "cust_id",
    "local_2"."ship_manifest"."shp_wt" AS "weight",
    "local_2"."ship_manifest"."trk_uid" AS "truck_id",
    "local_2"."ship_manifest"."drv_uid" AS "driver_id",
    "local_2"."ship_manifest"."cty_uid" AS "city_id",
    "local_2"."ship_manifest"."shp_dt" AS "ship_date"
FROM "local_2"."ship_manifest";

-- Reconstruct truck from local_3.cargoVehicle
CREATE VIEW "truck" AS
SELECT
    "local_3"."cargoVehicle"."vehicleId" AS "truck_id",
    "local_3"."cargoVehicle"."manufacturer" AS "make",
    "local_3"."cargoVehicle"."modelYear" AS "model_year"
FROM "local_3"."cargoVehicle";
