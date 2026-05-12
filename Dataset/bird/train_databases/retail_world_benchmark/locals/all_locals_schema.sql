-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/retail_world/retail_world.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "product_categories" (
    "category_key" INTEGER,
    "category_title" TEXT,
    "category_description" TEXT
);

CREATE TABLE "product_listings" (
    "product_key" INTEGER,
    "product_title" TEXT,
    "supplier_key" INTEGER,
    "category_key" INTEGER,
    "unit_measure" TEXT,
    "unit_price" REAL DEFAULT 0,
    FOREIGN KEY ("category_key") REFERENCES "product_categories"("category_key")
);

CREATE TABLE "product_suppliers" (
    "supplier_key" INTEGER,
    "supplier_title" TEXT,
    "contact_person" TEXT,
    "street_address" TEXT,
    "city_name" TEXT,
    "postal_code" TEXT,
    "country_name" TEXT,
    "contact_phone" TEXT
);

CREATE TABLE "order_items_quantity_11_to_20" (
    "order_item_key" INTEGER,
    "order_key" INTEGER,
    "product_key" INTEGER,
    "quantity_units" INTEGER,
    FOREIGN KEY ("product_key") REFERENCES "product_listings"("product_key")
);

CREATE TABLE "order_items_quantity_21_to_32" (
    "order_item_key" INTEGER,
    "order_key" INTEGER,
    "product_key" INTEGER,
    "quantity_units" INTEGER
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "customersUsa" (
    "clientId" INTEGER,
    "companyName" TEXT,
    "primaryContact" TEXT,
    "streetAddress" TEXT,
    "cityName" TEXT,
    "postalCodeValue" TEXT,
    "countryRegion" TEXT
);

CREATE TABLE "customersFrance" (
    "clientId" INTEGER,
    "companyName" TEXT,
    "primaryContact" TEXT,
    "streetAddress" TEXT,
    "cityName" TEXT,
    "postalCodeValue" TEXT,
    "countryRegion" TEXT
);

CREATE TABLE "customersGermany" (
    "clientId" INTEGER,
    "companyName" TEXT,
    "primaryContact" TEXT,
    "streetAddress" TEXT,
    "cityName" TEXT,
    "postalCodeValue" TEXT,
    "countryRegion" TEXT
);

CREATE TABLE "customersBrazilMexicoSpain" (
    "clientId" INTEGER,
    "companyName" TEXT,
    "primaryContact" TEXT,
    "streetAddress" TEXT,
    "cityName" TEXT,
    "postalCodeValue" TEXT,
    "countryRegion" TEXT
);

CREATE TABLE "customersUkVenezuelaArgentina" (
    "clientId" INTEGER,
    "companyName" TEXT,
    "primaryContact" TEXT,
    "streetAddress" TEXT,
    "cityName" TEXT,
    "postalCodeValue" TEXT,
    "countryRegion" TEXT
);

CREATE TABLE "customersOther" (
    "clientId" INTEGER,
    "companyName" TEXT,
    "primaryContact" TEXT,
    "streetAddress" TEXT,
    "cityName" TEXT,
    "postalCodeValue" TEXT,
    "countryRegion" TEXT
);

CREATE TABLE "staffMembers" (
    "staffId" INTEGER,
    "familyName" TEXT,
    "givenName" TEXT,
    "dateOfBirth" DATE,
    "portraitPath" TEXT,
    "internalNotes" TEXT
);

CREATE TABLE "customerOrders" (
    "orderNumber" INTEGER,
    "clientIdRef" INTEGER,
    "processedByStaffId" INTEGER,
    "orderTimestamp" DATETIME,
    "carrierId" INTEGER,
    FOREIGN KEY ("clientIdRef") REFERENCES "customersUsa"("clientId"),
    FOREIGN KEY ("clientIdRef") REFERENCES "customersUkVenezuelaArgentina"("clientId"),
    FOREIGN KEY ("clientIdRef") REFERENCES "customersOther"("clientId"),
    FOREIGN KEY ("processedByStaffId") REFERENCES "staffMembers"("staffId")
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "order_det_qty_lte_10" (
    "det_id" INTEGER,
    "ord_ref_id" INTEGER,
    "prod_ref_id" INTEGER,
    "qty_lte_10" INTEGER
);

CREATE TABLE "order_det_qty_gt_32_or_null" (
    "det_id" INTEGER,
    "ord_ref_id" INTEGER,
    "prod_ref_id" INTEGER,
    "qty_gt_32_or_null" INTEGER
);

CREATE TABLE "ship_carriers" (
    "ship_id" INTEGER,
    "carrier_name" TEXT,
    "contact_phone" TEXT
);

