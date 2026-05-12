-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";
ATTACH DATABASE 'local_6.sqlite' AS "local_6";

-- Reconstruct bitcoin_members from local_1.cryptoAccountMembers
CREATE VIEW "bitcoin_members" AS
SELECT
    "local_1"."cryptoAccountMembers"."memberId" AS "member_id",
    "local_1"."cryptoAccountMembers"."givenName" AS "first_name",
    "local_1"."cryptoAccountMembers"."homeRegion" AS "region"
FROM "local_1"."cryptoAccountMembers";

-- Reconstruct bitcoin_prices from row partitions (UNION (overlap))
CREATE VIEW "bitcoin_prices" AS
SELECT "local_6"."btc_mkt_px"."sym_cd" AS "ticker", "local_6"."btc_mkt_px"."mkt_dt" AS "market_date", "local_6"."btc_mkt_px"."px" AS "price", "local_6"."btc_mkt_px"."open_px" AS "open", "local_6"."btc_mkt_px"."high_px" AS "high", "local_6"."btc_mkt_px"."low_px" AS "low", "local_6"."btc_mkt_px"."vol" AS "volume", "local_6"."btc_mkt_px"."chg_txt" AS "change" FROM "local_6"."btc_mkt_px"
UNION
SELECT "local_6"."eth_mkt_px"."sym_cd" AS "ticker", "local_6"."eth_mkt_px"."mkt_dt" AS "market_date", "local_6"."eth_mkt_px"."px" AS "price", "local_6"."eth_mkt_px"."open_px" AS "open", "local_6"."eth_mkt_px"."high_px" AS "high", "local_6"."eth_mkt_px"."low_px" AS "low", "local_6"."eth_mkt_px"."vol" AS "volume", "local_6"."eth_mkt_px"."chg_txt" AS "change" FROM "local_6"."eth_mkt_px";

-- Reconstruct bitcoin_transactions from row partitions (UNION (overlap))
CREATE VIEW "bitcoin_transactions" AS
SELECT "local_2"."BitcoinSellTransactions"."TransactionId" AS "txn_id", "local_2"."BitcoinSellTransactions"."AccountId" AS "member_id", "local_2"."BitcoinSellTransactions"."TickerSymbol" AS "ticker", "local_2"."BitcoinSellTransactions"."TransactionDate" AS "txn_date", "local_2"."BitcoinSellTransactions"."TradeType" AS "txn_type", "local_2"."BitcoinSellTransactions"."Quantity" AS "quantity", "local_2"."BitcoinSellTransactions"."FeePercent" AS "percentage_fee", "local_2"."BitcoinSellTransactions"."TransactionTime" AS "txn_time" FROM "local_2"."BitcoinSellTransactions"
UNION
SELECT "local_4"."btc_txn_buy_log"."tx_id" AS "txn_id", "local_4"."btc_txn_buy_log"."mem_id" AS "member_id", "local_4"."btc_txn_buy_log"."asset_sym" AS "ticker", "local_4"."btc_txn_buy_log"."tx_date" AS "txn_date", "local_4"."btc_txn_buy_log"."tx_side" AS "txn_type", "local_4"."btc_txn_buy_log"."qty" AS "quantity", "local_4"."btc_txn_buy_log"."pct_fee" AS "percentage_fee", "local_4"."btc_txn_buy_log"."tx_time" AS "txn_time" FROM "local_4"."btc_txn_buy_log";

-- Reconstruct cleaned_weekly_sales from vertical split + row partition on a fragment
CREATE VIEW "cleaned_weekly_sales" AS
SELECT t4.[weekStartFormatted], t0.[weekStartDate], t1.[regionCode], t4.[salesPlatform], t0.[customerSegment], t3.[customerType], t1.[transactionCount], t0.[totalSales], t2.[weekOfYear], t1.[monthNumber], t1.[calendarYear], t0.[ageBand], t3.[demographicGroup], t1.[avgTransactionValue]
FROM [local_1].[weeklySalesByAgeBand] t0
JOIN [local_1].[weeklySalesAvgTransactionByRegion] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[weeklySalesAvgTransactionByRegionWithWeekNumber] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN (
SELECT [weeklySalesExistingCustomers].[__orig_rowid] AS __orig_rowid, [local_1].[weeklySalesExistingCustomers].[weekStartDate], [local_1].[weeklySalesExistingCustomers].[customerType], [local_1].[weeklySalesExistingCustomers].[totalSales], [local_1].[weeklySalesExistingCustomers].[demographicGroup] FROM [local_1].[weeklySalesExistingCustomers]
UNION
SELECT [weeklySalesNewOrGuestCustomers].[__orig_rowid] AS __orig_rowid, [local_1].[weeklySalesNewOrGuestCustomers].[weekStartDate], [local_1].[weeklySalesNewOrGuestCustomers].[customerType], [local_1].[weeklySalesNewOrGuestCustomers].[totalSales], [local_1].[weeklySalesNewOrGuestCustomers].[demographicGroup] FROM [local_1].[weeklySalesNewOrGuestCustomers]
) t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_1].[weeklySalesByPlatform] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct customer_nodes from row partitions (UNION (overlap))
CREATE VIEW "customer_nodes" AS
SELECT "local_4"."cust_node_end_lte_20200217"."cust_id" AS "customer_id", "local_4"."cust_node_end_lte_20200217"."reg_id" AS "region_id", "local_4"."cust_node_end_lte_20200217"."nd_id" AS "node_id", "local_4"."cust_node_end_lte_20200217"."start_dt" AS "start_date", "local_4"."cust_node_end_lte_20200217"."end_dt" AS "end_date" FROM "local_4"."cust_node_end_lte_20200217"
UNION
SELECT "local_4"."cust_node_end_gt_20200217_lte_20200315"."cust_id" AS "customer_id", "local_4"."cust_node_end_gt_20200217_lte_20200315"."reg_id" AS "region_id", "local_4"."cust_node_end_gt_20200217_lte_20200315"."nd_id" AS "node_id", "local_4"."cust_node_end_gt_20200217_lte_20200315"."start_dt" AS "start_date", "local_4"."cust_node_end_gt_20200217_lte_20200315"."end_dt" AS "end_date" FROM "local_4"."cust_node_end_gt_20200217_lte_20200315"
UNION
SELECT "local_4"."cust_node_end_gt_20200315_lte_20200419"."cust_id" AS "customer_id", "local_4"."cust_node_end_gt_20200315_lte_20200419"."reg_id" AS "region_id", "local_4"."cust_node_end_gt_20200315_lte_20200419"."nd_id" AS "node_id", "local_4"."cust_node_end_gt_20200315_lte_20200419"."start_dt" AS "start_date", "local_4"."cust_node_end_gt_20200315_lte_20200419"."end_dt" AS "end_date" FROM "local_4"."cust_node_end_gt_20200315_lte_20200419"
UNION
SELECT "local_4"."cust_node_end_gt_20200419_or_null"."cust_id" AS "customer_id", "local_4"."cust_node_end_gt_20200419_or_null"."reg_id" AS "region_id", "local_4"."cust_node_end_gt_20200419_or_null"."nd_id" AS "node_id", "local_4"."cust_node_end_gt_20200419_or_null"."start_dt" AS "start_date", "local_4"."cust_node_end_gt_20200419_or_null"."end_dt" AS "end_date" FROM "local_4"."cust_node_end_gt_20200419_or_null";

-- Reconstruct customer_regions from local_1.regionLookup
CREATE VIEW "customer_regions" AS
SELECT
    "local_1"."regionLookup"."regionId" AS "region_id",
    "local_1"."regionLookup"."regionName" AS "region_name"
FROM "local_1"."regionLookup";

-- Reconstruct customer_transactions from local_2.ClientTransactions
CREATE VIEW "customer_transactions" AS
SELECT
    "local_2"."ClientTransactions"."ClientId" AS "customer_id",
    "local_2"."ClientTransactions"."TransactionDate" AS "txn_date",
    "local_2"."ClientTransactions"."TransactionType" AS "txn_type",
    "local_2"."ClientTransactions"."TransactionAmount" AS "txn_amount"
FROM "local_2"."ClientTransactions";

-- Reconstruct interest_map from row partitions (UNION (overlap))
CREATE VIEW "interest_map" AS
SELECT "local_1"."interestMapCreatedUpTo2017Mar27"."interestId" AS "id", "local_1"."interestMapCreatedUpTo2017Mar27"."interestName" AS "interest_name", "local_1"."interestMapCreatedUpTo2017Mar27"."interestSummary" AS "interest_summary", "local_1"."interestMapCreatedUpTo2017Mar27"."createdAt" AS "created_at", "local_1"."interestMapCreatedUpTo2017Mar27"."lastModified" AS "last_modified" FROM "local_1"."interestMapCreatedUpTo2017Mar27"
UNION
SELECT "local_1"."interestMapCreatedAfter2017Mar27Until2018May15"."interestId" AS "id", "local_1"."interestMapCreatedAfter2017Mar27Until2018May15"."interestName" AS "interest_name", "local_1"."interestMapCreatedAfter2017Mar27Until2018May15"."interestSummary" AS "interest_summary", "local_1"."interestMapCreatedAfter2017Mar27Until2018May15"."createdAt" AS "created_at", "local_1"."interestMapCreatedAfter2017Mar27Until2018May15"."lastModified" AS "last_modified" FROM "local_1"."interestMapCreatedAfter2017Mar27Until2018May15"
UNION
SELECT "local_1"."interestMapCreatedAfter2018May15Until2018Oct22"."interestId" AS "id", "local_1"."interestMapCreatedAfter2018May15Until2018Oct22"."interestName" AS "interest_name", "local_1"."interestMapCreatedAfter2018May15Until2018Oct22"."interestSummary" AS "interest_summary", "local_1"."interestMapCreatedAfter2018May15Until2018Oct22"."createdAt" AS "created_at", "local_1"."interestMapCreatedAfter2018May15Until2018Oct22"."lastModified" AS "last_modified" FROM "local_1"."interestMapCreatedAfter2018May15Until2018Oct22"
UNION
SELECT "local_1"."interestMapCreatedAfter2018Oct22OrNull"."interestId" AS "id", "local_1"."interestMapCreatedAfter2018Oct22OrNull"."interestName" AS "interest_name", "local_1"."interestMapCreatedAfter2018Oct22OrNull"."interestSummary" AS "interest_summary", "local_1"."interestMapCreatedAfter2018Oct22OrNull"."createdAt" AS "created_at", "local_1"."interestMapCreatedAfter2018Oct22OrNull"."lastModified" AS "last_modified" FROM "local_1"."interestMapCreatedAfter2018Oct22OrNull";

-- Reconstruct interest_metrics from vertical split + row partition on a fragment
CREATE VIEW "interest_metrics" AS
SELECT t1.[monthNumeric], t1.[yearNumeric], t0.[monthYear], t0.[interestId], t0.[composition], t0.[indexValue], t0.[ranking], t0.[percentileRanking]
FROM (
SELECT [interestCompositionAbove3Point87OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[interestCompositionAbove3Point87OrNull].[monthYear], [local_1].[interestCompositionAbove3Point87OrNull].[interestId], [local_1].[interestCompositionAbove3Point87OrNull].[composition], [local_1].[interestCompositionAbove3Point87OrNull].[indexValue], [local_1].[interestCompositionAbove3Point87OrNull].[ranking], [local_1].[interestCompositionAbove3Point87OrNull].[percentileRanking] FROM [local_1].[interestCompositionAbove3Point87OrNull]
UNION
SELECT [interestCompositionAtMost2Point22].[__orig_rowid] AS __orig_rowid, [local_1].[interestCompositionAtMost2Point22].[monthYear], [local_1].[interestCompositionAtMost2Point22].[interestId], [local_1].[interestCompositionAtMost2Point22].[composition], [local_1].[interestCompositionAtMost2Point22].[indexValue], [local_1].[interestCompositionAtMost2Point22].[ranking], [local_1].[interestCompositionAtMost2Point22].[percentileRanking] FROM [local_1].[interestCompositionAtMost2Point22]
UNION
SELECT [interestCompositionBetween2Point22And2Point86].[__orig_rowid] AS __orig_rowid, [local_1].[interestCompositionBetween2Point22And2Point86].[monthYear], [local_1].[interestCompositionBetween2Point22And2Point86].[interestId], [local_1].[interestCompositionBetween2Point22And2Point86].[composition], [local_1].[interestCompositionBetween2Point22And2Point86].[indexValue], [local_1].[interestCompositionBetween2Point22And2Point86].[ranking], [local_1].[interestCompositionBetween2Point22And2Point86].[percentileRanking] FROM [local_1].[interestCompositionBetween2Point22And2Point86]
UNION
SELECT [interestCompositionBetween2Point86And3Point87].[__orig_rowid] AS __orig_rowid, [local_1].[interestCompositionBetween2Point86And3Point87].[monthYear], [local_1].[interestCompositionBetween2Point86And3Point87].[interestId], [local_1].[interestCompositionBetween2Point86And3Point87].[composition], [local_1].[interestCompositionBetween2Point86And3Point87].[indexValue], [local_1].[interestCompositionBetween2Point86And3Point87].[ranking], [local_1].[interestCompositionBetween2Point86And3Point87].[percentileRanking] FROM [local_1].[interestCompositionBetween2Point86And3Point87]
) t0
JOIN [local_1].[interestMetricsByMonth] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct shopping_cart_campaign_identifier from local_2.CartPromotionCampaigns
CREATE VIEW "shopping_cart_campaign_identifier" AS
SELECT
    "local_2"."CartPromotionCampaigns"."CampaignKey" AS "campaign_id",
    "local_2"."CartPromotionCampaigns"."ProductList" AS "products",
    "local_2"."CartPromotionCampaigns"."CampaignTitle" AS "campaign_name",
    "local_2"."CartPromotionCampaigns"."CampaignStart" AS "start_date",
    "local_2"."CartPromotionCampaigns"."CampaignEnd" AS "end_date"
FROM "local_2"."CartPromotionCampaigns";

-- Reconstruct shopping_cart_event_identifier from local_3.cart_event_type_lookup
CREATE VIEW "shopping_cart_event_identifier" AS
SELECT
    "local_3"."cart_event_type_lookup"."event_code" AS "event_type",
    "local_3"."cart_event_type_lookup"."event_label" AS "event_name"
FROM "local_3"."cart_event_type_lookup";

-- Reconstruct shopping_cart_events from row partitions (UNION (overlap))
CREATE VIEW "shopping_cart_events" AS
SELECT "local_3"."cart_events_sequence_early"."session_id" AS "visit_id", "local_3"."cart_events_sequence_early"."browser_cookie" AS "cookie_id", "local_3"."cart_events_sequence_early"."page_ref_id" AS "page_id", "local_3"."cart_events_sequence_early"."event_code" AS "event_type", "local_3"."cart_events_sequence_early"."sequence_index" AS "sequence_number", "local_3"."cart_events_sequence_early"."occurred_at" AS "event_time" FROM "local_3"."cart_events_sequence_early"
UNION
SELECT "local_3"."cart_events_sequence_late_or_null"."session_id" AS "visit_id", "local_3"."cart_events_sequence_late_or_null"."browser_cookie" AS "cookie_id", "local_3"."cart_events_sequence_late_or_null"."page_ref_id" AS "page_id", "local_3"."cart_events_sequence_late_or_null"."event_code" AS "event_type", "local_3"."cart_events_sequence_late_or_null"."sequence_index" AS "sequence_number", "local_3"."cart_events_sequence_late_or_null"."occurred_at" AS "event_time" FROM "local_3"."cart_events_sequence_late_or_null"
UNION
SELECT "local_4"."cart_evt_seq_gt3_lte6"."vis_id" AS "visit_id", "local_4"."cart_evt_seq_gt3_lte6"."ck_id" AS "cookie_id", "local_4"."cart_evt_seq_gt3_lte6"."pg_id" AS "page_id", "local_4"."cart_evt_seq_gt3_lte6"."evt_type" AS "event_type", "local_4"."cart_evt_seq_gt3_lte6"."seq_no" AS "sequence_number", "local_4"."cart_evt_seq_gt3_lte6"."evt_time" AS "event_time" FROM "local_4"."cart_evt_seq_gt3_lte6"
UNION
SELECT "local_4"."cart_evt_seq_gt6_lte10"."vis_id" AS "visit_id", "local_4"."cart_evt_seq_gt6_lte10"."ck_id" AS "cookie_id", "local_4"."cart_evt_seq_gt6_lte10"."pg_id" AS "page_id", "local_4"."cart_evt_seq_gt6_lte10"."evt_type" AS "event_type", "local_4"."cart_evt_seq_gt6_lte10"."seq_no" AS "sequence_number", "local_4"."cart_evt_seq_gt6_lte10"."evt_time" AS "event_time" FROM "local_4"."cart_evt_seq_gt6_lte10";

-- Reconstruct shopping_cart_page_hierarchy from local_4.cart_pg_hier
CREATE VIEW "shopping_cart_page_hierarchy" AS
SELECT
    "local_4"."cart_pg_hier"."pg_id" AS "page_id",
    "local_4"."cart_pg_hier"."pg_name" AS "page_name",
    "local_4"."cart_pg_hier"."prod_cat" AS "product_category",
    "local_4"."cart_pg_hier"."prod_id" AS "product_id"
FROM "local_4"."cart_pg_hier";

-- Reconstruct shopping_cart_users from row partitions (UNION (overlap))
CREATE VIEW "shopping_cart_users" AS
SELECT "local_1"."shoppingCartUsersStartedOnOrBefore2020Feb01"."userId" AS "user_id", "local_1"."shoppingCartUsersStartedOnOrBefore2020Feb01"."cookieId" AS "cookie_id", "local_1"."shoppingCartUsersStartedOnOrBefore2020Feb01"."startDate" AS "start_date" FROM "local_1"."shoppingCartUsersStartedOnOrBefore2020Feb01"
UNION
SELECT "local_1"."shoppingCartUsersStartedAfter2020Mar09OrNull"."userId" AS "user_id", "local_1"."shoppingCartUsersStartedAfter2020Mar09OrNull"."cookieId" AS "cookie_id", "local_1"."shoppingCartUsersStartedAfter2020Mar09OrNull"."startDate" AS "start_date" FROM "local_1"."shoppingCartUsersStartedAfter2020Mar09OrNull"
UNION
SELECT "local_3"."cart_users_started_after_2020_02_01_up_to_2020_02_19"."account_id" AS "user_id", "local_3"."cart_users_started_after_2020_02_01_up_to_2020_02_19"."browser_cookie" AS "cookie_id", "local_3"."cart_users_started_after_2020_02_01_up_to_2020_02_19"."registration_date" AS "start_date" FROM "local_3"."cart_users_started_after_2020_02_01_up_to_2020_02_19"
UNION
SELECT "local_3"."cart_users_started_after_2020_02_19_up_to_2020_03_09"."account_id" AS "user_id", "local_3"."cart_users_started_after_2020_02_19_up_to_2020_03_09"."browser_cookie" AS "cookie_id", "local_3"."cart_users_started_after_2020_02_19_up_to_2020_03_09"."registration_date" AS "start_date" FROM "local_3"."cart_users_started_after_2020_02_19_up_to_2020_03_09";

-- Reconstruct veg_cat from row partitions (UNION (overlap))
CREATE VIEW "veg_cat" AS
SELECT "local_5"."veg_cat_catcode_lte_1011010101"."row_idx" AS "index", "local_5"."veg_cat_catcode_lte_1011010101"."itm_cd" AS "item_code", "local_5"."veg_cat_catcode_lte_1011010101"."itm_nm" AS "item_name", "local_5"."veg_cat_catcode_lte_1011010101"."cat_cd" AS "category_code", "local_5"."veg_cat_catcode_lte_1011010101"."cat_nm" AS "category_name" FROM "local_5"."veg_cat_catcode_lte_1011010101"
UNION
SELECT "local_5"."veg_cat_catcode_gt_1011010101_lte_1011010501"."row_idx" AS "index", "local_5"."veg_cat_catcode_gt_1011010101_lte_1011010501"."itm_cd" AS "item_code", "local_5"."veg_cat_catcode_gt_1011010101_lte_1011010501"."itm_nm" AS "item_name", "local_5"."veg_cat_catcode_gt_1011010101_lte_1011010501"."cat_cd" AS "category_code", "local_5"."veg_cat_catcode_gt_1011010101_lte_1011010501"."cat_nm" AS "category_name" FROM "local_5"."veg_cat_catcode_gt_1011010101_lte_1011010501"
UNION
SELECT "local_5"."veg_cat_catcode_gt_1011010501_or_null"."row_idx" AS "index", "local_5"."veg_cat_catcode_gt_1011010501_or_null"."itm_cd" AS "item_code", "local_5"."veg_cat_catcode_gt_1011010501_or_null"."itm_nm" AS "item_name", "local_5"."veg_cat_catcode_gt_1011010501_or_null"."cat_cd" AS "category_code", "local_5"."veg_cat_catcode_gt_1011010501_or_null"."cat_nm" AS "category_name" FROM "local_5"."veg_cat_catcode_gt_1011010501_or_null";

-- Reconstruct veg_loss_rate_df from local_5.veg_loss_rate_pct
CREATE VIEW "veg_loss_rate_df" AS
SELECT
    "local_5"."veg_loss_rate_pct"."row_idx" AS "index",
    "local_5"."veg_loss_rate_pct"."itm_cd" AS "item_code",
    "local_5"."veg_loss_rate_pct"."itm_nm" AS "item_name",
    "local_5"."veg_loss_rate_pct"."loss_pct" AS "loss_rate_%"
FROM "local_5"."veg_loss_rate_pct";

-- Reconstruct veg_txn_df from vertical split + row partition on a fragment
CREATE VIEW "veg_txn_df" AS
SELECT t0.[idx], t0.[tx_dt], t0.[tx_tm], t0.[item_cd], t1.[qty_kg], t1.[px_rmb_per_kg], t0.[sale_ret_flag], t0.[disc_pct], t0.[dow]
FROM (
SELECT [veg_txn_dow_gt20210206_lte20211011].[__orig_rowid] AS __orig_rowid, [local_4].[veg_txn_dow_gt20210206_lte20211011].[idx], [local_4].[veg_txn_dow_gt20210206_lte20211011].[tx_dt], [local_4].[veg_txn_dow_gt20210206_lte20211011].[tx_tm], [local_4].[veg_txn_dow_gt20210206_lte20211011].[item_cd], [local_4].[veg_txn_dow_gt20210206_lte20211011].[sale_ret_flag], [local_4].[veg_txn_dow_gt20210206_lte20211011].[disc_pct], [local_4].[veg_txn_dow_gt20210206_lte20211011].[dow] FROM [local_4].[veg_txn_dow_gt20210206_lte20211011]
UNION
SELECT [veg_txn_dow_gt20211011_lte20220910].[__orig_rowid] AS __orig_rowid, [local_4].[veg_txn_dow_gt20211011_lte20220910].[idx], [local_4].[veg_txn_dow_gt20211011_lte20220910].[tx_dt], [local_4].[veg_txn_dow_gt20211011_lte20220910].[tx_tm], [local_4].[veg_txn_dow_gt20211011_lte20220910].[item_cd], [local_4].[veg_txn_dow_gt20211011_lte20220910].[sale_ret_flag], [local_4].[veg_txn_dow_gt20211011_lte20220910].[disc_pct], [local_4].[veg_txn_dow_gt20211011_lte20220910].[dow] FROM [local_4].[veg_txn_dow_gt20211011_lte20220910]
UNION
SELECT [veg_txn_dow_txndt_gt_2022_09_10_or_null].[__orig_rowid] AS __orig_rowid, [local_5].[veg_txn_dow_txndt_gt_2022_09_10_or_null].[row_idx], [local_5].[veg_txn_dow_txndt_gt_2022_09_10_or_null].[txn_dt], [local_5].[veg_txn_dow_txndt_gt_2022_09_10_or_null].[txn_tm], [local_5].[veg_txn_dow_txndt_gt_2022_09_10_or_null].[itm_cd], [local_5].[veg_txn_dow_txndt_gt_2022_09_10_or_null].[txn_side], [local_5].[veg_txn_dow_txndt_gt_2022_09_10_or_null].[disc_pct], [local_5].[veg_txn_dow_txndt_gt_2022_09_10_or_null].[dow] FROM [local_5].[veg_txn_dow_txndt_gt_2022_09_10_or_null]
UNION
SELECT [veg_txn_dow_txndt_lte_2021_02_06].[__orig_rowid] AS __orig_rowid, [local_5].[veg_txn_dow_txndt_lte_2021_02_06].[row_idx], [local_5].[veg_txn_dow_txndt_lte_2021_02_06].[txn_dt], [local_5].[veg_txn_dow_txndt_lte_2021_02_06].[txn_tm], [local_5].[veg_txn_dow_txndt_lte_2021_02_06].[itm_cd], [local_5].[veg_txn_dow_txndt_lte_2021_02_06].[txn_side], [local_5].[veg_txn_dow_txndt_lte_2021_02_06].[disc_pct], [local_5].[veg_txn_dow_txndt_lte_2021_02_06].[dow] FROM [local_5].[veg_txn_dow_txndt_lte_2021_02_06]
) t0
JOIN [local_4].[veg_txn_dow_misc] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct veg_whsle_df from row partitions (UNION (overlap))
CREATE VIEW "veg_whsle_df" AS
SELECT "local_5"."veg_whs_px_dt_lte_2021_05_05"."row_idx" AS "index", "local_5"."veg_whs_px_dt_lte_2021_05_05"."whs_dt" AS "whsle_date", "local_5"."veg_whs_px_dt_lte_2021_05_05"."itm_cd" AS "item_code", "local_5"."veg_whs_px_dt_lte_2021_05_05"."whs_px_rmb_kg" AS "whsle_px_rmb-kg" FROM "local_5"."veg_whs_px_dt_lte_2021_05_05"
UNION
SELECT "local_5"."veg_whs_px_dt_gt_2021_05_05_lte_2022_01_22"."row_idx" AS "index", "local_5"."veg_whs_px_dt_gt_2021_05_05_lte_2022_01_22"."whs_dt" AS "whsle_date", "local_5"."veg_whs_px_dt_gt_2021_05_05_lte_2022_01_22"."itm_cd" AS "item_code", "local_5"."veg_whs_px_dt_gt_2021_05_05_lte_2022_01_22"."whs_px_rmb_kg" AS "whsle_px_rmb-kg" FROM "local_5"."veg_whs_px_dt_gt_2021_05_05_lte_2022_01_22"
UNION
SELECT "local_5"."veg_whs_px_dt_gt_2022_01_22_lte_2022_09_12"."row_idx" AS "index", "local_5"."veg_whs_px_dt_gt_2022_01_22_lte_2022_09_12"."whs_dt" AS "whsle_date", "local_5"."veg_whs_px_dt_gt_2022_01_22_lte_2022_09_12"."itm_cd" AS "item_code", "local_5"."veg_whs_px_dt_gt_2022_01_22_lte_2022_09_12"."whs_px_rmb_kg" AS "whsle_px_rmb-kg" FROM "local_5"."veg_whs_px_dt_gt_2022_01_22_lte_2022_09_12"
UNION
SELECT "local_5"."veg_whs_px_dt_gt_2022_09_12_or_null"."row_idx" AS "index", "local_5"."veg_whs_px_dt_gt_2022_09_12_or_null"."whs_dt" AS "whsle_date", "local_5"."veg_whs_px_dt_gt_2022_09_12_or_null"."itm_cd" AS "item_code", "local_5"."veg_whs_px_dt_gt_2022_09_12_or_null"."whs_px_rmb_kg" AS "whsle_px_rmb-kg" FROM "local_5"."veg_whs_px_dt_gt_2022_09_12_or_null";

-- Reconstruct weekly_sales from row partitions (UNION (overlap))
CREATE VIEW "weekly_sales" AS
SELECT "local_6"."wk_sales_spec_dates"."wk_dt" AS "week_date", "local_6"."wk_sales_spec_dates"."reg_cd" AS "region", "local_6"."wk_sales_spec_dates"."plat_cd" AS "platform", "local_6"."wk_sales_spec_dates"."seg_cd" AS "segment", "local_6"."wk_sales_spec_dates"."cust_cat" AS "customer_type", "local_6"."wk_sales_spec_dates"."txn_cnt" AS "transactions", "local_6"."wk_sales_spec_dates"."sales_amt" AS "sales" FROM "local_6"."wk_sales_spec_dates"
UNION
SELECT "local_6"."wk_sales_other"."wk_dt" AS "week_date", "local_6"."wk_sales_other"."reg_cd" AS "region", "local_6"."wk_sales_other"."plat_cd" AS "platform", "local_6"."wk_sales_other"."seg_cd" AS "segment", "local_6"."wk_sales_other"."cust_cat" AS "customer_type", "local_6"."wk_sales_other"."txn_cnt" AS "transactions", "local_6"."wk_sales_other"."sales_amt" AS "sales" FROM "local_6"."wk_sales_other";
