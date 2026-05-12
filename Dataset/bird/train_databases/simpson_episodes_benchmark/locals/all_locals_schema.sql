-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/simpson_episodes/simpson_episodes.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "awd_comedy_series" (
    "awd_id" INTEGER,
    "awd_title" TEXT,
    "awd_cat" TEXT,
    "org_name" TEXT,
    "person_name" TEXT,
    "outcome" TEXT,
    "role_desc" TEXT,
    "yr" INTEGER
);

CREATE TABLE "awd_other_misc" (
    "awd_id" INTEGER,
    "awd_title" TEXT,
    "awd_cat" TEXT,
    "org_name" TEXT,
    "person_name" TEXT,
    "outcome" TEXT,
    "role_desc" TEXT,
    "yr" INTEGER
);

CREATE TABLE "ep_air_info" (
    "ep_id" TEXT,
    "air_dt" TEXT,
    "img_url" TEXT,
    "avg_rating" REAL,
    "season_no" INTEGER,
    "synopsis" TEXT,
    "ep_title" TEXT,
    "vote_cnt" INTEGER
);

CREATE TABLE "ep_keyword" (
    "ep_id" TEXT,
    "kwd_term" TEXT,
    FOREIGN KEY ("ep_id") REFERENCES "ep_air_info"("ep_id")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "episode_credits" (
    "episode_ref_id" TEXT,
    "credit_category" TEXT,
    "person_full_name" TEXT,
    "role_description" TEXT,
    "credited_status" TEXT,
    FOREIGN KEY ("person_full_name") REFERENCES "people"("full_name")
);

CREATE TABLE "people" (
    "full_name" TEXT,
    "date_of_birth" TEXT,
    "original_name" TEXT,
    "birthplace_city" TEXT,
    "birthplace_region" TEXT,
    "birthplace_country" TEXT,
    "height_m" REAL,
    "preferred_nickname" TEXT
);

CREATE TABLE "awards_by_category" (
    "award_record_id" INTEGER,
    "category_label" TEXT,
    "episode_code" TEXT,
    "outcome" TEXT,
    "role_description" TEXT,
    "season_tag" TEXT,
    "song_title" TEXT,
    "award_year" INTEGER
);

CREATE TABLE "awards_outstanding_animated_program_short" (
    "award_entry_id" INTEGER,
    "award_title" TEXT,
    "category_label" TEXT,
    "presenting_organization" TEXT,
    "recipient_name" TEXT,
    "outcome" TEXT,
    "role_description" TEXT,
    "award_year" INTEGER
);

CREATE TABLE "awards_animation_voiceover_writing_tv" (
    "award_entry_id" INTEGER,
    "award_title" TEXT,
    "category_label" TEXT,
    "presenting_organization" TEXT,
    "recipient_name" TEXT,
    "outcome" TEXT,
    "role_description" TEXT,
    "award_year" INTEGER
);

CREATE TABLE "awards_cartoon_writing_comedy_voiceover_animated" (
    "award_entry_id" INTEGER,
    "award_title" TEXT,
    "category_label" TEXT,
    "presenting_organization" TEXT,
    "recipient_name" TEXT,
    "outcome" TEXT,
    "role_description" TEXT,
    "award_year" INTEGER
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "characterAward" (
    "awardId" INTEGER,
    "characterName" TEXT
);

CREATE TABLE "episodeRating" (
    "episodeId" TEXT,
    "starRating" INTEGER,
    "voteCount" INTEGER,
    "votePercentage" REAL,
    FOREIGN KEY ("episodeId") REFERENCES "episodeRecord"("episodeId")
);

CREATE TABLE "episodeRecord" (
    "episodeId" TEXT,
    "episodeNumber" INTEGER,
    "imageUrl" TEXT,
    "overallEpisodeNumber" INTEGER,
    "averageRating" REAL,
    "seasonNumber" INTEGER,
    "totalVotes" INTEGER
);

