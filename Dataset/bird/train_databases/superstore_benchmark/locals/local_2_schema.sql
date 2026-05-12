CREATE TABLE "est_cust_sales" (
    "row_pk" INTEGER,
    "cust_key" TEXT,
    "disc" REAL,
    "ord_key" TEXT,
    "prod_key" TEXT,
    "qty" INTEGER,
    "region_cd" TEXT,
    "sales_amt" REAL,
    FOREIGN KEY ("region_cd") REFERENCES "dim_prod"("region_cd"),
    FOREIGN KEY ("cust_key") REFERENCES "dim_cust_city"("cust_key"),
    FOREIGN KEY ("region_cd") REFERENCES "dim_cust_city"("region_cd")
);

CREATE TABLE "est_order_dates" (
    "row_pk" INTEGER,
    "ord_dt" DATE,
    "ship_dt" DATE,
    "ship_mode" TEXT
);

CREATE TABLE "dim_prod" (
    "prod_key" TEXT,
    "prod_name" TEXT,
    "prod_cat" TEXT,
    "prod_subcat" TEXT,
    "region_cd" TEXT
);

CREATE TABLE "ctr_cust_profit_midlow" (
    "row_pk" INTEGER,
    "cust_key" TEXT,
    "disc" REAL,
    "ord_key" TEXT,
    "prod_key" TEXT,
    "net_prof" REAL,
    "region_cd" TEXT,
    "sales_amt" REAL,
    FOREIGN KEY ("region_cd") REFERENCES "dim_cust_city"("region_cd")
);

CREATE TABLE "ctr_cust_profit_midhigh" (
    "row_pk" INTEGER,
    "cust_key" TEXT,
    "disc" REAL,
    "ord_key" TEXT,
    "prod_key" TEXT,
    "net_prof" REAL,
    "region_cd" TEXT,
    "sales_amt" REAL,
    FOREIGN KEY ("prod_key") REFERENCES "dim_prod"("prod_key"),
    FOREIGN KEY ("region_cd") REFERENCES "dim_cust_city"("region_cd")
);

CREATE TABLE "ctr_cust_profit_high_null" (
    "row_pk" INTEGER,
    "cust_key" TEXT,
    "disc" REAL,
    "ord_key" TEXT,
    "prod_key" TEXT,
    "net_prof" REAL,
    "region_cd" TEXT,
    "sales_amt" REAL
);

CREATE TABLE "dim_cust_city" (
    "cust_key" TEXT,
    "region_cd" TEXT,
    "city_nm" TEXT,
    "cust_name" TEXT,
    "cust_seg" TEXT
);

CREATE TABLE "ctr_discount" (
    "row_pk" INTEGER,
    "disc" REAL,
    "net_prof" REAL,
    "qty" INTEGER,
    "region_cd" TEXT,
    "sales_amt" REAL,
    "ship_mode" TEXT,
    FOREIGN KEY ("region_cd") REFERENCES "dim_prod"("region_cd")
);

CREATE TABLE "wst_discount" (
    "row_pk" INTEGER,
    "disc" REAL,
    "prod_key" TEXT,
    "net_prof" REAL,
    "qty" INTEGER,
    "region_cd" TEXT,
    "sales_amt" REAL,
    "ship_mode" TEXT
);

CREATE TABLE "wst_cust_ordate_midlow" (
    "row_pk" INTEGER,
    "cust_key" TEXT,
    "disc" REAL,
    "ord_dt" DATE,
    "ord_key" TEXT,
    "prod_key" TEXT,
    "qty" INTEGER,
    "region_cd" TEXT,
    "ship_dt" DATE,
    "ship_mode" TEXT
);

CREATE TABLE "wst_cust_ordate_midhigh" (
    "row_pk" INTEGER,
    "cust_key" TEXT,
    "disc" REAL,
    "ord_dt" DATE,
    "ord_key" TEXT,
    "prod_key" TEXT,
    "qty" INTEGER,
    "region_cd" TEXT,
    "ship_dt" DATE,
    "ship_mode" TEXT,
    FOREIGN KEY ("prod_key") REFERENCES "dim_prod"("prod_key"),
    FOREIGN KEY ("region_cd") REFERENCES "dim_prod"("region_cd")
);

CREATE TABLE "sth_cust_sales" (
    "row_pk" INTEGER,
    "cust_key" TEXT,
    "disc" REAL,
    "ord_key" TEXT,
    "prod_key" TEXT,
    "qty" INTEGER,
    FOREIGN KEY ("cust_key") REFERENCES "dim_cust_city"("cust_key")
);

CREATE TABLE "sth_order_dates" (
    "row_pk" INTEGER,
    "ord_dt" DATE,
    "net_prof" REAL,
    "region_cd" TEXT,
    "ship_dt" DATE,
    "ship_mode" TEXT
);

CREATE TABLE "sth_discount_midlow" (
    "row_pk" INTEGER,
    "disc" REAL,
    "net_prof" REAL,
    "qty" INTEGER,
    "region_cd" TEXT,
    "sales_amt" REAL,
    "ship_mode" TEXT
);

CREATE TABLE "sth_discount_midhigh" (
    "row_pk" INTEGER,
    "disc" REAL,
    "net_prof" REAL,
    "qty" INTEGER,
    "region_cd" TEXT,
    "sales_amt" REAL,
    "ship_mode" TEXT,
    FOREIGN KEY ("region_cd") REFERENCES "dim_cust_city"("region_cd")
);