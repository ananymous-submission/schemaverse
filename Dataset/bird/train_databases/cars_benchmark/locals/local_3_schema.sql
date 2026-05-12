CREATE TABLE "veh_price" (
    "price_id" INTEGER,
    "price_usd" REAL
);

CREATE TABLE "accel_lte_13_8" (
    "price_id_ref" INTEGER,
    "accel_sec" REAL,
    "veh_name" TEXT,
    "mdl_id" INTEGER,
    "mpg_val" REAL,
    "veh_wt" INTEGER,
    FOREIGN KEY ("price_id_ref") REFERENCES "veh_price"("price_id")
);

CREATE TABLE "accel_gt_13_8_lte_15_5" (
    "price_id_ref" INTEGER,
    "accel_sec" REAL,
    "veh_name" TEXT,
    "mdl_id" INTEGER,
    "mpg_val" REAL,
    "veh_wt" INTEGER
);

CREATE TABLE "accel_gt_15_5_lte_17_1" (
    "accel_rec_id" INTEGER,
    "accel_sec" REAL,
    "veh_name" TEXT,
    "mdl_id" INTEGER,
    "mpg_val" REAL,
    "veh_wt" INTEGER
);