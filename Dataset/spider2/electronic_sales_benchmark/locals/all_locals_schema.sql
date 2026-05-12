-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/electronic_sales/electronic_sales.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "CustomersSaoPaulo" (
    "RowIndex" INTEGER,
    "CustomerIdentifier" TEXT,
    "CustomerUniqueIdentifier" TEXT,
    "PostalCodePrefix" INTEGER,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "CustomersMajorMetroCities" (
    "RowIndex" INTEGER,
    "CustomerIdentifier" TEXT,
    "CustomerUniqueIdentifier" TEXT,
    "PostalCodePrefix" INTEGER,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "CustomersOtherOrUnknownCities" (
    "RowIndex" INTEGER,
    "CustomerIdentifier" TEXT,
    "CustomerUniqueIdentifier" TEXT,
    "PostalCodePrefix" INTEGER,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "GeoLocationsSaoPaulo" (
    "RowIndex" INTEGER,
    "PostalCodePrefix" INTEGER,
    "Latitude" REAL,
    "Longitude" REAL,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "GeoLocationsOtherOrUnknownCities" (
    "RowIndex" INTEGER,
    "PostalCodePrefix" INTEGER,
    "Latitude" REAL,
    "Longitude" REAL,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "PaymentsSingleInstallment" (
    "RowIndex" INTEGER,
    "OrderIdentifier" TEXT,
    "PaymentSequence" INTEGER,
    "PaymentMethod" TEXT,
    "PaymentInstallments" INTEGER,
    "PaymentAmount" REAL
);

CREATE TABLE "PaymentsInstallmentsUpTo4" (
    "RowIndex" INTEGER,
    "OrderIdentifier" TEXT,
    "PaymentSequence" INTEGER,
    "PaymentMethod" TEXT,
    "PaymentInstallments" INTEGER,
    "PaymentAmount" REAL
);

CREATE TABLE "PaymentsInstallmentsMoreThan4OrNull" (
    "RowIndex" INTEGER,
    "OrderIdentifier" TEXT,
    "PaymentSequence" INTEGER,
    "PaymentMethod" TEXT,
    "PaymentInstallments" INTEGER,
    "PaymentAmount" REAL
);

CREATE TABLE "OrderReviewsOnOrBefore2017_09_23" (
    "RowIndex" INTEGER,
    "ReviewIdentifier" TEXT,
    "OrderIdentifier" TEXT,
    "ReviewScore" INTEGER,
    "ReviewTitle" TEXT,
    "ReviewMessage" TEXT,
    "ReviewCreationTimestamp" TEXT,
    "ReviewResponseTimestamp" TEXT
);

CREATE TABLE "OrderReviews2017_09_23To2018_02_02" (
    "RowIndex" INTEGER,
    "ReviewIdentifier" TEXT,
    "OrderIdentifier" TEXT,
    "ReviewScore" INTEGER,
    "ReviewTitle" TEXT,
    "ReviewMessage" TEXT,
    "ReviewCreationTimestamp" TEXT,
    "ReviewResponseTimestamp" TEXT
);

CREATE TABLE "OrderReviews2018_02_02To2018_05_16" (
    "RowIndex" INTEGER,
    "ReviewIdentifier" TEXT,
    "OrderIdentifier" TEXT,
    "ReviewScore" INTEGER,
    "ReviewTitle" TEXT,
    "ReviewMessage" TEXT,
    "ReviewCreationTimestamp" TEXT,
    "ReviewResponseTimestamp" TEXT
);

CREATE TABLE "OrderReviewsAfter2018_05_16OrNull" (
    "RowIndex" INTEGER,
    "ReviewIdentifier" TEXT,
    "OrderIdentifier" TEXT,
    "ReviewScore" INTEGER,
    "ReviewTitle" TEXT,
    "ReviewMessage" TEXT,
    "ReviewCreationTimestamp" TEXT,
    "ReviewResponseTimestamp" TEXT
);

CREATE TABLE "OrdersMasterRecords" (
    "RowIndex" INTEGER,
    "OrderIdentifier" TEXT,
    "CustomerIdentifier" TEXT,
    "OrderStatus" TEXT,
    "PurchaseTimestamp" TEXT,
    "ApprovalTimestamp" TEXT,
    "CarrierDeliveryTimestamp" TEXT,
    "CustomerDeliveryTimestamp" TEXT,
    "EstimatedDeliveryTimestamp" TEXT
);

CREATE TABLE "OrderItemsPriceRange39_9To74_99" (
    "RowIndex" INTEGER,
    "OrderIdentifier" TEXT,
    "OrderItemSequence" INTEGER,
    "Price" REAL,
    "ProductIdentifier" TEXT,
    "SellerIdentifier" TEXT,
    "ShippingLimitTimestamp" TEXT
);

CREATE TABLE "OrderItemsPriceRange74_99To134_9" (
    "RowIndex" INTEGER,
    "OrderIdentifier" TEXT,
    "OrderItemSequence" INTEGER,
    "Price" REAL,
    "ProductIdentifier" TEXT,
    "SellerIdentifier" TEXT,
    "ShippingLimitTimestamp" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "cat_name_xlat" (
    "xlat_idx" INTEGER,
    "cat_label_src" TEXT,
    "cat_label_en" TEXT
);

CREATE TABLE "prod_idx_stats" (
    "prod_id" TEXT,
    "ent_idx" INTEGER,
    "cat_label" TEXT,
    "desc_len" REAL,
    "name_len" REAL,
    "photo_cnt" REAL,
    "wt_g" REAL
);

CREATE TABLE "prod_idx_dims" (
    "prod_id" TEXT,
    "ent_idx" INTEGER,
    "cat_label" TEXT,
    "ht_cm" REAL,
    "len_cm" REAL,
    "photo_cnt" REAL,
    "wt_g" REAL,
    "wdth_cm" REAL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "orderItemsWithFreightValue" (
    "recordId" INTEGER,
    "freightValue" REAL,
    "orderItemId" INTEGER,
    "itemPrice" REAL,
    "shippingLimitDate" TEXT
);

CREATE TABLE "orderItemsPriceAtMost39Point9" (
    "recordId" INTEGER,
    "orderId" TEXT,
    "orderItemId" INTEGER,
    "itemPrice" REAL,
    "productId" TEXT,
    "sellerId" TEXT,
    "shippingLimitDate" TEXT
);

CREATE TABLE "orderItemsPriceAbove134Point9OrNull" (
    "recordId" INTEGER,
    "orderId" TEXT,
    "orderItemId" INTEGER,
    "itemPrice" REAL,
    "productId" TEXT,
    "sellerId" TEXT,
    "shippingLimitDate" TEXT
);

CREATE TABLE "sellersSaoPaulo" (
    "recordId" INTEGER,
    "sellerId" TEXT,
    "zipCodePrefix" INTEGER,
    "city" TEXT,
    "state" TEXT
);

CREATE TABLE "sellersSelectedRegionalCities" (
    "recordId" INTEGER,
    "sellerId" TEXT,
    "zipCodePrefix" INTEGER,
    "city" TEXT,
    "state" TEXT
);

CREATE TABLE "sellersOtherAndUnknownCities" (
    "recordId" INTEGER,
    "sellerId" TEXT,
    "zipCodePrefix" INTEGER,
    "city" TEXT,
    "state" TEXT
);

CREATE TABLE "geolocationSelectedCities" (
    "recordId" INTEGER,
    "zipCodePrefix" INTEGER,
    "latitude" REAL,
    "longitude" REAL,
    "city" TEXT,
    "state" TEXT
);

