-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct city from local_1.host_city
CREATE VIEW "city" AS
SELECT
    "local_1"."host_city"."host_city_id" AS "id",
    "local_1"."host_city"."city_label" AS "city_name"
FROM "local_1"."host_city";

-- Reconstruct competitor_event from local_2.comp_evt_rel
CREATE VIEW "competitor_event" AS
SELECT
    "local_2"."comp_evt_rel"."evt_id" AS "event_id",
    "local_2"."comp_evt_rel"."comp_id" AS "competitor_id",
    "local_2"."comp_evt_rel"."medal_ref" AS "medal_id"
FROM "local_2"."comp_evt_rel";

-- Reconstruct event from local_1.competition_event
CREATE VIEW "event" AS
SELECT
    "local_1"."competition_event"."competition_event_id" AS "id",
    "local_1"."competition_event"."sport_category_id" AS "sport_id",
    "local_1"."competition_event"."event_title" AS "event_name"
FROM "local_1"."competition_event";

-- Reconstruct games from row partitions (UNION (overlap))
CREATE VIEW "games" AS
SELECT "local_1"."summer_games"."summer_games_id" AS "id", "local_1"."summer_games"."year_held" AS "games_year", "local_1"."summer_games"."games_title" AS "games_name", "local_1"."summer_games"."season_label" AS "season" FROM "local_1"."summer_games"
UNION
SELECT "local_2"."winter_games"."games_id" AS "id", "local_2"."winter_games"."game_year" AS "games_year", "local_2"."winter_games"."game_title" AS "games_name", "local_2"."winter_games"."season_type" AS "season" FROM "local_2"."winter_games";

-- Reconstruct games_city from local_3.eventCityMap
CREATE VIEW "games_city" AS
SELECT
    "local_3"."eventCityMap"."eventId" AS "games_id",
    "local_3"."eventCityMap"."cityId" AS "city_id"
FROM "local_3"."eventCityMap";

-- Reconstruct games_competitor from row partitions (UNION (overlap))
CREATE VIEW "games_competitor" AS
SELECT "local_2"."games_comp_under22"."comp_rec_id" AS "id", "local_2"."games_comp_under22"."games_ref" AS "games_id", "local_2"."games_comp_under22"."ath_id" AS "person_id", "local_2"."games_comp_under22"."age_yrs" AS "age" FROM "local_2"."games_comp_under22"
UNION
SELECT "local_2"."games_comp_over29"."comp_rec_id" AS "id", "local_2"."games_comp_over29"."games_ref" AS "games_id", "local_2"."games_comp_over29"."ath_id" AS "person_id", "local_2"."games_comp_over29"."age_yrs" AS "age" FROM "local_2"."games_comp_over29"
UNION
SELECT "local_3"."competitorsAgeAbove22UpTo25"."competitorId" AS "id", "local_3"."competitorsAgeAbove22UpTo25"."eventId" AS "games_id", "local_3"."competitorsAgeAbove22UpTo25"."personIdRef" AS "person_id", "local_3"."competitorsAgeAbove22UpTo25"."participantAge" AS "age" FROM "local_3"."competitorsAgeAbove22UpTo25"
UNION
SELECT "local_3"."competitorsAgeAbove25UpTo29"."competitorId" AS "id", "local_3"."competitorsAgeAbove25UpTo29"."eventId" AS "games_id", "local_3"."competitorsAgeAbove25UpTo29"."personIdRef" AS "person_id", "local_3"."competitorsAgeAbove25UpTo29"."participantAge" AS "age" FROM "local_3"."competitorsAgeAbove25UpTo29";

-- Reconstruct medal from local_1.medal_type
CREATE VIEW "medal" AS
SELECT
    "local_1"."medal_type"."medal_type_id" AS "id",
    "local_1"."medal_type"."medal_rank" AS "medal_name"
FROM "local_1"."medal_type";

-- Reconstruct noc_region from local_2.noc_region_map
CREATE VIEW "noc_region" AS
SELECT
    "local_2"."noc_region_map"."noc_id" AS "id",
    "local_2"."noc_region_map"."noc_code" AS "noc",
    "local_2"."noc_region_map"."region_label" AS "region_name"
FROM "local_2"."noc_region_map";

-- Reconstruct person from row partitions (UNION (overlap))
CREATE VIEW "person" AS
SELECT "local_2"."person_ht_160_172"."person_id" AS "id", "local_2"."person_ht_160_172"."name_full" AS "full_name", "local_2"."person_ht_160_172"."gender_cd" AS "gender", "local_2"."person_ht_160_172"."ht_cm" AS "height", "local_2"."person_ht_160_172"."wt_kg" AS "weight" FROM "local_2"."person_ht_160_172"
UNION
SELECT "local_2"."person_ht_173_181"."person_id" AS "id", "local_2"."person_ht_173_181"."name_full" AS "full_name", "local_2"."person_ht_173_181"."gender_cd" AS "gender", "local_2"."person_ht_173_181"."ht_cm" AS "height", "local_2"."person_ht_173_181"."wt_kg" AS "weight" FROM "local_2"."person_ht_173_181"
UNION
SELECT "local_3"."peopleHeightAtMost159"."personId" AS "id", "local_3"."peopleHeightAtMost159"."fullName" AS "full_name", "local_3"."peopleHeightAtMost159"."genderIdentity" AS "gender", "local_3"."peopleHeightAtMost159"."heightCm" AS "height", "local_3"."peopleHeightAtMost159"."weightKg" AS "weight" FROM "local_3"."peopleHeightAtMost159"
UNION
SELECT "local_3"."peopleHeightAbove181OrUnknown"."personId" AS "id", "local_3"."peopleHeightAbove181OrUnknown"."fullName" AS "full_name", "local_3"."peopleHeightAbove181OrUnknown"."genderIdentity" AS "gender", "local_3"."peopleHeightAbove181OrUnknown"."heightCm" AS "height", "local_3"."peopleHeightAbove181OrUnknown"."weightKg" AS "weight" FROM "local_3"."peopleHeightAbove181OrUnknown";

-- Reconstruct person_region from local_3.personRegionMap
CREATE VIEW "person_region" AS
SELECT
    "local_3"."personRegionMap"."personId" AS "person_id",
    "local_3"."personRegionMap"."regionId" AS "region_id"
FROM "local_3"."personRegionMap";

-- Reconstruct sport from local_1.sport_category
CREATE VIEW "sport" AS
SELECT
    "local_1"."sport_category"."sport_category_id" AS "id",
    "local_1"."sport_category"."discipline_name" AS "sport_name"
FROM "local_1"."sport_category";
