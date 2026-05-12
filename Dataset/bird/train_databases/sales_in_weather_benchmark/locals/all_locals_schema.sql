-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/sales_in_weather/sales_in_weather.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "storeStationLink" (
    "storeId" INTEGER,
    "stationId" INTEGER,
    FOREIGN KEY ("stationId") REFERENCES "weatherSunTimes"("stationId"),
    FOREIGN KEY ("stationId") REFERENCES "weatherAvgSpeedAtMost5Point1"("stationId"),
    FOREIGN KEY ("stationId") REFERENCES "weatherAvgSpeedGreaterThan5Point1UpTo7Point3"("stationId")
);

CREATE TABLE "weatherConditionSummary" (
    "stationId" INTEGER,
    "observationDate" DATE,
    "codeSummary" TEXT,
    "tempDeparture" INTEGER,
    "dewPoint" INTEGER,
    "precipitationTotal" REAL,
    "seaLevelPressure" REAL,
    "snowfallAmount" REAL,
    "stationPressure" REAL,
    "avgTemperature" INTEGER,
    "wetBulbTemperature" INTEGER
);

CREATE TABLE "weatherSunTimes" (
    "stationId" INTEGER,
    "observationDate" DATE,
    "sunriseTime" TEXT,
    "sunsetTime" TEXT
);

CREATE TABLE "weatherAvgSpeedAtMost5Point1" (
    "stationId" INTEGER,
    "observationDate" DATE,
    "avgSpeed" REAL,
    "resultDirection" INTEGER,
    "resultSpeed" REAL
);

CREATE TABLE "weatherAvgSpeedGreaterThan5Point1UpTo7Point3" (
    "stationId" INTEGER,
    "observationDate" DATE,
    "avgSpeed" REAL,
    "resultDirection" INTEGER,
    "resultSpeed" REAL
);

CREATE TABLE "weatherAvgSpeedGreaterThan7Point3UpTo10Point1" (
    "stationId" INTEGER,
    "observationDate" DATE,
    "avgSpeed" REAL,
    "resultDirection" INTEGER,
    "resultSpeed" REAL
);

CREATE TABLE "weatherAvgSpeedAbove10Point1OrNull" (
    "stationId" INTEGER,
    "observationDate" DATE,
    "avgSpeed" REAL,
    "resultDirection" INTEGER,
    "resultSpeed" REAL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "sls_wthr" (
    "sale_dt" DATE,
    "st_id" INTEGER,
    "itm_id" INTEGER,
    "qty_sold" INTEGER
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "station_degree_day_totals" (
    "station_id" INTEGER,
    "observation_date" DATE,
    "cooling_degree_days" INTEGER,
    "heating_degree_days" INTEGER
);

CREATE TABLE "station_daily_weather_summary" (
    "station_id" INTEGER,
    "observation_date" DATE,
    "condition_summary" TEXT,
    "temp_deviation" INTEGER,
    "dew_point" INTEGER,
    "precipitation_total" REAL,
    "sea_level_pressure" REAL,
    "snowfall_amount" REAL,
    "average_temperature" INTEGER,
    "maximum_temperature" INTEGER,
    "minimum_temperature" INTEGER,
    "wet_bulb_temperature" INTEGER
);

