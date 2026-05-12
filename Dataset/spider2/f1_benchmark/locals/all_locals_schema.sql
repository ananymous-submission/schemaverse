-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/f1/f1.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "circ_alt_core" (
    "circ_id" INT(11),
    "alt_m" INT(11) DEFAULT NULL,
    "lat_deg" FLOAT DEFAULT NULL,
    "lng_deg" FLOAT DEFAULT NULL,
    "loc" VARCHAR(255) DEFAULT NULL,
    "circ_name" VARCHAR(255) NOT NULL DEFAULT '',
    "ref_url" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "circ_alt_usa" (
    "circ_id" INT(11),
    "alt_m" INT(11) DEFAULT NULL,
    "circ_ref" VARCHAR(255) NOT NULL DEFAULT '',
    "cntry" VARCHAR(255) DEFAULT NULL,
    "loc" VARCHAR(255) DEFAULT NULL,
    "circ_name" VARCHAR(255) NOT NULL DEFAULT '',
    "ref_url" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "circ_alt_fr_it_de" (
    "circ_id" INT(11),
    "alt_m" INT(11) DEFAULT NULL,
    "circ_ref" VARCHAR(255) NOT NULL DEFAULT '',
    "cntry" VARCHAR(255) DEFAULT NULL,
    "loc" VARCHAR(255) DEFAULT NULL,
    "circ_name" VARCHAR(255) NOT NULL DEFAULT '',
    "ref_url" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "circ_alt_es_be_ca" (
    "circ_id" INT(11),
    "alt_m" INT(11) DEFAULT NULL,
    "circ_ref" VARCHAR(255) NOT NULL DEFAULT '',
    "cntry" VARCHAR(255) DEFAULT NULL,
    "loc" VARCHAR(255) DEFAULT NULL,
    "circ_name" VARCHAR(255) NOT NULL DEFAULT '',
    "ref_url" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "circ_alt_pt_uk" (
    "circ_id" INT(11),
    "alt_m" INT(11) DEFAULT NULL,
    "circ_ref" VARCHAR(255) NOT NULL DEFAULT '',
    "cntry" VARCHAR(255) DEFAULT NULL,
    "loc" VARCHAR(255) DEFAULT NULL,
    "circ_name" VARCHAR(255) NOT NULL DEFAULT '',
    "ref_url" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "circ_alt_other" (
    "circ_id" INT(11),
    "alt_m" INT(11) DEFAULT NULL,
    "circ_ref" VARCHAR(255) NOT NULL DEFAULT '',
    "cntry" VARCHAR(255) DEFAULT NULL,
    "loc" VARCHAR(255) DEFAULT NULL,
    "circ_name" VARCHAR(255) NOT NULL DEFAULT '',
    "ref_url" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "circ_ext_dets" (
    "circ_id_ext" INT,
    "circ_ref_ext" TEXT,
    "circ_name" TEXT,
    "loc" TEXT,
    "cntry" TEXT,
    "lat_deg" REAL,
    "lng_deg" REAL,
    "alt_m" INT,
    "ref_url" TEXT,
    "last_race_yr" TEXT,
    "race_count" TEXT
);

CREATE TABLE "cons_res_cids_1_6" (
    "cons_res_id" INT(11),
    "race_ref" INT(11) NOT NULL DEFAULT '0',
    "cons_id" INT(11) NOT NULL DEFAULT '0',
    "pts" FLOAT DEFAULT NULL,
    "res_status" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "cons_res_cids_3_15_25" (
    "cons_res_id" INT(11),
    "race_ref" INT(11) NOT NULL DEFAULT '0',
    "cons_id" INT(11) NOT NULL DEFAULT '0',
    "pts" FLOAT DEFAULT NULL,
    "res_status" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "cons_res_cids_4_9_18_32" (
    "cons_res_id" INT(11),
    "race_ref" INT(11) NOT NULL DEFAULT '0',
    "cons_id" INT(11) NOT NULL DEFAULT '0',
    "pts" FLOAT DEFAULT NULL,
    "res_status" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "cons_res_other" (
    "cons_res_id" INT(11),
    "race_ref" INT(11) NOT NULL DEFAULT '0',
    "cons_id" INT(11) NOT NULL DEFAULT '0',
    "pts" FLOAT DEFAULT NULL,
    "res_status" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "lap_pos" (
    "race_ref" INT,
    "drv_id" INT,
    "lap_no" INT,
    "pos" INT,
    "lap_kind" TEXT
);

CREATE TABLE "res_ctor_map" (
    "res_id" INT(11),
    "cons_id" INT(11) NOT NULL DEFAULT '0',
    "drv_id" INT(11) NOT NULL DEFAULT '0',
    "race_ref" INT(11) NOT NULL DEFAULT '0',
    "status_ref" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "res_fast_lap" (
    "res_id" INT(11),
    "fl_lap_no" INT(11) DEFAULT NULL,
    "fl_speed" VARCHAR(255) DEFAULT NULL,
    "fl_time" VARCHAR(255) DEFAULT NULL,
    "fl_rank" INT(11) DEFAULT '0'
);

CREATE TABLE "res_grid_grp_0_1_3_7_10" (
    "res_id" INT(11),
    "grid_pos" INT(11) NOT NULL DEFAULT '0',
    "lap_count" INT(11) NOT NULL DEFAULT '0',
    "car_no" INT(11) DEFAULT NULL,
    "pts" FLOAT NOT NULL DEFAULT '0',
    "pos" INT(11) DEFAULT NULL,
    "pos_ord" INT(11) NOT NULL DEFAULT '0',
    "pos_txt" VARCHAR(255) NOT NULL DEFAULT '',
    "time_txt" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "res_grid_grp_4_5_9_11" (
    "res_id" INT(11),
    "grid_pos" INT(11) NOT NULL DEFAULT '0',
    "lap_count" INT(11) NOT NULL DEFAULT '0',
    "car_no" INT(11) DEFAULT NULL,
    "pts" FLOAT NOT NULL DEFAULT '0',
    "pos" INT(11) DEFAULT NULL,
    "pos_ord" INT(11) NOT NULL DEFAULT '0',
    "pos_txt" VARCHAR(255) NOT NULL DEFAULT '',
    "time_txt" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "res_grid_other" (
    "res_id" INT(11),
    "grid_pos" INT(11) NOT NULL DEFAULT '0',
    "lap_count" INT(11) NOT NULL DEFAULT '0',
    "car_no" INT(11) DEFAULT NULL,
    "pts" FLOAT NOT NULL DEFAULT '0',
    "pos" INT(11) DEFAULT NULL,
    "pos_ord" INT(11) NOT NULL DEFAULT '0',
    "pos_txt" VARCHAR(255) NOT NULL DEFAULT '',
    "time_txt" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "res_grid_full" (
    "res_id" INT(11),
    "grid_pos" INT(11) NOT NULL DEFAULT '0',
    "lap_count" INT(11) NOT NULL DEFAULT '0',
    "ms_time" INT(11) DEFAULT NULL,
    "car_no" INT(11) DEFAULT NULL,
    "pts" FLOAT NOT NULL DEFAULT '0',
    "pos_ord" INT(11) NOT NULL DEFAULT '0',
    "status_ref" INT(11) NOT NULL DEFAULT '0',
    "time_txt" VARCHAR(255) DEFAULT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "constructorsBritish" (
    "constructorId" INT(11),
    "constructorRef" VARCHAR(255) NOT NULL DEFAULT '',
    "displayName" VARCHAR(255) NOT NULL DEFAULT '',
    "nationalOrigin" VARCHAR(255) DEFAULT NULL,
    "websiteUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "constructorsAmerican" (
    "constructorId" INT(11),
    "constructorRef" VARCHAR(255) NOT NULL DEFAULT '',
    "displayName" VARCHAR(255) NOT NULL DEFAULT '',
    "nationalOrigin" VARCHAR(255) DEFAULT NULL,
    "websiteUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "constructorsItalian" (
    "constructorId" INT(11),
    "constructorRef" VARCHAR(255) NOT NULL DEFAULT '',
    "displayName" VARCHAR(255) NOT NULL DEFAULT '',
    "nationalOrigin" VARCHAR(255) DEFAULT NULL,
    "websiteUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "constructorsFrenchJapaneseSwiss" (
    "constructorId" INT(11),
    "constructorRef" VARCHAR(255) NOT NULL DEFAULT '',
    "displayName" VARCHAR(255) NOT NULL DEFAULT '',
    "nationalOrigin" VARCHAR(255) DEFAULT NULL,
    "websiteUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "constructorsGermanDutchSouthAfricanOther" (
    "constructorId" INT(11),
    "constructorRef" VARCHAR(255) NOT NULL DEFAULT '',
    "displayName" VARCHAR(255) NOT NULL DEFAULT '',
    "nationalOrigin" VARCHAR(255) DEFAULT NULL,
    "websiteUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "constructorCatalog" (
    "constructorId" INT,
    "constructorRef" TEXT,
    "displayName" TEXT,
    "nationalOrigin" TEXT,
    "websiteUrl" TEXT,
    "abbreviatedName" TEXT
);

CREATE TABLE "liverySchemes" (
    "constructorRef" VARCHAR(255) DEFAULT '',
    "startYear" INT(11) DEFAULT '0',
    "endYear" INT(11) DEFAULT '0',
    "primaryHexColor" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "raceRetirements" (
    "raceId" INT,
    "driverId" INT,
    "lapInfo" TEXT,
    "finishingPosition" INT,
    "statusId" INT,
    "retirementReason" TEXT
);

CREATE TABLE "shortConstructorNamesCooper" (
    "constructorRef" VARCHAR(255) DEFAULT '',
    "abbreviatedName" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "shortConstructorNamesLotus" (
    "constructorRef" VARCHAR(255) DEFAULT '',
    "abbreviatedName" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "shortConstructorNamesBrabham" (
    "constructorRef" VARCHAR(255) DEFAULT '',
    "abbreviatedName" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "shortConstructorNamesMcLarenDeTomaso" (
    "constructorRef" VARCHAR(255) DEFAULT '',
    "abbreviatedName" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "shortConstructorNamesEagleLdsMarchShadow" (
    "constructorRef" VARCHAR(255) DEFAULT '',
    "abbreviatedName" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "shortConstructorNamesOther" (
    "constructorRef" VARCHAR(255) DEFAULT '',
    "abbreviatedName" VARCHAR(255) NOT NULL DEFAULT ''
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "ConstructorStandingsTeams1And6" (
    "StandingRecordId" INT(11),
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "PointsTotal" FLOAT NOT NULL DEFAULT '0',
    "FinishingPosition" INT(11) DEFAULT NULL,
    "PositionLabel" VARCHAR(255) DEFAULT NULL,
    "WinsCount" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "ConstructorStandingsTeams3And25And4" (
    "StandingRecordId" INT(11),
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "PointsTotal" FLOAT NOT NULL DEFAULT '0',
    "FinishingPosition" INT(11) DEFAULT NULL,
    "PositionLabel" VARCHAR(255) DEFAULT NULL,
    "WinsCount" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "ConstructorStandingsTeams32And15And9And18" (
    "StandingRecordId" INT(11),
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "PointsTotal" FLOAT NOT NULL DEFAULT '0',
    "FinishingPosition" INT(11) DEFAULT NULL,
    "PositionLabel" VARCHAR(255) DEFAULT NULL,
    "WinsCount" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "ConstructorStandingsTeamsOther" (
    "StandingRecordId" INT(11),
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "PointsTotal" FLOAT NOT NULL DEFAULT '0',
    "FinishingPosition" INT(11) DEFAULT NULL,
    "PositionLabel" VARCHAR(255) DEFAULT NULL,
    "WinsCount" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "DriverProfilesBritish" (
    "DriverRecordId" INT(11),
    "DriverCode" VARCHAR(3) DEFAULT NULL,
    "DateOfBirth" DATE DEFAULT NULL,
    "DriverReference" VARCHAR(255) NOT NULL DEFAULT '',
    "NationalityName" VARCHAR(255) DEFAULT NULL,
    "CarNumber" INT(11) DEFAULT NULL,
    "ProfileUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "DriverProfilesAmerican" (
    "DriverRecordId" INT(11),
    "DriverCode" VARCHAR(3) DEFAULT NULL,
    "DateOfBirth" DATE DEFAULT NULL,
    "DriverReference" VARCHAR(255) NOT NULL DEFAULT '',
    "NationalityName" VARCHAR(255) DEFAULT NULL,
    "CarNumber" INT(11) DEFAULT NULL,
    "ProfileUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "DriverProfilesItalian" (
    "DriverRecordId" INT(11),
    "DriverCode" VARCHAR(3) DEFAULT NULL,
    "DateOfBirth" DATE DEFAULT NULL,
    "DriverReference" VARCHAR(255) NOT NULL DEFAULT '',
    "NationalityName" VARCHAR(255) DEFAULT NULL,
    "CarNumber" INT(11) DEFAULT NULL,
    "ProfileUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "DriverProfilesFrenchBrazilianArgentine" (
    "DriverRecordId" INT(11),
    "DriverCode" VARCHAR(3) DEFAULT NULL,
    "DateOfBirth" DATE DEFAULT NULL,
    "DriverReference" VARCHAR(255) NOT NULL DEFAULT '',
    "NationalityName" VARCHAR(255) DEFAULT NULL,
    "CarNumber" INT(11) DEFAULT NULL,
    "ProfileUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "DriverProfilesGermanBelgianSouthAfrican" (
    "DriverRecordId" INT(11),
    "DriverCode" VARCHAR(3) DEFAULT NULL,
    "DateOfBirth" DATE DEFAULT NULL,
    "DriverReference" VARCHAR(255) NOT NULL DEFAULT '',
    "NationalityName" VARCHAR(255) DEFAULT NULL,
    "CarNumber" INT(11) DEFAULT NULL,
    "ProfileUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "DriverProfilesOther" (
    "DriverRecordId" INT(11),
    "DriverCode" VARCHAR(3) DEFAULT NULL,
    "DateOfBirth" DATE DEFAULT NULL,
    "DriverReference" VARCHAR(255) NOT NULL DEFAULT '',
    "NationalityName" VARCHAR(255) DEFAULT NULL,
    "CarNumber" INT(11) DEFAULT NULL,
    "ProfileUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "DriverProfilesShortCodes" (
    "DriverRecordId" INT(11),
    "DriverCode" VARCHAR(3) DEFAULT NULL,
    "DriverReference" VARCHAR(255) NOT NULL DEFAULT '',
    "GivenName" VARCHAR(255) NOT NULL DEFAULT '',
    "NationalityName" VARCHAR(255) DEFAULT NULL,
    "CarNumber" INT(11) DEFAULT NULL,
    "FamilyName" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "DriverExtendedRecords" (
    "DriverRecordId" INT,
    "DriverReferenceText" TEXT,
    "CarNumber" INT,
    "DriverCodeText" TEXT,
    "GivenNameText" TEXT,
    "FamilyNameText" TEXT,
    "FullNameText" TEXT,
    "BirthTimestamp" NUM,
    "NationalityText" TEXT,
    "ProfileUrlText" TEXT
);

CREATE TABLE "LapTimeStatistics" (
    "RaceReferenceId" INT,
    "DriverReferenceId" INT,
    "AverageElapsedMilliseconds" TEXT,
    "AverageElapsedSeconds" TEXT,
    "StdDevMilliseconds" TEXT,
    "StdDevSeconds" TEXT
);

CREATE TABLE "SprintResultsConstructors1And51" (
    "ResultRecordId" INT(11),
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "DriverReferenceId" INT(11) NOT NULL DEFAULT '0',
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "SprintResultsConstructor3" (
    "ResultRecordId" INT(11),
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "DriverReferenceId" INT(11) NOT NULL DEFAULT '0',
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "SprintResultsConstructor6" (
    "ResultRecordId" INT(11),
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "DriverReferenceId" INT(11) NOT NULL DEFAULT '0',
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "SprintResultsConstructor9" (
    "ResultRecordId" INT(11),
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "DriverReferenceId" INT(11) NOT NULL DEFAULT '0',
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "SprintResultsConstructor117" (
    "ResultRecordId" INT(11),
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "DriverReferenceId" INT(11) NOT NULL DEFAULT '0',
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "SprintResultsConstructor131" (
    "ResultRecordId" INT(11),
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "DriverReferenceId" INT(11) NOT NULL DEFAULT '0',
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "SprintResultsConstructor210" (
    "ResultRecordId" INT(11),
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "DriverReferenceId" INT(11) NOT NULL DEFAULT '0',
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "SprintResultsConstructor214" (
    "ResultRecordId" INT(11),
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "DriverReferenceId" INT(11) NOT NULL DEFAULT '0',
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "SprintResultsConstructorsOther" (
    "ResultRecordId" INT(11),
    "ConstructorReferenceId" INT(11) NOT NULL DEFAULT '0',
    "DriverReferenceId" INT(11) NOT NULL DEFAULT '0',
    "RaceReferenceId" INT(11) NOT NULL DEFAULT '0',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "SprintResultsFastestLapDetails" (
    "ResultRecordId" INT(11),
    "FastestLapNumber" INT(11) DEFAULT NULL,
    "FastestLapSpeed" VARCHAR(255) DEFAULT NULL,
    "FastestLapTime" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "SprintResultsGridSummary" (
    "ResultRecordId" INT(11),
    "GridPosition" INT(11) NOT NULL DEFAULT '0',
    "LapsCompleted" INT(11) NOT NULL DEFAULT '0',
    "TimeMilliseconds" INT(11) DEFAULT NULL,
    "FinishPosition" INT(11) DEFAULT NULL,
    "PositionOrder" INT(11) NOT NULL DEFAULT '0',
    "PositionLabel" VARCHAR(255) NOT NULL DEFAULT '',
    "StatusReferenceId" INT(11) NOT NULL DEFAULT '0',
    "ResultTime" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "SprintResultsGridExtended" (
    "ResultRecordId" INT(11),
    "GridPosition" INT(11) NOT NULL DEFAULT '0',
    "LapsCompleted" INT(11) NOT NULL DEFAULT '0',
    "TimeMilliseconds" INT(11) DEFAULT NULL,
    "CarNumber" INT(11) DEFAULT NULL,
    "PointsAwarded" FLOAT NOT NULL DEFAULT '0',
    "PositionOrder" INT(11) NOT NULL DEFAULT '0',
    "PositionLabel" VARCHAR(255) NOT NULL DEFAULT '',
    "ResultTime" VARCHAR(255) DEFAULT NULL
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "lap_time_ms_general" (
    "race_key" INT(11),
    "driver_key" INT(11),
    "lap_number" INT(11),
    "lap_milliseconds" INT(11) DEFAULT NULL,
    "formatted_time" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "lap_time_ms_positions_1_and_3" (
    "race_key" INT(11),
    "driver_key" INT(11),
    "lap_number" INT(11),
    "lap_milliseconds" INT(11) DEFAULT NULL,
    "lap_position" INT(11) DEFAULT NULL,
    "formatted_time" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "lap_time_ms_positions_2_8_9" (
    "race_key" INT(11),
    "driver_key" INT(11),
    "lap_number" INT(11),
    "lap_milliseconds" INT(11) DEFAULT NULL,
    "lap_position" INT(11) DEFAULT NULL,
    "formatted_time" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "lap_time_ms_positions_4_and_5" (
    "race_key" INT(11),
    "driver_key" INT(11),
    "lap_number" INT(11),
    "lap_milliseconds" INT(11) DEFAULT NULL,
    "lap_position" INT(11) DEFAULT NULL,
    "formatted_time" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "lap_time_ms_positions_6_and_7" (
    "race_key" INT(11),
    "driver_key" INT(11),
    "lap_number" INT(11),
    "lap_milliseconds" INT(11) DEFAULT NULL,
    "lap_position" INT(11) DEFAULT NULL,
    "formatted_time" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "lap_time_ms_positions_other" (
    "race_key" INT(11),
    "driver_key" INT(11),
    "lap_number" INT(11),
    "lap_milliseconds" INT(11) DEFAULT NULL,
    "lap_position" INT(11) DEFAULT NULL,
    "formatted_time" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "race_records_circuits_14_11_70" (
    "race_key" INT(11),
    "circuit_key" INT(11) NOT NULL DEFAULT '0',
    "race_date" DATE NOT NULL,
    "free_practice_one_date" VARCHAR(255) DEFAULT NULL,
    "free_practice_two_date" VARCHAR(255) DEFAULT NULL,
    "free_practice_three_date" VARCHAR(255) DEFAULT NULL,
    "qualifying_date" VARCHAR(255) DEFAULT NULL,
    "sprint_race_date" VARCHAR(255) DEFAULT NULL,
    "sprint_race_time" VARCHAR(255) DEFAULT NULL,
    "reference_url" VARCHAR(255) DEFAULT NULL,
    "season_year" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "race_records_circuits_6_9" (
    "race_key" INT(11),
    "circuit_key" INT(11) NOT NULL DEFAULT '0',
    "race_date" DATE NOT NULL,
    "free_practice_one_date" VARCHAR(255) DEFAULT NULL,
    "free_practice_two_date" VARCHAR(255) DEFAULT NULL,
    "free_practice_three_date" VARCHAR(255) DEFAULT NULL,
    "qualifying_date" VARCHAR(255) DEFAULT NULL,
    "sprint_race_date" VARCHAR(255) DEFAULT NULL,
    "sprint_race_time" VARCHAR(255) DEFAULT NULL,
    "reference_url" VARCHAR(255) DEFAULT NULL,
    "season_year" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "race_records_circuits_13_7_18_20" (
    "race_key" INT(11),
    "circuit_key" INT(11) NOT NULL DEFAULT '0',
    "race_date" DATE NOT NULL,
    "free_practice_one_date" VARCHAR(255) DEFAULT NULL,
    "free_practice_two_date" VARCHAR(255) DEFAULT NULL,
    "free_practice_three_date" VARCHAR(255) DEFAULT NULL,
    "qualifying_date" VARCHAR(255) DEFAULT NULL,
    "sprint_race_date" VARCHAR(255) DEFAULT NULL,
    "sprint_race_time" VARCHAR(255) DEFAULT NULL,
    "reference_url" VARCHAR(255) DEFAULT NULL,
    "season_year" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "race_records_circuits_other" (
    "race_key" INT(11),
    "circuit_key" INT(11) NOT NULL DEFAULT '0',
    "race_date" DATE NOT NULL,
    "free_practice_one_date" VARCHAR(255) DEFAULT NULL,
    "free_practice_two_date" VARCHAR(255) DEFAULT NULL,
    "free_practice_three_date" VARCHAR(255) DEFAULT NULL,
    "qualifying_date" VARCHAR(255) DEFAULT NULL,
    "sprint_race_date" VARCHAR(255) DEFAULT NULL,
    "sprint_race_time" VARCHAR(255) DEFAULT NULL,
    "reference_url" VARCHAR(255) DEFAULT NULL,
    "season_year" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "race_session_times" (
    "race_key" INT(11),
    "free_practice_one_time" VARCHAR(255) DEFAULT NULL,
    "free_practice_two_time" VARCHAR(255) DEFAULT NULL,
    "free_practice_three_time" VARCHAR(255) DEFAULT NULL,
    "qualifying_time" VARCHAR(255) DEFAULT NULL,
    "sprint_race_date" VARCHAR(255) DEFAULT NULL,
    "sprint_race_time" VARCHAR(255) DEFAULT NULL,
    "official_race_time" TIME DEFAULT NULL
);

CREATE TABLE "race_overview_circuit_link" (
    "race_key" INT(11),
    "circuit_key" INT(11) NOT NULL DEFAULT '0',
    "race_date" DATE NOT NULL,
    "event_name" VARCHAR(255) NOT NULL DEFAULT '',
    "qualifying_date" VARCHAR(255) DEFAULT NULL,
    "season_round" INT(11) NOT NULL DEFAULT '0',
    "reference_url" VARCHAR(255) DEFAULT NULL,
    "season_year" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "race_metadata_extended" (
    "race_key" INT,
    "season_year" INT,
    "season_round" INT,
    "circuit_key" INT,
    "event_name" TEXT,
    "race_date" NUM,
    "race_time_value" NUM,
    "reference_url" TEXT,
    "free_practice_one_date_text" TEXT,
    "free_practice_one_time_text" TEXT,
    "free_practice_two_date_text" TEXT,
    "free_practice_two_time_text" TEXT,
    "free_practice_three_date_text" TEXT,
    "free_practice_three_time_text" TEXT,
    "qualifying_date_text" TEXT,
    "qualifying_time_text" TEXT,
    "sprint_race_date_text" TEXT,
    "sprint_race_time_text" TEXT,
    "pit_data_available_flag" TEXT,
    "short_event_name" TEXT,
    "has_sprint_flag" TEXT,
    "maximum_points_value" TEXT
);

CREATE TABLE "grand_prix_short_names" (
    "full_event_name" VARCHAR(255) DEFAULT '',
    "short_event_name" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "team_driver_rank_override_two" (
    "season_year" INT(11) DEFAULT '0',
    "constructor_reference" VARCHAR(255) DEFAULT '',
    "driver_reference" VARCHAR(255) DEFAULT '',
    "team_driver_rank_value" INT(11) DEFAULT '0'
);

CREATE TABLE "team_driver_rank_override_one" (
    "season_year" INT(11) DEFAULT '0',
    "constructor_reference" VARCHAR(255) DEFAULT '',
    "driver_reference" VARCHAR(255) DEFAULT '',
    "team_driver_rank_value" INT(11) DEFAULT '0'
);

CREATE TABLE "team_driver_rank_override_three_and_four_or_null" (
    "season_year" INT(11) DEFAULT '0',
    "constructor_reference" VARCHAR(255) DEFAULT '',
    "driver_reference" VARCHAR(255) DEFAULT '',
    "team_driver_rank_value" INT(11) DEFAULT '0'
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "DriverStandingsLowPoints" (
    "DriverStandingId" INT(11),
    "RaceId" INT(11) NOT NULL DEFAULT '0',
    "DriverId" INT(11) NOT NULL DEFAULT '0',
    "Points" FLOAT NOT NULL DEFAULT '0',
    "Position" INT(11) DEFAULT NULL,
    "PositionLabel" VARCHAR(255) DEFAULT NULL,
    "Wins" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "DriverStandingsModeratePoints" (
    "DriverStandingId" INT(11),
    "RaceId" INT(11) NOT NULL DEFAULT '0',
    "DriverId" INT(11) NOT NULL DEFAULT '0',
    "Points" FLOAT NOT NULL DEFAULT '0',
    "Position" INT(11) DEFAULT NULL,
    "PositionLabel" VARCHAR(255) DEFAULT NULL,
    "Wins" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "DriverStandingsHighOrUnknownPoints" (
    "DriverStandingId" INT(11),
    "RaceId" INT(11) NOT NULL DEFAULT '0',
    "DriverId" INT(11) NOT NULL DEFAULT '0',
    "Points" FLOAT NOT NULL DEFAULT '0',
    "Position" INT(11) DEFAULT NULL,
    "PositionLabel" VARCHAR(255) DEFAULT NULL,
    "Wins" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "DriverStandingsExtended" (
    "DriverStandingId" INT,
    "RaceId" INT,
    "DriverId" INT,
    "Points" REAL,
    "Position" INT,
    "PositionLabel" TEXT,
    "Wins" INT
);

CREATE TABLE "PitStopDurations" (
    "RaceId" INT(11),
    "DriverId" INT(11),
    "StopSequence" INT(11),
    "DurationLabel" VARCHAR(255) DEFAULT NULL,
    "DurationMilliseconds" INT(11) DEFAULT NULL,
    "StopTime" TIME NOT NULL
);

CREATE TABLE "PitStopLapsFeaturedSet" (
    "RaceId" INT(11),
    "DriverId" INT(11),
    "StopSequence" INT(11),
    "LapNumber" INT(11) NOT NULL,
    "LapMilliseconds" INT(11) DEFAULT NULL,
    "LapTime" TIME NOT NULL
);

CREATE TABLE "PitStopLapsSecondarySet" (
    "RaceId" INT(11),
    "DriverId" INT(11),
    "StopSequence" INT(11),
    "LapNumber" INT(11) NOT NULL,
    "LapMilliseconds" INT(11) DEFAULT NULL,
    "LapTime" TIME NOT NULL
);

CREATE TABLE "PitStopLapsOtherSet" (
    "RaceId" INT(11),
    "DriverId" INT(11),
    "StopSequence" INT(11),
    "LapNumber" INT(11) NOT NULL,
    "LapMilliseconds" INT(11) DEFAULT NULL,
    "LapTime" TIME NOT NULL
);

CREATE TABLE "RacingSeasons" (
    "SeasonYear" INT(11) DEFAULT '0',
    "SeasonUrl" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "TeamDriverRankings" (
    "SeasonYear" INT,
    "ConstructorId" INT,
    "ConstructorReference" TEXT,
    "DriverId" INT,
    "DriverReference" TEXT,
    "TeamDriverRankLabel" TEXT
);

-- ========================================================================
-- local_6
-- DDL file: local_6_schema.sql
-- ========================================================================

CREATE TABLE "seasonDriverRuns" (
    "seasonYear" INT,
    "driverRefId" INT,
    "driveRecordId" TEXT,
    "constructorRefId" INT,
    "firstRoundIndex" INT,
    "lastRoundIndex" INT,
    "isFirstDriveInSeason" TEXT,
    "isFinalDriveInSeason" TEXT
);

CREATE TABLE "extendedLapTimes" (
    "raceId" INT,
    "driverId" INT,
    "lapNumber" INT,
    "trackPosition" INT,
    "lapTime" TEXT,
    "lapMilliseconds" INT,
    "lapSeconds" REAL,
    "runningMilliseconds" TEXT
);

CREATE TABLE "qualifyingForConstructors3And6" (
    "qualificationId" INT(11),
    "constructorId" INT(11) NOT NULL DEFAULT '0',
    "driverId" INT(11) NOT NULL DEFAULT '0',
    "carNumber" INT(11) NOT NULL DEFAULT '0',
    "gridPosition" INT(11) DEFAULT NULL,
    "raceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "qualifyingForConstructors1And4And10" (
    "qualificationId" INT(11),
    "constructorId" INT(11) NOT NULL DEFAULT '0',
    "driverId" INT(11) NOT NULL DEFAULT '0',
    "carNumber" INT(11) NOT NULL DEFAULT '0',
    "gridPosition" INT(11) DEFAULT NULL,
    "raceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "qualifyingForConstructors9And15" (
    "qualificationId" INT(11),
    "constructorId" INT(11) NOT NULL DEFAULT '0',
    "driverId" INT(11) NOT NULL DEFAULT '0',
    "carNumber" INT(11) NOT NULL DEFAULT '0',
    "gridPosition" INT(11) DEFAULT NULL,
    "raceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "qualifyingForConstructors131And5" (
    "qualificationId" INT(11),
    "constructorId" INT(11) NOT NULL DEFAULT '0',
    "driverId" INT(11) NOT NULL DEFAULT '0',
    "carNumber" INT(11) NOT NULL DEFAULT '0',
    "gridPosition" INT(11) DEFAULT NULL,
    "raceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "qualifyingForOtherConstructors" (
    "qualificationId" INT(11),
    "constructorId" INT(11) NOT NULL DEFAULT '0',
    "driverId" INT(11) NOT NULL DEFAULT '0',
    "carNumber" INT(11) NOT NULL DEFAULT '0',
    "gridPosition" INT(11) DEFAULT NULL,
    "raceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "qualifyingSessionTimings" (
    "qualificationId" INT(11),
    "constructorId" INT(11) NOT NULL DEFAULT '0',
    "carNumber" INT(11) NOT NULL DEFAULT '0',
    "gridPosition" INT(11) DEFAULT NULL,
    "firstQualTime" VARCHAR(255) DEFAULT NULL,
    "secondQualTime" VARCHAR(255) DEFAULT NULL,
    "thirdQualTime" VARCHAR(255) DEFAULT NULL,
    "raceId" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "raceStatus" (
    "statusId" INT(11),
    "statusName" VARCHAR(255) NOT NULL DEFAULT ''
);

