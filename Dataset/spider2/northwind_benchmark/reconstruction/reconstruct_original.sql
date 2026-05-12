-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";

-- Reconstruct categories from local_5.ProductCategories
CREATE VIEW "categories" AS
SELECT
    "local_5"."ProductCategories"."CategoryIdentifier" AS "categoryid",
    "local_5"."ProductCategories"."CategoryLabel" AS "categoryname",
    "local_5"."ProductCategories"."DescriptionText" AS "description",
    "local_5"."ProductCategories"."ImageData" AS "picture"
FROM "local_5"."ProductCategories";

-- Reconstruct customercustomerdemo from local_2.customerDemographicsLink
CREATE VIEW "customercustomerdemo" AS
SELECT
    "local_2"."customerDemographicsLink"."customerReferenceId" AS "customerid",
    "local_2"."customerDemographicsLink"."demographicTypeId" AS "customertypeid"
FROM "local_2"."customerDemographicsLink";

-- Reconstruct customerdemographics from local_1.CustomerDemographicTypes
CREATE VIEW "customerdemographics" AS
SELECT
    "local_1"."CustomerDemographicTypes"."CustomerTypeCode" AS "customertypeid",
    "local_1"."CustomerDemographicTypes"."Description" AS "customerdesc"
FROM "local_1"."CustomerDemographicTypes";

-- Reconstruct customergroupthreshold from local_1.CustomerGroupThresholds
CREATE VIEW "customergroupthreshold" AS
SELECT
    "local_1"."CustomerGroupThresholds"."GroupKey" AS "groupname",
    "local_1"."CustomerGroupThresholds"."RangeMin" AS "rangebottom",
    "local_1"."CustomerGroupThresholds"."RangeMax" AS "rangetop"
FROM "local_1"."CustomerGroupThresholds";

-- Reconstruct customers from vertical split + row partition on a fragment
CREATE VIEW "customers" AS
SELECT t1.[CustomerCode], t0.[CompanyName], t0.[ContactName], t0.[JobTitle], t0.[StreetAddress], t0.[CityName], t0.[RegionName], t1.[PostalCode], t0.[CountryName], t0.[PhoneNumber], t1.[FaxNumber]
FROM (
SELECT [CityCustomersAccountingManagerTitle].[__orig_rowid] AS __orig_rowid, [local_1].[CityCustomersAccountingManagerTitle].[CompanyName], [local_1].[CityCustomersAccountingManagerTitle].[ContactName], [local_1].[CityCustomersAccountingManagerTitle].[JobTitle], [local_1].[CityCustomersAccountingManagerTitle].[StreetAddress], [local_1].[CityCustomersAccountingManagerTitle].[CityName], [local_1].[CityCustomersAccountingManagerTitle].[RegionName], [local_1].[CityCustomersAccountingManagerTitle].[CountryName], [local_1].[CityCustomersAccountingManagerTitle].[PhoneNumber] FROM [local_1].[CityCustomersAccountingManagerTitle]
UNION
SELECT [CityCustomersMarketingAssistantOrSalesAgent].[__orig_rowid] AS __orig_rowid, [local_1].[CityCustomersMarketingAssistantOrSalesAgent].[CompanyName], [local_1].[CityCustomersMarketingAssistantOrSalesAgent].[ContactName], [local_1].[CityCustomersMarketingAssistantOrSalesAgent].[JobTitle], [local_1].[CityCustomersMarketingAssistantOrSalesAgent].[StreetAddress], [local_1].[CityCustomersMarketingAssistantOrSalesAgent].[CityName], [local_1].[CityCustomersMarketingAssistantOrSalesAgent].[RegionName], [local_1].[CityCustomersMarketingAssistantOrSalesAgent].[CountryName], [local_1].[CityCustomersMarketingAssistantOrSalesAgent].[PhoneNumber] FROM [local_1].[CityCustomersMarketingAssistantOrSalesAgent]
UNION
SELECT [CityCustomersMarketingManagerTitle].[__orig_rowid] AS __orig_rowid, [local_1].[CityCustomersMarketingManagerTitle].[CompanyName], [local_1].[CityCustomersMarketingManagerTitle].[ContactName], [local_1].[CityCustomersMarketingManagerTitle].[JobTitle], [local_1].[CityCustomersMarketingManagerTitle].[StreetAddress], [local_1].[CityCustomersMarketingManagerTitle].[CityName], [local_1].[CityCustomersMarketingManagerTitle].[RegionName], [local_1].[CityCustomersMarketingManagerTitle].[CountryName], [local_1].[CityCustomersMarketingManagerTitle].[PhoneNumber] FROM [local_1].[CityCustomersMarketingManagerTitle]
UNION
SELECT [CityCustomersOwnerTitle].[__orig_rowid] AS __orig_rowid, [local_1].[CityCustomersOwnerTitle].[CompanyName], [local_1].[CityCustomersOwnerTitle].[ContactName], [local_1].[CityCustomersOwnerTitle].[JobTitle], [local_1].[CityCustomersOwnerTitle].[StreetAddress], [local_1].[CityCustomersOwnerTitle].[CityName], [local_1].[CityCustomersOwnerTitle].[RegionName], [local_1].[CityCustomersOwnerTitle].[CountryName], [local_1].[CityCustomersOwnerTitle].[PhoneNumber] FROM [local_1].[CityCustomersOwnerTitle]
UNION
SELECT [CityCustomersSalesCatchAll].[__orig_rowid] AS __orig_rowid, [local_1].[CityCustomersSalesCatchAll].[CompanyName], [local_1].[CityCustomersSalesCatchAll].[ContactName], [local_1].[CityCustomersSalesCatchAll].[JobTitle], [local_1].[CityCustomersSalesCatchAll].[StreetAddress], [local_1].[CityCustomersSalesCatchAll].[CityName], [local_1].[CityCustomersSalesCatchAll].[RegionName], [local_1].[CityCustomersSalesCatchAll].[CountryName], [local_1].[CityCustomersSalesCatchAll].[PhoneNumber] FROM [local_1].[CityCustomersSalesCatchAll]
UNION
SELECT [CityCustomersSalesManagerTitle].[__orig_rowid] AS __orig_rowid, [local_1].[CityCustomersSalesManagerTitle].[CompanyName], [local_1].[CityCustomersSalesManagerTitle].[ContactName], [local_1].[CityCustomersSalesManagerTitle].[JobTitle], [local_1].[CityCustomersSalesManagerTitle].[StreetAddress], [local_1].[CityCustomersSalesManagerTitle].[CityName], [local_1].[CityCustomersSalesManagerTitle].[RegionName], [local_1].[CityCustomersSalesManagerTitle].[CountryName], [local_1].[CityCustomersSalesManagerTitle].[PhoneNumber] FROM [local_1].[CityCustomersSalesManagerTitle]
UNION
SELECT [CityCustomersSalesRepresentativeTitle].[__orig_rowid] AS __orig_rowid, [local_1].[CityCustomersSalesRepresentativeTitle].[CompanyName], [local_1].[CityCustomersSalesRepresentativeTitle].[ContactName], [local_1].[CityCustomersSalesRepresentativeTitle].[JobTitle], [local_1].[CityCustomersSalesRepresentativeTitle].[StreetAddress], [local_1].[CityCustomersSalesRepresentativeTitle].[CityName], [local_1].[CityCustomersSalesRepresentativeTitle].[RegionName], [local_1].[CityCustomersSalesRepresentativeTitle].[CountryName], [local_1].[CityCustomersSalesRepresentativeTitle].[PhoneNumber] FROM [local_1].[CityCustomersSalesRepresentativeTitle]
) t0
JOIN [local_1].[CityCustomerCompact] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct employees from vertical (column) split (3 fragments)
CREATE VIEW "employees" AS
SELECT
    t0."EmployeeIdentifier" AS "employeeid",
    t0."LastName" AS "lastname",
    t0."FirstName" AS "firstname",
    t1."JobTitle" AS "title",
    t1."CourtesyTitle" AS "titleofcourtesy",
    t2."BirthDate" AS "birthdate",
    t2."HireDate" AS "hiredate",
    t0."StreetAddress" AS "address",
    t0."CityName" AS "city",
    t0."RegionName" AS "region",
    t0."PostalCode" AS "postalcode",
    t0."CountryName" AS "country",
    t0."HomePhone" AS "homephone",
    t0."PhoneExtension" AS "extension",
    t1."PhotoData" AS "photo",
    t2."Notes" AS "notes",
    t0."ReportsToId" AS "reportsto",
    t1."PhotoPath" AS "photopath"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "PostalCode" ORDER BY rowid) AS __rn FROM "local_1"."EmployeeAddresses") t0
JOIN "local_1"."EmployeeAddressesWithPhoto" t1 ON t0."PostalCode" IS t1."PostalCode" AND t0.__rn = t1.__rn
JOIN "local_1"."EmployeeBirthAndHire" t2 ON t0."PostalCode" IS t2."PostalCode" AND t0.__rn = t2.__rn;

-- Reconstruct employeeterritories from row partitions (UNION (overlap))
CREATE VIEW "employeeterritories" AS
SELECT "local_3"."emp_terrs_emp_lte3"."emp_id" AS "employeeid", "local_3"."emp_terrs_emp_lte3"."terr_code" AS "territoryid" FROM "local_3"."emp_terrs_emp_lte3"
UNION
SELECT "local_3"."emp_terrs_emp_gt3_lte6"."emp_id" AS "employeeid", "local_3"."emp_terrs_emp_gt3_lte6"."terr_code" AS "territoryid" FROM "local_3"."emp_terrs_emp_gt3_lte6"
UNION
SELECT "local_3"."emp_terrs_emp_gt6_lte7"."emp_id" AS "employeeid", "local_3"."emp_terrs_emp_gt6_lte7"."terr_code" AS "territoryid" FROM "local_3"."emp_terrs_emp_gt6_lte7"
UNION
SELECT "local_3"."emp_terrs_emp_gt7_or_null"."emp_id" AS "employeeid", "local_3"."emp_terrs_emp_gt7_or_null"."terr_code" AS "territoryid" FROM "local_3"."emp_terrs_emp_gt7_or_null";

-- Reconstruct order_details from row partitions (UNION (overlap))
CREATE VIEW "order_details" AS
SELECT "local_4"."order_items_orderid_le_10450"."order_id" AS "orderid", "local_4"."order_items_orderid_le_10450"."product_id" AS "productid", "local_4"."order_items_orderid_le_10450"."unit_price" AS "unitprice", "local_4"."order_items_orderid_le_10450"."quantity_ordered" AS "quantity", "local_4"."order_items_orderid_le_10450"."discount_rate" AS "discount" FROM "local_4"."order_items_orderid_le_10450"
UNION
SELECT "local_4"."order_items_orderid_gt_10450_to_10657"."order_id" AS "orderid", "local_4"."order_items_orderid_gt_10450_to_10657"."product_id" AS "productid", "local_4"."order_items_orderid_gt_10450_to_10657"."unit_price" AS "unitprice", "local_4"."order_items_orderid_gt_10450_to_10657"."quantity_ordered" AS "quantity", "local_4"."order_items_orderid_gt_10450_to_10657"."discount_rate" AS "discount" FROM "local_4"."order_items_orderid_gt_10450_to_10657"
UNION
SELECT "local_4"."order_items_orderid_gt_10657_to_10862"."order_id" AS "orderid", "local_4"."order_items_orderid_gt_10657_to_10862"."product_id" AS "productid", "local_4"."order_items_orderid_gt_10657_to_10862"."unit_price" AS "unitprice", "local_4"."order_items_orderid_gt_10657_to_10862"."quantity_ordered" AS "quantity", "local_4"."order_items_orderid_gt_10657_to_10862"."discount_rate" AS "discount" FROM "local_4"."order_items_orderid_gt_10657_to_10862"
UNION
SELECT "local_4"."order_items_orderid_gt_10862_or_null"."order_id" AS "orderid", "local_4"."order_items_orderid_gt_10862_or_null"."product_id" AS "productid", "local_4"."order_items_orderid_gt_10862_or_null"."unit_price" AS "unitprice", "local_4"."order_items_orderid_gt_10862_or_null"."quantity_ordered" AS "quantity", "local_4"."order_items_orderid_gt_10862_or_null"."discount_rate" AS "discount" FROM "local_4"."order_items_orderid_gt_10862_or_null";

-- Reconstruct orders from vertical split + row partition on a fragment
CREATE VIEW "orders" AS
SELECT t0.[OrderNumber], t0.[CustomerCode], t0.[EmployeeIdentifier], t2.[OrderDate], t2.[RequiredDate], t2.[ShippedDate], t0.[ShipViaCarrierId], t0.[FreightCharge], t1.[ShippingName], t1.[ShippingAddress], t0.[ShippingCity], t0.[ShippingRegion], t0.[ShippingPostalCode], t1.[ShippingCountry]
FROM (
SELECT [OrdersForNamedCustomerSet].[__orig_rowid] AS __orig_rowid, [local_1].[OrdersForNamedCustomerSet].[OrderNumber], [local_1].[OrdersForNamedCustomerSet].[CustomerCode], [local_1].[OrdersForNamedCustomerSet].[EmployeeIdentifier], [local_1].[OrdersForNamedCustomerSet].[ShipViaCarrierId], [local_1].[OrdersForNamedCustomerSet].[FreightCharge], [local_1].[OrdersForNamedCustomerSet].[ShippingCity], [local_1].[OrdersForNamedCustomerSet].[ShippingRegion], [local_1].[OrdersForNamedCustomerSet].[ShippingPostalCode] FROM [local_1].[OrdersForNamedCustomerSet]
UNION
SELECT [OrdersForOtherCustomers].[__orig_rowid] AS __orig_rowid, [local_1].[OrdersForOtherCustomers].[OrderNumber], [local_1].[OrdersForOtherCustomers].[CustomerCode], [local_1].[OrdersForOtherCustomers].[EmployeeIdentifier], [local_1].[OrdersForOtherCustomers].[ShipViaCarrierId], [local_1].[OrdersForOtherCustomers].[FreightCharge], [local_1].[OrdersForOtherCustomers].[ShippingCity], [local_1].[OrdersForOtherCustomers].[ShippingRegion], [local_1].[OrdersForOtherCustomers].[ShippingPostalCode] FROM [local_1].[OrdersForOtherCustomers]
) t0
JOIN [local_1].[OrdersShippingInfo] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[OrderDates] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct products from vertical split + row partition on a fragment
CREATE VIEW "products" AS
SELECT t0.[ProductIdentifier], t0.[ProductName], t0.[SupplierIdentifier], t0.[CategoryIdentifier], t0.[QuantityPerUnit], t0.[UnitPrice], t1.[UnitsInStock], t1.[UnitsOnOrder], t1.[ReorderLevel], t0.[IsDiscontinued]
FROM (
SELECT [ProductsSupplierHighestQuartile].[__orig_rowid] AS __orig_rowid, [local_1].[ProductsSupplierHighestQuartile].[ProductIdentifier], [local_1].[ProductsSupplierHighestQuartile].[ProductName], [local_1].[ProductsSupplierHighestQuartile].[SupplierIdentifier], [local_1].[ProductsSupplierHighestQuartile].[CategoryIdentifier], [local_1].[ProductsSupplierHighestQuartile].[QuantityPerUnit], [local_1].[ProductsSupplierHighestQuartile].[UnitPrice], [local_1].[ProductsSupplierHighestQuartile].[IsDiscontinued] FROM [local_1].[ProductsSupplierHighestQuartile]
UNION
SELECT [ProductsSupplierLowestQuartile].[__orig_rowid] AS __orig_rowid, [local_1].[ProductsSupplierLowestQuartile].[ProductIdentifier], [local_1].[ProductsSupplierLowestQuartile].[ProductName], [local_1].[ProductsSupplierLowestQuartile].[SupplierIdentifier], [local_1].[ProductsSupplierLowestQuartile].[CategoryIdentifier], [local_1].[ProductsSupplierLowestQuartile].[QuantityPerUnit], [local_1].[ProductsSupplierLowestQuartile].[UnitPrice], [local_1].[ProductsSupplierLowestQuartile].[IsDiscontinued] FROM [local_1].[ProductsSupplierLowestQuartile]
UNION
SELECT [ProductsSupplierSecondQuartile].[__orig_rowid] AS __orig_rowid, [local_1].[ProductsSupplierSecondQuartile].[ProductIdentifier], [local_1].[ProductsSupplierSecondQuartile].[ProductName], [local_1].[ProductsSupplierSecondQuartile].[SupplierIdentifier], [local_1].[ProductsSupplierSecondQuartile].[CategoryIdentifier], [local_1].[ProductsSupplierSecondQuartile].[QuantityPerUnit], [local_1].[ProductsSupplierSecondQuartile].[UnitPrice], [local_1].[ProductsSupplierSecondQuartile].[IsDiscontinued] FROM [local_1].[ProductsSupplierSecondQuartile]
UNION
SELECT [ProductsSupplierThirdQuartile].[__orig_rowid] AS __orig_rowid, [local_1].[ProductsSupplierThirdQuartile].[ProductIdentifier], [local_1].[ProductsSupplierThirdQuartile].[ProductName], [local_1].[ProductsSupplierThirdQuartile].[SupplierIdentifier], [local_1].[ProductsSupplierThirdQuartile].[CategoryIdentifier], [local_1].[ProductsSupplierThirdQuartile].[QuantityPerUnit], [local_1].[ProductsSupplierThirdQuartile].[UnitPrice], [local_1].[ProductsSupplierThirdQuartile].[IsDiscontinued] FROM [local_1].[ProductsSupplierThirdQuartile]
) t0
JOIN [local_1].[ProductInventoryStatus] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct region from local_1.Regions
CREATE VIEW "region" AS
SELECT
    "local_1"."Regions"."RegionIdentifier" AS "regionid",
    "local_1"."Regions"."RegionDescription" AS "regiondescription"
FROM "local_1"."Regions";

-- Reconstruct shippers from local_2.shippingProviders
CREATE VIEW "shippers" AS
SELECT
    "local_2"."shippingProviders"."carrierId" AS "shipperid",
    "local_2"."shippingProviders"."businessName" AS "companyname",
    "local_2"."shippingProviders"."contactPhone" AS "phone"
FROM "local_2"."shippingProviders";

-- Reconstruct suppliers from vertical (column) split (2 fragments)
CREATE VIEW "suppliers" AS
SELECT
    t0."sup_id" AS "supplierid",
    t0."comp_name" AS "companyname",
    t0."cont_name" AS "contactname",
    t1."cont_title" AS "contacttitle",
    t0."addr" AS "address",
    t0."cty" AS "city",
    t0."regn" AS "region",
    t0."postal_cd" AS "postalcode",
    t0."cntry" AS "country",
    t1."phone_num" AS "phone",
    t1."fax_num" AS "fax",
    t0."web_url" AS "homepage"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "postal_cd" ORDER BY rowid) AS __rn FROM "local_3"."suppl_addr_view") t0
JOIN "local_3"."suppl_profile_comp" t1 ON t0."postal_cd" IS t1."postal_cd" AND t0.__rn = t1.__rn;

-- Reconstruct territories from row partitions (UNION (overlap))
CREATE VIEW "territories" AS
SELECT "local_4"."territories_region_le_1"."territory_id" AS "territoryid", "local_4"."territories_region_le_1"."territory_description" AS "territorydescription", "local_4"."territories_region_le_1"."region_id" AS "regionid" FROM "local_4"."territories_region_le_1"
UNION
SELECT "local_4"."territories_region_gt_1_to_2"."territory_id" AS "territoryid", "local_4"."territories_region_gt_1_to_2"."territory_description" AS "territorydescription", "local_4"."territories_region_gt_1_to_2"."region_id" AS "regionid" FROM "local_4"."territories_region_gt_1_to_2"
UNION
SELECT "local_4"."territories_region_gt_2_to_3"."territory_id" AS "territoryid", "local_4"."territories_region_gt_2_to_3"."territory_description" AS "territorydescription", "local_4"."territories_region_gt_2_to_3"."region_id" AS "regionid" FROM "local_4"."territories_region_gt_2_to_3"
UNION
SELECT "local_4"."territories_region_gt_3_or_null"."territory_id" AS "territoryid", "local_4"."territories_region_gt_3_or_null"."territory_description" AS "territorydescription", "local_4"."territories_region_gt_3_or_null"."region_id" AS "regionid" FROM "local_4"."territories_region_gt_3_or_null";

-- Reconstruct usstates from row partitions (UNION (overlap))
CREATE VIEW "usstates" AS
SELECT "local_5"."EasternStates"."StateIdentifier" AS "stateid", "local_5"."EasternStates"."StateName" AS "statename", "local_5"."EasternStates"."StateAbbreviation" AS "stateabbr", "local_5"."EasternStates"."RegionName" AS "stateregion" FROM "local_5"."EasternStates"
UNION
SELECT "local_5"."MidwestStates"."StateIdentifier" AS "stateid", "local_5"."MidwestStates"."StateName" AS "statename", "local_5"."MidwestStates"."StateAbbreviation" AS "stateabbr", "local_5"."MidwestStates"."RegionName" AS "stateregion" FROM "local_5"."MidwestStates"
UNION
SELECT "local_5"."WesternStates"."StateIdentifier" AS "stateid", "local_5"."WesternStates"."StateName" AS "statename", "local_5"."WesternStates"."StateAbbreviation" AS "stateabbr", "local_5"."WesternStates"."RegionName" AS "stateregion" FROM "local_5"."WesternStates"
UNION
SELECT "local_5"."SouthernAndNorthernStates"."StateIdentifier" AS "stateid", "local_5"."SouthernAndNorthernStates"."StateName" AS "statename", "local_5"."SouthernAndNorthernStates"."StateAbbreviation" AS "stateabbr", "local_5"."SouthernAndNorthernStates"."RegionName" AS "stateregion" FROM "local_5"."SouthernAndNorthernStates";
