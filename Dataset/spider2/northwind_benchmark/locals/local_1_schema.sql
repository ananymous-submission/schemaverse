CREATE TABLE "CustomerDemographicTypes" (
    "CustomerTypeCode" TEXT NOT NULL,
    "Description" TEXT
);

CREATE TABLE "CustomerGroupThresholds" (
    "GroupKey" TEXT NOT NULL,
    "RangeMin" DECIMAL NOT NULL,
    "RangeMax" DECIMAL NOT NULL
);

CREATE TABLE "CityCustomersOwnerTitle" (
    "StreetAddress" TEXT,
    "CityName" TEXT,
    "CompanyName" TEXT NOT NULL,
    "ContactName" TEXT,
    "JobTitle" TEXT,
    "CountryName" TEXT,
    "PhoneNumber" TEXT,
    "RegionName" TEXT
);

CREATE TABLE "CityCustomersSalesRepresentativeTitle" (
    "StreetAddress" TEXT,
    "CityName" TEXT,
    "CompanyName" TEXT NOT NULL,
    "ContactName" TEXT,
    "JobTitle" TEXT,
    "CountryName" TEXT,
    "PhoneNumber" TEXT,
    "RegionName" TEXT
);

CREATE TABLE "CityCustomersMarketingManagerTitle" (
    "StreetAddress" TEXT,
    "CityName" TEXT,
    "CompanyName" TEXT NOT NULL,
    "ContactName" TEXT,
    "JobTitle" TEXT,
    "CountryName" TEXT,
    "PhoneNumber" TEXT,
    "RegionName" TEXT
);

CREATE TABLE "CityCustomersSalesManagerTitle" (
    "StreetAddress" TEXT,
    "CityName" TEXT,
    "CompanyName" TEXT NOT NULL,
    "ContactName" TEXT,
    "JobTitle" TEXT,
    "CountryName" TEXT,
    "PhoneNumber" TEXT,
    "RegionName" TEXT
);

CREATE TABLE "CityCustomersAccountingManagerTitle" (
    "StreetAddress" TEXT,
    "CityName" TEXT,
    "CompanyName" TEXT NOT NULL,
    "ContactName" TEXT,
    "JobTitle" TEXT,
    "CountryName" TEXT,
    "PhoneNumber" TEXT,
    "RegionName" TEXT
);

CREATE TABLE "CityCustomersSalesCatchAll" (
    "StreetAddress" TEXT,
    "CityName" TEXT,
    "CompanyName" TEXT NOT NULL,
    "ContactName" TEXT,
    "JobTitle" TEXT,
    "CountryName" TEXT,
    "PhoneNumber" TEXT,
    "RegionName" TEXT
);

CREATE TABLE "CityCustomersMarketingAssistantOrSalesAgent" (
    "StreetAddress" TEXT,
    "CityName" TEXT,
    "CompanyName" TEXT NOT NULL,
    "ContactName" TEXT,
    "JobTitle" TEXT,
    "CountryName" TEXT,
    "PhoneNumber" TEXT,
    "RegionName" TEXT
);

CREATE TABLE "CityCustomerCompact" (
    "StreetAddress" TEXT,
    "CityName" TEXT,
    "CompanyName" TEXT NOT NULL,
    "CustomerCode" TEXT NOT NULL,
    "FaxNumber" TEXT,
    "PhoneNumber" TEXT,
    "PostalCode" TEXT,
    "RegionName" TEXT
);

CREATE TABLE "EmployeeAddresses" (
    "PostalCode" TEXT,
    "StreetAddress" TEXT,
    "CityName" TEXT,
    "CountryName" TEXT,
    "EmployeeIdentifier" INTEGER NOT NULL,
    "PhoneExtension" TEXT,
    "FirstName" TEXT NOT NULL,
    "HomePhone" TEXT,
    "LastName" TEXT NOT NULL,
    "RegionName" TEXT,
    "ReportsToId" INTEGER
);

CREATE TABLE "EmployeeBirthAndHire" (
    "PostalCode" TEXT,
    "BirthDate" DATE,
    "HireDate" DATE,
    "Notes" TEXT
);

CREATE TABLE "EmployeeAddressesWithPhoto" (
    "PostalCode" TEXT,
    "StreetAddress" TEXT,
    "CityName" TEXT,
    "CountryName" TEXT,
    "EmployeeIdentifier" INTEGER NOT NULL,
    "PhoneExtension" TEXT,
    "PhotoData" BLOB,
    "PhotoPath" TEXT,
    "RegionName" TEXT,
    "ReportsToId" INTEGER,
    "JobTitle" TEXT,
    "CourtesyTitle" TEXT
);

CREATE TABLE "OrdersForNamedCustomerSet" (
    "OrderNumber" INTEGER NOT NULL,
    "CustomerCode" TEXT,
    "EmployeeIdentifier" INTEGER,
    "FreightCharge" REAL,
    "ShippingCity" TEXT,
    "ShippingPostalCode" TEXT,
    "ShippingRegion" TEXT,
    "ShipViaCarrierId" INTEGER
);

CREATE TABLE "OrdersForOtherCustomers" (
    "OrderNumber" INTEGER NOT NULL,
    "CustomerCode" TEXT,
    "EmployeeIdentifier" INTEGER,
    "FreightCharge" REAL,
    "ShippingCity" TEXT,
    "ShippingPostalCode" TEXT,
    "ShippingRegion" TEXT,
    "ShipViaCarrierId" INTEGER
);

CREATE TABLE "OrderDates" (
    "OrderNumber" INTEGER NOT NULL,
    "OrderDate" DATE,
    "RequiredDate" DATE,
    "ShippedDate" DATE
);

CREATE TABLE "OrdersShippingInfo" (
    "OrderNumber" INTEGER NOT NULL,
    "CustomerCode" TEXT,
    "EmployeeIdentifier" INTEGER,
    "FreightCharge" REAL,
    "ShippingAddress" TEXT,
    "ShippingCity" TEXT,
    "ShippingCountry" TEXT,
    "ShippingName" TEXT,
    "ShippingPostalCode" TEXT,
    "ShippingRegion" TEXT
);

CREATE TABLE "ProductsSupplierLowestQuartile" (
    "ProductIdentifier" INTEGER NOT NULL,
    "CategoryIdentifier" INTEGER,
    "IsDiscontinued" INTEGER NOT NULL,
    "ProductName" TEXT NOT NULL,
    "QuantityPerUnit" TEXT,
    "SupplierIdentifier" INTEGER,
    "UnitPrice" REAL
);

CREATE TABLE "ProductsSupplierSecondQuartile" (
    "ProductIdentifier" INTEGER NOT NULL,
    "CategoryIdentifier" INTEGER,
    "IsDiscontinued" INTEGER NOT NULL,
    "ProductName" TEXT NOT NULL,
    "QuantityPerUnit" TEXT,
    "SupplierIdentifier" INTEGER,
    "UnitPrice" REAL
);

CREATE TABLE "ProductsSupplierThirdQuartile" (
    "ProductIdentifier" INTEGER NOT NULL,
    "CategoryIdentifier" INTEGER,
    "IsDiscontinued" INTEGER NOT NULL,
    "ProductName" TEXT NOT NULL,
    "QuantityPerUnit" TEXT,
    "SupplierIdentifier" INTEGER,
    "UnitPrice" REAL
);

CREATE TABLE "ProductsSupplierHighestQuartile" (
    "ProductIdentifier" INTEGER NOT NULL,
    "CategoryIdentifier" INTEGER,
    "IsDiscontinued" INTEGER NOT NULL,
    "ProductName" TEXT NOT NULL,
    "QuantityPerUnit" TEXT,
    "SupplierIdentifier" INTEGER,
    "UnitPrice" REAL
);

CREATE TABLE "ProductInventoryStatus" (
    "ProductIdentifier" INTEGER NOT NULL,
    "IsDiscontinued" INTEGER NOT NULL,
    "ProductName" TEXT NOT NULL,
    "QuantityPerUnit" TEXT,
    "ReorderLevel" INTEGER,
    "UnitPrice" REAL,
    "UnitsInStock" INTEGER,
    "UnitsOnOrder" INTEGER
);

CREATE TABLE "Regions" (
    "RegionIdentifier" INTEGER NOT NULL,
    "RegionDescription" TEXT NOT NULL
);