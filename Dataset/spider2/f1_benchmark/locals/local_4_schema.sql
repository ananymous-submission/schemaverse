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