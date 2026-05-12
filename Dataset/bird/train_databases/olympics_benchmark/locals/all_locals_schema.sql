-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/olympics/olympics.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "host_city" (
    "host_city_id" INTEGER,
    "city_label" TEXT DEFAULT NULL
);

CREATE TABLE "competition_event" (
    "competition_event_id" INTEGER,
    "sport_category_id" INTEGER DEFAULT NULL,
    "event_title" TEXT DEFAULT NULL
);

CREATE TABLE "summer_games" (
    "summer_games_id" INTEGER,
    "year_held" INTEGER DEFAULT NULL,
    "games_title" TEXT DEFAULT NULL,
    "season_label" TEXT DEFAULT NULL
);

CREATE TABLE "medal_type" (
    "medal_type_id" INTEGER,
    "medal_rank" TEXT DEFAULT NULL
);

CREATE TABLE "sport_category" (
    "sport_category_id" INTEGER,
    "discipline_name" TEXT DEFAULT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "comp_evt_rel" (
    "evt_id" INTEGER DEFAULT NULL,
    "comp_id" INTEGER DEFAULT NULL,
    "medal_ref" INTEGER DEFAULT NULL
);

CREATE TABLE "games_comp_under22" (
    "comp_rec_id" INTEGER,
    "games_ref" INTEGER DEFAULT NULL,
    "ath_id" INTEGER DEFAULT NULL,
    "age_yrs" INTEGER DEFAULT NULL,
    FOREIGN KEY ("ath_id") REFERENCES "person_ht_160_172"("person_id")
);

CREATE TABLE "games_comp_over29" (
    "comp_rec_id" INTEGER,
    "games_ref" INTEGER DEFAULT NULL,
    "ath_id" INTEGER DEFAULT NULL,
    "age_yrs" INTEGER DEFAULT NULL,
    FOREIGN KEY ("ath_id") REFERENCES "person_ht_173_181"("person_id")
);

CREATE TABLE "noc_region_map" (
    "noc_id" INTEGER,
    "noc_code" TEXT DEFAULT NULL,
    "region_label" TEXT DEFAULT NULL
);

CREATE TABLE "person_ht_160_172" (
    "person_id" INTEGER,
    "name_full" TEXT DEFAULT NULL,
    "gender_cd" TEXT DEFAULT NULL,
    "ht_cm" INTEGER DEFAULT NULL,
    "wt_kg" INTEGER DEFAULT NULL
);

CREATE TABLE "person_ht_173_181" (
    "person_id" INTEGER,
    "name_full" TEXT DEFAULT NULL,
    "gender_cd" TEXT DEFAULT NULL,
    "ht_cm" INTEGER DEFAULT NULL,
    "wt_kg" INTEGER DEFAULT NULL
);

CREATE TABLE "winter_games" (
    "games_id" INTEGER,
    "game_year" INTEGER DEFAULT NULL,
    "game_title" TEXT DEFAULT NULL,
    "season_type" TEXT DEFAULT NULL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "eventCityMap" (
    "eventId" INTEGER DEFAULT NULL,
    "cityId" INTEGER DEFAULT NULL
);

CREATE TABLE "peopleHeightAtMost159" (
    "personId" INTEGER,
    "fullName" TEXT DEFAULT NULL,
    "genderIdentity" TEXT DEFAULT NULL,
    "heightCm" INTEGER DEFAULT NULL,
    "weightKg" INTEGER DEFAULT NULL
);

CREATE TABLE "peopleHeightAbove181OrUnknown" (
    "personId" INTEGER,
    "fullName" TEXT DEFAULT NULL,
    "genderIdentity" TEXT DEFAULT NULL,
    "heightCm" INTEGER DEFAULT NULL,
    "weightKg" INTEGER DEFAULT NULL
);

CREATE TABLE "personRegionMap" (
    "personId" INTEGER DEFAULT NULL,
    "regionId" INTEGER DEFAULT NULL
);

CREATE TABLE "competitorsAgeAbove22UpTo25" (
    "competitorId" INTEGER,
    "eventId" INTEGER DEFAULT NULL,
    "personIdRef" INTEGER DEFAULT NULL,
    "participantAge" INTEGER DEFAULT NULL,
    FOREIGN KEY ("personIdRef") REFERENCES "peopleHeightAtMost159"("personId")
);

CREATE TABLE "competitorsAgeAbove25UpTo29" (
    "competitorId" INTEGER,
    "eventId" INTEGER DEFAULT NULL,
    "personIdRef" INTEGER DEFAULT NULL,
    "participantAge" INTEGER DEFAULT NULL
);

