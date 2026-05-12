-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/superstore/superstore.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "customerCityRegistry" (
    "customerId" TEXT,
    "regionCode" TEXT,
    "cityName" TEXT,
    "customerName" TEXT,
    "postalCode" INTEGER,
    "customerSegment" TEXT
);

CREATE TABLE "customerCountryRegistry" (
    "customerId" TEXT,
    "regionCode" TEXT,
    "countryName" TEXT,
    "stateName" TEXT
);

CREATE TABLE "westOrdersOnOrBefore2015May19" (
    "rowId" INTEGER,
    "customerId" TEXT,
    "discountRate" REAL,
    "orderDate" DATE,
    "orderId" TEXT,
    "productId" TEXT,
    "quantityOrdered" INTEGER,
    "customerRegion" TEXT,
    "shipDate" DATE,
    "shippingMethod" TEXT,
    FOREIGN KEY ("customerId") REFERENCES "customerCityRegistry"("customerId"),
    FOREIGN KEY ("customerId") REFERENCES "customerCountryRegistry"("customerId"),
    FOREIGN KEY ("customerRegion") REFERENCES "customerCityRegistry"("regionCode"),
    FOREIGN KEY ("customerRegion") REFERENCES "customerCountryRegistry"("regionCode")
);

CREATE TABLE "westOrdersAfter2017Jul19OrNull" (
    "rowId" INTEGER,
    "customerId" TEXT,
    "discountRate" REAL,
    "orderDate" DATE,
    "orderId" TEXT,
    "productId" TEXT,
    "quantityOrdered" INTEGER,
    "customerRegion" TEXT,
    "shipDate" DATE,
    "shippingMethod" TEXT
);

CREATE TABLE "eastDiscountsProfitAtMost1Point5552" (
    "rowId" INTEGER,
    "discountRate" REAL,
    "profitAmount" REAL,
    "quantityOrdered" INTEGER,
    "customerRegion" TEXT,
    "salesAmount" REAL,
    "shippingMethod" TEXT,
    FOREIGN KEY ("customerRegion") REFERENCES "customerCityRegistry"("regionCode"),
    FOREIGN KEY ("customerRegion") REFERENCES "customerCountryRegistry"("regionCode")
);

CREATE TABLE "eastDiscountsProfitBetween1Point5552And8Point1552" (
    "rowId" INTEGER,
    "discountRate" REAL,
    "profitAmount" REAL,
    "quantityOrdered" INTEGER,
    "customerRegion" TEXT,
    "salesAmount" REAL,
    "shippingMethod" TEXT,
    FOREIGN KEY ("customerRegion") REFERENCES "customerCountryRegistry"("regionCode")
);

CREATE TABLE "eastDiscountsProfitBetween8Point1552And28Point7064" (
    "rowId" INTEGER,
    "discountRate" REAL,
    "profitAmount" REAL,
    "quantityOrdered" INTEGER,
    "customerRegion" TEXT,
    "salesAmount" REAL,
    "shippingMethod" TEXT,
    FOREIGN KEY ("customerRegion") REFERENCES "customerCityRegistry"("regionCode"),
    FOREIGN KEY ("customerRegion") REFERENCES "customerCountryRegistry"("regionCode")
);

CREATE TABLE "eastDiscountsProfitAbove28Point7064OrNull" (
    "rowId" INTEGER,
    "discountRate" REAL,
    "profitAmount" REAL,
    "quantityOrdered" INTEGER,
    "customerRegion" TEXT,
    "salesAmount" REAL,
    "shippingMethod" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "central_region_customers_profit_le_neg5_688" (
    "record_id" INTEGER,
    "customer_identifier" TEXT,
    "discount_rate" REAL,
    "order_reference" TEXT,
    "product_sku" TEXT,
    "profit_amount" REAL,
    "sales_region" TEXT,
    "sales_amount" REAL
);

CREATE TABLE "central_region_order_fulfillment_dates" (
    "record_id" INTEGER,
    "order_placed_date" DATE,
    "shipment_date" DATE,
    "shipping_method" TEXT
);

CREATE TABLE "southern_region_sales_profit_le_1_9024" (
    "record_id" INTEGER,
    "discount_rate" REAL,
    "profit_amount" REAL,
    "quantity_ordered" INTEGER,
    "sales_region" TEXT,
    "sales_amount" REAL,
    "shipping_method" TEXT
);

CREATE TABLE "southern_region_sales_profit_gt_34_2144_or_null" (
    "record_id" INTEGER,
    "discount_rate" REAL,
    "profit_amount" REAL,
    "quantity_ordered" INTEGER,
    "sales_region" TEXT,
    "sales_amount" REAL,
    "shipping_method" TEXT
);

