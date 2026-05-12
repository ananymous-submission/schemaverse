-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct station from vertical split + row partition on a fragment
CREATE VIEW "station" AS
SELECT t0.[stationId], t0.[stationName], t1.[latitude], t1.[longitude], t0.[dockCapacity], t0.[cityName], t0.[installationDate]
FROM (
SELECT [stationCityInstalledAug15AndAug21].[__orig_rowid] AS __orig_rowid, [local_1].[stationCityInstalledAug15AndAug21].[stationId], [local_1].[stationCityInstalledAug15AndAug21].[stationName], [local_1].[stationCityInstalledAug15AndAug21].[dockCapacity], [local_1].[stationCityInstalledAug15AndAug21].[cityName], [local_1].[stationCityInstalledAug15AndAug21].[installationDate] FROM [local_1].[stationCityInstalledAug15AndAug21]
UNION
SELECT [stationCityInstalledAug19AndAug20].[__orig_rowid] AS __orig_rowid, [local_1].[stationCityInstalledAug19AndAug20].[stationId], [local_1].[stationCityInstalledAug19AndAug20].[stationName], [local_1].[stationCityInstalledAug19AndAug20].[dockCapacity], [local_1].[stationCityInstalledAug19AndAug20].[cityName], [local_1].[stationCityInstalledAug19AndAug20].[installationDate] FROM [local_1].[stationCityInstalledAug19AndAug20]
UNION
SELECT [stationCityInstalledAug22AndAug25].[__orig_rowid] AS __orig_rowid, [local_1].[stationCityInstalledAug22AndAug25].[stationId], [local_1].[stationCityInstalledAug22AndAug25].[stationName], [local_1].[stationCityInstalledAug22AndAug25].[dockCapacity], [local_1].[stationCityInstalledAug22AndAug25].[cityName], [local_1].[stationCityInstalledAug22AndAug25].[installationDate] FROM [local_1].[stationCityInstalledAug22AndAug25]
UNION
SELECT [stationCityInstalledAug232013].[__orig_rowid] AS __orig_rowid, [local_1].[stationCityInstalledAug232013].[stationId], [local_1].[stationCityInstalledAug232013].[stationName], [local_1].[stationCityInstalledAug232013].[dockCapacity], [local_1].[stationCityInstalledAug232013].[cityName], [local_1].[stationCityInstalledAug232013].[installationDate] FROM [local_1].[stationCityInstalledAug232013]
UNION
SELECT [stationCityInstalledAug5AndAug6].[__orig_rowid] AS __orig_rowid, [local_1].[stationCityInstalledAug5AndAug6].[stationId], [local_1].[stationCityInstalledAug5AndAug6].[stationName], [local_1].[stationCityInstalledAug5AndAug6].[dockCapacity], [local_1].[stationCityInstalledAug5AndAug6].[cityName], [local_1].[stationCityInstalledAug5AndAug6].[installationDate] FROM [local_1].[stationCityInstalledAug5AndAug6]
UNION
SELECT [stationCityInstalledOther].[__orig_rowid] AS __orig_rowid, [local_1].[stationCityInstalledOther].[stationId], [local_1].[stationCityInstalledOther].[stationName], [local_1].[stationCityInstalledOther].[dockCapacity], [local_1].[stationCityInstalledOther].[cityName], [local_1].[stationCityInstalledOther].[installationDate] FROM [local_1].[stationCityInstalledOther]
) t0
JOIN [local_1].[stationDockInventory] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct status from local_1.realtimeStationStatus
CREATE VIEW "status" AS
SELECT
    "local_1"."realtimeStationStatus"."stationRefId" AS "station_id",
    "local_1"."realtimeStationStatus"."availableBikes" AS "bikes_available",
    "local_1"."realtimeStationStatus"."availableDocks" AS "docks_available",
    "local_1"."realtimeStationStatus"."observedAt" AS "time"
FROM "local_1"."realtimeStationStatus";

-- Reconstruct trip from vertical split + row partition on a fragment
CREATE VIEW "trip" AS
SELECT t0.[trip_id], t0.[trip_duration], t1.[start_time], t0.[origin_station_name], t0.[origin_station_id], t1.[end_time], t0.[destination_station_name], t0.[destination_station_id], t0.[bike_identifier], t0.[membership_type], t0.[postal_code]
FROM (
SELECT [trips_bikeid_335_to_441].[__orig_rowid] AS __orig_rowid, [local_2].[trips_bikeid_335_to_441].[trip_id], [local_2].[trips_bikeid_335_to_441].[trip_duration], [local_2].[trips_bikeid_335_to_441].[origin_station_name], [local_2].[trips_bikeid_335_to_441].[origin_station_id], [local_2].[trips_bikeid_335_to_441].[destination_station_name], [local_2].[trips_bikeid_335_to_441].[destination_station_id], [local_2].[trips_bikeid_335_to_441].[bike_identifier], [local_2].[trips_bikeid_335_to_441].[membership_type], [local_2].[trips_bikeid_335_to_441].[postal_code] FROM [local_2].[trips_bikeid_335_to_441]
UNION
SELECT [trips_bikeid_442_to_546].[__orig_rowid] AS __orig_rowid, [local_2].[trips_bikeid_442_to_546].[trip_id], [local_2].[trips_bikeid_442_to_546].[trip_duration], [local_2].[trips_bikeid_442_to_546].[origin_station_name], [local_2].[trips_bikeid_442_to_546].[origin_station_id], [local_2].[trips_bikeid_442_to_546].[destination_station_name], [local_2].[trips_bikeid_442_to_546].[destination_station_id], [local_2].[trips_bikeid_442_to_546].[bike_identifier], [local_2].[trips_bikeid_442_to_546].[membership_type], [local_2].[trips_bikeid_442_to_546].[postal_code] FROM [local_2].[trips_bikeid_442_to_546]
UNION
SELECT [trips_bikeid_above_546_or_null].[__orig_rowid] AS __orig_rowid, [local_2].[trips_bikeid_above_546_or_null].[trip_id], [local_2].[trips_bikeid_above_546_or_null].[trip_duration], [local_2].[trips_bikeid_above_546_or_null].[origin_station_name], [local_2].[trips_bikeid_above_546_or_null].[origin_station_id], [local_2].[trips_bikeid_above_546_or_null].[destination_station_name], [local_2].[trips_bikeid_above_546_or_null].[destination_station_id], [local_2].[trips_bikeid_above_546_or_null].[bike_identifier], [local_2].[trips_bikeid_above_546_or_null].[membership_type], [local_2].[trips_bikeid_above_546_or_null].[postal_code] FROM [local_2].[trips_bikeid_above_546_or_null]
UNION
SELECT [trips_bikeid_up_to_334].[__orig_rowid] AS __orig_rowid, [local_2].[trips_bikeid_up_to_334].[trip_id], [local_2].[trips_bikeid_up_to_334].[trip_duration], [local_2].[trips_bikeid_up_to_334].[origin_station_name], [local_2].[trips_bikeid_up_to_334].[origin_station_id], [local_2].[trips_bikeid_up_to_334].[destination_station_name], [local_2].[trips_bikeid_up_to_334].[destination_station_id], [local_2].[trips_bikeid_up_to_334].[bike_identifier], [local_2].[trips_bikeid_up_to_334].[membership_type], [local_2].[trips_bikeid_up_to_334].[postal_code] FROM [local_2].[trips_bikeid_up_to_334]
) t0
JOIN [local_2].[trips_no_station_info] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct weather from local_3.DailyWeatherObservation
CREATE VIEW "weather" AS
SELECT
    "local_3"."DailyWeatherObservation"."ObservationDate" AS "date",
    "local_3"."DailyWeatherObservation"."MaxTemperatureFahrenheit" AS "max_temperature_f",
    "local_3"."DailyWeatherObservation"."AverageTemperatureFahrenheit" AS "mean_temperature_f",
    "local_3"."DailyWeatherObservation"."MinTemperatureFahrenheit" AS "min_temperature_f",
    "local_3"."DailyWeatherObservation"."MaxDewPointFahrenheit" AS "max_dew_point_f",
    "local_3"."DailyWeatherObservation"."AverageDewPointFahrenheit" AS "mean_dew_point_f",
    "local_3"."DailyWeatherObservation"."MinDewPointFahrenheit" AS "min_dew_point_f",
    "local_3"."DailyWeatherObservation"."MaxHumidityPercent" AS "max_humidity",
    "local_3"."DailyWeatherObservation"."AverageHumidityPercent" AS "mean_humidity",
    "local_3"."DailyWeatherObservation"."MinHumidityPercent" AS "min_humidity",
    "local_3"."DailyWeatherObservation"."MaxSeaLevelPressureInches" AS "max_sea_level_pressure_inches",
    "local_3"."DailyWeatherObservation"."AverageSeaLevelPressureInches" AS "mean_sea_level_pressure_inches",
    "local_3"."DailyWeatherObservation"."MinSeaLevelPressureInches" AS "min_sea_level_pressure_inches",
    "local_3"."DailyWeatherObservation"."MaxVisibilityMiles" AS "max_visibility_miles",
    "local_3"."DailyWeatherObservation"."AverageVisibilityMiles" AS "mean_visibility_miles",
    "local_3"."DailyWeatherObservation"."MinVisibilityMiles" AS "min_visibility_miles",
    "local_3"."DailyWeatherObservation"."PeakWindSpeedMph" AS "max_wind_Speed_mph",
    "local_3"."DailyWeatherObservation"."AverageWindSpeedMph" AS "mean_wind_speed_mph",
    "local_3"."DailyWeatherObservation"."PeakGustSpeedMph" AS "max_gust_speed_mph",
    "local_3"."DailyWeatherObservation"."PrecipitationInchesText" AS "precipitation_inches",
    "local_3"."DailyWeatherObservation"."CloudCoverPercent" AS "cloud_cover",
    "local_3"."DailyWeatherObservation"."WeatherEvents" AS "events",
    "local_3"."DailyWeatherObservation"."WindDirectionDegrees" AS "wind_dir_degrees",
    "local_3"."DailyWeatherObservation"."PostalCode" AS "zip_code"
FROM "local_3"."DailyWeatherObservation";
