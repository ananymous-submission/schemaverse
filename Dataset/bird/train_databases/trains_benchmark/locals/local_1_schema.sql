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