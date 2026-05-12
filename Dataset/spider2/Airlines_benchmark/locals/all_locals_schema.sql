-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/Airlines/Airlines.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "aircraft_catalog" (
    "aircraft_designator" character(3) NOT NULL,
    "model_spec" jsonb NOT NULL,
    "max_range_km" INTEGER NOT NULL
);

CREATE TABLE "airports_by_timezone_europe_moscow" (
    "iata_code" character(3) NOT NULL,
    "name_translations" jsonb NOT NULL,
    "city_translations" jsonb NOT NULL,
    "location_point" point NOT NULL,
    "timezone_id" TEXT NOT NULL
);

CREATE TABLE "airports_by_timezone_asia_yekaterinburg" (
    "iata_code" character(3) NOT NULL,
    "name_translations" jsonb NOT NULL,
    "city_translations" jsonb NOT NULL,
    "location_point" point NOT NULL,
    "timezone_id" TEXT NOT NULL
);

CREATE TABLE "airports_timezone_asia_krasnoyarsk_or_other" (
    "iata_code" character(3) NOT NULL,
    "name_translations" jsonb NOT NULL,
    "city_translations" jsonb NOT NULL,
    "location_point" point NOT NULL,
    "timezone_id" TEXT NOT NULL
);

CREATE TABLE "airports_timezone_irkt_yakutsk_samara_vladivostok_novokuznetsk_volgograd" (
    "iata_code" character(3) NOT NULL,
    "name_translations" jsonb NOT NULL,
    "city_translations" jsonb NOT NULL,
    "location_point" point NOT NULL,
    "timezone_id" TEXT NOT NULL
);

CREATE TABLE "flights_arrivals_through_2017_07_31_12_16_moscow" (
    "flight_record_id" INTEGER NOT NULL,
    "arrival_time_actual" timestamp with time zone,
    "departure_time_actual" timestamp with time zone,
    "aircraft_designator" character(3) NOT NULL,
    "arrival_iata_code" character(3) NOT NULL,
    "flight_number" character(6) NOT NULL,
    "arrival_time_scheduled" timestamp with time zone NOT NULL,
    "departure_time_scheduled" timestamp with time zone NOT NULL,
    "flight_status" character varying(20) NOT NULL
);

CREATE TABLE "flights_arrivals_between_2017_07_31_12_16_and_2017_08_15_15_04_moscow" (
    "flight_record_id" INTEGER NOT NULL,
    "arrival_time_actual" timestamp with time zone,
    "departure_time_actual" timestamp with time zone,
    "aircraft_designator" character(3) NOT NULL,
    "arrival_iata_code" character(3) NOT NULL,
    "flight_number" character(6) NOT NULL,
    "arrival_time_scheduled" timestamp with time zone NOT NULL,
    "departure_time_scheduled" timestamp with time zone NOT NULL,
    "flight_status" character varying(20) NOT NULL
);

CREATE TABLE "flights_arrivals_after_2017_08_15_15_04_or_null_moscow" (
    "flight_record_id" INTEGER NOT NULL,
    "arrival_time_actual" timestamp with time zone,
    "departure_time_actual" timestamp with time zone,
    "aircraft_designator" character(3) NOT NULL,
    "arrival_iata_code" character(3) NOT NULL,
    "flight_number" character(6) NOT NULL,
    "arrival_time_scheduled" timestamp with time zone NOT NULL,
    "departure_time_scheduled" timestamp with time zone NOT NULL,
    "flight_status" character varying(20) NOT NULL
);

CREATE TABLE "flight_assignments_by_aircraft" (
    "flight_record_id" INTEGER NOT NULL,
    "aircraft_designator" character(3) NOT NULL,
    "arrival_iata_code" character(3) NOT NULL,
    "departure_iata_code" character(3) NOT NULL,
    "flight_number" character(6) NOT NULL,
    "flight_status" character varying(20) NOT NULL
);

CREATE TABLE "seats_for_economy_fare" (
    "aircraft_designator" character(3) NOT NULL,
    "seat_label" character varying(4) NOT NULL,
    "fare_category" character varying(10) NOT NULL
);

CREATE TABLE "seats_for_business_and_comfort_or_null_fare" (
    "aircraft_designator" character(3) NOT NULL,
    "seat_label" character varying(4) NOT NULL,
    "fare_category" character varying(10) NOT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "bp_bno_le15" (
    "tkt_ref" character(13) NOT NULL,
    "flt_ref" INTEGER NOT NULL,
    "brd_pos" INTEGER NOT NULL,
    "seat_loc" character varying(4) NOT NULL
);

CREATE TABLE "bp_bno_gt15_lte36" (
    "tkt_ref" character(13) NOT NULL,
    "flt_ref" INTEGER NOT NULL,
    "brd_pos" INTEGER NOT NULL,
    "seat_loc" character varying(4) NOT NULL
);

CREATE TABLE "bp_bno_gt36_lte72" (
    "tkt_ref" character(13) NOT NULL,
    "flt_ref" INTEGER NOT NULL,
    "brd_pos" INTEGER NOT NULL,
    "seat_loc" character varying(4) NOT NULL
);

CREATE TABLE "bp_bno_gt72_or_null" (
    "tkt_ref" character(13) NOT NULL,
    "flt_ref" INTEGER NOT NULL,
    "brd_pos" INTEGER NOT NULL,
    "seat_loc" character varying(4) NOT NULL
);

CREATE TABLE "bk_dte_on_or_before_2017_07_12_081800" (
    "bk_ref" character(6) NOT NULL,
    "bk_ts" timestamp with time zone NOT NULL,
    "ttl_amt" numeric(10,2) NOT NULL
);

CREATE TABLE "bk_dte_gt20170712_081800_lte20170724_052400" (
    "bk_ref" character(6) NOT NULL,
    "bk_ts" timestamp with time zone NOT NULL,
    "ttl_amt" numeric(10,2) NOT NULL
);

CREATE TABLE "bk_dte_gt20170724_052400_lte20170805_015800" (
    "bk_ref" character(6) NOT NULL,
    "bk_ts" timestamp with time zone NOT NULL,
    "ttl_amt" numeric(10,2) NOT NULL
);

CREATE TABLE "bk_dte_gt20170805_015800_or_null" (
    "bk_ref" character(6) NOT NULL,
    "bk_ts" timestamp with time zone NOT NULL,
    "ttl_amt" numeric(10,2) NOT NULL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "ticketFlightsListedAmounts" (
    "ticketNumber" character(13) NOT NULL,
    "flightId" INTEGER NOT NULL,
    "fareCondition" character varying(10) NOT NULL,
    "fareAmount" numeric(10,2) NOT NULL
);

CREATE TABLE "ticketFlightsOtherAmounts" (
    "ticketNumber" character(13) NOT NULL,
    "flightId" INTEGER NOT NULL,
    "fareCondition" character varying(10) NOT NULL,
    "fareAmount" numeric(10,2) NOT NULL
);

CREATE TABLE "bookingTickets" (
    "ticketNumber" character(13) NOT NULL,
    "bookingReference" character(6) NOT NULL,
    "passengerIdentifier" character varying(20) NOT NULL
);

