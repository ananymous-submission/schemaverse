CREATE TABLE "draft_source_entries" (
    "draft_source_id" INTEGER DEFAULT 0,
    "draft_origin" TEXT,
    "name" TEXT,
    "last_name" TEXT,
    "player_id" TEXT,
    "suffix_name" TEXT
);

CREATE TABLE "draft_selection_records" (
    "draft_selection_id" INTEGER DEFAULT 0,
    "draft_origin" TEXT,
    "overall_pick_number" INTEGER,
    "draft_year" INTEGER,
    "league_id" TEXT,
    "player_id" TEXT,
    "suffix_name" TEXT,
    "team_id" TEXT
);

CREATE TABLE "player_team_season_stats" (
    "player_team_stats_id" INTEGER,
    "season_games_played" INTEGER,
    "season_games_started" INTEGER,
    "season_personal_fouls" INTEGER,
    "post_assists" INTEGER,
    "post_blocks" INTEGER,
    "post_games_played" INTEGER,
    "post_games_started" INTEGER,
    "post_minutes" INTEGER,
    "post_personal_fouls" INTEGER,
    "post_points" INTEGER,
    "post_steals" INTEGER,
    "post_turnovers" INTEGER,
    "season_assists" INTEGER,
    "season_blocks" INTEGER,
    "season_minutes" INTEGER,
    "notes" TEXT,
    "season_points" INTEGER,
    "season_steals" INTEGER,
    "stint_number" INTEGER,
    "season_turnovers" INTEGER,
    "season_year" INTEGER
);

CREATE TABLE "player_team_post_rebounds_top" (
    "post_rebounds_top_id" INTEGER,
    "post_rebounds" INTEGER,
    "post_defensive_rebounds" INTEGER,
    "post_offensive_rebounds" INTEGER,
    "defensive_rebounds" INTEGER,
    "offensive_rebounds" INTEGER,
    "total_rebounds" INTEGER
);