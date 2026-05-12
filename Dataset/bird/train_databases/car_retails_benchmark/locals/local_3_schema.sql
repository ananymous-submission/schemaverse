CREATE TABLE "ord_ln_range_le3" (
    "ord_id" INTEGER,
    "prod_sku" TEXT,
    "qty_ord" INTEGER NOT NULL,
    "price_each" REAL NOT NULL,
    "line_no" INTEGER NOT NULL
);

CREATE TABLE "ord_ln_gt9_or_null" (
    "ord_id" INTEGER,
    "prod_sku" TEXT,
    "qty_ord" INTEGER NOT NULL,
    "price_each" REAL NOT NULL,
    "line_no" INTEGER NOT NULL
);

CREATE TABLE "prod_vendor_classic_autoart_minlin" (
    "prod_sku" TEXT,
    "prod_name" TEXT NOT NULL,
    "prod_line" TEXT NOT NULL,
    "scale" TEXT NOT NULL,
    "vendor" TEXT NOT NULL,
    "descr" TEXT NOT NULL,
    "stock_qty" INTEGER NOT NULL,
    "buy_price" REAL NOT NULL,
    "msrp" REAL NOT NULL
);

CREATE TABLE "prod_vendor_other_or_null" (
    "prod_sku" TEXT,
    "prod_name" TEXT NOT NULL,
    "prod_line" TEXT NOT NULL,
    "scale" TEXT NOT NULL,
    "vendor" TEXT NOT NULL,
    "descr" TEXT NOT NULL,
    "stock_qty" INTEGER NOT NULL,
    "buy_price" REAL NOT NULL,
    "msrp" REAL NOT NULL
);

CREATE TABLE "ord_meta_notes" (
    "ord_id" INTEGER,
    "notes" TEXT,
    "cust_id" INTEGER NOT NULL,
    "ord_status" TEXT NOT NULL
);