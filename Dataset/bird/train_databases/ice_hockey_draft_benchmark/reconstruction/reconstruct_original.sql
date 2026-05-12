-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct PlayerInfo from vertical split + row partition on a fragment
CREATE VIEW "PlayerInfo" AS
SELECT t0.[elite_uid], t0.[plyr_nm], t1.[birthDateString], t1.[birthYearValue], t1.[birthMonthNumber], t1.[birthDayOfMonth], t0.[birth_loc], t3.[nat], t0.[ht], t0.[wt], t3.[pos_role], t3.[shot_hand], t0.[draft_yr], t0.[draft_rd], t0.[ovr_pick], t0.[ovr_by], t0.[css_r], t2.[sevenYearGamesSum], t2.[sevenYearTimeOnIce], t2.[hasGamesPlayed]
FROM (
SELECT [plyr_css_r_33to81].[__orig_rowid] AS __orig_rowid, [local_2].[plyr_css_r_33to81].[elite_uid], [local_2].[plyr_css_r_33to81].[plyr_nm], [local_2].[plyr_css_r_33to81].[birth_loc], [local_2].[plyr_css_r_33to81].[ht], [local_2].[plyr_css_r_33to81].[wt], [local_2].[plyr_css_r_33to81].[draft_yr], [local_2].[plyr_css_r_33to81].[draft_rd], [local_2].[plyr_css_r_33to81].[ovr_pick], [local_2].[plyr_css_r_33to81].[ovr_by], [local_2].[plyr_css_r_33to81].[css_r] FROM [local_2].[plyr_css_r_33to81]
UNION
SELECT [plyr_css_r_82to145].[__orig_rowid] AS __orig_rowid, [local_2].[plyr_css_r_82to145].[elite_uid], [local_2].[plyr_css_r_82to145].[plyr_nm], [local_2].[plyr_css_r_82to145].[birth_loc], [local_2].[plyr_css_r_82to145].[ht], [local_2].[plyr_css_r_82to145].[wt], [local_2].[plyr_css_r_82to145].[draft_yr], [local_2].[plyr_css_r_82to145].[draft_rd], [local_2].[plyr_css_r_82to145].[ovr_pick], [local_2].[plyr_css_r_82to145].[ovr_by], [local_2].[plyr_css_r_82to145].[css_r] FROM [local_2].[plyr_css_r_82to145]
UNION
SELECT [plyr_css_r_gt145_or_null].[__orig_rowid] AS __orig_rowid, [local_2].[plyr_css_r_gt145_or_null].[elite_uid], [local_2].[plyr_css_r_gt145_or_null].[plyr_nm], [local_2].[plyr_css_r_gt145_or_null].[birth_loc], [local_2].[plyr_css_r_gt145_or_null].[ht], [local_2].[plyr_css_r_gt145_or_null].[wt], [local_2].[plyr_css_r_gt145_or_null].[draft_yr], [local_2].[plyr_css_r_gt145_or_null].[draft_rd], [local_2].[plyr_css_r_gt145_or_null].[ovr_pick], [local_2].[plyr_css_r_gt145_or_null].[ovr_by], [local_2].[plyr_css_r_gt145_or_null].[css_r] FROM [local_2].[plyr_css_r_gt145_or_null]
UNION
SELECT [plyr_css_r_le32].[__orig_rowid] AS __orig_rowid, [local_2].[plyr_css_r_le32].[elite_uid], [local_2].[plyr_css_r_le32].[plyr_nm], [local_2].[plyr_css_r_le32].[birth_loc], [local_2].[plyr_css_r_le32].[ht], [local_2].[plyr_css_r_le32].[wt], [local_2].[plyr_css_r_le32].[draft_yr], [local_2].[plyr_css_r_le32].[draft_rd], [local_2].[plyr_css_r_le32].[ovr_pick], [local_2].[plyr_css_r_le32].[ovr_by], [local_2].[plyr_css_r_le32].[css_r] FROM [local_2].[plyr_css_r_le32]
) t0
JOIN [local_1].[playerCssRanking] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[playerGameParticipation] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_2].[plyr_nat_pos] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct SeasonStatus from local_2.plyr_season_stat
CREATE VIEW "SeasonStatus" AS
SELECT
    "local_2"."plyr_season_stat"."elite_uid" AS "ELITEID",
    "local_2"."plyr_season_stat"."szn" AS "SEASON",
    "local_2"."plyr_season_stat"."team_nm" AS "TEAM",
    "local_2"."plyr_season_stat"."league_nm" AS "LEAGUE",
    "local_2"."plyr_season_stat"."game_type" AS "GAMETYPE",
    "local_2"."plyr_season_stat"."gp_count" AS "GP",
    "local_2"."plyr_season_stat"."goals" AS "G",
    "local_2"."plyr_season_stat"."assists" AS "A",
    "local_2"."plyr_season_stat"."pts" AS "P",
    "local_2"."plyr_season_stat"."pen_min" AS "PIM",
    "local_2"."plyr_season_stat"."plus_minus" AS "PLUSMINUS"
FROM "local_2"."plyr_season_stat";

-- Reconstruct height_info from local_3.StatureRecord
CREATE VIEW "height_info" AS
SELECT
    "local_3"."StatureRecord"."StatureId" AS "height_id",
    "local_3"."StatureRecord"."HeightCentimeters" AS "height_in_cm",
    "local_3"."StatureRecord"."HeightInches" AS "height_in_inch"
FROM "local_3"."StatureRecord";

-- Reconstruct weight_info from local_1.weightMeasurements
CREATE VIEW "weight_info" AS
SELECT
    "local_1"."weightMeasurements"."weightRecordId" AS "weight_id",
    "local_1"."weightMeasurements"."weightKilograms" AS "weight_in_kg",
    "local_1"."weightMeasurements"."weightPounds" AS "weight_in_lbs"
FROM "local_1"."weightMeasurements";
