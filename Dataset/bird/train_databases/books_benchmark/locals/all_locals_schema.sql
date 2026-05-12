-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/books/books.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "street_address" (
    "location_id" INTEGER,
    "house_number" TEXT,
    "street_label" TEXT,
    "locality_name" TEXT,
    "country_ref" INTEGER
);

CREATE TABLE "nation" (
    "nation_id" INTEGER,
    "nation_name" TEXT
);

CREATE TABLE "customer_order" (
    "purchase_id" INTEGER,
    "placed_at" DATETIME,
    "client_ref" INTEGER,
    "delivery_option_ref" INTEGER,
    "destination_address_ref" INTEGER
);

CREATE TABLE "client_profile" (
    "client_id" INTEGER,
    "given_name" TEXT,
    "family_name" TEXT,
    "contact_email" TEXT
);

CREATE TABLE "order_event_log" (
    "event_id" INTEGER,
    "purchase_ref" INTEGER,
    "status_ref" INTEGER,
    "status_timestamp" DATETIME
);

CREATE TABLE "order_status_lookup" (
    "status_code_id" INTEGER,
    "status_label" TEXT
);

CREATE TABLE "delivery_option" (
    "option_id" INTEGER,
    "option_label" TEXT,
    "price" REAL
);

CREATE TABLE "client_address_status_greater_than_one" (
    "client_id" INTEGER,
    "address_ref" INTEGER,
    "link_status_id" INTEGER,
    FOREIGN KEY ("client_id") REFERENCES "client_profile"("client_id"),
    FOREIGN KEY ("address_ref") REFERENCES "street_address"("location_id")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "addressStatusLookup" (
    "statusKey" INTEGER,
    "statusLabel" TEXT
);

CREATE TABLE "customerAddressStatusUpToOne" (
    "customerIdRef" INTEGER,
    "addressIdRef" INTEGER,
    "statusKeyRef" INTEGER
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "auth_rec" (
    "auth_id" INTEGER,
    "auth_nm" TEXT
);

CREATE TABLE "bk_auth_map" (
    "bk_id" INTEGER,
    "auth_id" INTEGER
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "BooksMax192Pages" (
    "BookKey" INTEGER,
    "BookTitle" TEXT,
    "Isbn13Code" TEXT,
    "LanguageKey" INTEGER,
    "PageCount" INTEGER,
    "ReleaseDate" DATE,
    "PublisherKey" INTEGER,
    FOREIGN KEY ("LanguageKey") REFERENCES "LanguageCatalog"("LanguageKey")
);

CREATE TABLE "BooksOver416OrNullPages" (
    "BookKey" INTEGER,
    "BookTitle" TEXT,
    "Isbn13Code" TEXT,
    "LanguageKey" INTEGER,
    "PageCount" INTEGER,
    "ReleaseDate" DATE,
    "PublisherKey" INTEGER,
    FOREIGN KEY ("LanguageKey") REFERENCES "LanguageCatalog"("LanguageKey")
);

CREATE TABLE "LanguageCatalog" (
    "LanguageKey" INTEGER,
    "LanguageIsoCode" TEXT,
    "LanguageDisplayName" TEXT
);

CREATE TABLE "OrderLinesPriceRange4Point86To9Point95" (
    "LineKey" INTEGER,
    "OrderKey" INTEGER,
    "BookKey" INTEGER,
    "UnitPrice" REAL
);

CREATE TABLE "OrderLinesPriceRange9Point95To15Point05" (
    "LineKey" INTEGER,
    "OrderKey" INTEGER,
    "BookKey" INTEGER,
    "UnitPrice" REAL
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "orderLinesPriceAtMost4Point86" (
    "lineId" INTEGER,
    "orderId" INTEGER,
    "bookId" INTEGER,
    "linePrice" REAL
);

CREATE TABLE "orderLinesPriceAbove15Point05OrNull" (
    "lineId" INTEGER,
    "orderId" INTEGER,
    "bookId" INTEGER,
    "linePrice" REAL
);

CREATE TABLE "publisherDirectory" (
    "publisherId" INTEGER,
    "publisherName" TEXT
);

CREATE TABLE "booksPages193To299" (
    "bookId" INTEGER,
    "bookTitle" TEXT,
    "isbn13Code" TEXT,
    "languageId" INTEGER,
    "pageCount" INTEGER,
    "publicationDate" DATE,
    "publisherId" INTEGER
);

CREATE TABLE "booksPages300To416" (
    "bookId" INTEGER,
    "bookTitle" TEXT,
    "isbn13Code" TEXT,
    "languageId" INTEGER,
    "pageCount" INTEGER,
    "publicationDate" DATE,
    "publisherId" INTEGER,
    FOREIGN KEY ("publisherId") REFERENCES "publisherDirectory"("publisherId")
);

