-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct olist_customers from row partitions (UNION (overlap))
CREATE VIEW "olist_customers" AS
SELECT "local_1"."CustomersSaoPaulo"."CustomerId" AS "customer_id", "local_1"."CustomersSaoPaulo"."CustomerExternalId" AS "customer_unique_id", "local_1"."CustomersSaoPaulo"."PostalCodePrefix" AS "customer_zip_code_prefix", "local_1"."CustomersSaoPaulo"."CityName" AS "customer_city", "local_1"."CustomersSaoPaulo"."StateCode" AS "customer_state" FROM "local_1"."CustomersSaoPaulo"
UNION
SELECT "local_1"."CustomersMajorCities"."CustomerId" AS "customer_id", "local_1"."CustomersMajorCities"."CustomerExternalId" AS "customer_unique_id", "local_1"."CustomersMajorCities"."PostalCodePrefix" AS "customer_zip_code_prefix", "local_1"."CustomersMajorCities"."CityName" AS "customer_city", "local_1"."CustomersMajorCities"."StateCode" AS "customer_state" FROM "local_1"."CustomersMajorCities"
UNION
SELECT "local_1"."CustomersOtherCities"."CustomerId" AS "customer_id", "local_1"."CustomersOtherCities"."CustomerExternalId" AS "customer_unique_id", "local_1"."CustomersOtherCities"."PostalCodePrefix" AS "customer_zip_code_prefix", "local_1"."CustomersOtherCities"."CityName" AS "customer_city", "local_1"."CustomersOtherCities"."StateCode" AS "customer_state" FROM "local_1"."CustomersOtherCities";

-- Reconstruct olist_geolocation from local_1.PostalGeolocation
CREATE VIEW "olist_geolocation" AS
SELECT
    "local_1"."PostalGeolocation"."PostalCodePrefix" AS "geolocation_zip_code_prefix",
    "local_1"."PostalGeolocation"."Latitude" AS "geolocation_lat",
    "local_1"."PostalGeolocation"."Longitude" AS "geolocation_lng",
    "local_1"."PostalGeolocation"."GeoCity" AS "geolocation_city",
    "local_1"."PostalGeolocation"."GeoState" AS "geolocation_state"
FROM "local_1"."PostalGeolocation";

-- Reconstruct olist_order_items from vertical split + row partition on a fragment
CREATE VIEW "olist_order_items" AS
SELECT t0.[ord_id], t0.[ord_itm_id], t0.[prod_id], t1.[slr_id], t0.[ship_limit_dt], t0.[itm_price], t0.[frt_val]
FROM (
SELECT [ord_itm_frt_gt_13_08_le_16_26].[__orig_rowid] AS __orig_rowid, [local_3].[ord_itm_frt_gt_13_08_le_16_26].[ord_id], [local_3].[ord_itm_frt_gt_13_08_le_16_26].[ord_itm_id], [local_3].[ord_itm_frt_gt_13_08_le_16_26].[prod_id], [local_3].[ord_itm_frt_gt_13_08_le_16_26].[ship_limit_dt], [local_3].[ord_itm_frt_gt_13_08_le_16_26].[itm_price], [local_3].[ord_itm_frt_gt_13_08_le_16_26].[frt_val] FROM [local_3].[ord_itm_frt_gt_13_08_le_16_26]
UNION
SELECT [ord_itm_frt_gt_16_26_le_21_15].[__orig_rowid] AS __orig_rowid, [local_3].[ord_itm_frt_gt_16_26_le_21_15].[ord_id], [local_3].[ord_itm_frt_gt_16_26_le_21_15].[ord_itm_id], [local_3].[ord_itm_frt_gt_16_26_le_21_15].[prod_id], [local_3].[ord_itm_frt_gt_16_26_le_21_15].[ship_limit_dt], [local_3].[ord_itm_frt_gt_16_26_le_21_15].[itm_price], [local_3].[ord_itm_frt_gt_16_26_le_21_15].[frt_val] FROM [local_3].[ord_itm_frt_gt_16_26_le_21_15]
UNION
SELECT [ord_itm_frt_gt_21_15_or_null].[__orig_rowid] AS __orig_rowid, [local_3].[ord_itm_frt_gt_21_15_or_null].[ord_id], [local_3].[ord_itm_frt_gt_21_15_or_null].[ord_itm_id], [local_3].[ord_itm_frt_gt_21_15_or_null].[prod_id], [local_3].[ord_itm_frt_gt_21_15_or_null].[ship_limit_dt], [local_3].[ord_itm_frt_gt_21_15_or_null].[itm_price], [local_3].[ord_itm_frt_gt_21_15_or_null].[frt_val] FROM [local_3].[ord_itm_frt_gt_21_15_or_null]
UNION
SELECT [ord_itm_frt_le_13_08].[__orig_rowid] AS __orig_rowid, [local_3].[ord_itm_frt_le_13_08].[ord_id], [local_3].[ord_itm_frt_le_13_08].[ord_itm_id], [local_3].[ord_itm_frt_le_13_08].[prod_id], [local_3].[ord_itm_frt_le_13_08].[ship_limit_dt], [local_3].[ord_itm_frt_le_13_08].[itm_price], [local_3].[ord_itm_frt_le_13_08].[frt_val] FROM [local_3].[ord_itm_frt_le_13_08]
) t0
JOIN [local_3].[ord_itm_prod_slr_ship_limit] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct olist_order_payments from row partitions (UNION (overlap))
CREATE VIEW "olist_order_payments" AS
SELECT "local_1"."OrderPaymentsSingleInstallment"."OrderId" AS "order_id", "local_1"."OrderPaymentsSingleInstallment"."PaymentSequence" AS "payment_sequential", "local_1"."OrderPaymentsSingleInstallment"."PaymentMethod" AS "payment_type", "local_1"."OrderPaymentsSingleInstallment"."InstallmentCount" AS "payment_installments", "local_1"."OrderPaymentsSingleInstallment"."PaymentAmount" AS "payment_value" FROM "local_1"."OrderPaymentsSingleInstallment"
UNION
SELECT "local_1"."OrderPaymentsTwoInstallments"."OrderId" AS "order_id", "local_1"."OrderPaymentsTwoInstallments"."PaymentSequence" AS "payment_sequential", "local_1"."OrderPaymentsTwoInstallments"."PaymentMethod" AS "payment_type", "local_1"."OrderPaymentsTwoInstallments"."InstallmentCount" AS "payment_installments", "local_1"."OrderPaymentsTwoInstallments"."PaymentAmount" AS "payment_value" FROM "local_1"."OrderPaymentsTwoInstallments"
UNION
SELECT "local_1"."OrderPaymentsThreeInstallments"."OrderId" AS "order_id", "local_1"."OrderPaymentsThreeInstallments"."PaymentSequence" AS "payment_sequential", "local_1"."OrderPaymentsThreeInstallments"."PaymentMethod" AS "payment_type", "local_1"."OrderPaymentsThreeInstallments"."InstallmentCount" AS "payment_installments", "local_1"."OrderPaymentsThreeInstallments"."PaymentAmount" AS "payment_value" FROM "local_1"."OrderPaymentsThreeInstallments"
UNION
SELECT "local_1"."OrderPaymentsInstallmentsFourFiveEight"."OrderId" AS "order_id", "local_1"."OrderPaymentsInstallmentsFourFiveEight"."PaymentSequence" AS "payment_sequential", "local_1"."OrderPaymentsInstallmentsFourFiveEight"."PaymentMethod" AS "payment_type", "local_1"."OrderPaymentsInstallmentsFourFiveEight"."InstallmentCount" AS "payment_installments", "local_1"."OrderPaymentsInstallmentsFourFiveEight"."PaymentAmount" AS "payment_value" FROM "local_1"."OrderPaymentsInstallmentsFourFiveEight"
UNION
SELECT "local_1"."OrderPaymentsInstallmentsTenSixSevenAndOther"."OrderId" AS "order_id", "local_1"."OrderPaymentsInstallmentsTenSixSevenAndOther"."PaymentSequence" AS "payment_sequential", "local_1"."OrderPaymentsInstallmentsTenSixSevenAndOther"."PaymentMethod" AS "payment_type", "local_1"."OrderPaymentsInstallmentsTenSixSevenAndOther"."InstallmentCount" AS "payment_installments", "local_1"."OrderPaymentsInstallmentsTenSixSevenAndOther"."PaymentAmount" AS "payment_value" FROM "local_1"."OrderPaymentsInstallmentsTenSixSevenAndOther";

-- Reconstruct olist_order_reviews from row partitions (UNION (overlap))
CREATE VIEW "olist_order_reviews" AS
SELECT "local_1"."OrderReviewsUpTo20170923"."ReviewId" AS "review_id", "local_1"."OrderReviewsUpTo20170923"."OrderId" AS "order_id", "local_1"."OrderReviewsUpTo20170923"."ReviewScore" AS "review_score", "local_1"."OrderReviewsUpTo20170923"."ReviewTitle" AS "review_comment_title", "local_1"."OrderReviewsUpTo20170923"."ReviewMessage" AS "review_comment_message", "local_1"."OrderReviewsUpTo20170923"."CreatedAt" AS "review_creation_date", "local_1"."OrderReviewsUpTo20170923"."AnsweredAt" AS "review_answer_timestamp" FROM "local_1"."OrderReviewsUpTo20170923"
UNION
SELECT "local_1"."OrderReviews20170924To20180202"."ReviewId" AS "review_id", "local_1"."OrderReviews20170924To20180202"."OrderId" AS "order_id", "local_1"."OrderReviews20170924To20180202"."ReviewScore" AS "review_score", "local_1"."OrderReviews20170924To20180202"."ReviewTitle" AS "review_comment_title", "local_1"."OrderReviews20170924To20180202"."ReviewMessage" AS "review_comment_message", "local_1"."OrderReviews20170924To20180202"."CreatedAt" AS "review_creation_date", "local_1"."OrderReviews20170924To20180202"."AnsweredAt" AS "review_answer_timestamp" FROM "local_1"."OrderReviews20170924To20180202"
UNION
SELECT "local_1"."OrderReviews20180203To20180516"."ReviewId" AS "review_id", "local_1"."OrderReviews20180203To20180516"."OrderId" AS "order_id", "local_1"."OrderReviews20180203To20180516"."ReviewScore" AS "review_score", "local_1"."OrderReviews20180203To20180516"."ReviewTitle" AS "review_comment_title", "local_1"."OrderReviews20180203To20180516"."ReviewMessage" AS "review_comment_message", "local_1"."OrderReviews20180203To20180516"."CreatedAt" AS "review_creation_date", "local_1"."OrderReviews20180203To20180516"."AnsweredAt" AS "review_answer_timestamp" FROM "local_1"."OrderReviews20180203To20180516"
UNION
SELECT "local_1"."OrderReviewsAfter20180516OrNull"."ReviewId" AS "review_id", "local_1"."OrderReviewsAfter20180516OrNull"."OrderId" AS "order_id", "local_1"."OrderReviewsAfter20180516OrNull"."ReviewScore" AS "review_score", "local_1"."OrderReviewsAfter20180516OrNull"."ReviewTitle" AS "review_comment_title", "local_1"."OrderReviewsAfter20180516OrNull"."ReviewMessage" AS "review_comment_message", "local_1"."OrderReviewsAfter20180516OrNull"."CreatedAt" AS "review_creation_date", "local_1"."OrderReviewsAfter20180516OrNull"."AnsweredAt" AS "review_answer_timestamp" FROM "local_1"."OrderReviewsAfter20180516OrNull";

-- Reconstruct olist_orders from local_1.CustomerOrders
CREATE VIEW "olist_orders" AS
SELECT
    "local_1"."CustomerOrders"."OrderId" AS "order_id",
    "local_1"."CustomerOrders"."CustomerId" AS "customer_id",
    "local_1"."CustomerOrders"."Status" AS "order_status",
    "local_1"."CustomerOrders"."PurchasedAt" AS "order_purchase_timestamp",
    "local_1"."CustomerOrders"."ApprovedAt" AS "order_approved_at",
    "local_1"."CustomerOrders"."CarrierDeliveryAt" AS "order_delivered_carrier_date",
    "local_1"."CustomerOrders"."DeliveredToCustomerAt" AS "order_delivered_customer_date",
    "local_1"."CustomerOrders"."EstimatedDeliveryAt" AS "order_estimated_delivery_date"
FROM "local_1"."CustomerOrders";

-- Reconstruct olist_products from vertical split + row partition on a fragment
CREATE VIEW "olist_products" AS
SELECT t0.[product_sku], t0.[category_label], t0.[name_length_chars], t0.[description_length_chars], t0.[photo_count], t0.[weight_grams], t1.[length_cm_value], t1.[height_cm_value], t1.[width_cm_value]
FROM (
SELECT [products_master_automotive_and_it_accessories].[__orig_rowid] AS __orig_rowid, [local_2].[products_master_automotive_and_it_accessories].[product_sku], [local_2].[products_master_automotive_and_it_accessories].[category_label], [local_2].[products_master_automotive_and_it_accessories].[name_length_chars], [local_2].[products_master_automotive_and_it_accessories].[description_length_chars], [local_2].[products_master_automotive_and_it_accessories].[photo_count], [local_2].[products_master_automotive_and_it_accessories].[weight_grams] FROM [local_2].[products_master_automotive_and_it_accessories]
UNION
SELECT [products_master_beauty_health_and_household].[__orig_rowid] AS __orig_rowid, [local_2].[products_master_beauty_health_and_household].[product_sku], [local_2].[products_master_beauty_health_and_household].[category_label], [local_2].[products_master_beauty_health_and_household].[name_length_chars], [local_2].[products_master_beauty_health_and_household].[description_length_chars], [local_2].[products_master_beauty_health_and_household].[photo_count], [local_2].[products_master_beauty_health_and_household].[weight_grams] FROM [local_2].[products_master_beauty_health_and_household]
UNION
SELECT [products_master_bed_bath_and_sports].[__orig_rowid] AS __orig_rowid, [local_2].[products_master_bed_bath_and_sports].[product_sku], [local_2].[products_master_bed_bath_and_sports].[category_label], [local_2].[products_master_bed_bath_and_sports].[name_length_chars], [local_2].[products_master_bed_bath_and_sports].[description_length_chars], [local_2].[products_master_bed_bath_and_sports].[photo_count], [local_2].[products_master_bed_bath_and_sports].[weight_grams] FROM [local_2].[products_master_bed_bath_and_sports]
UNION
SELECT [products_master_furniture_toys_and_gifts].[__orig_rowid] AS __orig_rowid, [local_2].[products_master_furniture_toys_and_gifts].[product_sku], [local_2].[products_master_furniture_toys_and_gifts].[category_label], [local_2].[products_master_furniture_toys_and_gifts].[name_length_chars], [local_2].[products_master_furniture_toys_and_gifts].[description_length_chars], [local_2].[products_master_furniture_toys_and_gifts].[photo_count], [local_2].[products_master_furniture_toys_and_gifts].[weight_grams] FROM [local_2].[products_master_furniture_toys_and_gifts]
UNION
SELECT [products_master_other].[__orig_rowid] AS __orig_rowid, [local_2].[products_master_other].[product_sku], [local_2].[products_master_other].[category_label], [local_2].[products_master_other].[name_length_chars], [local_2].[products_master_other].[description_length_chars], [local_2].[products_master_other].[photo_count], [local_2].[products_master_other].[weight_grams] FROM [local_2].[products_master_other]
) t0
JOIN [local_2].[products_master_dimensions] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct olist_products_dataset from vertical split + row partition on a fragment
CREATE VIEW "olist_products_dataset" AS
SELECT t0.[dataset_index], t0.[product_sku], t0.[category_label], t0.[name_length_chars], t0.[description_length_chars], t0.[photo_count], t0.[weight_grams], t1.[length_cm_value], t1.[height_cm_value], t1.[width_cm_value]
FROM (
SELECT [products_dataset_index_automotive_and_it_accessories].[__orig_rowid] AS __orig_rowid, [local_2].[products_dataset_index_automotive_and_it_accessories].[dataset_index], [local_2].[products_dataset_index_automotive_and_it_accessories].[product_sku], [local_2].[products_dataset_index_automotive_and_it_accessories].[category_label], [local_2].[products_dataset_index_automotive_and_it_accessories].[name_length_chars], [local_2].[products_dataset_index_automotive_and_it_accessories].[description_length_chars], [local_2].[products_dataset_index_automotive_and_it_accessories].[photo_count], [local_2].[products_dataset_index_automotive_and_it_accessories].[weight_grams] FROM [local_2].[products_dataset_index_automotive_and_it_accessories]
UNION
SELECT [products_dataset_index_beauty_health_and_household].[__orig_rowid] AS __orig_rowid, [local_2].[products_dataset_index_beauty_health_and_household].[dataset_index], [local_2].[products_dataset_index_beauty_health_and_household].[product_sku], [local_2].[products_dataset_index_beauty_health_and_household].[category_label], [local_2].[products_dataset_index_beauty_health_and_household].[name_length_chars], [local_2].[products_dataset_index_beauty_health_and_household].[description_length_chars], [local_2].[products_dataset_index_beauty_health_and_household].[photo_count], [local_2].[products_dataset_index_beauty_health_and_household].[weight_grams] FROM [local_2].[products_dataset_index_beauty_health_and_household]
UNION
SELECT [products_dataset_index_bed_bath_and_sports].[__orig_rowid] AS __orig_rowid, [local_2].[products_dataset_index_bed_bath_and_sports].[dataset_index], [local_2].[products_dataset_index_bed_bath_and_sports].[product_sku], [local_2].[products_dataset_index_bed_bath_and_sports].[category_label], [local_2].[products_dataset_index_bed_bath_and_sports].[name_length_chars], [local_2].[products_dataset_index_bed_bath_and_sports].[description_length_chars], [local_2].[products_dataset_index_bed_bath_and_sports].[photo_count], [local_2].[products_dataset_index_bed_bath_and_sports].[weight_grams] FROM [local_2].[products_dataset_index_bed_bath_and_sports]
UNION
SELECT [products_dataset_index_furniture_toys_and_gifts].[__orig_rowid] AS __orig_rowid, [local_2].[products_dataset_index_furniture_toys_and_gifts].[dataset_index], [local_2].[products_dataset_index_furniture_toys_and_gifts].[product_sku], [local_2].[products_dataset_index_furniture_toys_and_gifts].[category_label], [local_2].[products_dataset_index_furniture_toys_and_gifts].[name_length_chars], [local_2].[products_dataset_index_furniture_toys_and_gifts].[description_length_chars], [local_2].[products_dataset_index_furniture_toys_and_gifts].[photo_count], [local_2].[products_dataset_index_furniture_toys_and_gifts].[weight_grams] FROM [local_2].[products_dataset_index_furniture_toys_and_gifts]
UNION
SELECT [products_dataset_index_other].[__orig_rowid] AS __orig_rowid, [local_2].[products_dataset_index_other].[dataset_index], [local_2].[products_dataset_index_other].[product_sku], [local_2].[products_dataset_index_other].[category_label], [local_2].[products_dataset_index_other].[name_length_chars], [local_2].[products_dataset_index_other].[description_length_chars], [local_2].[products_dataset_index_other].[photo_count], [local_2].[products_dataset_index_other].[weight_grams] FROM [local_2].[products_dataset_index_other]
) t0
JOIN [local_2].[products_dataset_index_dimensions] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct olist_sellers from row partitions (UNION (overlap))
CREATE VIEW "olist_sellers" AS
SELECT "local_3"."slr_city_sao_paulo"."slr_id" AS "seller_id", "local_3"."slr_city_sao_paulo"."slr_zip_pref" AS "seller_zip_code_prefix", "local_3"."slr_city_sao_paulo"."slr_city" AS "seller_city", "local_3"."slr_city_sao_paulo"."slr_state" AS "seller_state" FROM "local_3"."slr_city_sao_paulo"
UNION
SELECT "local_3"."slr_city_curitiba_rio_santo_andre_campinas_belo_horizonte_ribeirao_preto_guarulhos_ibitinga"."slr_id" AS "seller_id", "local_3"."slr_city_curitiba_rio_santo_andre_campinas_belo_horizonte_ribeirao_preto_guarulhos_ibitinga"."slr_zip_pref" AS "seller_zip_code_prefix", "local_3"."slr_city_curitiba_rio_santo_andre_campinas_belo_horizonte_ribeirao_preto_guarulhos_ibitinga"."slr_city" AS "seller_city", "local_3"."slr_city_curitiba_rio_santo_andre_campinas_belo_horizonte_ribeirao_preto_guarulhos_ibitinga"."slr_state" AS "seller_state" FROM "local_3"."slr_city_curitiba_rio_santo_andre_campinas_belo_horizonte_ribeirao_preto_guarulhos_ibitinga"
UNION
SELECT "local_3"."slr_city_other_or_null"."slr_id" AS "seller_id", "local_3"."slr_city_other_or_null"."slr_zip_pref" AS "seller_zip_code_prefix", "local_3"."slr_city_other_or_null"."slr_city" AS "seller_city", "local_3"."slr_city_other_or_null"."slr_state" AS "seller_state" FROM "local_3"."slr_city_other_or_null";

-- Reconstruct product_category_name_translation from local_2.category_translation_map
CREATE VIEW "product_category_name_translation" AS
SELECT
    "local_2"."category_translation_map"."category_label_original" AS "product_category_name",
    "local_2"."category_translation_map"."category_label_english" AS "product_category_name_english"
FROM "local_2"."category_translation_map";
