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