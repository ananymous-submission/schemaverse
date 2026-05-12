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