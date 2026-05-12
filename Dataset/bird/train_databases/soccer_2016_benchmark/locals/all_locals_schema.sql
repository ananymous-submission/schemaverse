-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/soccer_2016/soccer_2016.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "extra_run_event_lte1" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "innings_index" INTEGER,
    "extra_runs_count" INTEGER,
    "extra_type_ref" INTEGER,
    FOREIGN KEY ("extra_type_ref") REFERENCES "extra_type_lookup"("extra_type_key")
);

CREATE TABLE "extra_run_event_gt1" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "innings_index" INTEGER,
    "extra_runs_count" INTEGER,
    "extra_type_ref" INTEGER,
    FOREIGN KEY ("extra_type_ref") REFERENCES "extra_type_lookup"("extra_type_key")
);

CREATE TABLE "extra_run_event_type_group" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "innings_index" INTEGER,
    "extra_type_ref" INTEGER,
    FOREIGN KEY ("extra_type_ref") REFERENCES "extra_type_lookup"("extra_type_key")
);

CREATE TABLE "extra_type_lookup" (
    "extra_type_key" INTEGER,
    "extra_type_label" TEXT
);

CREATE TABLE "match_summary_win_margin_lte6" (
    "match_key" INTEGER,
    "man_of_match_ref" INTEGER,
    "winning_team_ref" INTEGER,
    "result_type_ref" INTEGER,
    "Team_1" INTEGER,
    "team_ref" INTEGER,
    "toss_choice_ref" INTEGER,
    "toss_winner_ref" INTEGER,
    "win_margin_runs" INTEGER,
    FOREIGN KEY ("man_of_match_ref") REFERENCES "player_profile"("player_key")
);

CREATE TABLE "match_summary_win_margin_gt21_or_null" (
    "match_key" INTEGER,
    "man_of_match_ref" INTEGER,
    "winning_team_ref" INTEGER,
    "result_type_ref" INTEGER,
    "Team_1" INTEGER,
    "team_ref" INTEGER,
    "toss_choice_ref" INTEGER,
    "toss_winner_ref" INTEGER,
    "win_margin_runs" INTEGER,
    FOREIGN KEY ("man_of_match_ref") REFERENCES "player_profile"("player_key"),
    FOREIGN KEY ("toss_choice_ref") REFERENCES "toss_decision_lookup"("toss_choice_key"),
    FOREIGN KEY ("team_ref") REFERENCES "team_profile"("team_key")
);

CREATE TABLE "dismissal_type_lookup" (
    "dismissal_type_key" INTEGER,
    "dismissal_type_label" TEXT
);

CREATE TABLE "player_profile" (
    "player_key" INTEGER,
    "player_full_name" TEXT,
    "birth_date" DATE,
    "batting_hand_side" INTEGER,
    "bowling_skill_type" INTEGER,
    "country_key" INTEGER
);

CREATE TABLE "season_awards" (
    "season_key" INTEGER,
    "series_mvp_ref" INTEGER,
    "orange_cap_holder_ref" INTEGER,
    "purple_cap_holder_ref" INTEGER,
    "season_year_number" INTEGER
);

CREATE TABLE "team_profile" (
    "team_key" INTEGER,
    "team_display_name" TEXT
);

CREATE TABLE "toss_decision_lookup" (
    "toss_choice_key" INTEGER,
    "toss_choice_label" TEXT
);

CREATE TABLE "wicket_fielders_margin_gt21_or_null" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "innings_index" INTEGER,
    "fielder_player_ref" INTEGER,
    "dismissed_player_ref" INTEGER,
    FOREIGN KEY ("fielder_player_ref") REFERENCES "player_profile"("player_key"),
    FOREIGN KEY ("match_key") REFERENCES "match_summary_win_margin_gt21_or_null"("match_key")
);

CREATE TABLE "wicket_fielders_additional_margin_gt21_or_null" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "innings_index" INTEGER,
    "fielder_player_ref" INTEGER,
    "dismissal_kind_ref" INTEGER,
    "dismissed_player_ref" INTEGER,
    FOREIGN KEY ("fielder_player_ref") REFERENCES "player_profile"("player_key"),
    FOREIGN KEY ("dismissed_player_ref") REFERENCES "player_profile"("player_key")
);

CREATE TABLE "batsman_runs_gt0_lte1" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "runs_scored_count" INTEGER,
    "innings_index" INTEGER
);

CREATE TABLE "delivery_by_bowler_le_73" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "innings_index" INTEGER,
    "bowler_player_ref" INTEGER,
    "non_striker_player_ref" INTEGER,
    "striker_player_ref" INTEGER,
    FOREIGN KEY ("match_key") REFERENCES "match_summary_win_margin_lte6"("match_key"),
    FOREIGN KEY ("match_key") REFERENCES "match_summary_win_margin_gt21_or_null"("match_key")
);

CREATE TABLE "delivery_by_bowler_gt73_lte154" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "innings_index" INTEGER,
    "bowler_player_ref" INTEGER,
    "non_striker_player_ref" INTEGER,
    "striker_player_ref" INTEGER,
    FOREIGN KEY ("match_key") REFERENCES "match_summary_win_margin_lte6"("match_key")
);

CREATE TABLE "delivery_by_bowler_gt154_lte293" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "innings_index" INTEGER,
    "bowler_player_ref" INTEGER,
    "non_striker_player_ref" INTEGER,
    "striker_player_ref" INTEGER,
    FOREIGN KEY ("match_key") REFERENCES "match_summary_win_margin_lte6"("match_key")
);

CREATE TABLE "delivery_by_bowler_gt293_or_null" (
    "match_key" INTEGER,
    "over_number" INTEGER,
    "ball_number" INTEGER,
    "innings_index" INTEGER,
    "bowler_player_ref" INTEGER,
    "non_striker_player_ref" INTEGER,
    "striker_player_ref" INTEGER
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "BallDeliveryStrikerPosition" (
    "MatchId" INTEGER,
    "OverNumber" INTEGER,
    "BallNumber" INTEGER,
    "InningsNumber" INTEGER,
    "StrikerBattingPosition" INTEGER
);

CREATE TABLE "BallDeliveryBowler" (
    "MatchId" INTEGER,
    "OverNumber" INTEGER,
    "BallNumber" INTEGER,
    "InningsNumber" INTEGER,
    "BowlerPlayerId" INTEGER,
    "NonStrikerPlayerId" INTEGER,
    "StrikerPlayerId" INTEGER,
    "BattingTeamId" INTEGER,
    "BowlingTeamId" INTEGER
);

CREATE TABLE "CityDirectory" (
    "CityId" INTEGER,
    "CityName" TEXT,
    "CountryId" INTEGER
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "batsmanRunsNonPositive" (
    "matchId" INTEGER,
    "overNumber" INTEGER,
    "ballNumber" INTEGER,
    "runsScored" INTEGER,
    "inningsNumber" INTEGER
);

CREATE TABLE "batsmanRunsAboveOne" (
    "matchId" INTEGER,
    "overNumber" INTEGER,
    "ballNumber" INTEGER,
    "runsScored" INTEGER,
    "inningsNumber" INTEGER
);

CREATE TABLE "playOutcome" (
    "outcomeId" INTEGER,
    "outcomeCategory" TEXT
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "player_match_assoc" (
    "match_key_ref" INTEGER,
    "player_key" INTEGER,
    "role_key" INTEGER,
    "team_key" INTEGER,
    FOREIGN KEY ("match_key_ref") REFERENCES "match_summary_margin_gt8_lte21"("match_key")
);

CREATE TABLE "role_def" (
    "role_key" INTEGER,
    "role_label" TEXT
);

CREATE TABLE "match_summary_margin_gt6_lte8" (
    "match_key" INTEGER,
    "motm_id" INTEGER,
    "winner_team_id" INTEGER,
    "outcome_code" INTEGER,
    "team_a_id" INTEGER,
    "team_b_id" INTEGER,
    "toss_choice" INTEGER,
    "toss_winner_team" INTEGER,
    "win_margin_runs" INTEGER
);

CREATE TABLE "match_summary_margin_gt8_lte21" (
    "match_key" INTEGER,
    "motm_id" INTEGER,
    "winner_team_id" INTEGER,
    "outcome_code" INTEGER,
    "team_a_id" INTEGER,
    "team_b_id" INTEGER,
    "toss_choice" INTEGER,
    "toss_winner_team" INTEGER,
    "win_margin_runs" INTEGER
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "nation_registry" (
    "nation_id" INTEGER,
    "nation_name" TEXT
);

CREATE TABLE "match_official" (
    "official_id" INTEGER,
    "official_full_name" TEXT,
    "nation_id" INTEGER,
    FOREIGN KEY ("nation_id") REFERENCES "nation_registry"("nation_id")
);

-- ========================================================================
-- local_6
-- DDL file: local_6_schema.sql
-- ========================================================================

CREATE TABLE "bat_style" (
    "bat_id" INTEGER,
    "bat_hand" TEXT
);

CREATE TABLE "vnu_ref" (
    "vnu_id" INTEGER,
    "vnu_name" TEXT,
    "cty_id" INTEGER
);

CREATE TABLE "mch_sched" (
    "mch_id" INTEGER,
    "mch_date" DATE,
    "sea_id" INTEGER,
    "vnu_id" INTEGER,
    FOREIGN KEY ("vnu_id") REFERENCES "vnu_ref"("vnu_id")
);

-- ========================================================================
-- local_7
-- DDL file: local_7_schema.sql
-- ========================================================================

CREATE TABLE "bowl_style" (
    "bowl_id" INTEGER,
    "bowl_skill" TEXT
);

CREATE TABLE "win_basis" (
    "win_key" INTEGER,
    "win_kind" TEXT
);

CREATE TABLE "match_mvp" (
    "mtch_id" INTEGER,
    "mvp_player_id" INTEGER,
    "res_type" INTEGER,
    "toss_choice" INTEGER,
    "toss_winner_id" INTEGER,
    "win_margin" INTEGER,
    "win_basis_ref" INTEGER
);

