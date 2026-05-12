-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";
ATTACH DATABASE 'local_6.sqlite' AS "local_6";
ATTACH DATABASE 'local_7.sqlite' AS "local_7";
ATTACH DATABASE 'local_8.sqlite' AS "local_8";

-- Reconstruct borders from local_2.country_borders
CREATE VIEW "borders" AS
SELECT
    "local_2"."country_borders"."home_country" AS "Country1",
    "local_2"."country_borders"."adjacent_country" AS "Country2",
    "local_2"."country_borders"."border_length" AS "Length"
FROM "local_2"."country_borders";

-- Reconstruct city from local_1.CityLocality
CREATE VIEW "city" AS
SELECT
    "local_1"."CityLocality"."CityName" AS "Name",
    "local_1"."CityLocality"."CountryName" AS "Country",
    "local_1"."CityLocality"."ProvinceName" AS "Province",
    "local_1"."CityLocality"."PopulationCount" AS "Population",
    "local_1"."CityLocality"."LongitudeDegrees" AS "Longitude",
    "local_1"."CityLocality"."LatitudeDegrees" AS "Latitude"
FROM "local_1"."CityLocality";

-- Reconstruct continent from local_2.continent_catalog
CREATE VIEW "continent" AS
SELECT
    "local_2"."continent_catalog"."continent_name" AS "Name",
    "local_2"."continent_catalog"."total_area" AS "Area"
FROM "local_2"."continent_catalog";

-- Reconstruct country from local_1.CountryProfile
CREATE VIEW "country" AS
SELECT
    "local_1"."CountryProfile"."CountryName" AS "Name",
    "local_1"."CountryProfile"."CountryCode" AS "Code",
    "local_1"."CountryProfile"."CapitalCityName" AS "Capital",
    "local_1"."CountryProfile"."ProvinceName" AS "Province",
    "local_1"."CountryProfile"."LandArea" AS "Area",
    "local_1"."CountryProfile"."PopulationTotal" AS "Population"
FROM "local_1"."CountryProfile";

-- Reconstruct desert from local_3.aridRegion
CREATE VIEW "desert" AS
SELECT
    "local_3"."aridRegion"."desertName" AS "Name",
    "local_3"."aridRegion"."areaSquareKilometers" AS "Area",
    "local_3"."aridRegion"."longitudeDegrees" AS "Longitude",
    "local_3"."aridRegion"."latitudeDegrees" AS "Latitude"
FROM "local_3"."aridRegion";

-- Reconstruct economy from row partitions (UNION (overlap))
CREATE VIEW "economy" AS
SELECT "local_1"."EconomyAgricultureLowestQuartile"."CountryCode" AS "Country", "local_1"."EconomyAgricultureLowestQuartile"."GrossDomesticProduct" AS "GDP", "local_1"."EconomyAgricultureLowestQuartile"."AgricultureShare" AS "Agriculture", "local_1"."EconomyAgricultureLowestQuartile"."ServiceShare" AS "Service", "local_1"."EconomyAgricultureLowestQuartile"."IndustryShare" AS "Industry", "local_1"."EconomyAgricultureLowestQuartile"."InflationRate" AS "Inflation" FROM "local_1"."EconomyAgricultureLowestQuartile"
UNION
SELECT "local_1"."EconomyAgricultureSecondQuartile"."CountryCode" AS "Country", "local_1"."EconomyAgricultureSecondQuartile"."GrossDomesticProduct" AS "GDP", "local_1"."EconomyAgricultureSecondQuartile"."AgricultureShare" AS "Agriculture", "local_1"."EconomyAgricultureSecondQuartile"."ServiceShare" AS "Service", "local_1"."EconomyAgricultureSecondQuartile"."IndustryShare" AS "Industry", "local_1"."EconomyAgricultureSecondQuartile"."InflationRate" AS "Inflation" FROM "local_1"."EconomyAgricultureSecondQuartile"
UNION
SELECT "local_1"."EconomyAgricultureThirdQuartile"."CountryCode" AS "Country", "local_1"."EconomyAgricultureThirdQuartile"."GrossDomesticProduct" AS "GDP", "local_1"."EconomyAgricultureThirdQuartile"."AgricultureShare" AS "Agriculture", "local_1"."EconomyAgricultureThirdQuartile"."ServiceShare" AS "Service", "local_1"."EconomyAgricultureThirdQuartile"."IndustryShare" AS "Industry", "local_1"."EconomyAgricultureThirdQuartile"."InflationRate" AS "Inflation" FROM "local_1"."EconomyAgricultureThirdQuartile"
UNION
SELECT "local_1"."EconomyAgricultureHighestQuartileOrUnknown"."CountryCode" AS "Country", "local_1"."EconomyAgricultureHighestQuartileOrUnknown"."GrossDomesticProduct" AS "GDP", "local_1"."EconomyAgricultureHighestQuartileOrUnknown"."AgricultureShare" AS "Agriculture", "local_1"."EconomyAgricultureHighestQuartileOrUnknown"."ServiceShare" AS "Service", "local_1"."EconomyAgricultureHighestQuartileOrUnknown"."IndustryShare" AS "Industry", "local_1"."EconomyAgricultureHighestQuartileOrUnknown"."InflationRate" AS "Inflation" FROM "local_1"."EconomyAgricultureHighestQuartileOrUnknown";

-- Reconstruct encompasses from local_3.countryContinentMapping
CREATE VIEW "encompasses" AS
SELECT
    "local_3"."countryContinentMapping"."countryName" AS "Country",
    "local_3"."countryContinentMapping"."continentName" AS "Continent",
    "local_3"."countryContinentMapping"."coveragePercent" AS "Percentage"
FROM "local_3"."countryContinentMapping";

-- Reconstruct ethnicGroup from row partitions (UNION (overlap))
CREATE VIEW "ethnicGroup" AS
SELECT "local_1"."EthnicShareLowestQuartile"."CountryCode" AS "Country", "local_1"."EthnicShareLowestQuartile"."EthnicGroupName" AS "Name", "local_1"."EthnicShareLowestQuartile"."SharePercent" AS "Percentage" FROM "local_1"."EthnicShareLowestQuartile"
UNION
SELECT "local_1"."EthnicShareSecondQuartile"."CountryCode" AS "Country", "local_1"."EthnicShareSecondQuartile"."EthnicGroupName" AS "Name", "local_1"."EthnicShareSecondQuartile"."SharePercent" AS "Percentage" FROM "local_1"."EthnicShareSecondQuartile"
UNION
SELECT "local_1"."EthnicShareThirdQuartile"."CountryCode" AS "Country", "local_1"."EthnicShareThirdQuartile"."EthnicGroupName" AS "Name", "local_1"."EthnicShareThirdQuartile"."SharePercent" AS "Percentage" FROM "local_1"."EthnicShareThirdQuartile"
UNION
SELECT "local_1"."EthnicShareHighestQuartileOrUnknown"."CountryCode" AS "Country", "local_1"."EthnicShareHighestQuartileOrUnknown"."EthnicGroupName" AS "Name", "local_1"."EthnicShareHighestQuartileOrUnknown"."SharePercent" AS "Percentage" FROM "local_1"."EthnicShareHighestQuartileOrUnknown";

-- Reconstruct geo_desert from local_4.desert_zone
CREATE VIEW "geo_desert" AS
SELECT
    "local_4"."desert_zone"."desert_name" AS "Desert",
    "local_4"."desert_zone"."country_label" AS "Country",
    "local_4"."desert_zone"."prov_label" AS "Province"
FROM "local_4"."desert_zone";

-- Reconstruct geo_estuary from local_7.EstuaryJurisdiction
CREATE VIEW "geo_estuary" AS
SELECT
    "local_7"."EstuaryJurisdiction"."RiverName" AS "River",
    "local_7"."EstuaryJurisdiction"."CountryName" AS "Country",
    "local_7"."EstuaryJurisdiction"."ProvinceName" AS "Province"
FROM "local_7"."EstuaryJurisdiction";

-- Reconstruct geo_island from local_5.isl_geo
CREATE VIEW "geo_island" AS
SELECT
    "local_5"."isl_geo"."isl_name" AS "Island",
    "local_5"."isl_geo"."isl_ctry" AS "Country",
    "local_5"."isl_geo"."isl_prv" AS "Province"
FROM "local_5"."isl_geo";

-- Reconstruct geo_lake from local_6.lakeRegistry
CREATE VIEW "geo_lake" AS
SELECT
    "local_6"."lakeRegistry"."lakeName" AS "Lake",
    "local_6"."lakeRegistry"."countryName" AS "Country",
    "local_6"."lakeRegistry"."provinceName" AS "Province"
FROM "local_6"."lakeRegistry";

-- Reconstruct geo_mountain from local_8.MountainLocation
CREATE VIEW "geo_mountain" AS
SELECT
    "local_8"."MountainLocation"."MountainName" AS "Mountain",
    "local_8"."MountainLocation"."CountryName" AS "Country",
    "local_8"."MountainLocation"."ProvinceName" AS "Province"
FROM "local_8"."MountainLocation";

-- Reconstruct geo_river from local_7.RiverJurisdiction
CREATE VIEW "geo_river" AS
SELECT
    "local_7"."RiverJurisdiction"."RiverName" AS "River",
    "local_7"."RiverJurisdiction"."CountryName" AS "Country",
    "local_7"."RiverJurisdiction"."ProvinceName" AS "Province"
FROM "local_7"."RiverJurisdiction";

-- Reconstruct geo_sea from local_8.SeaLocation
CREATE VIEW "geo_sea" AS
SELECT
    "local_8"."SeaLocation"."SeaName" AS "Sea",
    "local_8"."SeaLocation"."CountryName" AS "Country",
    "local_8"."SeaLocation"."ProvinceName" AS "Province"
FROM "local_8"."SeaLocation";

-- Reconstruct geo_source from local_7.SourceJurisdiction
CREATE VIEW "geo_source" AS
SELECT
    "local_7"."SourceJurisdiction"."RiverName" AS "River",
    "local_7"."SourceJurisdiction"."CountryName" AS "Country",
    "local_7"."SourceJurisdiction"."ProvinceName" AS "Province"
FROM "local_7"."SourceJurisdiction";

-- Reconstruct isMember from row partitions (UNION (overlap))
CREATE VIEW "isMember" AS
SELECT "local_1"."OrganizationMembershipDiverse"."CountryCode" AS "Country", "local_1"."OrganizationMembershipDiverse"."OrganizationAbbreviation" AS "Organization", "local_1"."OrganizationMembershipDiverse"."MembershipType" AS "Type" FROM "local_1"."OrganizationMembershipDiverse"
UNION
SELECT "local_2"."country_membership_member"."member_country" AS "Country", "local_2"."country_membership_member"."member_organization" AS "Organization", "local_2"."country_membership_member"."membership_type" AS "Type" FROM "local_2"."country_membership_member";

-- Reconstruct island from row partitions (UNION (overlap))
CREATE VIEW "island" AS
SELECT "local_4"."isl_named_arch"."isl_label" AS "Name", "local_4"."isl_named_arch"."arch_name" AS "Islands", "local_4"."isl_named_arch"."area_km2" AS "Area", "local_4"."isl_named_arch"."max_ht_m" AS "Height", "local_4"."isl_named_arch"."isl_class" AS "Type", "local_4"."isl_named_arch"."lon_deg" AS "Longitude", "local_4"."isl_named_arch"."lat_deg" AS "Latitude" FROM "local_4"."isl_named_arch"
UNION
SELECT "local_4"."isl_other"."isl_label" AS "Name", "local_4"."isl_other"."arch_name" AS "Islands", "local_4"."isl_other"."area_km2" AS "Area", "local_4"."isl_other"."max_ht_m" AS "Height", "local_4"."isl_other"."isl_class" AS "Type", "local_4"."isl_other"."lon_deg" AS "Longitude", "local_4"."isl_other"."lat_deg" AS "Latitude" FROM "local_4"."isl_other"
UNION
SELECT "local_6"."islandArchipelagosSundaPhilippinesAzoresOstfriesische"."islandName" AS "Name", "local_6"."islandArchipelagosSundaPhilippinesAzoresOstfriesische"."archipelagoName" AS "Islands", "local_6"."islandArchipelagosSundaPhilippinesAzoresOstfriesische"."areaSqKm" AS "Area", "local_6"."islandArchipelagosSundaPhilippinesAzoresOstfriesische"."elevationMeters" AS "Height", "local_6"."islandArchipelagosSundaPhilippinesAzoresOstfriesische"."islandClassification" AS "Type", "local_6"."islandArchipelagosSundaPhilippinesAzoresOstfriesische"."longitude" AS "Longitude", "local_6"."islandArchipelagosSundaPhilippinesAzoresOstfriesische"."latitude" AS "Latitude" FROM "local_6"."islandArchipelagosSundaPhilippinesAzoresOstfriesische";

-- Reconstruct islandIn from local_4.isl_in_wtr
CREATE VIEW "islandIn" AS
SELECT
    "local_4"."isl_in_wtr"."isl_label" AS "Island",
    "local_4"."isl_in_wtr"."sea_name" AS "Sea",
    "local_4"."isl_in_wtr"."lake_name" AS "Lake",
    "local_4"."isl_in_wtr"."river_name" AS "River"
FROM "local_4"."isl_in_wtr";

-- Reconstruct lake from row partitions (UNION (overlap))
CREATE VIEW "lake" AS
SELECT "local_1"."LakesNonMajorRiverBucket"."LakeName" AS "Name", "local_1"."LakesNonMajorRiverBucket"."SurfaceArea" AS "Area", "local_1"."LakesNonMajorRiverBucket"."MaxDepth" AS "Depth", "local_1"."LakesNonMajorRiverBucket"."Elevation" AS "Altitude", "local_1"."LakesNonMajorRiverBucket"."LakeType" AS "Type", "local_1"."LakesNonMajorRiverBucket"."FeedingRiver" AS "River", "local_1"."LakesNonMajorRiverBucket"."LongitudeDegrees" AS "Longitude", "local_1"."LakesNonMajorRiverBucket"."LatitudeDegrees" AS "Latitude" FROM "local_1"."LakesNonMajorRiverBucket"
UNION
SELECT "local_5"."lk_named_rivs"."lk_name" AS "Name", "local_5"."lk_named_rivs"."lk_area" AS "Area", "local_5"."lk_named_rivs"."lk_max_depth" AS "Depth", "local_5"."lk_named_rivs"."lk_alt_m" AS "Altitude", "local_5"."lk_named_rivs"."lk_class" AS "Type", "local_5"."lk_named_rivs"."lk_riv" AS "River", "local_5"."lk_named_rivs"."lk_lon" AS "Longitude", "local_5"."lk_named_rivs"."lk_lat" AS "Latitude" FROM "local_5"."lk_named_rivs";

-- Reconstruct language from local_1.CountryLanguage
CREATE VIEW "language" AS
SELECT
    "local_1"."CountryLanguage"."CountryCode" AS "Country",
    "local_1"."CountryLanguage"."LanguageName" AS "Name",
    "local_1"."CountryLanguage"."SharePercent" AS "Percentage"
FROM "local_1"."CountryLanguage";

-- Reconstruct located from local_5.loc_point
CREATE VIEW "located" AS
SELECT
    "local_5"."loc_point"."loc_city" AS "City",
    "local_5"."loc_point"."loc_prv" AS "Province",
    "local_5"."loc_point"."loc_ctry" AS "Country",
    "local_5"."loc_point"."loc_riv" AS "River",
    "local_5"."loc_point"."loc_lk" AS "Lake",
    "local_5"."loc_point"."loc_sea" AS "Sea"
FROM "local_5"."loc_point";

-- Reconstruct locatedOn from local_4.city_on_isl
CREATE VIEW "locatedOn" AS
SELECT
    "local_4"."city_on_isl"."city_label" AS "City",
    "local_4"."city_on_isl"."prov_label" AS "Province",
    "local_4"."city_on_isl"."country_label" AS "Country",
    "local_4"."city_on_isl"."isl_label" AS "Island"
FROM "local_4"."city_on_isl";

-- Reconstruct mergesWith from local_8.SeaConvergence
CREATE VIEW "mergesWith" AS
SELECT
    "local_8"."SeaConvergence"."IncomingSea" AS "Sea1",
    "local_8"."SeaConvergence"."ReceivingSea" AS "Sea2"
FROM "local_8"."SeaConvergence";

-- Reconstruct mountain from local_6.mountainSummits
CREATE VIEW "mountain" AS
SELECT
    "local_6"."mountainSummits"."summitName" AS "Name",
    "local_6"."mountainSummits"."rangeName" AS "Mountains",
    "local_6"."mountainSummits"."elevationMeters" AS "Height",
    "local_6"."mountainSummits"."mountainClassification" AS "Type",
    "local_6"."mountainSummits"."longitude" AS "Longitude",
    "local_6"."mountainSummits"."latitude" AS "Latitude"
FROM "local_6"."mountainSummits";

-- Reconstruct mountainOnIsland from local_6.islandPeakMapping
CREATE VIEW "mountainOnIsland" AS
SELECT
    "local_6"."islandPeakMapping"."summitName" AS "Mountain",
    "local_6"."islandPeakMapping"."islandName" AS "Island"
FROM "local_6"."islandPeakMapping";

-- Reconstruct organization from local_1.OrganizationRegistry
CREATE VIEW "organization" AS
SELECT
    "local_1"."OrganizationRegistry"."OrgAbbreviation" AS "Abbreviation",
    "local_1"."OrganizationRegistry"."OrgFullName" AS "Name",
    "local_1"."OrganizationRegistry"."HeadquartersCity" AS "City",
    "local_1"."OrganizationRegistry"."CountryName" AS "Country",
    "local_1"."OrganizationRegistry"."ProvinceName" AS "Province",
    "local_1"."OrganizationRegistry"."EstablishedDate" AS "Established"
FROM "local_1"."OrganizationRegistry";

-- Reconstruct politics from row partitions (UNION (overlap))
CREATE VIEW "politics" AS
SELECT "local_1"."PoliticalSystemRepublicOnly"."CountryCode" AS "Country", "local_1"."PoliticalSystemRepublicOnly"."IndependenceDate" AS "Independence", "local_1"."PoliticalSystemRepublicOnly"."DependencyStatus" AS "Dependent", "local_1"."PoliticalSystemRepublicOnly"."GovernmentType" AS "Government" FROM "local_1"."PoliticalSystemRepublicOnly"
UNION
SELECT "local_1"."PoliticalSystemParliamentaryBotCommunistEmerging"."CountryCode" AS "Country", "local_1"."PoliticalSystemParliamentaryBotCommunistEmerging"."IndependenceDate" AS "Independence", "local_1"."PoliticalSystemParliamentaryBotCommunistEmerging"."DependencyStatus" AS "Dependent", "local_1"."PoliticalSystemParliamentaryBotCommunistEmerging"."GovernmentType" AS "Government" FROM "local_1"."PoliticalSystemParliamentaryBotCommunistEmerging"
UNION
SELECT "local_1"."PoliticalSystemMonarchyFederalOverseas"."CountryCode" AS "Country", "local_1"."PoliticalSystemMonarchyFederalOverseas"."IndependenceDate" AS "Independence", "local_1"."PoliticalSystemMonarchyFederalOverseas"."DependencyStatus" AS "Dependent", "local_1"."PoliticalSystemMonarchyFederalOverseas"."GovernmentType" AS "Government" FROM "local_1"."PoliticalSystemMonarchyFederalOverseas"
UNION
SELECT "local_1"."PoliticalSystemOtherGovernments"."CountryCode" AS "Country", "local_1"."PoliticalSystemOtherGovernments"."IndependenceDate" AS "Independence", "local_1"."PoliticalSystemOtherGovernments"."DependencyStatus" AS "Dependent", "local_1"."PoliticalSystemOtherGovernments"."GovernmentType" AS "Government" FROM "local_1"."PoliticalSystemOtherGovernments";

-- Reconstruct population from local_1.DemographicsPopulationStats
CREATE VIEW "population" AS
SELECT
    "local_1"."DemographicsPopulationStats"."CountryCode" AS "Country",
    "local_1"."DemographicsPopulationStats"."PopulationGrowthRate" AS "Population_Growth",
    "local_1"."DemographicsPopulationStats"."InfantMortalityRate" AS "Infant_Mortality"
FROM "local_1"."DemographicsPopulationStats";

-- Reconstruct province from vertical (column) split (2 fragments)
CREATE VIEW "province" AS
SELECT
    t0."ProvinceName" AS "Name",
    t0."CountryCode" AS "Country",
    t0."PopulationCount" AS "Population",
    t0."AreaKm2" AS "Area",
    t0."ProvinceCapitalCity" AS "Capital",
    t0."CapitalProvinceFlag" AS "CapProv"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "ProvinceName", "CountryCode" ORDER BY rowid) AS __rn FROM "local_1"."ProvinceAdministrativeArea") t0
JOIN "local_3"."provinceMetrics" t1 ON t0."ProvinceName" IS t1."provinceName" AND t0."CountryCode" IS t1."nationName" AND t0.__rn = t1.__rn;

-- Reconstruct religion from row partitions (UNION (overlap))
CREATE VIEW "religion" AS
SELECT "local_1"."ReligionShareLowestQuartile"."CountryCode" AS "Country", "local_1"."ReligionShareLowestQuartile"."ReligionName" AS "Name", "local_1"."ReligionShareLowestQuartile"."SharePercent" AS "Percentage" FROM "local_1"."ReligionShareLowestQuartile"
UNION
SELECT "local_1"."ReligionShareSecondQuartile"."CountryCode" AS "Country", "local_1"."ReligionShareSecondQuartile"."ReligionName" AS "Name", "local_1"."ReligionShareSecondQuartile"."SharePercent" AS "Percentage" FROM "local_1"."ReligionShareSecondQuartile"
UNION
SELECT "local_1"."ReligionShareThirdQuartile"."CountryCode" AS "Country", "local_1"."ReligionShareThirdQuartile"."ReligionName" AS "Name", "local_1"."ReligionShareThirdQuartile"."SharePercent" AS "Percentage" FROM "local_1"."ReligionShareThirdQuartile"
UNION
SELECT "local_1"."ReligionShareHighestQuartileOrUnknown"."CountryCode" AS "Country", "local_1"."ReligionShareHighestQuartileOrUnknown"."ReligionName" AS "Name", "local_1"."ReligionShareHighestQuartileOrUnknown"."SharePercent" AS "Percentage" FROM "local_1"."ReligionShareHighestQuartileOrUnknown";

-- Reconstruct river from vertical split + row partition on a fragment
CREATE VIEW "river" AS
SELECT t0.[RiverName], t1.[rl_riv], t1.[rl_lk], t1.[rl_sea], t1.[rl_len], t0.[SourceLongitudeDeg], t0.[SourceLatitudeDeg], t2.[MountainRanges], t2.[SourceElevationMeters], t0.[EstuaryLongitudeDeg], t0.[EstuaryLatitudeDeg]
FROM [local_7].[RiverCoordinates] t0
JOIN (
SELECT [riv_lk_named].[__orig_rowid] AS __orig_rowid, [local_5].[riv_lk_named].[rl_name], [local_5].[riv_lk_named].[rl_riv], [local_5].[riv_lk_named].[rl_lk], [local_5].[riv_lk_named].[rl_sea], [local_5].[riv_lk_named].[rl_len] FROM [local_5].[riv_lk_named]
UNION
SELECT [riv_lk_other].[__orig_rowid] AS __orig_rowid, [local_5].[riv_lk_other].[rl_name], [local_5].[riv_lk_other].[rl_riv], [local_5].[riv_lk_other].[rl_lk], [local_5].[riv_lk_other].[rl_sea], [local_5].[riv_lk_other].[rl_len] FROM [local_5].[riv_lk_other]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_7].[RiverProfile] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct sea from local_8.SeaDetails
CREATE VIEW "sea" AS
SELECT
    "local_8"."SeaDetails"."SeaName" AS "Name",
    "local_8"."SeaDetails"."MaximumDepth" AS "Depth"
FROM "local_8"."SeaDetails";

-- Reconstruct target from row partitions (UNION (overlap))
CREATE VIEW "target" AS
SELECT "local_1"."TargetChristianOnly"."CountryCode" AS "Country", "local_1"."TargetChristianOnly"."TargetGroup" AS "Target" FROM "local_1"."TargetChristianOnly"
UNION
SELECT "local_1"."TargetNonChristianOrUnknown"."CountryCode" AS "Country", "local_1"."TargetNonChristianOrUnknown"."TargetGroup" AS "Target" FROM "local_1"."TargetNonChristianOrUnknown";
