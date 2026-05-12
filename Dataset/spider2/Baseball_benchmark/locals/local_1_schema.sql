CREATE TABLE "all_star_game_appearances" (
    "player_key" TEXT,
    "all_star_game_id" TEXT,
    "game_sequence" INTEGER,
    "games_played" NUMERIC,
    "league_key" TEXT,
    "starting_position" NUMERIC,
    "season_year" INTEGER
);

CREATE TABLE "all_star_other_team_records" (
    "player_key" TEXT,
    "all_star_game_id" TEXT,
    "league_key" TEXT,
    "starting_position" NUMERIC,
    "team_code" TEXT,
    "season_year" INTEGER
);

CREATE TABLE "colleges_ca_il_fl" (
    "college_key" TEXT,
    "institution_name" TEXT,
    "city_name" TEXT,
    "state_code" TEXT,
    "country_name" TEXT
);

CREATE TABLE "colleges_tx_ny_oh" (
    "college_key" TEXT,
    "institution_name" TEXT,
    "city_name" TEXT,
    "state_code" TEXT,
    "country_name" TEXT
);

CREATE TABLE "colleges_pa_nc_tn" (
    "college_key" TEXT,
    "institution_name" TEXT,
    "city_name" TEXT,
    "state_code" TEXT,
    "country_name" TEXT
);

CREATE TABLE "colleges_other_states" (
    "college_key" TEXT,
    "institution_name" TEXT,
    "city_name" TEXT,
    "state_code" TEXT,
    "country_name" TEXT
);

CREATE TABLE "team_manager_seasons" (
    "manager_player_key" TEXT,
    "season_year" INTEGER,
    "team_code" TEXT,
    "league_key" TEXT,
    "in_season_indicator" INTEGER,
    "games_managed" INTEGER,
    "games_won" INTEGER,
    "games_lost" INTEGER,
    "finish_rank" NUMERIC,
    "player_manager_flag" TEXT
);

CREATE TABLE "player_college_before_1950" (
    "player_key" TEXT,
    "college_key" TEXT,
    "college_year" INTEGER
);

CREATE TABLE "player_college_after_1995_or_missing" (
    "player_key" TEXT,
    "college_key" TEXT,
    "college_year" INTEGER
);