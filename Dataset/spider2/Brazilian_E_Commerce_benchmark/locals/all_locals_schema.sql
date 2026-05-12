-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/Brazilian_E_Commerce/Brazilian_E_Commerce.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "CustomersSaoPaulo" (
    "CustomerId" TEXT,
    "CustomerExternalId" TEXT,
    "PostalCodePrefix" BIGINT,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "CustomersMajorCities" (
    "CustomerId" TEXT,
    "CustomerExternalId" TEXT,
    "PostalCodePrefix" BIGINT,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "CustomersOtherCities" (
    "CustomerId" TEXT,
    "CustomerExternalId" TEXT,
    "PostalCodePrefix" BIGINT,
    "CityName" TEXT,
    "StateCode" TEXT
);

CREATE TABLE "PostalGeolocation" (
    "PostalCodePrefix" BIGINT,
    "Latitude" FLOAT,
    "Longitude" FLOAT,
    "GeoCity" TEXT,
    "GeoState" TEXT
);

CREATE TABLE "OrderPaymentsSingleInstallment" (
    "OrderId" TEXT,
    "PaymentSequence" BIGINT,
    "PaymentMethod" TEXT,
    "InstallmentCount" BIGINT,
    "PaymentAmount" FLOAT
);

CREATE TABLE "OrderPaymentsTwoInstallments" (
    "OrderId" TEXT,
    "PaymentSequence" BIGINT,
    "PaymentMethod" TEXT,
    "InstallmentCount" BIGINT,
    "PaymentAmount" FLOAT
);

CREATE TABLE "OrderPaymentsThreeInstallments" (
    "OrderId" TEXT,
    "PaymentSequence" BIGINT,
    "PaymentMethod" TEXT,
    "InstallmentCount" BIGINT,
    "PaymentAmount" FLOAT
);

CREATE TABLE "OrderPaymentsInstallmentsFourFiveEight" (
    "OrderId" TEXT,
    "PaymentSequence" BIGINT,
    "PaymentMethod" TEXT,
    "InstallmentCount" BIGINT,
    "PaymentAmount" FLOAT
);

CREATE TABLE "OrderPaymentsInstallmentsTenSixSevenAndOther" (
    "OrderId" TEXT,
    "PaymentSequence" BIGINT,
    "PaymentMethod" TEXT,
    "InstallmentCount" BIGINT,
    "PaymentAmount" FLOAT
);

CREATE TABLE "OrderReviewsUpTo20170923" (
    "ReviewId" TEXT,
    "OrderId" TEXT,
    "ReviewScore" BIGINT,
    "ReviewTitle" TEXT,
    "ReviewMessage" TEXT,
    "CreatedAt" TEXT,
    "AnsweredAt" TEXT
);

CREATE TABLE "OrderReviews20170924To20180202" (
    "ReviewId" TEXT,
    "OrderId" TEXT,
    "ReviewScore" BIGINT,
    "ReviewTitle" TEXT,
    "ReviewMessage" TEXT,
    "CreatedAt" TEXT,
    "AnsweredAt" TEXT
);

CREATE TABLE "OrderReviews20180203To20180516" (
    "ReviewId" TEXT,
    "OrderId" TEXT,
    "ReviewScore" BIGINT,
    "ReviewTitle" TEXT,
    "ReviewMessage" TEXT,
    "CreatedAt" TEXT,
    "AnsweredAt" TEXT
);

CREATE TABLE "OrderReviewsAfter20180516OrNull" (
    "ReviewId" TEXT,
    "OrderId" TEXT,
    "ReviewScore" BIGINT,
    "ReviewTitle" TEXT,
    "ReviewMessage" TEXT,
    "CreatedAt" TEXT,
    "AnsweredAt" TEXT
);

CREATE TABLE "CustomerOrders" (
    "OrderId" TEXT,
    "CustomerId" TEXT,
    "Status" TEXT,
    "PurchasedAt" TEXT,
    "ApprovedAt" TEXT,
    "CarrierDeliveryAt" TEXT,
    "DeliveredToCustomerAt" TEXT,
    "EstimatedDeliveryAt" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "products_master_bed_bath_and_sports" (
    "product_sku" TEXT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_master_furniture_toys_and_gifts" (
    "product_sku" TEXT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_master_beauty_health_and_household" (
    "product_sku" TEXT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_master_automotive_and_it_accessories" (
    "product_sku" TEXT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_master_other" (
    "product_sku" TEXT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_master_dimensions" (
    "product_sku" TEXT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "height_cm_value" FLOAT,
    "length_cm_value" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT,
    "width_cm_value" FLOAT
);

CREATE TABLE "products_dataset_index_bed_bath_and_sports" (
    "product_sku" TEXT,
    "dataset_index" BIGINT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_dataset_index_furniture_toys_and_gifts" (
    "product_sku" TEXT,
    "dataset_index" BIGINT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_dataset_index_beauty_health_and_household" (
    "product_sku" TEXT,
    "dataset_index" BIGINT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_dataset_index_automotive_and_it_accessories" (
    "product_sku" TEXT,
    "dataset_index" BIGINT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_dataset_index_other" (
    "product_sku" TEXT,
    "dataset_index" BIGINT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_dataset_index_dimensions" (
    "product_sku" TEXT,
    "dataset_index" BIGINT,
    "category_label" TEXT,
    "height_cm_value" FLOAT,
    "length_cm_value" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT,
    "width_cm_value" FLOAT
);

CREATE TABLE "category_translation_map" (
    "category_label_original" TEXT,
    "category_label_english" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "ord_itm_frt_le_13_08" (
    "ord_id" TEXT,
    "ord_itm_id" BIGINT,
    "frt_val" FLOAT,
    "itm_price" FLOAT,
    "prod_id" TEXT,
    "ship_limit_dt" TEXT
);

CREATE TABLE "ord_itm_frt_gt_13_08_le_16_26" (
    "ord_id" TEXT,
    "ord_itm_id" BIGINT,
    "frt_val" FLOAT,
    "itm_price" FLOAT,
    "prod_id" TEXT,
    "ship_limit_dt" TEXT
);

CREATE TABLE "ord_itm_frt_gt_16_26_le_21_15" (
    "ord_id" TEXT,
    "ord_itm_id" BIGINT,
    "frt_val" FLOAT,
    "itm_price" FLOAT,
    "prod_id" TEXT,
    "ship_limit_dt" TEXT
);

CREATE TABLE "ord_itm_frt_gt_21_15_or_null" (
    "ord_id" TEXT,
    "ord_itm_id" BIGINT,
    "frt_val" FLOAT,
    "itm_price" FLOAT,
    "prod_id" TEXT,
    "ship_limit_dt" TEXT
);

CREATE TABLE "ord_itm_prod_slr_ship_limit" (
    "ord_id" TEXT,
    "ord_itm_id" BIGINT,
    "prod_id" TEXT,
    "slr_id" TEXT,
    "ship_limit_dt" TEXT
);

CREATE TABLE "slr_city_sao_paulo" (
    "slr_id" TEXT,
    "slr_zip_pref" BIGINT,
    "slr_city" TEXT,
    "slr_state" TEXT
);

CREATE TABLE "slr_city_curitiba_rio_santo_andre_campinas_belo_horizonte_ribeirao_preto_guarulhos_ibitinga" (
    "slr_id" TEXT,
    "slr_zip_pref" BIGINT,
    "slr_city" TEXT,
    "slr_state" TEXT
);

CREATE TABLE "slr_city_other_or_null" (
    "slr_id" TEXT,
    "slr_zip_pref" BIGINT,
    "slr_city" TEXT,
    "slr_state" TEXT
);

