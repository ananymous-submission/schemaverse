-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/professional_basketball/professional_basketball.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "coach_awds" (
    "rec_id" INTEGER,
    "yr" INTEGER,
    "coach_key" TEXT,
    "awd_name" TEXT,
    "lg_key" TEXT,
    "awd_note" TEXT,
    FOREIGN KEY ("coach_key") REFERENCES "coach_st_midhigloss"("coach_key")
);

CREATE TABLE "coach_st_lowloss" (
    "coach_key" TEXT,
    "yr" INTEGER,
    "team_key" TEXT,
    "lg_key" TEXT,
    "stint_no" INTEGER,
    "wins" INTEGER,
    "losses" INTEGER,
    "po_wins" INTEGER,
    "po_losses" INTEGER,
    FOREIGN KEY ("team_key") REFERENCES "team_seas_arena"("team_key"),
    FOREIGN KEY ("team_key") REFERENCES "team_seas_split"("team_key"),
    FOREIGN KEY ("team_key") REFERENCES "team_seas_defpts"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_defpts"("yr")
);

CREATE TABLE "coach_st_midlowloss" (
    "coach_key" TEXT,
    "yr" INTEGER,
    "team_key" TEXT,
    "lg_key" TEXT,
    "stint_no" INTEGER,
    "wins" INTEGER,
    "losses" INTEGER,
    "po_wins" INTEGER,
    "po_losses" INTEGER,
    FOREIGN KEY ("team_key") REFERENCES "team_seas_split"("team_key"),
    FOREIGN KEY ("team_key") REFERENCES "team_seas_defpts"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_arena"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_defpts"("yr")
);

CREATE TABLE "coach_st_midhigloss" (
    "coach_key" TEXT,
    "yr" INTEGER,
    "team_key" TEXT,
    "lg_key" TEXT,
    "stint_no" INTEGER,
    "wins" INTEGER,
    "losses" INTEGER,
    "po_wins" INTEGER,
    "po_losses" INTEGER,
    FOREIGN KEY ("team_key") REFERENCES "team_seas_defpts"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_arena"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_split"("yr")
);

CREATE TABLE "coach_st_highloss" (
    "coach_key" TEXT,
    "yr" INTEGER,
    "team_key" TEXT,
    "lg_key" TEXT,
    "stint_no" INTEGER,
    "wins" INTEGER,
    "losses" INTEGER,
    "po_wins" INTEGER,
    "po_losses" INTEGER,
    FOREIGN KEY ("team_key") REFERENCES "team_seas_defpts"("team_key")
);

CREATE TABLE "series_post_cfr" (
    "rec_id" INTEGER,
    "yr" INTEGER,
    "rnd" TEXT,
    "series_tag" TEXT,
    "win_team" TEXT,
    "win_lg" TEXT,
    "lose_team" TEXT,
    "lose_lg" TEXT,
    "win_games" INTEGER,
    "loss_games" INTEGER,
    FOREIGN KEY ("lose_team") REFERENCES "team_seas_arena"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_defpts"("yr"),
    FOREIGN KEY ("win_team") REFERENCES "team_seas_split"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_arena"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_split"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_defpts"("yr")
);

CREATE TABLE "series_post_csf" (
    "rec_id" INTEGER,
    "yr" INTEGER,
    "rnd" TEXT,
    "series_tag" TEXT,
    "win_team" TEXT,
    "win_lg" TEXT,
    "lose_team" TEXT,
    "lose_lg" TEXT,
    "win_games" INTEGER,
    "loss_games" INTEGER,
    FOREIGN KEY ("lose_team") REFERENCES "team_seas_arena"("team_key"),
    FOREIGN KEY ("lose_team") REFERENCES "team_seas_split"("team_key"),
    FOREIGN KEY ("lose_team") REFERENCES "team_seas_defpts"("team_key"),
    FOREIGN KEY ("win_team") REFERENCES "team_seas_split"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_arena"("yr")
);

CREATE TABLE "series_post_dsf" (
    "rec_id" INTEGER,
    "yr" INTEGER,
    "rnd" TEXT,
    "series_tag" TEXT,
    "win_team" TEXT,
    "win_lg" TEXT,
    "lose_team" TEXT,
    "lose_lg" TEXT,
    "win_games" INTEGER,
    "loss_games" INTEGER,
    FOREIGN KEY ("yr") REFERENCES "team_seas_arena"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_defpts"("yr"),
    FOREIGN KEY ("win_team") REFERENCES "team_seas_split"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_split"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_defpts"("yr")
);

CREATE TABLE "series_post_cf_f" (
    "rec_id" INTEGER,
    "yr" INTEGER,
    "rnd" TEXT,
    "series_tag" TEXT,
    "win_team" TEXT,
    "win_lg" TEXT,
    "lose_team" TEXT,
    "lose_lg" TEXT,
    "win_games" INTEGER,
    "loss_games" INTEGER,
    FOREIGN KEY ("lose_team") REFERENCES "team_seas_arena"("team_key"),
    FOREIGN KEY ("lose_team") REFERENCES "team_seas_defpts"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_arena"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_split"("yr"),
    FOREIGN KEY ("win_team") REFERENCES "team_seas_defpts"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_arena"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_defpts"("yr")
);

CREATE TABLE "series_post_other" (
    "rec_id" INTEGER,
    "yr" INTEGER,
    "rnd" TEXT,
    "series_tag" TEXT,
    "win_team" TEXT,
    "win_lg" TEXT,
    "lose_team" TEXT,
    "lose_lg" TEXT,
    "win_games" INTEGER,
    "loss_games" INTEGER,
    FOREIGN KEY ("lose_team") REFERENCES "team_seas_split"("team_key"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_arena"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_split"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_defpts"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_arena"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_split"("yr"),
    FOREIGN KEY ("yr") REFERENCES "team_seas_defpts"("yr")
);

CREATE TABLE "team_seas_arena" (
    "yr" INTEGER,
    "team_key" TEXT,
    "arena_name" TEXT,
    "conf_key" TEXT,
    "conf_rank" INTEGER,
    "div_key" TEXT,
    "franch_key" TEXT,
    "g_played" INTEGER,
    "lg_key" TEXT,
    "team_name" TEXT,
    "opp_ftm" INTEGER,
    "playoff_flag" TEXT,
    "seas_rank" INTEGER
);

CREATE TABLE "team_seas_split" (
    "yr" INTEGER,
    "team_key" TEXT,
    "arena_name" TEXT,
    "away_losses" INTEGER,
    "away_wins" INTEGER,
    "franch_key" TEXT,
    "g_played" INTEGER,
    "home_losses" INTEGER,
    "home_wins" INTEGER,
    "lg_key" TEXT,
    "losses" INTEGER,
    "team_name" TEXT,
    "playoff_flag" TEXT,
    "seas_rank" INTEGER,
    "wins" INTEGER
);

CREATE TABLE "team_seas_defpts" (
    "yr" INTEGER,
    "team_key" TEXT,
    "def_pts" INTEGER,
    "opp_fgm" INTEGER,
    "opp_ftm" INTEGER,
    "opp_pts" INTEGER
);

CREATE TABLE "draft_pick_elite" (
    "rec_id" INTEGER DEFAULT 0,
    "pick_overall" INTEGER,
    "pick_round" INTEGER,
    "pick_slot" INTEGER,
    "pick_yr" INTEGER
);

CREATE TABLE "draft_pick_midrange_low" (
    "rec_id" INTEGER DEFAULT 0,
    "pick_overall" INTEGER,
    "pick_round" INTEGER,
    "pick_slot" INTEGER,
    "pick_yr" INTEGER
);

CREATE TABLE "draft_pick_midrange_high" (
    "rec_id" INTEGER DEFAULT 0,
    "pick_overall" INTEGER,
    "pick_round" INTEGER,
    "pick_slot" INTEGER,
    "pick_yr" INTEGER,
    FOREIGN KEY ("pick_yr") REFERENCES "team_seas_arena"("yr")
);

CREATE TABLE "draft_pick_late" (
    "rec_id" INTEGER DEFAULT 0,
    "pick_overall" INTEGER,
    "pick_round" INTEGER,
    "pick_slot" INTEGER,
    "pick_yr" INTEGER,
    FOREIGN KEY ("pick_yr") REFERENCES "team_seas_arena"("yr"),
    FOREIGN KEY ("pick_yr") REFERENCES "team_seas_split"("yr"),
    FOREIGN KEY ("pick_yr") REFERENCES "team_seas_defpts"("yr")
);

CREATE TABLE "player_post_box" (
    "rec_id" INTEGER,
    "pf_tot" INTEGER,
    "post_ast" INTEGER,
    "post_blk" INTEGER,
    "post_pf" INTEGER,
    "post_fg" INTEGER,
    "post_ft_att" INTEGER,
    "post_ft_made" INTEGER,
    "ast_tot" INTEGER,
    "fg_att" INTEGER,
    "fg_made" INTEGER,
    "ft_att" INTEGER,
    "ft_made" INTEGER,
    "pts_tot" INTEGER
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "PlayerAwards" (
    "PlayerId" TEXT,
    "AwardName" TEXT,
    "AwardYear" INTEGER,
    "LeagueCode" TEXT,
    "Notes" TEXT,
    "Position" TEXT,
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerCollegeDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerAlternateCollegeDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightAtMost74"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerHighSchoolDetails"("PlayerId")
);

CREATE TABLE "AllStarAssistSummary" (
    "PlayerId" TEXT,
    "SeasonId" INTEGER,
    "Assists" INTEGER,
    "Blocks" INTEGER,
    "Conference" TEXT,
    "GamesPlayed" INTEGER,
    "Minutes" INTEGER,
    "PersonalFouls" INTEGER,
    "Points" INTEGER,
    "Turnovers" INTEGER,
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerBirthDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerCollegeDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerAlternateCollegeDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightOver80OrNull"("PlayerId")
);

CREATE TABLE "AllStarAssistDetailWithFreeThrows" (
    "PlayerId" TEXT,
    "SeasonId" INTEGER,
    "Assists" INTEGER,
    "Blocks" INTEGER,
    "Conference" TEXT,
    "FreeThrowAttempts" INTEGER,
    "GamesPlayed" INTEGER,
    "Minutes" INTEGER,
    "PersonalFouls" INTEGER,
    "Points" INTEGER,
    "Steals" INTEGER,
    "Turnovers" INTEGER,
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerBirthDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerCollegeDetails"("PlayerId")
);

CREATE TABLE "AllStarDefensiveReboundSummary" (
    "PlayerId" TEXT,
    "SeasonId" INTEGER,
    "DefensiveRebounds" INTEGER,
    "OffensiveRebounds" INTEGER,
    "TotalRebounds" INTEGER,
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerBirthDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerCollegeDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerAlternateCollegeDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightOver74UpTo77"("PlayerId")
);

CREATE TABLE "AllStarFieldGoalAttemptsAtMostSix" (
    "PlayerId" TEXT,
    "SeasonId" INTEGER,
    "FieldGoalAttempts" INTEGER,
    "FieldGoalsMade" INTEGER,
    "FreeThrowAttempts" INTEGER,
    "FreeThrowsMade" INTEGER,
    "ThreePointAttempts" INTEGER,
    "ThreePointMakes" INTEGER,
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightAtMost74"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightOver74UpTo77"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightOver77UpTo80"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerHighSchoolDetails"("PlayerId")
);

CREATE TABLE "AllStarFieldGoalAttemptsOverSixUpToNine" (
    "PlayerId" TEXT,
    "SeasonId" INTEGER,
    "FieldGoalAttempts" INTEGER,
    "FieldGoalsMade" INTEGER,
    "FreeThrowAttempts" INTEGER,
    "FreeThrowsMade" INTEGER,
    "ThreePointAttempts" INTEGER,
    "ThreePointMakes" INTEGER,
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerAlternateCollegeDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightAtMost74"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerHighSchoolDetails"("PlayerId")
);

CREATE TABLE "AllStarFieldGoalAttemptsOverNineUpToTwelve" (
    "PlayerId" TEXT,
    "SeasonId" INTEGER,
    "FieldGoalAttempts" INTEGER,
    "FieldGoalsMade" INTEGER,
    "FreeThrowAttempts" INTEGER,
    "FreeThrowsMade" INTEGER,
    "ThreePointAttempts" INTEGER,
    "ThreePointMakes" INTEGER,
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerBirthDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightAtMost74"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightOver74UpTo77"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightOver77UpTo80"("PlayerId")
);

CREATE TABLE "AllStarFieldGoalAttemptsOverTwelveOrNull" (
    "PlayerId" TEXT,
    "SeasonId" INTEGER,
    "FieldGoalAttempts" INTEGER,
    "FieldGoalsMade" INTEGER,
    "FreeThrowAttempts" INTEGER,
    "FreeThrowsMade" INTEGER,
    "ThreePointAttempts" INTEGER,
    "ThreePointMakes" INTEGER,
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerAlternateCollegeDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightOver80OrNull"("PlayerId")
);

CREATE TABLE "AllStarPlayerNames" (
    "PlayerId" TEXT,
    "SeasonId" INTEGER,
    "FirstName" TEXT,
    "LastName" TEXT,
    "LeagueId" TEXT,
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerBirthDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerCollegeDetails"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerFirstSeasonHeightOver77UpTo80"("PlayerId"),
    FOREIGN KEY ("PlayerId") REFERENCES "PlayerHighSchoolDetails"("PlayerId")
);

CREATE TABLE "PlayerBirthDetails" (
    "PlayerId" TEXT,
    "BirthCity" TEXT,
    "BirthCountry" TEXT,
    "BirthDate" DATE,
    "BirthState" TEXT,
    "DeathDate" DATE
);

CREATE TABLE "PlayerCollegeDetails" (
    "PlayerId" TEXT,
    "College" TEXT,
    "AlternateCollege" TEXT,
    "DeathDate" DATE,
    "LastName" TEXT,
    "MiddleName" TEXT,
    "Nickname" TEXT,
    "NameSuffix" TEXT,
    "Position" TEXT,
    "Race" TEXT
);

CREATE TABLE "PlayerAlternateCollegeDetails" (
    "PlayerId" TEXT,
    "AlternateCollege" TEXT,
    "FirstName" TEXT,
    "FullGivenName" TEXT,
    "Height" REAL,
    "LastName" TEXT,
    "MiddleName" TEXT,
    "GivenName" TEXT,
    "Nickname" TEXT,
    "NameSuffix" TEXT,
    "Position" TEXT,
    "Race" TEXT,
    "UseFirstPreference" TEXT,
    "Weight" INTEGER
);

CREATE TABLE "PlayerFirstSeasonHeightAtMost74" (
    "PlayerId" TEXT,
    "FirstSeasonYear" INTEGER,
    "Height" REAL,
    "LastSeasonYear" INTEGER,
    "Weight" INTEGER
);

CREATE TABLE "PlayerFirstSeasonHeightOver74UpTo77" (
    "PlayerId" TEXT,
    "FirstSeasonYear" INTEGER,
    "Height" REAL,
    "LastSeasonYear" INTEGER,
    "Weight" INTEGER
);

CREATE TABLE "PlayerFirstSeasonHeightOver77UpTo80" (
    "PlayerId" TEXT,
    "FirstSeasonYear" INTEGER,
    "Height" REAL,
    "LastSeasonYear" INTEGER,
    "Weight" INTEGER
);

CREATE TABLE "PlayerFirstSeasonHeightOver80OrNull" (
    "PlayerId" TEXT,
    "FirstSeasonYear" INTEGER,
    "Height" REAL,
    "LastSeasonYear" INTEGER,
    "Weight" INTEGER
);

CREATE TABLE "PlayerHighSchoolDetails" (
    "PlayerId" TEXT,
    "HighSchoolName" TEXT,
    "HighSchoolCity" TEXT,
    "HighSchoolCountry" TEXT,
    "HighSchoolState" TEXT
);

CREATE TABLE "PlayerTeamGamesSummary" (
    "RecordId" INTEGER,
    "GamesPlayed" INTEGER,
    "GamesStarted" INTEGER,
    "Blocks" INTEGER,
    "LeagueCode" TEXT,
    "Minutes" INTEGER,
    "Note" TEXT,
    "PlayerId" TEXT NOT NULL,
    "Steals" INTEGER,
    "Stint" INTEGER,
    "TeamId" TEXT,
    "Turnovers" INTEGER,
    "SeasonYear" INTEGER
);

CREATE TABLE "PlayerTeamFieldGoalAttemptBreakdownPost" (
    "RecordId" INTEGER,
    "PostgameFieldGoalAttempts" INTEGER,
    "PostgameThreePointAttempts" INTEGER,
    "PostgameThreePointMakes" INTEGER,
    "FieldGoalAttempts" INTEGER,
    "FieldGoalsMade" INTEGER,
    "ThreePointAttempts" INTEGER,
    "ThreePointMakes" INTEGER
);

CREATE TABLE "PlayerTeamPostReboundsAtMostZero" (
    "RecordId" INTEGER,
    "PostgameRebounds" INTEGER,
    "PostgameDefensiveRebounds" INTEGER,
    "PostgameOffensiveRebounds" INTEGER,
    "DefensiveRebounds" INTEGER,
    "OffensiveRebounds" INTEGER,
    "TotalRebounds" INTEGER
);

CREATE TABLE "PlayerTeamPostReboundsGreaterThanZeroUpToTwelve" (
    "RecordId" INTEGER,
    "PostgameRebounds" INTEGER,
    "PostgameDefensiveRebounds" INTEGER,
    "PostgameOffensiveRebounds" INTEGER,
    "DefensiveRebounds" INTEGER,
    "OffensiveRebounds" INTEGER,
    "TotalRebounds" INTEGER
);

