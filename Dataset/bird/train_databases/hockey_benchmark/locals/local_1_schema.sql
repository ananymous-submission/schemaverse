CREATE TABLE "awards_misc_thru1976" (
    "awardee_nm" TEXT,
    "awardee_id" TEXT,
    "award_code" TEXT,
    "yr" INTEGER,
    "lg_key" TEXT,
    "note_txt" TEXT
);

CREATE TABLE "awards_misc_1977_1991" (
    "awardee_nm" TEXT,
    "awardee_id" TEXT,
    "award_code" TEXT,
    "yr" INTEGER,
    "lg_key" TEXT,
    "note_txt" TEXT
);

CREATE TABLE "awards_misc_1992_2001" (
    "awardee_nm" TEXT,
    "awardee_id" TEXT,
    "award_code" TEXT,
    "yr" INTEGER,
    "lg_key" TEXT,
    "note_txt" TEXT
);

CREATE TABLE "awards_misc_post2001" (
    "awardee_nm" TEXT,
    "awardee_id" TEXT,
    "award_code" TEXT,
    "yr" INTEGER,
    "lg_key" TEXT,
    "note_txt" TEXT
);

CREATE TABLE "shutout_match_log" (
    "yr" INTEGER,
    "mo" INTEGER,
    "day" INTEGER,
    "team_id" TEXT,
    "opp_id" TEXT,
    "game_phase_cd" TEXT,
    "goalie_primary_id" TEXT,
    "goalie_secondary_id" TEXT
);