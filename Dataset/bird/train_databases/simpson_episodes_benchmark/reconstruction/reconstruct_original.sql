-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct Award from vertical split + row partition on a fragment
CREATE VIEW "Award" AS
SELECT t0.[awd_id], t0.[org_name], t0.[yr], t0.[awd_cat], t0.[awd_title], t0.[person_name], t0.[role_desc], t1.[episode_code], t1.[season_tag], t1.[song_title], t0.[outcome]
FROM (
SELECT [awd_comedy_series].[__orig_rowid] AS __orig_rowid, [local_1].[awd_comedy_series].[awd_id], [local_1].[awd_comedy_series].[org_name], [local_1].[awd_comedy_series].[yr], [local_1].[awd_comedy_series].[awd_cat], [local_1].[awd_comedy_series].[awd_title], [local_1].[awd_comedy_series].[person_name], [local_1].[awd_comedy_series].[role_desc], [local_1].[awd_comedy_series].[outcome] FROM [local_1].[awd_comedy_series]
UNION
SELECT [awd_other_misc].[__orig_rowid] AS __orig_rowid, [local_1].[awd_other_misc].[awd_id], [local_1].[awd_other_misc].[org_name], [local_1].[awd_other_misc].[yr], [local_1].[awd_other_misc].[awd_cat], [local_1].[awd_other_misc].[awd_title], [local_1].[awd_other_misc].[person_name], [local_1].[awd_other_misc].[role_desc], [local_1].[awd_other_misc].[outcome] FROM [local_1].[awd_other_misc]
UNION
SELECT [awards_animation_voiceover_writing_tv].[__orig_rowid] AS __orig_rowid, [local_2].[awards_animation_voiceover_writing_tv].[award_entry_id], [local_2].[awards_animation_voiceover_writing_tv].[presenting_organization], [local_2].[awards_animation_voiceover_writing_tv].[award_year], [local_2].[awards_animation_voiceover_writing_tv].[category_label], [local_2].[awards_animation_voiceover_writing_tv].[award_title], [local_2].[awards_animation_voiceover_writing_tv].[recipient_name], [local_2].[awards_animation_voiceover_writing_tv].[role_description], [local_2].[awards_animation_voiceover_writing_tv].[outcome] FROM [local_2].[awards_animation_voiceover_writing_tv]
UNION
SELECT [awards_cartoon_writing_comedy_voiceover_animated].[__orig_rowid] AS __orig_rowid, [local_2].[awards_cartoon_writing_comedy_voiceover_animated].[award_entry_id], [local_2].[awards_cartoon_writing_comedy_voiceover_animated].[presenting_organization], [local_2].[awards_cartoon_writing_comedy_voiceover_animated].[award_year], [local_2].[awards_cartoon_writing_comedy_voiceover_animated].[category_label], [local_2].[awards_cartoon_writing_comedy_voiceover_animated].[award_title], [local_2].[awards_cartoon_writing_comedy_voiceover_animated].[recipient_name], [local_2].[awards_cartoon_writing_comedy_voiceover_animated].[role_description], [local_2].[awards_cartoon_writing_comedy_voiceover_animated].[outcome] FROM [local_2].[awards_cartoon_writing_comedy_voiceover_animated]
UNION
SELECT [awards_outstanding_animated_program_short].[__orig_rowid] AS __orig_rowid, [local_2].[awards_outstanding_animated_program_short].[award_entry_id], [local_2].[awards_outstanding_animated_program_short].[presenting_organization], [local_2].[awards_outstanding_animated_program_short].[award_year], [local_2].[awards_outstanding_animated_program_short].[category_label], [local_2].[awards_outstanding_animated_program_short].[award_title], [local_2].[awards_outstanding_animated_program_short].[recipient_name], [local_2].[awards_outstanding_animated_program_short].[role_description], [local_2].[awards_outstanding_animated_program_short].[outcome] FROM [local_2].[awards_outstanding_animated_program_short]
) t0
JOIN [local_2].[awards_by_category] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct Character_Award from local_3.characterAward
CREATE VIEW "Character_Award" AS
SELECT
    "local_3"."characterAward"."awardId" AS "award_id",
    "local_3"."characterAward"."characterName" AS "character"
FROM "local_3"."characterAward";

-- Reconstruct Credit from local_2.episode_credits
CREATE VIEW "Credit" AS
SELECT
    "local_2"."episode_credits"."episode_ref_id" AS "episode_id",
    "local_2"."episode_credits"."credit_category" AS "category",
    "local_2"."episode_credits"."person_full_name" AS "person",
    "local_2"."episode_credits"."role_description" AS "role",
    "local_2"."episode_credits"."credited_status" AS "credited"
FROM "local_2"."episode_credits";

-- Reconstruct Episode from vertical (column) split (2 fragments)
CREATE VIEW "Episode" AS
SELECT
    t0."ep_id" AS "episode_id",
    t0."season_no" AS "season",
    t1."episodeNumber" AS "episode",
    t1."overallEpisodeNumber" AS "number_in_series",
    t0."ep_title" AS "title",
    t0."synopsis" AS "summary",
    t0."air_dt" AS "air_date",
    t0."img_url" AS "episode_image",
    t0."avg_rating" AS "rating",
    t0."vote_cnt" AS "votes"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "ep_id" ORDER BY rowid) AS __rn FROM "local_1"."ep_air_info") t0
JOIN "local_3"."episodeRecord" t1 ON t0."ep_id" IS t1."episodeId" AND t0.__rn = t1.__rn;

-- Reconstruct Keyword from local_1.ep_keyword
CREATE VIEW "Keyword" AS
SELECT
    "local_1"."ep_keyword"."ep_id" AS "episode_id",
    "local_1"."ep_keyword"."kwd_term" AS "keyword"
FROM "local_1"."ep_keyword";

-- Reconstruct Person from local_2.people
CREATE VIEW "Person" AS
SELECT
    "local_2"."people"."full_name" AS "name",
    "local_2"."people"."date_of_birth" AS "birthdate",
    "local_2"."people"."original_name" AS "birth_name",
    "local_2"."people"."birthplace_city" AS "birth_place",
    "local_2"."people"."birthplace_region" AS "birth_region",
    "local_2"."people"."birthplace_country" AS "birth_country",
    "local_2"."people"."height_m" AS "height_meters",
    "local_2"."people"."preferred_nickname" AS "nickname"
FROM "local_2"."people";

-- Reconstruct Vote from local_3.episodeRating
CREATE VIEW "Vote" AS
SELECT
    "local_3"."episodeRating"."episodeId" AS "episode_id",
    "local_3"."episodeRating"."starRating" AS "stars",
    "local_3"."episodeRating"."voteCount" AS "votes",
    "local_3"."episodeRating"."votePercentage" AS "percent"
FROM "local_3"."episodeRating";
