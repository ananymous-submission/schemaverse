-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct characters from local_1.mov_info
CREATE VIEW "characters" AS
SELECT
    "local_1"."mov_info"."mov_title" AS "movie_title",
    "local_1"."mov_info"."rel_date" AS "release_date",
    "local_1"."mov_info"."lead_char" AS "hero",
    "local_1"."mov_info"."antag_char" AS "villian",
    "local_1"."mov_info"."feat_song" AS "song"
FROM "local_1"."mov_info";

-- Reconstruct director from local_2.film_credits
CREATE VIEW "director" AS
SELECT
    "local_2"."film_credits"."film_title" AS "name",
    "local_2"."film_credits"."director_full_name" AS "director"
FROM "local_2"."film_credits";

-- Reconstruct movies_total_gross from vertical split + row partition on a fragment
CREATE VIEW "movies_total_gross" AS
SELECT t0.[mov_title], t0.[rel_date], t0.[genre_cat], t0.[mpaa_rt], t1.[tot_gross], t1.[infl_adj_gross]
FROM (
SELECT [gross_mpaa_act_thr_rom].[__orig_rowid] AS __orig_rowid, [local_1].[gross_mpaa_act_thr_rom].[mov_title], [local_1].[gross_mpaa_act_thr_rom].[rel_date], [local_1].[gross_mpaa_act_thr_rom].[genre_cat], [local_1].[gross_mpaa_act_thr_rom].[mpaa_rt] FROM [local_1].[gross_mpaa_act_thr_rom]
UNION
SELECT [gross_mpaa_adventure].[__orig_rowid] AS __orig_rowid, [local_1].[gross_mpaa_adventure].[mov_title], [local_1].[gross_mpaa_adventure].[rel_date], [local_1].[gross_mpaa_adventure].[genre_cat], [local_1].[gross_mpaa_adventure].[mpaa_rt] FROM [local_1].[gross_mpaa_adventure]
UNION
SELECT [gross_mpaa_comedy].[__orig_rowid] AS __orig_rowid, [local_1].[gross_mpaa_comedy].[mov_title], [local_1].[gross_mpaa_comedy].[rel_date], [local_1].[gross_mpaa_comedy].[genre_cat], [local_1].[gross_mpaa_comedy].[mpaa_rt] FROM [local_1].[gross_mpaa_comedy]
UNION
SELECT [gross_mpaa_drama].[__orig_rowid] AS __orig_rowid, [local_1].[gross_mpaa_drama].[mov_title], [local_1].[gross_mpaa_drama].[rel_date], [local_1].[gross_mpaa_drama].[genre_cat], [local_1].[gross_mpaa_drama].[mpaa_rt] FROM [local_1].[gross_mpaa_drama]
UNION
SELECT [gross_mpaa_other_doc_mus].[__orig_rowid] AS __orig_rowid, [local_1].[gross_mpaa_other_doc_mus].[mov_title], [local_1].[gross_mpaa_other_doc_mus].[rel_date], [local_1].[gross_mpaa_other_doc_mus].[genre_cat], [local_1].[gross_mpaa_other_doc_mus].[mpaa_rt] FROM [local_1].[gross_mpaa_other_doc_mus]
) t0
JOIN [local_1].[gross_mpaa_full] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct revenue from local_2.annual_revenue_summary
CREATE VIEW "revenue" AS
SELECT
    "local_2"."annual_revenue_summary"."fiscal_year" AS "Year",
    "local_2"."annual_revenue_summary"."studio_entertainment_revenue" AS "Studio Entertainment[NI 1]",
    "local_2"."annual_revenue_summary"."consumer_products_revenue" AS "Disney Consumer Products[NI 2]",
    "local_2"."annual_revenue_summary"."interactive_media_revenue" AS "Disney Interactive[NI 3][Rev 1]",
    "local_2"."annual_revenue_summary"."parks_and_resorts_revenue" AS "Walt Disney Parks and Resorts",
    "local_2"."annual_revenue_summary"."media_networks_segment" AS "Disney Media Networks",
    "local_2"."annual_revenue_summary"."total_revenue" AS "Total"
FROM "local_2"."annual_revenue_summary";

-- Reconstruct voice-actors from local_3.VoicePerformances
CREATE VIEW "voice-actors" AS
SELECT
    "local_3"."VoicePerformances"."CharacterName" AS "character",
    "local_3"."VoicePerformances"."PerformerName" AS "voice-actor",
    "local_3"."VoicePerformances"."FilmTitle" AS "movie"
FROM "local_3"."VoicePerformances";
