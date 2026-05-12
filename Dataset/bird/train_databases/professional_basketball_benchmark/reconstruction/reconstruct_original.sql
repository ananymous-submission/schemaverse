-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct awards_coaches from local_1.coach_awds
CREATE VIEW "awards_coaches" AS
SELECT
    "local_1"."coach_awds"."rec_id" AS "id",
    "local_1"."coach_awds"."yr" AS "year",
    "local_1"."coach_awds"."coach_key" AS "coachID",
    "local_1"."coach_awds"."awd_name" AS "award",
    "local_1"."coach_awds"."lg_key" AS "lgID",
    "local_1"."coach_awds"."awd_note" AS "note"
FROM "local_1"."coach_awds";

-- Reconstruct awards_players from local_3.PlayerAwards
CREATE VIEW "awards_players" AS
SELECT
    "local_3"."PlayerAwards"."PlayerId" AS "playerID",
    "local_3"."PlayerAwards"."AwardName" AS "award",
    "local_3"."PlayerAwards"."AwardYear" AS "year",
    "local_3"."PlayerAwards"."LeagueCode" AS "lgID",
    "local_3"."PlayerAwards"."Notes" AS "note",
    "local_3"."PlayerAwards"."Position" AS "pos"
FROM "local_3"."PlayerAwards";

-- Reconstruct coaches from row partitions (UNION (overlap))
CREATE VIEW "coaches" AS
SELECT "local_1"."coach_st_lowloss"."coach_key" AS "coachID", "local_1"."coach_st_lowloss"."yr" AS "year", "local_1"."coach_st_lowloss"."team_key" AS "tmID", "local_1"."coach_st_lowloss"."lg_key" AS "lgID", "local_1"."coach_st_lowloss"."stint_no" AS "stint", "local_1"."coach_st_lowloss"."wins" AS "won", "local_1"."coach_st_lowloss"."losses" AS "lost", "local_1"."coach_st_lowloss"."po_wins" AS "post_wins", "local_1"."coach_st_lowloss"."po_losses" AS "post_losses" FROM "local_1"."coach_st_lowloss"
UNION
SELECT "local_1"."coach_st_midlowloss"."coach_key" AS "coachID", "local_1"."coach_st_midlowloss"."yr" AS "year", "local_1"."coach_st_midlowloss"."team_key" AS "tmID", "local_1"."coach_st_midlowloss"."lg_key" AS "lgID", "local_1"."coach_st_midlowloss"."stint_no" AS "stint", "local_1"."coach_st_midlowloss"."wins" AS "won", "local_1"."coach_st_midlowloss"."losses" AS "lost", "local_1"."coach_st_midlowloss"."po_wins" AS "post_wins", "local_1"."coach_st_midlowloss"."po_losses" AS "post_losses" FROM "local_1"."coach_st_midlowloss"
UNION
SELECT "local_1"."coach_st_midhigloss"."coach_key" AS "coachID", "local_1"."coach_st_midhigloss"."yr" AS "year", "local_1"."coach_st_midhigloss"."team_key" AS "tmID", "local_1"."coach_st_midhigloss"."lg_key" AS "lgID", "local_1"."coach_st_midhigloss"."stint_no" AS "stint", "local_1"."coach_st_midhigloss"."wins" AS "won", "local_1"."coach_st_midhigloss"."losses" AS "lost", "local_1"."coach_st_midhigloss"."po_wins" AS "post_wins", "local_1"."coach_st_midhigloss"."po_losses" AS "post_losses" FROM "local_1"."coach_st_midhigloss"
UNION
SELECT "local_1"."coach_st_highloss"."coach_key" AS "coachID", "local_1"."coach_st_highloss"."yr" AS "year", "local_1"."coach_st_highloss"."team_key" AS "tmID", "local_1"."coach_st_highloss"."lg_key" AS "lgID", "local_1"."coach_st_highloss"."stint_no" AS "stint", "local_1"."coach_st_highloss"."wins" AS "won", "local_1"."coach_st_highloss"."losses" AS "lost", "local_1"."coach_st_highloss"."po_wins" AS "post_wins", "local_1"."coach_st_highloss"."po_losses" AS "post_losses" FROM "local_1"."coach_st_highloss";

-- Reconstruct draft from vertical split + row partition on a fragment
CREATE VIEW "draft" AS
SELECT t0.[rec_id], t0.[pick_yr], t0.[pick_round], t0.[pick_slot], t0.[pick_overall], t2.[team_id], t1.[name], t1.[last_name], t1.[suffix_name], t1.[player_id], t1.[draft_origin], t2.[league_id]
FROM (
SELECT [draft_pick_elite].[__orig_rowid] AS __orig_rowid, [local_1].[draft_pick_elite].[rec_id], [local_1].[draft_pick_elite].[pick_yr], [local_1].[draft_pick_elite].[pick_round], [local_1].[draft_pick_elite].[pick_slot], [local_1].[draft_pick_elite].[pick_overall] FROM [local_1].[draft_pick_elite]
UNION
SELECT [draft_pick_late].[__orig_rowid] AS __orig_rowid, [local_1].[draft_pick_late].[rec_id], [local_1].[draft_pick_late].[pick_yr], [local_1].[draft_pick_late].[pick_round], [local_1].[draft_pick_late].[pick_slot], [local_1].[draft_pick_late].[pick_overall] FROM [local_1].[draft_pick_late]
UNION
SELECT [draft_pick_midrange_high].[__orig_rowid] AS __orig_rowid, [local_1].[draft_pick_midrange_high].[rec_id], [local_1].[draft_pick_midrange_high].[pick_yr], [local_1].[draft_pick_midrange_high].[pick_round], [local_1].[draft_pick_midrange_high].[pick_slot], [local_1].[draft_pick_midrange_high].[pick_overall] FROM [local_1].[draft_pick_midrange_high]
UNION
SELECT [draft_pick_midrange_low].[__orig_rowid] AS __orig_rowid, [local_1].[draft_pick_midrange_low].[rec_id], [local_1].[draft_pick_midrange_low].[pick_yr], [local_1].[draft_pick_midrange_low].[pick_round], [local_1].[draft_pick_midrange_low].[pick_slot], [local_1].[draft_pick_midrange_low].[pick_overall] FROM [local_1].[draft_pick_midrange_low]
) t0
JOIN [local_2].[draft_source_entries] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_2].[draft_selection_records] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct player_allstar from vertical split + row partition on a fragment
CREATE VIEW "player_allstar" AS
SELECT t0.[PlayerId], t4.[LastName], t4.[FirstName], t0.[SeasonId], t0.[Conference], t4.[LeagueId], t0.[GamesPlayed], t0.[Minutes], t0.[Points], t2.[OffensiveRebounds], t2.[DefensiveRebounds], t2.[TotalRebounds], t0.[Assists], t1.[Steals], t0.[Blocks], t0.[Turnovers], t0.[PersonalFouls], t3.[FieldGoalAttempts], t3.[FieldGoalsMade], t1.[FreeThrowAttempts], t3.[FreeThrowsMade], t3.[ThreePointAttempts], t3.[ThreePointMakes]
FROM [local_3].[AllStarAssistSummary] t0
JOIN [local_3].[AllStarAssistDetailWithFreeThrows] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_3].[AllStarDefensiveReboundSummary] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN (
SELECT [AllStarFieldGoalAttemptsAtMostSix].[__orig_rowid] AS __orig_rowid, [local_3].[AllStarFieldGoalAttemptsAtMostSix].[PlayerId], [local_3].[AllStarFieldGoalAttemptsAtMostSix].[SeasonId], [local_3].[AllStarFieldGoalAttemptsAtMostSix].[FieldGoalAttempts], [local_3].[AllStarFieldGoalAttemptsAtMostSix].[FieldGoalsMade], [local_3].[AllStarFieldGoalAttemptsAtMostSix].[FreeThrowAttempts], [local_3].[AllStarFieldGoalAttemptsAtMostSix].[FreeThrowsMade], [local_3].[AllStarFieldGoalAttemptsAtMostSix].[ThreePointAttempts], [local_3].[AllStarFieldGoalAttemptsAtMostSix].[ThreePointMakes] FROM [local_3].[AllStarFieldGoalAttemptsAtMostSix]
UNION
SELECT [AllStarFieldGoalAttemptsOverNineUpToTwelve].[__orig_rowid] AS __orig_rowid, [local_3].[AllStarFieldGoalAttemptsOverNineUpToTwelve].[PlayerId], [local_3].[AllStarFieldGoalAttemptsOverNineUpToTwelve].[SeasonId], [local_3].[AllStarFieldGoalAttemptsOverNineUpToTwelve].[FieldGoalAttempts], [local_3].[AllStarFieldGoalAttemptsOverNineUpToTwelve].[FieldGoalsMade], [local_3].[AllStarFieldGoalAttemptsOverNineUpToTwelve].[FreeThrowAttempts], [local_3].[AllStarFieldGoalAttemptsOverNineUpToTwelve].[FreeThrowsMade], [local_3].[AllStarFieldGoalAttemptsOverNineUpToTwelve].[ThreePointAttempts], [local_3].[AllStarFieldGoalAttemptsOverNineUpToTwelve].[ThreePointMakes] FROM [local_3].[AllStarFieldGoalAttemptsOverNineUpToTwelve]
UNION
SELECT [AllStarFieldGoalAttemptsOverSixUpToNine].[__orig_rowid] AS __orig_rowid, [local_3].[AllStarFieldGoalAttemptsOverSixUpToNine].[PlayerId], [local_3].[AllStarFieldGoalAttemptsOverSixUpToNine].[SeasonId], [local_3].[AllStarFieldGoalAttemptsOverSixUpToNine].[FieldGoalAttempts], [local_3].[AllStarFieldGoalAttemptsOverSixUpToNine].[FieldGoalsMade], [local_3].[AllStarFieldGoalAttemptsOverSixUpToNine].[FreeThrowAttempts], [local_3].[AllStarFieldGoalAttemptsOverSixUpToNine].[FreeThrowsMade], [local_3].[AllStarFieldGoalAttemptsOverSixUpToNine].[ThreePointAttempts], [local_3].[AllStarFieldGoalAttemptsOverSixUpToNine].[ThreePointMakes] FROM [local_3].[AllStarFieldGoalAttemptsOverSixUpToNine]
UNION
SELECT [AllStarFieldGoalAttemptsOverTwelveOrNull].[__orig_rowid] AS __orig_rowid, [local_3].[AllStarFieldGoalAttemptsOverTwelveOrNull].[PlayerId], [local_3].[AllStarFieldGoalAttemptsOverTwelveOrNull].[SeasonId], [local_3].[AllStarFieldGoalAttemptsOverTwelveOrNull].[FieldGoalAttempts], [local_3].[AllStarFieldGoalAttemptsOverTwelveOrNull].[FieldGoalsMade], [local_3].[AllStarFieldGoalAttemptsOverTwelveOrNull].[FreeThrowAttempts], [local_3].[AllStarFieldGoalAttemptsOverTwelveOrNull].[FreeThrowsMade], [local_3].[AllStarFieldGoalAttemptsOverTwelveOrNull].[ThreePointAttempts], [local_3].[AllStarFieldGoalAttemptsOverTwelveOrNull].[ThreePointMakes] FROM [local_3].[AllStarFieldGoalAttemptsOverTwelveOrNull]
) t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_3].[AllStarPlayerNames] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct players from vertical split + row partition on a fragment
CREATE VIEW "players" AS
SELECT t0.[PlayerId], t2.[UseFirstPreference], t2.[FirstName], t1.[MiddleName], t1.[LastName], t2.[GivenName], t2.[FullGivenName], t1.[NameSuffix], t1.[Nickname], t1.[Position], t3.[FirstSeasonYear], t3.[LastSeasonYear], t2.[Height], t2.[Weight], t1.[College], t1.[AlternateCollege], t0.[BirthDate], t0.[BirthCity], t0.[BirthState], t0.[BirthCountry], t4.[HighSchoolName], t4.[HighSchoolCity], t4.[HighSchoolState], t4.[HighSchoolCountry], t0.[DeathDate], t1.[Race]
FROM [local_3].[PlayerBirthDetails] t0
JOIN [local_3].[PlayerCollegeDetails] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_3].[PlayerAlternateCollegeDetails] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN (
SELECT [PlayerFirstSeasonHeightAtMost74].[__orig_rowid] AS __orig_rowid, [local_3].[PlayerFirstSeasonHeightAtMost74].[PlayerId], [local_3].[PlayerFirstSeasonHeightAtMost74].[FirstSeasonYear], [local_3].[PlayerFirstSeasonHeightAtMost74].[LastSeasonYear], [local_3].[PlayerFirstSeasonHeightAtMost74].[Height], [local_3].[PlayerFirstSeasonHeightAtMost74].[Weight] FROM [local_3].[PlayerFirstSeasonHeightAtMost74]
UNION
SELECT [PlayerFirstSeasonHeightOver74UpTo77].[__orig_rowid] AS __orig_rowid, [local_3].[PlayerFirstSeasonHeightOver74UpTo77].[PlayerId], [local_3].[PlayerFirstSeasonHeightOver74UpTo77].[FirstSeasonYear], [local_3].[PlayerFirstSeasonHeightOver74UpTo77].[LastSeasonYear], [local_3].[PlayerFirstSeasonHeightOver74UpTo77].[Height], [local_3].[PlayerFirstSeasonHeightOver74UpTo77].[Weight] FROM [local_3].[PlayerFirstSeasonHeightOver74UpTo77]
UNION
SELECT [PlayerFirstSeasonHeightOver77UpTo80].[__orig_rowid] AS __orig_rowid, [local_3].[PlayerFirstSeasonHeightOver77UpTo80].[PlayerId], [local_3].[PlayerFirstSeasonHeightOver77UpTo80].[FirstSeasonYear], [local_3].[PlayerFirstSeasonHeightOver77UpTo80].[LastSeasonYear], [local_3].[PlayerFirstSeasonHeightOver77UpTo80].[Height], [local_3].[PlayerFirstSeasonHeightOver77UpTo80].[Weight] FROM [local_3].[PlayerFirstSeasonHeightOver77UpTo80]
UNION
SELECT [PlayerFirstSeasonHeightOver80OrNull].[__orig_rowid] AS __orig_rowid, [local_3].[PlayerFirstSeasonHeightOver80OrNull].[PlayerId], [local_3].[PlayerFirstSeasonHeightOver80OrNull].[FirstSeasonYear], [local_3].[PlayerFirstSeasonHeightOver80OrNull].[LastSeasonYear], [local_3].[PlayerFirstSeasonHeightOver80OrNull].[Height], [local_3].[PlayerFirstSeasonHeightOver80OrNull].[Weight] FROM [local_3].[PlayerFirstSeasonHeightOver80OrNull]
) t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_3].[PlayerHighSchoolDetails] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct players_teams from vertical split + row partition on a fragment
CREATE VIEW "players_teams" AS
SELECT t0.[player_team_stats_id], t1.[PlayerId], t0.[season_year], t0.[stint_number], t1.[TeamId], t1.[LeagueCode], t0.[season_games_played], t0.[season_games_started], t0.[season_minutes], t0.[season_points], t4.[offensive_rebounds], t4.[defensive_rebounds], t4.[total_rebounds], t0.[season_assists], t0.[season_steals], t0.[season_blocks], t0.[season_turnovers], t0.[season_personal_fouls], t2.[fg_att], t2.[fg_made], t2.[ft_att], t2.[ft_made], t3.[ThreePointAttempts], t3.[ThreePointMakes], t0.[post_games_played], t0.[post_games_started], t0.[post_minutes], t0.[post_points], t4.[post_offensive_rebounds], t4.[post_defensive_rebounds], t4.[post_rebounds], t0.[post_assists], t0.[post_steals], t0.[post_blocks], t0.[post_turnovers], t0.[post_personal_fouls], t3.[PostgameFieldGoalAttempts], t2.[post_fg], t2.[post_ft_att], t2.[post_ft_made], t3.[PostgameThreePointAttempts], t3.[PostgameThreePointMakes], t0.[notes]
FROM [local_2].[player_team_season_stats] t0
JOIN [local_3].[PlayerTeamGamesSummary] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[player_post_box] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_3].[PlayerTeamFieldGoalAttemptBreakdownPost] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN (
SELECT [player_team_post_rebounds_top].[__orig_rowid] AS __orig_rowid, [local_2].[player_team_post_rebounds_top].[post_rebounds_top_id], [local_2].[player_team_post_rebounds_top].[offensive_rebounds], [local_2].[player_team_post_rebounds_top].[defensive_rebounds], [local_2].[player_team_post_rebounds_top].[total_rebounds], [local_2].[player_team_post_rebounds_top].[post_offensive_rebounds], [local_2].[player_team_post_rebounds_top].[post_defensive_rebounds], [local_2].[player_team_post_rebounds_top].[post_rebounds] FROM [local_2].[player_team_post_rebounds_top]
UNION
SELECT [PlayerTeamPostReboundsAtMostZero].[__orig_rowid] AS __orig_rowid, [local_3].[PlayerTeamPostReboundsAtMostZero].[RecordId], [local_3].[PlayerTeamPostReboundsAtMostZero].[OffensiveRebounds], [local_3].[PlayerTeamPostReboundsAtMostZero].[DefensiveRebounds], [local_3].[PlayerTeamPostReboundsAtMostZero].[TotalRebounds], [local_3].[PlayerTeamPostReboundsAtMostZero].[PostgameOffensiveRebounds], [local_3].[PlayerTeamPostReboundsAtMostZero].[PostgameDefensiveRebounds], [local_3].[PlayerTeamPostReboundsAtMostZero].[PostgameRebounds] FROM [local_3].[PlayerTeamPostReboundsAtMostZero]
UNION
SELECT [PlayerTeamPostReboundsGreaterThanZeroUpToTwelve].[__orig_rowid] AS __orig_rowid, [local_3].[PlayerTeamPostReboundsGreaterThanZeroUpToTwelve].[RecordId], [local_3].[PlayerTeamPostReboundsGreaterThanZeroUpToTwelve].[OffensiveRebounds], [local_3].[PlayerTeamPostReboundsGreaterThanZeroUpToTwelve].[DefensiveRebounds], [local_3].[PlayerTeamPostReboundsGreaterThanZeroUpToTwelve].[TotalRebounds], [local_3].[PlayerTeamPostReboundsGreaterThanZeroUpToTwelve].[PostgameOffensiveRebounds], [local_3].[PlayerTeamPostReboundsGreaterThanZeroUpToTwelve].[PostgameDefensiveRebounds], [local_3].[PlayerTeamPostReboundsGreaterThanZeroUpToTwelve].[PostgameRebounds] FROM [local_3].[PlayerTeamPostReboundsGreaterThanZeroUpToTwelve]
) t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct series_post from row partitions (UNION (overlap))
CREATE VIEW "series_post" AS
SELECT "local_1"."series_post_cfr"."rec_id" AS "id", "local_1"."series_post_cfr"."yr" AS "year", "local_1"."series_post_cfr"."rnd" AS "round", "local_1"."series_post_cfr"."series_tag" AS "series", "local_1"."series_post_cfr"."win_team" AS "tmIDWinner", "local_1"."series_post_cfr"."win_lg" AS "lgIDWinner", "local_1"."series_post_cfr"."lose_team" AS "tmIDLoser", "local_1"."series_post_cfr"."lose_lg" AS "lgIDLoser", "local_1"."series_post_cfr"."win_games" AS "W", "local_1"."series_post_cfr"."loss_games" AS "L" FROM "local_1"."series_post_cfr"
UNION
SELECT "local_1"."series_post_csf"."rec_id" AS "id", "local_1"."series_post_csf"."yr" AS "year", "local_1"."series_post_csf"."rnd" AS "round", "local_1"."series_post_csf"."series_tag" AS "series", "local_1"."series_post_csf"."win_team" AS "tmIDWinner", "local_1"."series_post_csf"."win_lg" AS "lgIDWinner", "local_1"."series_post_csf"."lose_team" AS "tmIDLoser", "local_1"."series_post_csf"."lose_lg" AS "lgIDLoser", "local_1"."series_post_csf"."win_games" AS "W", "local_1"."series_post_csf"."loss_games" AS "L" FROM "local_1"."series_post_csf"
UNION
SELECT "local_1"."series_post_dsf"."rec_id" AS "id", "local_1"."series_post_dsf"."yr" AS "year", "local_1"."series_post_dsf"."rnd" AS "round", "local_1"."series_post_dsf"."series_tag" AS "series", "local_1"."series_post_dsf"."win_team" AS "tmIDWinner", "local_1"."series_post_dsf"."win_lg" AS "lgIDWinner", "local_1"."series_post_dsf"."lose_team" AS "tmIDLoser", "local_1"."series_post_dsf"."lose_lg" AS "lgIDLoser", "local_1"."series_post_dsf"."win_games" AS "W", "local_1"."series_post_dsf"."loss_games" AS "L" FROM "local_1"."series_post_dsf"
UNION
SELECT "local_1"."series_post_cf_f"."rec_id" AS "id", "local_1"."series_post_cf_f"."yr" AS "year", "local_1"."series_post_cf_f"."rnd" AS "round", "local_1"."series_post_cf_f"."series_tag" AS "series", "local_1"."series_post_cf_f"."win_team" AS "tmIDWinner", "local_1"."series_post_cf_f"."win_lg" AS "lgIDWinner", "local_1"."series_post_cf_f"."lose_team" AS "tmIDLoser", "local_1"."series_post_cf_f"."lose_lg" AS "lgIDLoser", "local_1"."series_post_cf_f"."win_games" AS "W", "local_1"."series_post_cf_f"."loss_games" AS "L" FROM "local_1"."series_post_cf_f"
UNION
SELECT "local_1"."series_post_other"."rec_id" AS "id", "local_1"."series_post_other"."yr" AS "year", "local_1"."series_post_other"."rnd" AS "round", "local_1"."series_post_other"."series_tag" AS "series", "local_1"."series_post_other"."win_team" AS "tmIDWinner", "local_1"."series_post_other"."win_lg" AS "lgIDWinner", "local_1"."series_post_other"."lose_team" AS "tmIDLoser", "local_1"."series_post_other"."lose_lg" AS "lgIDLoser", "local_1"."series_post_other"."win_games" AS "W", "local_1"."series_post_other"."loss_games" AS "L" FROM "local_1"."series_post_other";

-- Reconstruct teams from vertical (column) split (3 fragments)
CREATE VIEW "teams" AS
SELECT
    t0."yr" AS "year",
    t0."lg_key" AS "lgID",
    t0."team_key" AS "tmID",
    t0."franch_key" AS "franchID",
    t0."conf_key" AS "confID",
    t0."div_key" AS "divID",
    t0."seas_rank" AS "rank",
    t0."conf_rank" AS "confRank",
    t0."playoff_flag" AS "playoff",
    t0."team_name" AS "name",
    t1."opp_fgm" AS "o_fgm",
    t0."opp_ftm" AS "o_ftm",
    t1."opp_pts" AS "o_pts",
    t1."def_pts" AS "d_pts",
    t2."home_wins" AS "homeWon",
    t2."home_losses" AS "homeLost",
    t2."away_wins" AS "awayWon",
    t2."away_losses" AS "awayLost",
    t2."wins" AS "won",
    t2."losses" AS "lost",
    t0."g_played" AS "games",
    t0."arena_name" AS "arena"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "yr", "team_key" ORDER BY rowid) AS __rn FROM "local_1"."team_seas_arena") t0
JOIN "local_1"."team_seas_defpts" t1 ON t0."yr" IS t1."yr" AND t0."team_key" IS t1."team_key" AND t0.__rn = t1.__rn
JOIN "local_1"."team_seas_split" t2 ON t0."yr" IS t2."yr" AND t0."team_key" IS t2."team_key" AND t0.__rn = t2.__rn;
