CREATE TABLE "FacilityOrganizationDlcMapping" (
    "FacilityOrganizationKey" TEXT DEFAULT NULL,
    "DlcKey" TEXT DEFAULT NULL
);

CREATE TABLE "RoomsHistoryAccessLevelSelectedBuildings" (
    "SpaceId" TEXT DEFAULT NULL,
    "Area" REAL DEFAULT NULL,
    "AccessLevel" TEXT DEFAULT NULL,
    "BuildingRoom" TEXT DEFAULT NULL,
    "DepartmentCode" TEXT DEFAULT NULL,
    "FacilityBuildingKey" TEXT DEFAULT NULL,
    "FacilityFloorKey" TEXT DEFAULT NULL,
    "FacilityRoomKey" TEXT DEFAULT NULL,
    "FiscalPeriod" TEXT DEFAULT NULL,
    "FloorLabel" TEXT DEFAULT NULL,
    "RoomIdentifier" TEXT DEFAULT NULL,
    "RoomFullName" TEXT DEFAULT NULL,
    "WarehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "RoomsHistoryAccessLevelOtherBuildings" (
    "SpaceId" TEXT DEFAULT NULL,
    "Area" REAL DEFAULT NULL,
    "AccessLevel" TEXT DEFAULT NULL,
    "BuildingRoom" TEXT DEFAULT NULL,
    "DepartmentCode" TEXT DEFAULT NULL,
    "FacilityBuildingKey" TEXT DEFAULT NULL,
    "FacilityFloorKey" TEXT DEFAULT NULL,
    "FacilityRoomKey" TEXT DEFAULT NULL,
    "FiscalPeriod" TEXT DEFAULT NULL,
    "FloorLabel" TEXT DEFAULT NULL,
    "RoomIdentifier" TEXT DEFAULT NULL,
    "RoomFullName" TEXT DEFAULT NULL,
    "WarehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "RoomsHistorySpatialCoordinates" (
    "SpaceId" TEXT DEFAULT NULL,
    "Area" REAL DEFAULT NULL,
    "EastingSpc" REAL DEFAULT NULL,
    "LatitudeWgs84" REAL DEFAULT NULL,
    "LongitudeWgs84" REAL DEFAULT NULL,
    "NorthingSpc" REAL DEFAULT NULL
);

CREATE TABLE "RoomsHistoryAccessLevelArchive" (
    "SpaceId" TEXT DEFAULT NULL,
    "Area" REAL DEFAULT NULL,
    "AccessLevel" TEXT DEFAULT NULL,
    "BuildingRoom" TEXT DEFAULT NULL,
    "DepartmentCode" TEXT DEFAULT NULL,
    "FacilityBuildingKey" TEXT DEFAULT NULL,
    "FacilityFloorKey" TEXT DEFAULT NULL,
    "FacilityRoomHistoryKey" TEXT DEFAULT NULL,
    "FacilityRoomKey" TEXT DEFAULT NULL,
    "FacilityUseKey" TEXT DEFAULT NULL,
    "FiscalPeriod" TEXT DEFAULT NULL,
    "FloorLabel" TEXT DEFAULT NULL,
    "RoomFullName" TEXT DEFAULT NULL,
    "WarehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "RoomsHistoryMajorUseClassification" (
    "SpaceId" TEXT DEFAULT NULL,
    "Area" REAL DEFAULT NULL,
    "FacilityMajorUseKey" TEXT DEFAULT NULL,
    "FacilityMinorUseKey" TEXT DEFAULT NULL,
    "FacilityUseKey" TEXT DEFAULT NULL,
    "MajorUseDescription" TEXT DEFAULT NULL,
    "MinorUseDescription" TEXT DEFAULT NULL,
    "UseDescription" TEXT DEFAULT NULL
);

CREATE TABLE "RoomsHistoryMinorOrganizationMapping" (
    "SpaceId" TEXT DEFAULT NULL,
    "Area" REAL DEFAULT NULL,
    "FacilityMinorOrganizationKey" TEXT DEFAULT NULL,
    "FacilityOrganizationKey" TEXT DEFAULT NULL,
    "MinorOrganizationCode" TEXT DEFAULT NULL,
    "OrganizationName" TEXT DEFAULT NULL
);

CREATE TABLE "StudentDegreeProgramCatalog" (
    "DegreeCode" TEXT DEFAULT NULL,
    "DegreeDescription" TEXT DEFAULT NULL,
    "DegreeShortDescription" TEXT DEFAULT NULL,
    "DegreeTypeCode" TEXT DEFAULT NULL,
    "DegreeTypeDescription" TEXT DEFAULT NULL,
    "DegreeWeight" INTEGER DEFAULT NULL,
    "EffectiveFromTerm" TEXT DEFAULT NULL,
    "EffectiveThruTerm" TEXT DEFAULT NULL,
    "DepartmentCode" TEXT DEFAULT NULL,
    "DepartmentNameInCommencementBook" TEXT DEFAULT NULL,
    "SchoolNameInCommencementBook" TEXT DEFAULT NULL,
    "CourseCode" TEXT DEFAULT NULL,
    "CourseLevel" TEXT DEFAULT NULL,
    "IsDoubleMajorFlag" TEXT DEFAULT NULL,
    "CommencementBookCourseRoman" TEXT DEFAULT NULL,
    "CommencementBookSeeAlso" TEXT DEFAULT NULL,
    "DegreeLastActivityDate" TEXT DEFAULT NULL,
    "CourseLastActivityDate" TEXT DEFAULT NULL,
    "WarehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "DepartmentHierarchyDlcKeyPrimary" (
    "DlcCode" TEXT DEFAULT NULL,
    "DlcKey" TEXT DEFAULT NULL,
    "DlcName" TEXT DEFAULT NULL,
    "HierarchyType" TEXT DEFAULT NULL,
    "HierarchyLevelOneCode" TEXT DEFAULT NULL,
    "HierarchyLevelTwoCode" TEXT DEFAULT NULL,
    "HierarchyLevelThreeCode" TEXT DEFAULT NULL,
    "HierarchyLevelFourCode" TEXT DEFAULT NULL,
    "HierarchyLevelFourName" TEXT DEFAULT NULL,
    "HierarchyLevelFiveCode" TEXT DEFAULT NULL
);

CREATE TABLE "DepartmentHierarchyDlcVpResearch" (
    "DlcCode" TEXT DEFAULT NULL,
    "DlcKey" TEXT DEFAULT NULL,
    "DlcName" TEXT DEFAULT NULL,
    "HierarchyType" TEXT DEFAULT NULL,
    "HierarchyLevelOneCode" TEXT DEFAULT NULL,
    "HierarchyLevelOneName" TEXT DEFAULT NULL,
    "HierarchyLevelTwoCode" TEXT DEFAULT NULL,
    "HierarchyLevelTwoName" TEXT DEFAULT NULL,
    "HierarchyLevelThreeName" TEXT DEFAULT NULL,
    "HierarchyLevelFourName" TEXT DEFAULT NULL,
    "HierarchyLevelFiveName" TEXT DEFAULT NULL
);

CREATE TABLE "DepartmentHierarchyDlcStudentLifeProvostSchwarzman" (
    "DlcCode" TEXT DEFAULT NULL,
    "DlcKey" TEXT DEFAULT NULL,
    "DlcName" TEXT DEFAULT NULL,
    "HierarchyType" TEXT DEFAULT NULL,
    "HierarchyLevelOneCode" TEXT DEFAULT NULL,
    "HierarchyLevelOneName" TEXT DEFAULT NULL,
    "HierarchyLevelTwoCode" TEXT DEFAULT NULL,
    "HierarchyLevelTwoName" TEXT DEFAULT NULL,
    "HierarchyLevelThreeName" TEXT DEFAULT NULL,
    "HierarchyLevelFourName" TEXT DEFAULT NULL,
    "HierarchyLevelFiveName" TEXT DEFAULT NULL
);

CREATE TABLE "DepartmentHierarchyDlcUndergradAndFinance" (
    "DlcCode" TEXT DEFAULT NULL,
    "DlcKey" TEXT DEFAULT NULL,
    "DlcName" TEXT DEFAULT NULL,
    "HierarchyType" TEXT DEFAULT NULL,
    "HierarchyLevelOneCode" TEXT DEFAULT NULL,
    "HierarchyLevelOneName" TEXT DEFAULT NULL,
    "HierarchyLevelTwoCode" TEXT DEFAULT NULL,
    "HierarchyLevelTwoName" TEXT DEFAULT NULL,
    "HierarchyLevelThreeName" TEXT DEFAULT NULL,
    "HierarchyLevelFourName" TEXT DEFAULT NULL,
    "HierarchyLevelFiveName" TEXT DEFAULT NULL
);

CREATE TABLE "DepartmentHierarchyDlcScienceAndHumanities" (
    "DlcCode" TEXT DEFAULT NULL,
    "DlcKey" TEXT DEFAULT NULL,
    "DlcName" TEXT DEFAULT NULL,
    "HierarchyType" TEXT DEFAULT NULL,
    "HierarchyLevelOneCode" TEXT DEFAULT NULL,
    "HierarchyLevelOneName" TEXT DEFAULT NULL,
    "HierarchyLevelTwoCode" TEXT DEFAULT NULL,
    "HierarchyLevelTwoName" TEXT DEFAULT NULL,
    "HierarchyLevelThreeName" TEXT DEFAULT NULL,
    "HierarchyLevelFourName" TEXT DEFAULT NULL,
    "HierarchyLevelFiveName" TEXT DEFAULT NULL
);

CREATE TABLE "MajorOrganizationKeyOvcAndSEng" (
    "OrganizationId" TEXT DEFAULT NULL,
    "MajorOrganizationKey" TEXT DEFAULT NULL,
    "OrganizationKey" TEXT DEFAULT NULL,
    "ParentOrganizationCode" TEXT DEFAULT NULL,
    "ParentOrganizationKey" TEXT DEFAULT NULL
);

CREATE TABLE "MajorOrganizationKeyExecVpPresAndDsl" (
    "OrganizationId" TEXT DEFAULT NULL,
    "MajorOrganizationKey" TEXT DEFAULT NULL,
    "OrganizationKey" TEXT DEFAULT NULL,
    "ParentOrganizationCode" TEXT DEFAULT NULL,
    "ParentOrganizationKey" TEXT DEFAULT NULL
);

CREATE TABLE "MajorOrganizationKeyVpResAndHss" (
    "OrganizationId" TEXT DEFAULT NULL,
    "MajorOrganizationKey" TEXT DEFAULT NULL,
    "OrganizationKey" TEXT DEFAULT NULL,
    "ParentOrganizationCode" TEXT DEFAULT NULL,
    "ParentOrganizationKey" TEXT DEFAULT NULL
);

CREATE TABLE "MajorOrganizationKeyProvostAndScience" (
    "OrganizationId" TEXT DEFAULT NULL,
    "MajorOrganizationKey" TEXT DEFAULT NULL,
    "OrganizationKey" TEXT DEFAULT NULL,
    "ParentOrganizationCode" TEXT DEFAULT NULL,
    "ParentOrganizationKey" TEXT DEFAULT NULL
);

CREATE TABLE "MajorOrganizationKeyOther" (
    "OrganizationId" TEXT DEFAULT NULL,
    "MajorOrganizationKey" TEXT DEFAULT NULL,
    "OrganizationKey" TEXT DEFAULT NULL,
    "ParentOrganizationCode" TEXT DEFAULT NULL,
    "ParentOrganizationKey" TEXT DEFAULT NULL
);

CREATE TABLE "OrganizationAssignableAlternate" (
    "OrganizationId" TEXT DEFAULT NULL,
    "AssignableFlag" TEXT DEFAULT NULL,
    "OrganizationLevel" TEXT DEFAULT NULL,
    "OrganizationSortOrder" TEXT DEFAULT NULL,
    "WarehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "OrganizationCourseMapping" (
    "OrganizationId" TEXT DEFAULT NULL,
    "CourseCode" TEXT DEFAULT NULL,
    "DepartmentCode" TEXT DEFAULT NULL,
    "HrDepartmentCodeLegacy" TEXT DEFAULT NULL,
    "HrOrgUnitId" TEXT DEFAULT NULL,
    "OrganizationNumber" TEXT DEFAULT NULL
);

CREATE TABLE "FloorAccessLevelFloorOne" (
    "FacilityFloorKey" TEXT DEFAULT NULL,
    "AccessLevel" TEXT DEFAULT NULL,
    "BuildingWingId" TEXT DEFAULT NULL,
    "FacilityBuildingKey" TEXT DEFAULT NULL,
    "FloorLabel" TEXT DEFAULT NULL,
    "FloorSortSequence" TEXT DEFAULT NULL,
    "LevelId" TEXT DEFAULT NULL,
    "WarehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "FloorAccessLevelFloorTwo" (
    "FacilityFloorKey" TEXT DEFAULT NULL,
    "AccessLevel" TEXT DEFAULT NULL,
    "BuildingWingId" TEXT DEFAULT NULL,
    "FacilityBuildingKey" TEXT DEFAULT NULL,
    "FloorLabel" TEXT DEFAULT NULL,
    "FloorSortSequence" TEXT DEFAULT NULL,
    "LevelId" TEXT DEFAULT NULL,
    "WarehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "FloorAccessLevelFloorThree" (
    "FacilityFloorKey" TEXT DEFAULT NULL,
    "AccessLevel" TEXT DEFAULT NULL,
    "BuildingWingId" TEXT DEFAULT NULL,
    "FacilityBuildingKey" TEXT DEFAULT NULL,
    "FloorLabel" TEXT DEFAULT NULL,
    "FloorSortSequence" TEXT DEFAULT NULL,
    "LevelId" TEXT DEFAULT NULL,
    "WarehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "FloorAccessLevelFloorZero" (
    "FacilityFloorKey" TEXT DEFAULT NULL,
    "AccessLevel" TEXT DEFAULT NULL,
    "BuildingWingId" TEXT DEFAULT NULL,
    "FacilityBuildingKey" TEXT DEFAULT NULL,
    "FloorLabel" TEXT DEFAULT NULL,
    "FloorSortSequence" TEXT DEFAULT NULL,
    "LevelId" TEXT DEFAULT NULL,
    "WarehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "FloorAccessLevelFloorFourAndOther" (
    "FacilityFloorKey" TEXT DEFAULT NULL,
    "AccessLevel" TEXT DEFAULT NULL,
    "BuildingWingId" TEXT DEFAULT NULL,
    "FacilityBuildingKey" TEXT DEFAULT NULL,
    "FloorLabel" TEXT DEFAULT NULL,
    "FloorSortSequence" TEXT DEFAULT NULL,
    "LevelId" TEXT DEFAULT NULL,
    "WarehouseLoadDate" TEXT DEFAULT NULL
);