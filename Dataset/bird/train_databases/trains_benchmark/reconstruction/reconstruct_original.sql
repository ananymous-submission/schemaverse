-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";

-- Reconstruct cars from vertical split + row partition on a fragment
CREATE VIEW "cars" AS
SELECT t0.[CarLoadId], t1.[TrainId], t1.[CarPosition], t0.[CarShape], t0.[LoadLength], t0.[SideConfiguration], t0.[RoofType], t1.[WheelCount], t0.[LoadShape], t0.[LoadQuantity]
FROM (
SELECT [CarLoadsShapeCircleHexagonDiamond].[__orig_rowid] AS __orig_rowid, [local_1].[CarLoadsShapeCircleHexagonDiamond].[CarLoadId], [local_1].[CarLoadsShapeCircleHexagonDiamond].[CarShape], [local_1].[CarLoadsShapeCircleHexagonDiamond].[LoadLength], [local_1].[CarLoadsShapeCircleHexagonDiamond].[SideConfiguration], [local_1].[CarLoadsShapeCircleHexagonDiamond].[RoofType], [local_1].[CarLoadsShapeCircleHexagonDiamond].[LoadShape], [local_1].[CarLoadsShapeCircleHexagonDiamond].[LoadQuantity] FROM [local_1].[CarLoadsShapeCircleHexagonDiamond]
UNION
SELECT [carsWithRectangleLoad].[__orig_rowid] AS __orig_rowid, [local_2].[carsWithRectangleLoad].[carId], [local_2].[carsWithRectangleLoad].[bodyShape], [local_2].[carsWithRectangleLoad].[carLength], [local_2].[carsWithRectangleLoad].[sideConfiguration], [local_2].[carsWithRectangleLoad].[roofStyle], [local_2].[carsWithRectangleLoad].[loadProfile], [local_2].[carsWithRectangleLoad].[loadCount] FROM [local_2].[carsWithRectangleLoad]
UNION
SELECT [carsWithTriangleLoad].[__orig_rowid] AS __orig_rowid, [local_2].[carsWithTriangleLoad].[carId], [local_2].[carsWithTriangleLoad].[bodyShape], [local_2].[carsWithTriangleLoad].[carLength], [local_2].[carsWithTriangleLoad].[sideConfiguration], [local_2].[carsWithTriangleLoad].[roofStyle], [local_2].[carsWithTriangleLoad].[loadProfile], [local_2].[carsWithTriangleLoad].[loadCount] FROM [local_2].[carsWithTriangleLoad]
) t0
JOIN [local_1].[TrainCarSpecifications] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct trains from local_2.trainDirections
CREATE VIEW "trains" AS
SELECT
    "local_2"."trainDirections"."trainId" AS "id",
    "local_2"."trainDirections"."travelDirection" AS "direction"
FROM "local_2"."trainDirections";
