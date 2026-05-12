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