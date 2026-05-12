-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct customers from vertical split + row partition on a fragment
CREATE VIEW "customers" AS
SELECT t0.[customerId], t0.[customerFullName], t1.[contactFamilyName], t1.[contactGivenName], t0.[phoneNumber], t0.[addressPrimary], t0.[addressSecondary], t1.[cityName], t0.[region], t0.[postalCodeValue], t1.[countryName], t0.[salesRepresentativeId], t0.[creditLimitAmount]
FROM (
SELECT [customersByStatesCaNyPaBcCountyCork].[__orig_rowid] AS __orig_rowid, [local_1].[customersByStatesCaNyPaBcCountyCork].[customerId], [local_1].[customersByStatesCaNyPaBcCountyCork].[customerFullName], [local_1].[customersByStatesCaNyPaBcCountyCork].[phoneNumber], [local_1].[customersByStatesCaNyPaBcCountyCork].[addressPrimary], [local_1].[customersByStatesCaNyPaBcCountyCork].[addressSecondary], [local_1].[customersByStatesCaNyPaBcCountyCork].[region], [local_1].[customersByStatesCaNyPaBcCountyCork].[postalCodeValue], [local_1].[customersByStatesCaNyPaBcCountyCork].[salesRepresentativeId], [local_1].[customersByStatesCaNyPaBcCountyCork].[creditLimitAmount] FROM [local_1].[customersByStatesCaNyPaBcCountyCork]
UNION
SELECT [customersByStatesMaCtNswVictoria].[__orig_rowid] AS __orig_rowid, [local_1].[customersByStatesMaCtNswVictoria].[customerId], [local_1].[customersByStatesMaCtNswVictoria].[customerFullName], [local_1].[customersByStatesMaCtNswVictoria].[phoneNumber], [local_1].[customersByStatesMaCtNswVictoria].[addressPrimary], [local_1].[customersByStatesMaCtNswVictoria].[addressSecondary], [local_1].[customersByStatesMaCtNswVictoria].[region], [local_1].[customersByStatesMaCtNswVictoria].[postalCodeValue], [local_1].[customersByStatesMaCtNswVictoria].[salesRepresentativeId], [local_1].[customersByStatesMaCtNswVictoria].[creditLimitAmount] FROM [local_1].[customersByStatesMaCtNswVictoria]
UNION
SELECT [customersOtherStates].[__orig_rowid] AS __orig_rowid, [local_1].[customersOtherStates].[customerId], [local_1].[customersOtherStates].[customerFullName], [local_1].[customersOtherStates].[phoneNumber], [local_1].[customersOtherStates].[addressPrimary], [local_1].[customersOtherStates].[addressSecondary], [local_1].[customersOtherStates].[region], [local_1].[customersOtherStates].[postalCodeValue], [local_1].[customersOtherStates].[salesRepresentativeId], [local_1].[customersOtherStates].[creditLimitAmount] FROM [local_1].[customersOtherStates]
) t0
JOIN [local_1].[customersByCity] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct employees from vertical (column) split (2 fragments)
CREATE VIEW "employees" AS
SELECT
    t0."employeeId" AS "employeeNumber",
    t1."familyName" AS "lastName",
    t1."givenName" AS "firstName",
    t0."phoneExtension" AS "extension",
    t0."emailAddress" AS "email",
    t0."officeId" AS "officeCode",
    t0."managerId" AS "reportsTo",
    t0."jobRole" AS "jobTitle"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "employeeId" ORDER BY rowid) AS __rn FROM "local_1"."employeesContactEmails") t0
JOIN "local_1"."employeesDirectory" t1 ON t0."employeeId" IS t1."employeeId" AND t0.__rn = t1.__rn;

-- Reconstruct offices from vertical (column) split (2 fragments)
CREATE VIEW "offices" AS
SELECT
    t0."BranchIdentifier" AS "officeCode",
    t0."CityName" AS "city",
    t0."ContactPhone" AS "phone",
    t1."addressPrimary" AS "addressLine1",
    t1."addressSecondary" AS "addressLine2",
    t0."AdministrativeRegion" AS "state",
    t0."CountryName" AS "country",
    t0."PostalZip" AS "postalCode",
    t0."SalesTerritory" AS "territory"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "BranchIdentifier" ORDER BY rowid) AS __rn FROM "local_2"."OfficeBranch") t0
JOIN "local_1"."officesPrimaryAddress" t1 ON t0."BranchIdentifier" IS t1."officeId" AND t0.__rn = t1.__rn;

-- Reconstruct orderdetails from row partitions (UNION (overlap))
CREATE VIEW "orderdetails" AS
SELECT "local_1"."orderDetailsLinesFourToSix"."orderId" AS "orderNumber", "local_1"."orderDetailsLinesFourToSix"."productId" AS "productCode", "local_1"."orderDetailsLinesFourToSix"."quantity" AS "quantityOrdered", "local_1"."orderDetailsLinesFourToSix"."unitPrice" AS "priceEach", "local_1"."orderDetailsLinesFourToSix"."lineNumber" AS "orderLineNumber" FROM "local_1"."orderDetailsLinesFourToSix"
UNION
SELECT "local_1"."orderDetailsLinesSevenToNine"."orderId" AS "orderNumber", "local_1"."orderDetailsLinesSevenToNine"."productId" AS "productCode", "local_1"."orderDetailsLinesSevenToNine"."quantity" AS "quantityOrdered", "local_1"."orderDetailsLinesSevenToNine"."unitPrice" AS "priceEach", "local_1"."orderDetailsLinesSevenToNine"."lineNumber" AS "orderLineNumber" FROM "local_1"."orderDetailsLinesSevenToNine"
UNION
SELECT "local_3"."ord_ln_range_le3"."ord_id" AS "orderNumber", "local_3"."ord_ln_range_le3"."prod_sku" AS "productCode", "local_3"."ord_ln_range_le3"."qty_ord" AS "quantityOrdered", "local_3"."ord_ln_range_le3"."price_each" AS "priceEach", "local_3"."ord_ln_range_le3"."line_no" AS "orderLineNumber" FROM "local_3"."ord_ln_range_le3"
UNION
SELECT "local_3"."ord_ln_gt9_or_null"."ord_id" AS "orderNumber", "local_3"."ord_ln_gt9_or_null"."prod_sku" AS "productCode", "local_3"."ord_ln_gt9_or_null"."qty_ord" AS "quantityOrdered", "local_3"."ord_ln_gt9_or_null"."price_each" AS "priceEach", "local_3"."ord_ln_gt9_or_null"."line_no" AS "orderLineNumber" FROM "local_3"."ord_ln_gt9_or_null";

-- Reconstruct orders from vertical (column) split (2 fragments)
CREATE VIEW "orders" AS
SELECT
    t0."ord_id" AS "orderNumber",
    t1."orderPlacedDate" AS "orderDate",
    t1."requiredByDate" AS "requiredDate",
    t1."dateShipped" AS "shippedDate",
    t0."ord_status" AS "status",
    t0."notes" AS "comments",
    t0."cust_id" AS "customerNumber"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "ord_id" ORDER BY rowid) AS __rn FROM "local_3"."ord_meta_notes") t0
JOIN "local_1"."ordersWithCommentsForOtherStateCustomers" t1 ON t0."ord_id" IS t1."orderId" AND t0.__rn = t1.__rn;

-- Reconstruct payments from local_1.customerPaymentRecords
CREATE VIEW "payments" AS
SELECT
    "local_1"."customerPaymentRecords"."customerId" AS "customerNumber",
    "local_1"."customerPaymentRecords"."paymentReference" AS "checkNumber",
    "local_1"."customerPaymentRecords"."paymentPostedDate" AS "paymentDate",
    "local_1"."customerPaymentRecords"."paymentAmount" AS "amount"
FROM "local_1"."customerPaymentRecords";

-- Reconstruct productlines from local_2.ProductLineCatalog
CREATE VIEW "productlines" AS
SELECT
    "local_2"."ProductLineCatalog"."ProductLineKey" AS "productLine",
    "local_2"."ProductLineCatalog"."SummaryDescription" AS "textDescription",
    "local_2"."ProductLineCatalog"."RichHtmlDescription" AS "htmlDescription",
    "local_2"."ProductLineCatalog"."ImageData" AS "image"
FROM "local_2"."ProductLineCatalog";

-- Reconstruct products from row partitions (UNION (overlap))
CREATE VIEW "products" AS
SELECT "local_1"."productsFromCarouselAndSecondGear"."productId" AS "productCode", "local_1"."productsFromCarouselAndSecondGear"."productTitle" AS "productName", "local_1"."productsFromCarouselAndSecondGear"."productCategory" AS "productLine", "local_1"."productsFromCarouselAndSecondGear"."scale" AS "productScale", "local_1"."productsFromCarouselAndSecondGear"."vendorName" AS "productVendor", "local_1"."productsFromCarouselAndSecondGear"."description" AS "productDescription", "local_1"."productsFromCarouselAndSecondGear"."stockQuantity" AS "quantityInStock", "local_1"."productsFromCarouselAndSecondGear"."costPrice" AS "buyPrice", "local_1"."productsFromCarouselAndSecondGear"."listPrice" AS "MSRP" FROM "local_1"."productsFromCarouselAndSecondGear"
UNION
SELECT "local_1"."productsFromExotoAndGearbox"."productId" AS "productCode", "local_1"."productsFromExotoAndGearbox"."productTitle" AS "productName", "local_1"."productsFromExotoAndGearbox"."productCategory" AS "productLine", "local_1"."productsFromExotoAndGearbox"."scale" AS "productScale", "local_1"."productsFromExotoAndGearbox"."vendorName" AS "productVendor", "local_1"."productsFromExotoAndGearbox"."description" AS "productDescription", "local_1"."productsFromExotoAndGearbox"."stockQuantity" AS "quantityInStock", "local_1"."productsFromExotoAndGearbox"."costPrice" AS "buyPrice", "local_1"."productsFromExotoAndGearbox"."listPrice" AS "MSRP" FROM "local_1"."productsFromExotoAndGearbox"
UNION
SELECT "local_1"."productsFromHighway66AndMotorCity"."productId" AS "productCode", "local_1"."productsFromHighway66AndMotorCity"."productTitle" AS "productName", "local_1"."productsFromHighway66AndMotorCity"."productCategory" AS "productLine", "local_1"."productsFromHighway66AndMotorCity"."scale" AS "productScale", "local_1"."productsFromHighway66AndMotorCity"."vendorName" AS "productVendor", "local_1"."productsFromHighway66AndMotorCity"."description" AS "productDescription", "local_1"."productsFromHighway66AndMotorCity"."stockQuantity" AS "quantityInStock", "local_1"."productsFromHighway66AndMotorCity"."costPrice" AS "buyPrice", "local_1"."productsFromHighway66AndMotorCity"."listPrice" AS "MSRP" FROM "local_1"."productsFromHighway66AndMotorCity"
UNION
SELECT "local_3"."prod_vendor_classic_autoart_minlin"."prod_sku" AS "productCode", "local_3"."prod_vendor_classic_autoart_minlin"."prod_name" AS "productName", "local_3"."prod_vendor_classic_autoart_minlin"."prod_line" AS "productLine", "local_3"."prod_vendor_classic_autoart_minlin"."scale" AS "productScale", "local_3"."prod_vendor_classic_autoart_minlin"."vendor" AS "productVendor", "local_3"."prod_vendor_classic_autoart_minlin"."descr" AS "productDescription", "local_3"."prod_vendor_classic_autoart_minlin"."stock_qty" AS "quantityInStock", "local_3"."prod_vendor_classic_autoart_minlin"."buy_price" AS "buyPrice", "local_3"."prod_vendor_classic_autoart_minlin"."msrp" AS "MSRP" FROM "local_3"."prod_vendor_classic_autoart_minlin"
UNION
SELECT "local_3"."prod_vendor_other_or_null"."prod_sku" AS "productCode", "local_3"."prod_vendor_other_or_null"."prod_name" AS "productName", "local_3"."prod_vendor_other_or_null"."prod_line" AS "productLine", "local_3"."prod_vendor_other_or_null"."scale" AS "productScale", "local_3"."prod_vendor_other_or_null"."vendor" AS "productVendor", "local_3"."prod_vendor_other_or_null"."descr" AS "productDescription", "local_3"."prod_vendor_other_or_null"."stock_qty" AS "quantityInStock", "local_3"."prod_vendor_other_or_null"."buy_price" AS "buyPrice", "local_3"."prod_vendor_other_or_null"."msrp" AS "MSRP" FROM "local_3"."prod_vendor_other_or_null";
