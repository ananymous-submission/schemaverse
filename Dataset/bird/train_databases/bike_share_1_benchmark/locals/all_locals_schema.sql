-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/bike_share_1/bike_share_1.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "stationCityInstalledAug232013" (
    "stationId" INTEGER,
    "cityName" TEXT,
    "dockCapacity" INTEGER,
    "installationDate" TEXT,
    "stationName" TEXT
);

CREATE TABLE "stationCityInstalledAug19AndAug20" (
    "stationId" INTEGER,
    "cityName" TEXT,
    "dockCapacity" INTEGER,
    "installationDate" TEXT,
    "stationName" TEXT
);

CREATE TABLE "stationCityInstalledAug15AndAug21" (
    "stationId" INTEGER,
    "cityName" TEXT,
    "dockCapacity" INTEGER,
    "installationDate" TEXT,
    "stationName" TEXT
);

CREATE TABLE "stationCityInstalledAug22AndAug25" (
    "stationId" INTEGER,
    "cityName" TEXT,
    "dockCapacity" INTEGER,
    "installationDate" TEXT,
    "stationName" TEXT
);

CREATE TABLE "stationCityInstalledAug5AndAug6" (
    "stationId" INTEGER,
    "cityName" TEXT,
    "dockCapacity" INTEGER,
    "installationDate" TEXT,
    "stationName" TEXT
);

CREATE TABLE "stationCityInstalledOther" (
    "stationId" INTEGER,
    "cityName" TEXT,
    "dockCapacity" INTEGER,
    "installationDate" TEXT,
    "stationName" TEXT
);

CREATE TABLE "stationDockInventory" (
    "stationId" INTEGER,
    "dockCapacity" INTEGER,
    "installationDate" TEXT,
    "latitude" REAL,
    "longitude" REAL,
    "stationName" TEXT
);

CREATE TABLE "realtimeStationStatus" (
    "stationRefId" INTEGER,
    "availableBikes" INTEGER,
    "availableDocks" INTEGER,
    "observedAt" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "DailyWeatherObservation" (
    "ObservationDate" TEXT,
    "MaxTemperatureFahrenheit" INTEGER,
    "AverageTemperatureFahrenheit" INTEGER,
    "MinTemperatureFahrenheit" INTEGER,
    "MaxDewPointFahrenheit" INTEGER,
    "AverageDewPointFahrenheit" INTEGER,
    "MinDewPointFahrenheit" INTEGER,
    "MaxHumidityPercent" INTEGER,
    "AverageHumidityPercent" INTEGER,
    "MinHumidityPercent" INTEGER,
    "MaxSeaLevelPressureInches" REAL,
    "AverageSeaLevelPressureInches" REAL,
    "MinSeaLevelPressureInches" REAL,
    "MaxVisibilityMiles" INTEGER,
    "AverageVisibilityMiles" INTEGER,
    "MinVisibilityMiles" INTEGER,
    "PeakWindSpeedMph" INTEGER,
    "AverageWindSpeedMph" INTEGER,
    "PeakGustSpeedMph" INTEGER,
    "PrecipitationInchesText" TEXT,
    "CloudCoverPercent" INTEGER,
    "WeatherEvents" TEXT,
    "WindDirectionDegrees" INTEGER,
    "PostalCode" TEXT
);

