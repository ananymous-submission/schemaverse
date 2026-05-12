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