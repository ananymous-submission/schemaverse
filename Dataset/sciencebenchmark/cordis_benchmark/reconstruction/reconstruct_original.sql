-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";
ATTACH DATABASE 'local_6.sqlite' AS "local_6";

-- Reconstruct activity_types from local_1.ActivityClassification
CREATE VIEW "activity_types" AS
SELECT
    "local_1"."ActivityClassification"."ActivityCode" AS "code",
    "local_1"."ActivityClassification"."DescriptionText" AS "description"
FROM "local_1"."ActivityClassification";

-- Reconstruct countries from local_1.CountryRegistry
CREATE VIEW "countries" AS
SELECT
    "local_1"."CountryRegistry"."UnicsId" AS "unics_id",
    "local_1"."CountryRegistry"."CountryName" AS "country_name",
    "local_1"."CountryRegistry"."IsoCode2" AS "country_code2",
    "local_1"."CountryRegistry"."IsoCode3" AS "country_code3",
    "local_1"."CountryRegistry"."GeocodeCountryCode" AS "geocode_country_code"
FROM "local_1"."CountryRegistry";

-- Reconstruct ec_framework_programs from local_1.EcFrameworkProgramCatalog
CREATE VIEW "ec_framework_programs" AS
SELECT
    "local_1"."EcFrameworkProgramCatalog"."ProgramName" AS "ec_framework_program_name"
FROM "local_1"."EcFrameworkProgramCatalog";

-- Reconstruct erc_panels from local_2.rev_panels
CREATE VIEW "erc_panels" AS
SELECT
    "local_2"."rev_panels"."pnl_cd" AS "code",
    "local_2"."rev_panels"."pnl_desc" AS "description",
    "local_2"."rev_panels"."dom_cd" AS "part_of"
FROM "local_2"."rev_panels";

-- Reconstruct erc_research_domains from local_2.res_domains
CREATE VIEW "erc_research_domains" AS
SELECT
    "local_2"."res_domains"."dom_cd" AS "code",
    "local_2"."res_domains"."dom_desc" AS "description"
FROM "local_2"."res_domains";

-- Reconstruct eu_territorial_units from row partitions (UNION (overlap))
CREATE VIEW "eu_territorial_units" AS
SELECT "local_1"."EuTerritorialUnitsNuts2021"."RegionGeocode" AS "geocode_regions", "local_1"."EuTerritorialUnitsNuts2021"."DescriptionText" AS "description", "local_1"."EuTerritorialUnitsNuts2021"."GeocodeLevel" AS "geocode_level", "local_1"."EuTerritorialUnitsNuts2021"."NutsVersion" AS "nuts_version" FROM "local_1"."EuTerritorialUnitsNuts2021"
UNION
SELECT "local_1"."EuTerritorialUnitsNuts2016"."RegionGeocode" AS "geocode_regions", "local_1"."EuTerritorialUnitsNuts2016"."DescriptionText" AS "description", "local_1"."EuTerritorialUnitsNuts2016"."GeocodeLevel" AS "geocode_level", "local_1"."EuTerritorialUnitsNuts2016"."NutsVersion" AS "nuts_version" FROM "local_1"."EuTerritorialUnitsNuts2016";

-- Reconstruct funding_schemes from local_1.FundingSchemeCatalog
CREATE VIEW "funding_schemes" AS
SELECT
    "local_1"."FundingSchemeCatalog"."SchemeCode" AS "code",
    "local_1"."FundingSchemeCatalog"."SchemeTitle" AS "title"
FROM "local_1"."FundingSchemeCatalog";

-- Reconstruct institutions from vertical (column) split (3 fragments)
CREATE VIEW "institutions" AS
SELECT
    t0."UnicsId" AS "unics_id",
    t0."CountryUnicsId" AS "country_id",
    t1."InstitutionName" AS "institutions_name",
    t0."TerritorialRegionGeocode" AS "geocode_regions_3",
    t2."DbPediaUrl" AS "db_pedia_url",
    t2."WikidataUrl" AS "wikidata_url",
    t0."GridIdentifier" AS "grid_id",
    t0."AcronymText" AS "acronym",
    t1."ShortDesignation" AS "short_name",
    t2."WebsiteUrl" AS "website",
    t0."DocumentVectors" AS "document_vectors"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "UnicsId" ORDER BY rowid) AS __rn FROM "local_1"."InstitutionAcronymExtended") t0
JOIN "local_1"."InstitutionAcronymRegistry" t1 ON t0."UnicsId" IS t1."UnicsId" AND t0.__rn = t1.__rn
JOIN "local_1"."InstitutionExternalLinks" t2 ON t0."UnicsId" IS t2."UnicsId" AND t0.__rn = t2.__rn;

-- Reconstruct people from local_1.PersonRegistry
CREATE VIEW "people" AS
SELECT
    "local_1"."PersonRegistry"."UnicsId" AS "unics_id",
    "local_1"."PersonRegistry"."FullName" AS "full_name"
FROM "local_1"."PersonRegistry";

-- Reconstruct programmes from local_3.academic_programs
CREATE VIEW "programmes" AS
SELECT
    "local_3"."academic_programs"."program_code" AS "code",
    "local_3"."academic_programs"."registry_number" AS "rcn",
    "local_3"."academic_programs"."full_title" AS "title",
    "local_3"."academic_programs"."short_label" AS "short_name",
    "local_3"."academic_programs"."parent_program_code" AS "parent"
FROM "local_3"."academic_programs";

-- Reconstruct project_erc_panels from local_3.research_project_review_panels
CREATE VIEW "project_erc_panels" AS
SELECT
    "local_3"."research_project_review_panels"."research_project_id" AS "project",
    "local_3"."research_project_review_panels"."erc_panel_label" AS "panel"
FROM "local_3"."research_project_review_panels";

-- Reconstruct project_member_roles from local_4.memberRoleCatalog
CREATE VIEW "project_member_roles" AS
SELECT
    "local_4"."memberRoleCatalog"."roleCode" AS "code",
    "local_4"."memberRoleCatalog"."roleDescription" AS "description"
FROM "local_4"."memberRoleCatalog";

-- Reconstruct project_members from vertical split + row partition on a fragment
CREATE VIEW "project_members" AS
SELECT t0.[unicsId], t2.[projectId], t3.[picNumber], t2.[rcnIdentifier], t1.[MemberFullName], t0.[activityType], t0.[countryName], t0.[streetAddress], t0.[cityName], t0.[postalCode], t1.[EcContributionAmount], t3.[institutionId], t2.[memberRoleCode], t0.[geocodeRegionLevel3], t1.[MemberShortName], t1.[DepartmentName], t3.[vatRegistrationNumber], t0.[latitudeValue], t0.[longitudeValue], t0.[regionCode], t0.[regionName]
FROM (
SELECT [memberActivityMajorEuropeanCities].[__orig_rowid] AS __orig_rowid, [local_4].[memberActivityMajorEuropeanCities].[unicsId], [local_4].[memberActivityMajorEuropeanCities].[activityType], [local_4].[memberActivityMajorEuropeanCities].[countryName], [local_4].[memberActivityMajorEuropeanCities].[streetAddress], [local_4].[memberActivityMajorEuropeanCities].[cityName], [local_4].[memberActivityMajorEuropeanCities].[postalCode], [local_4].[memberActivityMajorEuropeanCities].[geocodeRegionLevel3], [local_4].[memberActivityMajorEuropeanCities].[latitudeValue], [local_4].[memberActivityMajorEuropeanCities].[longitudeValue], [local_4].[memberActivityMajorEuropeanCities].[regionCode], [local_4].[memberActivityMajorEuropeanCities].[regionName] FROM [local_4].[memberActivityMajorEuropeanCities]
UNION
SELECT [memberActivityOtherCities].[__orig_rowid] AS __orig_rowid, [local_4].[memberActivityOtherCities].[unicsId], [local_4].[memberActivityOtherCities].[activityType], [local_4].[memberActivityOtherCities].[countryName], [local_4].[memberActivityOtherCities].[streetAddress], [local_4].[memberActivityOtherCities].[cityName], [local_4].[memberActivityOtherCities].[postalCode], [local_4].[memberActivityOtherCities].[geocodeRegionLevel3], [local_4].[memberActivityOtherCities].[latitudeValue], [local_4].[memberActivityOtherCities].[longitudeValue], [local_4].[memberActivityOtherCities].[regionCode], [local_4].[memberActivityOtherCities].[regionName] FROM [local_4].[memberActivityOtherCities]
) t0
JOIN [local_1].[ProjectMemberActivityProfile] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_4].[memberEcContributionRecords] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_4].[memberInstitutionIdentifiers] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct project_programmes from local_4.projectProgramAssignments
CREATE VIEW "project_programmes" AS
SELECT
    "local_4"."projectProgramAssignments"."projectId" AS "project",
    "local_4"."projectProgramAssignments"."programmeCode" AS "programme"
FROM "local_4"."projectProgramAssignments";

-- Reconstruct project_subject_areas from local_5.proj_sub_area_map
CREATE VIEW "project_subject_areas" AS
SELECT
    "local_5"."proj_sub_area_map"."proj_unics_id" AS "project",
    "local_5"."proj_sub_area_map"."subj_code" AS "subject_area"
FROM "local_5"."proj_sub_area_map";

-- Reconstruct project_topics from local_6.projectTopicAssignments
CREATE VIEW "project_topics" AS
SELECT
    "local_6"."projectTopicAssignments"."projectId" AS "project",
    "local_6"."projectTopicAssignments"."topicCode" AS "topic"
FROM "local_6"."projectTopicAssignments";

-- Reconstruct projects from vertical split + row partition on a fragment
CREATE VIEW "projects" AS
SELECT t0.[UnicsId], t0.[ProjectAcronym], t0.[ProjectTitle], t0.[EcCall], t1.[ec_fund_sch], t0.[CordisReference], t0.[EcReference], t2.[StartDate], t2.[EndDate], t2.[StartYear], t2.[EndYear], t0.[HomepageUrl], t0.[TotalCost], t1.[ec_max_contrib_amt], t0.[FrameworkProgramName], t0.[ObjectiveSummary], t0.[PrincipalInvestigatorId]
FROM [local_1].[ProjectAcronymRegistry] t0
JOIN [local_5].[proj_cordis_meta] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [ProjectEndDatesHighQuartile].[__orig_rowid] AS __orig_rowid, [local_1].[ProjectEndDatesHighQuartile].[UnicsId], [local_1].[ProjectEndDatesHighQuartile].[StartDate], [local_1].[ProjectEndDatesHighQuartile].[EndDate], [local_1].[ProjectEndDatesHighQuartile].[StartYear], [local_1].[ProjectEndDatesHighQuartile].[EndYear] FROM [local_1].[ProjectEndDatesHighQuartile]
UNION
SELECT [projectsEndingAfter2015Sep30Through2018Oct31].[__orig_rowid] AS __orig_rowid, [local_6].[projectsEndingAfter2015Sep30Through2018Oct31].[projectId], [local_6].[projectsEndingAfter2015Sep30Through2018Oct31].[startDate], [local_6].[projectsEndingAfter2015Sep30Through2018Oct31].[endDate], [local_6].[projectsEndingAfter2015Sep30Through2018Oct31].[startYear], [local_6].[projectsEndingAfter2015Sep30Through2018Oct31].[endYear] FROM [local_6].[projectsEndingAfter2015Sep30Through2018Oct31]
UNION
SELECT [projectsEndingAfter2018Oct31Through2022Jun30].[__orig_rowid] AS __orig_rowid, [local_6].[projectsEndingAfter2018Oct31Through2022Jun30].[projectId], [local_6].[projectsEndingAfter2018Oct31Through2022Jun30].[startDate], [local_6].[projectsEndingAfter2018Oct31Through2022Jun30].[endDate], [local_6].[projectsEndingAfter2018Oct31Through2022Jun30].[startYear], [local_6].[projectsEndingAfter2018Oct31Through2022Jun30].[endYear] FROM [local_6].[projectsEndingAfter2018Oct31Through2022Jun30]
UNION
SELECT [projectsThrough2015Sep30].[__orig_rowid] AS __orig_rowid, [local_6].[projectsThrough2015Sep30].[projectId], [local_6].[projectsThrough2015Sep30].[startDate], [local_6].[projectsThrough2015Sep30].[endDate], [local_6].[projectsThrough2015Sep30].[startYear], [local_6].[projectsThrough2015Sep30].[endYear] FROM [local_6].[projectsThrough2015Sep30]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct subject_areas from local_5.subj_area_ref
CREATE VIEW "subject_areas" AS
SELECT
    "local_5"."subj_area_ref"."subj_code" AS "code",
    "local_5"."subj_area_ref"."area_title" AS "title",
    "local_5"."subj_area_ref"."area_desc" AS "description"
FROM "local_5"."subj_area_ref";

-- Reconstruct topics from local_6.researchTopics
CREATE VIEW "topics" AS
SELECT
    "local_6"."researchTopics"."topicCode" AS "code",
    "local_6"."researchTopics"."rcnNumber" AS "rcn",
    "local_6"."researchTopics"."topicTitle" AS "title"
FROM "local_6"."researchTopics";
