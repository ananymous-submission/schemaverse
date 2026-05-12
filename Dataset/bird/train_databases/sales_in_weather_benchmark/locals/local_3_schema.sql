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