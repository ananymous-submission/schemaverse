-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/BowlingLeague/BowlingLeague.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "bowler_profiles" (
    "bowler_id" INTEGER,
    "address" TEXT,
    "city" TEXT,
    "name" TEXT,
    "last_name" TEXT,
    "middle_initial" TEXT,
    "phone_number" TEXT,
    "state" TEXT,
    "postal_code" TEXT
);

CREATE TABLE "bowler_city_stats" (
    "bowler_id" INTEGER,
    "city" TEXT,
    "current_average" smallint DEFAULT 0,
    "current_handicap" smallint DEFAULT 0,
    "middle_initial" TEXT,
    "postal_code" TEXT,
    "team_id" INT
);

CREATE TABLE "team_directory" (
    "team_id" INTEGER,
    "team_name" TEXT NOT NULL,
    "captain_id" INT
);

CREATE TABLE "tournament_events" (
    "tournament_id" INTEGER,
    "event_date" DATE,
    "location" TEXT
);

CREATE TABLE "tournament_matches_lanes_15_16" (
    "match_id" INTEGER,
    "tournament_id" INT DEFAULT 0,
    "lanes_label" TEXT,
    "odd_lane_team_id" INT DEFAULT 0,
    "even_lane_team_id" INT DEFAULT 0,
    FOREIGN KEY ("tournament_id") REFERENCES "tournament_events"("tournament_id"),
    FOREIGN KEY ("odd_lane_team_id") REFERENCES "team_directory"("team_id")
);

CREATE TABLE "tournament_matches_lanes_11_12_19_20" (
    "match_id" INTEGER,
    "tournament_id" INT DEFAULT 0,
    "lanes_label" TEXT,
    "odd_lane_team_id" INT DEFAULT 0,
    "even_lane_team_id" INT DEFAULT 0
);

CREATE TABLE "tournament_matches_lanes_13_14" (
    "match_id" INTEGER,
    "tournament_id" INT DEFAULT 0,
    "lanes_label" TEXT,
    "odd_lane_team_id" INT DEFAULT 0,
    "even_lane_team_id" INT DEFAULT 0,
    FOREIGN KEY ("tournament_id") REFERENCES "tournament_events"("tournament_id"),
    FOREIGN KEY ("odd_lane_team_id") REFERENCES "team_directory"("team_id")
);

CREATE TABLE "tournament_matches_lanes_17_18" (
    "match_id" INTEGER,
    "tournament_id" INT DEFAULT 0,
    "lanes_label" TEXT,
    "odd_lane_team_id" INT DEFAULT 0,
    "even_lane_team_id" INT DEFAULT 0,
    FOREIGN KEY ("tournament_id") REFERENCES "tournament_events"("tournament_id"),
    FOREIGN KEY ("odd_lane_team_id") REFERENCES "team_directory"("team_id"),
    FOREIGN KEY ("even_lane_team_id") REFERENCES "team_directory"("team_id")
);

CREATE TABLE "tournament_matches_lanes_05_06_07_08" (
    "match_id" INTEGER,
    "tournament_id" INT DEFAULT 0,
    "lanes_label" TEXT,
    "odd_lane_team_id" INT DEFAULT 0,
    "even_lane_team_id" INT DEFAULT 0,
    FOREIGN KEY ("even_lane_team_id") REFERENCES "team_directory"("team_id")
);

CREATE TABLE "tournament_matches_lanes_09_10_21_22" (
    "match_id" INTEGER,
    "tournament_id" INT DEFAULT 0,
    "lanes_label" TEXT,
    "odd_lane_team_id" INT DEFAULT 0,
    "even_lane_team_id" INT DEFAULT 0
);

CREATE TABLE "tournament_matches_lanes_other" (
    "match_id" INTEGER,
    "tournament_id" INT DEFAULT 0,
    "lanes_label" TEXT,
    "odd_lane_team_id" INT DEFAULT 0,
    "even_lane_team_id" INT DEFAULT 0,
    FOREIGN KEY ("even_lane_team_id") REFERENCES "team_directory"("team_id")
);

CREATE TABLE "bowler_scores_handicap_187_189_194_196_198" (
    "match_id" INT DEFAULT 0,
    "game_number" smallint DEFAULT 0,
    "bowler_id" INT DEFAULT 0,
    "handicap_score" smallint DEFAULT 0,
    "raw_score" smallint DEFAULT 0
);

CREATE TABLE "bowler_scores_handicap_192_193_195_200" (
    "match_id" INT DEFAULT 0,
    "game_number" smallint DEFAULT 0,
    "bowler_id" INT DEFAULT 0,
    "handicap_score" smallint DEFAULT 0,
    "raw_score" smallint DEFAULT 0
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "bowlerHandicapScoresOtherBucket" (
    "matchId" INT DEFAULT 0,
    "gameNumber" smallint DEFAULT 0,
    "bowlerId" INT DEFAULT 0,
    "handicapScore" smallint DEFAULT 0,
    "rawScore" smallint DEFAULT 0,
    FOREIGN KEY ("matchId") REFERENCES "matchGamesWinningTeamUpToTwo"("matchId"),
    FOREIGN KEY ("matchId") REFERENCES "matchGamesWinningTeamGreaterThanTwoUpToFour"("matchId"),
    FOREIGN KEY ("matchId") REFERENCES "matchGamesWinningTeamGreaterThanFourUpToSix"("matchId"),
    FOREIGN KEY ("gameNumber") REFERENCES "matchGamesWinningTeamGreaterThanTwoUpToFour"("gameNumber"),
    FOREIGN KEY ("gameNumber") REFERENCES "matchGamesWinningTeamGreaterThanFourUpToSix"("gameNumber"),
    FOREIGN KEY ("gameNumber") REFERENCES "matchGamesWinningTeamGreaterThanSixOrNull"("gameNumber")
);

CREATE TABLE "bowlerHandicapScoresStandard" (
    "matchId" INT DEFAULT 0,
    "gameNumber" smallint DEFAULT 0,
    "bowlerId" INT DEFAULT 0,
    "handicapScore" smallint DEFAULT 0,
    "rawScore" smallint DEFAULT 0,
    "wonGame" BOOLEAN NOT NULL DEFAULT 0,
    FOREIGN KEY ("matchId") REFERENCES "matchGamesWinningTeamUpToTwo"("matchId"),
    FOREIGN KEY ("bowlerId") REFERENCES "bowlersRoster"("bowlerId")
);

CREATE TABLE "matchGamesWinningTeamUpToTwo" (
    "matchId" INT DEFAULT 0,
    "gameNumber" smallint DEFAULT 0,
    "winningTeamId" INT DEFAULT 0
);

CREATE TABLE "matchGamesWinningTeamGreaterThanTwoUpToFour" (
    "matchId" INT DEFAULT 0,
    "gameNumber" smallint DEFAULT 0,
    "winningTeamId" INT DEFAULT 0
);

CREATE TABLE "matchGamesWinningTeamGreaterThanFourUpToSix" (
    "matchId" INT DEFAULT 0,
    "gameNumber" smallint DEFAULT 0,
    "winningTeamId" INT DEFAULT 0
);

CREATE TABLE "matchGamesWinningTeamGreaterThanSixOrNull" (
    "matchId" INT DEFAULT 0,
    "gameNumber" smallint DEFAULT 0,
    "winningTeamId" INT DEFAULT 0
);

CREATE TABLE "archivedTournaments" (
    "tournamentId" INT DEFAULT 0,
    "tournamentDate" DATE,
    "location" TEXT
);

CREATE TABLE "archivedTournamentMatches" (
    "matchId" INT DEFAULT 0,
    "tournamentId" INT DEFAULT 0,
    "lanes" TEXT,
    "oddLaneTeamId" INT DEFAULT 0,
    "evenLaneTeamId" INT DEFAULT 0,
    FOREIGN KEY ("tournamentId") REFERENCES "archivedTournaments"("tournamentId")
);

CREATE TABLE "bowlersRoster" (
    "bowlerId" INTEGER,
    "address" TEXT,
    "gamesBowled" INT DEFAULT 0,
    "phoneNumber" TEXT,
    "state" TEXT,
    "totalPins" INT DEFAULT 0
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "ArchivedBowlerHandicapScore" (
    "MatchIdentifier" INT DEFAULT 0,
    "GameSequence" smallint DEFAULT 0,
    "BowlerIdentifier" INT DEFAULT 0,
    "HandicapScoreValue" smallint DEFAULT 0,
    "RawScoreValue" smallint DEFAULT 0,
    FOREIGN KEY ("MatchIdentifier") REFERENCES "ArchivedMatchGame"("MatchIdentifier"),
    FOREIGN KEY ("GameSequence") REFERENCES "ArchivedMatchGame"("GameSequence")
);

CREATE TABLE "ArchivedBowlerHandicapResult" (
    "MatchIdentifier" INT DEFAULT 0,
    "GameSequence" smallint DEFAULT 0,
    "BowlerIdentifier" INT DEFAULT 0,
    "HandicapScoreValue" smallint DEFAULT 0,
    "RawScoreValue" smallint DEFAULT 0,
    "GameWonFlag" BOOLEAN NOT NULL DEFAULT 0,
    FOREIGN KEY ("GameSequence") REFERENCES "ArchivedMatchGame"("GameSequence")
);

CREATE TABLE "ArchivedMatchGame" (
    "MatchIdentifier" INT DEFAULT 0,
    "GameSequence" smallint DEFAULT 0,
    "WinningTeamIdentifier" INT DEFAULT 0
);

CREATE TABLE "WashingtonZipDirectory" (
    "ZipCode" TEXT,
    "CityName" TEXT,
    "StateName" TEXT
);

