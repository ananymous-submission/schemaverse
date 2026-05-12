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