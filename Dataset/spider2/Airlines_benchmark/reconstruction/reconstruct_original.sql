-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct aircrafts_data from local_1.aircraft_catalog
CREATE VIEW "aircrafts_data" AS
SELECT
    "local_1"."aircraft_catalog"."aircraft_designator" AS "aircraft_code",
    "local_1"."aircraft_catalog"."model_spec" AS "model",
    "local_1"."aircraft_catalog"."max_range_km" AS "range"
FROM "local_1"."aircraft_catalog";

-- Reconstruct airports_data from row partitions (UNION (overlap))
CREATE VIEW "airports_data" AS
SELECT "local_1"."airports_by_timezone_europe_moscow"."iata_code" AS "airport_code", "local_1"."airports_by_timezone_europe_moscow"."name_translations" AS "airport_name", "local_1"."airports_by_timezone_europe_moscow"."city_translations" AS "city", "local_1"."airports_by_timezone_europe_moscow"."location_point" AS "coordinates", "local_1"."airports_by_timezone_europe_moscow"."timezone_id" AS "timezone" FROM "local_1"."airports_by_timezone_europe_moscow"
UNION
SELECT "local_1"."airports_by_timezone_asia_yekaterinburg"."iata_code" AS "airport_code", "local_1"."airports_by_timezone_asia_yekaterinburg"."name_translations" AS "airport_name", "local_1"."airports_by_timezone_asia_yekaterinburg"."city_translations" AS "city", "local_1"."airports_by_timezone_asia_yekaterinburg"."location_point" AS "coordinates", "local_1"."airports_by_timezone_asia_yekaterinburg"."timezone_id" AS "timezone" FROM "local_1"."airports_by_timezone_asia_yekaterinburg"
UNION
SELECT "local_1"."airports_timezone_asia_krasnoyarsk_or_other"."iata_code" AS "airport_code", "local_1"."airports_timezone_asia_krasnoyarsk_or_other"."name_translations" AS "airport_name", "local_1"."airports_timezone_asia_krasnoyarsk_or_other"."city_translations" AS "city", "local_1"."airports_timezone_asia_krasnoyarsk_or_other"."location_point" AS "coordinates", "local_1"."airports_timezone_asia_krasnoyarsk_or_other"."timezone_id" AS "timezone" FROM "local_1"."airports_timezone_asia_krasnoyarsk_or_other"
UNION
SELECT "local_1"."airports_timezone_irkt_yakutsk_samara_vladivostok_novokuznetsk_volgograd"."iata_code" AS "airport_code", "local_1"."airports_timezone_irkt_yakutsk_samara_vladivostok_novokuznetsk_volgograd"."name_translations" AS "airport_name", "local_1"."airports_timezone_irkt_yakutsk_samara_vladivostok_novokuznetsk_volgograd"."city_translations" AS "city", "local_1"."airports_timezone_irkt_yakutsk_samara_vladivostok_novokuznetsk_volgograd"."location_point" AS "coordinates", "local_1"."airports_timezone_irkt_yakutsk_samara_vladivostok_novokuznetsk_volgograd"."timezone_id" AS "timezone" FROM "local_1"."airports_timezone_irkt_yakutsk_samara_vladivostok_novokuznetsk_volgograd";

-- Reconstruct boarding_passes from row partitions (UNION (overlap))
CREATE VIEW "boarding_passes" AS
SELECT "local_2"."bp_bno_le15"."tkt_ref" AS "ticket_no", "local_2"."bp_bno_le15"."flt_ref" AS "flight_id", "local_2"."bp_bno_le15"."brd_pos" AS "boarding_no", "local_2"."bp_bno_le15"."seat_loc" AS "seat_no" FROM "local_2"."bp_bno_le15"
UNION
SELECT "local_2"."bp_bno_gt15_lte36"."tkt_ref" AS "ticket_no", "local_2"."bp_bno_gt15_lte36"."flt_ref" AS "flight_id", "local_2"."bp_bno_gt15_lte36"."brd_pos" AS "boarding_no", "local_2"."bp_bno_gt15_lte36"."seat_loc" AS "seat_no" FROM "local_2"."bp_bno_gt15_lte36"
UNION
SELECT "local_2"."bp_bno_gt36_lte72"."tkt_ref" AS "ticket_no", "local_2"."bp_bno_gt36_lte72"."flt_ref" AS "flight_id", "local_2"."bp_bno_gt36_lte72"."brd_pos" AS "boarding_no", "local_2"."bp_bno_gt36_lte72"."seat_loc" AS "seat_no" FROM "local_2"."bp_bno_gt36_lte72"
UNION
SELECT "local_2"."bp_bno_gt72_or_null"."tkt_ref" AS "ticket_no", "local_2"."bp_bno_gt72_or_null"."flt_ref" AS "flight_id", "local_2"."bp_bno_gt72_or_null"."brd_pos" AS "boarding_no", "local_2"."bp_bno_gt72_or_null"."seat_loc" AS "seat_no" FROM "local_2"."bp_bno_gt72_or_null";

-- Reconstruct bookings from row partitions (UNION (overlap))
CREATE VIEW "bookings" AS
SELECT "local_2"."bk_dte_on_or_before_2017_07_12_081800"."bk_ref" AS "book_ref", "local_2"."bk_dte_on_or_before_2017_07_12_081800"."bk_ts" AS "book_date", "local_2"."bk_dte_on_or_before_2017_07_12_081800"."ttl_amt" AS "total_amount" FROM "local_2"."bk_dte_on_or_before_2017_07_12_081800"
UNION
SELECT "local_2"."bk_dte_gt20170712_081800_lte20170724_052400"."bk_ref" AS "book_ref", "local_2"."bk_dte_gt20170712_081800_lte20170724_052400"."bk_ts" AS "book_date", "local_2"."bk_dte_gt20170712_081800_lte20170724_052400"."ttl_amt" AS "total_amount" FROM "local_2"."bk_dte_gt20170712_081800_lte20170724_052400"
UNION
SELECT "local_2"."bk_dte_gt20170724_052400_lte20170805_015800"."bk_ref" AS "book_ref", "local_2"."bk_dte_gt20170724_052400_lte20170805_015800"."bk_ts" AS "book_date", "local_2"."bk_dte_gt20170724_052400_lte20170805_015800"."ttl_amt" AS "total_amount" FROM "local_2"."bk_dte_gt20170724_052400_lte20170805_015800"
UNION
SELECT "local_2"."bk_dte_gt20170805_015800_or_null"."bk_ref" AS "book_ref", "local_2"."bk_dte_gt20170805_015800_or_null"."bk_ts" AS "book_date", "local_2"."bk_dte_gt20170805_015800_or_null"."ttl_amt" AS "total_amount" FROM "local_2"."bk_dte_gt20170805_015800_or_null";

-- Reconstruct flights from vertical split + row partition on a fragment
CREATE VIEW "flights" AS
SELECT t0.[flight_record_id], t0.[flight_number], t0.[departure_time_scheduled], t0.[arrival_time_scheduled], t1.[departure_iata_code], t0.[arrival_iata_code], t0.[flight_status], t0.[aircraft_designator], t0.[departure_time_actual], t0.[arrival_time_actual]
FROM (
SELECT [flights_arrivals_after_2017_08_15_15_04_or_null_moscow].[__orig_rowid] AS __orig_rowid, [local_1].[flights_arrivals_after_2017_08_15_15_04_or_null_moscow].[flight_record_id], [local_1].[flights_arrivals_after_2017_08_15_15_04_or_null_moscow].[flight_number], [local_1].[flights_arrivals_after_2017_08_15_15_04_or_null_moscow].[departure_time_scheduled], [local_1].[flights_arrivals_after_2017_08_15_15_04_or_null_moscow].[arrival_time_scheduled], [local_1].[flights_arrivals_after_2017_08_15_15_04_or_null_moscow].[arrival_iata_code], [local_1].[flights_arrivals_after_2017_08_15_15_04_or_null_moscow].[flight_status], [local_1].[flights_arrivals_after_2017_08_15_15_04_or_null_moscow].[aircraft_designator], [local_1].[flights_arrivals_after_2017_08_15_15_04_or_null_moscow].[departure_time_actual], [local_1].[flights_arrivals_after_2017_08_15_15_04_or_null_moscow].[arrival_time_actual] FROM [local_1].[flights_arrivals_after_2017_08_15_15_04_or_null_moscow]
UNION
SELECT [flights_arrivals_between_2017_07_31_12_16_and_2017_08_15_15_04_moscow].[__orig_rowid] AS __orig_rowid, [local_1].[flights_arrivals_between_2017_07_31_12_16_and_2017_08_15_15_04_moscow].[flight_record_id], [local_1].[flights_arrivals_between_2017_07_31_12_16_and_2017_08_15_15_04_moscow].[flight_number], [local_1].[flights_arrivals_between_2017_07_31_12_16_and_2017_08_15_15_04_moscow].[departure_time_scheduled], [local_1].[flights_arrivals_between_2017_07_31_12_16_and_2017_08_15_15_04_moscow].[arrival_time_scheduled], [local_1].[flights_arrivals_between_2017_07_31_12_16_and_2017_08_15_15_04_moscow].[arrival_iata_code], [local_1].[flights_arrivals_between_2017_07_31_12_16_and_2017_08_15_15_04_moscow].[flight_status], [local_1].[flights_arrivals_between_2017_07_31_12_16_and_2017_08_15_15_04_moscow].[aircraft_designator], [local_1].[flights_arrivals_between_2017_07_31_12_16_and_2017_08_15_15_04_moscow].[departure_time_actual], [local_1].[flights_arrivals_between_2017_07_31_12_16_and_2017_08_15_15_04_moscow].[arrival_time_actual] FROM [local_1].[flights_arrivals_between_2017_07_31_12_16_and_2017_08_15_15_04_moscow]
UNION
SELECT [flights_arrivals_through_2017_07_31_12_16_moscow].[__orig_rowid] AS __orig_rowid, [local_1].[flights_arrivals_through_2017_07_31_12_16_moscow].[flight_record_id], [local_1].[flights_arrivals_through_2017_07_31_12_16_moscow].[flight_number], [local_1].[flights_arrivals_through_2017_07_31_12_16_moscow].[departure_time_scheduled], [local_1].[flights_arrivals_through_2017_07_31_12_16_moscow].[arrival_time_scheduled], [local_1].[flights_arrivals_through_2017_07_31_12_16_moscow].[arrival_iata_code], [local_1].[flights_arrivals_through_2017_07_31_12_16_moscow].[flight_status], [local_1].[flights_arrivals_through_2017_07_31_12_16_moscow].[aircraft_designator], [local_1].[flights_arrivals_through_2017_07_31_12_16_moscow].[departure_time_actual], [local_1].[flights_arrivals_through_2017_07_31_12_16_moscow].[arrival_time_actual] FROM [local_1].[flights_arrivals_through_2017_07_31_12_16_moscow]
) t0
JOIN [local_1].[flight_assignments_by_aircraft] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct seats from row partitions (UNION (overlap))
CREATE VIEW "seats" AS
SELECT "local_1"."seats_for_economy_fare"."aircraft_designator" AS "aircraft_code", "local_1"."seats_for_economy_fare"."seat_label" AS "seat_no", "local_1"."seats_for_economy_fare"."fare_category" AS "fare_conditions" FROM "local_1"."seats_for_economy_fare"
UNION
SELECT "local_1"."seats_for_business_and_comfort_or_null_fare"."aircraft_designator" AS "aircraft_code", "local_1"."seats_for_business_and_comfort_or_null_fare"."seat_label" AS "seat_no", "local_1"."seats_for_business_and_comfort_or_null_fare"."fare_category" AS "fare_conditions" FROM "local_1"."seats_for_business_and_comfort_or_null_fare";

-- Reconstruct ticket_flights from row partitions (UNION (overlap))
CREATE VIEW "ticket_flights" AS
SELECT "local_3"."ticketFlightsListedAmounts"."ticketNumber" AS "ticket_no", "local_3"."ticketFlightsListedAmounts"."flightId" AS "flight_id", "local_3"."ticketFlightsListedAmounts"."fareCondition" AS "fare_conditions", "local_3"."ticketFlightsListedAmounts"."fareAmount" AS "amount" FROM "local_3"."ticketFlightsListedAmounts"
UNION
SELECT "local_3"."ticketFlightsOtherAmounts"."ticketNumber" AS "ticket_no", "local_3"."ticketFlightsOtherAmounts"."flightId" AS "flight_id", "local_3"."ticketFlightsOtherAmounts"."fareCondition" AS "fare_conditions", "local_3"."ticketFlightsOtherAmounts"."fareAmount" AS "amount" FROM "local_3"."ticketFlightsOtherAmounts";

-- Reconstruct tickets from local_3.bookingTickets
CREATE VIEW "tickets" AS
SELECT
    "local_3"."bookingTickets"."ticketNumber" AS "ticket_no",
    "local_3"."bookingTickets"."bookingReference" AS "book_ref",
    "local_3"."bookingTickets"."passengerIdentifier" AS "passenger_id"
FROM "local_3"."bookingTickets";
