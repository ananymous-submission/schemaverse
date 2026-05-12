-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";
ATTACH DATABASE 'local_6.sqlite' AS "local_6";
ATTACH DATABASE 'local_7.sqlite' AS "local_7";
ATTACH DATABASE 'local_8.sqlite' AS "local_8";

-- Reconstruct breweries from local_1.brewery_catalog
CREATE VIEW "breweries" AS
SELECT
    "local_1"."brewery_catalog"."brewery_id" AS "id",
    "local_1"."brewery_catalog"."brewery_name" AS "name"
FROM "local_1"."brewery_catalog";

-- Reconstruct channels_dim from local_1.channel_lookup
CREATE VIEW "channels_dim" AS
SELECT
    "local_1"."channel_lookup"."channel_id" AS "id",
    "local_1"."channel_lookup"."channel_name" AS "name",
    "local_1"."channel_lookup"."channel_shortcut" AS "shortcut"
FROM "local_1"."channel_lookup";

-- Reconstruct conway_gen_zero from local_1.conway_initial_cells
CREATE VIEW "conway_gen_zero" AS
SELECT
    "local_1"."conway_initial_cells"."cell_x" AS "x",
    "local_1"."conway_initial_cells"."cell_y" AS "y",
    "local_1"."conway_initial_cells"."is_alive" AS "alive"
FROM "local_1"."conway_initial_cells";

-- Reconstruct customer_favorites from local_1.customer_favorite_collections
CREATE VIEW "customer_favorites" AS
SELECT
    "local_1"."customer_favorite_collections"."customer_reference_id" AS "customer_id",
    "local_1"."customer_favorite_collections"."favorite_items" AS "favorite_list"
FROM "local_1"."customer_favorite_collections";

-- Reconstruct customer_reviews from local_1.customer_review_logs
CREATE VIEW "customer_reviews" AS
SELECT
    "local_1"."customer_review_logs"."customer_review_reference" AS "customer_id",
    "local_1"."customer_review_logs"."review_entries" AS "review_list"
FROM "local_1"."customer_review_logs";

-- Reconstruct customers from local_1.customer_profiles
CREATE VIEW "customers" AS
SELECT
    "local_1"."customer_profiles"."customer_id" AS "id",
    "local_1"."customer_profiles"."customer_name" AS "name"
FROM "local_1"."customer_profiles";

-- Reconstruct emp_hire_periods from local_1.employee_hire_intervals
CREATE VIEW "emp_hire_periods" AS
SELECT
    "local_1"."employee_hire_intervals"."employee_id" AS "emp_id",
    "local_1"."employee_hire_intervals"."hire_start_date" AS "start_",
    "local_1"."employee_hire_intervals"."hire_end_date" AS "end_",
    "local_1"."employee_hire_intervals"."position_title" AS "title"
FROM "local_1"."employee_hire_intervals";

-- Reconstruct employees from local_1.employee_directory
CREATE VIEW "employees" AS
SELECT
    "local_1"."employee_directory"."employee_id" AS "id",
    "local_1"."employee_directory"."employee_name" AS "name",
    "local_1"."employee_directory"."position_title" AS "title",
    "local_1"."employee_directory"."manager_id" AS "supervisor_id"
FROM "local_1"."employee_directory";

-- Reconstruct favorite_coll_type from local_1.favorite_collection_types
CREATE VIEW "favorite_coll_type" AS
SELECT
    "local_1"."favorite_collection_types"."favorite_collection_type_id" AS "id"
FROM "local_1"."favorite_collection_types";

-- Reconstruct gender_dim from local_1.gender_lookup
CREATE VIEW "gender_dim" AS
SELECT
    "local_1"."gender_lookup"."gender_code" AS "letter",
    "local_1"."gender_lookup"."gender_name" AS "name"
FROM "local_1"."gender_lookup";

-- Reconstruct id_name_coll_entries from local_1.name_collection_entries
CREATE VIEW "id_name_coll_entries" AS
SELECT
    "local_1"."name_collection_entries"."collection_type_id" AS "collection_id",
    "local_1"."name_collection_entries"."entry_id" AS "id",
    "local_1"."name_collection_entries"."entry_name" AS "name"
FROM "local_1"."name_collection_entries";

-- Reconstruct id_name_coll_type from local_1.name_collection_types
CREATE VIEW "id_name_coll_type" AS
SELECT
    "local_1"."name_collection_types"."collection_type_id" AS "collection_id"
FROM "local_1"."name_collection_types";

-- Reconstruct id_name_type from local_1.name_type_registry
CREATE VIEW "id_name_type" AS
SELECT
    "local_1"."name_type_registry"."name_type_id" AS "id",
    "local_1"."name_type_registry"."name_type_label" AS "name"
FROM "local_1"."name_type_registry";

-- Reconstruct inventory from row partitions (UNION (overlap))
CREATE VIEW "inventory" AS
SELECT "local_3"."inv_mid_tercile"."inv_id" AS "id", "local_3"."inv_mid_tercile"."loc_ref" AS "location_id", "local_3"."inv_mid_tercile"."prod_ref" AS "product_id", "local_3"."inv_mid_tercile"."purch_ref" AS "purchase_id", "local_3"."inv_mid_tercile"."qty_mid" AS "qty" FROM "local_3"."inv_mid_tercile"
UNION
SELECT "local_4"."Inventory_UpToQty26"."InventoryRecordId" AS "id", "local_4"."Inventory_UpToQty26"."StorageLocationId" AS "location_id", "local_4"."Inventory_UpToQty26"."ProductRefId" AS "product_id", "local_4"."Inventory_UpToQty26"."PurchaseReferenceId" AS "purchase_id", "local_4"."Inventory_UpToQty26"."Quantity" AS "qty" FROM "local_4"."Inventory_UpToQty26"
UNION
SELECT "local_4"."Inventory_Above42OrNull"."InventoryRecordId" AS "id", "local_4"."Inventory_Above42OrNull"."StorageLocationId" AS "location_id", "local_4"."Inventory_Above42OrNull"."ProductRefId" AS "product_id", "local_4"."Inventory_Above42OrNull"."PurchaseLinkId" AS "purchase_id", "local_4"."Inventory_Above42OrNull"."Quantity" AS "qty" FROM "local_4"."Inventory_Above42OrNull";

-- Reconstruct locations from row partitions (UNION (overlap))
CREATE VIEW "locations" AS
SELECT "local_1"."locations_position_at_most_8"."location_id" AS "id", "local_1"."locations_position_at_most_8"."warehouse_id" AS "warehouse", "local_1"."locations_position_at_most_8"."aisle_code" AS "aisle", "local_1"."locations_position_at_most_8"."shelf_position" AS "position" FROM "local_1"."locations_position_at_most_8"
UNION
SELECT "local_1"."locations_position_over_24_or_null"."location_id" AS "id", "local_1"."locations_position_over_24_or_null"."warehouse_id" AS "warehouse", "local_1"."locations_position_over_24_or_null"."aisle_code" AS "aisle", "local_1"."locations_position_over_24_or_null"."shelf_position" AS "position" FROM "local_1"."locations_position_over_24_or_null"
UNION
SELECT "local_3"."loc_lower_mid_quart"."loc_id" AS "id", "local_3"."loc_lower_mid_quart"."whs_ref" AS "warehouse", "local_3"."loc_lower_mid_quart"."aisle_code" AS "aisle", "local_3"."loc_lower_mid_quart"."pos_idx" AS "position" FROM "local_3"."loc_lower_mid_quart"
UNION
SELECT "local_3"."loc_upper_mid_quart"."loc_id" AS "id", "local_3"."loc_upper_mid_quart"."whs_ref" AS "warehouse", "local_3"."loc_upper_mid_quart"."aisle_code" AS "aisle", "local_3"."loc_upper_mid_quart"."pos_idx" AS "position" FROM "local_3"."loc_upper_mid_quart";

-- Reconstruct monthly_budget from row partitions (UNION (overlap))
CREATE VIEW "monthly_budget" AS
SELECT "local_3"."mth_budget_midlow"."prod_ref" AS "product_id", "local_3"."mth_budget_midlow"."mth_key" AS "mth", "local_3"."mth_budget_midlow"."qty_midlow" AS "qty" FROM "local_3"."mth_budget_midlow"
UNION
SELECT "local_3"."mth_budget_midhigh"."prod_ref" AS "product_id", "local_3"."mth_budget_midhigh"."mth_key" AS "mth", "local_3"."mth_budget_midhigh"."qty_midhigh" AS "qty" FROM "local_3"."mth_budget_midhigh"
UNION
SELECT "local_7"."monthly_budget_lowest_quartile"."product_identifier" AS "product_id", "local_7"."monthly_budget_lowest_quartile"."calendar_month" AS "mth", "local_7"."monthly_budget_lowest_quartile"."quantity" AS "qty" FROM "local_7"."monthly_budget_lowest_quartile"
UNION
SELECT "local_7"."monthly_budget_highest_quartile"."product_identifier" AS "product_id", "local_7"."monthly_budget_highest_quartile"."calendar_month" AS "mth", "local_7"."monthly_budget_highest_quartile"."quantity" AS "qty" FROM "local_7"."monthly_budget_highest_quartile";

-- Reconstruct monthly_sales from row partitions (UNION (overlap))
CREATE VIEW "monthly_sales" AS
SELECT "local_3"."mth_sales_midlow"."prod_ref" AS "product_id", "local_3"."mth_sales_midlow"."mth_key" AS "mth", "local_3"."mth_sales_midlow"."sales_midlow" AS "qty" FROM "local_3"."mth_sales_midlow"
UNION
SELECT "local_3"."mth_sales_midhigh"."prod_ref" AS "product_id", "local_3"."mth_sales_midhigh"."mth_key" AS "mth", "local_3"."mth_sales_midhigh"."sales_midhigh" AS "qty" FROM "local_3"."mth_sales_midhigh"
UNION
SELECT "local_8"."productMonthlySalesQtyAtMost11"."productId" AS "product_id", "local_8"."productMonthlySalesQtyAtMost11"."monthLabel" AS "mth", "local_8"."productMonthlySalesQtyAtMost11"."unitsSold" AS "qty" FROM "local_8"."productMonthlySalesQtyAtMost11"
UNION
SELECT "local_8"."productMonthlySalesQtyAbove39OrNull"."productId" AS "product_id", "local_8"."productMonthlySalesQtyAbove39OrNull"."monthLabel" AS "mth", "local_8"."productMonthlySalesQtyAbove39OrNull"."unitsSold" AS "qty" FROM "local_8"."productMonthlySalesQtyAbove39OrNull";

-- Reconstruct orderlines from local_3.ord_line_item
CREATE VIEW "orderlines" AS
SELECT
    "local_3"."ord_line_item"."line_id" AS "id",
    "local_3"."ord_line_item"."ord_ref" AS "order_id",
    "local_3"."ord_line_item"."prod_ref" AS "product_id",
    "local_3"."ord_line_item"."qty_ord" AS "qty",
    "local_3"."ord_line_item"."amt_total" AS "amount"
FROM "local_3"."ord_line_item";

-- Reconstruct orders from local_1.customer_orders
CREATE VIEW "orders" AS
SELECT
    "local_1"."customer_orders"."order_id" AS "id",
    "local_1"."customer_orders"."customer_reference_id" AS "customer_id",
    "local_1"."customer_orders"."order_placed_at" AS "ordered",
    "local_1"."customer_orders"."delivery_date" AS "delivery"
FROM "local_1"."customer_orders";

-- Reconstruct packaging from local_2.packageType
CREATE VIEW "packaging" AS
SELECT
    "local_2"."packageType"."packageTypeId" AS "id",
    "local_2"."packageType"."displayName" AS "name"
FROM "local_2"."packageType";

-- Reconstruct packaging_relations from local_2.packageComposition
CREATE VIEW "packaging_relations" AS
SELECT
    "local_2"."packageComposition"."containerTypeId" AS "packaging_id",
    "local_2"."packageComposition"."containedTypeId" AS "contains_id",
    "local_2"."packageComposition"."quantity" AS "qty"
FROM "local_2"."packageComposition";

-- Reconstruct picking_line from local_3.picklist_row
CREATE VIEW "picking_line" AS
SELECT
    "local_3"."picklist_row"."pick_id" AS "picklist_id",
    "local_3"."picklist_row"."row_no" AS "line_no",
    "local_3"."picklist_row"."loc_ref" AS "location_id",
    "local_3"."picklist_row"."ord_ref" AS "order_id",
    "local_3"."picklist_row"."prod_ref" AS "product_id",
    "local_3"."picklist_row"."qty_pick" AS "qty"
FROM "local_3"."picklist_row";

-- Reconstruct picking_list from local_1.picking_batches
CREATE VIEW "picking_list" AS
SELECT
    "local_1"."picking_batches"."picklist_id" AS "id",
    "local_1"."picking_batches"."created_at" AS "created",
    "local_1"."picking_batches"."picker_employee_id" AS "picker_emp_id"
FROM "local_1"."picking_batches";

-- Reconstruct picking_log from row partitions (UNION (overlap))
CREATE VIEW "picking_log" AS
SELECT "local_1"."picking_log_add_actions"."picklist_reference_id" AS "picklist_id", "local_1"."picking_log_add_actions"."logged_at" AS "log_time", "local_1"."picking_log_add_actions"."action_code" AS "activity", "local_1"."picking_log_add_actions"."location_reference_id" AS "location_id", "local_1"."picking_log_add_actions"."pickline_number" AS "pickline_no" FROM "local_1"."picking_log_add_actions"
UNION
SELECT "local_1"."picking_log_pick_actions"."picklist_reference_id" AS "picklist_id", "local_1"."picking_log_pick_actions"."logged_at" AS "log_time", "local_1"."picking_log_pick_actions"."action_code" AS "activity", "local_1"."picking_log_pick_actions"."location_reference_id" AS "location_id", "local_1"."picking_log_pick_actions"."pickline_number" AS "pickline_no" FROM "local_1"."picking_log_pick_actions"
UNION
SELECT "local_3"."picklog_done"."pick_id" AS "picklist_id", "local_3"."picklog_done"."log_ts" AS "log_time", "local_3"."picklog_done"."act_code" AS "activity", "local_3"."picklog_done"."loc_ref" AS "location_id", "local_3"."picklog_done"."pick_row_no" AS "pickline_no" FROM "local_3"."picklog_done";

-- Reconstruct product_alcohol from local_3.prod_alc_meta
CREATE VIEW "product_alcohol" AS
SELECT
    "local_3"."prod_alc_meta"."prod_ref" AS "product_id",
    "local_3"."prod_alc_meta"."vol_sales" AS "sales_volume",
    "local_3"."prod_alc_meta"."alc_pct" AS "abv"
FROM "local_3"."prod_alc_meta";

-- Reconstruct product_groups from local_3.prod_cat
CREATE VIEW "product_groups" AS
SELECT
    "local_3"."prod_cat"."cat_id" AS "id",
    "local_3"."prod_cat"."cat_name" AS "name"
FROM "local_3"."prod_cat";

-- Reconstruct product_minimums from local_3.prod_min_policy
CREATE VIEW "product_minimums" AS
SELECT
    "local_3"."prod_min_policy"."prod_ref" AS "product_id",
    "local_3"."prod_min_policy"."min_qty" AS "qty_minimum",
    "local_3"."prod_min_policy"."purchase_qty" AS "qty_purchase"
FROM "local_3"."prod_min_policy";

-- Reconstruct products from local_3.prod_item
CREATE VIEW "products" AS
SELECT
    "local_3"."prod_item"."prod_id" AS "id",
    "local_3"."prod_item"."prod_name" AS "name",
    "local_3"."prod_item"."cat_ref" AS "group_id"
FROM "local_3"."prod_item";

-- Reconstruct purchases from row partitions (UNION (overlap))
CREATE VIEW "purchases" AS
SELECT "local_3"."purch_midlow_qty"."purch_id" AS "id", "local_3"."purch_midlow_qty"."purch_dt" AS "purchased", "local_3"."purch_midlow_qty"."brewer_ref" AS "brewery_id", "local_3"."purch_midlow_qty"."prod_ref" AS "product_id", "local_3"."purch_midlow_qty"."qty_midlow" AS "qty", "local_3"."purch_midlow_qty"."cost_amt" AS "cost" FROM "local_3"."purch_midlow_qty"
UNION
SELECT "local_3"."purch_midhigh_qty"."purch_id" AS "id", "local_3"."purch_midhigh_qty"."purch_dt" AS "purchased", "local_3"."purch_midhigh_qty"."brewer_ref" AS "brewery_id", "local_3"."purch_midhigh_qty"."prod_ref" AS "product_id", "local_3"."purch_midhigh_qty"."qty_midhigh" AS "qty", "local_3"."purch_midhigh_qty"."cost_amt" AS "cost" FROM "local_3"."purch_midhigh_qty"
UNION
SELECT "local_4"."Purchases_UpToQty37"."PurchaseId" AS "id", "local_4"."Purchases_UpToQty37"."PurchasedAt" AS "purchased", "local_4"."Purchases_UpToQty37"."BreweryRefId" AS "brewery_id", "local_4"."Purchases_UpToQty37"."ProductRefId" AS "product_id", "local_4"."Purchases_UpToQty37"."Quantity" AS "qty", "local_4"."Purchases_UpToQty37"."CostAmount" AS "cost" FROM "local_4"."Purchases_UpToQty37"
UNION
SELECT "local_4"."Purchases_Above88OrNull"."PurchaseId" AS "id", "local_4"."Purchases_Above88OrNull"."PurchasedAt" AS "purchased", "local_4"."Purchases_Above88OrNull"."BreweryRefId" AS "brewery_id", "local_4"."Purchases_Above88OrNull"."ProductRefId" AS "product_id", "local_4"."Purchases_Above88OrNull"."Quantity" AS "qty", "local_4"."Purchases_Above88OrNull"."CostAmount" AS "cost" FROM "local_4"."Purchases_Above88OrNull";

-- Reconstruct server_heartbeat from local_4.ServerHeartbeatLog
CREATE VIEW "server_heartbeat" AS
SELECT
    "local_4"."ServerHeartbeatLog"."ServerIdentifier" AS "server",
    "local_4"."ServerHeartbeatLog"."HeartbeatTime" AS "beat_time"
FROM "local_4"."ServerHeartbeatLog";

-- Reconstruct stock from local_5.equity_catalog
CREATE VIEW "stock" AS
SELECT
    "local_5"."equity_catalog"."security_symbol" AS "symbol",
    "local_5"."equity_catalog"."company_name" AS "company"
FROM "local_5"."equity_catalog";

-- Reconstruct ticker from local_5.market_quote
CREATE VIEW "ticker" AS
SELECT
    "local_5"."market_quote"."security_symbol" AS "symbol",
    "local_5"."market_quote"."quote_date" AS "day",
    "local_5"."market_quote"."quote_price" AS "price"
FROM "local_5"."market_quote";

-- Reconstruct web_apps from local_6.HostedApplications
CREATE VIEW "web_apps" AS
SELECT
    "local_6"."HostedApplications"."ApplicationId" AS "id",
    "local_6"."HostedApplications"."ApplicationName" AS "name"
FROM "local_6"."HostedApplications";

-- Reconstruct web_counter_hist from local_2.webPageCounterHistory
CREATE VIEW "web_counter_hist" AS
SELECT
    "local_2"."webPageCounterHistory"."applicationId" AS "app_id",
    "local_2"."webPageCounterHistory"."pageNumber" AS "page_no",
    "local_2"."webPageCounterHistory"."counterDate" AS "day",
    "local_2"."webPageCounterHistory"."viewCount" AS "counter"
FROM "local_2"."webPageCounterHistory";

-- Reconstruct web_demographics from vertical (column) split (2 fragments)
CREATE VIEW "web_demographics" AS
SELECT
    t0."report_date" AS "day",
    t1."male_twitter_count" AS "m_tw_cnt",
    t0."male_twitter_quantity" AS "m_tw_qty",
    t0."male_facebook_count" AS "m_fb_cnt",
    t0."male_facebook_quantity" AS "m_fb_qty",
    t1."female_twitter_count" AS "f_tw_cnt",
    t0."female_twitter_quantity" AS "f_tw_qty",
    t0."female_facebook_count" AS "f_fb_cnt",
    t0."female_facebook_quantity" AS "f_fb_qty"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "report_date" ORDER BY rowid) AS __rn FROM "local_7"."daily_demographics_facebook_metrics") t0
JOIN "local_7"."daily_demographics_twitter_metrics" t1 ON t0."report_date" IS t1."report_date" AND t0.__rn = t1.__rn;

-- Reconstruct web_devices from local_8.dailyDeviceSessions
CREATE VIEW "web_devices" AS
SELECT
    "local_8"."dailyDeviceSessions"."reportDate" AS "day",
    "local_8"."dailyDeviceSessions"."desktopSessions" AS "pc",
    "local_8"."dailyDeviceSessions"."tabletSessions" AS "tablet",
    "local_8"."dailyDeviceSessions"."mobileSessions" AS "phone"
FROM "local_8"."dailyDeviceSessions";

-- Reconstruct web_page_visits from local_6.PageVisitEvents
CREATE VIEW "web_page_visits" AS
SELECT
    "local_6"."PageVisitEvents"."ClientIpAddress" AS "client_ip",
    "local_6"."PageVisitEvents"."VisitTimestamp" AS "visit_time",
    "local_6"."PageVisitEvents"."ApplicationId" AS "app_id",
    "local_6"."PageVisitEvents"."PageNumber" AS "page_no"
FROM "local_6"."PageVisitEvents";

-- Reconstruct web_pages from local_6.ApplicationPages
CREATE VIEW "web_pages" AS
SELECT
    "local_6"."ApplicationPages"."ApplicationId" AS "app_id",
    "local_6"."ApplicationPages"."PageNumber" AS "page_no",
    "local_6"."ApplicationPages"."FriendlyUrl" AS "friendly_url"
FROM "local_6"."ApplicationPages";
