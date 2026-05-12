CREATE TABLE "ActivityHistory" (
    "EventTimestamp" varchar(255),
    "SessionToken" varchar(255),
    "ActionType" varchar(255),
    "SelectedOption" varchar(255),
    "ResourcePath" varchar(255),
    "SearchCategory" varchar(255)
);

CREATE TABLE "ProductCatalogArchive" (
    "ProductIdentifier" varchar(255),
    "ProductName" varchar(255),
    "UnitPrice" INTEGER,
    "LastModifiedAt" varchar(255)
);

CREATE TABLE "ContentReadHistory" (
    "EventTimestamp" varchar(255),
    "SessionToken" varchar(255),
    "ActionType" varchar(255),
    "ResourceUrl" varchar(255)
);