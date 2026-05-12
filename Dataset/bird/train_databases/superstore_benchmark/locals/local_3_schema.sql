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