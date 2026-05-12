-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/hockey/hockey.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "awards_misc_thru1976" (
    "awardee_nm" TEXT,
    "awardee_id" TEXT,
    "award_code" TEXT,
    "yr" INTEGER,
    "lg_key" TEXT,
    "note_txt" TEXT
);

CREATE TABLE "awards_misc_1977_1991" (
    "awardee_nm" TEXT,
    "awardee_id" TEXT,
    "award_code" TEXT,
    "yr" INTEGER,
    "lg_key" TEXT,
    "note_txt" TEXT
);

CREATE TABLE "awards_misc_1992_2001" (
    "awardee_nm" TEXT,
    "awardee_id" TEXT,
    "award_code" TEXT,
    "yr" INTEGER,
    "lg_key" TEXT,
    "note_txt" TEXT
);

CREATE TABLE "awards_misc_post2001" (
    "awardee_nm" TEXT,
    "awardee_id" TEXT,
    "award_code" TEXT,
    "yr" INTEGER,
    "lg_key" TEXT,
    "note_txt" TEXT
);

CREATE TABLE "shutout_match_log" (
    "yr" INTEGER,
    "mo" INTEGER,
    "day" INTEGER,
    "team_id" TEXT,
    "opp_id" TEXT,
    "game_phase_cd" TEXT,
    "goalie_primary_id" TEXT,
    "goalie_secondary_id" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "CoachAwards" (
    "CoachId" TEXT,
    "AwardName" TEXT,
    "AwardYear" INTEGER,
    "LeagueId" TEXT,
    "NoteText" TEXT
);

CREATE TABLE "HallOfFameThrough1962" (
    "InductionYear" INTEGER,
    "HallMemberId" TEXT,
    "FullName" TEXT,
    "InductionCategory" TEXT
);

CREATE TABLE "HallOfFame1963To1972" (
    "InductionYear" INTEGER,
    "HallMemberId" TEXT,
    "FullName" TEXT,
    "InductionCategory" TEXT
);

CREATE TABLE "HallOfFame1973To1990" (
    "InductionYear" INTEGER,
    "HallMemberId" TEXT,
    "FullName" TEXT,
    "InductionCategory" TEXT
);

CREATE TABLE "HallOfFameSince1991OrUnknown" (
    "InductionYear" INTEGER,
    "HallMemberId" TEXT,
    "FullName" TEXT,
    "InductionCategory" TEXT
);

CREATE TABLE "CoachSeasonStatsGames38To70" (
    "CoachId" TEXT,
    "SeasonYear" INTEGER,
    "TeamId" TEXT,
    "StintNumber" INTEGER,
    "GamesPlayed" INTEGER,
    "PostseasonGames" TEXT,
    "PostseasonLosses" TEXT,
    "PostseasonTies" TEXT,
    "PostseasonWins" TEXT,
    "SeasonTies" INTEGER
);

CREATE TABLE "CoachSeasonStatsGames71To80" (
    "CoachId" TEXT,
    "SeasonYear" INTEGER,
    "TeamId" TEXT,
    "StintNumber" INTEGER,
    "GamesPlayed" INTEGER,
    "PostseasonGames" TEXT,
    "PostseasonLosses" TEXT,
    "PostseasonTies" TEXT,
    "PostseasonWins" TEXT,
    "SeasonTies" INTEGER
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "postseasonSeriesSummary" (
    "seasonYear" INTEGER,
    "playoffRound" TEXT,
    "seriesId" TEXT,
    "winnerTeamId" TEXT,
    "winnerLeagueId" TEXT,
    "loserTeamId" TEXT,
    "loserLeagueId" TEXT,
    "wins" INTEGER,
    "losses" INTEGER,
    "ties" INTEGER,
    "winnerGoals" INTEGER,
    "loserGoals" INTEGER,
    "seriesNote" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "teamMonthlySplitsAprilComprehensive" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "aprilLosses" TEXT,
    "aprilOvertimeLosses" TEXT,
    "aprilTies" TEXT,
    "aprilWins" TEXT,
    "decemberLosses" TEXT,
    "decemberOvertimeLosses" TEXT,
    "decemberTies" TEXT,
    "decemberWins" TEXT,
    "februaryLosses" INTEGER,
    "februaryOvertimeLosses" TEXT,
    "februaryTies" INTEGER,
    "februaryWins" INTEGER,
    "januaryLosses" INTEGER,
    "januaryOvertimeLosses" TEXT,
    "januaryTies" INTEGER,
    "januaryWins" INTEGER,
    "septemberLosses" TEXT,
    "septemberOvertimeLosses" TEXT,
    "septemberTies" TEXT,
    "septemberWins" TEXT,
    "leagueId" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "teamMonthlyOvertimeLosses" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "aprilOvertimeLosses" TEXT,
    "decemberLosses" TEXT,
    "decemberOvertimeLosses" TEXT,
    "februaryLosses" INTEGER,
    "februaryOvertimeLosses" TEXT,
    "januaryOvertimeLosses" TEXT,
    "marchOvertimeLosses" TEXT,
    "novemberLosses" TEXT,
    "novemberOvertimeLosses" TEXT,
    "novemberTies" TEXT,
    "novemberWins" TEXT,
    "septemberLosses" TEXT,
    "septemberOvertimeLosses" TEXT,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId")
);

CREATE TABLE "teamMonthlySplitsAprilTotals" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "aprilLosses" TEXT,
    "aprilTies" TEXT,
    "decemberTies" TEXT,
    "februaryTies" INTEGER,
    "januaryTies" INTEGER,
    "marchLosses" TEXT,
    "marchOvertimeLosses" TEXT,
    "marchTies" TEXT,
    "marchWins" TEXT,
    "septemberTies" TEXT,
    "leagueId" TEXT,
    "roadTies" INTEGER,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "teamMonthlySplitsOctober" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "octoberLosses" TEXT,
    "octoberOvertimeLosses" TEXT,
    "octoberTies" TEXT,
    "octoberWins" TEXT,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId")
);

CREATE TABLE "teamHomeLossesQuartileLowest" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "homeLosses" INTEGER,
    "homeOvertimeLosses" TEXT,
    "homeTies" INTEGER,
    "homeWins" INTEGER,
    "roadLosses" INTEGER,
    "roadOvertimeLosses" TEXT,
    "roadTies" INTEGER,
    "roadWins" INTEGER,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "teamHomeLossesQuartileLowerMiddle" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "homeLosses" INTEGER,
    "homeOvertimeLosses" TEXT,
    "homeTies" INTEGER,
    "homeWins" INTEGER,
    "roadLosses" INTEGER,
    "roadOvertimeLosses" TEXT,
    "roadTies" INTEGER,
    "roadWins" INTEGER,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId")
);

CREATE TABLE "teamHomeLossesQuartileUpperMiddle" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "homeLosses" INTEGER,
    "homeOvertimeLosses" TEXT,
    "homeTies" INTEGER,
    "homeWins" INTEGER,
    "roadLosses" INTEGER,
    "roadOvertimeLosses" TEXT,
    "roadTies" INTEGER,
    "roadWins" INTEGER,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "teamHomeLossesQuartileHighest" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "homeLosses" INTEGER,
    "homeOvertimeLosses" TEXT,
    "homeTies" INTEGER,
    "homeWins" INTEGER,
    "roadLosses" INTEGER,
    "roadOvertimeLosses" TEXT,
    "roadTies" INTEGER,
    "roadWins" INTEGER,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId")
);

CREATE TABLE "teamMatchupLossesGroupLowest" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "opponentId" TEXT,
    "losses" INTEGER,
    "overtimeLosses" TEXT,
    "ties" INTEGER,
    "wins" INTEGER,
    FOREIGN KEY ("opponentId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId")
);

CREATE TABLE "teamMatchupLossesGroupMiddle" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "opponentId" TEXT,
    "losses" INTEGER,
    "overtimeLosses" TEXT,
    "ties" INTEGER,
    "wins" INTEGER,
    FOREIGN KEY ("opponentId") REFERENCES "teamsSeasonGoalsSummary"("teamId"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId")
);

CREATE TABLE "teamMatchupLossesGroupHighest" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "opponentId" TEXT,
    "losses" INTEGER,
    "overtimeLosses" TEXT,
    "ties" INTEGER,
    "wins" INTEGER,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "teamMatchupOvertimeDetails" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "opponentId" TEXT,
    "overtimeLosses" TEXT,
    "ties" INTEGER,
    "leagueId" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "teamsSeasonOverviewGoalsLow" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "goals" INTEGER,
    "losses" INTEGER,
    "overtimeLosses" TEXT,
    "points" INTEGER,
    "shootoutLosses" TEXT,
    "shootoutWins" TEXT,
    "ties" INTEGER,
    "wins" INTEGER,
    "conferenceId" TEXT,
    "divisionId" TEXT,
    "franchiseId" TEXT,
    "teamName" TEXT,
    "playoffStatus" TEXT,
    "teamRank" INTEGER
);

CREATE TABLE "teamsSeasonGoalsSummary" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "goalsAgainst" INTEGER,
    "goalsFor" INTEGER,
    "penaltyKillGoals" TEXT,
    "powerPlayGoals" TEXT,
    "shortHandedAgainst" TEXT,
    "shortHandedFor" TEXT
);

CREATE TABLE "teamHalfSeasonTotals" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "halfNumber" INTEGER,
    "games" INTEGER,
    "losses" INTEGER,
    "ties" INTEGER,
    "wins" INTEGER,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId")
);

CREATE TABLE "teamHalfSeasonGoalsSummary" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "halfNumber" INTEGER,
    "games" INTEGER,
    "goalsAgainst" INTEGER,
    "goalsFor" INTEGER,
    "losses" INTEGER,
    "wins" INTEGER,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "teamHalfSeasonRankQuartileLowest" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "halfNumber" INTEGER,
    "ties" INTEGER,
    "leagueId" TEXT,
    "divisionRank" INTEGER
);

CREATE TABLE "teamHalfSeasonRankQuartileLowerMiddle" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "halfNumber" INTEGER,
    "ties" INTEGER,
    "leagueId" TEXT,
    "divisionRank" INTEGER,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "teamHalfSeasonRankQuartileUpperMiddle" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "halfNumber" INTEGER,
    "ties" INTEGER,
    "leagueId" TEXT,
    "divisionRank" INTEGER,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear")
);

CREATE TABLE "teamHalfSeasonRankQuartileHighest" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "halfNumber" INTEGER,
    "ties" INTEGER,
    "leagueId" TEXT,
    "divisionRank" INTEGER,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "teamPostBenchMinorPenalties" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "benchMinorPenalties" TEXT,
    "penaltyMinutes" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear")
);

CREATE TABLE "teamPostseasonSummaryExtended" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "games" INTEGER,
    "goalsAgainst" INTEGER,
    "goalsFor" INTEGER,
    "losses" INTEGER,
    "ties" INTEGER,
    "wins" INTEGER,
    "leagueId" TEXT,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId")
);

CREATE TABLE "teamPostGoalsAgainstQuartileLowest" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "goalsAgainst" INTEGER,
    "goalsFor" INTEGER,
    "losses" INTEGER,
    "penaltyKillGoals" TEXT,
    "powerPlayGoals" TEXT,
    "shortHandedAgainst" TEXT,
    "shortHandedFor" TEXT,
    "wins" INTEGER,
    "leagueId" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "teamPostGoalsAgainstQuartileLowerMiddle" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "goalsAgainst" INTEGER,
    "goalsFor" INTEGER,
    "losses" INTEGER,
    "penaltyKillGoals" TEXT,
    "powerPlayGoals" TEXT,
    "shortHandedAgainst" TEXT,
    "shortHandedFor" TEXT,
    "wins" INTEGER,
    "leagueId" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "teamPostGoalsAgainstQuartileUpperMiddle" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "goalsAgainst" INTEGER,
    "goalsFor" INTEGER,
    "losses" INTEGER,
    "penaltyKillGoals" TEXT,
    "powerPlayGoals" TEXT,
    "shortHandedAgainst" TEXT,
    "shortHandedFor" TEXT,
    "wins" INTEGER,
    "leagueId" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear")
);

CREATE TABLE "teamPostGoalsAgainstQuartileHighest" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "goalsAgainst" INTEGER,
    "goalsFor" INTEGER,
    "losses" INTEGER,
    "penaltyKillGoals" TEXT,
    "powerPlayGoals" TEXT,
    "shortHandedAgainst" TEXT,
    "shortHandedFor" TEXT,
    "wins" INTEGER,
    "leagueId" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "teamPostPenaltyCounts" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "penaltyKillCount" TEXT,
    "powerPlayChances" TEXT,
    "powerPlayGoals" TEXT,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "teamScorecardPostseason" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "games" INTEGER,
    "losses" INTEGER,
    "penaltyMinutes" TEXT,
    "ties" INTEGER,
    "wins" INTEGER,
    "leagueId" TEXT,
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "teamScorecardGoalsAggregate" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "goalsAgainst" INTEGER,
    "goalsFor" INTEGER,
    "losses" INTEGER,
    "penaltyMinutes" TEXT,
    "wins" INTEGER,
    "leagueId" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId")
);

CREATE TABLE "goalieLeagueAssignment" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "leagueId" TEXT,
    "teamId" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "coachSeriesAppearances" (
    "coachId" TEXT,
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "stintNumber" INTEGER,
    "games" INTEGER,
    "leagueId" TEXT,
    "postGames" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "coachSeasonResults" (
    "coachId" TEXT,
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "stintNumber" INTEGER,
    "losses" INTEGER,
    "postTies" TEXT,
    "ties" INTEGER,
    "wins" INTEGER,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonOverviewGoalsLow"("teamId"),
    FOREIGN KEY ("teamId") REFERENCES "teamsSeasonGoalsSummary"("teamId")
);

CREATE TABLE "goalieEngBucketZero" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "engCode" TEXT,
    "goalsAgainst" TEXT,
    "losses" TEXT,
    "postEngCode" TEXT,
    "postGoalsAgainst" TEXT,
    "postShutouts" TEXT,
    "postTies" TEXT,
    "shutouts" TEXT,
    "tiesOrOtl" TEXT,
    "wins" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear")
);

CREATE TABLE "goalieEngBucketOne" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "engCode" TEXT,
    "goalsAgainst" TEXT,
    "losses" TEXT,
    "postEngCode" TEXT,
    "postGoalsAgainst" TEXT,
    "postShutouts" TEXT,
    "postTies" TEXT,
    "shutouts" TEXT,
    "tiesOrOtl" TEXT,
    "wins" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "goalieEngBucketTwoThree" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "engCode" TEXT,
    "goalsAgainst" TEXT,
    "losses" TEXT,
    "postEngCode" TEXT,
    "postGoalsAgainst" TEXT,
    "postShutouts" TEXT,
    "postTies" TEXT,
    "shutouts" TEXT,
    "tiesOrOtl" TEXT,
    "wins" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "goalieEngBucketFourToEight" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "engCode" TEXT,
    "goalsAgainst" TEXT,
    "losses" TEXT,
    "postEngCode" TEXT,
    "postGoalsAgainst" TEXT,
    "postShutouts" TEXT,
    "postTies" TEXT,
    "shutouts" TEXT,
    "tiesOrOtl" TEXT,
    "wins" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear")
);

CREATE TABLE "goalieEngBucketOther" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "engCode" TEXT,
    "goalsAgainst" TEXT,
    "losses" TEXT,
    "postEngCode" TEXT,
    "postGoalsAgainst" TEXT,
    "postShutouts" TEXT,
    "postTies" TEXT,
    "shutouts" TEXT,
    "tiesOrOtl" TEXT,
    "wins" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

CREATE TABLE "coachSeasonNotes" (
    "coachId" TEXT,
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "stintNumber" INTEGER,
    "coachNotesText" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear")
);

CREATE TABLE "goalieGamesMinutes" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "gamesPlayed" TEXT,
    "minutes" TEXT,
    "postGamesPlayed" TEXT,
    "postMinutes" TEXT,
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonOverviewGoalsLow"("seasonYear"),
    FOREIGN KEY ("seasonYear") REFERENCES "teamsSeasonGoalsSummary"("seasonYear")
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "PlayerAwardWinnersByLeague" (
    "PlayerId" TEXT,
    "AwardName" TEXT,
    "AwardYear" INTEGER,
    "LeagueId" TEXT,
    "PlayerPosition" TEXT
);

CREATE TABLE "PlayerAwardsByLeagueAnnotated" (
    "PlayerId" TEXT,
    "AwardName" TEXT,
    "AwardYear" INTEGER,
    "LeagueId" TEXT,
    "AwardNote" TEXT,
    "PlayerPosition" TEXT
);

CREATE TABLE "AbbreviationMappings" (
    "AbbrevCategory" TEXT,
    "ShortCode" TEXT,
    "FullName" TEXT
);

