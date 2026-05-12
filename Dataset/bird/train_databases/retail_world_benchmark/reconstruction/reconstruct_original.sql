-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct Categories from local_1.product_categories
CREATE VIEW "Categories" AS
SELECT
    "local_1"."product_categories"."category_key" AS "CategoryID",
    "local_1"."product_categories"."category_title" AS "CategoryName",
    "local_1"."product_categories"."category_description" AS "Description"
FROM "local_1"."product_categories";

-- Reconstruct Customers from row partitions (UNION (overlap))
CREATE VIEW "Customers" AS
SELECT "local_2"."customersUsa"."clientId" AS "CustomerID", "local_2"."customersUsa"."companyName" AS "CustomerName", "local_2"."customersUsa"."primaryContact" AS "ContactName", "local_2"."customersUsa"."streetAddress" AS "Address", "local_2"."customersUsa"."cityName" AS "City", "local_2"."customersUsa"."postalCodeValue" AS "PostalCode", "local_2"."customersUsa"."countryRegion" AS "Country" FROM "local_2"."customersUsa"
UNION
SELECT "local_2"."customersFrance"."clientId" AS "CustomerID", "local_2"."customersFrance"."companyName" AS "CustomerName", "local_2"."customersFrance"."primaryContact" AS "ContactName", "local_2"."customersFrance"."streetAddress" AS "Address", "local_2"."customersFrance"."cityName" AS "City", "local_2"."customersFrance"."postalCodeValue" AS "PostalCode", "local_2"."customersFrance"."countryRegion" AS "Country" FROM "local_2"."customersFrance"
UNION
SELECT "local_2"."customersGermany"."clientId" AS "CustomerID", "local_2"."customersGermany"."companyName" AS "CustomerName", "local_2"."customersGermany"."primaryContact" AS "ContactName", "local_2"."customersGermany"."streetAddress" AS "Address", "local_2"."customersGermany"."cityName" AS "City", "local_2"."customersGermany"."postalCodeValue" AS "PostalCode", "local_2"."customersGermany"."countryRegion" AS "Country" FROM "local_2"."customersGermany"
UNION
SELECT "local_2"."customersBrazilMexicoSpain"."clientId" AS "CustomerID", "local_2"."customersBrazilMexicoSpain"."companyName" AS "CustomerName", "local_2"."customersBrazilMexicoSpain"."primaryContact" AS "ContactName", "local_2"."customersBrazilMexicoSpain"."streetAddress" AS "Address", "local_2"."customersBrazilMexicoSpain"."cityName" AS "City", "local_2"."customersBrazilMexicoSpain"."postalCodeValue" AS "PostalCode", "local_2"."customersBrazilMexicoSpain"."countryRegion" AS "Country" FROM "local_2"."customersBrazilMexicoSpain"
UNION
SELECT "local_2"."customersUkVenezuelaArgentina"."clientId" AS "CustomerID", "local_2"."customersUkVenezuelaArgentina"."companyName" AS "CustomerName", "local_2"."customersUkVenezuelaArgentina"."primaryContact" AS "ContactName", "local_2"."customersUkVenezuelaArgentina"."streetAddress" AS "Address", "local_2"."customersUkVenezuelaArgentina"."cityName" AS "City", "local_2"."customersUkVenezuelaArgentina"."postalCodeValue" AS "PostalCode", "local_2"."customersUkVenezuelaArgentina"."countryRegion" AS "Country" FROM "local_2"."customersUkVenezuelaArgentina"
UNION
SELECT "local_2"."customersOther"."clientId" AS "CustomerID", "local_2"."customersOther"."companyName" AS "CustomerName", "local_2"."customersOther"."primaryContact" AS "ContactName", "local_2"."customersOther"."streetAddress" AS "Address", "local_2"."customersOther"."cityName" AS "City", "local_2"."customersOther"."postalCodeValue" AS "PostalCode", "local_2"."customersOther"."countryRegion" AS "Country" FROM "local_2"."customersOther";

-- Reconstruct Employees from local_2.staffMembers
CREATE VIEW "Employees" AS
SELECT
    "local_2"."staffMembers"."staffId" AS "EmployeeID",
    "local_2"."staffMembers"."familyName" AS "LastName",
    "local_2"."staffMembers"."givenName" AS "FirstName",
    "local_2"."staffMembers"."dateOfBirth" AS "BirthDate",
    "local_2"."staffMembers"."portraitPath" AS "Photo",
    "local_2"."staffMembers"."internalNotes" AS "Notes"
FROM "local_2"."staffMembers";

-- Reconstruct OrderDetails from row partitions (UNION (overlap))
CREATE VIEW "OrderDetails" AS
SELECT "local_1"."order_items_quantity_11_to_20"."order_item_key" AS "OrderDetailID", "local_1"."order_items_quantity_11_to_20"."order_key" AS "OrderID", "local_1"."order_items_quantity_11_to_20"."product_key" AS "ProductID", "local_1"."order_items_quantity_11_to_20"."quantity_units" AS "Quantity" FROM "local_1"."order_items_quantity_11_to_20"
UNION
SELECT "local_1"."order_items_quantity_21_to_32"."order_item_key" AS "OrderDetailID", "local_1"."order_items_quantity_21_to_32"."order_key" AS "OrderID", "local_1"."order_items_quantity_21_to_32"."product_key" AS "ProductID", "local_1"."order_items_quantity_21_to_32"."quantity_units" AS "Quantity" FROM "local_1"."order_items_quantity_21_to_32"
UNION
SELECT "local_3"."order_det_qty_lte_10"."det_id" AS "OrderDetailID", "local_3"."order_det_qty_lte_10"."ord_ref_id" AS "OrderID", "local_3"."order_det_qty_lte_10"."prod_ref_id" AS "ProductID", "local_3"."order_det_qty_lte_10"."qty_lte_10" AS "Quantity" FROM "local_3"."order_det_qty_lte_10"
UNION
SELECT "local_3"."order_det_qty_gt_32_or_null"."det_id" AS "OrderDetailID", "local_3"."order_det_qty_gt_32_or_null"."ord_ref_id" AS "OrderID", "local_3"."order_det_qty_gt_32_or_null"."prod_ref_id" AS "ProductID", "local_3"."order_det_qty_gt_32_or_null"."qty_gt_32_or_null" AS "Quantity" FROM "local_3"."order_det_qty_gt_32_or_null";

-- Reconstruct Orders from local_2.customerOrders
CREATE VIEW "Orders" AS
SELECT
    "local_2"."customerOrders"."orderNumber" AS "OrderID",
    "local_2"."customerOrders"."clientIdRef" AS "CustomerID",
    "local_2"."customerOrders"."processedByStaffId" AS "EmployeeID",
    "local_2"."customerOrders"."orderTimestamp" AS "OrderDate",
    "local_2"."customerOrders"."carrierId" AS "ShipperID"
FROM "local_2"."customerOrders";

-- Reconstruct Products from local_1.product_listings
CREATE VIEW "Products" AS
SELECT
    "local_1"."product_listings"."product_key" AS "ProductID",
    "local_1"."product_listings"."product_title" AS "ProductName",
    "local_1"."product_listings"."supplier_key" AS "SupplierID",
    "local_1"."product_listings"."category_key" AS "CategoryID",
    "local_1"."product_listings"."unit_measure" AS "Unit",
    "local_1"."product_listings"."unit_price" AS "Price"
FROM "local_1"."product_listings";

-- Reconstruct Shippers from local_3.ship_carriers
CREATE VIEW "Shippers" AS
SELECT
    "local_3"."ship_carriers"."ship_id" AS "ShipperID",
    "local_3"."ship_carriers"."carrier_name" AS "ShipperName",
    "local_3"."ship_carriers"."contact_phone" AS "Phone"
FROM "local_3"."ship_carriers";

-- Reconstruct Suppliers from local_1.product_suppliers
CREATE VIEW "Suppliers" AS
SELECT
    "local_1"."product_suppliers"."supplier_key" AS "SupplierID",
    "local_1"."product_suppliers"."supplier_title" AS "SupplierName",
    "local_1"."product_suppliers"."contact_person" AS "ContactName",
    "local_1"."product_suppliers"."street_address" AS "Address",
    "local_1"."product_suppliers"."city_name" AS "City",
    "local_1"."product_suppliers"."postal_code" AS "PostalCode",
    "local_1"."product_suppliers"."country_name" AS "Country",
    "local_1"."product_suppliers"."contact_phone" AS "Phone"
FROM "local_1"."product_suppliers";
