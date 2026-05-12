CREATE TABLE "circuits" (
  "circuit_id" INT(11) NOT NULL,
  "circuit_ref" VARCHAR(255) NOT NULL DEFAULT '',
  "name" VARCHAR(255) NOT NULL DEFAULT '',
  "location" VARCHAR(255) DEFAULT NULL,
  "country" VARCHAR(255) DEFAULT NULL,
  "lat" FLOAT DEFAULT NULL,
  "lng" FLOAT DEFAULT NULL,
  "alt" INT(11) DEFAULT NULL,
  "url" VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("circuit_id")
);

CREATE TABLE circuits_ext(
  circuit_id INT,
  circuit_ref TEXT,
  name TEXT,
  location TEXT,
  country TEXT,
  lat REAL,
  lng REAL,
  alt INT,
  url TEXT,
  last_race_year,
  number_of_races
);

CREATE TABLE "constructor_results" (
  "constructor_results_id" INT(11) NOT NULL,
  "race_id" INT(11) NOT NULL DEFAULT '0',
  "constructor_id" INT(11) NOT NULL DEFAULT '0',
  "points" FLOAT DEFAULT NULL,
  "status" VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY ("constructor_results_id")
);

CREATE TABLE "constructor_standings" (
  "constructor_standings_id" INT(11) NOT NULL,
  "race_id" INT(11) NOT NULL DEFAULT '0',
  "constructor_id" INT(11) NOT NULL DEFAULT '0',
  "points" FLOAT NOT NULL DEFAULT '0',
  "position" INT(11) DEFAULT NULL,
  "position_text" VARCHAR(255) DEFAULT NULL,
  "wins" INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY ("constructor_standings_id")
);

CREATE TABLE "constructors" (
  "constructor_id" INT(11) NOT NULL,
  "constructor_ref" VARCHAR(255) NOT NULL DEFAULT '',
  "name" VARCHAR(255) NOT NULL DEFAULT '',
  "nationality" VARCHAR(255) DEFAULT NULL,
  "url" VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("constructor_id")
);

CREATE TABLE constructors_ext(
  constructor_id INT,
  constructor_ref TEXT,
  name TEXT,
  nationality TEXT,
  url TEXT,
  short_name
);

CREATE TABLE "driver_standings" (
  "driver_standings_id" INT(11) NOT NULL,
  "race_id" INT(11) NOT NULL DEFAULT '0',
  "driver_id" INT(11) NOT NULL DEFAULT '0',
  "points" FLOAT NOT NULL DEFAULT '0',
  "position" INT(11) DEFAULT NULL,
  "position_text" VARCHAR(255) DEFAULT NULL,
  "wins" INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY ("driver_standings_id")
);

CREATE TABLE driver_standings_ext(
  driver_standings_id INT,
  race_id INT,
  driver_id INT,
  points REAL,
  position INT,
  position_text TEXT,
  wins INT
);

CREATE TABLE "drivers" (
  "driver_id" INT(11) NOT NULL,
  "driver_ref" VARCHAR(255) NOT NULL DEFAULT '',
  "number" INT(11) DEFAULT NULL,
  "code" VARCHAR(3) DEFAULT NULL,
  "forename" VARCHAR(255) NOT NULL DEFAULT '',
  "surname" VARCHAR(255) NOT NULL DEFAULT '',
  "full_name" VARCHAR(255) AS (forename || ' ' || surname) VIRTUAL,
  "dob" DATE DEFAULT NULL,
  "nationality" VARCHAR(255) DEFAULT NULL,
  "url" VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("driver_id")
);

CREATE TABLE drivers_ext(
  driver_id INT,
  driver_ref TEXT,
  number INT,
  code,
  forename TEXT,
  surname TEXT,
  full_name TEXT,
  dob NUM,
  nationality TEXT,
  url TEXT
);

CREATE TABLE drives(
  year INT,
  driver_id INT,
  drive_id,
  constructor_id INT,
  first_round INT,
  last_round INT,
  is_first_drive_of_season,
  is_final_drive_of_season
);

CREATE TABLE lap_positions(
  race_id INT,
  driver_id INT,
  lap INT,
  position INT,
  lap_type
);

CREATE TABLE lap_time_stats(
  race_id INT,
  driver_id INT,
  avg_milliseconds,
  avg_seconds,
  stdev_milliseconds,
  stdev_seconds
);

CREATE TABLE "lap_times" (
  "race_id" INT(11) NOT NULL,
  "driver_id" INT(11) NOT NULL,
  "lap" INT(11) NOT NULL,
  "position" INT(11) DEFAULT NULL,
  "time" VARCHAR(255) DEFAULT NULL,
  "milliseconds" INT(11) DEFAULT NULL,
  "seconds" FLOAT AS (CAST(milliseconds AS FLOAT) / 1000) VIRTUAL,
  PRIMARY KEY ("race_id", "driver_id", "lap")
);

CREATE TABLE lap_times_ext(
  race_id INT,
  driver_id INT,
  lap INT,
  position INT,
  time TEXT,
  milliseconds INT,
  seconds REAL,
  running_milliseconds
);

CREATE TABLE "liveries" (
  "constructor_ref" VARCHAR(255) NOT NULL DEFAULT '',
  "start_year" INT(11) NOT NULL DEFAULT '0',
  "end_year" INT(11) NULL DEFAULT '0',
  "primary_hex_code" VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("constructor_ref", "start_year", "end_year")
);

CREATE TABLE "pit_stops" (
  "race_id" INT(11) NOT NULL,
  "driver_id" INT(11) NOT NULL,
  "stop" INT(11) NOT NULL,
  "lap" INT(11) NOT NULL,
  "time" TIME NOT NULL,
  "duration" VARCHAR(255) DEFAULT NULL,
  "milliseconds" INT(11) DEFAULT NULL,
  "seconds" FLOAT AS (CAST(milliseconds AS FLOAT) / 1000) VIRTUAL,
  PRIMARY KEY ("race_id", "driver_id", "stop")
);

CREATE TABLE "qualifying" (
  "qualify_id" INT(11) NOT NULL,
  "race_id" INT(11) NOT NULL DEFAULT '0',
  "driver_id" INT(11) NOT NULL DEFAULT '0',
  "constructor_id" INT(11) NOT NULL DEFAULT '0',
  "number" INT(11) NOT NULL DEFAULT '0',
  "position" INT(11) DEFAULT NULL,
  "q1" VARCHAR(255) DEFAULT NULL,
  "q2" VARCHAR(255) DEFAULT NULL,
  "q3" VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY ("qualify_id")
);

CREATE TABLE "races" (
  "race_id" INT(11) NOT NULL,
  "year" INT(11) NOT NULL DEFAULT '0',
  "round" INT(11) NOT NULL DEFAULT '0',
  "circuit_id" INT(11) NOT NULL DEFAULT '0',
  "name" VARCHAR(255) NOT NULL DEFAULT '',
  "date" DATE NOT NULL,
  "time" TIME DEFAULT NULL,
  "url" VARCHAR(255) DEFAULT NULL,
  "fp1_date" VARCHAR(255) DEFAULT NULL,
  "fp1_time" VARCHAR(255) DEFAULT NULL,
  "fp2_date" VARCHAR(255) DEFAULT NULL,
  "fp2_time" VARCHAR(255) DEFAULT NULL,
  "fp3_date" VARCHAR(255) DEFAULT NULL,
  "fp3_time" VARCHAR(255) DEFAULT NULL,
  "quali_date" VARCHAR(255) DEFAULT NULL,
  "quali_time" VARCHAR(255) DEFAULT NULL,
  "sprint_date" VARCHAR(255) DEFAULT NULL,
  "sprint_time" VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY ("race_id")
);

CREATE TABLE races_ext(
  race_id INT,
  year INT,
  round INT,
  circuit_id INT,
  name TEXT,
  date NUM,
  time NUM,
  url TEXT,
  fp1_date TEXT,
  fp1_time TEXT,
  fp2_date TEXT,
  fp2_time TEXT,
  fp3_date TEXT,
  fp3_time TEXT,
  quali_date TEXT,
  quali_time TEXT,
  sprint_date TEXT,
  sprint_time TEXT,
  is_pit_data_available,
  short_name,
  has_sprint,
  max_points
);

CREATE TABLE "results" (
  "result_id" INT(11) NOT NULL,
  "race_id" INT(11) NOT NULL DEFAULT '0',
  "driver_id" INT(11) NOT NULL DEFAULT '0',
  "constructor_id" INT(11) NOT NULL DEFAULT '0',
  "number" INT(11) DEFAULT NULL,
  "grid" INT(11) NOT NULL DEFAULT '0',
  "position" INT(11) DEFAULT NULL,
  "position_text" VARCHAR(255) NOT NULL DEFAULT '',
  "position_order" INT(11) NOT NULL DEFAULT '0',
  "points" FLOAT NOT NULL DEFAULT '0',
  "laps" INT(11) NOT NULL DEFAULT '0',
  "time" VARCHAR(255) DEFAULT NULL,
  "milliseconds" INT(11) DEFAULT NULL,
  "fastest_lap" INT(11) DEFAULT NULL,
  "rank" INT(11) DEFAULT '0',
  "fastest_lap_time" VARCHAR(255) DEFAULT NULL,
  "fastest_lap_speed" VARCHAR(255) DEFAULT NULL,
  "status_id" INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY ("result_id")
);

CREATE TABLE retirements(
  race_id INT,
  driver_id INT,
  lap,
  position_order INT,
  status_id INT,
  retirement_type
);

CREATE TABLE "seasons" (
  "year" INT(11) NOT NULL DEFAULT '0',
  "url" VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("year")
);

CREATE TABLE "short_constructor_names" (
  "constructor_ref" VARCHAR(255) NOT NULL DEFAULT '',
  "short_name" VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("constructor_ref")
);

CREATE TABLE "short_grand_prix_names" (
  "full_name" VARCHAR(255) NOT NULL DEFAULT '',
  "short_name" VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("full_name")
);

CREATE TABLE "sprint_results" (
  "result_id" INT(11) NOT NULL,
  "race_id" INT(11) NOT NULL DEFAULT '0',
  "driver_id" INT(11) NOT NULL DEFAULT '0',
  "constructor_id" INT(11) NOT NULL DEFAULT '0',
  "number" INT(11) DEFAULT NULL,
  "grid" INT(11) NOT NULL DEFAULT '0',
  "position" INT(11) DEFAULT NULL,
  "position_text" VARCHAR(255) NOT NULL DEFAULT '',
  "position_order" INT(11) NOT NULL DEFAULT '0',
  "points" FLOAT NOT NULL DEFAULT '0',
  "laps" INT(11) NOT NULL DEFAULT '0',
  "time" VARCHAR(255) DEFAULT NULL,
  "milliseconds" INT(11) DEFAULT NULL,
  "fastest_lap" INT(11) DEFAULT NULL,
  "fastest_lap_time" VARCHAR(255) DEFAULT NULL,
  "fastest_lap_speed" VARCHAR(255) DEFAULT NULL,
  "status_id" INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY ("result_id")
);

CREATE TABLE "status" (
  "status_id" INT(11) NOT NULL,
  "status" VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("status_id")
);

CREATE TABLE "tdr_overrides" (
  "year" INT(11) NOT NULL DEFAULT '0',
  "constructor_ref" VARCHAR(255) NOT NULL DEFAULT '',
  "driver_ref" VARCHAR(255) NOT NULL DEFAULT '',
  "team_driver_rank" INT(11) NULL DEFAULT '0',
  PRIMARY KEY ("year", "constructor_ref", "driver_ref")
);

CREATE TABLE team_driver_ranks(
  year INT,
  constructor_id INT,
  constructor_ref TEXT,
  driver_id INT,
  driver_ref TEXT,
  team_driver_rank
);