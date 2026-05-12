-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct Community_Area from row partitions (UNION (overlap))
CREATE VIEW "Community_Area" AS
SELECT "local_1"."CommunityAreaFarSoutheast"."CommunityAreaId" AS "community_area_no", "local_1"."CommunityAreaFarSoutheast"."AreaName" AS "community_area_name", "local_1"."CommunityAreaFarSoutheast"."GeographicSide" AS "side", "local_1"."CommunityAreaFarSoutheast"."PopulationCount" AS "population" FROM "local_1"."CommunityAreaFarSoutheast"
UNION
SELECT "local_1"."CommunityAreaSouth"."CommunityAreaId" AS "community_area_no", "local_1"."CommunityAreaSouth"."AreaName" AS "community_area_name", "local_1"."CommunityAreaSouth"."GeographicSide" AS "side", "local_1"."CommunityAreaSouth"."PopulationCount" AS "population" FROM "local_1"."CommunityAreaSouth"
UNION
SELECT "local_1"."CommunityAreaSouthwest"."CommunityAreaId" AS "community_area_no", "local_1"."CommunityAreaSouthwest"."AreaName" AS "community_area_name", "local_1"."CommunityAreaSouthwest"."GeographicSide" AS "side", "local_1"."CommunityAreaSouthwest"."PopulationCount" AS "population" FROM "local_1"."CommunityAreaSouthwest"
UNION
SELECT "local_1"."CommunityAreaWest"."CommunityAreaId" AS "community_area_no", "local_1"."CommunityAreaWest"."AreaName" AS "community_area_name", "local_1"."CommunityAreaWest"."GeographicSide" AS "side", "local_1"."CommunityAreaWest"."PopulationCount" AS "population" FROM "local_1"."CommunityAreaWest"
UNION
SELECT "local_1"."CommunityAreaFarSouthwestAndNorthwest"."CommunityAreaId" AS "community_area_no", "local_1"."CommunityAreaFarSouthwestAndNorthwest"."AreaName" AS "community_area_name", "local_1"."CommunityAreaFarSouthwestAndNorthwest"."GeographicSide" AS "side", "local_1"."CommunityAreaFarSouthwestAndNorthwest"."PopulationCount" AS "population" FROM "local_1"."CommunityAreaFarSouthwestAndNorthwest"
UNION
SELECT "local_2"."community_area_far_north"."community_area_id" AS "community_area_no", "local_2"."community_area_far_north"."area_label" AS "community_area_name", "local_2"."community_area_far_north"."region_side" AS "side", "local_2"."community_area_far_north"."population_count" AS "population" FROM "local_2"."community_area_far_north"
UNION
SELECT "local_2"."community_area_north_or_central"."community_area_id" AS "community_area_no", "local_2"."community_area_north_or_central"."area_label" AS "community_area_name", "local_2"."community_area_north_or_central"."region_side" AS "side", "local_2"."community_area_north_or_central"."population_count" AS "population" FROM "local_2"."community_area_north_or_central";

-- Reconstruct Crime from vertical split + row partition on a fragment
CREATE VIEW "Crime" AS
SELECT t0.[ReportId], t0.[CaseNumber], t0.[ReportDate], t0.[BlockIdentifier], t0.[IucrCode], t1.[LocationDescription], t0.[ArrestOccurred], t0.[DomesticFlag], t0.[BeatNumber], t1.[DistrictNumber], t1.[WardNumber], t1.[CommunityAreaId], t1.[FbiCode], t2.[Latitude], t2.[Longitude]
FROM [local_1].[CrimeArrestRecord] t0
JOIN (
SELECT [CrimeBeatLowerQuartile].[__orig_rowid] AS __orig_rowid, [local_1].[CrimeBeatLowerQuartile].[ReportId], [local_1].[CrimeBeatLowerQuartile].[CaseNumber], [local_1].[CrimeBeatLowerQuartile].[ReportDate], [local_1].[CrimeBeatLowerQuartile].[BlockIdentifier], [local_1].[CrimeBeatLowerQuartile].[IucrCode], [local_1].[CrimeBeatLowerQuartile].[LocationDescription], [local_1].[CrimeBeatLowerQuartile].[BeatNumber], [local_1].[CrimeBeatLowerQuartile].[DistrictNumber], [local_1].[CrimeBeatLowerQuartile].[WardNumber], [local_1].[CrimeBeatLowerQuartile].[CommunityAreaId], [local_1].[CrimeBeatLowerQuartile].[FbiCode] FROM [local_1].[CrimeBeatLowerQuartile]
UNION
SELECT [crime_incidents_beats_above_1723_or_null].[__orig_rowid] AS __orig_rowid, [local_2].[crime_incidents_beats_above_1723_or_null].[incident_report_id], [local_2].[crime_incidents_beats_above_1723_or_null].[case_reference], [local_2].[crime_incidents_beats_above_1723_or_null].[incident_date], [local_2].[crime_incidents_beats_above_1723_or_null].[street_block], [local_2].[crime_incidents_beats_above_1723_or_null].[iucr_code], [local_2].[crime_incidents_beats_above_1723_or_null].[location_text], [local_2].[crime_incidents_beats_above_1723_or_null].[police_beat_number], [local_2].[crime_incidents_beats_above_1723_or_null].[police_district_number], [local_2].[crime_incidents_beats_above_1723_or_null].[ward_number], [local_2].[crime_incidents_beats_above_1723_or_null].[community_area_id], [local_2].[crime_incidents_beats_above_1723_or_null].[fbi_offense_code] FROM [local_2].[crime_incidents_beats_above_1723_or_null]
UNION
SELECT [crime_incidents_beats_gt_1031_to_1723].[__orig_rowid] AS __orig_rowid, [local_2].[crime_incidents_beats_gt_1031_to_1723].[incident_report_id], [local_2].[crime_incidents_beats_gt_1031_to_1723].[case_reference], [local_2].[crime_incidents_beats_gt_1031_to_1723].[incident_date], [local_2].[crime_incidents_beats_gt_1031_to_1723].[street_block], [local_2].[crime_incidents_beats_gt_1031_to_1723].[iucr_code], [local_2].[crime_incidents_beats_gt_1031_to_1723].[location_text], [local_2].[crime_incidents_beats_gt_1031_to_1723].[police_beat_number], [local_2].[crime_incidents_beats_gt_1031_to_1723].[police_district_number], [local_2].[crime_incidents_beats_gt_1031_to_1723].[ward_number], [local_2].[crime_incidents_beats_gt_1031_to_1723].[community_area_id], [local_2].[crime_incidents_beats_gt_1031_to_1723].[fbi_offense_code] FROM [local_2].[crime_incidents_beats_gt_1031_to_1723]
UNION
SELECT [crime_incidents_beats_gt_611_to_1031].[__orig_rowid] AS __orig_rowid, [local_2].[crime_incidents_beats_gt_611_to_1031].[incident_report_id], [local_2].[crime_incidents_beats_gt_611_to_1031].[case_reference], [local_2].[crime_incidents_beats_gt_611_to_1031].[incident_date], [local_2].[crime_incidents_beats_gt_611_to_1031].[street_block], [local_2].[crime_incidents_beats_gt_611_to_1031].[iucr_code], [local_2].[crime_incidents_beats_gt_611_to_1031].[location_text], [local_2].[crime_incidents_beats_gt_611_to_1031].[police_beat_number], [local_2].[crime_incidents_beats_gt_611_to_1031].[police_district_number], [local_2].[crime_incidents_beats_gt_611_to_1031].[ward_number], [local_2].[crime_incidents_beats_gt_611_to_1031].[community_area_id], [local_2].[crime_incidents_beats_gt_611_to_1031].[fbi_offense_code] FROM [local_2].[crime_incidents_beats_gt_611_to_1031]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[CrimeGeoCoordinate] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct District from vertical (column) split (2 fragments)
CREATE VIEW "District" AS
SELECT
    t0."DistrictNumber" AS "district_no",
    t0."DistrictName" AS "district_name",
    t0."Address" AS "address",
    t0."ZipCode" AS "zip_code",
    t0."CommanderName" AS "commander",
    t0."EmailAddress" AS "email",
    t1."contactPhone" AS "phone",
    t1."contactFax" AS "fax",
    t1."ttyNumber" AS "tty",
    t0."TwitterHandle" AS "twitter"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "DistrictNumber" ORDER BY rowid) AS __rn FROM "local_1"."PoliceDistrictOffice") t0
JOIN "local_3"."districtDirectory" t1 ON t0."DistrictNumber" IS t1."districtId" AND t0.__rn = t1.__rn;

-- Reconstruct FBI_Code from local_1.FbiCrimeCode
CREATE VIEW "FBI_Code" AS
SELECT
    "local_1"."FbiCrimeCode"."FbiCode" AS "fbi_code_no",
    "local_1"."FbiCrimeCode"."Title" AS "title",
    "local_1"."FbiCrimeCode"."Description" AS "description",
    "local_1"."FbiCrimeCode"."CrimeAgainst" AS "crime_against"
FROM "local_1"."FbiCrimeCode";

-- Reconstruct IUCR from row partitions (UNION (overlap))
CREATE VIEW "IUCR" AS
SELECT "local_1"."IucrNarcotics"."IucrCode" AS "iucr_no", "local_1"."IucrNarcotics"."PrimaryDescription" AS "primary_description", "local_1"."IucrNarcotics"."SecondaryDescription" AS "secondary_description", "local_1"."IucrNarcotics"."IndexCode" AS "index_code" FROM "local_1"."IucrNarcotics"
UNION
SELECT "local_1"."IucrOtherChildrenWeapons"."IucrCode" AS "iucr_no", "local_1"."IucrOtherChildrenWeapons"."PrimaryDescription" AS "primary_description", "local_1"."IucrOtherChildrenWeapons"."SecondaryDescription" AS "secondary_description", "local_1"."IucrOtherChildrenWeapons"."IndexCode" AS "index_code" FROM "local_1"."IucrOtherChildrenWeapons"
UNION
SELECT "local_1"."IucrDeceptiveAssaultProstitution"."IucrCode" AS "iucr_no", "local_1"."IucrDeceptiveAssaultProstitution"."PrimaryDescription" AS "primary_description", "local_1"."IucrDeceptiveAssaultProstitution"."SecondaryDescription" AS "secondary_description", "local_1"."IucrDeceptiveAssaultProstitution"."IndexCode" AS "index_code" FROM "local_1"."IucrDeceptiveAssaultProstitution"
UNION
SELECT "local_1"."IucrBatteryGambling"."IucrCode" AS "iucr_no", "local_1"."IucrBatteryGambling"."PrimaryDescription" AS "primary_description", "local_1"."IucrBatteryGambling"."SecondaryDescription" AS "secondary_description", "local_1"."IucrBatteryGambling"."IndexCode" AS "index_code" FROM "local_1"."IucrBatteryGambling"
UNION
SELECT "local_1"."IucrOtherCatchAll"."IucrCode" AS "iucr_no", "local_1"."IucrOtherCatchAll"."PrimaryDescription" AS "primary_description", "local_1"."IucrOtherCatchAll"."SecondaryDescription" AS "secondary_description", "local_1"."IucrOtherCatchAll"."IndexCode" AS "index_code" FROM "local_1"."IucrOtherCatchAll";

-- Reconstruct Neighborhood from local_2.neighborhood_zone
CREATE VIEW "Neighborhood" AS
SELECT
    "local_2"."neighborhood_zone"."neighborhood_label" AS "neighborhood_name",
    "local_2"."neighborhood_zone"."community_area_id" AS "community_area_no"
FROM "local_2"."neighborhood_zone";

-- Reconstruct Ward from vertical split + row partition on a fragment
CREATE VIEW "Ward" AS
SELECT t0.[WardNumber], t2.[AldermanFirstName], t2.[AldermanLastName], t1.[aldermanNameSuffix], t1.[officeAddress], t1.[officePostalCode], t1.[contactEmail], t1.[officePhone], t0.[WardOfficeFax], t0.[CityHallRoom], t0.[CityHallPhone], t0.[CityHallFax], t1.[populationCount]
FROM (
SELECT [WardOfficeFaxListed].[__orig_rowid] AS __orig_rowid, [local_1].[WardOfficeFaxListed].[WardNumber], [local_1].[WardOfficeFaxListed].[WardOfficeFax], [local_1].[WardOfficeFaxListed].[CityHallRoom], [local_1].[WardOfficeFaxListed].[CityHallPhone], [local_1].[WardOfficeFaxListed].[CityHallFax] FROM [local_1].[WardOfficeFaxListed]
UNION
SELECT [WardOfficeFaxOther].[__orig_rowid] AS __orig_rowid, [local_1].[WardOfficeFaxOther].[WardNumber], [local_1].[WardOfficeFaxOther].[WardOfficeFax], [local_1].[WardOfficeFaxOther].[CityHallRoom], [local_1].[WardOfficeFaxOther].[CityHallPhone], [local_1].[WardOfficeFaxOther].[CityHallFax] FROM [local_1].[WardOfficeFaxOther]
) t0
JOIN [local_3].[wardProfile] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[WardPopulationDetails] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];
