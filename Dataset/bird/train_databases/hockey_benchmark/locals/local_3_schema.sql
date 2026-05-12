CREATE TABLE "coaches_games_max_37" (
    "coach_id" TEXT,
    "season_year" INTEGER,
    "team_id" TEXT,
    "stint_number" INTEGER,
    "games_coached" INTEGER,
    "postseason_games" TEXT,
    "postseason_losses" TEXT,
    "postseason_ties" TEXT,
    "postseason_wins" TEXT,
    "ties" INTEGER,
    FOREIGN KEY ("season_year") REFERENCES "teams_points_standings"("season_year"),
    FOREIGN KEY ("team_id") REFERENCES "teams_bench_minor_stats"("team_id")
);

CREATE TABLE "coaches_games_over_80_or_null" (
    "coach_id" TEXT,
    "season_year" INTEGER,
    "team_id" TEXT,
    "stint_number" INTEGER,
    "games_coached" INTEGER,
    "postseason_games" TEXT,
    "postseason_losses" TEXT,
    "postseason_ties" TEXT,
    "postseason_wins" TEXT,
    "ties" INTEGER,
    FOREIGN KEY ("season_year") REFERENCES "teams_points_standings"("season_year"),
    FOREIGN KEY ("season_year") REFERENCES "teams_penalty_kc_stats"("season_year"),
    FOREIGN KEY ("team_id") REFERENCES "teams_games_71_80"("team_id"),
    FOREIGN KEY ("team_id") REFERENCES "teams_bench_minor_stats"("team_id")
);

CREATE TABLE "goalies_gp_with_post_stats" (
    "player_id" TEXT,
    "season_year" INTEGER,
    "stint_number" INTEGER,
    "games_played" TEXT,
    "losses" TEXT,
    "postseason_games_played" TEXT,
    "postseason_losses" TEXT,
    "postseason_shutouts" TEXT,
    "postseason_ties" TEXT,
    "postseason_wins" TEXT,
    "shutouts" TEXT,
    "ties_overtime_loss" TEXT,
    "wins" TEXT,
    FOREIGN KEY ("player_id") REFERENCES "master_persons_registry"("player_id"),
    FOREIGN KEY ("season_year") REFERENCES "teams_points_standings"("season_year"),
    FOREIGN KEY ("season_year") REFERENCES "teams_bench_minor_stats"("season_year")
);

CREATE TABLE "goalies_postseason_sa_stats" (
    "player_id" TEXT,
    "season_year" INTEGER,
    "stint_number" INTEGER,
    "postseason_shots_against" TEXT,
    "shots_against" TEXT,
    FOREIGN KEY ("season_year") REFERENCES "teams_games_71_80"("season_year"),
    FOREIGN KEY ("season_year") REFERENCES "teams_games_over_80_or_null"("season_year"),
    FOREIGN KEY ("season_year") REFERENCES "teams_penalty_kc_stats"("season_year")
);

CREATE TABLE "goalies_ga_bench_pkc" (
    "player_id" TEXT,
    "season_year" INTEGER,
    "goals_against" INTEGER,
    "games_played" INTEGER,
    "losses" INTEGER,
    "minutes_played" INTEGER,
    "shutouts" INTEGER,
    "ties" INTEGER,
    "wins" INTEGER,
    FOREIGN KEY ("season_year") REFERENCES "teams_bench_minor_stats"("season_year"),
    FOREIGN KEY ("season_year") REFERENCES "teams_penalty_kc_stats"("season_year")
);

CREATE TABLE "goalies_ga_fragments_bench" (
    "player_id" TEXT,
    "season_year" INTEGER,
    "goals_against" INTEGER,
    "minutes_played" INTEGER,
    "shutouts" INTEGER,
    "ties" INTEGER,
    "league_id" TEXT,
    "team_id" TEXT,
    FOREIGN KEY ("season_year") REFERENCES "teams_games_71_80"("season_year"),
    FOREIGN KEY ("season_year") REFERENCES "teams_games_over_80_or_null"("season_year"),
    FOREIGN KEY ("season_year") REFERENCES "teams_bench_minor_stats"("season_year"),
    FOREIGN KEY ("team_id") REFERENCES "teams_penalty_kc_stats"("team_id")
);

CREATE TABLE "goalies_shootout_stats" (
    "player_id" TEXT,
    "season_year" INTEGER,
    "stint_number" INTEGER,
    "team_id" TEXT,
    "wins" INTEGER,
    "losses" INTEGER,
    "shots_against" INTEGER,
    "goals_against" INTEGER,
    FOREIGN KEY ("team_id") REFERENCES "teams_points_standings"("team_id")
);

CREATE TABLE "master_persons_registry" (
    "player_id" TEXT,
    "coach_id_ref" TEXT,
    "hall_of_fame_id" TEXT,
    "name" TEXT,
    "last_name" TEXT NOT NULL,
    "name_note" TEXT,
    "given_name" TEXT,
    "nickname" TEXT,
    "height" TEXT,
    "weight_lbs" TEXT,
    "shoot_catch" TEXT,
    "legends_id" TEXT,
    "ihdb_id" TEXT,
    "href_id" TEXT,
    "nhl_year" TEXT,
    "last_nhl_year" TEXT,
    "wha_year" TEXT,
    "last_wha_year" TEXT,
    "primary_position" TEXT,
    "birth_year" TEXT,
    "birth_month" TEXT,
    "birth_day" TEXT,
    "birth_country" TEXT,
    "birth_state" TEXT,
    "birth_city" TEXT,
    "death_year" TEXT,
    "death_month" TEXT,
    "death_day" TEXT,
    "death_country" TEXT,
    "death_state" TEXT,
    "death_city" TEXT,
    FOREIGN KEY ("coach_id_ref") REFERENCES "coaches_games_max_37"("coach_id"),
    FOREIGN KEY ("coach_id_ref") REFERENCES "coaches_games_over_80_or_null"("coach_id")
);

CREATE TABLE "scoring_stats_regular" (
    "player_id" TEXT,
    "season_year" INTEGER,
    "stint_number" INTEGER,
    "team_id" TEXT,
    "league_id" TEXT,
    "position" TEXT,
    "games_played" INTEGER,
    "goals" INTEGER,
    "assists" INTEGER,
    "points" INTEGER,
    "penalty_minutes" INTEGER,
    "plus_minus" TEXT,
    "powerplay_goals" TEXT,
    "powerplay_assists" TEXT,
    "shorthanded_goals" TEXT,
    "shorthanded_assists" TEXT,
    "game_winning_goals" TEXT,
    "game_tying_goals" TEXT,
    "shots_on_goal" TEXT,
    "postseason_games_played" TEXT,
    "postseason_goals" TEXT,
    "postseason_assists" TEXT,
    "postseason_points" TEXT,
    "postseason_penalty_minutes" TEXT,
    "postseason_plus_minus" TEXT,
    "postseason_powerplay_goals" TEXT,
    "postseason_powerplay_assists" TEXT,
    "postseason_shorthanded_goals" TEXT,
    "postseason_shorthanded_assists" TEXT,
    "postseason_game_winning_goals" TEXT,
    "postseason_shots_on_goal" TEXT,
    FOREIGN KEY ("season_year") REFERENCES "teams_games_71_80"("season_year"),
    FOREIGN KEY ("season_year") REFERENCES "teams_bench_minor_stats"("season_year"),
    FOREIGN KEY ("team_id") REFERENCES "teams_games_71_80"("team_id"),
    FOREIGN KEY ("team_id") REFERENCES "teams_points_standings"("team_id")
);

CREATE TABLE "scoring_stats_special_competition" (
    "player_id" TEXT,
    "season_year" INTEGER,
    "team_id" TEXT,
    "league_id" TEXT,
    "position" TEXT,
    "games_played" INTEGER,
    "goals" INTEGER,
    "assists" INTEGER,
    "points" INTEGER,
    "penalty_minutes" INTEGER,
    FOREIGN KEY ("season_year") REFERENCES "teams_games_71_80"("season_year"),
    FOREIGN KEY ("season_year") REFERENCES "teams_games_over_80_or_null"("season_year"),
    FOREIGN KEY ("season_year") REFERENCES "teams_penalty_kc_stats"("season_year"),
    FOREIGN KEY ("team_id") REFERENCES "teams_bench_minor_stats"("team_id"),
    FOREIGN KEY ("team_id") REFERENCES "teams_penalty_kc_stats"("team_id")
);

CREATE TABLE "scoring_shootout_stats" (
    "player_id" TEXT,
    "season_year" INTEGER,
    "stint_number" INTEGER,
    "team_id" TEXT,
    "shootout_attempts" INTEGER,
    "goals" INTEGER,
    "game_deciding_goals" INTEGER,
    FOREIGN KEY ("season_year") REFERENCES "teams_points_standings"("season_year"),
    FOREIGN KEY ("season_year") REFERENCES "teams_penalty_kc_stats"("season_year"),
    FOREIGN KEY ("team_id") REFERENCES "teams_games_71_80"("team_id"),
    FOREIGN KEY ("team_id") REFERENCES "teams_games_over_80_or_null"("team_id"),
    FOREIGN KEY ("team_id") REFERENCES "teams_penalty_kc_stats"("team_id")
);

CREATE TABLE "scoring_supplemental" (
    "player_id" TEXT,
    "season_year" INTEGER,
    "powerplay_assists" TEXT,
    "shorthanded_assists" TEXT,
    FOREIGN KEY ("player_id") REFERENCES "master_persons_registry"("player_id")
);

CREATE TABLE "teams_games_71_80" (
    "season_year" INTEGER,
    "team_id" TEXT,
    "games_played" INTEGER,
    "losses" INTEGER,
    "overtime_losses" TEXT,
    "points" INTEGER,
    "shootout_losses" TEXT,
    "shootout_wins" TEXT,
    "ties" INTEGER,
    "wins" INTEGER,
    "conference_id" TEXT,
    "division_id" TEXT,
    "franchise_id" TEXT,
    "team_name" TEXT,
    "playoff_flag" TEXT,
    "rank" INTEGER
);

CREATE TABLE "teams_games_over_80_or_null" (
    "season_year" INTEGER,
    "team_id" TEXT,
    "games_played" INTEGER,
    "losses" INTEGER,
    "overtime_losses" TEXT,
    "points" INTEGER,
    "shootout_losses" TEXT,
    "shootout_wins" TEXT,
    "ties" INTEGER,
    "wins" INTEGER,
    "conference_id" TEXT,
    "division_id" TEXT,
    "franchise_id" TEXT,
    "team_name" TEXT,
    "playoff_flag" TEXT,
    "rank" INTEGER
);

CREATE TABLE "teams_points_standings" (
    "season_year" INTEGER,
    "team_id" TEXT,
    "points" INTEGER,
    "shootout_losses" TEXT,
    "shootout_wins" TEXT,
    "ties" INTEGER,
    "conference_id" TEXT,
    "division_id" TEXT,
    "franchise_id" TEXT,
    "league_id" TEXT,
    "team_name" TEXT,
    "playoff_flag" TEXT,
    "rank" INTEGER
);

CREATE TABLE "teams_bench_minor_stats" (
    "season_year" INTEGER,
    "team_id" TEXT,
    "bench_minor" TEXT,
    "penalty_minutes" TEXT
);

CREATE TABLE "teams_penalty_kc_stats" (
    "season_year" INTEGER,
    "team_id" TEXT,
    "pkc_value" TEXT,
    "ppc_value" TEXT
);

CREATE TABLE "awards_players_position_defense" (
    "player_id" TEXT,
    "award_name" TEXT,
    "award_year" INTEGER,
    "league_id" TEXT,
    "position" TEXT
);

CREATE TABLE "awards_players_pos_goalie_leftwing_forward" (
    "player_id" TEXT,
    "award_name" TEXT,
    "award_year" INTEGER,
    "league_id" TEXT,
    "position" TEXT,
    FOREIGN KEY ("player_id") REFERENCES "master_persons_registry"("player_id")
);

CREATE TABLE "awards_players_pos_center_rightwing" (
    "player_id" TEXT,
    "award_name" TEXT,
    "award_year" INTEGER,
    "league_id" TEXT,
    "position" TEXT
);