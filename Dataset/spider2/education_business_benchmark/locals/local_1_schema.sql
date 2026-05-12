CREATE TABLE "SalaryDataForDataScientist" (
    "RowIndexNumber" INTEGER,
    "EmployerName" TEXT,
    "RoleTitle" TEXT,
    "ReportedSalaryCount" REAL,
    "LocationName" TEXT,
    "SalaryExpression" TEXT
);

CREATE TABLE "SalaryDataForDataAnalyst" (
    "RowIndexNumber" INTEGER,
    "EmployerName" TEXT,
    "RoleTitle" TEXT,
    "ReportedSalaryCount" REAL,
    "LocationName" TEXT,
    "SalaryExpression" TEXT
);

CREATE TABLE "SalaryDataForDataEngineer" (
    "RowIndexNumber" INTEGER,
    "EmployerName" TEXT,
    "RoleTitle" TEXT,
    "ReportedSalaryCount" REAL,
    "LocationName" TEXT,
    "SalaryExpression" TEXT
);

CREATE TABLE "SalaryDataForMlAndOtherRoles" (
    "RowIndexNumber" INTEGER,
    "EmployerName" TEXT,
    "RoleTitle" TEXT,
    "ReportedSalaryCount" REAL,
    "LocationName" TEXT,
    "SalaryExpression" TEXT
);

CREATE TABLE "WebAccountDirectory" (
    "AccountId" INTEGER,
    "AccountName" TEXT,
    "WebsiteUrl" TEXT,
    "Latitude" REAL,
    "Longitude" REAL,
    "PrimaryPointOfContact" TEXT,
    "SalesRepresentativeId" INTEGER
);

CREATE TABLE "WebEventChannelDirect" (
    "EventId" INTEGER,
    "AccountId" INTEGER,
    "EventTimestamp" TEXT,
    "ChannelName" TEXT
);

CREATE TABLE "WebEventChannelFacebook" (
    "EventId" INTEGER,
    "AccountId" INTEGER,
    "EventTimestamp" TEXT,
    "ChannelName" TEXT
);

CREATE TABLE "WebEventChannelOrganic" (
    "EventId" INTEGER,
    "AccountId" INTEGER,
    "EventTimestamp" TEXT,
    "ChannelName" TEXT
);

CREATE TABLE "WebEventChannelAdsAndSocial" (
    "EventId" INTEGER,
    "AccountId" INTEGER,
    "EventTimestamp" TEXT,
    "ChannelName" TEXT
);

CREATE TABLE "WebOrdersByAccountGlossUpTo74Point9" (
    "OrderId" INTEGER,
    "AccountId" INTEGER,
    "GlossAmountUsd" REAL,
    "GlossQuantity" INTEGER,
    "OrderTimestamp" TEXT,
    "PosterAmountUsd" REAL,
    "PosterQuantity" INTEGER,
    "StandardAmountUsd" REAL,
    "StandardQuantity" INTEGER,
    "TotalAmountUsd" REAL
);

CREATE TABLE "WebOrdersByAccountGlossGreaterThan74Point9To232Point19" (
    "OrderId" INTEGER,
    "AccountId" INTEGER,
    "GlossAmountUsd" REAL,
    "GlossQuantity" INTEGER,
    "OrderTimestamp" TEXT,
    "PosterAmountUsd" REAL,
    "PosterQuantity" INTEGER,
    "StandardAmountUsd" REAL,
    "StandardQuantity" INTEGER,
    "TotalAmountUsd" REAL
);

CREATE TABLE "WebOrdersByAccountGlossGreaterThan232Point19To749Point0" (
    "OrderId" INTEGER,
    "AccountId" INTEGER,
    "GlossAmountUsd" REAL,
    "GlossQuantity" INTEGER,
    "OrderTimestamp" TEXT,
    "PosterAmountUsd" REAL,
    "PosterQuantity" INTEGER,
    "StandardAmountUsd" REAL,
    "StandardQuantity" INTEGER,
    "TotalAmountUsd" REAL
);

CREATE TABLE "WebOrdersByAccountGlossGreaterThan749OrNull" (
    "OrderId" INTEGER,
    "AccountId" INTEGER,
    "GlossAmountUsd" REAL,
    "GlossQuantity" INTEGER,
    "OrderTimestamp" TEXT,
    "PosterAmountUsd" REAL,
    "PosterQuantity" INTEGER,
    "StandardAmountUsd" REAL,
    "StandardQuantity" INTEGER,
    "TotalAmountUsd" REAL
);

CREATE TABLE "WebOrderAccountTotalsSummary" (
    "OrderId" INTEGER,
    "AccountId" INTEGER,
    "GlossAmountUsd" REAL,
    "OrderTimestamp" TEXT,
    "ItemTotalCount" INTEGER,
    "TotalAmountUsd" REAL
);

CREATE TABLE "WebRegionList" (
    "RegionId" INTEGER,
    "RegionName" TEXT
);

CREATE TABLE "WebSalesRepresentativeDirectory" (
    "SalesRepresentativeId" INTEGER,
    "RepresentativeName" TEXT,
    "RegionId" INTEGER
);