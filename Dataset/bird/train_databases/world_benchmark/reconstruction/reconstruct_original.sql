-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct City from local_2.UrbanLocality
CREATE VIEW "City" AS
SELECT
    "local_2"."UrbanLocality"."UrbanLocalityId" AS "ID",
    "local_2"."UrbanLocality"."LocalityName" AS "Name",
    "local_2"."UrbanLocality"."NationIsoCode" AS "CountryCode",
    "local_2"."UrbanLocality"."AdministrativeDistrict" AS "District",
    "local_2"."UrbanLocality"."ResidentPopulation" AS "Population"
FROM "local_2"."UrbanLocality";

-- Reconstruct Country from vertical split + row partition on a fragment
CREATE VIEW "Country" AS
SELECT t0.[countryCode], t0.[commonName], t1.[continentName], t1.[regionName], t0.[landAreaKm2], t0.[independenceYear], t1.[populationCount], t0.[averageLifeExpectancy], t1.[gnpCurrent], t1.[gnpHistorical], t0.[localLanguageName], t0.[governmentType], t0.[headOfStateName], t0.[capitalCityId], t0.[alternateCountryCode]
FROM (
SELECT [countryCapitalOtherGovernmentForms].[__orig_rowid] AS __orig_rowid, [local_1].[countryCapitalOtherGovernmentForms].[countryCode], [local_1].[countryCapitalOtherGovernmentForms].[commonName], [local_1].[countryCapitalOtherGovernmentForms].[landAreaKm2], [local_1].[countryCapitalOtherGovernmentForms].[independenceYear], [local_1].[countryCapitalOtherGovernmentForms].[averageLifeExpectancy], [local_1].[countryCapitalOtherGovernmentForms].[localLanguageName], [local_1].[countryCapitalOtherGovernmentForms].[governmentType], [local_1].[countryCapitalOtherGovernmentForms].[headOfStateName], [local_1].[countryCapitalOtherGovernmentForms].[capitalCityId], [local_1].[countryCapitalOtherGovernmentForms].[alternateCountryCode] FROM [local_1].[countryCapitalOtherGovernmentForms]
UNION
SELECT [CountryConstitutionalMonarchy].[__orig_rowid] AS __orig_rowid, [local_2].[CountryConstitutionalMonarchy].[IsoCode], [local_2].[CountryConstitutionalMonarchy].[OfficialEnglishName], [local_2].[CountryConstitutionalMonarchy].[TotalSurfaceArea], [local_2].[CountryConstitutionalMonarchy].[IndependenceYear], [local_2].[CountryConstitutionalMonarchy].[AverageLifeExpectancy], [local_2].[CountryConstitutionalMonarchy].[NativeName], [local_2].[CountryConstitutionalMonarchy].[GovernmentStructure], [local_2].[CountryConstitutionalMonarchy].[HeadOfStateName], [local_2].[CountryConstitutionalMonarchy].[CapitalCityId], [local_2].[CountryConstitutionalMonarchy].[SecondaryIsoCode] FROM [local_2].[CountryConstitutionalMonarchy]
UNION
SELECT [CountryOtherGovernmentForms].[__orig_rowid] AS __orig_rowid, [local_2].[CountryOtherGovernmentForms].[IsoCode], [local_2].[CountryOtherGovernmentForms].[OfficialEnglishName], [local_2].[CountryOtherGovernmentForms].[TotalSurfaceArea], [local_2].[CountryOtherGovernmentForms].[IndependenceYear], [local_2].[CountryOtherGovernmentForms].[AverageLifeExpectancy], [local_2].[CountryOtherGovernmentForms].[NativeName], [local_2].[CountryOtherGovernmentForms].[GovernmentStructure], [local_2].[CountryOtherGovernmentForms].[HeadOfStateName], [local_2].[CountryOtherGovernmentForms].[CapitalCityId], [local_2].[CountryOtherGovernmentForms].[SecondaryIsoCode] FROM [local_2].[CountryOtherGovernmentForms]
UNION
SELECT [CountryRepublic].[__orig_rowid] AS __orig_rowid, [local_2].[CountryRepublic].[IsoCode], [local_2].[CountryRepublic].[OfficialEnglishName], [local_2].[CountryRepublic].[TotalSurfaceArea], [local_2].[CountryRepublic].[IndependenceYear], [local_2].[CountryRepublic].[AverageLifeExpectancy], [local_2].[CountryRepublic].[NativeName], [local_2].[CountryRepublic].[GovernmentStructure], [local_2].[CountryRepublic].[HeadOfStateName], [local_2].[CountryRepublic].[CapitalCityId], [local_2].[CountryRepublic].[SecondaryIsoCode] FROM [local_2].[CountryRepublic]
) t0
JOIN [local_1].[countryCapitalListedGovernmentForms] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct CountryLanguage from row partitions (UNION (overlap))
CREATE VIEW "CountryLanguage" AS
SELECT "local_3"."country_language_share_pct_le_1_2"."country_iso_code" AS "CountryCode", "local_3"."country_language_share_pct_le_1_2"."language_name" AS "Language", "local_3"."country_language_share_pct_le_1_2"."official_language_flag" AS "IsOfficial", "local_3"."country_language_share_pct_le_1_2"."share_percentage" AS "Percentage" FROM "local_3"."country_language_share_pct_le_1_2"
UNION
SELECT "local_3"."country_language_share_pct_gt_1_2_le_5_3"."country_iso_code" AS "CountryCode", "local_3"."country_language_share_pct_gt_1_2_le_5_3"."language_name" AS "Language", "local_3"."country_language_share_pct_gt_1_2_le_5_3"."official_language_flag" AS "IsOfficial", "local_3"."country_language_share_pct_gt_1_2_le_5_3"."share_percentage" AS "Percentage" FROM "local_3"."country_language_share_pct_gt_1_2_le_5_3"
UNION
SELECT "local_3"."country_language_share_pct_gt_5_3_le_21_1"."country_iso_code" AS "CountryCode", "local_3"."country_language_share_pct_gt_5_3_le_21_1"."language_name" AS "Language", "local_3"."country_language_share_pct_gt_5_3_le_21_1"."official_language_flag" AS "IsOfficial", "local_3"."country_language_share_pct_gt_5_3_le_21_1"."share_percentage" AS "Percentage" FROM "local_3"."country_language_share_pct_gt_5_3_le_21_1"
UNION
SELECT "local_3"."country_language_share_pct_gt_21_1_or_null"."country_iso_code" AS "CountryCode", "local_3"."country_language_share_pct_gt_21_1_or_null"."language_name" AS "Language", "local_3"."country_language_share_pct_gt_21_1_or_null"."official_language_flag" AS "IsOfficial", "local_3"."country_language_share_pct_gt_21_1_or_null"."share_percentage" AS "Percentage" FROM "local_3"."country_language_share_pct_gt_21_1_or_null";
