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