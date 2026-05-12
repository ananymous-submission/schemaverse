-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct Customers from row partitions (UNION (overlap))
CREATE VIEW "Customers" AS
SELECT "local_1"."customersMiddleAOrL"."customerKey" AS "CustomerID", "local_1"."customersMiddleAOrL"."givenName" AS "FirstName", "local_1"."customersMiddleAOrL"."middleInitialCode" AS "MiddleInitial", "local_1"."customersMiddleAOrL"."familyName" AS "LastName" FROM "local_1"."customersMiddleAOrL"
UNION
SELECT "local_1"."customersMiddleMOrJ"."customerKey" AS "CustomerID", "local_1"."customersMiddleMOrJ"."givenName" AS "FirstName", "local_1"."customersMiddleMOrJ"."middleInitialCode" AS "MiddleInitial", "local_1"."customersMiddleMOrJ"."familyName" AS "LastName" FROM "local_1"."customersMiddleMOrJ"
UNION
SELECT "local_1"."customersMiddleCOrDOrSOrEOrR"."customerKey" AS "CustomerID", "local_1"."customersMiddleCOrDOrSOrEOrR"."givenName" AS "FirstName", "local_1"."customersMiddleCOrDOrSOrEOrR"."middleInitialCode" AS "MiddleInitial", "local_1"."customersMiddleCOrDOrSOrEOrR"."familyName" AS "LastName" FROM "local_1"."customersMiddleCOrDOrSOrEOrR"
UNION
SELECT "local_1"."customersMiddleOther"."customerKey" AS "CustomerID", "local_1"."customersMiddleOther"."givenName" AS "FirstName", "local_1"."customersMiddleOther"."middleInitialCode" AS "MiddleInitial", "local_1"."customersMiddleOther"."familyName" AS "LastName" FROM "local_1"."customersMiddleOther";

-- Reconstruct Employees from local_2.emp_rec
CREATE VIEW "Employees" AS
SELECT
    "local_2"."emp_rec"."emp_id" AS "EmployeeID",
    "local_2"."emp_rec"."emp_fn" AS "FirstName",
    "local_2"."emp_rec"."emp_mi" AS "MiddleInitial",
    "local_2"."emp_rec"."emp_ln" AS "LastName"
FROM "local_2"."emp_rec";

-- Reconstruct Products from local_3.ProductCatalog
CREATE VIEW "Products" AS
SELECT
    "local_3"."ProductCatalog"."CatalogItemId" AS "ProductID",
    "local_3"."ProductCatalog"."Title" AS "Name",
    "local_3"."ProductCatalog"."UnitPrice" AS "Price"
FROM "local_3"."ProductCatalog";

-- Reconstruct Sales from row partitions (UNION (overlap))
CREATE VIEW "Sales" AS
SELECT "local_1"."salesQuantityUpTo252"."saleId" AS "SalesID", "local_1"."salesQuantityUpTo252"."salesRepId" AS "SalesPersonID", "local_1"."salesQuantityUpTo252"."customerKeyRef" AS "CustomerID", "local_1"."salesQuantityUpTo252"."productKeyRef" AS "ProductID", "local_1"."salesQuantityUpTo252"."orderQuantity" AS "Quantity" FROM "local_1"."salesQuantityUpTo252"
UNION
SELECT "local_1"."salesQuantityAbove751OrNull"."saleId" AS "SalesID", "local_1"."salesQuantityAbove751OrNull"."salesRepId" AS "SalesPersonID", "local_1"."salesQuantityAbove751OrNull"."customerKeyRef" AS "CustomerID", "local_1"."salesQuantityAbove751OrNull"."productKeyRef" AS "ProductID", "local_1"."salesQuantityAbove751OrNull"."orderQuantity" AS "Quantity" FROM "local_1"."salesQuantityAbove751OrNull"
UNION
SELECT "local_3"."SalesQuantity253To500"."SaleRecordId" AS "SalesID", "local_3"."SalesQuantity253To500"."SalesRepresentativeId" AS "SalesPersonID", "local_3"."SalesQuantity253To500"."ClientId" AS "CustomerID", "local_3"."SalesQuantity253To500"."CatalogItemId" AS "ProductID", "local_3"."SalesQuantity253To500"."UnitsSold" AS "Quantity" FROM "local_3"."SalesQuantity253To500"
UNION
SELECT "local_3"."SalesQuantity501To751"."SaleRecordId" AS "SalesID", "local_3"."SalesQuantity501To751"."SalesRepresentativeId" AS "SalesPersonID", "local_3"."SalesQuantity501To751"."ClientId" AS "CustomerID", "local_3"."SalesQuantity501To751"."CatalogItemId" AS "ProductID", "local_3"."SalesQuantity501To751"."UnitsSold" AS "Quantity" FROM "local_3"."SalesQuantity501To751";
