-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/shipping/shipping.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "california_city_registry" (
    "city_key" INTEGER,
    "city_label" TEXT,
    "state_name" TEXT,
    "population_count" INTEGER,
    "surface_area" REAL
);

CREATE TABLE "other_states_city_registry" (
    "city_key" INTEGER,
    "city_label" TEXT,
    "state_name" TEXT,
    "population_count" INTEGER,
    "surface_area" REAL
);

CREATE TABLE "manufacturer_customer_addresses" (
    "customer_key" INTEGER,
    "street_address" TEXT,
    "annual_revenue_amount" INTEGER,
    "city_name" TEXT,
    "customer_name" TEXT,
    "customer_category" TEXT,
    "phone_number" TEXT
);

CREATE TABLE "customer_address_records" (
    "customer_key" INTEGER,
    "street_address" TEXT,
    "annual_revenue_amount" INTEGER,
    "city_name" TEXT,
    "phone_number" TEXT,
    "state_name" TEXT,
    "postal_code_value" REAL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "drv_profile" (
    "drv_uid" INTEGER,
    "fname" TEXT,
    "lname" TEXT,
    "addr_line" TEXT,
    "drv_city" TEXT,
    "st_code" TEXT,
    "zip_cd" INTEGER,
    "phone_no" TEXT
);

CREATE TABLE "ship_manifest" (
    "shp_uid" INTEGER,
    "cust_uid" INTEGER,
    "shp_wt" REAL,
    "trk_uid" INTEGER,
    "drv_uid" INTEGER,
    "cty_uid" INTEGER,
    "shp_dt" TEXT,
    FOREIGN KEY ("drv_uid") REFERENCES "drv_profile"("drv_uid"),
    FOREIGN KEY ("cust_uid") REFERENCES "cust_addr_retail"("cust_uid"),
    FOREIGN KEY ("cust_uid") REFERENCES "cust_addr_wholesale"("cust_uid")
);

CREATE TABLE "city_tx_fl" (
    "cty_uid" INTEGER,
    "cty_name" TEXT,
    "st_code" TEXT,
    "pop_count" INTEGER,
    "area_sq_mi" REAL
);

CREATE TABLE "city_il_mi_ma_oh_nc_mn" (
    "cty_uid" INTEGER,
    "cty_name" TEXT,
    "st_code" TEXT,
    "pop_count" INTEGER,
    "area_sq_mi" REAL
);

CREATE TABLE "cust_addr_retail" (
    "cust_uid" INTEGER,
    "addr_line" TEXT,
    "rev_annual" INTEGER,
    "cty_name" TEXT,
    "cust_nm" TEXT,
    "cust_cat" TEXT,
    "phone_no" TEXT
);

CREATE TABLE "cust_addr_wholesale" (
    "cust_uid" INTEGER,
    "addr_line" TEXT,
    "rev_annual" INTEGER,
    "cty_name" TEXT,
    "cust_nm" TEXT,
    "cust_cat" TEXT,
    "phone_no" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "cargoVehicle" (
    "vehicleId" INTEGER,
    "manufacturer" TEXT,
    "modelYear" INTEGER
);

