-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct Air Carriers from local_2.airline_operators
CREATE VIEW "Air Carriers" AS
SELECT
    "local_2"."airline_operators"."operator_id" AS "Code",
    "local_2"."airline_operators"."operator_description" AS "Description"
FROM "local_2"."airline_operators";

-- Reconstruct Airlines from local_1.flt_ops_rec
CREATE VIEW "Airlines" AS
SELECT
    "local_1"."flt_ops_rec"."flt_dt" AS "FL_DATE",
    "local_1"."flt_ops_rec"."op_cr_id" AS "OP_CARRIER_AIRLINE_ID",
    "local_1"."flt_ops_rec"."tail_id" AS "TAIL_NUM",
    "local_1"."flt_ops_rec"."op_fl_no" AS "OP_CARRIER_FL_NUM",
    "local_1"."flt_ops_rec"."org_air_id" AS "ORIGIN_AIRPORT_ID",
    "local_1"."flt_ops_rec"."org_air_seq" AS "ORIGIN_AIRPORT_SEQ_ID",
    "local_1"."flt_ops_rec"."org_city_mkt" AS "ORIGIN_CITY_MARKET_ID",
    "local_1"."flt_ops_rec"."org_cd" AS "ORIGIN",
    "local_1"."flt_ops_rec"."dest_air_id" AS "DEST_AIRPORT_ID",
    "local_1"."flt_ops_rec"."dest_air_seq" AS "DEST_AIRPORT_SEQ_ID",
    "local_1"."flt_ops_rec"."dest_city_mkt" AS "DEST_CITY_MARKET_ID",
    "local_1"."flt_ops_rec"."dest_cd" AS "DEST",
    "local_1"."flt_ops_rec"."sched_dep_tm" AS "CRS_DEP_TIME",
    "local_1"."flt_ops_rec"."dep_tm" AS "DEP_TIME",
    "local_1"."flt_ops_rec"."dep_dly" AS "DEP_DELAY",
    "local_1"."flt_ops_rec"."dep_dly_adj" AS "DEP_DELAY_NEW",
    "local_1"."flt_ops_rec"."arr_tm" AS "ARR_TIME",
    "local_1"."flt_ops_rec"."arr_dly" AS "ARR_DELAY",
    "local_1"."flt_ops_rec"."arr_dly_adj" AS "ARR_DELAY_NEW",
    "local_1"."flt_ops_rec"."cancel_flg" AS "CANCELLED",
    "local_1"."flt_ops_rec"."cancel_cd" AS "CANCELLATION_CODE",
    "local_1"."flt_ops_rec"."sched_elapsed" AS "CRS_ELAPSED_TIME",
    "local_1"."flt_ops_rec"."act_elapsed" AS "ACTUAL_ELAPSED_TIME",
    "local_1"."flt_ops_rec"."carrier_dly" AS "CARRIER_DELAY",
    "local_1"."flt_ops_rec"."wx_dly" AS "WEATHER_DELAY",
    "local_1"."flt_ops_rec"."nas_dly" AS "NAS_DELAY",
    "local_1"."flt_ops_rec"."sec_dly" AS "SECURITY_DELAY",
    "local_1"."flt_ops_rec"."late_acft_dly" AS "LATE_AIRCRAFT_DELAY"
FROM "local_1"."flt_ops_rec";

-- Reconstruct Airports from local_3.airportDirectory
CREATE VIEW "Airports" AS
SELECT
    "local_3"."airportDirectory"."airportCode" AS "Code",
    "local_3"."airportDirectory"."airportDescription" AS "Description"
FROM "local_3"."airportDirectory";
