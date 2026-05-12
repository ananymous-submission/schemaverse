-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/delivery_center/delivery_center.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "comm_chan" (
    "chan_id" INTEGER,
    "chan_label" VARCHAR(50),
    "chan_kind" VARCHAR(50)
);

CREATE TABLE "drv_freelance" (
    "drv_id" INTEGER,
    "drv_mode" VARCHAR(50),
    "drv_role" VARCHAR(50)
);

CREATE TABLE "drv_logop" (
    "drv_id" INTEGER,
    "drv_mode" VARCHAR(50),
    "drv_role" VARCHAR(50)
);

CREATE TABLE "dist_hub" (
    "hub_uid" INTEGER,
    "hub_label" VARCHAR(50),
    "hub_town" VARCHAR(50),
    "hub_st" CHAR(2),
    "hub_lat" DECIMAL(9, 6),
    "hub_lon" DECIMAL(9, 6)
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "order_channel_links" (
    "order_id_pk" INTEGER,
    "channel_ref_id" INTEGER,
    "delivery_order_ref" INTEGER,
    "payment_order_ref" INTEGER,
    "store_ref_id" INTEGER
);

CREATE TABLE "orders_overview" (
    "order_id_pk" INTEGER,
    "total_amount" DECIMAL(10, 2),
    "delivery_cost_amount" DECIMAL(10, 2),
    "delivery_fee_amount" DECIMAL(10, 2),
    "metric_collected_duration" DECIMAL(10, 2),
    "metric_cycle_duration" DECIMAL(10, 2),
    "metric_expedition_speed_duration" DECIMAL(10, 2),
    "metric_paused_duration" DECIMAL(10, 2),
    "metric_production_duration" DECIMAL(10, 2),
    "metric_transit_duration" DECIMAL(10, 2),
    "metric_walking_duration" DECIMAL(10, 2),
    "moment_collected_at" DATETIME,
    "moment_in_expedition_at" DATETIME,
    "moment_ready_at" DATETIME,
    "order_state" VARCHAR(50)
);

CREATE TABLE "orders_created_day_up_to_8" (
    "order_id_pk" INTEGER,
    "total_amount" DECIMAL(10, 2),
    "created_day_of_month" INTEGER,
    "created_hour_of_day" INTEGER,
    "created_minute_of_hour" INTEGER,
    "created_month_number" INTEGER,
    "created_year_number" INTEGER,
    "order_state" VARCHAR(50)
);

CREATE TABLE "orders_created_day_9_to_16" (
    "order_id_pk" INTEGER,
    "total_amount" DECIMAL(10, 2),
    "created_day_of_month" INTEGER,
    "created_hour_of_day" INTEGER,
    "created_minute_of_hour" INTEGER,
    "created_month_number" INTEGER,
    "created_year_number" INTEGER,
    "order_state" VARCHAR(50)
);

CREATE TABLE "orders_created_day_17_to_24" (
    "order_id_pk" INTEGER,
    "total_amount" DECIMAL(10, 2),
    "created_day_of_month" INTEGER,
    "created_hour_of_day" INTEGER,
    "created_minute_of_hour" INTEGER,
    "created_month_number" INTEGER,
    "created_year_number" INTEGER,
    "order_state" VARCHAR(50)
);

CREATE TABLE "orders_created_day_25_or_null" (
    "order_id_pk" INTEGER,
    "total_amount" DECIMAL(10, 2),
    "created_day_of_month" INTEGER,
    "created_hour_of_day" INTEGER,
    "created_minute_of_hour" INTEGER,
    "created_month_number" INTEGER,
    "created_year_number" INTEGER,
    "order_state" VARCHAR(50)
);

CREATE TABLE "orders_timeline_metrics" (
    "order_id_pk" INTEGER,
    "delivery_cost_amount" DECIMAL(10, 2),
    "delivery_fee_amount" DECIMAL(10, 2),
    "metric_collected_duration" DECIMAL(10, 2),
    "metric_cycle_duration" DECIMAL(10, 2),
    "metric_expedition_speed_duration" DECIMAL(10, 2),
    "metric_production_duration" DECIMAL(10, 2),
    "metric_walking_duration" DECIMAL(10, 2),
    "moment_accepted_at" DATETIME,
    "moment_collected_at" DATETIME,
    "moment_created_at" DATETIME,
    "moment_delivered_at" DATETIME,
    "moment_delivering_at" DATETIME,
    "moment_finished_at" DATETIME,
    "moment_in_expedition_at" DATETIME,
    "moment_ready_at" DATETIME
);

CREATE TABLE "payments_known_amounts" (
    "payment_id_pk" INTEGER,
    "payment_order_ref" INTEGER,
    "amount_paid" DECIMAL(10, 2),
    "fee_charged" DECIMAL(10, 2),
    "method_type" VARCHAR(50),
    "payment_status_flag" VARCHAR(50)
);

CREATE TABLE "payments_amounts_other" (
    "payment_id_pk" INTEGER,
    "payment_order_ref" INTEGER,
    "amount_paid" DECIMAL(10, 2),
    "fee_charged" DECIMAL(10, 2),
    "method_type" VARCHAR(50),
    "payment_status_flag" VARCHAR(50)
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "deliveriesDriverIdUpTo7615" (
    "deliveryId" INTEGER,
    "orderId" INTEGER,
    "driverId" INTEGER,
    "distanceMeters" DECIMAL(10, 2),
    "deliveryStatus" VARCHAR(50)
);

CREATE TABLE "deliveriesDriverId7616To18754" (
    "deliveryId" INTEGER,
    "orderId" INTEGER,
    "driverId" INTEGER,
    "distanceMeters" DECIMAL(10, 2),
    "deliveryStatus" VARCHAR(50)
);

CREATE TABLE "deliveriesDriverId18755To31048" (
    "deliveryId" INTEGER,
    "orderId" INTEGER,
    "driverId" INTEGER,
    "distanceMeters" DECIMAL(10, 2),
    "deliveryStatus" VARCHAR(50)
);

CREATE TABLE "deliveriesDriverIdAbove31048OrNull" (
    "deliveryId" INTEGER,
    "orderId" INTEGER,
    "driverId" INTEGER,
    "distanceMeters" DECIMAL(10, 2),
    "deliveryStatus" VARCHAR(50)
);

CREATE TABLE "storesHubIdUpTo18" (
    "storeId" INTEGER,
    "hubId" INTEGER,
    "storeName" VARCHAR(50),
    "planPrice" DECIMAL(10, 2),
    "storeSegment" VARCHAR(50)
);

CREATE TABLE "storesHubId19To27" (
    "storeId" INTEGER,
    "hubId" INTEGER,
    "storeName" VARCHAR(50),
    "planPrice" DECIMAL(10, 2),
    "storeSegment" VARCHAR(50)
);

CREATE TABLE "storesHubId28To35" (
    "storeId" INTEGER,
    "hubId" INTEGER,
    "storeName" VARCHAR(50),
    "planPrice" DECIMAL(10, 2),
    "storeSegment" VARCHAR(50)
);

CREATE TABLE "storesHubIdAbove35OrNull" (
    "storeId" INTEGER,
    "hubId" INTEGER,
    "storeName" VARCHAR(50),
    "planPrice" DECIMAL(10, 2),
    "storeSegment" VARCHAR(50)
);

CREATE TABLE "storesHubIdEquals2" (
    "storeId" INTEGER,
    "hubId" INTEGER,
    "storeLatitude" DECIMAL(9, 6),
    "storeLongitude" DECIMAL(9, 6),
    "storeName" VARCHAR(50),
    "storeSegment" VARCHAR(50)
);

