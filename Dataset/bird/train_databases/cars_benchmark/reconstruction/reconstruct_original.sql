-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct country from local_1.Nation
CREATE VIEW "country" AS
SELECT
    "local_1"."Nation"."NationId" AS "origin",
    "local_1"."Nation"."NationName" AS "country"
FROM "local_1"."Nation";

-- Reconstruct data from vertical split + row partition on a fragment
CREATE VIEW "data" AS
SELECT t0.[recordId], t0.[milesPerGallon], t1.[cylinderCount], t1.[engineDisplacement], t1.[engineHorsepower], t0.[vehicleWeight], t0.[accelerationValue], t0.[modelYear], t0.[vehicleName]
FROM (
SELECT [vehicleAccelerationTopQuartile].[__orig_rowid] AS __orig_rowid, [local_2].[vehicleAccelerationTopQuartile].[recordId], [local_2].[vehicleAccelerationTopQuartile].[milesPerGallon], [local_2].[vehicleAccelerationTopQuartile].[vehicleWeight], [local_2].[vehicleAccelerationTopQuartile].[accelerationValue], [local_2].[vehicleAccelerationTopQuartile].[modelYear], [local_2].[vehicleAccelerationTopQuartile].[vehicleName] FROM [local_2].[vehicleAccelerationTopQuartile]
UNION
SELECT [accel_gt_13_8_lte_15_5].[__orig_rowid] AS __orig_rowid, [local_3].[accel_gt_13_8_lte_15_5].[price_id_ref], [local_3].[accel_gt_13_8_lte_15_5].[mpg_val], [local_3].[accel_gt_13_8_lte_15_5].[veh_wt], [local_3].[accel_gt_13_8_lte_15_5].[accel_sec], [local_3].[accel_gt_13_8_lte_15_5].[mdl_id], [local_3].[accel_gt_13_8_lte_15_5].[veh_name] FROM [local_3].[accel_gt_13_8_lte_15_5]
UNION
SELECT [accel_gt_15_5_lte_17_1].[__orig_rowid] AS __orig_rowid, [local_3].[accel_gt_15_5_lte_17_1].[accel_rec_id], [local_3].[accel_gt_15_5_lte_17_1].[mpg_val], [local_3].[accel_gt_15_5_lte_17_1].[veh_wt], [local_3].[accel_gt_15_5_lte_17_1].[accel_sec], [local_3].[accel_gt_15_5_lte_17_1].[mdl_id], [local_3].[accel_gt_15_5_lte_17_1].[veh_name] FROM [local_3].[accel_gt_15_5_lte_17_1]
UNION
SELECT [accel_lte_13_8].[__orig_rowid] AS __orig_rowid, [local_3].[accel_lte_13_8].[price_id_ref], [local_3].[accel_lte_13_8].[mpg_val], [local_3].[accel_lte_13_8].[veh_wt], [local_3].[accel_lte_13_8].[accel_sec], [local_3].[accel_lte_13_8].[mdl_id], [local_3].[accel_lte_13_8].[veh_name] FROM [local_3].[accel_lte_13_8]
) t0
JOIN [local_2].[vehicleAccelerationDataset] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct price from local_3.veh_price
CREATE VIEW "price" AS
SELECT
    "local_3"."veh_price"."price_id" AS "ID",
    "local_3"."veh_price"."price_usd" AS "price"
FROM "local_3"."veh_price";

-- Reconstruct production from local_1.ProductionRecord
CREATE VIEW "production" AS
SELECT
    "local_1"."ProductionRecord"."ProducerId" AS "ID",
    "local_1"."ProductionRecord"."ModelYear" AS "model_year",
    "local_1"."ProductionRecord"."NationId" AS "country"
FROM "local_1"."ProductionRecord";
