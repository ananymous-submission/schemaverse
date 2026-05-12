-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct Bowler_Scores from vertical split + row partition on a fragment
CREATE VIEW "Bowler_Scores" AS
SELECT t0.[match_id], t0.[game_number], t0.[bowler_id], t0.[raw_score], t0.[handicap_score], t1.[wonGame]
FROM (
SELECT [bowler_scores_handicap_187_189_194_196_198].[__orig_rowid] AS __orig_rowid, [local_1].[bowler_scores_handicap_187_189_194_196_198].[match_id], [local_1].[bowler_scores_handicap_187_189_194_196_198].[game_number], [local_1].[bowler_scores_handicap_187_189_194_196_198].[bowler_id], [local_1].[bowler_scores_handicap_187_189_194_196_198].[raw_score], [local_1].[bowler_scores_handicap_187_189_194_196_198].[handicap_score] FROM [local_1].[bowler_scores_handicap_187_189_194_196_198]
UNION
SELECT [bowler_scores_handicap_192_193_195_200].[__orig_rowid] AS __orig_rowid, [local_1].[bowler_scores_handicap_192_193_195_200].[match_id], [local_1].[bowler_scores_handicap_192_193_195_200].[game_number], [local_1].[bowler_scores_handicap_192_193_195_200].[bowler_id], [local_1].[bowler_scores_handicap_192_193_195_200].[raw_score], [local_1].[bowler_scores_handicap_192_193_195_200].[handicap_score] FROM [local_1].[bowler_scores_handicap_192_193_195_200]
UNION
SELECT [bowlerHandicapScoresOtherBucket].[__orig_rowid] AS __orig_rowid, [local_2].[bowlerHandicapScoresOtherBucket].[matchId], [local_2].[bowlerHandicapScoresOtherBucket].[gameNumber], [local_2].[bowlerHandicapScoresOtherBucket].[bowlerId], [local_2].[bowlerHandicapScoresOtherBucket].[rawScore], [local_2].[bowlerHandicapScoresOtherBucket].[handicapScore] FROM [local_2].[bowlerHandicapScoresOtherBucket]
) t0
JOIN [local_2].[bowlerHandicapScoresStandard] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct Bowler_Scores_Archive from vertical (column) split (2 fragments)
CREATE VIEW "Bowler_Scores_Archive" AS
SELECT
    t0."MatchIdentifier" AS "MatchID",
    t0."GameSequence" AS "GameNumber",
    t0."BowlerIdentifier" AS "BowlerID",
    t0."RawScoreValue" AS "RawScore",
    t0."HandicapScoreValue" AS "HandiCapScore",
    t0."GameWonFlag" AS "WonGame"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "MatchIdentifier", "GameSequence", "BowlerIdentifier" ORDER BY rowid) AS __rn FROM "local_3"."ArchivedBowlerHandicapResult") t0
JOIN "local_3"."ArchivedBowlerHandicapScore" t1 ON t0."MatchIdentifier" IS t1."MatchIdentifier" AND t0."GameSequence" IS t1."GameSequence" AND t0."BowlerIdentifier" IS t1."BowlerIdentifier" AND t0.__rn = t1.__rn;

-- Reconstruct Bowlers from vertical (column) split (3 fragments)
CREATE VIEW "Bowlers" AS
SELECT
    t0."bowler_id" AS "BowlerID",
    t1."last_name" AS "BowlerLastName",
    t1."name" AS "BowlerFirstName",
    t0."middle_initial" AS "BowlerMiddleInit",
    t1."address" AS "BowlerAddress",
    t0."city" AS "BowlerCity",
    t1."state" AS "BowlerState",
    t0."postal_code" AS "BowlerZip",
    t1."phone_number" AS "BowlerPhoneNumber",
    t0."team_id" AS "TeamID",
    t2."totalPins" AS "BowlerTotalPins",
    t2."gamesBowled" AS "BowlerGamesBowled",
    t0."current_average" AS "BowlerCurrentAverage",
    t0."current_handicap" AS "BowlerCurrentHcp"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "bowler_id" ORDER BY rowid) AS __rn FROM "local_1"."bowler_city_stats") t0
JOIN "local_1"."bowler_profiles" t1 ON t0."bowler_id" IS t1."bowler_id" AND t0.__rn = t1.__rn
JOIN "local_2"."bowlersRoster" t2 ON t0."bowler_id" IS t2."bowlerId" AND t0.__rn = t2.__rn;

-- Reconstruct Match_Games from row partitions (UNION (overlap))
CREATE VIEW "Match_Games" AS
SELECT "local_2"."matchGamesWinningTeamUpToTwo"."matchId" AS "MatchID", "local_2"."matchGamesWinningTeamUpToTwo"."gameNumber" AS "GameNumber", "local_2"."matchGamesWinningTeamUpToTwo"."winningTeamId" AS "WinningTeamID" FROM "local_2"."matchGamesWinningTeamUpToTwo"
UNION
SELECT "local_2"."matchGamesWinningTeamGreaterThanTwoUpToFour"."matchId" AS "MatchID", "local_2"."matchGamesWinningTeamGreaterThanTwoUpToFour"."gameNumber" AS "GameNumber", "local_2"."matchGamesWinningTeamGreaterThanTwoUpToFour"."winningTeamId" AS "WinningTeamID" FROM "local_2"."matchGamesWinningTeamGreaterThanTwoUpToFour"
UNION
SELECT "local_2"."matchGamesWinningTeamGreaterThanFourUpToSix"."matchId" AS "MatchID", "local_2"."matchGamesWinningTeamGreaterThanFourUpToSix"."gameNumber" AS "GameNumber", "local_2"."matchGamesWinningTeamGreaterThanFourUpToSix"."winningTeamId" AS "WinningTeamID" FROM "local_2"."matchGamesWinningTeamGreaterThanFourUpToSix"
UNION
SELECT "local_2"."matchGamesWinningTeamGreaterThanSixOrNull"."matchId" AS "MatchID", "local_2"."matchGamesWinningTeamGreaterThanSixOrNull"."gameNumber" AS "GameNumber", "local_2"."matchGamesWinningTeamGreaterThanSixOrNull"."winningTeamId" AS "WinningTeamID" FROM "local_2"."matchGamesWinningTeamGreaterThanSixOrNull";

-- Reconstruct Match_Games_Archive from local_3.ArchivedMatchGame
CREATE VIEW "Match_Games_Archive" AS
SELECT
    "local_3"."ArchivedMatchGame"."MatchIdentifier" AS "MatchID",
    "local_3"."ArchivedMatchGame"."GameSequence" AS "GameNumber",
    "local_3"."ArchivedMatchGame"."WinningTeamIdentifier" AS "WinningTeamID"
FROM "local_3"."ArchivedMatchGame";

-- Reconstruct Teams from local_1.team_directory
CREATE VIEW "Teams" AS
SELECT
    "local_1"."team_directory"."team_id" AS "TeamID",
    "local_1"."team_directory"."team_name" AS "TeamName",
    "local_1"."team_directory"."captain_id" AS "CaptainID"
FROM "local_1"."team_directory";

-- Reconstruct Tournaments from local_1.tournament_events
CREATE VIEW "Tournaments" AS
SELECT
    "local_1"."tournament_events"."tournament_id" AS "TourneyID",
    "local_1"."tournament_events"."event_date" AS "TourneyDate",
    "local_1"."tournament_events"."location" AS "TourneyLocation"
FROM "local_1"."tournament_events";

-- Reconstruct Tournaments_Archive from local_2.archivedTournaments
CREATE VIEW "Tournaments_Archive" AS
SELECT
    "local_2"."archivedTournaments"."tournamentId" AS "TourneyID",
    "local_2"."archivedTournaments"."tournamentDate" AS "TourneyDate",
    "local_2"."archivedTournaments"."location" AS "TourneyLocation"
FROM "local_2"."archivedTournaments";

-- Reconstruct Tourney_Matches from row partitions (UNION (overlap))
CREATE VIEW "Tourney_Matches" AS
SELECT "local_1"."tournament_matches_lanes_15_16"."match_id" AS "MatchID", "local_1"."tournament_matches_lanes_15_16"."tournament_id" AS "TourneyID", "local_1"."tournament_matches_lanes_15_16"."lanes_label" AS "Lanes", "local_1"."tournament_matches_lanes_15_16"."odd_lane_team_id" AS "OddLaneTeamID", "local_1"."tournament_matches_lanes_15_16"."even_lane_team_id" AS "EvenLaneTeamID" FROM "local_1"."tournament_matches_lanes_15_16"
UNION
SELECT "local_1"."tournament_matches_lanes_11_12_19_20"."match_id" AS "MatchID", "local_1"."tournament_matches_lanes_11_12_19_20"."tournament_id" AS "TourneyID", "local_1"."tournament_matches_lanes_11_12_19_20"."lanes_label" AS "Lanes", "local_1"."tournament_matches_lanes_11_12_19_20"."odd_lane_team_id" AS "OddLaneTeamID", "local_1"."tournament_matches_lanes_11_12_19_20"."even_lane_team_id" AS "EvenLaneTeamID" FROM "local_1"."tournament_matches_lanes_11_12_19_20"
UNION
SELECT "local_1"."tournament_matches_lanes_13_14"."match_id" AS "MatchID", "local_1"."tournament_matches_lanes_13_14"."tournament_id" AS "TourneyID", "local_1"."tournament_matches_lanes_13_14"."lanes_label" AS "Lanes", "local_1"."tournament_matches_lanes_13_14"."odd_lane_team_id" AS "OddLaneTeamID", "local_1"."tournament_matches_lanes_13_14"."even_lane_team_id" AS "EvenLaneTeamID" FROM "local_1"."tournament_matches_lanes_13_14"
UNION
SELECT "local_1"."tournament_matches_lanes_17_18"."match_id" AS "MatchID", "local_1"."tournament_matches_lanes_17_18"."tournament_id" AS "TourneyID", "local_1"."tournament_matches_lanes_17_18"."lanes_label" AS "Lanes", "local_1"."tournament_matches_lanes_17_18"."odd_lane_team_id" AS "OddLaneTeamID", "local_1"."tournament_matches_lanes_17_18"."even_lane_team_id" AS "EvenLaneTeamID" FROM "local_1"."tournament_matches_lanes_17_18"
UNION
SELECT "local_1"."tournament_matches_lanes_05_06_07_08"."match_id" AS "MatchID", "local_1"."tournament_matches_lanes_05_06_07_08"."tournament_id" AS "TourneyID", "local_1"."tournament_matches_lanes_05_06_07_08"."lanes_label" AS "Lanes", "local_1"."tournament_matches_lanes_05_06_07_08"."odd_lane_team_id" AS "OddLaneTeamID", "local_1"."tournament_matches_lanes_05_06_07_08"."even_lane_team_id" AS "EvenLaneTeamID" FROM "local_1"."tournament_matches_lanes_05_06_07_08"
UNION
SELECT "local_1"."tournament_matches_lanes_09_10_21_22"."match_id" AS "MatchID", "local_1"."tournament_matches_lanes_09_10_21_22"."tournament_id" AS "TourneyID", "local_1"."tournament_matches_lanes_09_10_21_22"."lanes_label" AS "Lanes", "local_1"."tournament_matches_lanes_09_10_21_22"."odd_lane_team_id" AS "OddLaneTeamID", "local_1"."tournament_matches_lanes_09_10_21_22"."even_lane_team_id" AS "EvenLaneTeamID" FROM "local_1"."tournament_matches_lanes_09_10_21_22"
UNION
SELECT "local_1"."tournament_matches_lanes_other"."match_id" AS "MatchID", "local_1"."tournament_matches_lanes_other"."tournament_id" AS "TourneyID", "local_1"."tournament_matches_lanes_other"."lanes_label" AS "Lanes", "local_1"."tournament_matches_lanes_other"."odd_lane_team_id" AS "OddLaneTeamID", "local_1"."tournament_matches_lanes_other"."even_lane_team_id" AS "EvenLaneTeamID" FROM "local_1"."tournament_matches_lanes_other";

-- Reconstruct Tourney_Matches_Archive from local_2.archivedTournamentMatches
CREATE VIEW "Tourney_Matches_Archive" AS
SELECT
    "local_2"."archivedTournamentMatches"."matchId" AS "MatchID",
    "local_2"."archivedTournamentMatches"."tournamentId" AS "TourneyID",
    "local_2"."archivedTournamentMatches"."lanes" AS "Lanes",
    "local_2"."archivedTournamentMatches"."oddLaneTeamId" AS "OddLaneTeamID",
    "local_2"."archivedTournamentMatches"."evenLaneTeamId" AS "EvenLaneTeamID"
FROM "local_2"."archivedTournamentMatches";

-- Reconstruct WAZips from local_3.WashingtonZipDirectory
CREATE VIEW "WAZips" AS
SELECT
    "local_3"."WashingtonZipDirectory"."ZipCode" AS "ZIP",
    "local_3"."WashingtonZipDirectory"."CityName" AS "City",
    "local_3"."WashingtonZipDirectory"."StateName" AS "State"
FROM "local_3"."WashingtonZipDirectory";
