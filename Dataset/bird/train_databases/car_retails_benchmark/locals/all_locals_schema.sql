-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/car_retails/car_retails.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "customersByStatesCaNyPaBcCountyCork" (
    "customerId" INTEGER,
    "addressPrimary" TEXT NOT NULL,
    "addressSecondary" TEXT,
    "creditLimitAmount" REAL,
    "customerFullName" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "postalCodeValue" TEXT,
    "salesRepresentativeId" INTEGER,
    "region" TEXT,
    FOREIGN KEY ("salesRepresentativeId") REFERENCES "employeesDirectory"("employeeId")
);

CREATE TABLE "customersByStatesMaCtNswVictoria" (
    "customerId" INTEGER,
    "addressPrimary" TEXT NOT NULL,
    "addressSecondary" TEXT,
    "creditLimitAmount" REAL,
    "customerFullName" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "postalCodeValue" TEXT,
    "salesRepresentativeId" INTEGER,
    "region" TEXT,
    FOREIGN KEY ("salesRepresentativeId") REFERENCES "employeesContactEmails"("employeeId"),
    FOREIGN KEY ("salesRepresentativeId") REFERENCES "employeesDirectory"("employeeId")
);

CREATE TABLE "customersOtherStates" (
    "customerId" INTEGER,
    "addressPrimary" TEXT NOT NULL,
    "addressSecondary" TEXT,
    "creditLimitAmount" REAL,
    "customerFullName" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "postalCodeValue" TEXT,
    "salesRepresentativeId" INTEGER,
    "region" TEXT,
    FOREIGN KEY ("salesRepresentativeId") REFERENCES "employeesContactEmails"("employeeId")
);

CREATE TABLE "customersByCity" (
    "customerId" INTEGER,
    "cityName" TEXT NOT NULL,
    "contactGivenName" TEXT NOT NULL,
    "contactFamilyName" TEXT NOT NULL,
    "countryName" TEXT NOT NULL,
    "creditLimitAmount" REAL,
    "customerFullName" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "postalCodeValue" TEXT,
    "salesRepresentativeId" INTEGER
);

CREATE TABLE "employeesContactEmails" (
    "employeeId" INTEGER,
    "emailAddress" TEXT NOT NULL,
    "phoneExtension" TEXT NOT NULL,
    "jobRole" TEXT NOT NULL,
    "officeId" TEXT NOT NULL,
    "managerId" INTEGER
);

CREATE TABLE "employeesDirectory" (
    "employeeId" INTEGER,
    "phoneExtension" TEXT NOT NULL,
    "givenName" TEXT NOT NULL,
    "jobRole" TEXT NOT NULL,
    "familyName" TEXT NOT NULL,
    "managerId" INTEGER,
    FOREIGN KEY ("managerId") REFERENCES "employeesDirectory"("employeeId")
);

CREATE TABLE "ordersWithCommentsForOtherStateCustomers" (
    "orderId" INTEGER,
    "orderNotes" TEXT,
    "customerId" INTEGER NOT NULL,
    "orderPlacedDate" DATE NOT NULL,
    "requiredByDate" DATE NOT NULL,
    "dateShipped" DATE,
    "orderStatus" TEXT NOT NULL,
    FOREIGN KEY ("customerId") REFERENCES "customersOtherStates"("customerId")
);

CREATE TABLE "customerPaymentRecords" (
    "customerId" INTEGER,
    "paymentReference" TEXT,
    "paymentPostedDate" DATE NOT NULL,
    "paymentAmount" REAL NOT NULL,
    FOREIGN KEY ("customerId") REFERENCES "customersByStatesCaNyPaBcCountyCork"("customerId"),
    FOREIGN KEY ("customerId") REFERENCES "customersByStatesMaCtNswVictoria"("customerId"),
    FOREIGN KEY ("customerId") REFERENCES "customersByCity"("customerId")
);

CREATE TABLE "orderDetailsLinesFourToSix" (
    "orderId" INTEGER,
    "productId" TEXT,
    "quantity" INTEGER NOT NULL,
    "unitPrice" REAL NOT NULL,
    "lineNumber" INTEGER NOT NULL
);

CREATE TABLE "orderDetailsLinesSevenToNine" (
    "orderId" INTEGER,
    "productId" TEXT,
    "quantity" INTEGER NOT NULL,
    "unitPrice" REAL NOT NULL,
    "lineNumber" INTEGER NOT NULL
);

CREATE TABLE "officesPrimaryAddress" (
    "officeId" TEXT,
    "addressPrimary" TEXT NOT NULL,
    "addressSecondary" TEXT,
    "cityName" TEXT NOT NULL,
    "countryName" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "postalCodeValue" TEXT NOT NULL
);

CREATE TABLE "productsFromCarouselAndSecondGear" (
    "productId" TEXT,
    "productTitle" TEXT NOT NULL,
    "productCategory" TEXT NOT NULL,
    "scale" TEXT NOT NULL,
    "vendorName" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "stockQuantity" INTEGER NOT NULL,
    "costPrice" REAL NOT NULL,
    "listPrice" REAL NOT NULL
);

CREATE TABLE "productsFromExotoAndGearbox" (
    "productId" TEXT,
    "productTitle" TEXT NOT NULL,
    "productCategory" TEXT NOT NULL,
    "scale" TEXT NOT NULL,
    "vendorName" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "stockQuantity" INTEGER NOT NULL,
    "costPrice" REAL NOT NULL,
    "listPrice" REAL NOT NULL
);

CREATE TABLE "productsFromHighway66AndMotorCity" (
    "productId" TEXT,
    "productTitle" TEXT NOT NULL,
    "productCategory" TEXT NOT NULL,
    "scale" TEXT NOT NULL,
    "vendorName" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "stockQuantity" INTEGER NOT NULL,
    "costPrice" REAL NOT NULL,
    "listPrice" REAL NOT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "OfficeBranch" (
    "BranchIdentifier" TEXT,
    "CityName" TEXT NOT NULL,
    "CountryName" TEXT NOT NULL,
    "ContactPhone" TEXT NOT NULL,
    "PostalZip" TEXT NOT NULL,
    "AdministrativeRegion" TEXT,
    "SalesTerritory" TEXT NOT NULL
);

CREATE TABLE "ProductLineCatalog" (
    "ProductLineKey" TEXT,
    "SummaryDescription" TEXT,
    "RichHtmlDescription" TEXT,
    "ImageData" BLOB
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "ord_ln_range_le3" (
    "ord_id" INTEGER,
    "prod_sku" TEXT,
    "qty_ord" INTEGER NOT NULL,
    "price_each" REAL NOT NULL,
    "line_no" INTEGER NOT NULL
);

CREATE TABLE "ord_ln_gt9_or_null" (
    "ord_id" INTEGER,
    "prod_sku" TEXT,
    "qty_ord" INTEGER NOT NULL,
    "price_each" REAL NOT NULL,
    "line_no" INTEGER NOT NULL
);

CREATE TABLE "prod_vendor_classic_autoart_minlin" (
    "prod_sku" TEXT,
    "prod_name" TEXT NOT NULL,
    "prod_line" TEXT NOT NULL,
    "scale" TEXT NOT NULL,
    "vendor" TEXT NOT NULL,
    "descr" TEXT NOT NULL,
    "stock_qty" INTEGER NOT NULL,
    "buy_price" REAL NOT NULL,
    "msrp" REAL NOT NULL
);

CREATE TABLE "prod_vendor_other_or_null" (
    "prod_sku" TEXT,
    "prod_name" TEXT NOT NULL,
    "prod_line" TEXT NOT NULL,
    "scale" TEXT NOT NULL,
    "vendor" TEXT NOT NULL,
    "descr" TEXT NOT NULL,
    "stock_qty" INTEGER NOT NULL,
    "buy_price" REAL NOT NULL,
    "msrp" REAL NOT NULL
);

CREATE TABLE "ord_meta_notes" (
    "ord_id" INTEGER,
    "notes" TEXT,
    "cust_id" INTEGER NOT NULL,
    "ord_status" TEXT NOT NULL
);

