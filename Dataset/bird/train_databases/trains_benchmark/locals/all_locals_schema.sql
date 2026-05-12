-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/trains/trains.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "CarLoadsShapeCircleHexagonDiamond" (
    "CarLoadId" INTEGER,
    "LoadLength" TEXT DEFAULT NULL,
    "LoadQuantity" INTEGER DEFAULT NULL,
    "LoadShape" TEXT DEFAULT NULL,
    "RoofType" TEXT DEFAULT NULL,
    "CarShape" TEXT DEFAULT NULL,
    "SideConfiguration" TEXT DEFAULT NULL
);

CREATE TABLE "TrainCarSpecifications" (
    "CarSpecificationId" INTEGER,
    "CarLength" TEXT DEFAULT NULL,
    "LoadQuantity" INTEGER DEFAULT NULL,
    "CarPosition" INTEGER DEFAULT NULL,
    "RoofType" TEXT DEFAULT NULL,
    "SideConfiguration" TEXT DEFAULT NULL,
    "TrainId" INTEGER DEFAULT NULL,
    "WheelCount" INTEGER DEFAULT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "trainDirections" (
    "trainId" INTEGER,
    "travelDirection" TEXT DEFAULT NULL
);

CREATE TABLE "carsWithRectangleLoad" (
    "carId" INTEGER,
    "carLength" TEXT DEFAULT NULL,
    "loadCount" INTEGER DEFAULT NULL,
    "loadProfile" TEXT DEFAULT NULL,
    "roofStyle" TEXT DEFAULT NULL,
    "bodyShape" TEXT DEFAULT NULL,
    "sideConfiguration" TEXT DEFAULT NULL
);

CREATE TABLE "carsWithTriangleLoad" (
    "carId" INTEGER,
    "carLength" TEXT DEFAULT NULL,
    "loadCount" INTEGER DEFAULT NULL,
    "loadProfile" TEXT DEFAULT NULL,
    "roofStyle" TEXT DEFAULT NULL,
    "bodyShape" TEXT DEFAULT NULL,
    "sideConfiguration" TEXT DEFAULT NULL
);

