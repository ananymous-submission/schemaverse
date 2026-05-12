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