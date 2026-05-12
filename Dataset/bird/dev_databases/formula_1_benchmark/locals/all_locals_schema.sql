-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/dev_databases/formula_1/formula_1.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "circuitsUsUkItaly" (
    "circuitIdPk" INTEGER,
    "circuitReference" TEXT NOT NULL DEFAULT '',
    "displayName" TEXT NOT NULL DEFAULT '',
    "locality" TEXT,
    "countryName" TEXT,
    "latitude" REAL,
    "longitude" REAL,
    "elevationMeters" INTEGER,
    "sourceUrl" TEXT NOT NULL DEFAULT ''
);

CREATE TABLE "circuitsFranceCanadaGermany" (
    "circuitIdPk" INTEGER,
    "circuitReference" TEXT NOT NULL DEFAULT '',
    "displayName" TEXT NOT NULL DEFAULT '',
    "locality" TEXT,
    "countryName" TEXT,
    "latitude" REAL,
    "longitude" REAL,
    "elevationMeters" INTEGER,
    "sourceUrl" TEXT NOT NULL DEFAULT ''
);

CREATE TABLE "circuitsSpainAustriaBelgium" (
    "circuitIdPk" INTEGER,
    "circuitReference" TEXT NOT NULL DEFAULT '',
    "displayName" TEXT NOT NULL DEFAULT '',
    "locality" TEXT,
    "countryName" TEXT,
    "latitude" REAL,
    "longitude" REAL,
    "elevationMeters" INTEGER,
    "sourceUrl" TEXT NOT NULL DEFAULT ''
);

CREATE TABLE "circuitsOtherCountries" (
    "circuitIdPk" INTEGER,
    "circuitReference" TEXT NOT NULL DEFAULT '',
    "displayName" TEXT NOT NULL DEFAULT '',
    "locality" TEXT,
    "countryName" TEXT,
    "latitude" REAL,
    "longitude" REAL,
    "elevationMeters" INTEGER,
    "sourceUrl" TEXT NOT NULL DEFAULT ''
);

CREATE TABLE "pitStopsDurationLapUpTo13" (
    "raceIdFk" INTEGER,
    "driverIdFk" INTEGER,
    "stopSequence" INTEGER,
    "durationText" TEXT,
    "lapNumber" INTEGER NOT NULL,
    "durationMilliseconds" INTEGER,
    "stopTime" TEXT NOT NULL,
    FOREIGN KEY ("raceIdFk") REFERENCES "racesBritishAndMonaco"("raceIdPk")
);

CREATE TABLE "pitStopsLapRecords" (
    "raceIdFk" INTEGER,
    "driverIdFk" INTEGER,
    "stopSequence" INTEGER,
    "lapNumber" INTEGER NOT NULL,
    "stopTime" TEXT NOT NULL,
    FOREIGN KEY ("raceIdFk") REFERENCES "racesBritishAndMonaco"("raceIdPk")
);

CREATE TABLE "racesBritishAndMonaco" (
    "raceIdPk" INTEGER,
    "seasonYear" INTEGER NOT NULL DEFAULT 0,
    "roundNumber" INTEGER NOT NULL DEFAULT 0,
    "circuitIdFk" INTEGER NOT NULL DEFAULT 0,
    "raceName" TEXT NOT NULL DEFAULT '',
    "raceDate" DATE NOT NULL DEFAULT '0000-00-00',
    "raceTime" TEXT,
    "referenceUrl" TEXT,
    FOREIGN KEY ("circuitIdFk") REFERENCES "circuitsSpainAustriaBelgium"("circuitIdPk"),
    FOREIGN KEY ("circuitIdFk") REFERENCES "circuitsOtherCountries"("circuitIdPk")
);

CREATE TABLE "racesOtherEvents" (
    "raceIdPk" INTEGER,
    "seasonYear" INTEGER NOT NULL DEFAULT 0,
    "roundNumber" INTEGER NOT NULL DEFAULT 0,
    "circuitIdFk" INTEGER NOT NULL DEFAULT 0,
    "raceName" TEXT NOT NULL DEFAULT '',
    "raceDate" DATE NOT NULL DEFAULT '0000-00-00',
    "raceTime" TEXT,
    "referenceUrl" TEXT,
    FOREIGN KEY ("circuitIdFk") REFERENCES "circuitsOtherCountries"("circuitIdPk")
);

CREATE TABLE "seasonsArchive" (
    "seasonYear" INTEGER DEFAULT 0,
    "seasonUrl" TEXT NOT NULL DEFAULT ''
);

CREATE TABLE "resultsFastestLapGridTopFive" (
    "resultIdPk" INTEGER,
    "fastestLapTimeStr" TEXT,
    "startingGrid" INTEGER NOT NULL DEFAULT 0,
    "lapsCompleted" INTEGER NOT NULL DEFAULT 0,
    "fastestLapMilliseconds" INTEGER,
    "carNumber" INTEGER,
    "pointsScored" REAL NOT NULL DEFAULT 0,
    "positionRank" INTEGER NOT NULL DEFAULT 0,
    "raceTime" TEXT
);

CREATE TABLE "resultsFastestLapGrid6To11" (
    "resultIdPk" INTEGER,
    "fastestLapTimeStr" TEXT,
    "startingGrid" INTEGER NOT NULL DEFAULT 0,
    "lapsCompleted" INTEGER NOT NULL DEFAULT 0,
    "fastestLapMilliseconds" INTEGER,
    "carNumber" INTEGER,
    "pointsScored" REAL NOT NULL DEFAULT 0,
    "positionRank" INTEGER NOT NULL DEFAULT 0,
    "raceTime" TEXT
);

CREATE TABLE "resultsFastestLapGrid12To17" (
    "resultIdPk" INTEGER,
    "fastestLapTimeStr" TEXT,
    "startingGrid" INTEGER NOT NULL DEFAULT 0,
    "lapsCompleted" INTEGER NOT NULL DEFAULT 0,
    "fastestLapMilliseconds" INTEGER,
    "carNumber" INTEGER,
    "pointsScored" REAL NOT NULL DEFAULT 0,
    "positionRank" INTEGER NOT NULL DEFAULT 0,
    "raceTime" TEXT
);

CREATE TABLE "resultsFastestLapGrid18AndAboveOrNull" (
    "resultIdPk" INTEGER,
    "fastestLapTimeStr" TEXT,
    "startingGrid" INTEGER NOT NULL DEFAULT 0,
    "lapsCompleted" INTEGER NOT NULL DEFAULT 0,
    "fastestLapMilliseconds" INTEGER,
    "carNumber" INTEGER,
    "pointsScored" REAL NOT NULL DEFAULT 0,
    "positionRank" INTEGER NOT NULL DEFAULT 0,
    "raceTime" TEXT
);

CREATE TABLE "lapTimesMs82399To90717" (
    "raceIdFk" INTEGER,
    "driverIdFk" INTEGER,
    "lapNumber" INTEGER,
    "positionNumber" INTEGER,
    "lapTime" TEXT,
    "lapMilliseconds" INTEGER
);

CREATE TABLE "lapTimesMs90718To102756" (
    "raceIdFk" INTEGER,
    "driverIdFk" INTEGER,
    "lapNumber" INTEGER,
    "positionNumber" INTEGER,
    "lapTime" TEXT,
    "lapMilliseconds" INTEGER
);

CREATE TABLE "constructorResultsPointsPositiveToFour" (
    "constructorResultIdPk" INTEGER,
    "raceIdFk" INTEGER NOT NULL DEFAULT 0,
    "constructorIdFk" INTEGER NOT NULL DEFAULT 0,
    "pointsScored" REAL,
    "statusDescription" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "constructor_results_nonpositive_points" (
    "constructor_result_id" INTEGER,
    "race_id" INTEGER NOT NULL DEFAULT 0,
    "constructor_team_id" INTEGER NOT NULL DEFAULT 0,
    "points_total" REAL,
    "result_status" TEXT,
    FOREIGN KEY ("constructor_team_id") REFERENCES "constructor_teams"("constructor_team_id")
);

CREATE TABLE "constructor_results_high_points" (
    "constructor_result_id" INTEGER,
    "race_id" INTEGER NOT NULL DEFAULT 0,
    "constructor_team_id" INTEGER NOT NULL DEFAULT 0,
    "points_total" REAL,
    "result_status" TEXT,
    FOREIGN KEY ("constructor_team_id") REFERENCES "constructor_teams"("constructor_team_id")
);

CREATE TABLE "constructor_teams" (
    "constructor_team_id" INTEGER,
    "reference_code" TEXT NOT NULL DEFAULT '',
    "team_name" TEXT NOT NULL DEFAULT '',
    "team_nationality" TEXT,
    "website_url" TEXT NOT NULL DEFAULT ''
);

CREATE TABLE "qualifying_constructor_number_above_20" (
    "qualify_id" INTEGER,
    "constructor_team_id" INTEGER NOT NULL DEFAULT 0,
    "driver_id" INTEGER NOT NULL DEFAULT 0,
    "entry_number" INTEGER NOT NULL DEFAULT 0,
    "position_rank" INTEGER,
    "race_id" INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE "qualifying_attempts_by_constructor" (
    "qualify_id" INTEGER,
    "constructor_team_id" INTEGER NOT NULL DEFAULT 0,
    "entry_number" INTEGER NOT NULL DEFAULT 0,
    "position_rank" INTEGER,
    "qual_time_stage_one" TEXT,
    "qual_time_stage_two" TEXT,
    "qual_time_stage_three" TEXT,
    "race_id" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("constructor_team_id") REFERENCES "constructor_teams"("constructor_team_id")
);

CREATE TABLE "constructor_standings_0_to_6_points" (
    "constructor_standing_id" INTEGER,
    "race_id" INTEGER NOT NULL DEFAULT 0,
    "constructor_team_id" INTEGER NOT NULL DEFAULT 0,
    "points_total" REAL NOT NULL DEFAULT 0,
    "position_rank" INTEGER,
    "position_label" TEXT,
    "win_count" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("constructor_team_id") REFERENCES "constructor_teams"("constructor_team_id")
);

CREATE TABLE "constructor_standings_6_to_25_points" (
    "constructor_standing_id" INTEGER,
    "race_id" INTEGER NOT NULL DEFAULT 0,
    "constructor_team_id" INTEGER NOT NULL DEFAULT 0,
    "points_total" REAL NOT NULL DEFAULT 0,
    "position_rank" INTEGER,
    "position_label" TEXT,
    "win_count" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("constructor_team_id") REFERENCES "constructor_teams"("constructor_team_id")
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "ConstructorStandingsPointsAtMostZero" (
    "ConstructorStandingId" INTEGER,
    "RaceId" INTEGER NOT NULL DEFAULT 0,
    "ConstructorId" INTEGER NOT NULL DEFAULT 0,
    "Points" REAL NOT NULL DEFAULT 0,
    "Position" INTEGER,
    "PositionLabel" TEXT,
    "WinsCount" INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE "ConstructorStandingsPointsAbove25OrNull" (
    "ConstructorStandingId" INTEGER,
    "RaceId" INTEGER NOT NULL DEFAULT 0,
    "ConstructorId" INTEGER NOT NULL DEFAULT 0,
    "Points" REAL NOT NULL DEFAULT 0,
    "Position" INTEGER,
    "PositionLabel" TEXT,
    "WinsCount" INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE "DriverRegistry" (
    "DriverId" INTEGER,
    "DriverCode" TEXT,
    "DateOfBirth" DATE,
    "DriverReference" TEXT NOT NULL DEFAULT '',
    "FirstName" TEXT NOT NULL DEFAULT '',
    "Nationality" TEXT,
    "LastName" TEXT NOT NULL DEFAULT ''
);

CREATE TABLE "LapTimesMillisecondsAtMost82398" (
    "RaceId" INTEGER,
    "DriverId" INTEGER,
    "LapNumber" INTEGER,
    "Position" INTEGER,
    "LapTime" TEXT,
    "Milliseconds" INTEGER
);

CREATE TABLE "LapTimesMillisecondsAbove102756OrNull" (
    "RaceId" INTEGER,
    "DriverId" INTEGER,
    "LapNumber" INTEGER,
    "Position" INTEGER,
    "LapTime" TEXT,
    "Milliseconds" INTEGER,
    FOREIGN KEY ("DriverId") REFERENCES "DriverRegistry"("DriverId")
);

CREATE TABLE "DriverStandingsPointsGreaterThanZeroToEight" (
    "DriverStandingId" INTEGER,
    "RaceId" INTEGER NOT NULL DEFAULT 0,
    "DriverId" INTEGER NOT NULL DEFAULT 0,
    "Points" REAL NOT NULL DEFAULT 0,
    "Position" INTEGER,
    "PositionLabel" TEXT,
    "WinsCount" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("DriverId") REFERENCES "DriverRegistry"("DriverId")
);

CREATE TABLE "QualifyingGridNumberAtMost7" (
    "QualifyRecordId" INTEGER,
    "ConstructorId" INTEGER NOT NULL DEFAULT 0,
    "DriverId" INTEGER NOT NULL DEFAULT 0,
    "GridNumber" INTEGER NOT NULL DEFAULT 0,
    "Position" INTEGER,
    "RaceId" INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE "QualifyingGridNumber8To12" (
    "QualifyRecordId" INTEGER,
    "ConstructorId" INTEGER NOT NULL DEFAULT 0,
    "DriverId" INTEGER NOT NULL DEFAULT 0,
    "GridNumber" INTEGER NOT NULL DEFAULT 0,
    "Position" INTEGER,
    "RaceId" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("DriverId") REFERENCES "DriverRegistry"("DriverId")
);

CREATE TABLE "QualifyingGridNumber13To20" (
    "QualifyRecordId" INTEGER,
    "ConstructorId" INTEGER NOT NULL DEFAULT 0,
    "DriverId" INTEGER NOT NULL DEFAULT 0,
    "GridNumber" INTEGER NOT NULL DEFAULT 0,
    "Position" INTEGER,
    "RaceId" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("DriverId") REFERENCES "DriverRegistry"("DriverId")
);

CREATE TABLE "PitStopsLaps14To24" (
    "RaceId" INTEGER,
    "DriverId" INTEGER,
    "StopNumber" INTEGER,
    "Duration" TEXT,
    "LapNumber" INTEGER NOT NULL,
    "Milliseconds" INTEGER,
    "EventTime" TEXT NOT NULL
);

CREATE TABLE "PitStopsLaps25To35" (
    "RaceId" INTEGER,
    "DriverId" INTEGER,
    "StopNumber" INTEGER,
    "Duration" TEXT,
    "LapNumber" INTEGER NOT NULL,
    "Milliseconds" INTEGER,
    "EventTime" TEXT NOT NULL
);

CREATE TABLE "PitStopsLapsAbove35OrNull" (
    "RaceId" INTEGER,
    "DriverId" INTEGER,
    "StopNumber" INTEGER,
    "Duration" TEXT,
    "LapNumber" INTEGER NOT NULL,
    "Milliseconds" INTEGER,
    "EventTime" TEXT NOT NULL,
    FOREIGN KEY ("DriverId") REFERENCES "DriverRegistry"("DriverId")
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "drv_stand_lowpts" (
    "stand_id" INTEGER,
    "race_fk" INTEGER NOT NULL DEFAULT 0,
    "driver_fk" INTEGER NOT NULL DEFAULT 0,
    "pts" REAL NOT NULL DEFAULT 0,
    "pos" INTEGER,
    "pos_txt" TEXT,
    "wins_cnt" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("driver_fk") REFERENCES "drv_profile"("driver_id"),
    FOREIGN KEY ("race_fk") REFERENCES "races_bel_germ"("race_id")
);

CREATE TABLE "drv_stand_highpts" (
    "stand_id" INTEGER,
    "race_fk" INTEGER NOT NULL DEFAULT 0,
    "driver_fk" INTEGER NOT NULL DEFAULT 0,
    "pts" REAL NOT NULL DEFAULT 0,
    "pos" INTEGER,
    "pos_txt" TEXT,
    "wins_cnt" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("race_fk") REFERENCES "races_ita_esp_bra"("race_id")
);

CREATE TABLE "results_ctor_map" (
    "result_id" INTEGER,
    "ctor_fk" INTEGER NOT NULL DEFAULT 0,
    "driver_fk" INTEGER NOT NULL DEFAULT 0,
    "race_fk" INTEGER NOT NULL DEFAULT 0,
    "status_fk" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("status_fk") REFERENCES "race_status"("status_id"),
    FOREIGN KEY ("race_fk") REFERENCES "races_bel_germ"("race_id")
);

CREATE TABLE "res_fast_lap" (
    "result_id" INTEGER,
    "fast_lap_no" INTEGER,
    "fast_lap_speed" TEXT,
    "fast_lap_time" TEXT,
    "lap_rank" INTEGER DEFAULT 0
);

CREATE TABLE "res_grid" (
    "result_id" INTEGER,
    "grid_pos" INTEGER NOT NULL DEFAULT 0,
    "laps" INTEGER NOT NULL DEFAULT 0,
    "car_no" INTEGER,
    "pts" REAL NOT NULL DEFAULT 0,
    "pos" INTEGER,
    "pos_order" INTEGER NOT NULL DEFAULT 0,
    "pos_txt" TEXT NOT NULL DEFAULT '',
    "status_fk" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("status_fk") REFERENCES "race_status"("status_id")
);

CREATE TABLE "race_status" (
    "status_id" INTEGER,
    "status_txt" TEXT NOT NULL DEFAULT ''
);

CREATE TABLE "races_ita_esp_bra" (
    "race_id" INTEGER,
    "yr" INTEGER NOT NULL DEFAULT 0,
    "rnd" INTEGER NOT NULL DEFAULT 0,
    "circuit_fk" INTEGER NOT NULL DEFAULT 0,
    "race_name" TEXT NOT NULL DEFAULT '',
    "race_date" DATE NOT NULL DEFAULT '0000-00-00',
    "race_time" TEXT,
    "race_url" TEXT
);

CREATE TABLE "races_bel_germ" (
    "race_id" INTEGER,
    "yr" INTEGER NOT NULL DEFAULT 0,
    "rnd" INTEGER NOT NULL DEFAULT 0,
    "circuit_fk" INTEGER NOT NULL DEFAULT 0,
    "race_name" TEXT NOT NULL DEFAULT '',
    "race_date" DATE NOT NULL DEFAULT '0000-00-00',
    "race_time" TEXT,
    "race_url" TEXT
);

CREATE TABLE "races_fra_can" (
    "race_id" INTEGER,
    "yr" INTEGER NOT NULL DEFAULT 0,
    "rnd" INTEGER NOT NULL DEFAULT 0,
    "circuit_fk" INTEGER NOT NULL DEFAULT 0,
    "race_name" TEXT NOT NULL DEFAULT '',
    "race_date" DATE NOT NULL DEFAULT '0000-00-00',
    "race_time" TEXT,
    "race_url" TEXT
);

CREATE TABLE "drv_profile" (
    "driver_id" INTEGER,
    "drv_code" TEXT,
    "birth_dt" DATE,
    "drv_ref" TEXT NOT NULL DEFAULT '',
    "nation" TEXT,
    "car_no" INTEGER,
    "bio_url" TEXT NOT NULL DEFAULT ''
);

