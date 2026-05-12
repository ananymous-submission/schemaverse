-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/IPL/IPL.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "bowlingPlayByPlay_bowlerUpTo73" (
    "matchRefId" INTEGER,
    "overIndex" INTEGER,
    "ballIndex" INTEGER,
    "inningIndex" INTEGER,
    "bowlerId" INTEGER,
    "nonStrikerId" INTEGER,
    "strikerId" INTEGER,
    "strikerBattingOrder" INTEGER,
    "bowlingTeamId" INTEGER
);

CREATE TABLE "bowlingPlayByPlay_bowler74To153" (
    "matchRefId" INTEGER,
    "overIndex" INTEGER,
    "ballIndex" INTEGER,
    "inningIndex" INTEGER,
    "bowlerId" INTEGER,
    "nonStrikerId" INTEGER,
    "strikerId" INTEGER,
    "strikerBattingOrder" INTEGER,
    "bowlingTeamId" INTEGER
);

CREATE TABLE "bowlingPlayByPlay_bowler154To293" (
    "matchRefId" INTEGER,
    "overIndex" INTEGER,
    "ballIndex" INTEGER,
    "inningIndex" INTEGER,
    "bowlerId" INTEGER,
    "nonStrikerId" INTEGER,
    "strikerId" INTEGER,
    "strikerBattingOrder" INTEGER,
    "bowlingTeamId" INTEGER
);

CREATE TABLE "bowlingPlayByPlay_bowlerAbove293OrNull" (
    "matchRefId" INTEGER,
    "overIndex" INTEGER,
    "ballIndex" INTEGER,
    "inningIndex" INTEGER,
    "bowlerId" INTEGER,
    "nonStrikerId" INTEGER,
    "strikerId" INTEGER,
    "strikerBattingOrder" INTEGER,
    "bowlingTeamId" INTEGER
);

CREATE TABLE "bowlingPlayByPlaySummary" (
    "matchRefId" INTEGER,
    "overIndex" INTEGER,
    "ballIndex" INTEGER,
    "inningIndex" INTEGER,
    "bowlerId" INTEGER,
    "strikerBattingOrder" INTEGER,
    "battingTeamId" INTEGER,
    "bowlingTeamId" INTEGER
);

CREATE TABLE "batsmanRuns_nonPositiveOrZero" (
    "matchRefId" INTEGER,
    "overIndex" INTEGER,
    "ballIndex" INTEGER,
    "runsScored" INTEGER,
    "inningIndex" INTEGER
);

CREATE TABLE "batsmanRuns_betweenZeroAndOne" (
    "matchRefId" INTEGER,
    "overIndex" INTEGER,
    "ballIndex" INTEGER,
    "runsScored" INTEGER,
    "inningIndex" INTEGER
);

CREATE TABLE "batsmanRuns_greaterThanOneOrNull" (
    "matchRefId" INTEGER,
    "overIndex" INTEGER,
    "ballIndex" INTEGER,
    "runsScored" INTEGER,
    "inningIndex" INTEGER
);

CREATE TABLE "matchSummary_manOfMatchUpTo40" (
    "matchRefId" INTEGER,
    "playerOfMatchId" INTEGER,
    "matchDate" DATE,
    "matchWinnerTeamId" INTEGER,
    "seasonId" INTEGER,
    "teamAId" INTEGER,
    "teamBId" INTEGER,
    "tossDecision" TEXT,
    "tossWinnerTeamId" INTEGER,
    "venueName" TEXT
);

CREATE TABLE "matchSummary_manOfMatch41To104" (
    "matchRefId" INTEGER,
    "playerOfMatchId" INTEGER,
    "matchDate" DATE,
    "matchWinnerTeamId" INTEGER,
    "seasonId" INTEGER,
    "teamAId" INTEGER,
    "teamBId" INTEGER,
    "tossDecision" TEXT,
    "tossWinnerTeamId" INTEGER,
    "venueName" TEXT
);

CREATE TABLE "matchSummary_manOfMatch105To208" (
    "matchRefId" INTEGER,
    "playerOfMatchId" INTEGER,
    "matchDate" DATE,
    "matchWinnerTeamId" INTEGER,
    "seasonId" INTEGER,
    "teamAId" INTEGER,
    "teamBId" INTEGER,
    "tossDecision" TEXT,
    "tossWinnerTeamId" INTEGER,
    "venueName" TEXT
);

CREATE TABLE "matchSummary_manOfMatchAbove208OrNull" (
    "matchRefId" INTEGER,
    "playerOfMatchId" INTEGER,
    "matchDate" DATE,
    "matchWinnerTeamId" INTEGER,
    "seasonId" INTEGER,
    "teamAId" INTEGER,
    "teamBId" INTEGER,
    "tossDecision" TEXT,
    "tossWinnerTeamId" INTEGER,
    "venueName" TEXT
);

CREATE TABLE "matchSummary" (
    "matchRefId" INTEGER,
    "playerOfMatchId" INTEGER,
    "matchDate" DATE,
    "resultType" TEXT,
    "seasonId" INTEGER,
    "tossDecision" TEXT,
    "venueName" TEXT,
    "winningMargin" INTEGER,
    "winningType" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "mch_bll_xtra_amt" (
    "m_id" INTEGER,
    "ov_id" INTEGER,
    "bll_id" INTEGER,
    "inn_no" INTEGER,
    "xtra_runs" INTEGER,
    "xtra_type" TEXT
);

CREATE TABLE "mch_bll_xtra_kind" (
    "m_id" INTEGER,
    "ov_id" INTEGER,
    "bll_id" INTEGER,
    "inn_no" INTEGER,
    "xtra_type" TEXT
);

CREATE TABLE "plr_bowl_ra_med" (
    "plr_id" INTEGER,
    "plr_name" TEXT,
    "birth_dt" DATE,
    "bat_hand" TEXT,
    "bowl_skill" TEXT,
    "cntry_name" TEXT
);

CREATE TABLE "plr_bowl_ra_offb" (
    "plr_id" INTEGER,
    "plr_name" TEXT,
    "birth_dt" DATE,
    "bat_hand" TEXT,
    "bowl_skill" TEXT,
    "cntry_name" TEXT
);

CREATE TABLE "plr_bowl_ra_fm_leg_legg" (
    "plr_id" INTEGER,
    "plr_name" TEXT,
    "birth_dt" DATE,
    "bat_hand" TEXT,
    "bowl_skill" TEXT,
    "cntry_name" TEXT
);

CREATE TABLE "plr_bowl_sla_orth_ra_medf" (
    "plr_id" INTEGER,
    "plr_name" TEXT,
    "birth_dt" DATE,
    "bat_hand" TEXT,
    "bowl_skill" TEXT,
    "cntry_name" TEXT
);

CREATE TABLE "plr_bowl_ra_fast_la_fm_other" (
    "plr_id" INTEGER,
    "plr_name" TEXT,
    "birth_dt" DATE,
    "bat_hand" TEXT,
    "bowl_skill" TEXT,
    "cntry_name" TEXT
);

CREATE TABLE "plr_mch_tm_le3" (
    "m_id" INTEGER,
    "plr_id" INTEGER,
    "plr_pos" TEXT,
    "tm_id" INTEGER
);

CREATE TABLE "plr_mch_tm_gt3_le5" (
    "m_id" INTEGER,
    "plr_id" INTEGER,
    "plr_pos" TEXT,
    "tm_id" INTEGER
);

CREATE TABLE "plr_mch_tm_gt5_le7" (
    "m_id" INTEGER,
    "plr_id" INTEGER,
    "plr_pos" TEXT,
    "tm_id" INTEGER
);

CREATE TABLE "plr_mch_tm_gt7_or_null" (
    "m_id" INTEGER,
    "plr_id" INTEGER,
    "plr_pos" TEXT,
    "tm_id" INTEGER
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "CricketTeam" (
    "TeamId" INTEGER,
    "TeamName" TEXT
);

CREATE TABLE "WicketKindPlayerUpTo40" (
    "MatchId" INTEGER,
    "OverId" INTEGER,
    "BallId" INTEGER,
    "InningsNumber" INTEGER,
    "DismissalKind" TEXT,
    "DismissedPlayerId" INTEGER
);

CREATE TABLE "WicketKindPlayerGt40To97" (
    "MatchId" INTEGER,
    "OverId" INTEGER,
    "BallId" INTEGER,
    "InningsNumber" INTEGER,
    "DismissalKind" TEXT,
    "DismissedPlayerId" INTEGER
);

CREATE TABLE "WicketKindPlayerGt97To212" (
    "MatchId" INTEGER,
    "OverId" INTEGER,
    "BallId" INTEGER,
    "InningsNumber" INTEGER,
    "DismissalKind" TEXT,
    "DismissedPlayerId" INTEGER
);

CREATE TABLE "WicketKindPlayerGt212OrNull" (
    "MatchId" INTEGER,
    "OverId" INTEGER,
    "BallId" INTEGER,
    "InningsNumber" INTEGER,
    "DismissalKind" TEXT,
    "DismissedPlayerId" INTEGER
);

CREATE TABLE "WicketPlayerDismissal" (
    "MatchId" INTEGER,
    "OverId" INTEGER,
    "BallId" INTEGER,
    "InningsNumber" INTEGER,
    "DismissedPlayerId" INTEGER
);

