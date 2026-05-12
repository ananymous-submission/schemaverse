CREATE TABLE "trips_bikeid_up_to_334" (
    "trip_id" INTEGER,
    "bike_identifier" INTEGER,
    "trip_duration" INTEGER,
    "destination_station_id" INTEGER,
    "destination_station_name" TEXT,
    "origin_station_id" INTEGER,
    "origin_station_name" TEXT,
    "membership_type" TEXT,
    "postal_code" INTEGER
);

CREATE TABLE "trips_bikeid_335_to_441" (
    "trip_id" INTEGER,
    "bike_identifier" INTEGER,
    "trip_duration" INTEGER,
    "destination_station_id" INTEGER,
    "destination_station_name" TEXT,
    "origin_station_id" INTEGER,
    "origin_station_name" TEXT,
    "membership_type" TEXT,
    "postal_code" INTEGER
);

CREATE TABLE "trips_bikeid_442_to_546" (
    "trip_id" INTEGER,
    "bike_identifier" INTEGER,
    "trip_duration" INTEGER,
    "destination_station_id" INTEGER,
    "destination_station_name" TEXT,
    "origin_station_id" INTEGER,
    "origin_station_name" TEXT,
    "membership_type" TEXT,
    "postal_code" INTEGER
);

CREATE TABLE "trips_bikeid_above_546_or_null" (
    "trip_id" INTEGER,
    "bike_identifier" INTEGER,
    "trip_duration" INTEGER,
    "destination_station_id" INTEGER,
    "destination_station_name" TEXT,
    "origin_station_id" INTEGER,
    "origin_station_name" TEXT,
    "membership_type" TEXT,
    "postal_code" INTEGER
);

CREATE TABLE "trips_no_station_info" (
    "trip_id" INTEGER,
    "bike_identifier" INTEGER,
    "trip_duration" INTEGER,
    "end_time" TEXT,
    "start_time" TEXT,
    "membership_type" TEXT,
    "postal_code" INTEGER
);