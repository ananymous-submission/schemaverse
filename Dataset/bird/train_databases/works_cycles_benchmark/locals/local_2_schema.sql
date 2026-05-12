CREATE TABLE "CountryRegionCurrencyMap" (
    "RegionCode" TEXT,
    "CurrencyIsoCode" TEXT,
    "LastModifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "EmployeePayHistoryLowestRateQuartile" (
    "EmployeeId" INTEGER,
    "RateEffectiveDate" DATETIME,
    "PayRate" REAL NOT NULL,
    "PayInterval" INTEGER NOT NULL,
    "LastModifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "EmployeePayHistoryHighestRateQuartileOrNull" (
    "EmployeeId" INTEGER,
    "RateEffectiveDate" DATETIME,
    "PayRate" REAL NOT NULL,
    "PayInterval" INTEGER NOT NULL,
    "LastModifiedDate" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "PhoneNumberTypeLookup" (
    "PhoneTypeId" INTEGER,
    "TypeName" TEXT NOT NULL,
    "LastUpdated" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "ShoppingCartItemEntry" (
    "CartItemId" INTEGER,
    "CartId" TEXT NOT NULL,
    "ItemQuantity" INTEGER NOT NULL DEFAULT 1,
    "ProductRefId" INTEGER NOT NULL,
    "CreatedTimestamp" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "LastModifiedTimestamp" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "EmployeeGenderProfile" (
    "EmployeeId" INTEGER,
    "GenderCode" TEXT NOT NULL,
    "JobTitleName" TEXT NOT NULL,
    "MaritalStatusCode" TEXT NOT NULL,
    "OrgLevel" INTEGER,
    "OrgNodePath" TEXT
);

CREATE TABLE "EmployeeCurrentFlagSalariedNonPositive" (
    "EmployeeId" INTEGER,
    "IsCurrent" INTEGER NOT NULL DEFAULT 1,
    "LoginName" TEXT NOT NULL,
    "NationalIdentifier" TEXT NOT NULL,
    "SalariedIndicator" INTEGER NOT NULL DEFAULT 1,
    "RowGuidValue" TEXT NOT NULL,
    FOREIGN KEY ("EmployeeId") REFERENCES "PersonAdditionalContactInfoModifiedDateRange2012Dec12To2013Sep13"("PersonId")
);

CREATE TABLE "EmployeeCurrentFlagSalariedPositiveOrNull" (
    "EmployeeId" INTEGER,
    "IsCurrent" INTEGER NOT NULL DEFAULT 1,
    "LoginName" TEXT NOT NULL,
    "NationalIdentifier" TEXT NOT NULL,
    "SalariedIndicator" INTEGER NOT NULL DEFAULT 1,
    "RowGuidValue" TEXT NOT NULL
);

CREATE TABLE "PersonAdditionalContactInfoModifiedDateRange2012Dec12To2013Sep13" (
    "PersonId" INTEGER,
    "AdditionalContacts" TEXT,
    "DemographicData" TEXT,
    "EmailPromotionFlag" INTEGER NOT NULL DEFAULT 0,
    "ModifiedTimestamp" DATETIME NOT NULL DEFAULT current_timestamp,
    "NameStyleFlag" INTEGER NOT NULL DEFAULT 0,
    "PersonCategory" TEXT NOT NULL,
    "NameSuffix" TEXT,
    "NameTitle" TEXT,
    "RowGuidValue" TEXT NOT NULL
);

CREATE TABLE "PersonAdditionalContactInfoModifiedDateRange2013Sep13To2014Jan30" (
    "PersonId" INTEGER,
    "AdditionalContacts" TEXT,
    "DemographicData" TEXT,
    "EmailPromotionFlag" INTEGER NOT NULL DEFAULT 0,
    "ModifiedTimestamp" DATETIME NOT NULL DEFAULT current_timestamp,
    "NameStyleFlag" INTEGER NOT NULL DEFAULT 0,
    "PersonCategory" TEXT NOT NULL,
    "NameSuffix" TEXT,
    "NameTitle" TEXT,
    "RowGuidValue" TEXT NOT NULL
);