-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/Baseball/Baseball.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "all_star_game_appearances" (
    "player_key" TEXT,
    "all_star_game_id" TEXT,
    "game_sequence" INTEGER,
    "games_played" NUMERIC,
    "league_key" TEXT,
    "starting_position" NUMERIC,
    "season_year" INTEGER
);

CREATE TABLE "all_star_other_team_records" (
    "player_key" TEXT,
    "all_star_game_id" TEXT,
    "league_key" TEXT,
    "starting_position" NUMERIC,
    "team_code" TEXT,
    "season_year" INTEGER
);

CREATE TABLE "colleges_ca_il_fl" (
    "college_key" TEXT,
    "institution_name" TEXT,
    "city_name" TEXT,
    "state_code" TEXT,
    "country_name" TEXT
);

CREATE TABLE "colleges_tx_ny_oh" (
    "college_key" TEXT,
    "institution_name" TEXT,
    "city_name" TEXT,
    "state_code" TEXT,
    "country_name" TEXT
);

CREATE TABLE "colleges_pa_nc_tn" (
    "college_key" TEXT,
    "institution_name" TEXT,
    "city_name" TEXT,
    "state_code" TEXT,
    "country_name" TEXT
);

CREATE TABLE "colleges_other_states" (
    "college_key" TEXT,
    "institution_name" TEXT,
    "city_name" TEXT,
    "state_code" TEXT,
    "country_name" TEXT
);

CREATE TABLE "team_manager_seasons" (
    "manager_player_key" TEXT,
    "season_year" INTEGER,
    "team_code" TEXT,
    "league_key" TEXT,
    "in_season_indicator" INTEGER,
    "games_managed" INTEGER,
    "games_won" INTEGER,
    "games_lost" INTEGER,
    "finish_rank" NUMERIC,
    "player_manager_flag" TEXT
);

CREATE TABLE "player_college_before_1950" (
    "player_key" TEXT,
    "college_key" TEXT,
    "college_year" INTEGER
);

CREATE TABLE "player_college_after_1995_or_missing" (
    "player_key" TEXT,
    "college_key" TEXT,
    "college_year" INTEGER
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "PlayerSeasonAppearances" (
    "SeasonYear" INTEGER,
    "TeamId" TEXT,
    "LeagueId" TEXT,
    "PlayerId" TEXT,
    "GamesTotal" NUMERIC,
    "GamesStarted" NUMERIC,
    "GamesBatting" INTEGER,
    "GamesDefense" NUMERIC,
    "GamesPitcher" INTEGER,
    "GamesCatcher" INTEGER,
    "GamesFirstBase" INTEGER,
    "GamesSecondBase" INTEGER,
    "GamesThirdBase" INTEGER,
    "GamesShortstop" INTEGER,
    "GamesLeftField" INTEGER,
    "GamesCenterField" INTEGER,
    "GamesRightField" INTEGER,
    "GamesOutfield" INTEGER,
    "GamesDesignatedHitter" NUMERIC,
    "GamesPinchHitter" NUMERIC,
    "GamesPinchRunner" NUMERIC
);

CREATE TABLE "ParkByCitiesPhiladelphiaClevelandBostonChicagoNewYork" (
    "ParkId" TEXT,
    "ParkName" TEXT,
    "ParkAlias" TEXT,
    "City" TEXT,
    "State" TEXT,
    "Country" TEXT
);

CREATE TABLE "ParkByCitiesBaltimoreWashingtonCincinnatiStLouis" (
    "ParkId" TEXT,
    "ParkName" TEXT,
    "ParkAlias" TEXT,
    "City" TEXT,
    "State" TEXT,
    "Country" TEXT
);

CREATE TABLE "ParkByCitiesOtherOrNull" (
    "ParkId" TEXT,
    "ParkName" TEXT,
    "ParkAlias" TEXT,
    "City" TEXT,
    "State" TEXT,
    "Country" TEXT
);

CREATE TABLE "PostseasonLosersRoundWorldSeries" (
    "SeasonYear" INTEGER,
    "LoserTeamId" TEXT,
    "LoserLeagueId" TEXT,
    "WinnerLeagueId" TEXT,
    "PlayoffRound" TEXT,
    "WinnerTeamId" TEXT,
    "TieCount" INTEGER
);

CREATE TABLE "PostseasonLosersRoundALCS" (
    "SeasonYear" INTEGER,
    "LoserTeamId" TEXT,
    "LoserLeagueId" TEXT,
    "WinnerLeagueId" TEXT,
    "PlayoffRound" TEXT,
    "WinnerTeamId" TEXT,
    "TieCount" INTEGER
);

CREATE TABLE "PostseasonLosersRoundNLCS" (
    "SeasonYear" INTEGER,
    "LoserTeamId" TEXT,
    "LoserLeagueId" TEXT,
    "WinnerLeagueId" TEXT,
    "PlayoffRound" TEXT,
    "WinnerTeamId" TEXT,
    "TieCount" INTEGER
);

CREATE TABLE "PostseasonLosersRoundALDS1ALWCNLWCNLDS2AndOther" (
    "SeasonYear" INTEGER,
    "LoserTeamId" TEXT,
    "LoserLeagueId" TEXT,
    "WinnerLeagueId" TEXT,
    "PlayoffRound" TEXT,
    "WinnerTeamId" TEXT,
    "TieCount" INTEGER
);

CREATE TABLE "PostseasonLosersRoundALDS2NLDS1" (
    "SeasonYear" INTEGER,
    "LoserTeamId" TEXT,
    "LoserLeagueId" TEXT,
    "WinnerLeagueId" TEXT,
    "PlayoffRound" TEXT,
    "WinnerTeamId" TEXT,
    "TieCount" INTEGER
);

CREATE TABLE "PostseasonSeriesOutcome" (
    "SeasonYear" INTEGER,
    "LoserTeamId" TEXT,
    "LossCount" INTEGER,
    "PlayoffRound" TEXT,
    "WinnerTeamId" TEXT,
    "TieCount" INTEGER,
    "WinCount" INTEGER
);

CREATE TABLE "HomeGameAttendanceAtMostSeventyFour" (
    "ParkId" TEXT,
    "SpanStart" TEXT,
    "AttendanceCount" INTEGER,
    "GamesCount" INTEGER,
    "OpeningsCount" INTEGER,
    "SpanEnd" TEXT,
    "SeasonYear" INTEGER
);

CREATE TABLE "HomeGameAttendanceSeventyFiveToSeventyEight" (
    "ParkId" TEXT,
    "SpanStart" TEXT,
    "AttendanceCount" INTEGER,
    "GamesCount" INTEGER,
    "OpeningsCount" INTEGER,
    "SpanEnd" TEXT,
    "SeasonYear" INTEGER
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "regularBattingStats" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "teamId" TEXT,
    "leagueId" TEXT,
    "games" INTEGER,
    "atBats" NUMERIC,
    "runs" NUMERIC,
    "hits" NUMERIC,
    "doubles" NUMERIC,
    "triples" NUMERIC,
    "homeRuns" NUMERIC,
    "runsBattedIn" NUMERIC,
    "stolenBases" NUMERIC,
    "caughtStealing" NUMERIC,
    "walks" NUMERIC,
    "strikeouts" NUMERIC,
    "intentionalWalks" NUMERIC,
    "hitByPitch" NUMERIC,
    "sacrificeHits" NUMERIC,
    "sacrificeFlies" NUMERIC,
    "groundedIntoDoublePlay" NUMERIC
);

CREATE TABLE "postseasonBattingStats" (
    "seasonYear" INTEGER,
    "roundName" TEXT,
    "playerId" TEXT,
    "teamId" TEXT,
    "leagueId" TEXT,
    "games" INTEGER,
    "atBats" INTEGER,
    "runs" INTEGER,
    "hits" INTEGER,
    "doubles" INTEGER,
    "triples" INTEGER,
    "homeRuns" INTEGER,
    "runsBattedIn" INTEGER,
    "stolenBases" INTEGER,
    "caughtStealing" NUMERIC,
    "walks" INTEGER,
    "strikeouts" INTEGER,
    "intentionalWalks" NUMERIC,
    "hitByPitch" NUMERIC,
    "sacrificeHits" NUMERIC,
    "sacrificeFlies" NUMERIC,
    "groundedIntoDoublePlay" NUMERIC
);

CREATE TABLE "fieldingStats" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "teamId" TEXT,
    "leagueId" TEXT,
    "position" TEXT,
    "games" INTEGER,
    "gamesStarted" NUMERIC,
    "inningsOuts" NUMERIC,
    "putouts" NUMERIC,
    "assists" NUMERIC,
    "errors" NUMERIC,
    "doublePlays" NUMERIC,
    "passedBalls" NUMERIC,
    "wildPitches" NUMERIC,
    "stolenBases" NUMERIC,
    "caughtStealing" NUMERIC,
    "zoneRating" NUMERIC
);

CREATE TABLE "outfieldGamesByPosition" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "gamesLeftField" NUMERIC,
    "gamesCenterField" NUMERIC,
    "gamesRightField" NUMERIC
);

CREATE TABLE "postseasonFieldingStats" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "leagueId" TEXT,
    "roundName" TEXT,
    "position" TEXT,
    "games" INTEGER,
    "gamesStarted" NUMERIC,
    "inningsOuts" NUMERIC,
    "putouts" INTEGER,
    "assists" INTEGER,
    "errors" INTEGER,
    "doublePlays" INTEGER,
    "triplePlays" INTEGER,
    "passedBalls" NUMERIC,
    "stolenBases" NUMERIC,
    "caughtStealing" NUMERIC
);

CREATE TABLE "managerAwards" (
    "managerPlayerId" TEXT,
    "awardId" TEXT,
    "seasonYear" INTEGER,
    "leagueId" TEXT,
    "tieIndicator" TEXT,
    "notesValue" NUMERIC
);

CREATE TABLE "managerAwardVotesByAward" (
    "seasonYear" INTEGER,
    "managerPlayerId" TEXT,
    "awardId" TEXT,
    "leagueId" TEXT,
    "firstPlaceVotes" INTEGER
);

CREATE TABLE "managerAwardVotesLeaguePointsUpTo4" (
    "seasonYear" INTEGER,
    "managerPlayerId" TEXT,
    "leagueId" TEXT,
    "pointsMax" INTEGER,
    "pointsWon" INTEGER,
    "firstPlaceVotes" INTEGER
);

CREATE TABLE "managerAwardVotesLeaguePoints5To22" (
    "seasonYear" INTEGER,
    "managerPlayerId" TEXT,
    "leagueId" TEXT,
    "pointsMax" INTEGER,
    "pointsWon" INTEGER,
    "firstPlaceVotes" INTEGER
);

CREATE TABLE "managerAwardVotesLeaguePoints23To69" (
    "seasonYear" INTEGER,
    "managerPlayerId" TEXT,
    "leagueId" TEXT,
    "pointsMax" INTEGER,
    "pointsWon" INTEGER,
    "firstPlaceVotes" INTEGER
);

CREATE TABLE "managerAwardVotesLeaguePointsOver69OrNull" (
    "seasonYear" INTEGER,
    "managerPlayerId" TEXT,
    "leagueId" TEXT,
    "pointsMax" INTEGER,
    "pointsWon" INTEGER,
    "firstPlaceVotes" INTEGER
);

CREATE TABLE "managerHalfSeasonId14485GamesUpTo43" (
    "managerPlayerId" TEXT,
    "halfSeason" INTEGER,
    "games" INTEGER,
    "inSeasonIndicator" INTEGER,
    "losses" INTEGER,
    "rankPosition" INTEGER,
    "wins" INTEGER,
    "seasonYear" INTEGER
);

CREATE TABLE "managerHalfSeasonId14485Games44To52" (
    "managerPlayerId" TEXT,
    "halfSeason" INTEGER,
    "games" INTEGER,
    "inSeasonIndicator" INTEGER,
    "losses" INTEGER,
    "rankPosition" INTEGER,
    "wins" INTEGER,
    "seasonYear" INTEGER
);

CREATE TABLE "managerHalfSeasonId14485Games53To56" (
    "managerPlayerId" TEXT,
    "halfSeason" INTEGER,
    "games" INTEGER,
    "inSeasonIndicator" INTEGER,
    "losses" INTEGER,
    "rankPosition" INTEGER,
    "wins" INTEGER,
    "seasonYear" INTEGER
);

CREATE TABLE "managerHalfSeasonId14485GamesOver56OrNull" (
    "managerPlayerId" TEXT,
    "halfSeason" INTEGER,
    "games" INTEGER,
    "inSeasonIndicator" INTEGER,
    "losses" INTEGER,
    "rankPosition" INTEGER,
    "wins" INTEGER,
    "seasonYear" INTEGER
);

CREATE TABLE "managerHalfSeasonId42402" (
    "managerPlayerId" TEXT,
    "halfSeason" INTEGER,
    "games" INTEGER,
    "inSeasonIndicator" INTEGER,
    "rankPosition" INTEGER,
    "seasonYear" INTEGER
);

CREATE TABLE "managerHalfByLeague" (
    "managerPlayerId" TEXT,
    "halfSeason" INTEGER,
    "leagueId" TEXT,
    "teamId" TEXT
);

CREATE TABLE "regularPitchingStats" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "stintNumber" INTEGER,
    "teamId" TEXT,
    "leagueId" TEXT,
    "wins" INTEGER,
    "losses" INTEGER,
    "games" INTEGER,
    "gamesStarted" INTEGER,
    "completeGames" INTEGER,
    "shutouts" INTEGER,
    "saves" INTEGER,
    "outsPitched" NUMERIC,
    "hitsAllowed" INTEGER,
    "earnedRuns" INTEGER,
    "homeRunsAllowed" INTEGER,
    "walksAllowed" INTEGER,
    "strikeouts" INTEGER,
    "battingAverageOpponents" NUMERIC,
    "earnedRunAverage" NUMERIC,
    "intentionalWalks" NUMERIC,
    "wildPitches" NUMERIC,
    "hitByPitch" NUMERIC,
    "balks" INTEGER,
    "battersFaced" NUMERIC,
    "gamesFinished" NUMERIC,
    "runs" INTEGER,
    "sacrificeHitsAllowed" NUMERIC,
    "sacrificeFliesAllowed" NUMERIC,
    "groundedIntoDoublePlay" NUMERIC
);

CREATE TABLE "postseasonPitchingStats" (
    "playerId" TEXT,
    "seasonYear" INTEGER,
    "roundName" TEXT,
    "teamId" TEXT,
    "leagueId" TEXT,
    "wins" INTEGER,
    "losses" INTEGER,
    "games" INTEGER,
    "gamesStarted" INTEGER,
    "completeGames" INTEGER,
    "shutouts" INTEGER,
    "saves" INTEGER,
    "outsPitched" INTEGER,
    "hitsAllowed" INTEGER,
    "earnedRuns" INTEGER,
    "homeRunsAllowed" INTEGER,
    "walksAllowed" INTEGER,
    "strikeouts" INTEGER,
    "battingAverageOpponents" TEXT,
    "earnedRunAverage" NUMERIC,
    "intentionalWalks" NUMERIC,
    "wildPitches" NUMERIC,
    "hitByPitch" NUMERIC,
    "balks" NUMERIC,
    "battersFaced" NUMERIC,
    "gamesFinished" INTEGER,
    "runs" INTEGER,
    "sacrificeHitsAllowed" NUMERIC,
    "sacrificeFliesAllowed" NUMERIC,
    "groundedIntoDoublePlay" NUMERIC
);

CREATE TABLE "playerBioBasic" (
    "bbrefId" TEXT,
    "battingHand" TEXT,
    "birthCity" TEXT,
    "birthCountry" TEXT,
    "birthState" TEXT,
    "heightInches" NUMERIC,
    "firstName" TEXT,
    "givenName" TEXT,
    "lastName" TEXT,
    "playerId" TEXT,
    "retroId" TEXT,
    "throwingHand" TEXT,
    "weightPounds" NUMERIC
);

CREATE TABLE "playerBioExtended" (
    "bbrefId" TEXT,
    "battingHand" TEXT,
    "birthCity" TEXT,
    "birthCountry" TEXT,
    "birthDay" NUMERIC,
    "birthMonth" NUMERIC,
    "birthState" TEXT,
    "birthYear" NUMERIC,
    "deathCity" TEXT,
    "deathCountry" TEXT,
    "deathDay" NUMERIC,
    "deathMonth" NUMERIC,
    "deathState" TEXT,
    "deathYear" NUMERIC,
    "givenName" TEXT,
    "throwingHand" TEXT
);

CREATE TABLE "playerAwards" (
    "playerId" TEXT,
    "awardId" TEXT,
    "seasonYear" INTEGER,
    "leagueId" TEXT,
    "tieIndicator" TEXT,
    "notesText" TEXT
);

CREATE TABLE "playerAwardVotes" (
    "awardId" TEXT,
    "seasonYear" INTEGER,
    "leagueId" TEXT,
    "playerId" TEXT,
    "pointsWon" NUMERIC,
    "pointsMax" INTEGER,
    "firstPlaceVotes" NUMERIC
);

CREATE TABLE "salaryRecords" (
    "seasonYear" INTEGER,
    "teamId" TEXT,
    "leagueId" TEXT,
    "playerId" TEXT,
    "salaryAmount" INTEGER
);

CREATE TABLE "allStarRosterNyaChaPit" (
    "playerId" TEXT,
    "gameId" TEXT,
    "leagueId" TEXT,
    "startingPosition" NUMERIC,
    "teamId" TEXT,
    "seasonYear" INTEGER
);

CREATE TABLE "allStarRosterSlnBos" (
    "playerId" TEXT,
    "gameId" TEXT,
    "leagueId" TEXT,
    "startingPosition" NUMERIC,
    "teamId" TEXT,
    "seasonYear" INTEGER
);

CREATE TABLE "allStarRosterCinDetCleChn" (
    "playerId" TEXT,
    "gameId" TEXT,
    "leagueId" TEXT,
    "startingPosition" NUMERIC,
    "teamId" TEXT,
    "seasonYear" INTEGER
);

CREATE TABLE "playerCollegeYears1950To1981" (
    "playerId" TEXT,
    "collegeId" TEXT,
    "attendanceYear" INTEGER
);

CREATE TABLE "playerCollegeYears1982To1995" (
    "playerId" TEXT,
    "collegeId" TEXT,
    "attendanceYear" INTEGER
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "home_park_att_gt78_or_null" (
    "park_cd" TEXT,
    "span_start" TEXT,
    "tot_att" INTEGER,
    "gms" INTEGER,
    "open_cnt" INTEGER,
    "span_end" TEXT,
    "yr" INTEGER
);

CREATE TABLE "home_park_league_map" (
    "park_cd" TEXT,
    "span_start" TEXT,
    "lg_cd" TEXT,
    "open_cnt" INTEGER,
    "span_end" TEXT,
    "team_cd" TEXT,
    "yr" INTEGER
);

CREATE TABLE "team_box_core" (
    "yr" INTEGER,
    "fr_id" TEXT,
    "ab_ct" INTEGER,
    "att_tot" NUMERIC,
    "bb_ct" INTEGER,
    "bba_ct" INTEGER,
    "cg_ct" INTEGER,
    "cs_val" NUMERIC,
    "dbl_ct" INTEGER,
    "dp_ct" NUMERIC,
    "errs" INTEGER,
    "er_ct" INTEGER,
    "era_val" NUMERIC,
    "field_pct" NUMERIC,
    "gms" INTEGER,
    "g_home_pct" NUMERIC,
    "hits_ct" INTEGER,
    "ha_ct" INTEGER,
    "hbp_ct" NUMERIC,
    "hr_ct" INTEGER,
    "hra_ct" INTEGER,
    "ip_outs" INTEGER,
    "losses_ct" INTEGER,
    "team_nm" TEXT,
    "runs_ct" INTEGER,
    "ra_ct" INTEGER,
    "pos_rank" INTEGER,
    "sb_ct" NUMERIC,
    "sf_ct" NUMERIC,
    "sho_ct" INTEGER,
    "so_ct" NUMERIC,
    "soa_ct" INTEGER,
    "sv_ct" INTEGER,
    "team_cd_retro" TEXT,
    "tpl_ct" INTEGER,
    "wins_ct" INTEGER,
    "wc_win_flag" TEXT,
    "ws_win_flag" TEXT
);

CREATE TABLE "team_box_extra" (
    "yr" INTEGER,
    "fr_id" TEXT,
    "ab_ct" INTEGER,
    "att_tot" NUMERIC,
    "bb_ct" INTEGER,
    "cg_ct" INTEGER,
    "cs_val" NUMERIC,
    "div_cd" TEXT,
    "div_win_flag" TEXT,
    "dp_ct" NUMERIC,
    "errs" INTEGER,
    "era_val" NUMERIC,
    "field_pct" NUMERIC,
    "lg_cd" TEXT,
    "lg_win_flag" TEXT,
    "team_nm" TEXT,
    "pos_rank" INTEGER,
    "sb_ct" NUMERIC,
    "sf_ct" NUMERIC,
    "sv_ct" INTEGER,
    "team_cd" TEXT,
    "team_cd_br" TEXT,
    "team_cd_lah45" TEXT,
    "team_cd_retro" TEXT,
    "wins_ct" INTEGER,
    "wc_win_flag" TEXT,
    "ws_win_flag" TEXT
);

CREATE TABLE "team_half_div_e" (
    "team_cd" TEXT,
    "half_seas" INTEGER,
    "div_cd" TEXT,
    "div_win_flag" TEXT,
    "lg_cd" TEXT
);

CREATE TABLE "team_half_div_w_null" (
    "team_cd" TEXT,
    "half_seas" INTEGER,
    "div_cd" TEXT,
    "div_win_flag" TEXT,
    "lg_cd" TEXT
);

CREATE TABLE "team_half_div_win_stats" (
    "team_cd" TEXT,
    "half_seas" INTEGER,
    "div_win_flag" TEXT,
    "pos_rank" INTEGER,
    "wins_ct" INTEGER,
    "yr" INTEGER
);

CREATE TABLE "team_half_legacy_frag" (
    "team_cd" TEXT,
    "half_seas" INTEGER,
    "gms" INTEGER,
    "losses_ct" INTEGER,
    "pos_rank" INTEGER,
    "wins_ct" INTEGER,
    "yr" INTEGER
);

CREATE TABLE "team_franchise_naassoc_misc" (
    "fr_id" TEXT,
    "fr_name" TEXT,
    "active_flg" TEXT,
    "na_assoc_cd" TEXT
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "HallOfFameElection" (
    "InducteeId" TEXT,
    "ElectionYear" INTEGER,
    "VotingBody" TEXT,
    "BallotsCast" NUMERIC,
    "VotesNeeded" NUMERIC,
    "VotesReceived" NUMERIC,
    "InductionStatus" TEXT,
    "InductionCategory" TEXT,
    "VotesNeededNote" TEXT
);

CREATE TABLE "TeamFranchiseEmptyNAAssoc" (
    "FranchiseCode" TEXT,
    "FranchiseName" TEXT,
    "ActiveFlag" TEXT,
    "NaAssociation" TEXT
);

CREATE TABLE "PlayerDebutFinalOnOrBefore1921Jul13" (
    "BbrefPlayerId" TEXT,
    "DebutDate" TEXT,
    "FinalGameDate" TEXT,
    "ListedHeight" NUMERIC,
    "GivenName" TEXT,
    "Surname" TEXT,
    "ListedWeight" NUMERIC
);

CREATE TABLE "PlayerDebutFinalAfter1921Jul13Through1964Sep23" (
    "BbrefPlayerId" TEXT,
    "DebutDate" TEXT,
    "FinalGameDate" TEXT,
    "ListedHeight" NUMERIC,
    "GivenName" TEXT,
    "Surname" TEXT,
    "ListedWeight" NUMERIC
);

CREATE TABLE "PlayerDebutFinalAfter1964Sep23Through1999Jul16" (
    "BbrefPlayerId" TEXT,
    "DebutDate" TEXT,
    "FinalGameDate" TEXT,
    "ListedHeight" NUMERIC,
    "GivenName" TEXT,
    "Surname" TEXT,
    "ListedWeight" NUMERIC
);

CREATE TABLE "PlayerDebutFinalAfter1999Jul16OrNull" (
    "BbrefPlayerId" TEXT,
    "DebutDate" TEXT,
    "FinalGameDate" TEXT,
    "ListedHeight" NUMERIC,
    "GivenName" TEXT,
    "Surname" TEXT,
    "ListedWeight" NUMERIC
);

CREATE TABLE "TeamParkFactorAtMost97" (
    "SeasonYear" INTEGER,
    "FranchiseCode" TEXT,
    "BattingParkFactor" INTEGER,
    "HomeGames" NUMERIC,
    "ParkCode" TEXT,
    "PitchingParkFactor" INTEGER
);

CREATE TABLE "TeamParkFactorOver97To100" (
    "SeasonYear" INTEGER,
    "FranchiseCode" TEXT,
    "BattingParkFactor" INTEGER,
    "HomeGames" NUMERIC,
    "ParkCode" TEXT,
    "PitchingParkFactor" INTEGER
);

CREATE TABLE "TeamParkFactorOver100To103" (
    "SeasonYear" INTEGER,
    "FranchiseCode" TEXT,
    "BattingParkFactor" INTEGER,
    "HomeGames" NUMERIC,
    "ParkCode" TEXT,
    "PitchingParkFactor" INTEGER
);

CREATE TABLE "TeamParkFactorOver103OrNull" (
    "SeasonYear" INTEGER,
    "FranchiseCode" TEXT,
    "BattingParkFactor" INTEGER,
    "HomeGames" NUMERIC,
    "ParkCode" TEXT,
    "PitchingParkFactor" INTEGER
);

