-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";

-- Reconstruct country from local_1.nation
CREATE VIEW "country" AS
SELECT
    "local_1"."nation"."nationId" AS "country_id",
    "local_1"."nation"."isoCode" AS "country_iso_code",
    "local_1"."nation"."commonName" AS "country_name"
FROM "local_1"."nation";

-- Reconstruct department from local_1.orgUnit
CREATE VIEW "department" AS
SELECT
    "local_1"."orgUnit"."unitId" AS "department_id",
    "local_1"."orgUnit"."unitName" AS "department_name"
FROM "local_1"."orgUnit";

-- Reconstruct gender from local_1.genderCategory
CREATE VIEW "gender" AS
SELECT
    "local_1"."genderCategory"."categoryId" AS "gender_id",
    "local_1"."genderCategory"."categoryLabel" AS "gender"
FROM "local_1"."genderCategory";

-- Reconstruct genre from local_1.contentGenre
CREATE VIEW "genre" AS
SELECT
    "local_1"."contentGenre"."genreKey" AS "genre_id",
    "local_1"."contentGenre"."genreLabel" AS "genre_name"
FROM "local_1"."contentGenre";

-- Reconstruct keyword from local_1.searchTerm
CREATE VIEW "keyword" AS
SELECT
    "local_1"."searchTerm"."termId" AS "keyword_id",
    "local_1"."searchTerm"."termText" AS "keyword_name"
FROM "local_1"."searchTerm";

-- Reconstruct language from local_1.locale
CREATE VIEW "language" AS
SELECT
    "local_1"."locale"."localeId" AS "language_id",
    "local_1"."locale"."isoLanguageCode" AS "language_code",
    "local_1"."locale"."localName" AS "language_name"
FROM "local_1"."locale";

-- Reconstruct language_role from local_2.lang_role
CREATE VIEW "language_role" AS
SELECT
    "local_2"."lang_role"."role_pk" AS "role_id",
    "local_2"."lang_role"."role_lbl" AS "language_role"
FROM "local_2"."lang_role";

-- Reconstruct movie from vertical split + row partition on a fragment
CREATE VIEW "movie" AS
SELECT t0.[movie_uid], t2.[OfficialTitle], t0.[budget_amount], t2.[HomepageUrl], t0.[synopsis], t0.[popularity_score], t0.[released_on], t1.[boxOfficeRevenue], t0.[duration_minutes], t0.[status_label], t2.[Tagline], t0.[average_rating], t1.[ratingCount]
FROM (
SELECT [movies_budget_over_forty_million_or_null].[__orig_rowid] AS __orig_rowid, [local_3].[movies_budget_over_forty_million_or_null].[movie_uid], [local_3].[movies_budget_over_forty_million_or_null].[budget_amount], [local_3].[movies_budget_over_forty_million_or_null].[synopsis], [local_3].[movies_budget_over_forty_million_or_null].[popularity_score], [local_3].[movies_budget_over_forty_million_or_null].[released_on], [local_3].[movies_budget_over_forty_million_or_null].[duration_minutes], [local_3].[movies_budget_over_forty_million_or_null].[status_label], [local_3].[movies_budget_over_forty_million_or_null].[average_rating] FROM [local_3].[movies_budget_over_forty_million_or_null]
UNION
SELECT [movies_budget_under_one_million].[__orig_rowid] AS __orig_rowid, [local_3].[movies_budget_under_one_million].[movie_uid], [local_3].[movies_budget_under_one_million].[budget_amount], [local_3].[movies_budget_under_one_million].[synopsis], [local_3].[movies_budget_under_one_million].[popularity_score], [local_3].[movies_budget_under_one_million].[released_on], [local_3].[movies_budget_under_one_million].[duration_minutes], [local_3].[movies_budget_under_one_million].[status_label], [local_3].[movies_budget_under_one_million].[average_rating] FROM [local_3].[movies_budget_under_one_million]
UNION
SELECT [MovieBudgetBetween15MillionAnd40Million].[__orig_rowid] AS __orig_rowid, [local_4].[MovieBudgetBetween15MillionAnd40Million].[MovieId], [local_4].[MovieBudgetBetween15MillionAnd40Million].[ProductionBudget], [local_4].[MovieBudgetBetween15MillionAnd40Million].[Synopsis], [local_4].[MovieBudgetBetween15MillionAnd40Million].[PopularityScore], [local_4].[MovieBudgetBetween15MillionAnd40Million].[ReleaseDate], [local_4].[MovieBudgetBetween15MillionAnd40Million].[RuntimeMinutes], [local_4].[MovieBudgetBetween15MillionAnd40Million].[ReleaseStatus], [local_4].[MovieBudgetBetween15MillionAnd40Million].[AverageVote] FROM [local_4].[MovieBudgetBetween15MillionAnd40Million]
UNION
SELECT [MovieBudgetBetween1MillionAnd15Million].[__orig_rowid] AS __orig_rowid, [local_4].[MovieBudgetBetween1MillionAnd15Million].[MovieId], [local_4].[MovieBudgetBetween1MillionAnd15Million].[ProductionBudget], [local_4].[MovieBudgetBetween1MillionAnd15Million].[Synopsis], [local_4].[MovieBudgetBetween1MillionAnd15Million].[PopularityScore], [local_4].[MovieBudgetBetween1MillionAnd15Million].[ReleaseDate], [local_4].[MovieBudgetBetween1MillionAnd15Million].[RuntimeMinutes], [local_4].[MovieBudgetBetween1MillionAnd15Million].[ReleaseStatus], [local_4].[MovieBudgetBetween1MillionAnd15Million].[AverageVote] FROM [local_4].[MovieBudgetBetween1MillionAnd15Million]
) t0
JOIN [local_5].[filmFinancials] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_4].[MovieWebPresence] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct movie_cast from local_3.film_cast_members
CREATE VIEW "movie_cast" AS
SELECT
    "local_3"."film_cast_members"."movie_uid" AS "movie_id",
    "local_3"."film_cast_members"."person_uid" AS "person_id",
    "local_3"."film_cast_members"."role_name" AS "character_name",
    "local_3"."film_cast_members"."gender_ref" AS "gender_id",
    "local_3"."film_cast_members"."billing_order" AS "cast_order"
FROM "local_3"."film_cast_members";

-- Reconstruct movie_company from local_5.filmStudioRelations
CREATE VIEW "movie_company" AS
SELECT
    "local_5"."filmStudioRelations"."filmId" AS "movie_id",
    "local_5"."filmStudioRelations"."studioId" AS "company_id"
FROM "local_5"."filmStudioRelations";

-- Reconstruct movie_crew from local_4.MovieCrewAssignment
CREATE VIEW "movie_crew" AS
SELECT
    "local_4"."MovieCrewAssignment"."MovieId" AS "movie_id",
    "local_4"."MovieCrewAssignment"."PersonId" AS "person_id",
    "local_4"."MovieCrewAssignment"."DepartmentId" AS "department_id",
    "local_4"."MovieCrewAssignment"."CrewRole" AS "job"
FROM "local_4"."MovieCrewAssignment";

-- Reconstruct movie_genres from local_2.film_genre_map
CREATE VIEW "movie_genres" AS
SELECT
    "local_2"."film_genre_map"."film_id" AS "movie_id",
    "local_2"."film_genre_map"."genre_fk" AS "genre_id"
FROM "local_2"."film_genre_map";

-- Reconstruct movie_keywords from local_3.film_keyword_associations
CREATE VIEW "movie_keywords" AS
SELECT
    "local_3"."film_keyword_associations"."movie_uid" AS "movie_id",
    "local_3"."film_keyword_associations"."keyword_ref" AS "keyword_id"
FROM "local_3"."film_keyword_associations";

-- Reconstruct movie_languages from local_2.film_lang_map
CREATE VIEW "movie_languages" AS
SELECT
    "local_2"."film_lang_map"."film_id" AS "movie_id",
    "local_2"."film_lang_map"."lang_fk" AS "language_id",
    "local_2"."film_lang_map"."role_fk" AS "language_role_id"
FROM "local_2"."film_lang_map";

-- Reconstruct person from local_4.PersonRecord
CREATE VIEW "person" AS
SELECT
    "local_4"."PersonRecord"."PersonId" AS "person_id",
    "local_4"."PersonRecord"."FullName" AS "person_name"
FROM "local_4"."PersonRecord";

-- Reconstruct production_company from local_5.productionStudios
CREATE VIEW "production_company" AS
SELECT
    "local_5"."productionStudios"."studioId" AS "company_id",
    "local_5"."productionStudios"."studioName" AS "company_name"
FROM "local_5"."productionStudios";

-- Reconstruct production_country from local_3.film_production_countries
CREATE VIEW "production_country" AS
SELECT
    "local_3"."film_production_countries"."movie_uid" AS "movie_id",
    "local_3"."film_production_countries"."country_ref" AS "country_id"
FROM "local_3"."film_production_countries";
