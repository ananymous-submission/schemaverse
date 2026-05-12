CREATE TABLE "OfficeBranch" (
    "BranchIdentifier" TEXT,
    "CityName" TEXT NOT NULL,
    "CountryName" TEXT NOT NULL,
    "ContactPhone" TEXT NOT NULL,
    "PostalZip" TEXT NOT NULL,
    "AdministrativeRegion" TEXT,
    "SalesTerritory" TEXT NOT NULL
);

CREATE TABLE "ProductLineCatalog" (
    "ProductLineKey" TEXT,
    "SummaryDescription" TEXT,
    "RichHtmlDescription" TEXT,
    "ImageData" BLOB
);