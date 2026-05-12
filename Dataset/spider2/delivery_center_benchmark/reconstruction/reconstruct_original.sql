-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct channels from local_1.comm_chan
CREATE VIEW "channels" AS
SELECT
    "local_1"."comm_chan"."chan_id" AS "channel_id",
    "local_1"."comm_chan"."chan_label" AS "channel_name",
    "local_1"."comm_chan"."chan_kind" AS "channel_type"
FROM "local_1"."comm_chan";

-- Reconstruct deliveries from row partitions (UNION (overlap))
CREATE VIEW "deliveries" AS
SELECT "local_3"."deliveriesDriverIdUpTo7615"."deliveryId" AS "delivery_id", "local_3"."deliveriesDriverIdUpTo7615"."orderId" AS "delivery_order_id", "local_3"."deliveriesDriverIdUpTo7615"."driverId" AS "driver_id", "local_3"."deliveriesDriverIdUpTo7615"."distanceMeters" AS "delivery_distance_meters", "local_3"."deliveriesDriverIdUpTo7615"."deliveryStatus" AS "delivery_status" FROM "local_3"."deliveriesDriverIdUpTo7615"
UNION
SELECT "local_3"."deliveriesDriverId7616To18754"."deliveryId" AS "delivery_id", "local_3"."deliveriesDriverId7616To18754"."orderId" AS "delivery_order_id", "local_3"."deliveriesDriverId7616To18754"."driverId" AS "driver_id", "local_3"."deliveriesDriverId7616To18754"."distanceMeters" AS "delivery_distance_meters", "local_3"."deliveriesDriverId7616To18754"."deliveryStatus" AS "delivery_status" FROM "local_3"."deliveriesDriverId7616To18754"
UNION
SELECT "local_3"."deliveriesDriverId18755To31048"."deliveryId" AS "delivery_id", "local_3"."deliveriesDriverId18755To31048"."orderId" AS "delivery_order_id", "local_3"."deliveriesDriverId18755To31048"."driverId" AS "driver_id", "local_3"."deliveriesDriverId18755To31048"."distanceMeters" AS "delivery_distance_meters", "local_3"."deliveriesDriverId18755To31048"."deliveryStatus" AS "delivery_status" FROM "local_3"."deliveriesDriverId18755To31048"
UNION
SELECT "local_3"."deliveriesDriverIdAbove31048OrNull"."deliveryId" AS "delivery_id", "local_3"."deliveriesDriverIdAbove31048OrNull"."orderId" AS "delivery_order_id", "local_3"."deliveriesDriverIdAbove31048OrNull"."driverId" AS "driver_id", "local_3"."deliveriesDriverIdAbove31048OrNull"."distanceMeters" AS "delivery_distance_meters", "local_3"."deliveriesDriverIdAbove31048OrNull"."deliveryStatus" AS "delivery_status" FROM "local_3"."deliveriesDriverIdAbove31048OrNull";

-- Reconstruct drivers from row partitions (UNION (overlap))
CREATE VIEW "drivers" AS
SELECT "local_1"."drv_freelance"."drv_id" AS "driver_id", "local_1"."drv_freelance"."drv_mode" AS "driver_modal", "local_1"."drv_freelance"."drv_role" AS "driver_type" FROM "local_1"."drv_freelance"
UNION
SELECT "local_1"."drv_logop"."drv_id" AS "driver_id", "local_1"."drv_logop"."drv_mode" AS "driver_modal", "local_1"."drv_logop"."drv_role" AS "driver_type" FROM "local_1"."drv_logop";

-- Reconstruct hubs from local_1.dist_hub
CREATE VIEW "hubs" AS
SELECT
    "local_1"."dist_hub"."hub_uid" AS "hub_id",
    "local_1"."dist_hub"."hub_label" AS "hub_name",
    "local_1"."dist_hub"."hub_town" AS "hub_city",
    "local_1"."dist_hub"."hub_st" AS "hub_state",
    "local_1"."dist_hub"."hub_lat" AS "hub_latitude",
    "local_1"."dist_hub"."hub_lon" AS "hub_longitude"
FROM "local_1"."dist_hub";

-- Reconstruct orders from vertical split + row partition on a fragment
CREATE VIEW "orders" AS
SELECT t0.[order_id_pk], t0.[store_ref_id], t0.[channel_ref_id], t0.[payment_order_ref], t0.[delivery_order_ref], t1.[order_state], t1.[total_amount], t1.[delivery_fee_amount], t1.[delivery_cost_amount], t2.[created_hour_of_day], t2.[created_minute_of_hour], t2.[created_day_of_month], t2.[created_month_number], t2.[created_year_number], t3.[moment_created_at], t3.[moment_accepted_at], t1.[moment_ready_at], t1.[moment_collected_at], t1.[moment_in_expedition_at], t3.[moment_delivering_at], t3.[moment_delivered_at], t3.[moment_finished_at], t1.[metric_collected_duration], t1.[metric_paused_duration], t1.[metric_production_duration], t1.[metric_walking_duration], t1.[metric_expedition_speed_duration], t1.[metric_transit_duration], t1.[metric_cycle_duration]
FROM [local_2].[order_channel_links] t0
JOIN [local_2].[orders_overview] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [orders_created_day_17_to_24].[__orig_rowid] AS __orig_rowid, [local_2].[orders_created_day_17_to_24].[order_id_pk], [local_2].[orders_created_day_17_to_24].[order_state], [local_2].[orders_created_day_17_to_24].[total_amount], [local_2].[orders_created_day_17_to_24].[created_hour_of_day], [local_2].[orders_created_day_17_to_24].[created_minute_of_hour], [local_2].[orders_created_day_17_to_24].[created_day_of_month], [local_2].[orders_created_day_17_to_24].[created_month_number], [local_2].[orders_created_day_17_to_24].[created_year_number] FROM [local_2].[orders_created_day_17_to_24]
UNION
SELECT [orders_created_day_25_or_null].[__orig_rowid] AS __orig_rowid, [local_2].[orders_created_day_25_or_null].[order_id_pk], [local_2].[orders_created_day_25_or_null].[order_state], [local_2].[orders_created_day_25_or_null].[total_amount], [local_2].[orders_created_day_25_or_null].[created_hour_of_day], [local_2].[orders_created_day_25_or_null].[created_minute_of_hour], [local_2].[orders_created_day_25_or_null].[created_day_of_month], [local_2].[orders_created_day_25_or_null].[created_month_number], [local_2].[orders_created_day_25_or_null].[created_year_number] FROM [local_2].[orders_created_day_25_or_null]
UNION
SELECT [orders_created_day_9_to_16].[__orig_rowid] AS __orig_rowid, [local_2].[orders_created_day_9_to_16].[order_id_pk], [local_2].[orders_created_day_9_to_16].[order_state], [local_2].[orders_created_day_9_to_16].[total_amount], [local_2].[orders_created_day_9_to_16].[created_hour_of_day], [local_2].[orders_created_day_9_to_16].[created_minute_of_hour], [local_2].[orders_created_day_9_to_16].[created_day_of_month], [local_2].[orders_created_day_9_to_16].[created_month_number], [local_2].[orders_created_day_9_to_16].[created_year_number] FROM [local_2].[orders_created_day_9_to_16]
UNION
SELECT [orders_created_day_up_to_8].[__orig_rowid] AS __orig_rowid, [local_2].[orders_created_day_up_to_8].[order_id_pk], [local_2].[orders_created_day_up_to_8].[order_state], [local_2].[orders_created_day_up_to_8].[total_amount], [local_2].[orders_created_day_up_to_8].[created_hour_of_day], [local_2].[orders_created_day_up_to_8].[created_minute_of_hour], [local_2].[orders_created_day_up_to_8].[created_day_of_month], [local_2].[orders_created_day_up_to_8].[created_month_number], [local_2].[orders_created_day_up_to_8].[created_year_number] FROM [local_2].[orders_created_day_up_to_8]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_2].[orders_timeline_metrics] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct payments from row partitions (UNION (overlap))
CREATE VIEW "payments" AS
SELECT "local_2"."payments_known_amounts"."payment_id_pk" AS "payment_id", "local_2"."payments_known_amounts"."payment_order_ref" AS "payment_order_id", "local_2"."payments_known_amounts"."amount_paid" AS "payment_amount", "local_2"."payments_known_amounts"."fee_charged" AS "payment_fee", "local_2"."payments_known_amounts"."method_type" AS "payment_method", "local_2"."payments_known_amounts"."payment_status_flag" AS "payment_status" FROM "local_2"."payments_known_amounts"
UNION
SELECT "local_2"."payments_amounts_other"."payment_id_pk" AS "payment_id", "local_2"."payments_amounts_other"."payment_order_ref" AS "payment_order_id", "local_2"."payments_amounts_other"."amount_paid" AS "payment_amount", "local_2"."payments_amounts_other"."fee_charged" AS "payment_fee", "local_2"."payments_amounts_other"."method_type" AS "payment_method", "local_2"."payments_amounts_other"."payment_status_flag" AS "payment_status" FROM "local_2"."payments_amounts_other";

-- Reconstruct stores from vertical split + row partition on a fragment
CREATE VIEW "stores" AS
SELECT t0.[storeId], t0.[hubId], t0.[storeName], t0.[storeSegment], t0.[planPrice], t1.[storeLatitude], t1.[storeLongitude]
FROM (
SELECT [storesHubId19To27].[__orig_rowid] AS __orig_rowid, [local_3].[storesHubId19To27].[storeId], [local_3].[storesHubId19To27].[hubId], [local_3].[storesHubId19To27].[storeName], [local_3].[storesHubId19To27].[storeSegment], [local_3].[storesHubId19To27].[planPrice] FROM [local_3].[storesHubId19To27]
UNION
SELECT [storesHubId28To35].[__orig_rowid] AS __orig_rowid, [local_3].[storesHubId28To35].[storeId], [local_3].[storesHubId28To35].[hubId], [local_3].[storesHubId28To35].[storeName], [local_3].[storesHubId28To35].[storeSegment], [local_3].[storesHubId28To35].[planPrice] FROM [local_3].[storesHubId28To35]
UNION
SELECT [storesHubIdAbove35OrNull].[__orig_rowid] AS __orig_rowid, [local_3].[storesHubIdAbove35OrNull].[storeId], [local_3].[storesHubIdAbove35OrNull].[hubId], [local_3].[storesHubIdAbove35OrNull].[storeName], [local_3].[storesHubIdAbove35OrNull].[storeSegment], [local_3].[storesHubIdAbove35OrNull].[planPrice] FROM [local_3].[storesHubIdAbove35OrNull]
UNION
SELECT [storesHubIdUpTo18].[__orig_rowid] AS __orig_rowid, [local_3].[storesHubIdUpTo18].[storeId], [local_3].[storesHubIdUpTo18].[hubId], [local_3].[storesHubIdUpTo18].[storeName], [local_3].[storesHubIdUpTo18].[storeSegment], [local_3].[storesHubIdUpTo18].[planPrice] FROM [local_3].[storesHubIdUpTo18]
) t0
JOIN [local_3].[storesHubIdEquals2] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];
