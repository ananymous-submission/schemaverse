-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";
ATTACH DATABASE 'local_6.sqlite' AS "local_6";
ATTACH DATABASE 'local_7.sqlite' AS "local_7";

-- Reconstruct Ball_by_Ball from vertical split + row partition on a fragment
CREATE VIEW "Ball_by_Ball" AS
SELECT t0.[match_key], t0.[over_number], t0.[ball_number], t0.[innings_index], t1.[BattingTeamId], t1.[BowlingTeamId], t2.[StrikerBattingPosition], t0.[striker_player_ref], t0.[non_striker_player_ref], t0.[bowler_player_ref]
FROM (
SELECT [delivery_by_bowler_gt154_lte293].[__orig_rowid] AS __orig_rowid, [local_1].[delivery_by_bowler_gt154_lte293].[match_key], [local_1].[delivery_by_bowler_gt154_lte293].[over_number], [local_1].[delivery_by_bowler_gt154_lte293].[ball_number], [local_1].[delivery_by_bowler_gt154_lte293].[innings_index], [local_1].[delivery_by_bowler_gt154_lte293].[striker_player_ref], [local_1].[delivery_by_bowler_gt154_lte293].[non_striker_player_ref], [local_1].[delivery_by_bowler_gt154_lte293].[bowler_player_ref] FROM [local_1].[delivery_by_bowler_gt154_lte293]
UNION
SELECT [delivery_by_bowler_gt293_or_null].[__orig_rowid] AS __orig_rowid, [local_1].[delivery_by_bowler_gt293_or_null].[match_key], [local_1].[delivery_by_bowler_gt293_or_null].[over_number], [local_1].[delivery_by_bowler_gt293_or_null].[ball_number], [local_1].[delivery_by_bowler_gt293_or_null].[innings_index], [local_1].[delivery_by_bowler_gt293_or_null].[striker_player_ref], [local_1].[delivery_by_bowler_gt293_or_null].[non_striker_player_ref], [local_1].[delivery_by_bowler_gt293_or_null].[bowler_player_ref] FROM [local_1].[delivery_by_bowler_gt293_or_null]
UNION
SELECT [delivery_by_bowler_gt73_lte154].[__orig_rowid] AS __orig_rowid, [local_1].[delivery_by_bowler_gt73_lte154].[match_key], [local_1].[delivery_by_bowler_gt73_lte154].[over_number], [local_1].[delivery_by_bowler_gt73_lte154].[ball_number], [local_1].[delivery_by_bowler_gt73_lte154].[innings_index], [local_1].[delivery_by_bowler_gt73_lte154].[striker_player_ref], [local_1].[delivery_by_bowler_gt73_lte154].[non_striker_player_ref], [local_1].[delivery_by_bowler_gt73_lte154].[bowler_player_ref] FROM [local_1].[delivery_by_bowler_gt73_lte154]
UNION
SELECT [delivery_by_bowler_le_73].[__orig_rowid] AS __orig_rowid, [local_1].[delivery_by_bowler_le_73].[match_key], [local_1].[delivery_by_bowler_le_73].[over_number], [local_1].[delivery_by_bowler_le_73].[ball_number], [local_1].[delivery_by_bowler_le_73].[innings_index], [local_1].[delivery_by_bowler_le_73].[striker_player_ref], [local_1].[delivery_by_bowler_le_73].[non_striker_player_ref], [local_1].[delivery_by_bowler_le_73].[bowler_player_ref] FROM [local_1].[delivery_by_bowler_le_73]
) t0
JOIN [local_2].[BallDeliveryBowler] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_2].[BallDeliveryStrikerPosition] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct Batsman_Scored from row partitions (UNION (overlap))
CREATE VIEW "Batsman_Scored" AS
SELECT "local_1"."batsman_runs_gt0_lte1"."match_key" AS "Match_Id", "local_1"."batsman_runs_gt0_lte1"."over_number" AS "Over_Id", "local_1"."batsman_runs_gt0_lte1"."ball_number" AS "Ball_Id", "local_1"."batsman_runs_gt0_lte1"."runs_scored_count" AS "Runs_Scored", "local_1"."batsman_runs_gt0_lte1"."innings_index" AS "Innings_No" FROM "local_1"."batsman_runs_gt0_lte1"
UNION
SELECT "local_3"."batsmanRunsNonPositive"."matchId" AS "Match_Id", "local_3"."batsmanRunsNonPositive"."overNumber" AS "Over_Id", "local_3"."batsmanRunsNonPositive"."ballNumber" AS "Ball_Id", "local_3"."batsmanRunsNonPositive"."runsScored" AS "Runs_Scored", "local_3"."batsmanRunsNonPositive"."inningsNumber" AS "Innings_No" FROM "local_3"."batsmanRunsNonPositive"
UNION
SELECT "local_3"."batsmanRunsAboveOne"."matchId" AS "Match_Id", "local_3"."batsmanRunsAboveOne"."overNumber" AS "Over_Id", "local_3"."batsmanRunsAboveOne"."ballNumber" AS "Ball_Id", "local_3"."batsmanRunsAboveOne"."runsScored" AS "Runs_Scored", "local_3"."batsmanRunsAboveOne"."inningsNumber" AS "Innings_No" FROM "local_3"."batsmanRunsAboveOne";

-- Reconstruct Batting_Style from local_6.bat_style
CREATE VIEW "Batting_Style" AS
SELECT
    "local_6"."bat_style"."bat_id" AS "Batting_Id",
    "local_6"."bat_style"."bat_hand" AS "Batting_hand"
FROM "local_6"."bat_style";

-- Reconstruct Bowling_Style from local_7.bowl_style
CREATE VIEW "Bowling_Style" AS
SELECT
    "local_7"."bowl_style"."bowl_id" AS "Bowling_Id",
    "local_7"."bowl_style"."bowl_skill" AS "Bowling_skill"
FROM "local_7"."bowl_style";

-- Reconstruct City from local_2.CityDirectory
CREATE VIEW "City" AS
SELECT
    "local_2"."CityDirectory"."CityId" AS "City_Id",
    "local_2"."CityDirectory"."CityName" AS "City_Name",
    "local_2"."CityDirectory"."CountryId" AS "Country_id"
FROM "local_2"."CityDirectory";

-- Reconstruct Country from local_5.nation_registry
CREATE VIEW "Country" AS
SELECT
    "local_5"."nation_registry"."nation_id" AS "Country_Id",
    "local_5"."nation_registry"."nation_name" AS "Country_Name"
FROM "local_5"."nation_registry";

-- Reconstruct Extra_Runs from vertical split + row partition on a fragment
CREATE VIEW "Extra_Runs" AS
SELECT t0.[match_key], t0.[over_number], t0.[ball_number], t0.[extra_type_ref], t0.[extra_runs_count], t0.[innings_index]
FROM (
SELECT [extra_run_event_gt1].[__orig_rowid] AS __orig_rowid, [local_1].[extra_run_event_gt1].[match_key], [local_1].[extra_run_event_gt1].[over_number], [local_1].[extra_run_event_gt1].[ball_number], [local_1].[extra_run_event_gt1].[extra_type_ref], [local_1].[extra_run_event_gt1].[extra_runs_count], [local_1].[extra_run_event_gt1].[innings_index] FROM [local_1].[extra_run_event_gt1]
UNION
SELECT [extra_run_event_lte1].[__orig_rowid] AS __orig_rowid, [local_1].[extra_run_event_lte1].[match_key], [local_1].[extra_run_event_lte1].[over_number], [local_1].[extra_run_event_lte1].[ball_number], [local_1].[extra_run_event_lte1].[extra_type_ref], [local_1].[extra_run_event_lte1].[extra_runs_count], [local_1].[extra_run_event_lte1].[innings_index] FROM [local_1].[extra_run_event_lte1]
) t0
JOIN [local_1].[extra_run_event_type_group] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct Extra_Type from local_1.extra_type_lookup
CREATE VIEW "Extra_Type" AS
SELECT
    "local_1"."extra_type_lookup"."extra_type_key" AS "Extra_Id",
    "local_1"."extra_type_lookup"."extra_type_label" AS "Extra_Name"
FROM "local_1"."extra_type_lookup";

-- Reconstruct Match from vertical split + row partition on a fragment
CREATE VIEW "Match" AS
SELECT t0.[match_key], t0.[Team_1], t0.[team_ref], t2.[mch_date], t2.[sea_id], t2.[vnu_id], t0.[toss_winner_ref], t0.[toss_choice_ref], t1.[win_basis_ref], t0.[win_margin_runs], t0.[result_type_ref], t0.[winning_team_ref], t0.[man_of_match_ref]
FROM (
SELECT [match_summary_win_margin_gt21_or_null].[__orig_rowid] AS __orig_rowid, [local_1].[match_summary_win_margin_gt21_or_null].[match_key], [local_1].[match_summary_win_margin_gt21_or_null].[team_ref], [local_1].[match_summary_win_margin_gt21_or_null].[toss_winner_ref], [local_1].[match_summary_win_margin_gt21_or_null].[toss_choice_ref], [local_1].[match_summary_win_margin_gt21_or_null].[win_margin_runs], [local_1].[match_summary_win_margin_gt21_or_null].[result_type_ref], [local_1].[match_summary_win_margin_gt21_or_null].[winning_team_ref], [local_1].[match_summary_win_margin_gt21_or_null].[man_of_match_ref] FROM [local_1].[match_summary_win_margin_gt21_or_null]
UNION
SELECT [match_summary_win_margin_lte6].[__orig_rowid] AS __orig_rowid, [local_1].[match_summary_win_margin_lte6].[match_key], [local_1].[match_summary_win_margin_lte6].[team_ref], [local_1].[match_summary_win_margin_lte6].[toss_winner_ref], [local_1].[match_summary_win_margin_lte6].[toss_choice_ref], [local_1].[match_summary_win_margin_lte6].[win_margin_runs], [local_1].[match_summary_win_margin_lte6].[result_type_ref], [local_1].[match_summary_win_margin_lte6].[winning_team_ref], [local_1].[match_summary_win_margin_lte6].[man_of_match_ref] FROM [local_1].[match_summary_win_margin_lte6]
UNION
SELECT [match_summary_margin_gt6_lte8].[__orig_rowid] AS __orig_rowid, [local_4].[match_summary_margin_gt6_lte8].[match_key], [local_4].[match_summary_margin_gt6_lte8].[team_a_id], [local_4].[match_summary_margin_gt6_lte8].[team_b_id], [local_4].[match_summary_margin_gt6_lte8].[toss_winner_team], [local_4].[match_summary_margin_gt6_lte8].[toss_choice], [local_4].[match_summary_margin_gt6_lte8].[win_margin_runs], [local_4].[match_summary_margin_gt6_lte8].[outcome_code], [local_4].[match_summary_margin_gt6_lte8].[winner_team_id], [local_4].[match_summary_margin_gt6_lte8].[motm_id] FROM [local_4].[match_summary_margin_gt6_lte8]
UNION
SELECT [match_summary_margin_gt8_lte21].[__orig_rowid] AS __orig_rowid, [local_4].[match_summary_margin_gt8_lte21].[match_key], [local_4].[match_summary_margin_gt8_lte21].[team_a_id], [local_4].[match_summary_margin_gt8_lte21].[team_b_id], [local_4].[match_summary_margin_gt8_lte21].[toss_winner_team], [local_4].[match_summary_margin_gt8_lte21].[toss_choice], [local_4].[match_summary_margin_gt8_lte21].[win_margin_runs], [local_4].[match_summary_margin_gt8_lte21].[outcome_code], [local_4].[match_summary_margin_gt8_lte21].[winner_team_id], [local_4].[match_summary_margin_gt8_lte21].[motm_id] FROM [local_4].[match_summary_margin_gt8_lte21]
) t0
JOIN [local_7].[match_mvp] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_6].[mch_sched] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct Out_Type from local_1.dismissal_type_lookup
CREATE VIEW "Out_Type" AS
SELECT
    "local_1"."dismissal_type_lookup"."dismissal_type_key" AS "Out_Id",
    "local_1"."dismissal_type_lookup"."dismissal_type_label" AS "Out_Name"
FROM "local_1"."dismissal_type_lookup";

-- Reconstruct Outcome from local_3.playOutcome
CREATE VIEW "Outcome" AS
SELECT
    "local_3"."playOutcome"."outcomeId" AS "Outcome_Id",
    "local_3"."playOutcome"."outcomeCategory" AS "Outcome_Type"
FROM "local_3"."playOutcome";

-- Reconstruct Player from local_1.player_profile
CREATE VIEW "Player" AS
SELECT
    "local_1"."player_profile"."player_key" AS "Player_Id",
    "local_1"."player_profile"."player_full_name" AS "Player_Name",
    "local_1"."player_profile"."birth_date" AS "DOB",
    "local_1"."player_profile"."batting_hand_side" AS "Batting_hand",
    "local_1"."player_profile"."bowling_skill_type" AS "Bowling_skill",
    "local_1"."player_profile"."country_key" AS "Country_Name"
FROM "local_1"."player_profile";

-- Reconstruct Player_Match from local_4.player_match_assoc
CREATE VIEW "Player_Match" AS
SELECT
    "local_4"."player_match_assoc"."match_key_ref" AS "Match_Id",
    "local_4"."player_match_assoc"."player_key" AS "Player_Id",
    "local_4"."player_match_assoc"."role_key" AS "Role_Id",
    "local_4"."player_match_assoc"."team_key" AS "Team_Id"
FROM "local_4"."player_match_assoc";

-- Reconstruct Rolee from local_4.role_def
CREATE VIEW "Rolee" AS
SELECT
    "local_4"."role_def"."role_key" AS "Role_Id",
    "local_4"."role_def"."role_label" AS "Role_Desc"
FROM "local_4"."role_def";

-- Reconstruct Season from local_1.season_awards
CREATE VIEW "Season" AS
SELECT
    "local_1"."season_awards"."season_key" AS "Season_Id",
    "local_1"."season_awards"."series_mvp_ref" AS "Man_of_the_Series",
    "local_1"."season_awards"."orange_cap_holder_ref" AS "Orange_Cap",
    "local_1"."season_awards"."purple_cap_holder_ref" AS "Purple_Cap",
    "local_1"."season_awards"."season_year_number" AS "Season_Year"
FROM "local_1"."season_awards";

-- Reconstruct Team from local_1.team_profile
CREATE VIEW "Team" AS
SELECT
    "local_1"."team_profile"."team_key" AS "Team_Id",
    "local_1"."team_profile"."team_display_name" AS "Team_Name"
FROM "local_1"."team_profile";

-- Reconstruct Toss_Decision from local_1.toss_decision_lookup
CREATE VIEW "Toss_Decision" AS
SELECT
    "local_1"."toss_decision_lookup"."toss_choice_key" AS "Toss_Id",
    "local_1"."toss_decision_lookup"."toss_choice_label" AS "Toss_Name"
FROM "local_1"."toss_decision_lookup";

-- Reconstruct Umpire from local_5.match_official
CREATE VIEW "Umpire" AS
SELECT
    "local_5"."match_official"."official_id" AS "Umpire_Id",
    "local_5"."match_official"."official_full_name" AS "Umpire_Name",
    "local_5"."match_official"."nation_id" AS "Umpire_Country"
FROM "local_5"."match_official";

-- Reconstruct Venue from local_6.vnu_ref
CREATE VIEW "Venue" AS
SELECT
    "local_6"."vnu_ref"."vnu_id" AS "Venue_Id",
    "local_6"."vnu_ref"."vnu_name" AS "Venue_Name",
    "local_6"."vnu_ref"."cty_id" AS "City_Id"
FROM "local_6"."vnu_ref";

-- Reconstruct Wicket_Taken from vertical (column) split (2 fragments)
CREATE VIEW "Wicket_Taken" AS
SELECT
    t0."match_key" AS "Match_Id",
    t0."over_number" AS "Over_Id",
    t0."ball_number" AS "Ball_Id",
    t0."dismissed_player_ref" AS "Player_Out",
    t0."dismissal_kind_ref" AS "Kind_Out",
    t0."fielder_player_ref" AS "Fielders",
    t0."innings_index" AS "Innings_No"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "match_key", "over_number", "ball_number", "innings_index" ORDER BY rowid) AS __rn FROM "local_1"."wicket_fielders_additional_margin_gt21_or_null") t0
JOIN "local_1"."wicket_fielders_margin_gt21_or_null" t1 ON t0."match_key" IS t1."match_key" AND t0."over_number" IS t1."over_number" AND t0."ball_number" IS t1."ball_number" AND t0."innings_index" IS t1."innings_index" AND t0.__rn = t1.__rn;

-- Reconstruct Win_By from local_7.win_basis
CREATE VIEW "Win_By" AS
SELECT
    "local_7"."win_basis"."win_key" AS "Win_Id",
    "local_7"."win_basis"."win_kind" AS "Win_Type"
FROM "local_7"."win_basis";
