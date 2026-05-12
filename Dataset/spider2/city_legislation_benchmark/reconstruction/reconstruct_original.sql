-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";

-- Reconstruct alien_data from vertical split + row partition on a fragment
CREATE VIEW "alien_data" AS
SELECT t0.[RecordId], t1.[GivenName], t1.[FamilyName], t0.[EmailAddress], t0.[GenderIdentity], t0.[EntityType], t0.[BirthYear], t0.[AgeYears], t0.[FavoriteFood], t0.[FeedingFrequency], t2.[AggressionScore], t0.[OccupationTitle], t1.[CurrentLocation], t2.[StateName], t2.[USRegion], t1.[CountryName]
FROM [local_1].[AlienAgeMetrics] t0
JOIN [local_1].[AlienAgeProfiles] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [AlienAggressionBirth1747To1823].[__orig_rowid] AS __orig_rowid, [local_1].[AlienAggressionBirth1747To1823].[RecordId], [local_1].[AlienAggressionBirth1747To1823].[EmailAddress], [local_1].[AlienAggressionBirth1747To1823].[BirthYear], [local_1].[AlienAggressionBirth1747To1823].[FeedingFrequency], [local_1].[AlienAggressionBirth1747To1823].[AggressionScore], [local_1].[AlienAggressionBirth1747To1823].[StateName], [local_1].[AlienAggressionBirth1747To1823].[USRegion] FROM [local_1].[AlienAggressionBirth1747To1823]
UNION
SELECT [AlienAggressionBirth1824To1897].[__orig_rowid] AS __orig_rowid, [local_1].[AlienAggressionBirth1824To1897].[RecordId], [local_1].[AlienAggressionBirth1824To1897].[EmailAddress], [local_1].[AlienAggressionBirth1824To1897].[BirthYear], [local_1].[AlienAggressionBirth1824To1897].[FeedingFrequency], [local_1].[AlienAggressionBirth1824To1897].[AggressionScore], [local_1].[AlienAggressionBirth1824To1897].[StateName], [local_1].[AlienAggressionBirth1824To1897].[USRegion] FROM [local_1].[AlienAggressionBirth1824To1897]
UNION
SELECT [AlienAggressionBirthAfter1897OrUnknown].[__orig_rowid] AS __orig_rowid, [local_1].[AlienAggressionBirthAfter1897OrUnknown].[RecordId], [local_1].[AlienAggressionBirthAfter1897OrUnknown].[EmailAddress], [local_1].[AlienAggressionBirthAfter1897OrUnknown].[BirthYear], [local_1].[AlienAggressionBirthAfter1897OrUnknown].[FeedingFrequency], [local_1].[AlienAggressionBirthAfter1897OrUnknown].[AggressionScore], [local_1].[AlienAggressionBirthAfter1897OrUnknown].[StateName], [local_1].[AlienAggressionBirthAfter1897OrUnknown].[USRegion] FROM [local_1].[AlienAggressionBirthAfter1897OrUnknown]
UNION
SELECT [AlienAggressionBirthUpTo1746].[__orig_rowid] AS __orig_rowid, [local_1].[AlienAggressionBirthUpTo1746].[RecordId], [local_1].[AlienAggressionBirthUpTo1746].[EmailAddress], [local_1].[AlienAggressionBirthUpTo1746].[BirthYear], [local_1].[AlienAggressionBirthUpTo1746].[FeedingFrequency], [local_1].[AlienAggressionBirthUpTo1746].[AggressionScore], [local_1].[AlienAggressionBirthUpTo1746].[StateName], [local_1].[AlienAggressionBirthUpTo1746].[USRegion] FROM [local_1].[AlienAggressionBirthUpTo1746]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct aliens from row partitions (UNION (overlap))
CREATE VIEW "aliens" AS
SELECT "local_1"."AlienProfilesBirthUpTo1746"."ProfileId" AS "id", "local_1"."AlienProfilesBirthUpTo1746"."GivenName" AS "first_name", "local_1"."AlienProfilesBirthUpTo1746"."FamilyName" AS "last_name", "local_1"."AlienProfilesBirthUpTo1746"."EmailAddress" AS "email", "local_1"."AlienProfilesBirthUpTo1746"."GenderIdentity" AS "gender", "local_1"."AlienProfilesBirthUpTo1746"."EntityType" AS "type", "local_1"."AlienProfilesBirthUpTo1746"."BirthYear" AS "birth_year" FROM "local_1"."AlienProfilesBirthUpTo1746"
UNION
SELECT "local_1"."AlienProfilesBirth1747To1823"."ProfileId" AS "id", "local_1"."AlienProfilesBirth1747To1823"."GivenName" AS "first_name", "local_1"."AlienProfilesBirth1747To1823"."FamilyName" AS "last_name", "local_1"."AlienProfilesBirth1747To1823"."EmailAddress" AS "email", "local_1"."AlienProfilesBirth1747To1823"."GenderIdentity" AS "gender", "local_1"."AlienProfilesBirth1747To1823"."EntityType" AS "type", "local_1"."AlienProfilesBirth1747To1823"."BirthYear" AS "birth_year" FROM "local_1"."AlienProfilesBirth1747To1823"
UNION
SELECT "local_1"."AlienProfilesBirth1824To1897"."ProfileId" AS "id", "local_1"."AlienProfilesBirth1824To1897"."GivenName" AS "first_name", "local_1"."AlienProfilesBirth1824To1897"."FamilyName" AS "last_name", "local_1"."AlienProfilesBirth1824To1897"."EmailAddress" AS "email", "local_1"."AlienProfilesBirth1824To1897"."GenderIdentity" AS "gender", "local_1"."AlienProfilesBirth1824To1897"."EntityType" AS "type", "local_1"."AlienProfilesBirth1824To1897"."BirthYear" AS "birth_year" FROM "local_1"."AlienProfilesBirth1824To1897"
UNION
SELECT "local_1"."AlienProfilesBirthAfter1897OrUnknown"."ProfileId" AS "id", "local_1"."AlienProfilesBirthAfter1897OrUnknown"."GivenName" AS "first_name", "local_1"."AlienProfilesBirthAfter1897OrUnknown"."FamilyName" AS "last_name", "local_1"."AlienProfilesBirthAfter1897OrUnknown"."EmailAddress" AS "email", "local_1"."AlienProfilesBirthAfter1897OrUnknown"."GenderIdentity" AS "gender", "local_1"."AlienProfilesBirthAfter1897OrUnknown"."EntityType" AS "type", "local_1"."AlienProfilesBirthAfter1897OrUnknown"."BirthYear" AS "birth_year" FROM "local_1"."AlienProfilesBirthAfter1897OrUnknown";

-- Reconstruct aliens_details from row partitions (UNION (overlap))
CREATE VIEW "aliens_details" AS
SELECT "local_1"."AlienDetailsFeedingOnce"."DetailRecordId" AS "detail_id", "local_1"."AlienDetailsFeedingOnce"."FavoriteFoodItem" AS "favorite_food", "local_1"."AlienDetailsFeedingOnce"."FeedingFrequency" AS "feeding_frequency", "local_1"."AlienDetailsFeedingOnce"."AggressionScore" AS "aggressive" FROM "local_1"."AlienDetailsFeedingOnce"
UNION
SELECT "local_1"."AlienDetailsFeedingMonthlyOrNull"."DetailRecordId" AS "detail_id", "local_1"."AlienDetailsFeedingMonthlyOrNull"."FavoriteFoodItem" AS "favorite_food", "local_1"."AlienDetailsFeedingMonthlyOrNull"."FeedingFrequency" AS "feeding_frequency", "local_1"."AlienDetailsFeedingMonthlyOrNull"."AggressionScore" AS "aggressive" FROM "local_1"."AlienDetailsFeedingMonthlyOrNull"
UNION
SELECT "local_2"."alien_details_weekly"."alien_detail_id" AS "detail_id", "local_2"."alien_details_weekly"."preferred_food" AS "favorite_food", "local_2"."alien_details_weekly"."feeding_schedule" AS "feeding_frequency", "local_2"."alien_details_weekly"."is_aggressive" AS "aggressive" FROM "local_2"."alien_details_weekly"
UNION
SELECT "local_2"."alien_details_never"."alien_detail_id" AS "detail_id", "local_2"."alien_details_never"."preferred_food" AS "favorite_food", "local_2"."alien_details_never"."feeding_schedule" AS "feeding_frequency", "local_2"."alien_details_never"."is_aggressive" AS "aggressive" FROM "local_2"."alien_details_never"
UNION
SELECT "local_2"."alien_details_daily"."alien_detail_id" AS "detail_id", "local_2"."alien_details_daily"."preferred_food" AS "favorite_food", "local_2"."alien_details_daily"."feeding_schedule" AS "feeding_frequency", "local_2"."alien_details_daily"."is_aggressive" AS "aggressive" FROM "local_2"."alien_details_daily"
UNION
SELECT "local_2"."alien_details_seldom"."alien_detail_id" AS "detail_id", "local_2"."alien_details_seldom"."preferred_food" AS "favorite_food", "local_2"."alien_details_seldom"."feeding_schedule" AS "feeding_frequency", "local_2"."alien_details_seldom"."is_aggressive" AS "aggressive" FROM "local_2"."alien_details_seldom"
UNION
SELECT "local_2"."alien_details_yearly"."alien_detail_id" AS "detail_id", "local_2"."alien_details_yearly"."preferred_food" AS "favorite_food", "local_2"."alien_details_yearly"."feeding_schedule" AS "feeding_frequency", "local_2"."alien_details_yearly"."is_aggressive" AS "aggressive" FROM "local_2"."alien_details_yearly"
UNION
SELECT "local_2"."alien_details_often"."alien_detail_id" AS "detail_id", "local_2"."alien_details_often"."preferred_food" AS "favorite_food", "local_2"."alien_details_often"."feeding_schedule" AS "feeding_frequency", "local_2"."alien_details_often"."is_aggressive" AS "aggressive" FROM "local_2"."alien_details_often";

-- Reconstruct aliens_location from row partitions (UNION (overlap))
CREATE VIEW "aliens_location" AS
SELECT "local_1"."AlienLocationMajorUSCities"."LocationId" AS "loc_id", "local_1"."AlienLocationMajorUSCities"."CurrentLocationName" AS "current_location", "local_1"."AlienLocationMajorUSCities"."StateName" AS "state", "local_1"."AlienLocationMajorUSCities"."CountryName" AS "country", "local_1"."AlienLocationMajorUSCities"."OccupationTitle" AS "occupation" FROM "local_1"."AlienLocationMajorUSCities"
UNION
SELECT "local_1"."AlienLocationOtherOrNull"."LocationId" AS "loc_id", "local_1"."AlienLocationOtherOrNull"."CurrentLocationName" AS "current_location", "local_1"."AlienLocationOtherOrNull"."StateName" AS "state", "local_1"."AlienLocationOtherOrNull"."CountryName" AS "country", "local_1"."AlienLocationOtherOrNull"."OccupationTitle" AS "occupation" FROM "local_1"."AlienLocationOtherOrNull";

-- Reconstruct cities from row partitions (UNION (overlap))
CREATE VIEW "cities" AS
SELECT "local_1"."CitiesUnitedStates"."CityId" AS "city_id", "local_1"."CitiesUnitedStates"."CityName" AS "city_name", "local_1"."CitiesUnitedStates"."Latitude" AS "latitude", "local_1"."CitiesUnitedStates"."Longitude" AS "longitude", "local_1"."CitiesUnitedStates"."CountryCode2" AS "country_code_2", "local_1"."CitiesUnitedStates"."IsCapital" AS "capital", "local_1"."CitiesUnitedStates"."Population" AS "population", "local_1"."CitiesUnitedStates"."InsertedOn" AS "insert_date" FROM "local_1"."CitiesUnitedStates"
UNION
SELECT "local_1"."CitiesBrazilGreatBritainJapan"."CityId" AS "city_id", "local_1"."CitiesBrazilGreatBritainJapan"."CityName" AS "city_name", "local_1"."CitiesBrazilGreatBritainJapan"."Latitude" AS "latitude", "local_1"."CitiesBrazilGreatBritainJapan"."Longitude" AS "longitude", "local_1"."CitiesBrazilGreatBritainJapan"."CountryCode2" AS "country_code_2", "local_1"."CitiesBrazilGreatBritainJapan"."IsCapital" AS "capital", "local_1"."CitiesBrazilGreatBritainJapan"."Population" AS "population", "local_1"."CitiesBrazilGreatBritainJapan"."InsertedOn" AS "insert_date" FROM "local_1"."CitiesBrazilGreatBritainJapan"
UNION
SELECT "local_1"."CitiesGermanyPhilippinesChinaItaly"."CityId" AS "city_id", "local_1"."CitiesGermanyPhilippinesChinaItaly"."CityName" AS "city_name", "local_1"."CitiesGermanyPhilippinesChinaItaly"."Latitude" AS "latitude", "local_1"."CitiesGermanyPhilippinesChinaItaly"."Longitude" AS "longitude", "local_1"."CitiesGermanyPhilippinesChinaItaly"."CountryCode2" AS "country_code_2", "local_1"."CitiesGermanyPhilippinesChinaItaly"."IsCapital" AS "capital", "local_1"."CitiesGermanyPhilippinesChinaItaly"."Population" AS "population", "local_1"."CitiesGermanyPhilippinesChinaItaly"."InsertedOn" AS "insert_date" FROM "local_1"."CitiesGermanyPhilippinesChinaItaly"
UNION
SELECT "local_4"."cityCatalogIndia"."cityId" AS "city_id", "local_4"."cityCatalogIndia"."cityName" AS "city_name", "local_4"."cityCatalogIndia"."latitudeDegrees" AS "latitude", "local_4"."cityCatalogIndia"."longitudeDegrees" AS "longitude", "local_4"."cityCatalogIndia"."countryIsoAlpha2" AS "country_code_2", "local_4"."cityCatalogIndia"."isCapital" AS "capital", "local_4"."cityCatalogIndia"."populationEstimate" AS "population", "local_4"."cityCatalogIndia"."insertedAt" AS "insert_date" FROM "local_4"."cityCatalogIndia"
UNION
SELECT "local_4"."cityCatalogOtherCountries"."cityId" AS "city_id", "local_4"."cityCatalogOtherCountries"."cityName" AS "city_name", "local_4"."cityCatalogOtherCountries"."latitudeDegrees" AS "latitude", "local_4"."cityCatalogOtherCountries"."longitudeDegrees" AS "longitude", "local_4"."cityCatalogOtherCountries"."countryIsoAlpha2" AS "country_code_2", "local_4"."cityCatalogOtherCountries"."isCapital" AS "capital", "local_4"."cityCatalogOtherCountries"."populationEstimate" AS "population", "local_4"."cityCatalogOtherCountries"."insertedAt" AS "insert_date" FROM "local_4"."cityCatalogOtherCountries";

-- Reconstruct cities_countries from row partitions (UNION (overlap))
CREATE VIEW "cities_countries" AS
SELECT "local_1"."CountriesLatinAmericaAndTheCaribbean"."CountryId" AS "country_id", "local_1"."CountriesLatinAmericaAndTheCaribbean"."CountryName" AS "country_name", "local_1"."CountriesLatinAmericaAndTheCaribbean"."CountryCode2" AS "country_code_2", "local_1"."CountriesLatinAmericaAndTheCaribbean"."CountryCode3" AS "country_code_3", "local_1"."CountriesLatinAmericaAndTheCaribbean"."RegionName" AS "region", "local_1"."CountriesLatinAmericaAndTheCaribbean"."SubRegion" AS "sub_region", "local_1"."CountriesLatinAmericaAndTheCaribbean"."IntermediateRegion" AS "intermediate_region", "local_1"."CountriesLatinAmericaAndTheCaribbean"."CreatedOn" AS "created_on" FROM "local_1"."CountriesLatinAmericaAndTheCaribbean"
UNION
SELECT "local_1"."CountriesWesternAsiaPolynesiaSouthernAsia"."CountryId" AS "country_id", "local_1"."CountriesWesternAsiaPolynesiaSouthernAsia"."CountryName" AS "country_name", "local_1"."CountriesWesternAsiaPolynesiaSouthernAsia"."CountryCode2" AS "country_code_2", "local_1"."CountriesWesternAsiaPolynesiaSouthernAsia"."CountryCode3" AS "country_code_3", "local_1"."CountriesWesternAsiaPolynesiaSouthernAsia"."RegionName" AS "region", "local_1"."CountriesWesternAsiaPolynesiaSouthernAsia"."SubRegion" AS "sub_region", "local_1"."CountriesWesternAsiaPolynesiaSouthernAsia"."IntermediateRegion" AS "intermediate_region", "local_1"."CountriesWesternAsiaPolynesiaSouthernAsia"."CreatedOn" AS "created_on" FROM "local_1"."CountriesWesternAsiaPolynesiaSouthernAsia"
UNION
SELECT "local_1"."CountriesEuropeAndSoutheastAsiaRegions"."CountryId" AS "country_id", "local_1"."CountriesEuropeAndSoutheastAsiaRegions"."CountryName" AS "country_name", "local_1"."CountriesEuropeAndSoutheastAsiaRegions"."CountryCode2" AS "country_code_2", "local_1"."CountriesEuropeAndSoutheastAsiaRegions"."CountryCode3" AS "country_code_3", "local_1"."CountriesEuropeAndSoutheastAsiaRegions"."RegionName" AS "region", "local_1"."CountriesEuropeAndSoutheastAsiaRegions"."SubRegion" AS "sub_region", "local_1"."CountriesEuropeAndSoutheastAsiaRegions"."IntermediateRegion" AS "intermediate_region", "local_1"."CountriesEuropeAndSoutheastAsiaRegions"."CreatedOn" AS "created_on" FROM "local_1"."CountriesEuropeAndSoutheastAsiaRegions"
UNION
SELECT "local_5"."countries_subsaharan_africa"."country_key" AS "country_id", "local_5"."countries_subsaharan_africa"."country_label" AS "country_name", "local_5"."countries_subsaharan_africa"."iso_alpha2" AS "country_code_2", "local_5"."countries_subsaharan_africa"."iso_alpha3" AS "country_code_3", "local_5"."countries_subsaharan_africa"."macro_region" AS "region", "local_5"."countries_subsaharan_africa"."subregion_label" AS "sub_region", "local_5"."countries_subsaharan_africa"."intermediate_area" AS "intermediate_region", "local_5"."countries_subsaharan_africa"."record_created_at" AS "created_on" FROM "local_5"."countries_subsaharan_africa"
UNION
SELECT "local_5"."countries_other_subregions"."country_key" AS "country_id", "local_5"."countries_other_subregions"."country_label" AS "country_name", "local_5"."countries_other_subregions"."iso_alpha2" AS "country_code_2", "local_5"."countries_other_subregions"."iso_alpha3" AS "country_code_3", "local_5"."countries_other_subregions"."macro_region" AS "region", "local_5"."countries_other_subregions"."subregion_label" AS "sub_region", "local_5"."countries_other_subregions"."intermediate_area" AS "intermediate_region", "local_5"."countries_other_subregions"."record_created_at" AS "created_on" FROM "local_5"."countries_other_subregions";

-- Reconstruct cities_currencies from local_1.CountryCurrencies
CREATE VIEW "cities_currencies" AS
SELECT
    "local_1"."CountryCurrencies"."CurrencyId" AS "currency_id",
    "local_1"."CountryCurrencies"."CountryCode2" AS "country_code_2",
    "local_1"."CountryCurrencies"."CurrencyName" AS "currency_name",
    "local_1"."CountryCurrencies"."CurrencyCode" AS "currency_code"
FROM "local_1"."CountryCurrencies";

-- Reconstruct cities_languages from row partitions (UNION (overlap))
CREATE VIEW "cities_languages" AS
SELECT "local_1"."LanguagesForIndiaTanzaniaSouthAfricaKenyaRussiaFranceCameroonSwitzerlandChina"."LanguageId" AS "language_id", "local_1"."LanguagesForIndiaTanzaniaSouthAfricaKenyaRussiaFranceCameroonSwitzerlandChina"."LanguageName" AS "language", "local_1"."LanguagesForIndiaTanzaniaSouthAfricaKenyaRussiaFranceCameroonSwitzerlandChina"."CountryCode2" AS "country_code_2" FROM "local_1"."LanguagesForIndiaTanzaniaSouthAfricaKenyaRussiaFranceCameroonSwitzerlandChina"
UNION
SELECT "local_1"."LanguagesForOtherCountries"."LanguageId" AS "language_id", "local_1"."LanguagesForOtherCountries"."LanguageName" AS "language", "local_1"."LanguagesForOtherCountries"."CountryCode2" AS "country_code_2" FROM "local_1"."LanguagesForOtherCountries";

-- Reconstruct job_company from local_2.employer_profiles
CREATE VIEW "job_company" AS
SELECT
    "local_2"."employer_profiles"."employer_id" AS "company_id",
    "local_2"."employer_profiles"."employer_name" AS "name",
    "local_2"."employer_profiles"."website_url" AS "link",
    "local_2"."employer_profiles"."google_profile_url" AS "link_google",
    "local_2"."employer_profiles"."logo_thumbnail" AS "thumbnail"
FROM "local_2"."employer_profiles";

-- Reconstruct job_postings_fact from vertical split + row partition on a fragment
CREATE VIEW "job_postings_fact" AS
SELECT t0.[job_uid], t0.[co_key], t0.[title_abbr], t0.[title_full], t1.[job_loc], t0.[src_via], t0.[sched_type], t2.[wfh_flag], t0.[srch_loc], t0.[post_dt], t2.[no_deg_flag], t2.[health_ins_flag], t0.[job_ctry], t3.[pay_rate], t3.[pay_yr_avg], t3.[pay_hr_avg]
FROM [local_3].[jp_co_country_hist] t0
JOIN [local_3].[jp_co_loc_hist] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [jp_health_gt0_or_null].[__orig_rowid] AS __orig_rowid, [local_3].[jp_health_gt0_or_null].[job_uid], [local_3].[jp_health_gt0_or_null].[wfh_flag], [local_3].[jp_health_gt0_or_null].[no_deg_flag], [local_3].[jp_health_gt0_or_null].[health_ins_flag] FROM [local_3].[jp_health_gt0_or_null]
UNION
SELECT [jp_health_le0].[__orig_rowid] AS __orig_rowid, [local_3].[jp_health_le0].[job_uid], [local_3].[jp_health_le0].[wfh_flag], [local_3].[jp_health_le0].[no_deg_flag], [local_3].[jp_health_le0].[health_ins_flag] FROM [local_3].[jp_health_le0]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_3].[jp_salary_avg] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct legislation_date_dim from row partitions (UNION (overlap))
CREATE VIEW "legislation_date_dim" AS
SELECT "local_4"."legislationDatesDayUpToEight"."calendarDate" AS "date", "local_4"."legislationDatesDayUpToEight"."monthLabel" AS "month_name", "local_4"."legislationDatesDayUpToEight"."dayNumber" AS "day_of_month" FROM "local_4"."legislationDatesDayUpToEight"
UNION
SELECT "local_4"."legislationDatesDayNineToSixteen"."calendarDate" AS "date", "local_4"."legislationDatesDayNineToSixteen"."monthLabel" AS "month_name", "local_4"."legislationDatesDayNineToSixteen"."dayNumber" AS "day_of_month" FROM "local_4"."legislationDatesDayNineToSixteen"
UNION
SELECT "local_4"."legislationDatesDaySeventeenToTwentyThree"."calendarDate" AS "date", "local_4"."legislationDatesDaySeventeenToTwentyThree"."monthLabel" AS "month_name", "local_4"."legislationDatesDaySeventeenToTwentyThree"."dayNumber" AS "day_of_month" FROM "local_4"."legislationDatesDaySeventeenToTwentyThree"
UNION
SELECT "local_4"."legislationDatesDayAboveTwentyThree"."calendarDate" AS "date", "local_4"."legislationDatesDayAboveTwentyThree"."monthLabel" AS "month_name", "local_4"."legislationDatesDayAboveTwentyThree"."dayNumber" AS "day_of_month" FROM "local_4"."legislationDatesDayAboveTwentyThree";

-- Reconstruct legislators from vertical (column) split (4 fragments)
CREATE VIEW "legislators" AS
SELECT
    t3."FullName" AS "full_name",
    t3."FirstName" AS "first_name",
    t3."LastName" AS "last_name",
    t3."MiddleName" AS "middle_name",
    t3."Nickname" AS "nickname",
    t1."NameSuffix" AS "suffix",
    t3."OtherNamesEnd" AS "other_names_end",
    t3."OtherNamesMiddle" AS "other_names_middle",
    t3."OtherNamesLast" AS "other_names_last",
    t0."BirthDate" AS "birthday",
    t1."Gender" AS "gender",
    t1."BioguideId" AS "id_bioguide",
    t0."PreviousBioguideId" AS "id_bioguide_previous_0",
    t0."GovTrackId" AS "id_govtrack",
    t0."IcpsrId" AS "id_icpsr",
    t0."WikipediaId" AS "id_wikipedia",
    t0."WikidataId" AS "id_wikidata",
    t0."GoogleEntityId" AS "id_google_entity_id",
    t1."HouseHistoryId" AS "id_house_history",
    t1."HouseHistoryAlternateId" AS "id_house_history_alternate",
    t0."ThomasId" AS "id_thomas",
    t0."CspanId" AS "id_cspan",
    t0."VoteSmartId" AS "id_votesmart",
    t0."LisId" AS "id_lis",
    t0."BallotpediaId" AS "id_ballotpedia",
    t0."OpenSecretsId" AS "id_opensecrets",
    t2."FecIdAlpha" AS "id_fec_0",
    t2."FecIdBeta" AS "id_fec_1",
    t2."FecIdGamma" AS "id_fec_2"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "GoogleEntityId" ORDER BY rowid) AS __rn FROM "local_1"."LegislatorsBirthdayAdditionalIdentifiers") t0
JOIN "local_1"."LegislatorsBirthdayIdentifiers" t1 ON t0."GoogleEntityId" IS t1."GoogleEntityId" AND t0.__rn = t1.__rn
JOIN "local_1"."LegislatorsFecIdentifiers" t2 ON t0."GoogleEntityId" IS t2."GoogleEntityId" AND t0.__rn = t2.__rn
JOIN "local_1"."LegislatorsNames" t3 ON t0."GoogleEntityId" IS t3."GoogleEntityId" AND t0.__rn = t3.__rn;

-- Reconstruct legislators_terms from vertical split + row partition on a fragment
CREATE VIEW "legislators_terms" AS
SELECT t0.[bio_id], t3.[term_num], t0.[term_key], t1.[term_kind], t3.[term_start_dt], t3.[term_end_dt], t2.[st_code], t2.[dist_num], t0.[class_num], t0.[party_affil], t1.[contact_method], t0.[web_url], t0.[addr], t0.[phone_num], t0.[fax_num], t0.[contact_url], t0.[office_loc], t2.[st_rank], t0.[rss_feed], t0.[cauc]
FROM [local_3].[leg_term_addr_full] t0
JOIN [local_3].[leg_term_addr_meta] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [leg_term_dist_gt11_or_null].[__orig_rowid] AS __orig_rowid, [local_3].[leg_term_dist_gt11_or_null].[bio_id], [local_3].[leg_term_dist_gt11_or_null].[term_key], [local_3].[leg_term_dist_gt11_or_null].[st_code], [local_3].[leg_term_dist_gt11_or_null].[dist_num], [local_3].[leg_term_dist_gt11_or_null].[st_rank] FROM [local_3].[leg_term_dist_gt11_or_null]
UNION
SELECT [leg_term_dist_gt2_le6].[__orig_rowid] AS __orig_rowid, [local_3].[leg_term_dist_gt2_le6].[bio_id], [local_3].[leg_term_dist_gt2_le6].[term_key], [local_3].[leg_term_dist_gt2_le6].[st_code], [local_3].[leg_term_dist_gt2_le6].[dist_num], [local_3].[leg_term_dist_gt2_le6].[st_rank] FROM [local_3].[leg_term_dist_gt2_le6]
UNION
SELECT [leg_term_dist_gt6_le11].[__orig_rowid] AS __orig_rowid, [local_3].[leg_term_dist_gt6_le11].[bio_id], [local_3].[leg_term_dist_gt6_le11].[term_key], [local_3].[leg_term_dist_gt6_le11].[st_code], [local_3].[leg_term_dist_gt6_le11].[dist_num], [local_3].[leg_term_dist_gt6_le11].[st_rank] FROM [local_3].[leg_term_dist_gt6_le11]
UNION
SELECT [leg_term_dist_le2].[__orig_rowid] AS __orig_rowid, [local_3].[leg_term_dist_le2].[bio_id], [local_3].[leg_term_dist_le2].[term_key], [local_3].[leg_term_dist_le2].[st_code], [local_3].[leg_term_dist_le2].[dist_num], [local_3].[leg_term_dist_le2].[st_rank] FROM [local_3].[leg_term_dist_le2]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_3].[leg_term_party_hist] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct skills_dim from local_5.skills_catalog
CREATE VIEW "skills_dim" AS
SELECT
    "local_5"."skills_catalog"."skill_key" AS "skill_id",
    "local_5"."skills_catalog"."skill_name" AS "skills",
    "local_5"."skills_catalog"."skill_category" AS "type"
FROM "local_5"."skills_catalog";

-- Reconstruct skills_job_dim from local_2.job_skill_associations
CREATE VIEW "skills_job_dim" AS
SELECT
    "local_2"."job_skill_associations"."job_reference_id" AS "job_id",
    "local_2"."job_skill_associations"."skill_reference_id" AS "skill_id"
FROM "local_2"."job_skill_associations";
