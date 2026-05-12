-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct Award from vertical (column) split (2 fragments)
CREATE VIEW "Award" AS
SELECT
    t0."award_key" AS "award_id",
    t1."presenting_organization" AS "organization",
    t0."award_year" AS "year",
    t1."award_category_name" AS "award_category",
    t1."award_name" AS "award",
    t0."tv_series" AS "series",
    t0."ep_id" AS "episode_id",
    t0."person_ref" AS "person_id",
    t0."award_role" AS "role",
    t0."award_res" AS "result"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "award_key" ORDER BY rowid) AS __rn FROM "local_2"."award_ep_link") t0
JOIN "local_3"."award_honors" t1 ON t0."award_key" IS t1."award_record_id" AND t0.__rn = t1.__rn;

-- Reconstruct Credit from row partitions (UNION (overlap))
CREATE VIEW "Credit" AS
SELECT "local_1"."EpisodeCastCredits"."EpisodeId" AS "episode_id", "local_1"."EpisodeCastCredits"."PersonId" AS "person_id", "local_1"."EpisodeCastCredits"."Category" AS "category", "local_1"."EpisodeCastCredits"."Role" AS "role", "local_1"."EpisodeCastCredits"."CreditedAs" AS "credited" FROM "local_1"."EpisodeCastCredits"
UNION
SELECT "local_1"."EpisodeOtherCredits"."EpisodeId" AS "episode_id", "local_1"."EpisodeOtherCredits"."PersonId" AS "person_id", "local_1"."EpisodeOtherCredits"."Category" AS "category", "local_1"."EpisodeOtherCredits"."Role" AS "role", "local_1"."EpisodeOtherCredits"."CreditedAs" AS "credited" FROM "local_1"."EpisodeOtherCredits"
UNION
SELECT "local_2"."credit_prod_addcrew"."ep_id" AS "episode_id", "local_2"."credit_prod_addcrew"."person_ref" AS "person_id", "local_2"."credit_prod_addcrew"."cred_cat" AS "category", "local_2"."credit_prod_addcrew"."cred_role" AS "role", "local_2"."credit_prod_addcrew"."cred_as" AS "credited" FROM "local_2"."credit_prod_addcrew"
UNION
SELECT "local_2"."credit_general_art"."ep_id" AS "episode_id", "local_2"."credit_general_art"."person_ref" AS "person_id", "local_2"."credit_general_art"."cred_cat" AS "category", "local_2"."credit_general_art"."cred_role" AS "role", "local_2"."credit_general_art"."cred_as" AS "credited" FROM "local_2"."credit_general_art"
UNION
SELECT "local_2"."credit_cam_elec_sound_loc_mgmt_edit"."ep_id" AS "episode_id", "local_2"."credit_cam_elec_sound_loc_mgmt_edit"."person_ref" AS "person_id", "local_2"."credit_cam_elec_sound_loc_mgmt_edit"."cred_cat" AS "category", "local_2"."credit_cam_elec_sound_loc_mgmt_edit"."cred_role" AS "role", "local_2"."credit_cam_elec_sound_loc_mgmt_edit"."cred_as" AS "credited" FROM "local_2"."credit_cam_elec_sound_loc_mgmt_edit";

-- Reconstruct Episode from vertical (column) split (2 fragments)
CREATE VIEW "Episode" AS
SELECT
    t0."EpisodeId" AS "episode_id",
    t0."SeriesTitle" AS "series",
    t0."SeasonNumber" AS "season",
    t0."EpisodeNumber" AS "episode",
    t0."NumberInSeries" AS "number_in_series",
    t1."episode_title" AS "title",
    t0."Summary" AS "summary",
    t0."AirDate" AS "air_date",
    t0."EpisodeImage" AS "episode_image",
    t1."viewer_rating" AS "rating",
    t0."VoteCount" AS "votes"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "EpisodeId" ORDER BY rowid) AS __rn FROM "local_1"."EpisodeAirDetails") t0
JOIN "local_3"."episode_release" t1 ON t0."EpisodeId" IS t1."episode_identifier" AND t0.__rn = t1.__rn;

-- Reconstruct Keyword from local_2.ep_keyword
CREATE VIEW "Keyword" AS
SELECT
    "local_2"."ep_keyword"."ep_id" AS "episode_id",
    "local_2"."ep_keyword"."kw" AS "keyword"
FROM "local_2"."ep_keyword";

-- Reconstruct Person from vertical split + row partition on a fragment
CREATE VIEW "Person" AS
SELECT t0.[PersonId], t1.[name_pref], t0.[BirthDate], t1.[name_birth], t0.[BirthPlace], t0.[BirthRegion], t0.[BirthCountry], t0.[HeightMeters], t0.[Nickname]
FROM (
SELECT [PersonOtherBirthCountry].[__orig_rowid] AS __orig_rowid, [local_1].[PersonOtherBirthCountry].[PersonId], [local_1].[PersonOtherBirthCountry].[BirthDate], [local_1].[PersonOtherBirthCountry].[BirthPlace], [local_1].[PersonOtherBirthCountry].[BirthRegion], [local_1].[PersonOtherBirthCountry].[BirthCountry], [local_1].[PersonOtherBirthCountry].[HeightMeters], [local_1].[PersonOtherBirthCountry].[Nickname] FROM [local_1].[PersonOtherBirthCountry]
UNION
SELECT [person_birth_cntry_us_ca_co_de_in_ie_gb_it_pl].[__orig_rowid] AS __orig_rowid, [local_2].[person_birth_cntry_us_ca_co_de_in_ie_gb_it_pl].[person_ref], [local_2].[person_birth_cntry_us_ca_co_de_in_ie_gb_it_pl].[dob], [local_2].[person_birth_cntry_us_ca_co_de_in_ie_gb_it_pl].[birth_loc], [local_2].[person_birth_cntry_us_ca_co_de_in_ie_gb_it_pl].[birth_area], [local_2].[person_birth_cntry_us_ca_co_de_in_ie_gb_it_pl].[birth_cntry], [local_2].[person_birth_cntry_us_ca_co_de_in_ie_gb_it_pl].[ht_m], [local_2].[person_birth_cntry_us_ca_co_de_in_ie_gb_it_pl].[nick] FROM [local_2].[person_birth_cntry_us_ca_co_de_in_ie_gb_it_pl]
) t0
JOIN [local_2].[person_bio_ext] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct Vote from local_3.episode_vote_summary
CREATE VIEW "Vote" AS
SELECT
    "local_3"."episode_vote_summary"."episode_identifier" AS "episode_id",
    "local_3"."episode_vote_summary"."star_rating" AS "stars",
    "local_3"."episode_vote_summary"."vote_count" AS "votes",
    "local_3"."episode_vote_summary"."vote_percentage" AS "percent"
FROM "local_3"."episode_vote_summary";
