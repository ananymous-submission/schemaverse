-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/cars/cars.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "Nation" (
    "NationId" INTEGER,
    "NationName" TEXT
);

CREATE TABLE "ProductionRecord" (
    "ProducerId" INTEGER,
    "ModelYear" INTEGER,
    "NationId" INTEGER
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "vehicleAccelerationTopQuartile" (
    "recordId" INTEGER,
    "accelerationValue" REAL,
    "vehicleName" TEXT,
    "modelYear" INTEGER,
    "milesPerGallon" REAL,
    "vehicleWeight" INTEGER
);

CREATE TABLE "vehicleAccelerationDataset" (
    "recordId" INTEGER,
    "accelerationValue" REAL,
    "vehicleName" TEXT,
    "cylinderCount" INTEGER,
    "engineDisplacement" REAL,
    "engineHorsepower" INTEGER,
    "modelYear" INTEGER,
    "vehicleWeight" INTEGER
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

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

