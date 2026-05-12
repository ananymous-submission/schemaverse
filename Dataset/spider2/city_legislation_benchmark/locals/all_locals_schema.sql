-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/city_legislation/city_legislation.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "AlienAgeMetrics" (
    "RecordId" INTEGER,
    "AgeYears" INTEGER,
    "BirthYear" INTEGER,
    "EmailAddress" TEXT,
    "FavoriteFood" TEXT,
    "FeedingFrequency" TEXT,
    "GenderIdentity" TEXT,
    "OccupationTitle" TEXT,
    "EntityType" TEXT
);

CREATE TABLE "AlienAggressionBirthUpTo1746" (
    "RecordId" INTEGER,
    "AggressionScore" INTEGER,
    "BirthYear" INTEGER,
    "EmailAddress" TEXT,
    "FeedingFrequency" TEXT,
    "StateName" TEXT,
    "USRegion" TEXT
);

CREATE TABLE "AlienAggressionBirth1747To1823" (
    "RecordId" INTEGER,
    "AggressionScore" INTEGER,
    "BirthYear" INTEGER,
    "EmailAddress" TEXT,
    "FeedingFrequency" TEXT,
    "StateName" TEXT,
    "USRegion" TEXT
);

CREATE TABLE "AlienAggressionBirth1824To1897" (
    "RecordId" INTEGER,
    "AggressionScore" INTEGER,
    "BirthYear" INTEGER,
    "EmailAddress" TEXT,
    "FeedingFrequency" TEXT,
    "StateName" TEXT,
    "USRegion" TEXT
);

CREATE TABLE "AlienAggressionBirthAfter1897OrUnknown" (
    "RecordId" INTEGER,
    "AggressionScore" INTEGER,
    "BirthYear" INTEGER,
    "EmailAddress" TEXT,
    "FeedingFrequency" TEXT,
    "StateName" TEXT,
    "USRegion" TEXT
);

CREATE TABLE "AlienAgeProfiles" (
    "RecordId" INTEGER,
    "AgeYears" INTEGER,
    "CountryName" TEXT,
    "CurrentLocation" TEXT,
    "GivenName" TEXT,
    "GenderIdentity" TEXT,
    "FamilyName" TEXT,
    "EntityType" TEXT
);

CREATE TABLE "AlienProfilesBirthUpTo1746" (
    "ProfileId" INTEGER,
    "GivenName" TEXT,
    "FamilyName" TEXT,
    "EmailAddress" TEXT,
    "GenderIdentity" TEXT,
    "EntityType" TEXT,
    "BirthYear" INTEGER
);

CREATE TABLE "AlienProfilesBirth1747To1823" (
    "ProfileId" INTEGER,
    "GivenName" TEXT,
    "FamilyName" TEXT,
    "EmailAddress" TEXT,
    "GenderIdentity" TEXT,
    "EntityType" TEXT,
    "BirthYear" INTEGER
);

CREATE TABLE "AlienProfilesBirth1824To1897" (
    "ProfileId" INTEGER,
    "GivenName" TEXT,
    "FamilyName" TEXT,
    "EmailAddress" TEXT,
    "GenderIdentity" TEXT,
    "EntityType" TEXT,
    "BirthYear" INTEGER
);

CREATE TABLE "AlienProfilesBirthAfter1897OrUnknown" (
    "ProfileId" INTEGER,
    "GivenName" TEXT,
    "FamilyName" TEXT,
    "EmailAddress" TEXT,
    "GenderIdentity" TEXT,
    "EntityType" TEXT,
    "BirthYear" INTEGER
);

CREATE TABLE "AlienDetailsFeedingOnce" (
    "DetailRecordId" INTEGER,
    "FavoriteFoodItem" TEXT,
    "FeedingFrequency" TEXT,
    "AggressionScore" INTEGER
);

CREATE TABLE "AlienDetailsFeedingMonthlyOrNull" (
    "DetailRecordId" INTEGER,
    "FavoriteFoodItem" TEXT,
    "FeedingFrequency" TEXT,
    "AggressionScore" INTEGER
);

CREATE TABLE "AlienLocationMajorUSCities" (
    "LocationId" INTEGER,
    "CurrentLocationName" TEXT,
    "StateName" TEXT,
    "CountryName" TEXT,
    "OccupationTitle" TEXT
);

CREATE TABLE "AlienLocationOtherOrNull" (
    "LocationId" INTEGER,
    "CurrentLocationName" TEXT,
    "StateName" TEXT,
    "CountryName" TEXT,
    "OccupationTitle" TEXT
);

CREATE TABLE "CountryCurrencies" (
    "CurrencyId" INTEGER,
    "CountryCode2" TEXT,
    "CurrencyName" TEXT,
    "CurrencyCode" TEXT
);

CREATE TABLE "LanguagesForIndiaTanzaniaSouthAfricaKenyaRussiaFranceCameroonSwitzerlandChina" (
    "LanguageId" INTEGER,
    "LanguageName" TEXT,
    "CountryCode2" TEXT
);

CREATE TABLE "LanguagesForOtherCountries" (
    "LanguageId" INTEGER,
    "LanguageName" TEXT,
    "CountryCode2" TEXT
);

CREATE TABLE "LegislatorsBirthdayIdentifiers" (
    "GoogleEntityId" TEXT,
    "BirthDate" TEXT,
    "Gender" TEXT,
    "BallotpediaId" TEXT,
    "BioguideId" TEXT,
    "PreviousBioguideId" TEXT,
    "CspanId" REAL,
    "GovTrackId" INTEGER,
    "HouseHistoryId" REAL,
    "HouseHistoryAlternateId" REAL,
    "IcpsrId" REAL,
    "OpenSecretsId" TEXT,
    "VoteSmartId" REAL,
    "WikidataId" TEXT,
    "WikipediaId" TEXT,
    "NameSuffix" TEXT
);

CREATE TABLE "LegislatorsNames" (
    "GoogleEntityId" TEXT,
    "FirstName" TEXT,
    "FullName" TEXT,
    "Gender" TEXT,
    "LastName" TEXT,
    "MiddleName" TEXT,
    "Nickname" TEXT,
    "OtherNamesEnd" TEXT,
    "OtherNamesLast" TEXT,
    "OtherNamesMiddle" REAL,
    "NameSuffix" TEXT
);

CREATE TABLE "LegislatorsFecIdentifiers" (
    "GoogleEntityId" TEXT,
    "FecIdAlpha" TEXT,
    "FecIdBeta" TEXT,
    "FecIdGamma" TEXT
);

CREATE TABLE "LegislatorsBirthdayAdditionalIdentifiers" (
    "GoogleEntityId" TEXT,
    "BirthDate" TEXT,
    "BallotpediaId" TEXT,
    "PreviousBioguideId" TEXT,
    "CspanId" REAL,
    "GovTrackId" INTEGER,
    "IcpsrId" REAL,
    "LisId" TEXT,
    "OpenSecretsId" TEXT,
    "ThomasId" REAL,
    "VoteSmartId" REAL,
    "WikidataId" TEXT,
    "WikipediaId" TEXT
);

CREATE TABLE "CitiesUnitedStates" (
    "CityId" INTEGER,
    "CityName" TEXT,
    "Latitude" REAL,
    "Longitude" REAL,
    "CountryCode2" TEXT,
    "IsCapital" INTEGER,
    "Population" REAL,
    "InsertedOn" TEXT
);

CREATE TABLE "CitiesBrazilGreatBritainJapan" (
    "CityId" INTEGER,
    "CityName" TEXT,
    "Latitude" REAL,
    "Longitude" REAL,
    "CountryCode2" TEXT,
    "IsCapital" INTEGER,
    "Population" REAL,
    "InsertedOn" TEXT
);

CREATE TABLE "CitiesGermanyPhilippinesChinaItaly" (
    "CityId" INTEGER,
    "CityName" TEXT,
    "Latitude" REAL,
    "Longitude" REAL,
    "CountryCode2" TEXT,
    "IsCapital" INTEGER,
    "Population" REAL,
    "InsertedOn" TEXT
);

CREATE TABLE "CountriesLatinAmericaAndTheCaribbean" (
    "CountryId" INTEGER,
    "CountryName" TEXT,
    "CountryCode2" TEXT,
    "CountryCode3" TEXT,
    "RegionName" TEXT,
    "SubRegion" TEXT,
    "IntermediateRegion" TEXT,
    "CreatedOn" TEXT
);

CREATE TABLE "CountriesWesternAsiaPolynesiaSouthernAsia" (
    "CountryId" INTEGER,
    "CountryName" TEXT,
    "CountryCode2" TEXT,
    "CountryCode3" TEXT,
    "RegionName" TEXT,
    "SubRegion" TEXT,
    "IntermediateRegion" TEXT,
    "CreatedOn" TEXT
);

CREATE TABLE "CountriesEuropeAndSoutheastAsiaRegions" (
    "CountryId" INTEGER,
    "CountryName" TEXT,
    "CountryCode2" TEXT,
    "CountryCode3" TEXT,
    "RegionName" TEXT,
    "SubRegion" TEXT,
    "IntermediateRegion" TEXT,
    "CreatedOn" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "employer_profiles" (
    "employer_id" INTEGER,
    "employer_name" TEXT,
    "website_url" TEXT,
    "google_profile_url" TEXT,
    "logo_thumbnail" TEXT
);

CREATE TABLE "job_skill_associations" (
    "job_reference_id" INTEGER,
    "skill_reference_id" INTEGER
);

CREATE TABLE "alien_details_weekly" (
    "alien_detail_id" INTEGER,
    "preferred_food" TEXT,
    "feeding_schedule" TEXT,
    "is_aggressive" INTEGER
);

CREATE TABLE "alien_details_never" (
    "alien_detail_id" INTEGER,
    "preferred_food" TEXT,
    "feeding_schedule" TEXT,
    "is_aggressive" INTEGER
);

CREATE TABLE "alien_details_daily" (
    "alien_detail_id" INTEGER,
    "preferred_food" TEXT,
    "feeding_schedule" TEXT,
    "is_aggressive" INTEGER
);

CREATE TABLE "alien_details_seldom" (
    "alien_detail_id" INTEGER,
    "preferred_food" TEXT,
    "feeding_schedule" TEXT,
    "is_aggressive" INTEGER
);

CREATE TABLE "alien_details_yearly" (
    "alien_detail_id" INTEGER,
    "preferred_food" TEXT,
    "feeding_schedule" TEXT,
    "is_aggressive" INTEGER
);

CREATE TABLE "alien_details_often" (
    "alien_detail_id" INTEGER,
    "preferred_food" TEXT,
    "feeding_schedule" TEXT,
    "is_aggressive" INTEGER
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "jp_co_country_hist" (
    "job_uid" INTEGER,
    "co_key" INTEGER,
    "job_ctry" TEXT,
    "post_dt" TEXT,
    "sched_type" TEXT,
    "title_full" TEXT,
    "title_abbr" TEXT,
    "src_via" TEXT,
    "srch_loc" TEXT
);

CREATE TABLE "jp_co_loc_hist" (
    "job_uid" INTEGER,
    "co_key" INTEGER,
    "job_ctry" TEXT,
    "job_loc" TEXT,
    "post_dt" TEXT,
    "sched_type" TEXT,
    "src_via" TEXT,
    "srch_loc" TEXT
);

CREATE TABLE "jp_health_le0" (
    "job_uid" INTEGER,
    "health_ins_flag" INTEGER,
    "no_deg_flag" INTEGER,
    "wfh_flag" INTEGER
);

CREATE TABLE "jp_health_gt0_or_null" (
    "job_uid" INTEGER,
    "health_ins_flag" INTEGER,
    "no_deg_flag" INTEGER,
    "wfh_flag" INTEGER
);

CREATE TABLE "jp_salary_avg" (
    "job_uid" INTEGER,
    "pay_hr_avg" REAL,
    "pay_rate" TEXT,
    "pay_yr_avg" REAL
);

CREATE TABLE "leg_term_addr_full" (
    "term_key" TEXT,
    "addr" TEXT,
    "cauc" TEXT,
    "class_num" REAL,
    "contact_url" TEXT,
    "fax_num" TEXT,
    "bio_id" TEXT,
    "office_loc" TEXT,
    "party_affil" TEXT,
    "phone_num" TEXT,
    "rss_feed" TEXT,
    "web_url" TEXT
);

CREATE TABLE "leg_term_addr_meta" (
    "term_key" TEXT,
    "addr" TEXT,
    "cauc" TEXT,
    "class_num" REAL,
    "contact_url" TEXT,
    "contact_method" TEXT,
    "office_loc" TEXT,
    "rss_feed" TEXT,
    "term_kind" TEXT
);

CREATE TABLE "leg_term_dist_le2" (
    "term_key" TEXT,
    "dist_num" REAL,
    "bio_id" TEXT,
    "st_code" TEXT,
    "st_rank" TEXT
);

CREATE TABLE "leg_term_dist_gt2_le6" (
    "term_key" TEXT,
    "dist_num" REAL,
    "bio_id" TEXT,
    "st_code" TEXT,
    "st_rank" TEXT
);

CREATE TABLE "leg_term_dist_gt6_le11" (
    "term_key" TEXT,
    "dist_num" REAL,
    "bio_id" TEXT,
    "st_code" TEXT,
    "st_rank" TEXT
);

CREATE TABLE "leg_term_dist_gt11_or_null" (
    "term_key" TEXT,
    "dist_num" REAL,
    "bio_id" TEXT,
    "st_code" TEXT,
    "st_rank" TEXT
);

CREATE TABLE "leg_term_party_hist" (
    "term_key" TEXT,
    "party_affil" TEXT,
    "term_end_dt" TEXT,
    "term_num" INTEGER,
    "term_start_dt" TEXT
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "cityCatalogIndia" (
    "cityId" INTEGER,
    "cityName" TEXT,
    "latitudeDegrees" REAL,
    "longitudeDegrees" REAL,
    "countryIsoAlpha2" TEXT,
    "isCapital" INTEGER,
    "populationEstimate" REAL,
    "insertedAt" TEXT
);

CREATE TABLE "cityCatalogOtherCountries" (
    "cityId" INTEGER,
    "cityName" TEXT,
    "latitudeDegrees" REAL,
    "longitudeDegrees" REAL,
    "countryIsoAlpha2" TEXT,
    "isCapital" INTEGER,
    "populationEstimate" REAL,
    "insertedAt" TEXT
);

CREATE TABLE "legislationDatesDayUpToEight" (
    "calendarDate" TEXT,
    "monthLabel" TEXT,
    "dayNumber" INTEGER
);

CREATE TABLE "legislationDatesDayNineToSixteen" (
    "calendarDate" TEXT,
    "monthLabel" TEXT,
    "dayNumber" INTEGER
);

CREATE TABLE "legislationDatesDaySeventeenToTwentyThree" (
    "calendarDate" TEXT,
    "monthLabel" TEXT,
    "dayNumber" INTEGER
);

CREATE TABLE "legislationDatesDayAboveTwentyThree" (
    "calendarDate" TEXT,
    "monthLabel" TEXT,
    "dayNumber" INTEGER
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "countries_subsaharan_africa" (
    "country_key" INTEGER,
    "country_label" TEXT,
    "iso_alpha2" TEXT,
    "iso_alpha3" TEXT,
    "macro_region" TEXT,
    "subregion_label" TEXT,
    "intermediate_area" TEXT,
    "record_created_at" TEXT
);

CREATE TABLE "countries_other_subregions" (
    "country_key" INTEGER,
    "country_label" TEXT,
    "iso_alpha2" TEXT,
    "iso_alpha3" TEXT,
    "macro_region" TEXT,
    "subregion_label" TEXT,
    "intermediate_area" TEXT,
    "record_created_at" TEXT
);

CREATE TABLE "skills_catalog" (
    "skill_key" INTEGER,
    "skill_name" TEXT,
    "skill_category" TEXT
);

