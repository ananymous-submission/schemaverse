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