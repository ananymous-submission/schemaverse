-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/bank_sales_trading/bank_sales_trading.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "cryptoAccountMembers" (
    "memberId" TEXT,
    "givenName" TEXT,
    "homeRegion" TEXT
);

CREATE TABLE "weeklySalesByAgeBand" (
    "weekStartDate" TEXT,
    "totalSales" INTEGER,
    "ageBand" TEXT,
    "customerSegment" TEXT
);

CREATE TABLE "weeklySalesAvgTransactionByRegion" (
    "weekStartDate" TEXT,
    "totalSales" INTEGER,
    "avgTransactionValue" REAL,
    "calendarYear" INTEGER,
    "monthNumber" INTEGER,
    "regionCode" TEXT,
    "transactionCount" INTEGER
);

CREATE TABLE "weeklySalesAvgTransactionByRegionWithWeekNumber" (
    "weekStartDate" TEXT,
    "totalSales" INTEGER,
    "avgTransactionValue" REAL,
    "calendarYear" INTEGER,
    "monthNumber" INTEGER,
    "regionCode" TEXT,
    "transactionCount" INTEGER,
    "weekOfYear" INTEGER
);

CREATE TABLE "weeklySalesExistingCustomers" (
    "weekStartDate" TEXT,
    "totalSales" INTEGER,
    "customerType" TEXT,
    "demographicGroup" TEXT
);

CREATE TABLE "weeklySalesNewOrGuestCustomers" (
    "weekStartDate" TEXT,
    "totalSales" INTEGER,
    "customerType" TEXT,
    "demographicGroup" TEXT
);

CREATE TABLE "weeklySalesByPlatform" (
    "weekStartDate" TEXT,
    "totalSales" INTEGER,
    "salesPlatform" TEXT,
    "weekStartFormatted" TEXT
);

CREATE TABLE "regionLookup" (
    "regionId" INTEGER,
    "regionName" TEXT
);

CREATE TABLE "interestMapCreatedUpTo2017Mar27" (
    "interestId" INTEGER,
    "interestName" TEXT,
    "interestSummary" TEXT,
    "createdAt" TEXT,
    "lastModified" TEXT
);

CREATE TABLE "interestMapCreatedAfter2017Mar27Until2018May15" (
    "interestId" INTEGER,
    "interestName" TEXT,
    "interestSummary" TEXT,
    "createdAt" TEXT,
    "lastModified" TEXT
);

CREATE TABLE "interestMapCreatedAfter2018May15Until2018Oct22" (
    "interestId" INTEGER,
    "interestName" TEXT,
    "interestSummary" TEXT,
    "createdAt" TEXT,
    "lastModified" TEXT
);

CREATE TABLE "interestMapCreatedAfter2018Oct22OrNull" (
    "interestId" INTEGER,
    "interestName" TEXT,
    "interestSummary" TEXT,
    "createdAt" TEXT,
    "lastModified" TEXT
);

CREATE TABLE "interestMetricsByMonth" (
    "monthYear" TEXT,
    "interestId" REAL,
    "monthNumeric" REAL,
    "yearNumeric" REAL,
    "composition" REAL,
    "indexValue" REAL,
    "ranking" INTEGER
);

CREATE TABLE "interestCompositionAtMost2Point22" (
    "monthYear" TEXT,
    "interestId" REAL,
    "composition" REAL,
    "indexValue" REAL,
    "percentileRanking" REAL,
    "ranking" INTEGER
);

CREATE TABLE "interestCompositionBetween2Point22And2Point86" (
    "monthYear" TEXT,
    "interestId" REAL,
    "composition" REAL,
    "indexValue" REAL,
    "percentileRanking" REAL,
    "ranking" INTEGER
);

CREATE TABLE "interestCompositionBetween2Point86And3Point87" (
    "monthYear" TEXT,
    "interestId" REAL,
    "composition" REAL,
    "indexValue" REAL,
    "percentileRanking" REAL,
    "ranking" INTEGER
);

CREATE TABLE "interestCompositionAbove3Point87OrNull" (
    "monthYear" TEXT,
    "interestId" REAL,
    "composition" REAL,
    "indexValue" REAL,
    "percentileRanking" REAL,
    "ranking" INTEGER
);

CREATE TABLE "shoppingCartUsersStartedOnOrBefore2020Feb01" (
    "userId" INTEGER,
    "cookieId" TEXT,
    "startDate" TEXT
);

CREATE TABLE "shoppingCartUsersStartedAfter2020Mar09OrNull" (
    "userId" INTEGER,
    "cookieId" TEXT,
    "startDate" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "ClientTransactions" (
    "ClientId" INTEGER,
    "TransactionDate" TEXT,
    "TransactionType" TEXT,
    "TransactionAmount" INTEGER
);

CREATE TABLE "CartPromotionCampaigns" (
    "CampaignKey" INTEGER,
    "ProductList" TEXT,
    "CampaignTitle" TEXT,
    "CampaignStart" TEXT,
    "CampaignEnd" TEXT
);

CREATE TABLE "BitcoinSellTransactions" (
    "TransactionId" INTEGER,
    "AccountId" TEXT,
    "TickerSymbol" TEXT,
    "TransactionDate" TEXT,
    "TradeType" TEXT,
    "Quantity" REAL,
    "FeePercent" REAL,
    "TransactionTime" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "cart_event_type_lookup" (
    "event_code" INTEGER,
    "event_label" TEXT
);

CREATE TABLE "cart_events_sequence_early" (
    "session_id" TEXT,
    "browser_cookie" TEXT,
    "page_ref_id" INTEGER,
    "event_code" INTEGER,
    "sequence_index" INTEGER,
    "occurred_at" TEXT
);

CREATE TABLE "cart_events_sequence_late_or_null" (
    "session_id" TEXT,
    "browser_cookie" TEXT,
    "page_ref_id" INTEGER,
    "event_code" INTEGER,
    "sequence_index" INTEGER,
    "occurred_at" TEXT
);

CREATE TABLE "cart_users_started_after_2020_02_01_up_to_2020_02_19" (
    "account_id" INTEGER,
    "browser_cookie" TEXT,
    "registration_date" TEXT
);

CREATE TABLE "cart_users_started_after_2020_02_19_up_to_2020_03_09" (
    "account_id" INTEGER,
    "browser_cookie" TEXT,
    "registration_date" TEXT
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "btc_txn_buy_log" (
    "tx_id" INTEGER,
    "mem_id" TEXT,
    "asset_sym" TEXT,
    "tx_date" TEXT,
    "tx_side" TEXT,
    "qty" REAL,
    "pct_fee" REAL,
    "tx_time" TEXT
);

CREATE TABLE "cust_node_end_lte_20200217" (
    "cust_id" INTEGER,
    "reg_id" INTEGER,
    "nd_id" INTEGER,
    "start_dt" TEXT,
    "end_dt" TEXT
);

CREATE TABLE "cust_node_end_gt_20200217_lte_20200315" (
    "cust_id" INTEGER,
    "reg_id" INTEGER,
    "nd_id" INTEGER,
    "start_dt" TEXT,
    "end_dt" TEXT
);

CREATE TABLE "cust_node_end_gt_20200315_lte_20200419" (
    "cust_id" INTEGER,
    "reg_id" INTEGER,
    "nd_id" INTEGER,
    "start_dt" TEXT,
    "end_dt" TEXT
);

CREATE TABLE "cust_node_end_gt_20200419_or_null" (
    "cust_id" INTEGER,
    "reg_id" INTEGER,
    "nd_id" INTEGER,
    "start_dt" TEXT,
    "end_dt" TEXT
);

CREATE TABLE "cart_pg_hier" (
    "pg_id" INTEGER,
    "pg_name" TEXT,
    "prod_cat" TEXT,
    "prod_id" REAL
);

CREATE TABLE "cart_evt_seq_gt3_lte6" (
    "vis_id" TEXT,
    "ck_id" TEXT,
    "pg_id" INTEGER,
    "evt_type" INTEGER,
    "seq_no" INTEGER,
    "evt_time" TEXT
);

CREATE TABLE "cart_evt_seq_gt6_lte10" (
    "vis_id" TEXT,
    "ck_id" TEXT,
    "pg_id" INTEGER,
    "evt_type" INTEGER,
    "seq_no" INTEGER,
    "evt_time" TEXT
);

CREATE TABLE "veg_txn_dow_misc" (
    "idx" INTEGER,
    "dow" TEXT,
    "disc_pct" INTEGER,
    "item_cd" INTEGER,
    "qty_kg" REAL,
    "tx_dt" TEXT,
    "px_rmb_per_kg" REAL
);

CREATE TABLE "veg_txn_dow_gt20210206_lte20211011" (
    "idx" INTEGER,
    "dow" TEXT,
    "disc_pct" INTEGER,
    "item_cd" INTEGER,
    "sale_ret_flag" TEXT,
    "tx_dt" TEXT,
    "tx_tm" TEXT
);

CREATE TABLE "veg_txn_dow_gt20211011_lte20220910" (
    "idx" INTEGER,
    "dow" TEXT,
    "disc_pct" INTEGER,
    "item_cd" INTEGER,
    "sale_ret_flag" TEXT,
    "tx_dt" TEXT,
    "tx_tm" TEXT
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "veg_cat_catcode_lte_1011010101" (
    "row_idx" INTEGER,
    "itm_cd" INTEGER,
    "itm_nm" TEXT,
    "cat_cd" INTEGER,
    "cat_nm" TEXT
);

CREATE TABLE "veg_cat_catcode_gt_1011010101_lte_1011010501" (
    "row_idx" INTEGER,
    "itm_cd" INTEGER,
    "itm_nm" TEXT,
    "cat_cd" INTEGER,
    "cat_nm" TEXT
);

CREATE TABLE "veg_cat_catcode_gt_1011010501_or_null" (
    "row_idx" INTEGER,
    "itm_cd" INTEGER,
    "itm_nm" TEXT,
    "cat_cd" INTEGER,
    "cat_nm" TEXT
);

CREATE TABLE "veg_loss_rate_pct" (
    "row_idx" INTEGER,
    "itm_cd" INTEGER,
    "itm_nm" TEXT,
    "loss_pct" REAL
);

CREATE TABLE "veg_txn_dow_txndt_lte_2021_02_06" (
    "row_idx" INTEGER,
    "dow" TEXT,
    "disc_pct" INTEGER,
    "itm_cd" INTEGER,
    "txn_side" TEXT,
    "txn_dt" TEXT,
    "txn_tm" TEXT
);

CREATE TABLE "veg_txn_dow_txndt_gt_2022_09_10_or_null" (
    "row_idx" INTEGER,
    "dow" TEXT,
    "disc_pct" INTEGER,
    "itm_cd" INTEGER,
    "txn_side" TEXT,
    "txn_dt" TEXT,
    "txn_tm" TEXT
);

CREATE TABLE "veg_whs_px_dt_lte_2021_05_05" (
    "row_idx" INTEGER,
    "whs_dt" TEXT,
    "itm_cd" INTEGER,
    "whs_px_rmb_kg" REAL
);

CREATE TABLE "veg_whs_px_dt_gt_2021_05_05_lte_2022_01_22" (
    "row_idx" INTEGER,
    "whs_dt" TEXT,
    "itm_cd" INTEGER,
    "whs_px_rmb_kg" REAL
);

CREATE TABLE "veg_whs_px_dt_gt_2022_01_22_lte_2022_09_12" (
    "row_idx" INTEGER,
    "whs_dt" TEXT,
    "itm_cd" INTEGER,
    "whs_px_rmb_kg" REAL
);

CREATE TABLE "veg_whs_px_dt_gt_2022_09_12_or_null" (
    "row_idx" INTEGER,
    "whs_dt" TEXT,
    "itm_cd" INTEGER,
    "whs_px_rmb_kg" REAL
);

-- ========================================================================
-- local_6
-- DDL file: local_6_schema.sql
-- ========================================================================

CREATE TABLE "btc_mkt_px" (
    "sym_cd" TEXT,
    "mkt_dt" TEXT,
    "px" REAL,
    "open_px" REAL,
    "high_px" REAL,
    "low_px" REAL,
    "vol" TEXT,
    "chg_txt" TEXT
);

CREATE TABLE "eth_mkt_px" (
    "sym_cd" TEXT,
    "mkt_dt" TEXT,
    "px" REAL,
    "open_px" REAL,
    "high_px" REAL,
    "low_px" REAL,
    "vol" TEXT,
    "chg_txt" TEXT
);

CREATE TABLE "wk_sales_spec_dates" (
    "wk_dt" TEXT,
    "reg_cd" TEXT,
    "plat_cd" TEXT,
    "seg_cd" TEXT,
    "cust_cat" TEXT,
    "txn_cnt" INTEGER,
    "sales_amt" INTEGER
);

CREATE TABLE "wk_sales_other" (
    "wk_dt" TEXT,
    "reg_cd" TEXT,
    "plat_cd" TEXT,
    "seg_cd" TEXT,
    "cust_cat" TEXT,
    "txn_cnt" INTEGER,
    "sales_amt" INTEGER
);

