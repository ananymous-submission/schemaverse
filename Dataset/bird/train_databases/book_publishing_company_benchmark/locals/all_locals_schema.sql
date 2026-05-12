-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/book_publishing_company/book_publishing_company.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "author_contact_info" (
    "author_id" TEXT,
    "street_address" TEXT,
    "contract_status" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "state_code" TEXT,
    "postal_code" TEXT
);

CREATE TABLE "author_profile" (
    "author_id" TEXT,
    "mailing_address" TEXT,
    "name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "city_name" TEXT,
    "contract_status" TEXT NOT NULL,
    "contact_number" TEXT NOT NULL,
    "state_code" TEXT
);

CREATE TABLE "store_order_summary" (
    "store_id" TEXT,
    "order_number" TEXT,
    "title_code" TEXT,
    "order_date" DATETIME NOT NULL,
    "quantity" INTEGER NOT NULL,
    FOREIGN KEY ("title_code") REFERENCES "title_financials"("title_code")
);

CREATE TABLE "store_order_terms" (
    "store_id" TEXT,
    "order_number" TEXT,
    "title_code" TEXT,
    "order_date" DATETIME NOT NULL,
    "payment_terms" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    FOREIGN KEY ("title_code") REFERENCES "title_financials"("title_code")
);

CREATE TABLE "title_author_link" (
    "author_id" TEXT,
    "title_code" TEXT,
    "author_sequence" INTEGER,
    "royalty_percent" INTEGER,
    FOREIGN KEY ("title_code") REFERENCES "title_financials"("title_code"),
    FOREIGN KEY ("author_id") REFERENCES "author_profile"("author_id")
);

CREATE TABLE "title_financials" (
    "title_code" TEXT,
    "advance_payment" REAL,
    "internal_notes" TEXT,
    "list_price" REAL,
    "publication_date" DATETIME NOT NULL,
    "book_title" TEXT NOT NULL,
    "title_type" TEXT NOT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "employeesEmptyMiddleInitial" (
    "employeeId" TEXT,
    "firstName" TEXT NOT NULL,
    "hireDate" DATETIME NOT NULL,
    "jobLevel" INTEGER,
    "lastName" TEXT NOT NULL,
    "middleInitial" TEXT
);

CREATE TABLE "employeesMiddleInitialAorHorJ" (
    "employeeId" TEXT,
    "firstName" TEXT NOT NULL,
    "hireDate" DATETIME NOT NULL,
    "jobLevel" INTEGER,
    "lastName" TEXT NOT NULL,
    "middleInitial" TEXT
);

CREATE TABLE "employeesMiddleInitialFOrP" (
    "employeeId" TEXT,
    "firstName" TEXT NOT NULL,
    "hireDate" DATETIME NOT NULL,
    "jobLevel" INTEGER,
    "lastName" TEXT NOT NULL,
    "middleInitial" TEXT
);

CREATE TABLE "employeesMiddleInitialMorBorG" (
    "employeeId" TEXT,
    "firstName" TEXT NOT NULL,
    "hireDate" DATETIME NOT NULL,
    "jobLevel" INTEGER,
    "lastName" TEXT NOT NULL,
    "middleInitial" TEXT
);

CREATE TABLE "employeesMiddleInitialOther" (
    "employeeId" TEXT,
    "firstName" TEXT NOT NULL,
    "hireDate" DATETIME NOT NULL,
    "jobLevel" INTEGER,
    "lastName" TEXT NOT NULL,
    "middleInitial" TEXT
);

CREATE TABLE "employeeHireRecords" (
    "employeeId" TEXT,
    "hireDate" DATETIME NOT NULL,
    "jobId" INTEGER NOT NULL,
    "jobLevel" INTEGER,
    "middleInitial" TEXT,
    "publisherId" TEXT NOT NULL
);

CREATE TABLE "jobRoles" (
    "jobId" INTEGER,
    "jobDescription" TEXT NOT NULL,
    "minLevel" INTEGER NOT NULL,
    "maxLevel" INTEGER NOT NULL
);

CREATE TABLE "publisherAssets" (
    "publisherId" TEXT,
    "logoImage" BLOB,
    "publicityInfo" TEXT,
    FOREIGN KEY ("publisherId") REFERENCES "publisherDirectory"("publisherId")
);

CREATE TABLE "publisherDirectory" (
    "publisherId" TEXT,
    "publisherName" TEXT,
    "headquartersCity" TEXT,
    "headquartersState" TEXT,
    "headquartersCountry" TEXT
);

CREATE TABLE "royaltySchedules" (
    "titleId" TEXT NOT NULL,
    "lowRange" INTEGER,
    "highRange" INTEGER,
    "royaltyRate" INTEGER
);

CREATE TABLE "bookAdvanceDetails" (
    "titleId" TEXT,
    "advanceAmount" REAL,
    "listPrice" REAL,
    "publisherId" TEXT,
    "publicationDate" DATETIME NOT NULL,
    "royaltyRate" INTEGER,
    "titleName" TEXT NOT NULL,
    "yearToDateSales" INTEGER
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "TieredDiscounts" (
    "DiscountCategory" TEXT NOT NULL,
    "OutletId" TEXT,
    "MinimumQuantity" INTEGER,
    "MaximumQuantity" INTEGER,
    "DiscountRate" REAL NOT NULL,
    FOREIGN KEY ("OutletId") REFERENCES "RetailOutlets"("OutletId")
);

CREATE TABLE "RetailOutlets" (
    "OutletId" TEXT,
    "OutletName" TEXT,
    "AddressLine" TEXT,
    "CityName" TEXT,
    "StateCode" TEXT,
    "PostalCode" TEXT
);

