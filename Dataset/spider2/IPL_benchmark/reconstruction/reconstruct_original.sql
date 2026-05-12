-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct ball_by_ball from vertical split + row partition on a fragment
CREATE VIEW "ball_by_ball" AS
SELECT t0.[matchRefId], t0.[overIndex], t0.[ballIndex], t0.[inningIndex], t1.[battingTeamId], t0.[bowlingTeamId], t0.[strikerBattingOrder], t0.[strikerId], t0.[nonStrikerId], t0.[bowlerId]
FROM (
SELECT [bowlingPlayByPlay_bowler154To293].[__orig_rowid] AS __orig_rowid, [local_1].[bowlingPlayByPlay_bowler154To293].[matchRefId], [local_1].[bowlingPlayByPlay_bowler154To293].[overIndex], [local_1].[bowlingPlayByPlay_bowler154To293].[ballIndex], [local_1].[bowlingPlayByPlay_bowler154To293].[inningIndex], [local_1].[bowlingPlayByPlay_bowler154To293].[bowlingTeamId], [local_1].[bowlingPlayByPlay_bowler154To293].[strikerBattingOrder], [local_1].[bowlingPlayByPlay_bowler154To293].[strikerId], [local_1].[bowlingPlayByPlay_bowler154To293].[nonStrikerId], [local_1].[bowlingPlayByPlay_bowler154To293].[bowlerId] FROM [local_1].[bowlingPlayByPlay_bowler154To293]
UNION
SELECT [bowlingPlayByPlay_bowler74To153].[__orig_rowid] AS __orig_rowid, [local_1].[bowlingPlayByPlay_bowler74To153].[matchRefId], [local_1].[bowlingPlayByPlay_bowler74To153].[overIndex], [local_1].[bowlingPlayByPlay_bowler74To153].[ballIndex], [local_1].[bowlingPlayByPlay_bowler74To153].[inningIndex], [local_1].[bowlingPlayByPlay_bowler74To153].[bowlingTeamId], [local_1].[bowlingPlayByPlay_bowler74To153].[strikerBattingOrder], [local_1].[bowlingPlayByPlay_bowler74To153].[strikerId], [local_1].[bowlingPlayByPlay_bowler74To153].[nonStrikerId], [local_1].[bowlingPlayByPlay_bowler74To153].[bowlerId] FROM [local_1].[bowlingPlayByPlay_bowler74To153]
UNION
SELECT [bowlingPlayByPlay_bowlerAbove293OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[bowlingPlayByPlay_bowlerAbove293OrNull].[matchRefId], [local_1].[bowlingPlayByPlay_bowlerAbove293OrNull].[overIndex], [local_1].[bowlingPlayByPlay_bowlerAbove293OrNull].[ballIndex], [local_1].[bowlingPlayByPlay_bowlerAbove293OrNull].[inningIndex], [local_1].[bowlingPlayByPlay_bowlerAbove293OrNull].[bowlingTeamId], [local_1].[bowlingPlayByPlay_bowlerAbove293OrNull].[strikerBattingOrder], [local_1].[bowlingPlayByPlay_bowlerAbove293OrNull].[strikerId], [local_1].[bowlingPlayByPlay_bowlerAbove293OrNull].[nonStrikerId], [local_1].[bowlingPlayByPlay_bowlerAbove293OrNull].[bowlerId] FROM [local_1].[bowlingPlayByPlay_bowlerAbove293OrNull]
UNION
SELECT [bowlingPlayByPlay_bowlerUpTo73].[__orig_rowid] AS __orig_rowid, [local_1].[bowlingPlayByPlay_bowlerUpTo73].[matchRefId], [local_1].[bowlingPlayByPlay_bowlerUpTo73].[overIndex], [local_1].[bowlingPlayByPlay_bowlerUpTo73].[ballIndex], [local_1].[bowlingPlayByPlay_bowlerUpTo73].[inningIndex], [local_1].[bowlingPlayByPlay_bowlerUpTo73].[bowlingTeamId], [local_1].[bowlingPlayByPlay_bowlerUpTo73].[strikerBattingOrder], [local_1].[bowlingPlayByPlay_bowlerUpTo73].[strikerId], [local_1].[bowlingPlayByPlay_bowlerUpTo73].[nonStrikerId], [local_1].[bowlingPlayByPlay_bowlerUpTo73].[bowlerId] FROM [local_1].[bowlingPlayByPlay_bowlerUpTo73]
) t0
JOIN [local_1].[bowlingPlayByPlaySummary] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct batsman_scored from row partitions (UNION (overlap))
CREATE VIEW "batsman_scored" AS
SELECT "local_1"."batsmanRuns_nonPositiveOrZero"."matchRefId" AS "match_id", "local_1"."batsmanRuns_nonPositiveOrZero"."overIndex" AS "over_id", "local_1"."batsmanRuns_nonPositiveOrZero"."ballIndex" AS "ball_id", "local_1"."batsmanRuns_nonPositiveOrZero"."runsScored" AS "runs_scored", "local_1"."batsmanRuns_nonPositiveOrZero"."inningIndex" AS "innings_no" FROM "local_1"."batsmanRuns_nonPositiveOrZero"
UNION
SELECT "local_1"."batsmanRuns_betweenZeroAndOne"."matchRefId" AS "match_id", "local_1"."batsmanRuns_betweenZeroAndOne"."overIndex" AS "over_id", "local_1"."batsmanRuns_betweenZeroAndOne"."ballIndex" AS "ball_id", "local_1"."batsmanRuns_betweenZeroAndOne"."runsScored" AS "runs_scored", "local_1"."batsmanRuns_betweenZeroAndOne"."inningIndex" AS "innings_no" FROM "local_1"."batsmanRuns_betweenZeroAndOne"
UNION
SELECT "local_1"."batsmanRuns_greaterThanOneOrNull"."matchRefId" AS "match_id", "local_1"."batsmanRuns_greaterThanOneOrNull"."overIndex" AS "over_id", "local_1"."batsmanRuns_greaterThanOneOrNull"."ballIndex" AS "ball_id", "local_1"."batsmanRuns_greaterThanOneOrNull"."runsScored" AS "runs_scored", "local_1"."batsmanRuns_greaterThanOneOrNull"."inningIndex" AS "innings_no" FROM "local_1"."batsmanRuns_greaterThanOneOrNull";

-- Reconstruct extra_runs from vertical (column) split (2 fragments)
CREATE VIEW "extra_runs" AS
SELECT
    t0."m_id" AS "match_id",
    t0."ov_id" AS "over_id",
    t0."bll_id" AS "ball_id",
    t0."xtra_type" AS "extra_type",
    t0."xtra_runs" AS "extra_runs",
    t0."inn_no" AS "innings_no"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "m_id", "ov_id", "bll_id", "inn_no" ORDER BY rowid) AS __rn FROM "local_2"."mch_bll_xtra_amt") t0
JOIN "local_2"."mch_bll_xtra_kind" t1 ON t0."m_id" IS t1."m_id" AND t0."ov_id" IS t1."ov_id" AND t0."bll_id" IS t1."bll_id" AND t0."inn_no" IS t1."inn_no" AND t0.__rn = t1.__rn;

-- Reconstruct match from vertical split + row partition on a fragment
CREATE VIEW "match" AS
SELECT t0.[matchRefId], t0.[teamAId], t0.[teamBId], t0.[matchDate], t0.[seasonId], t0.[venueName], t0.[tossWinnerTeamId], t0.[tossDecision], t1.[winningType], t1.[winningMargin], t1.[resultType], t0.[matchWinnerTeamId], t0.[playerOfMatchId]
FROM (
SELECT [matchSummary_manOfMatch105To208].[__orig_rowid] AS __orig_rowid, [local_1].[matchSummary_manOfMatch105To208].[matchRefId], [local_1].[matchSummary_manOfMatch105To208].[teamAId], [local_1].[matchSummary_manOfMatch105To208].[teamBId], [local_1].[matchSummary_manOfMatch105To208].[matchDate], [local_1].[matchSummary_manOfMatch105To208].[seasonId], [local_1].[matchSummary_manOfMatch105To208].[venueName], [local_1].[matchSummary_manOfMatch105To208].[tossWinnerTeamId], [local_1].[matchSummary_manOfMatch105To208].[tossDecision], [local_1].[matchSummary_manOfMatch105To208].[matchWinnerTeamId], [local_1].[matchSummary_manOfMatch105To208].[playerOfMatchId] FROM [local_1].[matchSummary_manOfMatch105To208]
UNION
SELECT [matchSummary_manOfMatch41To104].[__orig_rowid] AS __orig_rowid, [local_1].[matchSummary_manOfMatch41To104].[matchRefId], [local_1].[matchSummary_manOfMatch41To104].[teamAId], [local_1].[matchSummary_manOfMatch41To104].[teamBId], [local_1].[matchSummary_manOfMatch41To104].[matchDate], [local_1].[matchSummary_manOfMatch41To104].[seasonId], [local_1].[matchSummary_manOfMatch41To104].[venueName], [local_1].[matchSummary_manOfMatch41To104].[tossWinnerTeamId], [local_1].[matchSummary_manOfMatch41To104].[tossDecision], [local_1].[matchSummary_manOfMatch41To104].[matchWinnerTeamId], [local_1].[matchSummary_manOfMatch41To104].[playerOfMatchId] FROM [local_1].[matchSummary_manOfMatch41To104]
UNION
SELECT [matchSummary_manOfMatchAbove208OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[matchSummary_manOfMatchAbove208OrNull].[matchRefId], [local_1].[matchSummary_manOfMatchAbove208OrNull].[teamAId], [local_1].[matchSummary_manOfMatchAbove208OrNull].[teamBId], [local_1].[matchSummary_manOfMatchAbove208OrNull].[matchDate], [local_1].[matchSummary_manOfMatchAbove208OrNull].[seasonId], [local_1].[matchSummary_manOfMatchAbove208OrNull].[venueName], [local_1].[matchSummary_manOfMatchAbove208OrNull].[tossWinnerTeamId], [local_1].[matchSummary_manOfMatchAbove208OrNull].[tossDecision], [local_1].[matchSummary_manOfMatchAbove208OrNull].[matchWinnerTeamId], [local_1].[matchSummary_manOfMatchAbove208OrNull].[playerOfMatchId] FROM [local_1].[matchSummary_manOfMatchAbove208OrNull]
UNION
SELECT [matchSummary_manOfMatchUpTo40].[__orig_rowid] AS __orig_rowid, [local_1].[matchSummary_manOfMatchUpTo40].[matchRefId], [local_1].[matchSummary_manOfMatchUpTo40].[teamAId], [local_1].[matchSummary_manOfMatchUpTo40].[teamBId], [local_1].[matchSummary_manOfMatchUpTo40].[matchDate], [local_1].[matchSummary_manOfMatchUpTo40].[seasonId], [local_1].[matchSummary_manOfMatchUpTo40].[venueName], [local_1].[matchSummary_manOfMatchUpTo40].[tossWinnerTeamId], [local_1].[matchSummary_manOfMatchUpTo40].[tossDecision], [local_1].[matchSummary_manOfMatchUpTo40].[matchWinnerTeamId], [local_1].[matchSummary_manOfMatchUpTo40].[playerOfMatchId] FROM [local_1].[matchSummary_manOfMatchUpTo40]
) t0
JOIN [local_1].[matchSummary] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct player from row partitions (UNION (overlap))
CREATE VIEW "player" AS
SELECT "local_2"."plr_bowl_ra_med"."plr_id" AS "player_id", "local_2"."plr_bowl_ra_med"."plr_name" AS "player_name", "local_2"."plr_bowl_ra_med"."birth_dt" AS "dob", "local_2"."plr_bowl_ra_med"."bat_hand" AS "batting_hand", "local_2"."plr_bowl_ra_med"."bowl_skill" AS "bowling_skill", "local_2"."plr_bowl_ra_med"."cntry_name" AS "country_name" FROM "local_2"."plr_bowl_ra_med"
UNION
SELECT "local_2"."plr_bowl_ra_offb"."plr_id" AS "player_id", "local_2"."plr_bowl_ra_offb"."plr_name" AS "player_name", "local_2"."plr_bowl_ra_offb"."birth_dt" AS "dob", "local_2"."plr_bowl_ra_offb"."bat_hand" AS "batting_hand", "local_2"."plr_bowl_ra_offb"."bowl_skill" AS "bowling_skill", "local_2"."plr_bowl_ra_offb"."cntry_name" AS "country_name" FROM "local_2"."plr_bowl_ra_offb"
UNION
SELECT "local_2"."plr_bowl_ra_fm_leg_legg"."plr_id" AS "player_id", "local_2"."plr_bowl_ra_fm_leg_legg"."plr_name" AS "player_name", "local_2"."plr_bowl_ra_fm_leg_legg"."birth_dt" AS "dob", "local_2"."plr_bowl_ra_fm_leg_legg"."bat_hand" AS "batting_hand", "local_2"."plr_bowl_ra_fm_leg_legg"."bowl_skill" AS "bowling_skill", "local_2"."plr_bowl_ra_fm_leg_legg"."cntry_name" AS "country_name" FROM "local_2"."plr_bowl_ra_fm_leg_legg"
UNION
SELECT "local_2"."plr_bowl_sla_orth_ra_medf"."plr_id" AS "player_id", "local_2"."plr_bowl_sla_orth_ra_medf"."plr_name" AS "player_name", "local_2"."plr_bowl_sla_orth_ra_medf"."birth_dt" AS "dob", "local_2"."plr_bowl_sla_orth_ra_medf"."bat_hand" AS "batting_hand", "local_2"."plr_bowl_sla_orth_ra_medf"."bowl_skill" AS "bowling_skill", "local_2"."plr_bowl_sla_orth_ra_medf"."cntry_name" AS "country_name" FROM "local_2"."plr_bowl_sla_orth_ra_medf"
UNION
SELECT "local_2"."plr_bowl_ra_fast_la_fm_other"."plr_id" AS "player_id", "local_2"."plr_bowl_ra_fast_la_fm_other"."plr_name" AS "player_name", "local_2"."plr_bowl_ra_fast_la_fm_other"."birth_dt" AS "dob", "local_2"."plr_bowl_ra_fast_la_fm_other"."bat_hand" AS "batting_hand", "local_2"."plr_bowl_ra_fast_la_fm_other"."bowl_skill" AS "bowling_skill", "local_2"."plr_bowl_ra_fast_la_fm_other"."cntry_name" AS "country_name" FROM "local_2"."plr_bowl_ra_fast_la_fm_other";

-- Reconstruct player_match from row partitions (UNION (overlap))
CREATE VIEW "player_match" AS
SELECT "local_2"."plr_mch_tm_le3"."m_id" AS "match_id", "local_2"."plr_mch_tm_le3"."plr_id" AS "player_id", "local_2"."plr_mch_tm_le3"."plr_pos" AS "role", "local_2"."plr_mch_tm_le3"."tm_id" AS "team_id" FROM "local_2"."plr_mch_tm_le3"
UNION
SELECT "local_2"."plr_mch_tm_gt3_le5"."m_id" AS "match_id", "local_2"."plr_mch_tm_gt3_le5"."plr_id" AS "player_id", "local_2"."plr_mch_tm_gt3_le5"."plr_pos" AS "role", "local_2"."plr_mch_tm_gt3_le5"."tm_id" AS "team_id" FROM "local_2"."plr_mch_tm_gt3_le5"
UNION
SELECT "local_2"."plr_mch_tm_gt5_le7"."m_id" AS "match_id", "local_2"."plr_mch_tm_gt5_le7"."plr_id" AS "player_id", "local_2"."plr_mch_tm_gt5_le7"."plr_pos" AS "role", "local_2"."plr_mch_tm_gt5_le7"."tm_id" AS "team_id" FROM "local_2"."plr_mch_tm_gt5_le7"
UNION
SELECT "local_2"."plr_mch_tm_gt7_or_null"."m_id" AS "match_id", "local_2"."plr_mch_tm_gt7_or_null"."plr_id" AS "player_id", "local_2"."plr_mch_tm_gt7_or_null"."plr_pos" AS "role", "local_2"."plr_mch_tm_gt7_or_null"."tm_id" AS "team_id" FROM "local_2"."plr_mch_tm_gt7_or_null";

-- Reconstruct team from local_3.CricketTeam
CREATE VIEW "team" AS
SELECT
    "local_3"."CricketTeam"."TeamId" AS "team_id",
    "local_3"."CricketTeam"."TeamName" AS "name"
FROM "local_3"."CricketTeam";

-- Reconstruct wicket_taken from vertical split + row partition on a fragment
CREATE VIEW "wicket_taken" AS
SELECT t0.[MatchId], t0.[OverId], t0.[BallId], t0.[DismissedPlayerId], t0.[DismissalKind], t0.[InningsNumber]
FROM (
SELECT [WicketKindPlayerGt212OrNull].[__orig_rowid] AS __orig_rowid, [local_3].[WicketKindPlayerGt212OrNull].[MatchId], [local_3].[WicketKindPlayerGt212OrNull].[OverId], [local_3].[WicketKindPlayerGt212OrNull].[BallId], [local_3].[WicketKindPlayerGt212OrNull].[DismissedPlayerId], [local_3].[WicketKindPlayerGt212OrNull].[DismissalKind], [local_3].[WicketKindPlayerGt212OrNull].[InningsNumber] FROM [local_3].[WicketKindPlayerGt212OrNull]
UNION
SELECT [WicketKindPlayerGt40To97].[__orig_rowid] AS __orig_rowid, [local_3].[WicketKindPlayerGt40To97].[MatchId], [local_3].[WicketKindPlayerGt40To97].[OverId], [local_3].[WicketKindPlayerGt40To97].[BallId], [local_3].[WicketKindPlayerGt40To97].[DismissedPlayerId], [local_3].[WicketKindPlayerGt40To97].[DismissalKind], [local_3].[WicketKindPlayerGt40To97].[InningsNumber] FROM [local_3].[WicketKindPlayerGt40To97]
UNION
SELECT [WicketKindPlayerGt97To212].[__orig_rowid] AS __orig_rowid, [local_3].[WicketKindPlayerGt97To212].[MatchId], [local_3].[WicketKindPlayerGt97To212].[OverId], [local_3].[WicketKindPlayerGt97To212].[BallId], [local_3].[WicketKindPlayerGt97To212].[DismissedPlayerId], [local_3].[WicketKindPlayerGt97To212].[DismissalKind], [local_3].[WicketKindPlayerGt97To212].[InningsNumber] FROM [local_3].[WicketKindPlayerGt97To212]
UNION
SELECT [WicketKindPlayerUpTo40].[__orig_rowid] AS __orig_rowid, [local_3].[WicketKindPlayerUpTo40].[MatchId], [local_3].[WicketKindPlayerUpTo40].[OverId], [local_3].[WicketKindPlayerUpTo40].[BallId], [local_3].[WicketKindPlayerUpTo40].[DismissedPlayerId], [local_3].[WicketKindPlayerUpTo40].[DismissalKind], [local_3].[WicketKindPlayerUpTo40].[InningsNumber] FROM [local_3].[WicketKindPlayerUpTo40]
) t0
JOIN [local_3].[WicketPlayerDismissal] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];
