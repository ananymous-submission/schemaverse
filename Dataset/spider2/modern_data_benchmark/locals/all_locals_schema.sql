-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/modern_data/modern_data.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "comp_dates" (
    "comp_id" INTEGER,
    "join_dt" TEXT,
    "found_yr" INTEGER
);

CREATE TABLE "comp_finance" (
    "comp_id" INTEGER,
    "est_val" INTEGER,
    "tot_fund" INTEGER,
    "inv_list" TEXT
);

CREATE TABLE "comp_sectors" (
    "comp_id" INTEGER,
    "sector_tag" TEXT
);

CREATE TABLE "inc_zip_stats" (
    "zip_code" INTEGER,
    "est_tot" INTEGER,
    "moe_tot" INTEGER,
    "est_med_inc" INTEGER,
    "moe_med_inc" INTEGER,
    "est_mean_inc" INTEGER,
    "moe_mean_inc" INTEGER
);

CREATE TABLE "pza_menu" (
    "pza_id" INTEGER,
    "pza_label" TEXT
);

CREATE TABLE "pza_recipes" (
    "pza_id" INTEGER,
    "top_list" TEXT
);

CREATE TABLE "dlv_riders" (
    "rider_id" INTEGER,
    "reg_dt" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "orderToppingExclusions" (
    "exclusionId" INTEGER,
    "orderReferenceId" INTEGER,
    "excludedToppingId" INTEGER,
    "exclusionCount" INTEGER
);

CREATE TABLE "toppingCatalog" (
    "toppingRefId" INTEGER,
    "toppingLabel" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "pizza_order_extras" (
    "extras_entry_id" INTEGER,
    "order_reference_id" INTEGER,
    "addon_id" INTEGER,
    "addon_quantity" INTEGER
);

CREATE TABLE "daily_health_statistics" (
    "report_date" TEXT,
    "region_name" TEXT,
    "confirmed_cases_total" INTEGER,
    "confirmed_deaths_total" INTEGER
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "CustomerOrderExclusions" (
    "CustomerIdentifier" INTEGER,
    "SpecialInstructions" TEXT,
    "ItemExclusions" TEXT,
    "OrderIdentifier" INTEGER,
    "OrderTimestamp" TEXT
);

CREATE TABLE "CustomerOrderPizzas" (
    "CustomerIdentifier" INTEGER,
    "SpecialInstructions" TEXT,
    "OrderIdentifier" INTEGER,
    "OrderTimestamp" TEXT,
    "PizzaIdentifier" INTEGER
);

CREATE TABLE "RunnerOrderAssignments" (
    "OrderIdentifier" INTEGER,
    "RunnerIdentifier" INTEGER,
    "PickupTimestamp" TEXT,
    "TripDistance" REAL,
    "TripDuration" REAL,
    "CancellationNote" TEXT
);

CREATE TABLE "RunnerOrderRecords" (
    "OrderIdentifier" INTEGER,
    "RunnerIdentifier" INTEGER,
    "PickupTimestamp" TEXT,
    "TripDistance" TEXT,
    "TripDuration" TEXT,
    "CancellationNote" TEXT
);

CREATE TABLE "StreetTreeInventory" (
    "RecordIndex" INTEGER,
    "TreeIdentifier" INTEGER,
    "DiameterAtBreastHeight" INTEGER,
    "StumpDiameter" INTEGER,
    "TreeCondition" TEXT,
    "HealthStatus" TEXT,
    "SpeciesLatinName" TEXT,
    "SpeciesCommonName" TEXT,
    "StreetAddress" TEXT,
    "ZipCode" INTEGER,
    "BoroughCode" INTEGER,
    "BoroughName" TEXT,
    "NeighborhoodName" TEXT,
    "StateCode" TEXT,
    "LatitudeCoordinate" REAL,
    "LongitudeCoordinate" REAL
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "pza_order_log" (
    "ord_id" INTEGER,
    "cust_ref" INTEGER,
    "pza_ref" INTEGER,
    "excl_specs" TEXT,
    "add_on_codes" TEXT,
    "ord_ts" TEXT
);

CREATE TABLE "lex_wordset" (
    "lex_items" TEXT
);

