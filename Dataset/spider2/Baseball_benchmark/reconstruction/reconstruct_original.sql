-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";

-- Reconstruct all_star from vertical split + row partition on a fragment
CREATE VIEW "all_star" AS
SELECT t0.[player_key], t0.[season_year], t0.[game_sequence], t0.[all_star_game_id], t1.[team_code], t0.[league_key], t0.[games_played], t0.[starting_position]
FROM [local_1].[all_star_game_appearances] t0
JOIN (
SELECT [all_star_other_team_records].[__orig_rowid] AS __orig_rowid, [local_1].[all_star_other_team_records].[player_key], [local_1].[all_star_other_team_records].[season_year], [local_1].[all_star_other_team_records].[all_star_game_id], [local_1].[all_star_other_team_records].[team_code], [local_1].[all_star_other_team_records].[league_key], [local_1].[all_star_other_team_records].[starting_position] FROM [local_1].[all_star_other_team_records]
UNION
SELECT [allStarRosterCinDetCleChn].[__orig_rowid] AS __orig_rowid, [local_3].[allStarRosterCinDetCleChn].[playerId], [local_3].[allStarRosterCinDetCleChn].[seasonYear], [local_3].[allStarRosterCinDetCleChn].[gameId], [local_3].[allStarRosterCinDetCleChn].[teamId], [local_3].[allStarRosterCinDetCleChn].[leagueId], [local_3].[allStarRosterCinDetCleChn].[startingPosition] FROM [local_3].[allStarRosterCinDetCleChn]
UNION
SELECT [allStarRosterNyaChaPit].[__orig_rowid] AS __orig_rowid, [local_3].[allStarRosterNyaChaPit].[playerId], [local_3].[allStarRosterNyaChaPit].[seasonYear], [local_3].[allStarRosterNyaChaPit].[gameId], [local_3].[allStarRosterNyaChaPit].[teamId], [local_3].[allStarRosterNyaChaPit].[leagueId], [local_3].[allStarRosterNyaChaPit].[startingPosition] FROM [local_3].[allStarRosterNyaChaPit]
UNION
SELECT [allStarRosterSlnBos].[__orig_rowid] AS __orig_rowid, [local_3].[allStarRosterSlnBos].[playerId], [local_3].[allStarRosterSlnBos].[seasonYear], [local_3].[allStarRosterSlnBos].[gameId], [local_3].[allStarRosterSlnBos].[teamId], [local_3].[allStarRosterSlnBos].[leagueId], [local_3].[allStarRosterSlnBos].[startingPosition] FROM [local_3].[allStarRosterSlnBos]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct appearances from local_2.PlayerSeasonAppearances
CREATE VIEW "appearances" AS
SELECT
    "local_2"."PlayerSeasonAppearances"."SeasonYear" AS "year",
    "local_2"."PlayerSeasonAppearances"."TeamId" AS "team_id",
    "local_2"."PlayerSeasonAppearances"."LeagueId" AS "league_id",
    "local_2"."PlayerSeasonAppearances"."PlayerId" AS "player_id",
    "local_2"."PlayerSeasonAppearances"."GamesTotal" AS "g_all",
    "local_2"."PlayerSeasonAppearances"."GamesStarted" AS "gs",
    "local_2"."PlayerSeasonAppearances"."GamesBatting" AS "g_batting",
    "local_2"."PlayerSeasonAppearances"."GamesDefense" AS "g_defense",
    "local_2"."PlayerSeasonAppearances"."GamesPitcher" AS "g_p",
    "local_2"."PlayerSeasonAppearances"."GamesCatcher" AS "g_c",
    "local_2"."PlayerSeasonAppearances"."GamesFirstBase" AS "g_1b",
    "local_2"."PlayerSeasonAppearances"."GamesSecondBase" AS "g_2b",
    "local_2"."PlayerSeasonAppearances"."GamesThirdBase" AS "g_3b",
    "local_2"."PlayerSeasonAppearances"."GamesShortstop" AS "g_ss",
    "local_2"."PlayerSeasonAppearances"."GamesLeftField" AS "g_lf",
    "local_2"."PlayerSeasonAppearances"."GamesCenterField" AS "g_cf",
    "local_2"."PlayerSeasonAppearances"."GamesRightField" AS "g_rf",
    "local_2"."PlayerSeasonAppearances"."GamesOutfield" AS "g_of",
    "local_2"."PlayerSeasonAppearances"."GamesDesignatedHitter" AS "g_dh",
    "local_2"."PlayerSeasonAppearances"."GamesPinchHitter" AS "g_ph",
    "local_2"."PlayerSeasonAppearances"."GamesPinchRunner" AS "g_pr"
FROM "local_2"."PlayerSeasonAppearances";

-- Reconstruct batting from local_3.regularBattingStats
CREATE VIEW "batting" AS
SELECT
    "local_3"."regularBattingStats"."playerId" AS "player_id",
    "local_3"."regularBattingStats"."seasonYear" AS "year",
    "local_3"."regularBattingStats"."stintNumber" AS "stint",
    "local_3"."regularBattingStats"."teamId" AS "team_id",
    "local_3"."regularBattingStats"."leagueId" AS "league_id",
    "local_3"."regularBattingStats"."games" AS "g",
    "local_3"."regularBattingStats"."atBats" AS "ab",
    "local_3"."regularBattingStats"."runs" AS "r",
    "local_3"."regularBattingStats"."hits" AS "h",
    "local_3"."regularBattingStats"."doubles" AS "double",
    "local_3"."regularBattingStats"."triples" AS "triple",
    "local_3"."regularBattingStats"."homeRuns" AS "hr",
    "local_3"."regularBattingStats"."runsBattedIn" AS "rbi",
    "local_3"."regularBattingStats"."stolenBases" AS "sb",
    "local_3"."regularBattingStats"."caughtStealing" AS "cs",
    "local_3"."regularBattingStats"."walks" AS "bb",
    "local_3"."regularBattingStats"."strikeouts" AS "so",
    "local_3"."regularBattingStats"."intentionalWalks" AS "ibb",
    "local_3"."regularBattingStats"."hitByPitch" AS "hbp",
    "local_3"."regularBattingStats"."sacrificeHits" AS "sh",
    "local_3"."regularBattingStats"."sacrificeFlies" AS "sf",
    "local_3"."regularBattingStats"."groundedIntoDoublePlay" AS "g_idp"
FROM "local_3"."regularBattingStats";

-- Reconstruct batting_postseason from local_3.postseasonBattingStats
CREATE VIEW "batting_postseason" AS
SELECT
    "local_3"."postseasonBattingStats"."seasonYear" AS "year",
    "local_3"."postseasonBattingStats"."roundName" AS "round",
    "local_3"."postseasonBattingStats"."playerId" AS "player_id",
    "local_3"."postseasonBattingStats"."teamId" AS "team_id",
    "local_3"."postseasonBattingStats"."leagueId" AS "league_id",
    "local_3"."postseasonBattingStats"."games" AS "g",
    "local_3"."postseasonBattingStats"."atBats" AS "ab",
    "local_3"."postseasonBattingStats"."runs" AS "r",
    "local_3"."postseasonBattingStats"."hits" AS "h",
    "local_3"."postseasonBattingStats"."doubles" AS "double",
    "local_3"."postseasonBattingStats"."triples" AS "triple",
    "local_3"."postseasonBattingStats"."homeRuns" AS "hr",
    "local_3"."postseasonBattingStats"."runsBattedIn" AS "rbi",
    "local_3"."postseasonBattingStats"."stolenBases" AS "sb",
    "local_3"."postseasonBattingStats"."caughtStealing" AS "cs",
    "local_3"."postseasonBattingStats"."walks" AS "bb",
    "local_3"."postseasonBattingStats"."strikeouts" AS "so",
    "local_3"."postseasonBattingStats"."intentionalWalks" AS "ibb",
    "local_3"."postseasonBattingStats"."hitByPitch" AS "hbp",
    "local_3"."postseasonBattingStats"."sacrificeHits" AS "sh",
    "local_3"."postseasonBattingStats"."sacrificeFlies" AS "sf",
    "local_3"."postseasonBattingStats"."groundedIntoDoublePlay" AS "g_idp"
FROM "local_3"."postseasonBattingStats";

-- Reconstruct college from row partitions (UNION (overlap))
CREATE VIEW "college" AS
SELECT "local_1"."colleges_ca_il_fl"."college_key" AS "college_id", "local_1"."colleges_ca_il_fl"."institution_name" AS "name_full", "local_1"."colleges_ca_il_fl"."city_name" AS "city", "local_1"."colleges_ca_il_fl"."state_code" AS "state", "local_1"."colleges_ca_il_fl"."country_name" AS "country" FROM "local_1"."colleges_ca_il_fl"
UNION
SELECT "local_1"."colleges_tx_ny_oh"."college_key" AS "college_id", "local_1"."colleges_tx_ny_oh"."institution_name" AS "name_full", "local_1"."colleges_tx_ny_oh"."city_name" AS "city", "local_1"."colleges_tx_ny_oh"."state_code" AS "state", "local_1"."colleges_tx_ny_oh"."country_name" AS "country" FROM "local_1"."colleges_tx_ny_oh"
UNION
SELECT "local_1"."colleges_pa_nc_tn"."college_key" AS "college_id", "local_1"."colleges_pa_nc_tn"."institution_name" AS "name_full", "local_1"."colleges_pa_nc_tn"."city_name" AS "city", "local_1"."colleges_pa_nc_tn"."state_code" AS "state", "local_1"."colleges_pa_nc_tn"."country_name" AS "country" FROM "local_1"."colleges_pa_nc_tn"
UNION
SELECT "local_1"."colleges_other_states"."college_key" AS "college_id", "local_1"."colleges_other_states"."institution_name" AS "name_full", "local_1"."colleges_other_states"."city_name" AS "city", "local_1"."colleges_other_states"."state_code" AS "state", "local_1"."colleges_other_states"."country_name" AS "country" FROM "local_1"."colleges_other_states";

-- Reconstruct fielding from local_3.fieldingStats
CREATE VIEW "fielding" AS
SELECT
    "local_3"."fieldingStats"."playerId" AS "player_id",
    "local_3"."fieldingStats"."seasonYear" AS "year",
    "local_3"."fieldingStats"."stintNumber" AS "stint",
    "local_3"."fieldingStats"."teamId" AS "team_id",
    "local_3"."fieldingStats"."leagueId" AS "league_id",
    "local_3"."fieldingStats"."position" AS "pos",
    "local_3"."fieldingStats"."games" AS "g",
    "local_3"."fieldingStats"."gamesStarted" AS "gs",
    "local_3"."fieldingStats"."inningsOuts" AS "inn_outs",
    "local_3"."fieldingStats"."putouts" AS "po",
    "local_3"."fieldingStats"."assists" AS "a",
    "local_3"."fieldingStats"."errors" AS "e",
    "local_3"."fieldingStats"."doublePlays" AS "dp",
    "local_3"."fieldingStats"."passedBalls" AS "pb",
    "local_3"."fieldingStats"."wildPitches" AS "wp",
    "local_3"."fieldingStats"."stolenBases" AS "sb",
    "local_3"."fieldingStats"."caughtStealing" AS "cs",
    "local_3"."fieldingStats"."zoneRating" AS "zr"
FROM "local_3"."fieldingStats";

-- Reconstruct fielding_outfield from local_3.outfieldGamesByPosition
CREATE VIEW "fielding_outfield" AS
SELECT
    "local_3"."outfieldGamesByPosition"."playerId" AS "player_id",
    "local_3"."outfieldGamesByPosition"."seasonYear" AS "year",
    "local_3"."outfieldGamesByPosition"."stintNumber" AS "stint",
    "local_3"."outfieldGamesByPosition"."gamesLeftField" AS "glf",
    "local_3"."outfieldGamesByPosition"."gamesCenterField" AS "gcf",
    "local_3"."outfieldGamesByPosition"."gamesRightField" AS "grf"
FROM "local_3"."outfieldGamesByPosition";

-- Reconstruct fielding_postseason from local_3.postseasonFieldingStats
CREATE VIEW "fielding_postseason" AS
SELECT
    "local_3"."postseasonFieldingStats"."playerId" AS "player_id",
    "local_3"."postseasonFieldingStats"."seasonYear" AS "year",
    "local_3"."postseasonFieldingStats"."teamId" AS "team_id",
    "local_3"."postseasonFieldingStats"."leagueId" AS "league_id",
    "local_3"."postseasonFieldingStats"."roundName" AS "round",
    "local_3"."postseasonFieldingStats"."position" AS "pos",
    "local_3"."postseasonFieldingStats"."games" AS "g",
    "local_3"."postseasonFieldingStats"."gamesStarted" AS "gs",
    "local_3"."postseasonFieldingStats"."inningsOuts" AS "inn_outs",
    "local_3"."postseasonFieldingStats"."putouts" AS "po",
    "local_3"."postseasonFieldingStats"."assists" AS "a",
    "local_3"."postseasonFieldingStats"."errors" AS "e",
    "local_3"."postseasonFieldingStats"."doublePlays" AS "dp",
    "local_3"."postseasonFieldingStats"."triplePlays" AS "tp",
    "local_3"."postseasonFieldingStats"."passedBalls" AS "pb",
    "local_3"."postseasonFieldingStats"."stolenBases" AS "sb",
    "local_3"."postseasonFieldingStats"."caughtStealing" AS "cs"
FROM "local_3"."postseasonFieldingStats";

-- Reconstruct hall_of_fame from local_5.HallOfFameElection
CREATE VIEW "hall_of_fame" AS
SELECT
    "local_5"."HallOfFameElection"."InducteeId" AS "player_id",
    "local_5"."HallOfFameElection"."ElectionYear" AS "yearid",
    "local_5"."HallOfFameElection"."VotingBody" AS "votedby",
    "local_5"."HallOfFameElection"."BallotsCast" AS "ballots",
    "local_5"."HallOfFameElection"."VotesNeeded" AS "needed",
    "local_5"."HallOfFameElection"."VotesReceived" AS "votes",
    "local_5"."HallOfFameElection"."InductionStatus" AS "inducted",
    "local_5"."HallOfFameElection"."InductionCategory" AS "category",
    "local_5"."HallOfFameElection"."VotesNeededNote" AS "needed_note"
FROM "local_5"."HallOfFameElection";

-- Reconstruct home_game from vertical split + row partition on a fragment
CREATE VIEW "home_game" AS
SELECT t0.[SeasonYear], t1.[lg_cd], t1.[team_cd], t0.[ParkId], t0.[SpanStart], t0.[SpanEnd], t0.[GamesCount], t0.[OpeningsCount], t0.[AttendanceCount]
FROM (
SELECT [HomeGameAttendanceAtMostSeventyFour].[__orig_rowid] AS __orig_rowid, [local_2].[HomeGameAttendanceAtMostSeventyFour].[SeasonYear], [local_2].[HomeGameAttendanceAtMostSeventyFour].[ParkId], [local_2].[HomeGameAttendanceAtMostSeventyFour].[SpanStart], [local_2].[HomeGameAttendanceAtMostSeventyFour].[SpanEnd], [local_2].[HomeGameAttendanceAtMostSeventyFour].[GamesCount], [local_2].[HomeGameAttendanceAtMostSeventyFour].[OpeningsCount], [local_2].[HomeGameAttendanceAtMostSeventyFour].[AttendanceCount] FROM [local_2].[HomeGameAttendanceAtMostSeventyFour]
UNION
SELECT [HomeGameAttendanceSeventyFiveToSeventyEight].[__orig_rowid] AS __orig_rowid, [local_2].[HomeGameAttendanceSeventyFiveToSeventyEight].[SeasonYear], [local_2].[HomeGameAttendanceSeventyFiveToSeventyEight].[ParkId], [local_2].[HomeGameAttendanceSeventyFiveToSeventyEight].[SpanStart], [local_2].[HomeGameAttendanceSeventyFiveToSeventyEight].[SpanEnd], [local_2].[HomeGameAttendanceSeventyFiveToSeventyEight].[GamesCount], [local_2].[HomeGameAttendanceSeventyFiveToSeventyEight].[OpeningsCount], [local_2].[HomeGameAttendanceSeventyFiveToSeventyEight].[AttendanceCount] FROM [local_2].[HomeGameAttendanceSeventyFiveToSeventyEight]
UNION
SELECT [home_park_att_gt78_or_null].[__orig_rowid] AS __orig_rowid, [local_4].[home_park_att_gt78_or_null].[yr], [local_4].[home_park_att_gt78_or_null].[park_cd], [local_4].[home_park_att_gt78_or_null].[span_start], [local_4].[home_park_att_gt78_or_null].[span_end], [local_4].[home_park_att_gt78_or_null].[gms], [local_4].[home_park_att_gt78_or_null].[open_cnt], [local_4].[home_park_att_gt78_or_null].[tot_att] FROM [local_4].[home_park_att_gt78_or_null]
) t0
JOIN [local_4].[home_park_league_map] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct manager from local_1.team_manager_seasons
CREATE VIEW "manager" AS
SELECT
    "local_1"."team_manager_seasons"."manager_player_key" AS "player_id",
    "local_1"."team_manager_seasons"."season_year" AS "year",
    "local_1"."team_manager_seasons"."team_code" AS "team_id",
    "local_1"."team_manager_seasons"."league_key" AS "league_id",
    "local_1"."team_manager_seasons"."in_season_indicator" AS "inseason",
    "local_1"."team_manager_seasons"."games_managed" AS "g",
    "local_1"."team_manager_seasons"."games_won" AS "w",
    "local_1"."team_manager_seasons"."games_lost" AS "l",
    "local_1"."team_manager_seasons"."finish_rank" AS "rank",
    "local_1"."team_manager_seasons"."player_manager_flag" AS "plyr_mgr"
FROM "local_1"."team_manager_seasons";

-- Reconstruct manager_award from local_3.managerAwards
CREATE VIEW "manager_award" AS
SELECT
    "local_3"."managerAwards"."managerPlayerId" AS "player_id",
    "local_3"."managerAwards"."awardId" AS "award_id",
    "local_3"."managerAwards"."seasonYear" AS "year",
    "local_3"."managerAwards"."leagueId" AS "league_id",
    "local_3"."managerAwards"."tieIndicator" AS "tie",
    "local_3"."managerAwards"."notesValue" AS "notes"
FROM "local_3"."managerAwards";

-- Reconstruct manager_award_vote from vertical split + row partition on a fragment
CREATE VIEW "manager_award_vote" AS
SELECT t0.[awardId], t0.[seasonYear], t0.[leagueId], t0.[managerPlayerId], t1.[pointsWon], t1.[pointsMax], t0.[firstPlaceVotes]
FROM [local_3].[managerAwardVotesByAward] t0
JOIN (
SELECT [managerAwardVotesLeaguePoints23To69].[__orig_rowid] AS __orig_rowid, [local_3].[managerAwardVotesLeaguePoints23To69].[seasonYear], [local_3].[managerAwardVotesLeaguePoints23To69].[leagueId], [local_3].[managerAwardVotesLeaguePoints23To69].[managerPlayerId], [local_3].[managerAwardVotesLeaguePoints23To69].[pointsWon], [local_3].[managerAwardVotesLeaguePoints23To69].[pointsMax], [local_3].[managerAwardVotesLeaguePoints23To69].[firstPlaceVotes] FROM [local_3].[managerAwardVotesLeaguePoints23To69]
UNION
SELECT [managerAwardVotesLeaguePoints5To22].[__orig_rowid] AS __orig_rowid, [local_3].[managerAwardVotesLeaguePoints5To22].[seasonYear], [local_3].[managerAwardVotesLeaguePoints5To22].[leagueId], [local_3].[managerAwardVotesLeaguePoints5To22].[managerPlayerId], [local_3].[managerAwardVotesLeaguePoints5To22].[pointsWon], [local_3].[managerAwardVotesLeaguePoints5To22].[pointsMax], [local_3].[managerAwardVotesLeaguePoints5To22].[firstPlaceVotes] FROM [local_3].[managerAwardVotesLeaguePoints5To22]
UNION
SELECT [managerAwardVotesLeaguePointsOver69OrNull].[__orig_rowid] AS __orig_rowid, [local_3].[managerAwardVotesLeaguePointsOver69OrNull].[seasonYear], [local_3].[managerAwardVotesLeaguePointsOver69OrNull].[leagueId], [local_3].[managerAwardVotesLeaguePointsOver69OrNull].[managerPlayerId], [local_3].[managerAwardVotesLeaguePointsOver69OrNull].[pointsWon], [local_3].[managerAwardVotesLeaguePointsOver69OrNull].[pointsMax], [local_3].[managerAwardVotesLeaguePointsOver69OrNull].[firstPlaceVotes] FROM [local_3].[managerAwardVotesLeaguePointsOver69OrNull]
UNION
SELECT [managerAwardVotesLeaguePointsUpTo4].[__orig_rowid] AS __orig_rowid, [local_3].[managerAwardVotesLeaguePointsUpTo4].[seasonYear], [local_3].[managerAwardVotesLeaguePointsUpTo4].[leagueId], [local_3].[managerAwardVotesLeaguePointsUpTo4].[managerPlayerId], [local_3].[managerAwardVotesLeaguePointsUpTo4].[pointsWon], [local_3].[managerAwardVotesLeaguePointsUpTo4].[pointsMax], [local_3].[managerAwardVotesLeaguePointsUpTo4].[firstPlaceVotes] FROM [local_3].[managerAwardVotesLeaguePointsUpTo4]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct manager_half from vertical split + row partition on a fragment
CREATE VIEW "manager_half" AS
SELECT t0.[managerPlayerId], t0.[seasonYear], t2.[teamId], t2.[leagueId], t0.[inSeasonIndicator], t0.[halfSeason], t0.[games], t0.[wins], t0.[losses], t0.[rankPosition]
FROM (
SELECT [managerHalfSeasonId14485Games44To52].[__orig_rowid] AS __orig_rowid, [local_3].[managerHalfSeasonId14485Games44To52].[managerPlayerId], [local_3].[managerHalfSeasonId14485Games44To52].[seasonYear], [local_3].[managerHalfSeasonId14485Games44To52].[inSeasonIndicator], [local_3].[managerHalfSeasonId14485Games44To52].[halfSeason], [local_3].[managerHalfSeasonId14485Games44To52].[games], [local_3].[managerHalfSeasonId14485Games44To52].[wins], [local_3].[managerHalfSeasonId14485Games44To52].[losses], [local_3].[managerHalfSeasonId14485Games44To52].[rankPosition] FROM [local_3].[managerHalfSeasonId14485Games44To52]
UNION
SELECT [managerHalfSeasonId14485Games53To56].[__orig_rowid] AS __orig_rowid, [local_3].[managerHalfSeasonId14485Games53To56].[managerPlayerId], [local_3].[managerHalfSeasonId14485Games53To56].[seasonYear], [local_3].[managerHalfSeasonId14485Games53To56].[inSeasonIndicator], [local_3].[managerHalfSeasonId14485Games53To56].[halfSeason], [local_3].[managerHalfSeasonId14485Games53To56].[games], [local_3].[managerHalfSeasonId14485Games53To56].[wins], [local_3].[managerHalfSeasonId14485Games53To56].[losses], [local_3].[managerHalfSeasonId14485Games53To56].[rankPosition] FROM [local_3].[managerHalfSeasonId14485Games53To56]
UNION
SELECT [managerHalfSeasonId14485GamesOver56OrNull].[__orig_rowid] AS __orig_rowid, [local_3].[managerHalfSeasonId14485GamesOver56OrNull].[managerPlayerId], [local_3].[managerHalfSeasonId14485GamesOver56OrNull].[seasonYear], [local_3].[managerHalfSeasonId14485GamesOver56OrNull].[inSeasonIndicator], [local_3].[managerHalfSeasonId14485GamesOver56OrNull].[halfSeason], [local_3].[managerHalfSeasonId14485GamesOver56OrNull].[games], [local_3].[managerHalfSeasonId14485GamesOver56OrNull].[wins], [local_3].[managerHalfSeasonId14485GamesOver56OrNull].[losses], [local_3].[managerHalfSeasonId14485GamesOver56OrNull].[rankPosition] FROM [local_3].[managerHalfSeasonId14485GamesOver56OrNull]
UNION
SELECT [managerHalfSeasonId14485GamesUpTo43].[__orig_rowid] AS __orig_rowid, [local_3].[managerHalfSeasonId14485GamesUpTo43].[managerPlayerId], [local_3].[managerHalfSeasonId14485GamesUpTo43].[seasonYear], [local_3].[managerHalfSeasonId14485GamesUpTo43].[inSeasonIndicator], [local_3].[managerHalfSeasonId14485GamesUpTo43].[halfSeason], [local_3].[managerHalfSeasonId14485GamesUpTo43].[games], [local_3].[managerHalfSeasonId14485GamesUpTo43].[wins], [local_3].[managerHalfSeasonId14485GamesUpTo43].[losses], [local_3].[managerHalfSeasonId14485GamesUpTo43].[rankPosition] FROM [local_3].[managerHalfSeasonId14485GamesUpTo43]
) t0
JOIN [local_3].[managerHalfSeasonId42402] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_3].[managerHalfByLeague] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct park from row partitions (UNION (overlap))
CREATE VIEW "park" AS
SELECT "local_2"."ParkByCitiesPhiladelphiaClevelandBostonChicagoNewYork"."ParkId" AS "park_id", "local_2"."ParkByCitiesPhiladelphiaClevelandBostonChicagoNewYork"."ParkName" AS "park_name", "local_2"."ParkByCitiesPhiladelphiaClevelandBostonChicagoNewYork"."ParkAlias" AS "park_alias", "local_2"."ParkByCitiesPhiladelphiaClevelandBostonChicagoNewYork"."City" AS "city", "local_2"."ParkByCitiesPhiladelphiaClevelandBostonChicagoNewYork"."State" AS "state", "local_2"."ParkByCitiesPhiladelphiaClevelandBostonChicagoNewYork"."Country" AS "country" FROM "local_2"."ParkByCitiesPhiladelphiaClevelandBostonChicagoNewYork"
UNION
SELECT "local_2"."ParkByCitiesBaltimoreWashingtonCincinnatiStLouis"."ParkId" AS "park_id", "local_2"."ParkByCitiesBaltimoreWashingtonCincinnatiStLouis"."ParkName" AS "park_name", "local_2"."ParkByCitiesBaltimoreWashingtonCincinnatiStLouis"."ParkAlias" AS "park_alias", "local_2"."ParkByCitiesBaltimoreWashingtonCincinnatiStLouis"."City" AS "city", "local_2"."ParkByCitiesBaltimoreWashingtonCincinnatiStLouis"."State" AS "state", "local_2"."ParkByCitiesBaltimoreWashingtonCincinnatiStLouis"."Country" AS "country" FROM "local_2"."ParkByCitiesBaltimoreWashingtonCincinnatiStLouis"
UNION
SELECT "local_2"."ParkByCitiesOtherOrNull"."ParkId" AS "park_id", "local_2"."ParkByCitiesOtherOrNull"."ParkName" AS "park_name", "local_2"."ParkByCitiesOtherOrNull"."ParkAlias" AS "park_alias", "local_2"."ParkByCitiesOtherOrNull"."City" AS "city", "local_2"."ParkByCitiesOtherOrNull"."State" AS "state", "local_2"."ParkByCitiesOtherOrNull"."Country" AS "country" FROM "local_2"."ParkByCitiesOtherOrNull";

-- Reconstruct pitching from local_3.regularPitchingStats
CREATE VIEW "pitching" AS
SELECT
    "local_3"."regularPitchingStats"."playerId" AS "player_id",
    "local_3"."regularPitchingStats"."seasonYear" AS "year",
    "local_3"."regularPitchingStats"."stintNumber" AS "stint",
    "local_3"."regularPitchingStats"."teamId" AS "team_id",
    "local_3"."regularPitchingStats"."leagueId" AS "league_id",
    "local_3"."regularPitchingStats"."wins" AS "w",
    "local_3"."regularPitchingStats"."losses" AS "l",
    "local_3"."regularPitchingStats"."games" AS "g",
    "local_3"."regularPitchingStats"."gamesStarted" AS "gs",
    "local_3"."regularPitchingStats"."completeGames" AS "cg",
    "local_3"."regularPitchingStats"."shutouts" AS "sho",
    "local_3"."regularPitchingStats"."saves" AS "sv",
    "local_3"."regularPitchingStats"."outsPitched" AS "ipouts",
    "local_3"."regularPitchingStats"."hitsAllowed" AS "h",
    "local_3"."regularPitchingStats"."earnedRuns" AS "er",
    "local_3"."regularPitchingStats"."homeRunsAllowed" AS "hr",
    "local_3"."regularPitchingStats"."walksAllowed" AS "bb",
    "local_3"."regularPitchingStats"."strikeouts" AS "so",
    "local_3"."regularPitchingStats"."battingAverageOpponents" AS "baopp",
    "local_3"."regularPitchingStats"."earnedRunAverage" AS "era",
    "local_3"."regularPitchingStats"."intentionalWalks" AS "ibb",
    "local_3"."regularPitchingStats"."wildPitches" AS "wp",
    "local_3"."regularPitchingStats"."hitByPitch" AS "hbp",
    "local_3"."regularPitchingStats"."balks" AS "bk",
    "local_3"."regularPitchingStats"."battersFaced" AS "bfp",
    "local_3"."regularPitchingStats"."gamesFinished" AS "gf",
    "local_3"."regularPitchingStats"."runs" AS "r",
    "local_3"."regularPitchingStats"."sacrificeHitsAllowed" AS "sh",
    "local_3"."regularPitchingStats"."sacrificeFliesAllowed" AS "sf",
    "local_3"."regularPitchingStats"."groundedIntoDoublePlay" AS "g_idp"
FROM "local_3"."regularPitchingStats";

-- Reconstruct pitching_postseason from local_3.postseasonPitchingStats
CREATE VIEW "pitching_postseason" AS
SELECT
    "local_3"."postseasonPitchingStats"."playerId" AS "player_id",
    "local_3"."postseasonPitchingStats"."seasonYear" AS "year",
    "local_3"."postseasonPitchingStats"."roundName" AS "round",
    "local_3"."postseasonPitchingStats"."teamId" AS "team_id",
    "local_3"."postseasonPitchingStats"."leagueId" AS "league_id",
    "local_3"."postseasonPitchingStats"."wins" AS "w",
    "local_3"."postseasonPitchingStats"."losses" AS "l",
    "local_3"."postseasonPitchingStats"."games" AS "g",
    "local_3"."postseasonPitchingStats"."gamesStarted" AS "gs",
    "local_3"."postseasonPitchingStats"."completeGames" AS "cg",
    "local_3"."postseasonPitchingStats"."shutouts" AS "sho",
    "local_3"."postseasonPitchingStats"."saves" AS "sv",
    "local_3"."postseasonPitchingStats"."outsPitched" AS "ipouts",
    "local_3"."postseasonPitchingStats"."hitsAllowed" AS "h",
    "local_3"."postseasonPitchingStats"."earnedRuns" AS "er",
    "local_3"."postseasonPitchingStats"."homeRunsAllowed" AS "hr",
    "local_3"."postseasonPitchingStats"."walksAllowed" AS "bb",
    "local_3"."postseasonPitchingStats"."strikeouts" AS "so",
    "local_3"."postseasonPitchingStats"."battingAverageOpponents" AS "baopp",
    "local_3"."postseasonPitchingStats"."earnedRunAverage" AS "era",
    "local_3"."postseasonPitchingStats"."intentionalWalks" AS "ibb",
    "local_3"."postseasonPitchingStats"."wildPitches" AS "wp",
    "local_3"."postseasonPitchingStats"."hitByPitch" AS "hbp",
    "local_3"."postseasonPitchingStats"."balks" AS "bk",
    "local_3"."postseasonPitchingStats"."battersFaced" AS "bfp",
    "local_3"."postseasonPitchingStats"."gamesFinished" AS "gf",
    "local_3"."postseasonPitchingStats"."runs" AS "r",
    "local_3"."postseasonPitchingStats"."sacrificeHitsAllowed" AS "sh",
    "local_3"."postseasonPitchingStats"."sacrificeFliesAllowed" AS "sf",
    "local_3"."postseasonPitchingStats"."groundedIntoDoublePlay" AS "g_idp"
FROM "local_3"."postseasonPitchingStats";

-- Reconstruct player from vertical split + row partition on a fragment
CREATE VIEW "player" AS
SELECT t0.[playerId], t1.[birthYear], t1.[birthMonth], t1.[birthDay], t0.[birthCountry], t0.[birthState], t0.[birthCity], t1.[deathYear], t1.[deathMonth], t1.[deathDay], t1.[deathCountry], t1.[deathState], t1.[deathCity], t0.[firstName], t0.[lastName], t0.[givenName], t0.[weightPounds], t0.[heightInches], t0.[battingHand], t0.[throwingHand], t2.[DebutDate], t2.[FinalGameDate], t0.[retroId], t0.[bbrefId]
FROM [local_3].[playerBioBasic] t0
JOIN [local_3].[playerBioExtended] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [PlayerDebutFinalAfter1921Jul13Through1964Sep23].[__orig_rowid] AS __orig_rowid, [local_5].[PlayerDebutFinalAfter1921Jul13Through1964Sep23].[GivenName], [local_5].[PlayerDebutFinalAfter1921Jul13Through1964Sep23].[Surname], [local_5].[PlayerDebutFinalAfter1921Jul13Through1964Sep23].[ListedWeight], [local_5].[PlayerDebutFinalAfter1921Jul13Through1964Sep23].[ListedHeight], [local_5].[PlayerDebutFinalAfter1921Jul13Through1964Sep23].[DebutDate], [local_5].[PlayerDebutFinalAfter1921Jul13Through1964Sep23].[FinalGameDate], [local_5].[PlayerDebutFinalAfter1921Jul13Through1964Sep23].[BbrefPlayerId] FROM [local_5].[PlayerDebutFinalAfter1921Jul13Through1964Sep23]
UNION
SELECT [PlayerDebutFinalAfter1964Sep23Through1999Jul16].[__orig_rowid] AS __orig_rowid, [local_5].[PlayerDebutFinalAfter1964Sep23Through1999Jul16].[GivenName], [local_5].[PlayerDebutFinalAfter1964Sep23Through1999Jul16].[Surname], [local_5].[PlayerDebutFinalAfter1964Sep23Through1999Jul16].[ListedWeight], [local_5].[PlayerDebutFinalAfter1964Sep23Through1999Jul16].[ListedHeight], [local_5].[PlayerDebutFinalAfter1964Sep23Through1999Jul16].[DebutDate], [local_5].[PlayerDebutFinalAfter1964Sep23Through1999Jul16].[FinalGameDate], [local_5].[PlayerDebutFinalAfter1964Sep23Through1999Jul16].[BbrefPlayerId] FROM [local_5].[PlayerDebutFinalAfter1964Sep23Through1999Jul16]
UNION
SELECT [PlayerDebutFinalAfter1999Jul16OrNull].[__orig_rowid] AS __orig_rowid, [local_5].[PlayerDebutFinalAfter1999Jul16OrNull].[GivenName], [local_5].[PlayerDebutFinalAfter1999Jul16OrNull].[Surname], [local_5].[PlayerDebutFinalAfter1999Jul16OrNull].[ListedWeight], [local_5].[PlayerDebutFinalAfter1999Jul16OrNull].[ListedHeight], [local_5].[PlayerDebutFinalAfter1999Jul16OrNull].[DebutDate], [local_5].[PlayerDebutFinalAfter1999Jul16OrNull].[FinalGameDate], [local_5].[PlayerDebutFinalAfter1999Jul16OrNull].[BbrefPlayerId] FROM [local_5].[PlayerDebutFinalAfter1999Jul16OrNull]
UNION
SELECT [PlayerDebutFinalOnOrBefore1921Jul13].[__orig_rowid] AS __orig_rowid, [local_5].[PlayerDebutFinalOnOrBefore1921Jul13].[GivenName], [local_5].[PlayerDebutFinalOnOrBefore1921Jul13].[Surname], [local_5].[PlayerDebutFinalOnOrBefore1921Jul13].[ListedWeight], [local_5].[PlayerDebutFinalOnOrBefore1921Jul13].[ListedHeight], [local_5].[PlayerDebutFinalOnOrBefore1921Jul13].[DebutDate], [local_5].[PlayerDebutFinalOnOrBefore1921Jul13].[FinalGameDate], [local_5].[PlayerDebutFinalOnOrBefore1921Jul13].[BbrefPlayerId] FROM [local_5].[PlayerDebutFinalOnOrBefore1921Jul13]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct player_award from local_3.playerAwards
CREATE VIEW "player_award" AS
SELECT
    "local_3"."playerAwards"."playerId" AS "player_id",
    "local_3"."playerAwards"."awardId" AS "award_id",
    "local_3"."playerAwards"."seasonYear" AS "year",
    "local_3"."playerAwards"."leagueId" AS "league_id",
    "local_3"."playerAwards"."tieIndicator" AS "tie",
    "local_3"."playerAwards"."notesText" AS "notes"
FROM "local_3"."playerAwards";

-- Reconstruct player_award_vote from local_3.playerAwardVotes
CREATE VIEW "player_award_vote" AS
SELECT
    "local_3"."playerAwardVotes"."awardId" AS "award_id",
    "local_3"."playerAwardVotes"."seasonYear" AS "year",
    "local_3"."playerAwardVotes"."leagueId" AS "league_id",
    "local_3"."playerAwardVotes"."playerId" AS "player_id",
    "local_3"."playerAwardVotes"."pointsWon" AS "points_won",
    "local_3"."playerAwardVotes"."pointsMax" AS "points_max",
    "local_3"."playerAwardVotes"."firstPlaceVotes" AS "votes_first"
FROM "local_3"."playerAwardVotes";

-- Reconstruct player_college from row partitions (UNION (overlap))
CREATE VIEW "player_college" AS
SELECT "local_1"."player_college_before_1950"."player_key" AS "player_id", "local_1"."player_college_before_1950"."college_key" AS "college_id", "local_1"."player_college_before_1950"."college_year" AS "year" FROM "local_1"."player_college_before_1950"
UNION
SELECT "local_1"."player_college_after_1995_or_missing"."player_key" AS "player_id", "local_1"."player_college_after_1995_or_missing"."college_key" AS "college_id", "local_1"."player_college_after_1995_or_missing"."college_year" AS "year" FROM "local_1"."player_college_after_1995_or_missing"
UNION
SELECT "local_3"."playerCollegeYears1950To1981"."playerId" AS "player_id", "local_3"."playerCollegeYears1950To1981"."collegeId" AS "college_id", "local_3"."playerCollegeYears1950To1981"."attendanceYear" AS "year" FROM "local_3"."playerCollegeYears1950To1981"
UNION
SELECT "local_3"."playerCollegeYears1982To1995"."playerId" AS "player_id", "local_3"."playerCollegeYears1982To1995"."collegeId" AS "college_id", "local_3"."playerCollegeYears1982To1995"."attendanceYear" AS "year" FROM "local_3"."playerCollegeYears1982To1995";

-- Reconstruct postseason from vertical split + row partition on a fragment
CREATE VIEW "postseason" AS
SELECT t0.[SeasonYear], t0.[PlayoffRound], t0.[WinnerTeamId], t0.[WinnerLeagueId], t0.[LoserTeamId], t0.[LoserLeagueId], t1.[WinCount], t1.[LossCount], t0.[TieCount]
FROM (
SELECT [PostseasonLosersRoundALCS].[__orig_rowid] AS __orig_rowid, [local_2].[PostseasonLosersRoundALCS].[SeasonYear], [local_2].[PostseasonLosersRoundALCS].[PlayoffRound], [local_2].[PostseasonLosersRoundALCS].[WinnerTeamId], [local_2].[PostseasonLosersRoundALCS].[WinnerLeagueId], [local_2].[PostseasonLosersRoundALCS].[LoserTeamId], [local_2].[PostseasonLosersRoundALCS].[LoserLeagueId], [local_2].[PostseasonLosersRoundALCS].[TieCount] FROM [local_2].[PostseasonLosersRoundALCS]
UNION
SELECT [PostseasonLosersRoundALDS1ALWCNLWCNLDS2AndOther].[__orig_rowid] AS __orig_rowid, [local_2].[PostseasonLosersRoundALDS1ALWCNLWCNLDS2AndOther].[SeasonYear], [local_2].[PostseasonLosersRoundALDS1ALWCNLWCNLDS2AndOther].[PlayoffRound], [local_2].[PostseasonLosersRoundALDS1ALWCNLWCNLDS2AndOther].[WinnerTeamId], [local_2].[PostseasonLosersRoundALDS1ALWCNLWCNLDS2AndOther].[WinnerLeagueId], [local_2].[PostseasonLosersRoundALDS1ALWCNLWCNLDS2AndOther].[LoserTeamId], [local_2].[PostseasonLosersRoundALDS1ALWCNLWCNLDS2AndOther].[LoserLeagueId], [local_2].[PostseasonLosersRoundALDS1ALWCNLWCNLDS2AndOther].[TieCount] FROM [local_2].[PostseasonLosersRoundALDS1ALWCNLWCNLDS2AndOther]
UNION
SELECT [PostseasonLosersRoundALDS2NLDS1].[__orig_rowid] AS __orig_rowid, [local_2].[PostseasonLosersRoundALDS2NLDS1].[SeasonYear], [local_2].[PostseasonLosersRoundALDS2NLDS1].[PlayoffRound], [local_2].[PostseasonLosersRoundALDS2NLDS1].[WinnerTeamId], [local_2].[PostseasonLosersRoundALDS2NLDS1].[WinnerLeagueId], [local_2].[PostseasonLosersRoundALDS2NLDS1].[LoserTeamId], [local_2].[PostseasonLosersRoundALDS2NLDS1].[LoserLeagueId], [local_2].[PostseasonLosersRoundALDS2NLDS1].[TieCount] FROM [local_2].[PostseasonLosersRoundALDS2NLDS1]
UNION
SELECT [PostseasonLosersRoundNLCS].[__orig_rowid] AS __orig_rowid, [local_2].[PostseasonLosersRoundNLCS].[SeasonYear], [local_2].[PostseasonLosersRoundNLCS].[PlayoffRound], [local_2].[PostseasonLosersRoundNLCS].[WinnerTeamId], [local_2].[PostseasonLosersRoundNLCS].[WinnerLeagueId], [local_2].[PostseasonLosersRoundNLCS].[LoserTeamId], [local_2].[PostseasonLosersRoundNLCS].[LoserLeagueId], [local_2].[PostseasonLosersRoundNLCS].[TieCount] FROM [local_2].[PostseasonLosersRoundNLCS]
UNION
SELECT [PostseasonLosersRoundWorldSeries].[__orig_rowid] AS __orig_rowid, [local_2].[PostseasonLosersRoundWorldSeries].[SeasonYear], [local_2].[PostseasonLosersRoundWorldSeries].[PlayoffRound], [local_2].[PostseasonLosersRoundWorldSeries].[WinnerTeamId], [local_2].[PostseasonLosersRoundWorldSeries].[WinnerLeagueId], [local_2].[PostseasonLosersRoundWorldSeries].[LoserTeamId], [local_2].[PostseasonLosersRoundWorldSeries].[LoserLeagueId], [local_2].[PostseasonLosersRoundWorldSeries].[TieCount] FROM [local_2].[PostseasonLosersRoundWorldSeries]
) t0
JOIN [local_2].[PostseasonSeriesOutcome] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct salary from local_3.salaryRecords
CREATE VIEW "salary" AS
SELECT
    "local_3"."salaryRecords"."seasonYear" AS "year",
    "local_3"."salaryRecords"."teamId" AS "team_id",
    "local_3"."salaryRecords"."leagueId" AS "league_id",
    "local_3"."salaryRecords"."playerId" AS "player_id",
    "local_3"."salaryRecords"."salaryAmount" AS "salary"
FROM "local_3"."salaryRecords";

-- Reconstruct team from vertical split + row partition on a fragment
CREATE VIEW "team" AS
SELECT t0.[yr], t1.[lg_cd], t1.[team_cd], t0.[fr_id], t1.[div_cd], t0.[pos_rank], t0.[gms], t0.[g_home_pct], t0.[wins_ct], t0.[losses_ct], t1.[div_win_flag], t0.[wc_win_flag], t1.[lg_win_flag], t0.[ws_win_flag], t0.[runs_ct], t0.[ab_ct], t0.[hits_ct], t0.[dbl_ct], t0.[tpl_ct], t0.[hr_ct], t0.[bb_ct], t0.[so_ct], t0.[sb_ct], t0.[cs_val], t0.[hbp_ct], t0.[sf_ct], t0.[ra_ct], t0.[er_ct], t0.[era_val], t0.[cg_ct], t0.[sho_ct], t0.[sv_ct], t0.[ip_outs], t0.[ha_ct], t0.[hra_ct], t0.[bba_ct], t0.[soa_ct], t0.[errs], t0.[dp_ct], t0.[field_pct], t0.[team_nm], t2.[ParkCode], t0.[att_tot], t2.[BattingParkFactor], t2.[PitchingParkFactor], t1.[team_cd_br], t1.[team_cd_lah45], t0.[team_cd_retro]
FROM [local_4].[team_box_core] t0
JOIN [local_4].[team_box_extra] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [TeamParkFactorAtMost97].[__orig_rowid] AS __orig_rowid, [local_5].[TeamParkFactorAtMost97].[SeasonYear], [local_5].[TeamParkFactorAtMost97].[FranchiseCode], [local_5].[TeamParkFactorAtMost97].[HomeGames], [local_5].[TeamParkFactorAtMost97].[ParkCode], [local_5].[TeamParkFactorAtMost97].[BattingParkFactor], [local_5].[TeamParkFactorAtMost97].[PitchingParkFactor] FROM [local_5].[TeamParkFactorAtMost97]
UNION
SELECT [TeamParkFactorOver100To103].[__orig_rowid] AS __orig_rowid, [local_5].[TeamParkFactorOver100To103].[SeasonYear], [local_5].[TeamParkFactorOver100To103].[FranchiseCode], [local_5].[TeamParkFactorOver100To103].[HomeGames], [local_5].[TeamParkFactorOver100To103].[ParkCode], [local_5].[TeamParkFactorOver100To103].[BattingParkFactor], [local_5].[TeamParkFactorOver100To103].[PitchingParkFactor] FROM [local_5].[TeamParkFactorOver100To103]
UNION
SELECT [TeamParkFactorOver103OrNull].[__orig_rowid] AS __orig_rowid, [local_5].[TeamParkFactorOver103OrNull].[SeasonYear], [local_5].[TeamParkFactorOver103OrNull].[FranchiseCode], [local_5].[TeamParkFactorOver103OrNull].[HomeGames], [local_5].[TeamParkFactorOver103OrNull].[ParkCode], [local_5].[TeamParkFactorOver103OrNull].[BattingParkFactor], [local_5].[TeamParkFactorOver103OrNull].[PitchingParkFactor] FROM [local_5].[TeamParkFactorOver103OrNull]
UNION
SELECT [TeamParkFactorOver97To100].[__orig_rowid] AS __orig_rowid, [local_5].[TeamParkFactorOver97To100].[SeasonYear], [local_5].[TeamParkFactorOver97To100].[FranchiseCode], [local_5].[TeamParkFactorOver97To100].[HomeGames], [local_5].[TeamParkFactorOver97To100].[ParkCode], [local_5].[TeamParkFactorOver97To100].[BattingParkFactor], [local_5].[TeamParkFactorOver97To100].[PitchingParkFactor] FROM [local_5].[TeamParkFactorOver97To100]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct team_franchise from row partitions (UNION (overlap))
CREATE VIEW "team_franchise" AS
SELECT "local_4"."team_franchise_naassoc_misc"."fr_id" AS "franchise_id", "local_4"."team_franchise_naassoc_misc"."fr_name" AS "franchise_name", "local_4"."team_franchise_naassoc_misc"."active_flg" AS "active", "local_4"."team_franchise_naassoc_misc"."na_assoc_cd" AS "na_assoc" FROM "local_4"."team_franchise_naassoc_misc"
UNION
SELECT "local_5"."TeamFranchiseEmptyNAAssoc"."FranchiseCode" AS "franchise_id", "local_5"."TeamFranchiseEmptyNAAssoc"."FranchiseName" AS "franchise_name", "local_5"."TeamFranchiseEmptyNAAssoc"."ActiveFlag" AS "active", "local_5"."TeamFranchiseEmptyNAAssoc"."NaAssociation" AS "na_assoc" FROM "local_5"."TeamFranchiseEmptyNAAssoc";

-- Reconstruct team_half from vertical split + row partition on a fragment
CREATE VIEW "team_half" AS
SELECT t1.[yr], t0.[lg_cd], t0.[team_cd], t0.[half_seas], t0.[div_cd], t0.[div_win_flag], t1.[pos_rank], t2.[gms], t1.[wins_ct], t2.[losses_ct]
FROM (
SELECT [team_half_div_e].[__orig_rowid] AS __orig_rowid, [local_4].[team_half_div_e].[lg_cd], [local_4].[team_half_div_e].[team_cd], [local_4].[team_half_div_e].[half_seas], [local_4].[team_half_div_e].[div_cd], [local_4].[team_half_div_e].[div_win_flag] FROM [local_4].[team_half_div_e]
UNION
SELECT [team_half_div_w_null].[__orig_rowid] AS __orig_rowid, [local_4].[team_half_div_w_null].[lg_cd], [local_4].[team_half_div_w_null].[team_cd], [local_4].[team_half_div_w_null].[half_seas], [local_4].[team_half_div_w_null].[div_cd], [local_4].[team_half_div_w_null].[div_win_flag] FROM [local_4].[team_half_div_w_null]
) t0
JOIN [local_4].[team_half_div_win_stats] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_4].[team_half_legacy_frag] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];
