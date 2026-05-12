-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/E_commerce/E_commerce.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "CustomersInSaoPaulo" (
    "CustomerIdentifier" TEXT,
    "CustomerExternalId" TEXT,
    "ZipCodePrefix" INTEGER,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "CustomersInRioDeJaneiroBeloHorizonteSalvadorGuarulhosBrasiliaCuritibaCampinasPortoAlegre" (
    "CustomerIdentifier" TEXT,
    "CustomerExternalId" TEXT,
    "ZipCodePrefix" INTEGER,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "CustomersOtherOrNull" (
    "CustomerIdentifier" TEXT,
    "CustomerExternalId" TEXT,
    "ZipCodePrefix" INTEGER,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "ZipCodeGeolocation" (
    "ZipCodePrefix" INTEGER,
    "Latitude" REAL,
    "Longitude" REAL,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "LeadsClosedWithAverageStock" (
    "MqlIdentifier" TEXT,
    "AverageStockLevel" TEXT,
    "BusinessSegment" TEXT,
    "DeclaredMonthlyRevenue" REAL,
    "DeclaredCatalogSize" REAL,
    "HasCompanyFlag" INTEGER,
    "HasGtinFlag" INTEGER,
    "LeadBehaviorProfile" TEXT,
    "LeadType" TEXT,
    "WonDate" TEXT
);

CREATE TABLE "LeadsClosedByBusinessSegment" (
    "MqlIdentifier" TEXT,
    "BusinessSegment" TEXT,
    "BusinessType" TEXT,
    "DeclaredMonthlyRevenue" REAL,
    "HasCompanyFlag" INTEGER,
    "LeadBehaviorProfile" TEXT,
    "LeadType" TEXT,
    "WonDate" TEXT
);

CREATE TABLE "LeadsClosedForSdr4b339f9567d060bcea4f5136b9f5949e" (
    "MqlIdentifier" TEXT,
    "SdrIdentifier" TEXT,
    "SellerIdentifier" TEXT,
    "SrIdentifier" TEXT
);

CREATE TABLE "LeadsClosedForSdr068066e24f0c643eb1d089c7dd20cd73AndSdr56bf83c4bb35763a51c2baab501b4c67" (
    "MqlIdentifier" TEXT,
    "SdrIdentifier" TEXT,
    "SellerIdentifier" TEXT,
    "SrIdentifier" TEXT
);

CREATE TABLE "LeadsClosedForSdr9d12ef1a7eca3ec58c545c678af7869cAndSdra8387c01a09e99ce014107505b92388c" (
    "MqlIdentifier" TEXT,
    "SdrIdentifier" TEXT,
    "SellerIdentifier" TEXT,
    "SrIdentifier" TEXT
);

CREATE TABLE "LeadsClosedForSdr9e4d1098a3b0f5da39b0bc48f9876645AndSdrde63de0d10a6012430098db33c679b0b" (
    "MqlIdentifier" TEXT,
    "SdrIdentifier" TEXT,
    "SellerIdentifier" TEXT,
    "SrIdentifier" TEXT
);

CREATE TABLE "LeadsClosedForSdr370c9f455f93a9a96cbe9bea48e70033AndSdr09285259593c61296eef10c734121d5b" (
    "MqlIdentifier" TEXT,
    "SdrIdentifier" TEXT,
    "SellerIdentifier" TEXT,
    "SrIdentifier" TEXT
);

CREATE TABLE "LeadsClosedForOtherSdrsOrNull" (
    "MqlIdentifier" TEXT,
    "SdrIdentifier" TEXT,
    "SellerIdentifier" TEXT,
    "SrIdentifier" TEXT
);

CREATE TABLE "LeadsQualifiedUpTo20171231" (
    "MqlIdentifier" TEXT,
    "FirstContactDate" TEXT,
    "LandingPageIdentifier" TEXT,
    "LeadOrigin" TEXT
);

CREATE TABLE "LeadsQualifiedAfter20171231To20180225" (
    "MqlIdentifier" TEXT,
    "FirstContactDate" TEXT,
    "LandingPageIdentifier" TEXT,
    "LeadOrigin" TEXT
);

CREATE TABLE "LeadsQualifiedAfter20180225To20180415" (
    "MqlIdentifier" TEXT,
    "FirstContactDate" TEXT,
    "LandingPageIdentifier" TEXT,
    "LeadOrigin" TEXT
);

CREATE TABLE "LeadsQualifiedAfter20180415OrNull" (
    "MqlIdentifier" TEXT,
    "FirstContactDate" TEXT,
    "LandingPageIdentifier" TEXT,
    "LeadOrigin" TEXT
);

CREATE TABLE "OrderPaymentsSingleOrNoInstallment" (
    "OrderIdentifier" TEXT,
    "PaymentSequence" INTEGER,
    "PaymentMethod" TEXT,
    "PaymentInstallments" INTEGER,
    "PaymentAmount" REAL
);

CREATE TABLE "OrderPaymentsInstallmentsBetween2And4" (
    "OrderIdentifier" TEXT,
    "PaymentSequence" INTEGER,
    "PaymentMethod" TEXT,
    "PaymentInstallments" INTEGER,
    "PaymentAmount" REAL
);

CREATE TABLE "OrderPaymentsMoreThan4OrNull" (
    "OrderIdentifier" TEXT,
    "PaymentSequence" INTEGER,
    "PaymentMethod" TEXT,
    "PaymentInstallments" INTEGER,
    "PaymentAmount" REAL
);

CREATE TABLE "OrderReviewsUpTo20170923000000" (
    "ReviewIdentifier" TEXT,
    "OrderIdentifier" TEXT,
    "ReviewScore" INTEGER,
    "ReviewCommentTitle" TEXT,
    "ReviewCommentMessage" TEXT,
    "ReviewCreationTimestamp" TEXT,
    "ReviewAnswerTimestamp" TEXT
);

CREATE TABLE "OrderReviewsAfter20170923000000To20180202000000" (
    "ReviewIdentifier" TEXT,
    "OrderIdentifier" TEXT,
    "ReviewScore" INTEGER,
    "ReviewCommentTitle" TEXT,
    "ReviewCommentMessage" TEXT,
    "ReviewCreationTimestamp" TEXT,
    "ReviewAnswerTimestamp" TEXT
);

CREATE TABLE "OrderReviewsAfter20180202000000To20180516000000" (
    "ReviewIdentifier" TEXT,
    "OrderIdentifier" TEXT,
    "ReviewScore" INTEGER,
    "ReviewCommentTitle" TEXT,
    "ReviewCommentMessage" TEXT,
    "ReviewCreationTimestamp" TEXT,
    "ReviewAnswerTimestamp" TEXT
);

CREATE TABLE "OrderReviewsAfter20180516000000OrNull" (
    "ReviewIdentifier" TEXT,
    "OrderIdentifier" TEXT,
    "ReviewScore" INTEGER,
    "ReviewCommentTitle" TEXT,
    "ReviewCommentMessage" TEXT,
    "ReviewCreationTimestamp" TEXT,
    "ReviewAnswerTimestamp" TEXT
);

CREATE TABLE "OrdersSummary" (
    "CustomerIdentifier" TEXT,
    "OrderApprovedTimestamp" TEXT,
    "OrderIdentifier" TEXT,
    "OrderPurchaseTimestamp" TEXT,
    "OrderStatus" TEXT
);

CREATE TABLE "OrdersWithDeliveryDates" (
    "CustomerIdentifier" TEXT,
    "OrderApprovedTimestamp" TEXT,
    "OrderDeliveredToCarrierTimestamp" TEXT,
    "OrderDeliveredToCustomerTimestamp" TEXT,
    "OrderEstimatedDeliveryTimestamp" TEXT,
    "OrderPurchaseTimestamp" TEXT,
    "OrderStatus" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "category_name_translations_map" (
    "category_key" TEXT,
    "category_name_en" TEXT
);

CREATE TABLE "bedding_bath_and_sports_products" (
    "product_sku" TEXT,
    "category_key" TEXT,
    "description_length_chars" REAL,
    "length_cm" REAL,
    "name_length_chars" REAL,
    "photos_count" REAL,
    "weight_g" REAL
);

CREATE TABLE "furniture_toys_and_gifts_products" (
    "product_sku" TEXT,
    "category_key" TEXT,
    "description_length_chars" REAL,
    "length_cm" REAL,
    "name_length_chars" REAL,
    "photos_count" REAL,
    "weight_g" REAL
);

CREATE TABLE "beauty_health_and_household_products" (
    "product_sku" TEXT,
    "category_key" TEXT,
    "description_length_chars" REAL,
    "length_cm" REAL,
    "name_length_chars" REAL,
    "photos_count" REAL,
    "weight_g" REAL
);

CREATE TABLE "auto_and_computer_accessories_products" (
    "product_sku" TEXT,
    "category_key" TEXT,
    "description_length_chars" REAL,
    "length_cm" REAL,
    "name_length_chars" REAL,
    "photos_count" REAL,
    "weight_g" REAL
);

CREATE TABLE "other_or_unclassified_products" (
    "product_sku" TEXT,
    "category_key" TEXT,
    "description_length_chars" REAL,
    "length_cm" REAL,
    "name_length_chars" REAL,
    "photos_count" REAL,
    "weight_g" REAL
);

CREATE TABLE "product_master_catalog" (
    "product_sku" TEXT,
    "category_key" TEXT,
    "height_cm" REAL,
    "length_cm" REAL,
    "photos_count" REAL,
    "weight_g" REAL,
    "width_cm" REAL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "ord_itm_frt_val" (
    "ord_id" TEXT,
    "ord_itm_id" INTEGER,
    "frt_val" REAL,
    "prc" REAL,
    "ship_lim_dt" TEXT
);

CREATE TABLE "ord_itm_prc_lte_39_9" (
    "ord_id" TEXT,
    "ord_itm_id" INTEGER,
    "prc" REAL,
    "prod_id" TEXT,
    "sel_id" TEXT,
    "ship_lim_dt" TEXT
);

CREATE TABLE "ord_itm_prc_gt_39_9_lte_74_99" (
    "ord_id" TEXT,
    "ord_itm_id" INTEGER,
    "prc" REAL,
    "prod_id" TEXT,
    "sel_id" TEXT,
    "ship_lim_dt" TEXT
);

CREATE TABLE "ord_itm_prc_gt_74_99_lte_134_9" (
    "ord_id" TEXT,
    "ord_itm_id" INTEGER,
    "prc" REAL,
    "prod_id" TEXT,
    "sel_id" TEXT,
    "ship_lim_dt" TEXT
);

CREATE TABLE "ord_itm_prc_gt_134_9_or_null" (
    "ord_id" TEXT,
    "ord_itm_id" INTEGER,
    "prc" REAL,
    "prod_id" TEXT,
    "sel_id" TEXT,
    "ship_lim_dt" TEXT
);

CREATE TABLE "sel_city_sao_paulo" (
    "sel_id" TEXT,
    "sel_zip_pref" INTEGER,
    "sel_city" TEXT,
    "sel_state" TEXT
);

CREATE TABLE "sel_city_selected_cities" (
    "sel_id" TEXT,
    "sel_zip_pref" INTEGER,
    "sel_city" TEXT,
    "sel_state" TEXT
);

CREATE TABLE "sel_city_other_or_null" (
    "sel_id" TEXT,
    "sel_zip_pref" INTEGER,
    "sel_city" TEXT,
    "sel_state" TEXT
);

