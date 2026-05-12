-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/northwind/northwind.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "customerDemographicsLink" (
    "customerReferenceId" TEXT NOT NULL,
    "demographicTypeId" TEXT NOT NULL
);

CREATE TABLE "shippingProviders" (
    "carrierId" INTEGER NOT NULL,
    "businessName" TEXT NOT NULL,
    "contactPhone" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "emp_terrs_emp_lte3" (
    "emp_id" INTEGER NOT NULL,
    "terr_code" TEXT NOT NULL
);

CREATE TABLE "emp_terrs_emp_gt3_lte6" (
    "emp_id" INTEGER NOT NULL,
    "terr_code" TEXT NOT NULL
);

CREATE TABLE "emp_terrs_emp_gt6_lte7" (
    "emp_id" INTEGER NOT NULL,
    "terr_code" TEXT NOT NULL
);

CREATE TABLE "emp_terrs_emp_gt7_or_null" (
    "emp_id" INTEGER NOT NULL,
    "terr_code" TEXT NOT NULL
);

CREATE TABLE "suppl_addr_view" (
    "postal_cd" TEXT,
    "addr" TEXT,
    "cty" TEXT,
    "comp_name" TEXT NOT NULL,
    "cont_name" TEXT,
    "cntry" TEXT,
    "web_url" TEXT,
    "regn" TEXT,
    "sup_id" INTEGER NOT NULL
);

CREATE TABLE "suppl_profile_comp" (
    "postal_cd" TEXT,
    "comp_name" TEXT NOT NULL,
    "cont_name" TEXT,
    "cont_title" TEXT,
    "fax_num" TEXT,
    "web_url" TEXT,
    "phone_num" TEXT,
    "regn" TEXT,
    "sup_id" INTEGER NOT NULL
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "order_items_orderid_le_10450" (
    "order_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "unit_price" REAL NOT NULL,
    "quantity_ordered" INTEGER NOT NULL,
    "discount_rate" REAL NOT NULL
);

CREATE TABLE "order_items_orderid_gt_10450_to_10657" (
    "order_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "unit_price" REAL NOT NULL,
    "quantity_ordered" INTEGER NOT NULL,
    "discount_rate" REAL NOT NULL
);

CREATE TABLE "order_items_orderid_gt_10657_to_10862" (
    "order_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "unit_price" REAL NOT NULL,
    "quantity_ordered" INTEGER NOT NULL,
    "discount_rate" REAL NOT NULL
);

CREATE TABLE "order_items_orderid_gt_10862_or_null" (
    "order_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "unit_price" REAL NOT NULL,
    "quantity_ordered" INTEGER NOT NULL,
    "discount_rate" REAL NOT NULL
);

CREATE TABLE "territories_region_le_1" (
    "territory_id" TEXT NOT NULL,
    "territory_description" TEXT NOT NULL,
    "region_id" INTEGER NOT NULL
);

CREATE TABLE "territories_region_gt_1_to_2" (
    "territory_id" TEXT NOT NULL,
    "territory_description" TEXT NOT NULL,
    "region_id" INTEGER NOT NULL
);

CREATE TABLE "territories_region_gt_2_to_3" (
    "territory_id" TEXT NOT NULL,
    "territory_description" TEXT NOT NULL,
    "region_id" INTEGER NOT NULL
);

CREATE TABLE "territories_region_gt_3_or_null" (
    "territory_id" TEXT NOT NULL,
    "territory_description" TEXT NOT NULL,
    "region_id" INTEGER NOT NULL
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

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

