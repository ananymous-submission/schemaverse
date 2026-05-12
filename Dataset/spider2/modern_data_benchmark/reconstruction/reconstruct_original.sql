-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";

-- Reconstruct companies_dates from local_1.comp_dates
CREATE VIEW "companies_dates" AS
SELECT
    "local_1"."comp_dates"."comp_id" AS "company_id",
    "local_1"."comp_dates"."join_dt" AS "date_joined",
    "local_1"."comp_dates"."found_yr" AS "year_founded"
FROM "local_1"."comp_dates";

-- Reconstruct companies_funding from local_1.comp_finance
CREATE VIEW "companies_funding" AS
SELECT
    "local_1"."comp_finance"."comp_id" AS "company_id",
    "local_1"."comp_finance"."est_val" AS "valuation",
    "local_1"."comp_finance"."tot_fund" AS "funding",
    "local_1"."comp_finance"."inv_list" AS "select_investors"
FROM "local_1"."comp_finance";

-- Reconstruct companies_industries from local_1.comp_sectors
CREATE VIEW "companies_industries" AS
SELECT
    "local_1"."comp_sectors"."comp_id" AS "company_id",
    "local_1"."comp_sectors"."sector_tag" AS "industry"
FROM "local_1"."comp_sectors";

-- Reconstruct income_trees from local_1.inc_zip_stats
CREATE VIEW "income_trees" AS
SELECT
    "local_1"."inc_zip_stats"."zip_code" AS "zipcode",
    "local_1"."inc_zip_stats"."est_tot" AS "Estimate_Total",
    "local_1"."inc_zip_stats"."moe_tot" AS "Margin_of_Error_Total",
    "local_1"."inc_zip_stats"."est_med_inc" AS "Estimate_Median_income",
    "local_1"."inc_zip_stats"."moe_med_inc" AS "Margin_of_Error_Median_income",
    "local_1"."inc_zip_stats"."est_mean_inc" AS "Estimate_Mean_income",
    "local_1"."inc_zip_stats"."moe_mean_inc" AS "Margin_of_Error_Mean_income"
FROM "local_1"."inc_zip_stats";

-- Reconstruct pizza_clean_customer_orders from vertical (column) split (2 fragments)
CREATE VIEW "pizza_clean_customer_orders" AS
SELECT
    t0."OrderIdentifier" AS "order_id",
    t0."CustomerIdentifier" AS "customer_id",
    t1."PizzaIdentifier" AS "pizza_id",
    t0."ItemExclusions" AS "exclusions",
    t0."SpecialInstructions" AS "extras",
    t0."OrderTimestamp" AS "order_time"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "CustomerIdentifier", "SpecialInstructions" ORDER BY rowid) AS __rn FROM "local_4"."CustomerOrderExclusions") t0
JOIN "local_4"."CustomerOrderPizzas" t1 ON t0."CustomerIdentifier" IS t1."CustomerIdentifier" AND t0."SpecialInstructions" IS t1."SpecialInstructions" AND t0.__rn = t1.__rn;

-- Reconstruct pizza_clean_runner_orders from local_4.RunnerOrderAssignments
CREATE VIEW "pizza_clean_runner_orders" AS
SELECT
    "local_4"."RunnerOrderAssignments"."OrderIdentifier" AS "order_id",
    "local_4"."RunnerOrderAssignments"."RunnerIdentifier" AS "runner_id",
    "local_4"."RunnerOrderAssignments"."PickupTimestamp" AS "pickup_time",
    "local_4"."RunnerOrderAssignments"."TripDistance" AS "distance",
    "local_4"."RunnerOrderAssignments"."TripDuration" AS "duration",
    "local_4"."RunnerOrderAssignments"."CancellationNote" AS "cancellation"
FROM "local_4"."RunnerOrderAssignments";

-- Reconstruct pizza_customer_orders from local_5.pza_order_log
CREATE VIEW "pizza_customer_orders" AS
SELECT
    "local_5"."pza_order_log"."ord_id" AS "order_id",
    "local_5"."pza_order_log"."cust_ref" AS "customer_id",
    "local_5"."pza_order_log"."pza_ref" AS "pizza_id",
    "local_5"."pza_order_log"."excl_specs" AS "exclusions",
    "local_5"."pza_order_log"."add_on_codes" AS "extras",
    "local_5"."pza_order_log"."ord_ts" AS "order_time"
FROM "local_5"."pza_order_log";

-- Reconstruct pizza_get_exclusions from local_2.orderToppingExclusions
CREATE VIEW "pizza_get_exclusions" AS
SELECT
    "local_2"."orderToppingExclusions"."exclusionId" AS "row_id",
    "local_2"."orderToppingExclusions"."orderReferenceId" AS "order_id",
    "local_2"."orderToppingExclusions"."excludedToppingId" AS "exclusions",
    "local_2"."orderToppingExclusions"."exclusionCount" AS "total_exclusions"
FROM "local_2"."orderToppingExclusions";

-- Reconstruct pizza_get_extras from local_3.pizza_order_extras
CREATE VIEW "pizza_get_extras" AS
SELECT
    "local_3"."pizza_order_extras"."extras_entry_id" AS "row_id",
    "local_3"."pizza_order_extras"."order_reference_id" AS "order_id",
    "local_3"."pizza_order_extras"."addon_id" AS "extras",
    "local_3"."pizza_order_extras"."addon_quantity" AS "extras_count"
FROM "local_3"."pizza_order_extras";

-- Reconstruct pizza_names from local_1.pza_menu
CREATE VIEW "pizza_names" AS
SELECT
    "local_1"."pza_menu"."pza_id" AS "pizza_id",
    "local_1"."pza_menu"."pza_label" AS "pizza_name"
FROM "local_1"."pza_menu";

-- Reconstruct pizza_recipes from local_1.pza_recipes
CREATE VIEW "pizza_recipes" AS
SELECT
    "local_1"."pza_recipes"."pza_id" AS "pizza_id",
    "local_1"."pza_recipes"."top_list" AS "toppings"
FROM "local_1"."pza_recipes";

-- Reconstruct pizza_runner_orders from local_4.RunnerOrderRecords
CREATE VIEW "pizza_runner_orders" AS
SELECT
    "local_4"."RunnerOrderRecords"."OrderIdentifier" AS "order_id",
    "local_4"."RunnerOrderRecords"."RunnerIdentifier" AS "runner_id",
    "local_4"."RunnerOrderRecords"."PickupTimestamp" AS "pickup_time",
    "local_4"."RunnerOrderRecords"."TripDistance" AS "distance",
    "local_4"."RunnerOrderRecords"."TripDuration" AS "duration",
    "local_4"."RunnerOrderRecords"."CancellationNote" AS "cancellation"
FROM "local_4"."RunnerOrderRecords";

-- Reconstruct pizza_runners from local_1.dlv_riders
CREATE VIEW "pizza_runners" AS
SELECT
    "local_1"."dlv_riders"."rider_id" AS "runner_id",
    "local_1"."dlv_riders"."reg_dt" AS "registration_date"
FROM "local_1"."dlv_riders";

-- Reconstruct pizza_toppings from local_2.toppingCatalog
CREATE VIEW "pizza_toppings" AS
SELECT
    "local_2"."toppingCatalog"."toppingRefId" AS "topping_id",
    "local_2"."toppingCatalog"."toppingLabel" AS "topping_name"
FROM "local_2"."toppingCatalog";

-- Reconstruct statistics from local_3.daily_health_statistics
CREATE VIEW "statistics" AS
SELECT
    "local_3"."daily_health_statistics"."report_date" AS "date",
    "local_3"."daily_health_statistics"."region_name" AS "state",
    "local_3"."daily_health_statistics"."confirmed_cases_total" AS "total_cases",
    "local_3"."daily_health_statistics"."confirmed_deaths_total" AS "total_deaths"
FROM "local_3"."daily_health_statistics";

-- Reconstruct trees from local_4.StreetTreeInventory
CREATE VIEW "trees" AS
SELECT
    "local_4"."StreetTreeInventory"."RecordIndex" AS "idx",
    "local_4"."StreetTreeInventory"."TreeIdentifier" AS "tree_id",
    "local_4"."StreetTreeInventory"."DiameterAtBreastHeight" AS "tree_dbh",
    "local_4"."StreetTreeInventory"."StumpDiameter" AS "stump_diam",
    "local_4"."StreetTreeInventory"."TreeCondition" AS "status",
    "local_4"."StreetTreeInventory"."HealthStatus" AS "health",
    "local_4"."StreetTreeInventory"."SpeciesLatinName" AS "spc_latin",
    "local_4"."StreetTreeInventory"."SpeciesCommonName" AS "spc_common",
    "local_4"."StreetTreeInventory"."StreetAddress" AS "address",
    "local_4"."StreetTreeInventory"."ZipCode" AS "zipcode",
    "local_4"."StreetTreeInventory"."BoroughCode" AS "borocode",
    "local_4"."StreetTreeInventory"."BoroughName" AS "boroname",
    "local_4"."StreetTreeInventory"."NeighborhoodName" AS "nta_name",
    "local_4"."StreetTreeInventory"."StateCode" AS "state",
    "local_4"."StreetTreeInventory"."LatitudeCoordinate" AS "latitude",
    "local_4"."StreetTreeInventory"."LongitudeCoordinate" AS "longitude"
FROM "local_4"."StreetTreeInventory";

-- Reconstruct word_list from local_5.lex_wordset
CREATE VIEW "word_list" AS
SELECT
    "local_5"."lex_wordset"."lex_items" AS "words"
FROM "local_5"."lex_wordset";
