CREATE TABLE "dish_agg" (
    "dish_id" INTEGER,
    "dish_name" TEXT,
    "dish_desc" TEXT,
    "menu_cnt" INTEGER,
    "appear_cnt" INTEGER,
    "seen" INTEGER,
    "last_seen" INTEGER,
    "min_price" REAL,
    "max_price" REAL
);

CREATE TABLE "menu_item_lowprice" (
    "item_id" INTEGER,
    "page_ref" INTEGER,
    "unit_price" REAL,
    "price_high" REAL,
    "dish_ref" INTEGER,
    "created_ts" TEXT,
    "updated_ts" TEXT,
    "pos_x" REAL,
    "pos_y" REAL
);

CREATE TABLE "menu_item_highprice" (
    "item_id" INTEGER,
    "page_ref" INTEGER,
    "unit_price" REAL,
    "price_high" REAL,
    "dish_ref" INTEGER,
    "created_ts" TEXT,
    "updated_ts" TEXT,
    "pos_x" REAL,
    "pos_y" REAL,
    FOREIGN KEY ("dish_ref") REFERENCES "dish_agg"("dish_id")
);