-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/law_episode/law_episode.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "EpisodeCastCredits" (
    "EpisodeId" TEXT,
    "PersonId" TEXT,
    "Category" TEXT,
    "Role" TEXT,
    "CreditedAs" TEXT,
    FOREIGN KEY ("PersonId") REFERENCES "PersonOtherBirthCountry"("PersonId"),
    FOREIGN KEY ("EpisodeId") REFERENCES "EpisodeAirDetails"("EpisodeId")
);

CREATE TABLE "EpisodeOtherCredits" (
    "EpisodeId" TEXT,
    "PersonId" TEXT,
    "Category" TEXT,
    "Role" TEXT,
    "CreditedAs" TEXT
);

CREATE TABLE "EpisodeAirDetails" (
    "EpisodeId" TEXT,
    "AirDate" DATE,
    "EpisodeNumber" INTEGER,
    "EpisodeImage" TEXT,
    "NumberInSeries" INTEGER,
    "SeasonNumber" INTEGER,
    "SeriesTitle" TEXT,
    "Summary" TEXT,
    "VoteCount" INTEGER
);

CREATE TABLE "PersonOtherBirthCountry" (
    "PersonId" TEXT,
    "BirthCountry" TEXT,
    "BirthPlace" TEXT,
    "BirthRegion" TEXT,
    "BirthDate" DATE,
    "HeightMeters" REAL,
    "Nickname" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "ep_keyword" (
    "ep_id" TEXT,
    "kw" TEXT
);

CREATE TABLE "person_birth_cntry_us_ca_co_de_in_ie_gb_it_pl" (
    "person_ref" TEXT,
    "birth_cntry" TEXT,
    "birth_loc" TEXT,
    "birth_area" TEXT,
    "dob" DATE,
    "ht_m" REAL,
    "nick" TEXT
);

CREATE TABLE "person_bio_ext" (
    "person_ref" TEXT,
    "birth_cntry" TEXT,
    "name_birth" TEXT,
    "dob" DATE,
    "ht_m" REAL,
    "name_pref" TEXT,
    "nick" TEXT
);

CREATE TABLE "credit_prod_addcrew" (
    "ep_id" TEXT,
    "person_ref" TEXT,
    "cred_cat" TEXT,
    "cred_role" TEXT,
    "cred_as" TEXT
);

CREATE TABLE "credit_general_art" (
    "ep_id" TEXT,
    "person_ref" TEXT,
    "cred_cat" TEXT,
    "cred_role" TEXT,
    "cred_as" TEXT
);

CREATE TABLE "credit_cam_elec_sound_loc_mgmt_edit" (
    "ep_id" TEXT,
    "person_ref" TEXT,
    "cred_cat" TEXT,
    "cred_role" TEXT,
    "cred_as" TEXT
);

CREATE TABLE "award_ep_link" (
    "award_key" INTEGER,
    "ep_id" TEXT,
    "person_ref" TEXT,
    "award_res" TEXT,
    "award_role" TEXT,
    "tv_series" TEXT,
    "award_year" INTEGER,
    FOREIGN KEY ("person_ref") REFERENCES "person_birth_cntry_us_ca_co_de_in_ie_gb_it_pl"("person_ref")
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "award_honors" (
    "award_record_id" INTEGER,
    "award_name" TEXT,
    "award_category_name" TEXT,
    "presenting_organization" TEXT,
    "outcome" TEXT,
    "recipient_role" TEXT,
    "series_title" TEXT,
    "award_year" INTEGER
);

CREATE TABLE "episode_vote_summary" (
    "episode_identifier" TEXT,
    "star_rating" INTEGER,
    "vote_count" INTEGER,
    "vote_percentage" REAL
);

CREATE TABLE "episode_release" (
    "episode_identifier" TEXT,
    "release_date" DATE,
    "image_url" TEXT,
    "viewer_rating" REAL,
    "series_title" TEXT,
    "synopsis" TEXT,
    "episode_title" TEXT
);

