CREATE TABLE "order_items_orderid_le_10450" (
    "order_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "unit_price" REAL NOT NULL,
    "quantity_ordered" INTEGER NOT NULL,
    "discount_rate" REAL NOT NULL
);

CREATE TABLE "order_items_orderid_gt_10450_to_10657" (
    "order_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "unit_price" REAL NOT NULL,
    "quantity_ordered" INTEGER NOT NULL,
    "discount_rate" REAL NOT NULL
);

CREATE TABLE "order_items_orderid_gt_10657_to_10862" (
    "order_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "unit_price" REAL NOT NULL,
    "quantity_ordered" INTEGER NOT NULL,
    "discount_rate" REAL NOT NULL
);

CREATE TABLE "order_items_orderid_gt_10862_or_null" (
    "order_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "unit_price" REAL NOT NULL,
    "quantity_ordered" INTEGER NOT NULL,
    "discount_rate" REAL NOT NULL
);

CREATE TABLE "territories_region_le_1" (
    "territory_id" TEXT NOT NULL,
    "territory_description" TEXT NOT NULL,
    "region_id" INTEGER NOT NULL
);

CREATE TABLE "territories_region_gt_1_to_2" (
    "territory_id" TEXT NOT NULL,
    "territory_description" TEXT NOT NULL,
    "region_id" INTEGER NOT NULL
);

CREATE TABLE "territories_region_gt_2_to_3" (
    "territory_id" TEXT NOT NULL,
    "territory_description" TEXT NOT NULL,
    "region_id" INTEGER NOT NULL
);

CREATE TABLE "territories_region_gt_3_or_null" (
    "territory_id" TEXT NOT NULL,
    "territory_description" TEXT NOT NULL,
    "region_id" INTEGER NOT NULL
);