-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";

-- Reconstruct actor from local_1.Performer
CREATE VIEW "actor" AS
SELECT
    "local_1"."Performer"."PerformerId" AS "actor_id",
    "local_1"."Performer"."GivenName" AS "first_name",
    "local_1"."Performer"."FamilyName" AS "last_name",
    "local_1"."Performer"."LastModifiedAt" AS "last_update"
FROM "local_1"."Performer";

-- Reconstruct address from local_2.addr_master
CREATE VIEW "address" AS
SELECT
    "local_2"."addr_master"."addr_ref" AS "address_id",
    "local_2"."addr_master"."addr_line1" AS "address",
    "local_2"."addr_master"."addr_line2" AS "address2",
    "local_2"."addr_master"."region" AS "district",
    "local_2"."addr_master"."city_ref" AS "city_id",
    "local_2"."addr_master"."post_code" AS "postal_code",
    "local_2"."addr_master"."phone_num" AS "phone",
    "local_2"."addr_master"."upd_ts" AS "last_update"
FROM "local_2"."addr_master";

-- Reconstruct category from local_3.film_genre
CREATE VIEW "category" AS
SELECT
    "local_3"."film_genre"."genre_id" AS "category_id",
    "local_3"."film_genre"."genre_name" AS "name",
    "local_3"."film_genre"."updated_at" AS "last_update"
FROM "local_3"."film_genre";

-- Reconstruct city from local_4.municipality
CREATE VIEW "city" AS
SELECT
    "local_4"."municipality"."municipalityId" AS "city_id",
    "local_4"."municipality"."municipalityName" AS "city",
    "local_4"."municipality"."nationId" AS "country_id",
    "local_4"."municipality"."lastModifiedAt" AS "last_update"
FROM "local_4"."municipality";

-- Reconstruct country from local_4.nation
CREATE VIEW "country" AS
SELECT
    "local_4"."nation"."nationId" AS "country_id",
    "local_4"."nation"."nationName" AS "country",
    "local_4"."nation"."lastModifiedAt" AS "last_update"
FROM "local_4"."nation";

-- Reconstruct customer from vertical split + row partition on a fragment
CREATE VIEW "customer" AS
SELECT t0.[cust_ref], t1.[store_ref], t0.[fname], t0.[lname], t0.[contact_email], t1.[addr_ref], t0.[is_active_flag], t0.[created_ts], t0.[upd_ts]
FROM (
SELECT [cust_active_created_20060214_220436].[__orig_rowid] AS __orig_rowid, [local_2].[cust_active_created_20060214_220436].[cust_ref], [local_2].[cust_active_created_20060214_220436].[fname], [local_2].[cust_active_created_20060214_220436].[lname], [local_2].[cust_active_created_20060214_220436].[contact_email], [local_2].[cust_active_created_20060214_220436].[is_active_flag], [local_2].[cust_active_created_20060214_220436].[created_ts], [local_2].[cust_active_created_20060214_220436].[upd_ts] FROM [local_2].[cust_active_created_20060214_220436]
UNION
SELECT [cust_active_created_20060214_220437].[__orig_rowid] AS __orig_rowid, [local_2].[cust_active_created_20060214_220437].[cust_ref], [local_2].[cust_active_created_20060214_220437].[fname], [local_2].[cust_active_created_20060214_220437].[lname], [local_2].[cust_active_created_20060214_220437].[contact_email], [local_2].[cust_active_created_20060214_220437].[is_active_flag], [local_2].[cust_active_created_20060214_220437].[created_ts], [local_2].[cust_active_created_20060214_220437].[upd_ts] FROM [local_2].[cust_active_created_20060214_220437]
) t0
JOIN [local_2].[cust_active_addr] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct film from vertical split + row partition on a fragment
CREATE VIEW "film" AS
SELECT t0.[FilmId], t0.[FilmTitle], t0.[Synopsis], t0.[ReleaseYear], t1.[locale_id], t1.[original_locale_id], t0.[RentalDurationDays], t0.[RentalRate], t0.[DurationMinutes], t0.[ReplacementCost], t0.[ContentRating], t0.[SpecialFeatures], t0.[LastModifiedAt]
FROM (
SELECT [FilmsLength115To149].[__orig_rowid] AS __orig_rowid, [local_1].[FilmsLength115To149].[FilmId], [local_1].[FilmsLength115To149].[FilmTitle], [local_1].[FilmsLength115To149].[Synopsis], [local_1].[FilmsLength115To149].[ReleaseYear], [local_1].[FilmsLength115To149].[RentalDurationDays], [local_1].[FilmsLength115To149].[RentalRate], [local_1].[FilmsLength115To149].[DurationMinutes], [local_1].[FilmsLength115To149].[ReplacementCost], [local_1].[FilmsLength115To149].[ContentRating], [local_1].[FilmsLength115To149].[SpecialFeatures], [local_1].[FilmsLength115To149].[LastModifiedAt] FROM [local_1].[FilmsLength115To149]
UNION
SELECT [FilmsLength150OrGreaterOrUnknown].[__orig_rowid] AS __orig_rowid, [local_1].[FilmsLength150OrGreaterOrUnknown].[FilmId], [local_1].[FilmsLength150OrGreaterOrUnknown].[FilmTitle], [local_1].[FilmsLength150OrGreaterOrUnknown].[Synopsis], [local_1].[FilmsLength150OrGreaterOrUnknown].[ReleaseYear], [local_1].[FilmsLength150OrGreaterOrUnknown].[RentalDurationDays], [local_1].[FilmsLength150OrGreaterOrUnknown].[RentalRate], [local_1].[FilmsLength150OrGreaterOrUnknown].[DurationMinutes], [local_1].[FilmsLength150OrGreaterOrUnknown].[ReplacementCost], [local_1].[FilmsLength150OrGreaterOrUnknown].[ContentRating], [local_1].[FilmsLength150OrGreaterOrUnknown].[SpecialFeatures], [local_1].[FilmsLength150OrGreaterOrUnknown].[LastModifiedAt] FROM [local_1].[FilmsLength150OrGreaterOrUnknown]
UNION
SELECT [FilmsLength81To114].[__orig_rowid] AS __orig_rowid, [local_1].[FilmsLength81To114].[FilmId], [local_1].[FilmsLength81To114].[FilmTitle], [local_1].[FilmsLength81To114].[Synopsis], [local_1].[FilmsLength81To114].[ReleaseYear], [local_1].[FilmsLength81To114].[RentalDurationDays], [local_1].[FilmsLength81To114].[RentalRate], [local_1].[FilmsLength81To114].[DurationMinutes], [local_1].[FilmsLength81To114].[ReplacementCost], [local_1].[FilmsLength81To114].[ContentRating], [local_1].[FilmsLength81To114].[SpecialFeatures], [local_1].[FilmsLength81To114].[LastModifiedAt] FROM [local_1].[FilmsLength81To114]
UNION
SELECT [movie_descriptions_short].[__orig_rowid] AS __orig_rowid, [local_5].[movie_descriptions_short].[movie_id], [local_5].[movie_descriptions_short].[title_text], [local_5].[movie_descriptions_short].[summary_text], [local_5].[movie_descriptions_short].[release_year_text], [local_5].[movie_descriptions_short].[rental_period_days], [local_5].[movie_descriptions_short].[rental_price], [local_5].[movie_descriptions_short].[duration_minutes], [local_5].[movie_descriptions_short].[replacement_price], [local_5].[movie_descriptions_short].[content_rating], [local_5].[movie_descriptions_short].[extra_features], [local_5].[movie_descriptions_short].[updated_at] FROM [local_5].[movie_descriptions_short]
) t0
JOIN [local_5].[movie_language_assignments] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct film_actor from local_1.FilmCasting
CREATE VIEW "film_actor" AS
SELECT
    "local_1"."FilmCasting"."PerformerId" AS "actor_id",
    "local_1"."FilmCasting"."FilmId" AS "film_id",
    "local_1"."FilmCasting"."LastModifiedAt" AS "last_update"
FROM "local_1"."FilmCasting";

-- Reconstruct film_category from local_3.film_genre_link
CREATE VIEW "film_category" AS
SELECT
    "local_3"."film_genre_link"."movie_id" AS "film_id",
    "local_3"."film_genre_link"."genre_id" AS "category_id",
    "local_3"."film_genre_link"."updated_at" AS "last_update"
FROM "local_3"."film_genre_link";

-- Reconstruct film_text from local_5.movie_title_descriptions
CREATE VIEW "film_text" AS
SELECT
    "local_5"."movie_title_descriptions"."movie_id" AS "film_id",
    "local_5"."movie_title_descriptions"."title_text" AS "title",
    "local_5"."movie_title_descriptions"."summary_text" AS "description"
FROM "local_5"."movie_title_descriptions";

-- Reconstruct inventory from local_2.inv_stock
CREATE VIEW "inventory" AS
SELECT
    "local_2"."inv_stock"."inv_ref" AS "inventory_id",
    "local_2"."inv_stock"."film_ref" AS "film_id",
    "local_2"."inv_stock"."store_ref" AS "store_id",
    "local_2"."inv_stock"."upd_ts" AS "last_update"
FROM "local_2"."inv_stock";

-- Reconstruct language from local_5.spoken_languages
CREATE VIEW "language" AS
SELECT
    "local_5"."spoken_languages"."locale_id" AS "language_id",
    "local_5"."spoken_languages"."locale_name" AS "name",
    "local_5"."spoken_languages"."updated_at" AS "last_update"
FROM "local_5"."spoken_languages";

-- Reconstruct payment from vertical split + row partition on a fragment
CREATE VIEW "payment" AS
SELECT t0.[pay_ref], t1.[cust_ref], t1.[staff_ref], t0.[rental_ref], t0.[amt], t0.[pay_ts], t0.[upd_ts]
FROM (
SELECT [pay_amt_2_99_to_4_99].[__orig_rowid] AS __orig_rowid, [local_2].[pay_amt_2_99_to_4_99].[pay_ref], [local_2].[pay_amt_2_99_to_4_99].[rental_ref], [local_2].[pay_amt_2_99_to_4_99].[amt], [local_2].[pay_amt_2_99_to_4_99].[pay_ts], [local_2].[pay_amt_2_99_to_4_99].[upd_ts] FROM [local_2].[pay_amt_2_99_to_4_99]
UNION
SELECT [pay_amt_gt_4_99].[__orig_rowid] AS __orig_rowid, [local_2].[pay_amt_gt_4_99].[pay_ref], [local_2].[pay_amt_gt_4_99].[rental_ref], [local_2].[pay_amt_gt_4_99].[amt], [local_2].[pay_amt_gt_4_99].[pay_ts], [local_2].[pay_amt_gt_4_99].[upd_ts] FROM [local_2].[pay_amt_gt_4_99]
UNION
SELECT [pay_amt_lte_2_99].[__orig_rowid] AS __orig_rowid, [local_2].[pay_amt_lte_2_99].[pay_ref], [local_2].[pay_amt_lte_2_99].[rental_ref], [local_2].[pay_amt_lte_2_99].[amt], [local_2].[pay_amt_lte_2_99].[pay_ts], [local_2].[pay_amt_lte_2_99].[upd_ts] FROM [local_2].[pay_amt_lte_2_99]
) t0
JOIN [local_2].[pay_amt_full] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct rental from vertical (column) split (2 fragments)
CREATE VIEW "rental" AS
SELECT
    t0."rental_ref" AS "rental_id",
    t1."rented_ts" AS "rental_date",
    t0."inv_ref" AS "inventory_id",
    t0."cust_ref" AS "customer_id",
    t1."returned_ts" AS "return_date",
    t0."staff_ref" AS "staff_id",
    t0."upd_ts" AS "last_update"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "rental_ref" ORDER BY rowid) AS __rn FROM "local_2"."rental_by_cust") t0
JOIN "local_2"."rental_by_inv" t1 ON t0."rental_ref" IS t1."rental_ref" AND t0.__rn = t1.__rn;

-- Reconstruct staff from vertical (column) split (2 fragments)
CREATE VIEW "staff" AS
SELECT
    t0."staff_ref" AS "staff_id",
    t0."fname" AS "first_name",
    t0."lname" AS "last_name",
    t1."addr_ref" AS "address_id",
    t0."avatar_blob" AS "picture",
    t1."contact_email" AS "email",
    t1."store_ref" AS "store_id",
    t0."is_active_flag" AS "active",
    t0."user_name" AS "username",
    t0."pwd_hash" AS "password",
    t0."upd_ts" AS "last_update"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "staff_ref" ORDER BY rowid) AS __rn FROM "local_2"."staff_auth") t0
JOIN "local_2"."staff_contact" t1 ON t0."staff_ref" IS t1."staff_ref" AND t0.__rn = t1.__rn;

-- Reconstruct store from local_2.store_loc
CREATE VIEW "store" AS
SELECT
    "local_2"."store_loc"."store_ref" AS "store_id",
    "local_2"."store_loc"."mgr_staff_ref" AS "manager_staff_id",
    "local_2"."store_loc"."addr_ref" AS "address_id",
    "local_2"."store_loc"."upd_ts" AS "last_update"
FROM "local_2"."store_loc";
