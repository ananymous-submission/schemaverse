-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/oracle_sql/oracle_sql.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "brewery_catalog" (
    "brewery_id" INTEGER,
    "brewery_name" TEXT NOT NULL
);

CREATE TABLE "channel_lookup" (
    "channel_id" INTEGER,
    "channel_name" TEXT NOT NULL,
    "channel_shortcut" TEXT NOT NULL
);

CREATE TABLE "conway_initial_cells" (
    "cell_x" INTEGER,
    "cell_y" INTEGER,
    "is_alive" INTEGER NOT NULL
);

CREATE TABLE "customer_favorite_collections" (
    "customer_reference_id" INTEGER,
    "favorite_items" TEXT,
    FOREIGN KEY ("customer_reference_id") REFERENCES "customer_profiles"("customer_id")
);

CREATE TABLE "customer_review_logs" (
    "customer_review_reference" INTEGER,
    "review_entries" TEXT
);

CREATE TABLE "customer_profiles" (
    "customer_id" INTEGER,
    "customer_name" TEXT NOT NULL
);

CREATE TABLE "employee_hire_intervals" (
    "employee_id" INTEGER,
    "hire_start_date" TEXT,
    "hire_end_date" TEXT,
    "position_title" TEXT NOT NULL
);

CREATE TABLE "employee_directory" (
    "employee_id" INTEGER,
    "employee_name" TEXT NOT NULL,
    "position_title" TEXT NOT NULL,
    "manager_id" INTEGER,
    FOREIGN KEY ("manager_id") REFERENCES "employee_directory"("employee_id")
);

CREATE TABLE "favorite_collection_types" (
    "favorite_collection_type_id" INTEGER
);

CREATE TABLE "gender_lookup" (
    "gender_code" TEXT,
    "gender_name" TEXT
);

CREATE TABLE "name_collection_entries" (
    "collection_type_id" INTEGER,
    "entry_id" INTEGER,
    "entry_name" TEXT,
    FOREIGN KEY ("collection_type_id") REFERENCES "name_collection_types"("collection_type_id")
);

CREATE TABLE "name_collection_types" (
    "collection_type_id" INTEGER
);

CREATE TABLE "name_type_registry" (
    "name_type_id" INTEGER,
    "name_type_label" TEXT
);

CREATE TABLE "locations_position_at_most_8" (
    "location_id" INTEGER,
    "warehouse_id" INTEGER NOT NULL,
    "aisle_code" TEXT NOT NULL,
    "shelf_position" INTEGER NOT NULL
);

CREATE TABLE "locations_position_over_24_or_null" (
    "location_id" INTEGER,
    "warehouse_id" INTEGER NOT NULL,
    "aisle_code" TEXT NOT NULL,
    "shelf_position" INTEGER NOT NULL
);

CREATE TABLE "customer_orders" (
    "order_id" INTEGER,
    "customer_reference_id" INTEGER NOT NULL,
    "order_placed_at" TEXT,
    "delivery_date" TEXT,
    FOREIGN KEY ("customer_reference_id") REFERENCES "customer_profiles"("customer_id")
);

CREATE TABLE "picking_batches" (
    "picklist_id" INTEGER,
    "created_at" TEXT NOT NULL,
    "picker_employee_id" INTEGER
);

CREATE TABLE "picking_log_add_actions" (
    "picklist_reference_id" INTEGER,
    "logged_at" TEXT,
    "action_code" TEXT NOT NULL,
    "location_reference_id" INTEGER,
    "pickline_number" INTEGER,
    FOREIGN KEY ("location_reference_id") REFERENCES "locations_position_at_most_8"("location_id")
);

CREATE TABLE "picking_log_pick_actions" (
    "picklist_reference_id" INTEGER,
    "logged_at" TEXT,
    "action_code" TEXT NOT NULL,
    "location_reference_id" INTEGER,
    "pickline_number" INTEGER,
    FOREIGN KEY ("location_reference_id") REFERENCES "locations_position_at_most_8"("location_id"),
    FOREIGN KEY ("picklist_reference_id") REFERENCES "picking_batches"("picklist_id")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "packageType" (
    "packageTypeId" INTEGER,
    "displayName" TEXT NOT NULL
);

CREATE TABLE "packageComposition" (
    "containerTypeId" INTEGER,
    "containedTypeId" INTEGER,
    "quantity" INTEGER NOT NULL,
    FOREIGN KEY ("containerTypeId") REFERENCES "packageType"("packageTypeId")
);

CREATE TABLE "webPageCounterHistory" (
    "applicationId" INTEGER,
    "pageNumber" INTEGER,
    "counterDate" TEXT,
    "viewCount" INTEGER NOT NULL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "ord_line_item" (
    "line_id" INTEGER,
    "ord_ref" INTEGER NOT NULL,
    "prod_ref" INTEGER NOT NULL,
    "qty_ord" REAL NOT NULL,
    "amt_total" REAL NOT NULL
);

CREATE TABLE "picklist_row" (
    "pick_id" INTEGER,
    "row_no" INTEGER,
    "loc_ref" INTEGER NOT NULL,
    "ord_ref" INTEGER NOT NULL,
    "prod_ref" INTEGER NOT NULL,
    "qty_pick" REAL NOT NULL,
    FOREIGN KEY ("loc_ref") REFERENCES "loc_upper_mid_quart"("loc_id")
);

CREATE TABLE "prod_alc_meta" (
    "prod_ref" INTEGER,
    "vol_sales" REAL NOT NULL,
    "alc_pct" REAL NOT NULL
);

CREATE TABLE "prod_cat" (
    "cat_id" INTEGER,
    "cat_name" TEXT NOT NULL
);

CREATE TABLE "prod_min_policy" (
    "prod_ref" INTEGER,
    "min_qty" REAL NOT NULL,
    "purchase_qty" REAL NOT NULL,
    FOREIGN KEY ("prod_ref") REFERENCES "prod_item"("prod_id")
);

CREATE TABLE "prod_item" (
    "prod_id" INTEGER,
    "prod_name" TEXT NOT NULL,
    "cat_ref" INTEGER NOT NULL,
    FOREIGN KEY ("cat_ref") REFERENCES "prod_cat"("cat_id")
);

CREATE TABLE "inv_mid_tercile" (
    "inv_id" INTEGER,
    "loc_ref" INTEGER NOT NULL,
    "prod_ref" INTEGER NOT NULL,
    "purch_ref" INTEGER NOT NULL,
    "qty_mid" REAL NOT NULL,
    FOREIGN KEY ("purch_ref") REFERENCES "purch_midhigh_qty"("purch_id")
);

CREATE TABLE "loc_lower_mid_quart" (
    "loc_id" INTEGER,
    "whs_ref" INTEGER NOT NULL,
    "aisle_code" TEXT NOT NULL,
    "pos_idx" INTEGER NOT NULL
);

CREATE TABLE "loc_upper_mid_quart" (
    "loc_id" INTEGER,
    "whs_ref" INTEGER NOT NULL,
    "aisle_code" TEXT NOT NULL,
    "pos_idx" INTEGER NOT NULL
);

CREATE TABLE "mth_budget_midlow" (
    "prod_ref" INTEGER,
    "mth_key" TEXT,
    "qty_midlow" REAL NOT NULL
);

CREATE TABLE "mth_budget_midhigh" (
    "prod_ref" INTEGER,
    "mth_key" TEXT,
    "qty_midhigh" REAL NOT NULL,
    FOREIGN KEY ("prod_ref") REFERENCES "prod_item"("prod_id")
);

CREATE TABLE "mth_sales_midlow" (
    "prod_ref" INTEGER,
    "mth_key" TEXT,
    "sales_midlow" INTEGER NOT NULL,
    FOREIGN KEY ("prod_ref") REFERENCES "prod_item"("prod_id")
);

CREATE TABLE "mth_sales_midhigh" (
    "prod_ref" INTEGER,
    "mth_key" TEXT,
    "sales_midhigh" INTEGER NOT NULL
);

CREATE TABLE "picklog_done" (
    "pick_id" INTEGER,
    "log_ts" TEXT,
    "act_code" TEXT NOT NULL,
    "loc_ref" INTEGER,
    "pick_row_no" INTEGER,
    FOREIGN KEY ("loc_ref") REFERENCES "loc_lower_mid_quart"("loc_id")
);

CREATE TABLE "purch_midlow_qty" (
    "purch_id" INTEGER,
    "purch_dt" TEXT NOT NULL,
    "brewer_ref" INTEGER NOT NULL,
    "prod_ref" INTEGER NOT NULL,
    "qty_midlow" INTEGER NOT NULL,
    "cost_amt" REAL NOT NULL,
    FOREIGN KEY ("prod_ref") REFERENCES "prod_item"("prod_id")
);

CREATE TABLE "purch_midhigh_qty" (
    "purch_id" INTEGER,
    "purch_dt" TEXT NOT NULL,
    "brewer_ref" INTEGER NOT NULL,
    "prod_ref" INTEGER NOT NULL,
    "qty_midhigh" INTEGER NOT NULL,
    "cost_amt" REAL NOT NULL,
    FOREIGN KEY ("prod_ref") REFERENCES "prod_item"("prod_id")
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "Inventory_UpToQty26" (
    "InventoryRecordId" INTEGER,
    "StorageLocationId" INTEGER NOT NULL,
    "ProductRefId" INTEGER NOT NULL,
    "PurchaseReferenceId" INTEGER NOT NULL,
    "Quantity" REAL NOT NULL,
    FOREIGN KEY ("PurchaseReferenceId") REFERENCES "Purchases_Above88OrNull"("PurchaseId")
);

CREATE TABLE "Inventory_Above42OrNull" (
    "InventoryRecordId" INTEGER,
    "StorageLocationId" INTEGER NOT NULL,
    "ProductRefId" INTEGER NOT NULL,
    "PurchaseLinkId" INTEGER NOT NULL,
    "Quantity" REAL NOT NULL
);

CREATE TABLE "Purchases_UpToQty37" (
    "PurchaseId" INTEGER,
    "PurchasedAt" TEXT NOT NULL,
    "BreweryRefId" INTEGER NOT NULL,
    "ProductRefId" INTEGER NOT NULL,
    "Quantity" INTEGER NOT NULL,
    "CostAmount" REAL NOT NULL
);

CREATE TABLE "Purchases_Above88OrNull" (
    "PurchaseId" INTEGER,
    "PurchasedAt" TEXT NOT NULL,
    "BreweryRefId" INTEGER NOT NULL,
    "ProductRefId" INTEGER NOT NULL,
    "Quantity" INTEGER NOT NULL,
    "CostAmount" REAL NOT NULL
);

CREATE TABLE "ServerHeartbeatLog" (
    "ServerIdentifier" TEXT NOT NULL,
    "HeartbeatTime" TEXT NOT NULL
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "equity_catalog" (
    "security_symbol" TEXT,
    "company_name" TEXT NOT NULL
);

CREATE TABLE "market_quote" (
    "security_symbol" TEXT,
    "quote_date" TEXT,
    "quote_price" REAL NOT NULL
);

-- ========================================================================
-- local_6
-- DDL file: local_6_schema.sql
-- ========================================================================

CREATE TABLE "HostedApplications" (
    "ApplicationId" INTEGER,
    "ApplicationName" TEXT NOT NULL
);

CREATE TABLE "PageVisitEvents" (
    "ClientIpAddress" TEXT NOT NULL,
    "VisitTimestamp" TEXT NOT NULL,
    "ApplicationId" INTEGER NOT NULL,
    "PageNumber" INTEGER NOT NULL,
    FOREIGN KEY ("PageNumber") REFERENCES "ApplicationPages"("PageNumber")
);

CREATE TABLE "ApplicationPages" (
    "ApplicationId" INTEGER,
    "PageNumber" INTEGER,
    "FriendlyUrl" TEXT NOT NULL
);

-- ========================================================================
-- local_7
-- DDL file: local_7_schema.sql
-- ========================================================================

CREATE TABLE "monthly_budget_lowest_quartile" (
    "product_identifier" INTEGER,
    "calendar_month" TEXT,
    "quantity" REAL NOT NULL
);

CREATE TABLE "monthly_budget_highest_quartile" (
    "product_identifier" INTEGER,
    "calendar_month" TEXT,
    "quantity" REAL NOT NULL
);

CREATE TABLE "daily_demographics_facebook_metrics" (
    "report_date" TEXT,
    "female_facebook_count" INTEGER,
    "female_facebook_quantity" INTEGER,
    "female_twitter_quantity" INTEGER,
    "male_facebook_count" INTEGER,
    "male_facebook_quantity" INTEGER,
    "male_twitter_quantity" INTEGER
);

CREATE TABLE "daily_demographics_twitter_metrics" (
    "report_date" TEXT,
    "female_facebook_quantity" INTEGER,
    "female_twitter_count" INTEGER,
    "female_twitter_quantity" INTEGER,
    "male_facebook_quantity" INTEGER,
    "male_twitter_count" INTEGER,
    "male_twitter_quantity" INTEGER
);

-- ========================================================================
-- local_8
-- DDL file: local_8_schema.sql
-- ========================================================================

CREATE TABLE "productMonthlySalesQtyAtMost11" (
    "productId" INTEGER,
    "monthLabel" TEXT,
    "unitsSold" INTEGER NOT NULL
);

CREATE TABLE "productMonthlySalesQtyAbove39OrNull" (
    "productId" INTEGER,
    "monthLabel" TEXT,
    "unitsSold" INTEGER NOT NULL
);

CREATE TABLE "dailyDeviceSessions" (
    "reportDate" TEXT,
    "desktopSessions" INTEGER,
    "tabletSessions" INTEGER,
    "mobileSessions" INTEGER
);

