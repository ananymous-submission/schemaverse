CREATE TABLE "cust_mast" (
    "cust_id" INTEGER,
    "cust_name" TEXT
);

CREATE TABLE "prod_mast" (
    "prod_id" INTEGER,
    "prod_name" TEXT
);

CREATE TABLE "s_ord_qty_lte_three_cur" (
    "ord_no" TEXT,
    "cur_code" TEXT,
    "disc_val" REAL,
    "ord_qty" INTEGER,
    "sales_chan" TEXT,
    "unit_cost" TEXT,
    "unit_price" TEXT,
    "wh_code" TEXT,
    "sales_team_id" INTEGER
);

CREATE TABLE "s_ord_qty_gt_three_lte_five_cur" (
    "ord_no" TEXT,
    "cur_code" TEXT,
    "disc_val" REAL,
    "ord_qty" INTEGER,
    "sales_chan" TEXT,
    "unit_cost" TEXT,
    "unit_price" TEXT,
    "wh_code" TEXT,
    "sales_team_id" INTEGER
);

CREATE TABLE "s_ord_qty_gt_five_lte_seven_cur" (
    "ord_no" TEXT,
    "cur_code" TEXT,
    "disc_val" REAL,
    "ord_qty" INTEGER,
    "sales_chan" TEXT,
    "unit_cost" TEXT,
    "unit_price" TEXT,
    "wh_code" TEXT,
    "sales_team_id" INTEGER
);

CREATE TABLE "s_ord_qty_gt_seven_or_null_cur" (
    "ord_no" TEXT,
    "cur_code" TEXT,
    "disc_val" REAL,
    "ord_qty" INTEGER,
    "sales_chan" TEXT,
    "unit_cost" TEXT,
    "unit_price" TEXT,
    "wh_code" TEXT,
    "sales_team_id" INTEGER
);