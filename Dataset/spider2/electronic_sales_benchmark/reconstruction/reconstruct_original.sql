-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct customers from row partitions (UNION (overlap))
CREATE VIEW "customers" AS
SELECT "local_1"."CustomersSaoPaulo"."RowIndex" AS "index", "local_1"."CustomersSaoPaulo"."CustomerIdentifier" AS "customer_id", "local_1"."CustomersSaoPaulo"."CustomerUniqueIdentifier" AS "customer_unique_id", "local_1"."CustomersSaoPaulo"."PostalCodePrefix" AS "customer_zip_code_prefix", "local_1"."CustomersSaoPaulo"."CityName" AS "customer_city", "local_1"."CustomersSaoPaulo"."StateCode" AS "customer_state" FROM "local_1"."CustomersSaoPaulo"
UNION
SELECT "local_1"."CustomersMajorMetroCities"."RowIndex" AS "index", "local_1"."CustomersMajorMetroCities"."CustomerIdentifier" AS "customer_id", "local_1"."CustomersMajorMetroCities"."CustomerUniqueIdentifier" AS "customer_unique_id", "local_1"."CustomersMajorMetroCities"."PostalCodePrefix" AS "customer_zip_code_prefix", "local_1"."CustomersMajorMetroCities"."CityName" AS "customer_city", "local_1"."CustomersMajorMetroCities"."StateCode" AS "customer_state" FROM "local_1"."CustomersMajorMetroCities"
UNION
SELECT "local_1"."CustomersOtherOrUnknownCities"."RowIndex" AS "index", "local_1"."CustomersOtherOrUnknownCities"."CustomerIdentifier" AS "customer_id", "local_1"."CustomersOtherOrUnknownCities"."CustomerUniqueIdentifier" AS "customer_unique_id", "local_1"."CustomersOtherOrUnknownCities"."PostalCodePrefix" AS "customer_zip_code_prefix", "local_1"."CustomersOtherOrUnknownCities"."CityName" AS "customer_city", "local_1"."CustomersOtherOrUnknownCities"."StateCode" AS "customer_state" FROM "local_1"."CustomersOtherOrUnknownCities";

-- Reconstruct geolocation from row partitions (UNION (overlap))
CREATE VIEW "geolocation" AS
SELECT "local_1"."GeoLocationsSaoPaulo"."RowIndex" AS "index", "local_1"."GeoLocationsSaoPaulo"."PostalCodePrefix" AS "geolocation_zip_code_prefix", "local_1"."GeoLocationsSaoPaulo"."Latitude" AS "geolocation_lat", "local_1"."GeoLocationsSaoPaulo"."Longitude" AS "geolocation_lng", "local_1"."GeoLocationsSaoPaulo"."CityName" AS "geolocation_city", "local_1"."GeoLocationsSaoPaulo"."StateCode" AS "geolocation_state" FROM "local_1"."GeoLocationsSaoPaulo"
UNION
SELECT "local_1"."GeoLocationsOtherOrUnknownCities"."RowIndex" AS "index", "local_1"."GeoLocationsOtherOrUnknownCities"."PostalCodePrefix" AS "geolocation_zip_code_prefix", "local_1"."GeoLocationsOtherOrUnknownCities"."Latitude" AS "geolocation_lat", "local_1"."GeoLocationsOtherOrUnknownCities"."Longitude" AS "geolocation_lng", "local_1"."GeoLocationsOtherOrUnknownCities"."CityName" AS "geolocation_city", "local_1"."GeoLocationsOtherOrUnknownCities"."StateCode" AS "geolocation_state" FROM "local_1"."GeoLocationsOtherOrUnknownCities"
UNION
SELECT "local_3"."geolocationSelectedCities"."recordId" AS "index", "local_3"."geolocationSelectedCities"."zipCodePrefix" AS "geolocation_zip_code_prefix", "local_3"."geolocationSelectedCities"."latitude" AS "geolocation_lat", "local_3"."geolocationSelectedCities"."longitude" AS "geolocation_lng", "local_3"."geolocationSelectedCities"."city" AS "geolocation_city", "local_3"."geolocationSelectedCities"."state" AS "geolocation_state" FROM "local_3"."geolocationSelectedCities";

-- Reconstruct order_items from vertical split + row partition on a fragment
CREATE VIEW "order_items" AS
SELECT t0.[recordId], t1.[OrderIdentifier], t0.[orderItemId], t1.[ProductIdentifier], t1.[SellerIdentifier], t0.[shippingLimitDate], t0.[itemPrice], t0.[freightValue]
FROM [local_3].[orderItemsWithFreightValue] t0
JOIN (
SELECT [OrderItemsPriceRange39_9To74_99].[__orig_rowid] AS __orig_rowid, [local_1].[OrderItemsPriceRange39_9To74_99].[RowIndex], [local_1].[OrderItemsPriceRange39_9To74_99].[OrderIdentifier], [local_1].[OrderItemsPriceRange39_9To74_99].[OrderItemSequence], [local_1].[OrderItemsPriceRange39_9To74_99].[ProductIdentifier], [local_1].[OrderItemsPriceRange39_9To74_99].[SellerIdentifier], [local_1].[OrderItemsPriceRange39_9To74_99].[ShippingLimitTimestamp], [local_1].[OrderItemsPriceRange39_9To74_99].[Price] FROM [local_1].[OrderItemsPriceRange39_9To74_99]
UNION
SELECT [OrderItemsPriceRange74_99To134_9].[__orig_rowid] AS __orig_rowid, [local_1].[OrderItemsPriceRange74_99To134_9].[RowIndex], [local_1].[OrderItemsPriceRange74_99To134_9].[OrderIdentifier], [local_1].[OrderItemsPriceRange74_99To134_9].[OrderItemSequence], [local_1].[OrderItemsPriceRange74_99To134_9].[ProductIdentifier], [local_1].[OrderItemsPriceRange74_99To134_9].[SellerIdentifier], [local_1].[OrderItemsPriceRange74_99To134_9].[ShippingLimitTimestamp], [local_1].[OrderItemsPriceRange74_99To134_9].[Price] FROM [local_1].[OrderItemsPriceRange74_99To134_9]
UNION
SELECT [orderItemsPriceAbove134Point9OrNull].[__orig_rowid] AS __orig_rowid, [local_3].[orderItemsPriceAbove134Point9OrNull].[recordId], [local_3].[orderItemsPriceAbove134Point9OrNull].[orderId], [local_3].[orderItemsPriceAbove134Point9OrNull].[orderItemId], [local_3].[orderItemsPriceAbove134Point9OrNull].[productId], [local_3].[orderItemsPriceAbove134Point9OrNull].[sellerId], [local_3].[orderItemsPriceAbove134Point9OrNull].[shippingLimitDate], [local_3].[orderItemsPriceAbove134Point9OrNull].[itemPrice] FROM [local_3].[orderItemsPriceAbove134Point9OrNull]
UNION
SELECT [orderItemsPriceAtMost39Point9].[__orig_rowid] AS __orig_rowid, [local_3].[orderItemsPriceAtMost39Point9].[recordId], [local_3].[orderItemsPriceAtMost39Point9].[orderId], [local_3].[orderItemsPriceAtMost39Point9].[orderItemId], [local_3].[orderItemsPriceAtMost39Point9].[productId], [local_3].[orderItemsPriceAtMost39Point9].[sellerId], [local_3].[orderItemsPriceAtMost39Point9].[shippingLimitDate], [local_3].[orderItemsPriceAtMost39Point9].[itemPrice] FROM [local_3].[orderItemsPriceAtMost39Point9]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct order_payments from row partitions (UNION (overlap))
CREATE VIEW "order_payments" AS
SELECT "local_1"."PaymentsSingleInstallment"."RowIndex" AS "index", "local_1"."PaymentsSingleInstallment"."OrderIdentifier" AS "order_id", "local_1"."PaymentsSingleInstallment"."PaymentSequence" AS "payment_sequential", "local_1"."PaymentsSingleInstallment"."PaymentMethod" AS "payment_type", "local_1"."PaymentsSingleInstallment"."PaymentInstallments" AS "payment_installments", "local_1"."PaymentsSingleInstallment"."PaymentAmount" AS "payment_value" FROM "local_1"."PaymentsSingleInstallment"
UNION
SELECT "local_1"."PaymentsInstallmentsUpTo4"."RowIndex" AS "index", "local_1"."PaymentsInstallmentsUpTo4"."OrderIdentifier" AS "order_id", "local_1"."PaymentsInstallmentsUpTo4"."PaymentSequence" AS "payment_sequential", "local_1"."PaymentsInstallmentsUpTo4"."PaymentMethod" AS "payment_type", "local_1"."PaymentsInstallmentsUpTo4"."PaymentInstallments" AS "payment_installments", "local_1"."PaymentsInstallmentsUpTo4"."PaymentAmount" AS "payment_value" FROM "local_1"."PaymentsInstallmentsUpTo4"
UNION
SELECT "local_1"."PaymentsInstallmentsMoreThan4OrNull"."RowIndex" AS "index", "local_1"."PaymentsInstallmentsMoreThan4OrNull"."OrderIdentifier" AS "order_id", "local_1"."PaymentsInstallmentsMoreThan4OrNull"."PaymentSequence" AS "payment_sequential", "local_1"."PaymentsInstallmentsMoreThan4OrNull"."PaymentMethod" AS "payment_type", "local_1"."PaymentsInstallmentsMoreThan4OrNull"."PaymentInstallments" AS "payment_installments", "local_1"."PaymentsInstallmentsMoreThan4OrNull"."PaymentAmount" AS "payment_value" FROM "local_1"."PaymentsInstallmentsMoreThan4OrNull";

-- Reconstruct order_reviews from row partitions (UNION (overlap))
CREATE VIEW "order_reviews" AS
SELECT "local_1"."OrderReviewsOnOrBefore2017_09_23"."RowIndex" AS "index", "local_1"."OrderReviewsOnOrBefore2017_09_23"."ReviewIdentifier" AS "review_id", "local_1"."OrderReviewsOnOrBefore2017_09_23"."OrderIdentifier" AS "order_id", "local_1"."OrderReviewsOnOrBefore2017_09_23"."ReviewScore" AS "review_score", "local_1"."OrderReviewsOnOrBefore2017_09_23"."ReviewTitle" AS "review_comment_title", "local_1"."OrderReviewsOnOrBefore2017_09_23"."ReviewMessage" AS "review_comment_message", "local_1"."OrderReviewsOnOrBefore2017_09_23"."ReviewCreationTimestamp" AS "review_creation_date", "local_1"."OrderReviewsOnOrBefore2017_09_23"."ReviewResponseTimestamp" AS "review_answer_timestamp" FROM "local_1"."OrderReviewsOnOrBefore2017_09_23"
UNION
SELECT "local_1"."OrderReviews2017_09_23To2018_02_02"."RowIndex" AS "index", "local_1"."OrderReviews2017_09_23To2018_02_02"."ReviewIdentifier" AS "review_id", "local_1"."OrderReviews2017_09_23To2018_02_02"."OrderIdentifier" AS "order_id", "local_1"."OrderReviews2017_09_23To2018_02_02"."ReviewScore" AS "review_score", "local_1"."OrderReviews2017_09_23To2018_02_02"."ReviewTitle" AS "review_comment_title", "local_1"."OrderReviews2017_09_23To2018_02_02"."ReviewMessage" AS "review_comment_message", "local_1"."OrderReviews2017_09_23To2018_02_02"."ReviewCreationTimestamp" AS "review_creation_date", "local_1"."OrderReviews2017_09_23To2018_02_02"."ReviewResponseTimestamp" AS "review_answer_timestamp" FROM "local_1"."OrderReviews2017_09_23To2018_02_02"
UNION
SELECT "local_1"."OrderReviews2018_02_02To2018_05_16"."RowIndex" AS "index", "local_1"."OrderReviews2018_02_02To2018_05_16"."ReviewIdentifier" AS "review_id", "local_1"."OrderReviews2018_02_02To2018_05_16"."OrderIdentifier" AS "order_id", "local_1"."OrderReviews2018_02_02To2018_05_16"."ReviewScore" AS "review_score", "local_1"."OrderReviews2018_02_02To2018_05_16"."ReviewTitle" AS "review_comment_title", "local_1"."OrderReviews2018_02_02To2018_05_16"."ReviewMessage" AS "review_comment_message", "local_1"."OrderReviews2018_02_02To2018_05_16"."ReviewCreationTimestamp" AS "review_creation_date", "local_1"."OrderReviews2018_02_02To2018_05_16"."ReviewResponseTimestamp" AS "review_answer_timestamp" FROM "local_1"."OrderReviews2018_02_02To2018_05_16"
UNION
SELECT "local_1"."OrderReviewsAfter2018_05_16OrNull"."RowIndex" AS "index", "local_1"."OrderReviewsAfter2018_05_16OrNull"."ReviewIdentifier" AS "review_id", "local_1"."OrderReviewsAfter2018_05_16OrNull"."OrderIdentifier" AS "order_id", "local_1"."OrderReviewsAfter2018_05_16OrNull"."ReviewScore" AS "review_score", "local_1"."OrderReviewsAfter2018_05_16OrNull"."ReviewTitle" AS "review_comment_title", "local_1"."OrderReviewsAfter2018_05_16OrNull"."ReviewMessage" AS "review_comment_message", "local_1"."OrderReviewsAfter2018_05_16OrNull"."ReviewCreationTimestamp" AS "review_creation_date", "local_1"."OrderReviewsAfter2018_05_16OrNull"."ReviewResponseTimestamp" AS "review_answer_timestamp" FROM "local_1"."OrderReviewsAfter2018_05_16OrNull";

-- Reconstruct orders from local_1.OrdersMasterRecords
CREATE VIEW "orders" AS
SELECT
    "local_1"."OrdersMasterRecords"."RowIndex" AS "index",
    "local_1"."OrdersMasterRecords"."OrderIdentifier" AS "order_id",
    "local_1"."OrdersMasterRecords"."CustomerIdentifier" AS "customer_id",
    "local_1"."OrdersMasterRecords"."OrderStatus" AS "order_status",
    "local_1"."OrdersMasterRecords"."PurchaseTimestamp" AS "order_purchase_timestamp",
    "local_1"."OrdersMasterRecords"."ApprovalTimestamp" AS "order_approved_at",
    "local_1"."OrdersMasterRecords"."CarrierDeliveryTimestamp" AS "order_delivered_carrier_date",
    "local_1"."OrdersMasterRecords"."CustomerDeliveryTimestamp" AS "order_delivered_customer_date",
    "local_1"."OrdersMasterRecords"."EstimatedDeliveryTimestamp" AS "order_estimated_delivery_date"
FROM "local_1"."OrdersMasterRecords";

-- Reconstruct product_category_name_translation from local_2.cat_name_xlat
CREATE VIEW "product_category_name_translation" AS
SELECT
    "local_2"."cat_name_xlat"."xlat_idx" AS "index",
    "local_2"."cat_name_xlat"."cat_label_src" AS "product_category_name",
    "local_2"."cat_name_xlat"."cat_label_en" AS "product_category_name_english"
FROM "local_2"."cat_name_xlat";

-- Reconstruct products from vertical (column) split (2 fragments)
CREATE VIEW "products" AS
SELECT
    t0."ent_idx" AS "index",
    t0."prod_id" AS "product_id",
    t0."cat_label" AS "product_category_name",
    t1."name_len" AS "product_name_lenght",
    t1."desc_len" AS "product_description_lenght",
    t0."photo_cnt" AS "product_photos_qty",
    t0."wt_g" AS "product_weight_g",
    t0."len_cm" AS "product_length_cm",
    t0."ht_cm" AS "product_height_cm",
    t0."wdth_cm" AS "product_width_cm"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "prod_id" ORDER BY rowid) AS __rn FROM "local_2"."prod_idx_dims") t0
JOIN "local_2"."prod_idx_stats" t1 ON t0."prod_id" IS t1."prod_id" AND t0.__rn = t1.__rn;

-- Reconstruct sellers from row partitions (UNION (overlap))
CREATE VIEW "sellers" AS
SELECT "local_3"."sellersSaoPaulo"."recordId" AS "index", "local_3"."sellersSaoPaulo"."sellerId" AS "seller_id", "local_3"."sellersSaoPaulo"."zipCodePrefix" AS "seller_zip_code_prefix", "local_3"."sellersSaoPaulo"."city" AS "seller_city", "local_3"."sellersSaoPaulo"."state" AS "seller_state" FROM "local_3"."sellersSaoPaulo"
UNION
SELECT "local_3"."sellersSelectedRegionalCities"."recordId" AS "index", "local_3"."sellersSelectedRegionalCities"."sellerId" AS "seller_id", "local_3"."sellersSelectedRegionalCities"."zipCodePrefix" AS "seller_zip_code_prefix", "local_3"."sellersSelectedRegionalCities"."city" AS "seller_city", "local_3"."sellersSelectedRegionalCities"."state" AS "seller_state" FROM "local_3"."sellersSelectedRegionalCities"
UNION
SELECT "local_3"."sellersOtherAndUnknownCities"."recordId" AS "index", "local_3"."sellersOtherAndUnknownCities"."sellerId" AS "seller_id", "local_3"."sellersOtherAndUnknownCities"."zipCodePrefix" AS "seller_zip_code_prefix", "local_3"."sellersOtherAndUnknownCities"."city" AS "seller_city", "local_3"."sellersOtherAndUnknownCities"."state" AS "seller_state" FROM "local_3"."sellersOtherAndUnknownCities";
