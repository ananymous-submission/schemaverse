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