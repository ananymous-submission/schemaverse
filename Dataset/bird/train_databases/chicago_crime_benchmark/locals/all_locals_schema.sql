-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/chicago_crime/chicago_crime.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "CrimeArrestRecord" (
    "ReportId" INTEGER,
    "ArrestOccurred" TEXT,
    "BeatNumber" INTEGER,
    "BlockIdentifier" TEXT,
    "CaseNumber" TEXT,
    "ReportDate" TEXT,
    "DomesticFlag" TEXT,
    "IucrCode" TEXT,
    FOREIGN KEY ("IucrCode") REFERENCES "IucrNarcotics"("IucrCode"),
    FOREIGN KEY ("IucrCode") REFERENCES "IucrDeceptiveAssaultProstitution"("IucrCode"),
    FOREIGN KEY ("IucrCode") REFERENCES "IucrBatteryGambling"("IucrCode"),
    FOREIGN KEY ("IucrCode") REFERENCES "IucrOtherCatchAll"("IucrCode")
);

CREATE TABLE "CrimeBeatLowerQuartile" (
    "ReportId" INTEGER,
    "BeatNumber" INTEGER,
    "BlockIdentifier" TEXT,
    "CaseNumber" TEXT,
    "CommunityAreaId" INTEGER,
    "ReportDate" TEXT,
    "DistrictNumber" INTEGER,
    "FbiCode" TEXT,
    "IucrCode" TEXT,
    "LocationDescription" TEXT,
    "WardNumber" INTEGER,
    FOREIGN KEY ("FbiCode") REFERENCES "FbiCrimeCode"("FbiCode"),
    FOREIGN KEY ("CommunityAreaId") REFERENCES "CommunityAreaSouth"("CommunityAreaId"),
    FOREIGN KEY ("CommunityAreaId") REFERENCES "CommunityAreaSouthwest"("CommunityAreaId"),
    FOREIGN KEY ("IucrCode") REFERENCES "IucrOtherCatchAll"("IucrCode"),
    FOREIGN KEY ("WardNumber") REFERENCES "WardOfficeFaxListed"("WardNumber")
);

CREATE TABLE "CrimeGeoCoordinate" (
    "ReportId" INTEGER,
    "Latitude" TEXT,
    "LocationDescription" TEXT,
    "Longitude" TEXT
);

CREATE TABLE "FbiCrimeCode" (
    "FbiCode" TEXT,
    "Title" TEXT,
    "Description" TEXT,
    "CrimeAgainst" TEXT
);

CREATE TABLE "IucrNarcotics" (
    "IucrCode" TEXT,
    "PrimaryDescription" TEXT,
    "SecondaryDescription" TEXT,
    "IndexCode" TEXT
);

CREATE TABLE "IucrOtherChildrenWeapons" (
    "IucrCode" TEXT,
    "PrimaryDescription" TEXT,
    "SecondaryDescription" TEXT,
    "IndexCode" TEXT
);

CREATE TABLE "IucrDeceptiveAssaultProstitution" (
    "IucrCode" TEXT,
    "PrimaryDescription" TEXT,
    "SecondaryDescription" TEXT,
    "IndexCode" TEXT
);

CREATE TABLE "IucrBatteryGambling" (
    "IucrCode" TEXT,
    "PrimaryDescription" TEXT,
    "SecondaryDescription" TEXT,
    "IndexCode" TEXT
);

CREATE TABLE "IucrOtherCatchAll" (
    "IucrCode" TEXT,
    "PrimaryDescription" TEXT,
    "SecondaryDescription" TEXT,
    "IndexCode" TEXT
);

CREATE TABLE "CommunityAreaFarSoutheast" (
    "CommunityAreaId" INTEGER,
    "AreaName" TEXT,
    "GeographicSide" TEXT,
    "PopulationCount" TEXT
);

CREATE TABLE "CommunityAreaSouth" (
    "CommunityAreaId" INTEGER,
    "AreaName" TEXT,
    "GeographicSide" TEXT,
    "PopulationCount" TEXT
);

CREATE TABLE "CommunityAreaSouthwest" (
    "CommunityAreaId" INTEGER,
    "AreaName" TEXT,
    "GeographicSide" TEXT,
    "PopulationCount" TEXT
);

CREATE TABLE "CommunityAreaWest" (
    "CommunityAreaId" INTEGER,
    "AreaName" TEXT,
    "GeographicSide" TEXT,
    "PopulationCount" TEXT
);

CREATE TABLE "CommunityAreaFarSouthwestAndNorthwest" (
    "CommunityAreaId" INTEGER,
    "AreaName" TEXT,
    "GeographicSide" TEXT,
    "PopulationCount" TEXT
);

CREATE TABLE "PoliceDistrictOffice" (
    "DistrictNumber" INTEGER,
    "Address" TEXT,
    "CommanderName" TEXT,
    "DistrictName" TEXT,
    "EmailAddress" TEXT,
    "TwitterHandle" TEXT,
    "ZipCode" INTEGER
);

CREATE TABLE "WardPopulationDetails" (
    "WardNumber" INTEGER,
    "PopulationCount" INTEGER,
    "AldermanFirstName" TEXT,
    "AldermanLastName" TEXT,
    "AldermanNameSuffix" TEXT,
    "WardEmail" TEXT,
    "WardOfficeZip" TEXT
);

CREATE TABLE "WardOfficeFaxListed" (
    "WardNumber" INTEGER,
    "CityHallFax" TEXT,
    "CityHallPhone" TEXT,
    "CityHallRoom" INTEGER,
    "WardOfficeFax" TEXT
);

CREATE TABLE "WardOfficeFaxOther" (
    "WardNumber" INTEGER,
    "CityHallFax" TEXT,
    "CityHallPhone" TEXT,
    "CityHallRoom" INTEGER,
    "WardOfficeFax" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "community_area_far_north" (
    "community_area_id" INTEGER,
    "area_label" TEXT,
    "region_side" TEXT,
    "population_count" TEXT
);

CREATE TABLE "community_area_north_or_central" (
    "community_area_id" INTEGER,
    "area_label" TEXT,
    "region_side" TEXT,
    "population_count" TEXT
);

CREATE TABLE "neighborhood_zone" (
    "neighborhood_label" TEXT,
    "community_area_id" INTEGER
);

CREATE TABLE "crime_incidents_beats_gt_611_to_1031" (
    "incident_report_id" INTEGER,
    "police_beat_number" INTEGER,
    "street_block" TEXT,
    "case_reference" TEXT,
    "community_area_id" INTEGER,
    "incident_date" TEXT,
    "police_district_number" INTEGER,
    "fbi_offense_code" TEXT,
    "iucr_code" TEXT,
    "location_text" TEXT,
    "ward_number" INTEGER,
    FOREIGN KEY ("community_area_id") REFERENCES "community_area_far_north"("community_area_id")
);

CREATE TABLE "crime_incidents_beats_gt_1031_to_1723" (
    "incident_report_id" INTEGER,
    "police_beat_number" INTEGER,
    "street_block" TEXT,
    "case_reference" TEXT,
    "community_area_id" INTEGER,
    "incident_date" TEXT,
    "police_district_number" INTEGER,
    "fbi_offense_code" TEXT,
    "iucr_code" TEXT,
    "location_text" TEXT,
    "ward_number" INTEGER
);

CREATE TABLE "crime_incidents_beats_above_1723_or_null" (
    "incident_report_id" INTEGER,
    "police_beat_number" INTEGER,
    "street_block" TEXT,
    "case_reference" TEXT,
    "community_area_id" INTEGER,
    "incident_date" TEXT,
    "police_district_number" INTEGER,
    "fbi_offense_code" TEXT,
    "iucr_code" TEXT,
    "location_text" TEXT,
    "ward_number" INTEGER
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "districtDirectory" (
    "districtId" INTEGER,
    "districtFullName" TEXT,
    "contactEmail" TEXT,
    "contactFax" TEXT,
    "contactPhone" TEXT,
    "ttyNumber" TEXT,
    "twitterHandle" TEXT,
    "postalCode" INTEGER
);

CREATE TABLE "wardProfile" (
    "wardId" INTEGER,
    "populationCount" INTEGER,
    "aldermanNameSuffix" TEXT,
    "contactEmail" TEXT,
    "officeAddress" TEXT,
    "officeFax" TEXT,
    "officePhone" TEXT,
    "officePostalCode" TEXT
);

