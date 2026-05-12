-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct relation from local_1.storeStationLink
CREATE VIEW "relation" AS
SELECT
    "local_1"."storeStationLink"."storeId" AS "store_nbr",
    "local_1"."storeStationLink"."stationId" AS "station_nbr"
FROM "local_1"."storeStationLink";

-- Reconstruct sales_in_weather from local_2.sls_wthr
CREATE VIEW "sales_in_weather" AS
SELECT
    "local_2"."sls_wthr"."sale_dt" AS "date",
    "local_2"."sls_wthr"."st_id" AS "store_nbr",
    "local_2"."sls_wthr"."itm_id" AS "item_nbr",
    "local_2"."sls_wthr"."qty_sold" AS "units"
FROM "local_2"."sls_wthr";

-- Reconstruct weather from vertical split + row partition on a fragment
CREATE VIEW "weather" AS
SELECT t0.[stationId], t0.[observationDate], t2.[maximum_temperature], t2.[minimum_temperature], t1.[avgTemperature], t1.[tempDeparture], t1.[dewPoint], t1.[wetBulbTemperature], t3.[heating_degree_days], t3.[cooling_degree_days], t4.[sunriseTime], t4.[sunsetTime], t1.[codeSummary], t1.[snowfallAmount], t1.[precipitationTotal], t1.[stationPressure], t1.[seaLevelPressure], t0.[resultSpeed], t0.[resultDirection], t0.[avgSpeed]
FROM (
SELECT [weatherAvgSpeedAbove10Point1OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[weatherAvgSpeedAbove10Point1OrNull].[stationId], [local_1].[weatherAvgSpeedAbove10Point1OrNull].[observationDate], [local_1].[weatherAvgSpeedAbove10Point1OrNull].[resultSpeed], [local_1].[weatherAvgSpeedAbove10Point1OrNull].[resultDirection], [local_1].[weatherAvgSpeedAbove10Point1OrNull].[avgSpeed] FROM [local_1].[weatherAvgSpeedAbove10Point1OrNull]
UNION
SELECT [weatherAvgSpeedAtMost5Point1].[__orig_rowid] AS __orig_rowid, [local_1].[weatherAvgSpeedAtMost5Point1].[stationId], [local_1].[weatherAvgSpeedAtMost5Point1].[observationDate], [local_1].[weatherAvgSpeedAtMost5Point1].[resultSpeed], [local_1].[weatherAvgSpeedAtMost5Point1].[resultDirection], [local_1].[weatherAvgSpeedAtMost5Point1].[avgSpeed] FROM [local_1].[weatherAvgSpeedAtMost5Point1]
UNION
SELECT [weatherAvgSpeedGreaterThan5Point1UpTo7Point3].[__orig_rowid] AS __orig_rowid, [local_1].[weatherAvgSpeedGreaterThan5Point1UpTo7Point3].[stationId], [local_1].[weatherAvgSpeedGreaterThan5Point1UpTo7Point3].[observationDate], [local_1].[weatherAvgSpeedGreaterThan5Point1UpTo7Point3].[resultSpeed], [local_1].[weatherAvgSpeedGreaterThan5Point1UpTo7Point3].[resultDirection], [local_1].[weatherAvgSpeedGreaterThan5Point1UpTo7Point3].[avgSpeed] FROM [local_1].[weatherAvgSpeedGreaterThan5Point1UpTo7Point3]
UNION
SELECT [weatherAvgSpeedGreaterThan7Point3UpTo10Point1].[__orig_rowid] AS __orig_rowid, [local_1].[weatherAvgSpeedGreaterThan7Point3UpTo10Point1].[stationId], [local_1].[weatherAvgSpeedGreaterThan7Point3UpTo10Point1].[observationDate], [local_1].[weatherAvgSpeedGreaterThan7Point3UpTo10Point1].[resultSpeed], [local_1].[weatherAvgSpeedGreaterThan7Point3UpTo10Point1].[resultDirection], [local_1].[weatherAvgSpeedGreaterThan7Point3UpTo10Point1].[avgSpeed] FROM [local_1].[weatherAvgSpeedGreaterThan7Point3UpTo10Point1]
) t0
JOIN [local_1].[weatherConditionSummary] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_3].[station_daily_weather_summary] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_3].[station_degree_day_totals] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_1].[weatherSunTimes] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];
