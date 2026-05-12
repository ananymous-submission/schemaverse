CREATE TABLE "LibraryReserveMaterialStatusOtherLoadDates" (
    "CourseInstructorKey" TEXT DEFAULT NULL,
    "ReserveCatalogKey" TEXT DEFAULT NULL,
    "MaterialStatusKey" TEXT DEFAULT NULL,
    "TermCode" TEXT DEFAULT NULL,
    "WarehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "LibraryReserveMaterialSubjectOffered" (
    "CourseInstructorKey" TEXT DEFAULT NULL,
    "ReserveCatalogKey" TEXT DEFAULT NULL,
    "SubjectOfferedKey" TEXT DEFAULT NULL,
    "SubjectIdentifier" TEXT DEFAULT NULL,
    "TermCode" TEXT DEFAULT NULL,
    "WarehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "SubjectAttributeEffective1995May09" (
    "AttributeCode" TEXT DEFAULT NULL,
    "AttributeType" TEXT DEFAULT NULL,
    "ShortDescription" TEXT DEFAULT NULL,
    "Description" TEXT DEFAULT NULL,
    "ReportDescription" TEXT DEFAULT NULL,
    "LastActivityDate" TEXT DEFAULT NULL,
    "WarehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "SubjectAttributeHistoricActivityDates" (
    "AttributeCode" TEXT DEFAULT NULL,
    "AttributeType" TEXT DEFAULT NULL,
    "ShortDescription" TEXT DEFAULT NULL,
    "Description" TEXT DEFAULT NULL,
    "ReportDescription" TEXT DEFAULT NULL,
    "LastActivityDate" TEXT DEFAULT NULL,
    "WarehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "SubjectAttributeActivity2017Sep05And2010Dec20" (
    "AttributeCode" TEXT DEFAULT NULL,
    "AttributeType" TEXT DEFAULT NULL,
    "ShortDescription" TEXT DEFAULT NULL,
    "Description" TEXT DEFAULT NULL,
    "ReportDescription" TEXT DEFAULT NULL,
    "LastActivityDate" TEXT DEFAULT NULL,
    "WarehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "SubjectAttributeActivity2001Oct25And2017Nov03" (
    "AttributeCode" TEXT DEFAULT NULL,
    "AttributeType" TEXT DEFAULT NULL,
    "ShortDescription" TEXT DEFAULT NULL,
    "Description" TEXT DEFAULT NULL,
    "ReportDescription" TEXT DEFAULT NULL,
    "LastActivityDate" TEXT DEFAULT NULL,
    "WarehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "SubjectAttributeOtherActivityDates" (
    "AttributeCode" TEXT DEFAULT NULL,
    "AttributeType" TEXT DEFAULT NULL,
    "ShortDescription" TEXT DEFAULT NULL,
    "Description" TEXT DEFAULT NULL,
    "ReportDescription" TEXT DEFAULT NULL,
    "LastActivityDate" TEXT DEFAULT NULL,
    "WarehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "PostalCodeMajorCanadianCities" (
    "PostalCode" TEXT DEFAULT NULL,
    "CityName" TEXT DEFAULT NULL,
    "CityType" TEXT DEFAULT NULL,
    "ProvinceAbbreviation" TEXT DEFAULT NULL,
    "ProvinceName" TEXT DEFAULT NULL,
    "WarehouseLoadDate" TEXT DEFAULT NULL
);

CREATE TABLE "PostalCodeOtherCanadianCities" (
    "PostalCode" TEXT DEFAULT NULL,
    "CityName" TEXT DEFAULT NULL,
    "CityType" TEXT DEFAULT NULL,
    "ProvinceAbbreviation" TEXT DEFAULT NULL,
    "ProvinceName" TEXT DEFAULT NULL,
    "WarehouseLoadDate" TEXT DEFAULT NULL
);