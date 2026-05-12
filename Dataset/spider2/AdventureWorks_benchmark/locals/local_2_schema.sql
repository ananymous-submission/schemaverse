CREATE TABLE "pm_desc_cult_pm_lte32" (
    "pm_id" INTEGER,
    "pd_id" INTEGER,
    "cult_id" TEXT,
    "mod_ts" DATE
);

CREATE TABLE "pm_desc_cult_pm_33to64" (
    "pm_id" INTEGER,
    "pd_id" INTEGER,
    "cult_id" TEXT,
    "mod_ts" DATE
);

CREATE TABLE "pm_desc_cult_pm_65to96" (
    "pm_id" INTEGER,
    "pd_id" INTEGER,
    "cult_id" TEXT,
    "mod_ts" DATE
);

CREATE TABLE "pm_desc_cult_pm_gt96_or_null" (
    "pm_id" INTEGER,
    "pd_id" INTEGER,
    "cult_id" TEXT,
    "mod_ts" DATE
);

CREATE TABLE "sod_detail_ctn_empty" (
    "row_guid" TEXT,
    "ctn_code" TEXT,
    "mod_ts" DATE,
    "qty" INTEGER,
    "prod_id" INTEGER,
    "sodetail_id" INTEGER,
    "so_id" INTEGER
);

CREATE TABLE "sod_detail_ctn_values" (
    "row_guid" TEXT,
    "ctn_code" TEXT,
    "mod_ts" DATE,
    "qty" INTEGER,
    "prod_id" INTEGER,
    "sodetail_id" INTEGER,
    "so_id" INTEGER
);

CREATE TABLE "sod_detail_ctn_pricing" (
    "row_guid" TEXT,
    "ctn_code" TEXT,
    "mod_ts" DATE,
    "qty" INTEGER,
    "so_id" INTEGER,
    "sp_off_id" INTEGER,
    "unit_price" FLOAT,
    "unit_price_disc" FLOAT
);

CREATE TABLE "soh_status_core" (
    "row_guid" TEXT,
    "status_code" TEXT,
    "acct_num" TEXT,
    "note" TEXT,
    "cc_auth_code" TEXT,
    "cc_id" INTEGER,
    "online_flg" BOOLEAN,
    "po_num" TEXT,
    "rev_num" INTEGER,
    "so_id" INTEGER,
    "ship_method_id" INTEGER,
    "terr_id" INTEGER
);

CREATE TABLE "soh_status_full" (
    "row_guid" TEXT,
    "status_code" TEXT,
    "acct_num" TEXT,
    "bill_addr_id" INTEGER,
    "note" TEXT,
    "cc_auth_code" TEXT,
    "cc_id" INTEGER,
    "curr_rate_id" INTEGER,
    "cust_id" INTEGER,
    "online_flg" BOOLEAN,
    "po_num" TEXT,
    "so_id" INTEGER,
    "salesp_id" INTEGER,
    "ship_method_id" INTEGER,
    "ship_addr_id" INTEGER,
    "terr_id" INTEGER
);

CREATE TABLE "soh_due_lte_20130702" (
    "row_guid" TEXT,
    "due_dt" DATE,
    "mod_ts" DATE,
    "ord_dt" DATE,
    "ship_dt" DATE
);

CREATE TABLE "soh_due_20130703_20131115" (
    "row_guid" TEXT,
    "due_dt" DATE,
    "mod_ts" DATE,
    "ord_dt" DATE,
    "ship_dt" DATE
);

CREATE TABLE "soh_due_20131116_20140312" (
    "row_guid" TEXT,
    "due_dt" DATE,
    "mod_ts" DATE,
    "ord_dt" DATE,
    "ship_dt" DATE
);

CREATE TABLE "soh_due_gt_20140312_or_null" (
    "row_guid" TEXT,
    "due_dt" DATE,
    "mod_ts" DATE,
    "ord_dt" DATE,
    "ship_dt" DATE
);

CREATE TABLE "soh_totals_freight" (
    "row_guid" TEXT,
    "freight_amt" FLOAT,
    "sub_total" FLOAT,
    "tax_amt" FLOAT,
    "total_due" FLOAT
);