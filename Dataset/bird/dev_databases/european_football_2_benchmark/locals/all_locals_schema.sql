-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/dev_databases/european_football_2/european_football_2.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "countryReference" (
    "countryId" INTEGER,
    "countryName" TEXT
);

CREATE TABLE "playerAttributesAccelerationProfile" (
    "attributeId" INTEGER,
    "accelerationRating" INTEGER,
    "aggressionRating" INTEGER,
    "agilityRating" INTEGER,
    "balanceRating" INTEGER,
    "ballControlRating" INTEGER,
    "crossingRating" INTEGER,
    "curveRating" INTEGER,
    "dribblingRating" INTEGER,
    "interceptionRating" INTEGER,
    "jumpingRating" INTEGER,
    "longShotRating" INTEGER,
    "markingRating" INTEGER,
    "penaltyRating" INTEGER,
    "positioningRating" INTEGER,
    "reactionRating" INTEGER,
    "shotPowerRating" INTEGER,
    "slidingTackleRating" INTEGER,
    "sprintSpeedRating" INTEGER,
    "staminaRating" INTEGER,
    "standingTackleRating" INTEGER,
    "strengthRating" INTEGER,
    "visionRating" INTEGER,
    "volleyRating" INTEGER
);

CREATE TABLE "playerWorkRateProfile" (
    "workRateId" INTEGER,
    "attackingWorkRate" TEXT,
    "defensiveWorkRate" TEXT,
    "externalPlayerId" INTEGER,
    "fifaPlayerId" INTEGER,
    FOREIGN KEY ("externalPlayerId") REFERENCES "playersHeightAbove182Point88To185Point42"("externalPlayerId")
);

CREATE TABLE "playerAttributesHighAggressionAbove73OrNull" (
    "attributeId" INTEGER,
    "aggressionRating" INTEGER,
    "balanceRating" INTEGER,
    "goalkeeperDivingRating" INTEGER,
    "goalkeeperHandlingRating" INTEGER,
    "goalkeeperKickingRating" INTEGER,
    "goalkeeperPositioningRating" INTEGER,
    "goalkeeperReflexRating" INTEGER,
    "jumpingRating" INTEGER,
    "markingRating" INTEGER,
    "positioningRating" INTEGER,
    "reactionRating" INTEGER,
    "shotPowerRating" INTEGER,
    "slidingTackleRating" INTEGER,
    "sprintSpeedRating" INTEGER,
    "standingTackleRating" INTEGER
);

CREATE TABLE "playersHeightAbove177Point8To182Point88" (
    "playerRecordId" INTEGER,
    "externalPlayerId" INTEGER,
    "displayName" TEXT,
    "fifaPlayerId" INTEGER,
    "birthDate" TEXT,
    "heightValue" INTEGER,
    "weightValue" INTEGER
);

CREATE TABLE "playersHeightAbove182Point88To185Point42" (
    "playerRecordId" INTEGER,
    "externalPlayerId" INTEGER,
    "displayName" TEXT,
    "fifaPlayerId" INTEGER,
    "birthDate" TEXT,
    "heightValue" INTEGER,
    "weightValue" INTEGER
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "CompetitionLeague" (
    "LeagueId" INTEGER,
    "CountryId" INTEGER,
    "LeagueName" TEXT
);

CREATE TABLE "TeamAttributesBuildUpPlayDribbling" (
    "TeamAttributeId" INTEGER,
    "BuildUpPlayDribblingValue" INTEGER,
    "BuildUpPlayDribblingCategory" TEXT,
    "BuildUpPlayPassingValue" INTEGER,
    "BuildUpPlayPassingCategory" TEXT,
    "BuildUpPlayPositioningCategory" TEXT,
    "BuildUpPlaySpeedValue" INTEGER,
    "BuildUpPlaySpeedCategory" TEXT,
    "ChanceCreationPassingValue" INTEGER,
    "ChanceCreationPassingCategory" TEXT,
    "ChanceCreationPositioningCategory" TEXT
);

CREATE TABLE "TeamAttributesBuildUpPlayDribblingClassifications" (
    "TeamAttributeClassId" INTEGER,
    "BuildUpPlayDribblingCategory" TEXT,
    "ChanceCreationCrossingValue" INTEGER,
    "ChanceCreationCrossingCategory" TEXT,
    "ChanceCreationShootingValue" INTEGER,
    "ChanceCreationShootingCategory" TEXT
);

CREATE TABLE "B365ALowestQuartileMatches" (
    "MatchOddsId" INTEGER,
    "B365AwayOdds" REAL,
    "B365DrawOdds" REAL,
    "B365HomeOdds" REAL,
    "BsaAwayOdds" REAL,
    "BsaDrawOdds" REAL,
    "BsaHomeOdds" REAL,
    "BwaAwayOdds" REAL,
    "BwaDrawOdds" REAL,
    "BwaHomeOdds" REAL,
    "GbAwayOdds" REAL,
    "GbDrawOdds" REAL,
    "GbHomeOdds" REAL,
    "IwAwayOdds" REAL,
    "IwDrawOdds" REAL,
    "IwHomeOdds" REAL,
    "LbAwayOdds" REAL,
    "LbDrawOdds" REAL,
    "LbHomeOdds" REAL,
    "PsAwayOdds" REAL,
    "PsDrawOdds" REAL,
    "PsHomeOdds" REAL,
    "SjAwayOdds" REAL,
    "SjDrawOdds" REAL,
    "SjHomeOdds" REAL,
    "VcAwayOdds" REAL,
    "VcDrawOdds" REAL,
    "VcHomeOdds" REAL,
    "WhAwayOdds" REAL,
    "WhDrawOdds" REAL,
    "WhHomeOdds" REAL,
    "AwayPlayerTenId" INTEGER,
    "AwayTeamApiId" INTEGER,
    "AwayTeamGoals" INTEGER,
    "CardEvents" TEXT,
    "Corners" TEXT,
    "CountryId" INTEGER,
    "Crosses" TEXT,
    "MatchDate" TEXT,
    "FoulsCommitted" TEXT,
    "Goals" TEXT,
    "HomeTeamApiId" INTEGER,
    "HomeTeamGoals" INTEGER,
    "LeagueId" INTEGER,
    "MatchApiId" INTEGER,
    "Possession" TEXT,
    "Season" TEXT,
    "ShotsOffTarget" TEXT,
    "ShotsOnTarget" TEXT,
    "Stage" INTEGER
);

CREATE TABLE "B365AQuartileRange2Point5To3Point5Matches" (
    "MatchOddsId" INTEGER,
    "B365AwayOdds" REAL,
    "B365DrawOdds" REAL,
    "B365HomeOdds" REAL,
    "BsaAwayOdds" REAL,
    "BsaDrawOdds" REAL,
    "BsaHomeOdds" REAL,
    "BwaAwayOdds" REAL,
    "BwaDrawOdds" REAL,
    "BwaHomeOdds" REAL,
    "GbAwayOdds" REAL,
    "GbDrawOdds" REAL,
    "GbHomeOdds" REAL,
    "IwAwayOdds" REAL,
    "IwDrawOdds" REAL,
    "IwHomeOdds" REAL,
    "LbAwayOdds" REAL,
    "LbDrawOdds" REAL,
    "LbHomeOdds" REAL,
    "PsAwayOdds" REAL,
    "PsDrawOdds" REAL,
    "PsHomeOdds" REAL,
    "SjAwayOdds" REAL,
    "SjDrawOdds" REAL,
    "SjHomeOdds" REAL,
    "VcAwayOdds" REAL,
    "VcDrawOdds" REAL,
    "VcHomeOdds" REAL,
    "WhAwayOdds" REAL,
    "WhDrawOdds" REAL,
    "WhHomeOdds" REAL,
    "AwayPlayerTenId" INTEGER,
    "AwayTeamApiId" INTEGER,
    "AwayTeamGoals" INTEGER,
    "CardEvents" TEXT,
    "Corners" TEXT,
    "CountryId" INTEGER,
    "Crosses" TEXT,
    "MatchDate" TEXT,
    "FoulsCommitted" TEXT,
    "Goals" TEXT,
    "HomeTeamApiId" INTEGER,
    "HomeTeamGoals" INTEGER,
    "LeagueId" INTEGER,
    "MatchApiId" INTEGER,
    "Possession" TEXT,
    "Season" TEXT,
    "ShotsOffTarget" TEXT,
    "ShotsOnTarget" TEXT,
    "Stage" INTEGER
);

CREATE TABLE "B365AQuartileRange3Point5To5Point25Matches" (
    "MatchOddsId" INTEGER,
    "B365AwayOdds" REAL,
    "B365DrawOdds" REAL,
    "B365HomeOdds" REAL,
    "BsaAwayOdds" REAL,
    "BsaDrawOdds" REAL,
    "BsaHomeOdds" REAL,
    "BwaAwayOdds" REAL,
    "BwaDrawOdds" REAL,
    "BwaHomeOdds" REAL,
    "GbAwayOdds" REAL,
    "GbDrawOdds" REAL,
    "GbHomeOdds" REAL,
    "IwAwayOdds" REAL,
    "IwDrawOdds" REAL,
    "IwHomeOdds" REAL,
    "LbAwayOdds" REAL,
    "LbDrawOdds" REAL,
    "LbHomeOdds" REAL,
    "PsAwayOdds" REAL,
    "PsDrawOdds" REAL,
    "PsHomeOdds" REAL,
    "SjAwayOdds" REAL,
    "SjDrawOdds" REAL,
    "SjHomeOdds" REAL,
    "VcAwayOdds" REAL,
    "VcDrawOdds" REAL,
    "VcHomeOdds" REAL,
    "WhAwayOdds" REAL,
    "WhDrawOdds" REAL,
    "WhHomeOdds" REAL,
    "AwayPlayerTenId" INTEGER,
    "AwayTeamApiId" INTEGER,
    "AwayTeamGoals" INTEGER,
    "CardEvents" TEXT,
    "Corners" TEXT,
    "CountryId" INTEGER,
    "Crosses" TEXT,
    "MatchDate" TEXT,
    "FoulsCommitted" TEXT,
    "Goals" TEXT,
    "HomeTeamApiId" INTEGER,
    "HomeTeamGoals" INTEGER,
    "LeagueId" INTEGER,
    "MatchApiId" INTEGER,
    "Possession" TEXT,
    "Season" TEXT,
    "ShotsOffTarget" TEXT,
    "ShotsOnTarget" TEXT,
    "Stage" INTEGER
);

CREATE TABLE "B365AHighestQuartileOrNullMatches" (
    "MatchOddsId" INTEGER,
    "B365AwayOdds" REAL,
    "B365DrawOdds" REAL,
    "B365HomeOdds" REAL,
    "BsaAwayOdds" REAL,
    "BsaDrawOdds" REAL,
    "BsaHomeOdds" REAL,
    "BwaAwayOdds" REAL,
    "BwaDrawOdds" REAL,
    "BwaHomeOdds" REAL,
    "GbAwayOdds" REAL,
    "GbDrawOdds" REAL,
    "GbHomeOdds" REAL,
    "IwAwayOdds" REAL,
    "IwDrawOdds" REAL,
    "IwHomeOdds" REAL,
    "LbAwayOdds" REAL,
    "LbDrawOdds" REAL,
    "LbHomeOdds" REAL,
    "PsAwayOdds" REAL,
    "PsDrawOdds" REAL,
    "PsHomeOdds" REAL,
    "SjAwayOdds" REAL,
    "SjDrawOdds" REAL,
    "SjHomeOdds" REAL,
    "VcAwayOdds" REAL,
    "VcDrawOdds" REAL,
    "VcHomeOdds" REAL,
    "WhAwayOdds" REAL,
    "WhDrawOdds" REAL,
    "WhHomeOdds" REAL,
    "AwayPlayerTenId" INTEGER,
    "AwayTeamApiId" INTEGER,
    "AwayTeamGoals" INTEGER,
    "CardEvents" TEXT,
    "Corners" TEXT,
    "CountryId" INTEGER,
    "Crosses" TEXT,
    "MatchDate" TEXT,
    "FoulsCommitted" TEXT,
    "Goals" TEXT,
    "HomeTeamApiId" INTEGER,
    "HomeTeamGoals" INTEGER,
    "LeagueId" INTEGER,
    "MatchApiId" INTEGER,
    "Possession" TEXT,
    "Season" TEXT,
    "ShotsOffTarget" TEXT,
    "ShotsOnTarget" TEXT,
    "Stage" INTEGER
);

CREATE TABLE "AwayPlayerXTenRosterEntries" (
    "MatchXRosterId" INTEGER,
    "AwayPlayerXTenId" INTEGER,
    "AwayPlayerXElevenId" INTEGER,
    "HomePlayerTenId" INTEGER,
    "HomePlayerElevenId" INTEGER,
    "HomePlayerXOneId" INTEGER,
    "HomePlayerXTenId" INTEGER,
    "HomePlayerXElevenId" INTEGER,
    "HomePlayerXTwoId" INTEGER,
    "HomePlayerXThreeId" INTEGER,
    "HomePlayerXFourId" INTEGER,
    "HomePlayerXFiveId" INTEGER,
    "HomePlayerXSixId" INTEGER,
    "HomePlayerXSevenId" INTEGER,
    "HomePlayerXEightId" INTEGER,
    "HomePlayerXNineId" INTEGER,
    "HomePlayerYOneId" INTEGER,
    "HomePlayerYTenId" INTEGER,
    "HomePlayerYElevenId" INTEGER,
    "HomePlayerYTwoId" INTEGER,
    "HomePlayerYThreeId" INTEGER,
    "HomePlayerYFourId" INTEGER,
    "HomePlayerYFiveId" INTEGER,
    "HomePlayerYSixId" INTEGER,
    "HomePlayerYSevenId" INTEGER,
    "HomeTeamGoals" INTEGER
);

CREATE TABLE "AwayPlayerElevenRosterEntries" (
    "MatchRosterId" INTEGER,
    "AwayPlayerElevenId" INTEGER,
    "AwayPlayerYOneId" INTEGER,
    "AwayPlayerYTenId" INTEGER,
    "AwayPlayerYElevenId" INTEGER,
    "AwayPlayerYTwoId" INTEGER,
    "AwayPlayerYThreeId" INTEGER,
    "AwayPlayerYFourId" INTEGER,
    "AwayPlayerYFiveId" INTEGER,
    "AwayPlayerYSixId" INTEGER,
    "AwayPlayerYSevenId" INTEGER,
    "AwayPlayerYEightId" INTEGER,
    "AwayPlayerYNineId" INTEGER,
    "AwayTeamGoals" INTEGER,
    "HomePlayerYTenId" INTEGER,
    "HomePlayerYElevenId" INTEGER,
    "HomePlayerYEightId" INTEGER,
    "HomePlayerYNineId" INTEGER
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "mt_bet_odds" (
    "rec_id" INTEGER,
    "odds_b365_away" REAL,
    "odds_b365_home" REAL,
    "odds_bwin_away" REAL,
    "odds_bwin_home" REAL,
    "odds_gb_away" REAL,
    "odds_gb_home" REAL,
    "odds_iw_away" REAL,
    "odds_iw_home" REAL,
    "odds_lb_home" REAL,
    "odds_ps_away" REAL,
    "odds_ps_home" REAL,
    "odds_sj_away" REAL,
    "odds_sj_draw" REAL,
    "odds_sj_home" REAL,
    "odds_vc_home" REAL,
    "odds_wh_away" REAL,
    "odds_wh_draw" REAL,
    "odds_wh_home" REAL,
    "away_pl_gk_id" INTEGER,
    "away_pl_st_support_id" INTEGER,
    "away_pl_sub_fwd_id" INTEGER,
    "away_pl_lb_id" INTEGER,
    "away_pl_cb_l_id" INTEGER,
    "away_pl_cb_r_id" INTEGER,
    "away_pl_rb_id" INTEGER,
    "away_pl_lm_id" INTEGER,
    "away_pl_cm_id" INTEGER,
    "away_pl_rm_id" INTEGER,
    "away_pl_st_id" INTEGER,
    "away_tm_ext_id" INTEGER,
    "card_events" TEXT,
    "corners" TEXT,
    "country_ref" INTEGER,
    "crosses" TEXT,
    "match_date" TEXT,
    "fouls" TEXT,
    "goals" TEXT,
    "home_pl_gk_id" INTEGER,
    "home_pl_st_support_id" INTEGER,
    "home_pl_sub_fwd_id" INTEGER,
    "home_pl_lb_id" INTEGER,
    "home_pl_cb_l_id" INTEGER,
    "home_pl_cb_r_id" INTEGER,
    "home_pl_rb_id" INTEGER,
    "home_pl_lm_id" INTEGER,
    "home_pl_cm_id" INTEGER,
    "home_pl_rm_id" INTEGER,
    "home_pl_st_id" INTEGER,
    "home_tm_ext_id" INTEGER,
    "league_ref" INTEGER,
    "match_ext_id" INTEGER,
    "possession" TEXT,
    "season_tag" TEXT,
    "shots_off" TEXT,
    "shots_on" TEXT,
    "stage" INTEGER,
    FOREIGN KEY ("away_pl_sub_fwd_id") REFERENCES "pl_ht_low"("player_ext_id"),
    FOREIGN KEY ("away_pl_sub_fwd_id") REFERENCES "pl_ht_high_nullok"("player_ext_id"),
    FOREIGN KEY ("away_pl_st_support_id") REFERENCES "pl_ht_high_nullok"("player_ext_id"),
    FOREIGN KEY ("away_pl_st_id") REFERENCES "pl_ht_low"("player_ext_id"),
    FOREIGN KEY ("away_pl_st_id") REFERENCES "pl_ht_high_nullok"("player_ext_id"),
    FOREIGN KEY ("away_pl_rm_id") REFERENCES "pl_ht_low"("player_ext_id"),
    FOREIGN KEY ("away_pl_rm_id") REFERENCES "pl_ht_high_nullok"("player_ext_id"),
    FOREIGN KEY ("away_pl_lm_id") REFERENCES "pl_ht_high_nullok"("player_ext_id"),
    FOREIGN KEY ("away_pl_cb_r_id") REFERENCES "pl_ht_low"("player_ext_id"),
    FOREIGN KEY ("away_pl_cb_r_id") REFERENCES "pl_ht_high_nullok"("player_ext_id"),
    FOREIGN KEY ("away_pl_cb_l_id") REFERENCES "pl_ht_low"("player_ext_id"),
    FOREIGN KEY ("away_pl_lb_id") REFERENCES "pl_ht_high_nullok"("player_ext_id"),
    FOREIGN KEY ("away_pl_gk_id") REFERENCES "pl_ht_low"("player_ext_id"),
    FOREIGN KEY ("away_pl_gk_id") REFERENCES "pl_ht_high_nullok"("player_ext_id"),
    FOREIGN KEY ("home_pl_st_support_id") REFERENCES "pl_ht_low"("player_ext_id"),
    FOREIGN KEY ("home_pl_st_support_id") REFERENCES "pl_ht_high_nullok"("player_ext_id"),
    FOREIGN KEY ("home_pl_cm_id") REFERENCES "pl_ht_low"("player_ext_id"),
    FOREIGN KEY ("home_pl_cm_id") REFERENCES "pl_ht_high_nullok"("player_ext_id"),
    FOREIGN KEY ("home_pl_lm_id") REFERENCES "pl_ht_high_nullok"("player_ext_id"),
    FOREIGN KEY ("home_pl_cb_r_id") REFERENCES "pl_ht_high_nullok"("player_ext_id"),
    FOREIGN KEY ("home_pl_gk_id") REFERENCES "pl_ht_low"("player_ext_id"),
    FOREIGN KEY ("home_pl_gk_id") REFERENCES "pl_ht_high_nullok"("player_ext_id"),
    FOREIGN KEY ("away_tm_ext_id") REFERENCES "tm_core"("team_ext_id")
);

CREATE TABLE "mt_away_pl_lineup" (
    "rec_id" INTEGER,
    "away_pl_gk" INTEGER,
    "away_pl_st_support" INTEGER,
    "away_pl_sub_fwd" INTEGER,
    "away_pl_lb" INTEGER,
    "away_pl_cb_l" INTEGER,
    "away_pl_cb_r" INTEGER,
    "away_pl_rb" INTEGER,
    "away_pl_lm" INTEGER,
    "away_pl_cm" INTEGER,
    "away_pl_rm" INTEGER,
    "away_pl_st" INTEGER,
    "home_pl_st_support" INTEGER,
    "home_pl_sub_fwd" INTEGER
);

CREATE TABLE "pl_ht_low" (
    "rec_id" INTEGER,
    "player_ext_id" INTEGER,
    "player_full_name" TEXT,
    "player_fifa_id" INTEGER,
    "bday" TEXT,
    "height_cm" INTEGER,
    "weight_kg" INTEGER
);

CREATE TABLE "pl_ht_high_nullok" (
    "rec_id" INTEGER,
    "player_ext_id" INTEGER,
    "player_full_name" TEXT,
    "player_fifa_id" INTEGER,
    "bday" TEXT,
    "height_cm" INTEGER,
    "weight_kg" INTEGER
);

CREATE TABLE "tm_core" (
    "rec_id" INTEGER,
    "team_ext_id" INTEGER,
    "team_fifa_id" INTEGER,
    "team_name_long" TEXT,
    "team_name_short" TEXT
);

CREATE TABLE "pl_attr_snapshot" (
    "rec_id" INTEGER,
    "attr_date" TEXT,
    "ovr_rt" INTEGER,
    "pot" INTEGER,
    "pref_foot" TEXT
);

CREATE TABLE "tm_attr_defaggr_le44_date" (
    "rec_id" INTEGER,
    "attr_date" TEXT,
    "def_aggr" INTEGER,
    "def_line_class" TEXT,
    "def_team_width" INTEGER,
    "def_team_width_class" TEXT,
    "team_ext_id" INTEGER,
    "team_fifa_id" INTEGER,
    FOREIGN KEY ("team_fifa_id") REFERENCES "tm_core"("team_fifa_id")
);

CREATE TABLE "tm_attr_defaggr_45_48_date" (
    "rec_id" INTEGER,
    "attr_date" TEXT,
    "def_aggr" INTEGER,
    "def_line_class" TEXT,
    "def_team_width" INTEGER,
    "def_team_width_class" TEXT,
    "team_ext_id" INTEGER,
    "team_fifa_id" INTEGER,
    FOREIGN KEY ("team_ext_id") REFERENCES "tm_core"("team_ext_id"),
    FOREIGN KEY ("team_fifa_id") REFERENCES "tm_core"("team_fifa_id")
);

CREATE TABLE "tm_attr_defaggr_49_55_date" (
    "rec_id" INTEGER,
    "attr_date" TEXT,
    "def_aggr" INTEGER,
    "def_line_class" TEXT,
    "def_team_width" INTEGER,
    "def_team_width_class" TEXT,
    "team_ext_id" INTEGER,
    "team_fifa_id" INTEGER,
    FOREIGN KEY ("team_ext_id") REFERENCES "tm_core"("team_ext_id")
);

CREATE TABLE "tm_attr_defaggr_gt55_nullok_date" (
    "rec_id" INTEGER,
    "attr_date" TEXT,
    "def_aggr" INTEGER,
    "def_line_class" TEXT,
    "def_team_width" INTEGER,
    "def_team_width_class" TEXT,
    "team_ext_id" INTEGER,
    "team_fifa_id" INTEGER
);

CREATE TABLE "pl_attr_tech_xing" (
    "rec_id" INTEGER,
    "cross" INTEGER,
    "drib" INTEGER,
    "finish" INTEGER,
    "fk_acc" INTEGER,
    "head_acc" INTEGER,
    "interc" INTEGER,
    "long_pass" INTEGER,
    "long_shot" INTEGER,
    "pens" INTEGER,
    "short_pass" INTEGER,
    "vis" INTEGER,
    "volley" INTEGER
);

CREATE TABLE "tm_attr_bup_pos_cl" (
    "rec_id" INTEGER,
    "bup_pos_class" TEXT,
    "chance_pos_class" TEXT,
    "attr_date" TEXT,
    "def_aggr" INTEGER,
    "def_aggr_class" TEXT,
    "def_line_class" TEXT,
    "def_team_width" INTEGER
);

CREATE TABLE "tm_attr_chc_pass" (
    "rec_id" INTEGER,
    "chance_pass" INTEGER,
    "chance_pass_class" TEXT,
    "def_press" INTEGER,
    "def_press_class" TEXT,
    "def_team_width_class" TEXT
);

CREATE TABLE "pl_attr_aggr_le51" (
    "rec_id" INTEGER,
    "aggr" INTEGER,
    "bal" INTEGER,
    "gk_div" INTEGER,
    "gk_hand" INTEGER,
    "gk_kick" INTEGER,
    "gk_pos" INTEGER,
    "gk_refl" INTEGER,
    "jmp" INTEGER,
    "mark" INTEGER,
    "pos" INTEGER,
    "react" INTEGER,
    "shot_pow" INTEGER,
    "slide_tack" INTEGER,
    "sprint_sp" INTEGER,
    "stand_tack" INTEGER
);

CREATE TABLE "pl_attr_aggr_52_64" (
    "rec_id" INTEGER,
    "aggr" INTEGER,
    "bal" INTEGER,
    "gk_div" INTEGER,
    "gk_hand" INTEGER,
    "gk_kick" INTEGER,
    "gk_pos" INTEGER,
    "gk_refl" INTEGER,
    "jmp" INTEGER,
    "mark" INTEGER,
    "pos" INTEGER,
    "react" INTEGER,
    "shot_pow" INTEGER,
    "slide_tack" INTEGER,
    "sprint_sp" INTEGER,
    "stand_tack" INTEGER
);

CREATE TABLE "pl_attr_aggr_65_73" (
    "rec_id" INTEGER,
    "aggr" INTEGER,
    "bal" INTEGER,
    "gk_div" INTEGER,
    "gk_hand" INTEGER,
    "gk_kick" INTEGER,
    "gk_pos" INTEGER,
    "gk_refl" INTEGER,
    "jmp" INTEGER,
    "mark" INTEGER,
    "pos" INTEGER,
    "react" INTEGER,
    "shot_pow" INTEGER,
    "slide_tack" INTEGER,
    "sprint_sp" INTEGER,
    "stand_tack" INTEGER
);

