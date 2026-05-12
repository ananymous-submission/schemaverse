CREATE TABLE "ProductCategories" (
    "CategoryIdentifier" INTEGER NOT NULL,
    "CategoryLabel" TEXT NOT NULL,
    "DescriptionText" TEXT,
    "ImageData" BLOB
);

CREATE TABLE "EasternStates" (
    "StateIdentifier" INTEGER NOT NULL,
    "StateName" TEXT,
    "StateAbbreviation" TEXT,
    "RegionName" TEXT
);

CREATE TABLE "MidwestStates" (
    "StateIdentifier" INTEGER NOT NULL,
    "StateName" TEXT,
    "StateAbbreviation" TEXT,
    "RegionName" TEXT
);

CREATE TABLE "WesternStates" (
    "StateIdentifier" INTEGER NOT NULL,
    "StateName" TEXT,
    "StateAbbreviation" TEXT,
    "RegionName" TEXT
);

CREATE TABLE "SouthernAndNorthernStates" (
    "StateIdentifier" INTEGER NOT NULL,
    "StateName" TEXT,
    "StateAbbreviation" TEXT,
    "RegionName" TEXT
);