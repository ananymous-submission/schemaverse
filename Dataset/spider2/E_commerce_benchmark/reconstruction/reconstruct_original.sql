-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct customers from row partitions (UNION (overlap))
CREATE VIEW "customers" AS
SELECT "local_1"."CustomersInSaoPaulo"."CustomerIdentifier" AS "customer_id", "local_1"."CustomersInSaoPaulo"."CustomerExternalId" AS "customer_unique_id", "local_1"."CustomersInSaoPaulo"."ZipCodePrefix" AS "customer_zip_code_prefix", "local_1"."CustomersInSaoPaulo"."CityName" AS "customer_city", "local_1"."CustomersInSaoPaulo"."StateCode" AS "customer_state" FROM "local_1"."CustomersInSaoPaulo"
UNION
SELECT "local_1"."CustomersInRioDeJaneiroBeloHorizonteSalvadorGuarulhosBrasiliaCuritibaCampinasPortoAlegre"."CustomerIdentifier" AS "customer_id", "local_1"."CustomersInRioDeJaneiroBeloHorizonteSalvadorGuarulhosBrasiliaCuritibaCampinasPortoAlegre"."CustomerExternalId" AS "customer_unique_id", "local_1"."CustomersInRioDeJaneiroBeloHorizonteSalvadorGuarulhosBrasiliaCuritibaCampinasPortoAlegre"."ZipCodePrefix" AS "customer_zip_code_prefix", "local_1"."CustomersInRioDeJaneiroBeloHorizonteSalvadorGuarulhosBrasiliaCuritibaCampinasPortoAlegre"."CityName" AS "customer_city", "local_1"."CustomersInRioDeJaneiroBeloHorizonteSalvadorGuarulhosBrasiliaCuritibaCampinasPortoAlegre"."StateCode" AS "customer_state" FROM "local_1"."CustomersInRioDeJaneiroBeloHorizonteSalvadorGuarulhosBrasiliaCuritibaCampinasPortoAlegre"
UNION
SELECT "local_1"."CustomersOtherOrNull"."CustomerIdentifier" AS "customer_id", "local_1"."CustomersOtherOrNull"."CustomerExternalId" AS "customer_unique_id", "local_1"."CustomersOtherOrNull"."ZipCodePrefix" AS "customer_zip_code_prefix", "local_1"."CustomersOtherOrNull"."CityName" AS "customer_city", "local_1"."CustomersOtherOrNull"."StateCode" AS "customer_state" FROM "local_1"."CustomersOtherOrNull";

-- Reconstruct geolocation from local_1.ZipCodeGeolocation
CREATE VIEW "geolocation" AS
SELECT
    "local_1"."ZipCodeGeolocation"."ZipCodePrefix" AS "geolocation_zip_code_prefix",
    "local_1"."ZipCodeGeolocation"."Latitude" AS "geolocation_lat",
    "local_1"."ZipCodeGeolocation"."Longitude" AS "geolocation_lng",
    "local_1"."ZipCodeGeolocation"."CityName" AS "geolocation_city",
    "local_1"."ZipCodeGeolocation"."StateCode" AS "geolocation_state"
FROM "local_1"."ZipCodeGeolocation";

-- Reconstruct leads_closed from vertical split + row partition on a fragment
CREATE VIEW "leads_closed" AS
SELECT t0.[MqlIdentifier], t2.[SellerIdentifier], t2.[SdrIdentifier], t2.[SrIdentifier], t0.[WonDate], t0.[BusinessSegment], t0.[LeadType], t0.[LeadBehaviorProfile], t0.[HasCompanyFlag], t0.[HasGtinFlag], t0.[AverageStockLevel], t1.[BusinessType], t0.[DeclaredCatalogSize], t0.[DeclaredMonthlyRevenue]
FROM [local_1].[LeadsClosedWithAverageStock] t0
JOIN [local_1].[LeadsClosedByBusinessSegment] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [LeadsClosedForOtherSdrsOrNull].[__orig_rowid] AS __orig_rowid, [local_1].[LeadsClosedForOtherSdrsOrNull].[MqlIdentifier], [local_1].[LeadsClosedForOtherSdrsOrNull].[SellerIdentifier], [local_1].[LeadsClosedForOtherSdrsOrNull].[SdrIdentifier], [local_1].[LeadsClosedForOtherSdrsOrNull].[SrIdentifier] FROM [local_1].[LeadsClosedForOtherSdrsOrNull]
UNION
SELECT [LeadsClosedForSdr068066e24f0c643eb1d089c7dd20cd73AndSdr56bf83c4bb35763a51c2baab501b4c67].[__orig_rowid] AS __orig_rowid, [local_1].[LeadsClosedForSdr068066e24f0c643eb1d089c7dd20cd73AndSdr56bf83c4bb35763a51c2baab501b4c67].[MqlIdentifier], [local_1].[LeadsClosedForSdr068066e24f0c643eb1d089c7dd20cd73AndSdr56bf83c4bb35763a51c2baab501b4c67].[SellerIdentifier], [local_1].[LeadsClosedForSdr068066e24f0c643eb1d089c7dd20cd73AndSdr56bf83c4bb35763a51c2baab501b4c67].[SdrIdentifier], [local_1].[LeadsClosedForSdr068066e24f0c643eb1d089c7dd20cd73AndSdr56bf83c4bb35763a51c2baab501b4c67].[SrIdentifier] FROM [local_1].[LeadsClosedForSdr068066e24f0c643eb1d089c7dd20cd73AndSdr56bf83c4bb35763a51c2baab501b4c67]
UNION
SELECT [LeadsClosedForSdr370c9f455f93a9a96cbe9bea48e70033AndSdr09285259593c61296eef10c734121d5b].[__orig_rowid] AS __orig_rowid, [local_1].[LeadsClosedForSdr370c9f455f93a9a96cbe9bea48e70033AndSdr09285259593c61296eef10c734121d5b].[MqlIdentifier], [local_1].[LeadsClosedForSdr370c9f455f93a9a96cbe9bea48e70033AndSdr09285259593c61296eef10c734121d5b].[SellerIdentifier], [local_1].[LeadsClosedForSdr370c9f455f93a9a96cbe9bea48e70033AndSdr09285259593c61296eef10c734121d5b].[SdrIdentifier], [local_1].[LeadsClosedForSdr370c9f455f93a9a96cbe9bea48e70033AndSdr09285259593c61296eef10c734121d5b].[SrIdentifier] FROM [local_1].[LeadsClosedForSdr370c9f455f93a9a96cbe9bea48e70033AndSdr09285259593c61296eef10c734121d5b]
UNION
SELECT [LeadsClosedForSdr4b339f9567d060bcea4f5136b9f5949e].[__orig_rowid] AS __orig_rowid, [local_1].[LeadsClosedForSdr4b339f9567d060bcea4f5136b9f5949e].[MqlIdentifier], [local_1].[LeadsClosedForSdr4b339f9567d060bcea4f5136b9f5949e].[SellerIdentifier], [local_1].[LeadsClosedForSdr4b339f9567d060bcea4f5136b9f5949e].[SdrIdentifier], [local_1].[LeadsClosedForSdr4b339f9567d060bcea4f5136b9f5949e].[SrIdentifier] FROM [local_1].[LeadsClosedForSdr4b339f9567d060bcea4f5136b9f5949e]
UNION
SELECT [LeadsClosedForSdr9d12ef1a7eca3ec58c545c678af7869cAndSdra8387c01a09e99ce014107505b92388c].[__orig_rowid] AS __orig_rowid, [local_1].[LeadsClosedForSdr9d12ef1a7eca3ec58c545c678af7869cAndSdra8387c01a09e99ce014107505b92388c].[MqlIdentifier], [local_1].[LeadsClosedForSdr9d12ef1a7eca3ec58c545c678af7869cAndSdra8387c01a09e99ce014107505b92388c].[SellerIdentifier], [local_1].[LeadsClosedForSdr9d12ef1a7eca3ec58c545c678af7869cAndSdra8387c01a09e99ce014107505b92388c].[SdrIdentifier], [local_1].[LeadsClosedForSdr9d12ef1a7eca3ec58c545c678af7869cAndSdra8387c01a09e99ce014107505b92388c].[SrIdentifier] FROM [local_1].[LeadsClosedForSdr9d12ef1a7eca3ec58c545c678af7869cAndSdra8387c01a09e99ce014107505b92388c]
UNION
SELECT [LeadsClosedForSdr9e4d1098a3b0f5da39b0bc48f9876645AndSdrde63de0d10a6012430098db33c679b0b].[__orig_rowid] AS __orig_rowid, [local_1].[LeadsClosedForSdr9e4d1098a3b0f5da39b0bc48f9876645AndSdrde63de0d10a6012430098db33c679b0b].[MqlIdentifier], [local_1].[LeadsClosedForSdr9e4d1098a3b0f5da39b0bc48f9876645AndSdrde63de0d10a6012430098db33c679b0b].[SellerIdentifier], [local_1].[LeadsClosedForSdr9e4d1098a3b0f5da39b0bc48f9876645AndSdrde63de0d10a6012430098db33c679b0b].[SdrIdentifier], [local_1].[LeadsClosedForSdr9e4d1098a3b0f5da39b0bc48f9876645AndSdrde63de0d10a6012430098db33c679b0b].[SrIdentifier] FROM [local_1].[LeadsClosedForSdr9e4d1098a3b0f5da39b0bc48f9876645AndSdrde63de0d10a6012430098db33c679b0b]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct leads_qualified from row partitions (UNION (overlap))
CREATE VIEW "leads_qualified" AS
SELECT "local_1"."LeadsQualifiedUpTo20171231"."MqlIdentifier" AS "mql_id", "local_1"."LeadsQualifiedUpTo20171231"."FirstContactDate" AS "first_contact_date", "local_1"."LeadsQualifiedUpTo20171231"."LandingPageIdentifier" AS "landing_page_id", "local_1"."LeadsQualifiedUpTo20171231"."LeadOrigin" AS "origin" FROM "local_1"."LeadsQualifiedUpTo20171231"
UNION
SELECT "local_1"."LeadsQualifiedAfter20171231To20180225"."MqlIdentifier" AS "mql_id", "local_1"."LeadsQualifiedAfter20171231To20180225"."FirstContactDate" AS "first_contact_date", "local_1"."LeadsQualifiedAfter20171231To20180225"."LandingPageIdentifier" AS "landing_page_id", "local_1"."LeadsQualifiedAfter20171231To20180225"."LeadOrigin" AS "origin" FROM "local_1"."LeadsQualifiedAfter20171231To20180225"
UNION
SELECT "local_1"."LeadsQualifiedAfter20180225To20180415"."MqlIdentifier" AS "mql_id", "local_1"."LeadsQualifiedAfter20180225To20180415"."FirstContactDate" AS "first_contact_date", "local_1"."LeadsQualifiedAfter20180225To20180415"."LandingPageIdentifier" AS "landing_page_id", "local_1"."LeadsQualifiedAfter20180225To20180415"."LeadOrigin" AS "origin" FROM "local_1"."LeadsQualifiedAfter20180225To20180415"
UNION
SELECT "local_1"."LeadsQualifiedAfter20180415OrNull"."MqlIdentifier" AS "mql_id", "local_1"."LeadsQualifiedAfter20180415OrNull"."FirstContactDate" AS "first_contact_date", "local_1"."LeadsQualifiedAfter20180415OrNull"."LandingPageIdentifier" AS "landing_page_id", "local_1"."LeadsQualifiedAfter20180415OrNull"."LeadOrigin" AS "origin" FROM "local_1"."LeadsQualifiedAfter20180415OrNull";

-- Reconstruct order_items from vertical split + row partition on a fragment
CREATE VIEW "order_items" AS
SELECT t0.[ord_id], t0.[ord_itm_id], t1.[prod_id], t1.[sel_id], t0.[ship_lim_dt], t0.[prc], t0.[frt_val]
FROM [local_3].[ord_itm_frt_val] t0
JOIN (
SELECT [ord_itm_prc_gt_134_9_or_null].[__orig_rowid] AS __orig_rowid, [local_3].[ord_itm_prc_gt_134_9_or_null].[ord_id], [local_3].[ord_itm_prc_gt_134_9_or_null].[ord_itm_id], [local_3].[ord_itm_prc_gt_134_9_or_null].[prod_id], [local_3].[ord_itm_prc_gt_134_9_or_null].[sel_id], [local_3].[ord_itm_prc_gt_134_9_or_null].[ship_lim_dt], [local_3].[ord_itm_prc_gt_134_9_or_null].[prc] FROM [local_3].[ord_itm_prc_gt_134_9_or_null]
UNION
SELECT [ord_itm_prc_gt_39_9_lte_74_99].[__orig_rowid] AS __orig_rowid, [local_3].[ord_itm_prc_gt_39_9_lte_74_99].[ord_id], [local_3].[ord_itm_prc_gt_39_9_lte_74_99].[ord_itm_id], [local_3].[ord_itm_prc_gt_39_9_lte_74_99].[prod_id], [local_3].[ord_itm_prc_gt_39_9_lte_74_99].[sel_id], [local_3].[ord_itm_prc_gt_39_9_lte_74_99].[ship_lim_dt], [local_3].[ord_itm_prc_gt_39_9_lte_74_99].[prc] FROM [local_3].[ord_itm_prc_gt_39_9_lte_74_99]
UNION
SELECT [ord_itm_prc_gt_74_99_lte_134_9].[__orig_rowid] AS __orig_rowid, [local_3].[ord_itm_prc_gt_74_99_lte_134_9].[ord_id], [local_3].[ord_itm_prc_gt_74_99_lte_134_9].[ord_itm_id], [local_3].[ord_itm_prc_gt_74_99_lte_134_9].[prod_id], [local_3].[ord_itm_prc_gt_74_99_lte_134_9].[sel_id], [local_3].[ord_itm_prc_gt_74_99_lte_134_9].[ship_lim_dt], [local_3].[ord_itm_prc_gt_74_99_lte_134_9].[prc] FROM [local_3].[ord_itm_prc_gt_74_99_lte_134_9]
UNION
SELECT [ord_itm_prc_lte_39_9].[__orig_rowid] AS __orig_rowid, [local_3].[ord_itm_prc_lte_39_9].[ord_id], [local_3].[ord_itm_prc_lte_39_9].[ord_itm_id], [local_3].[ord_itm_prc_lte_39_9].[prod_id], [local_3].[ord_itm_prc_lte_39_9].[sel_id], [local_3].[ord_itm_prc_lte_39_9].[ship_lim_dt], [local_3].[ord_itm_prc_lte_39_9].[prc] FROM [local_3].[ord_itm_prc_lte_39_9]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct order_payments from row partitions (UNION (overlap))
CREATE VIEW "order_payments" AS
SELECT "local_1"."OrderPaymentsSingleOrNoInstallment"."OrderIdentifier" AS "order_id", "local_1"."OrderPaymentsSingleOrNoInstallment"."PaymentSequence" AS "payment_sequential", "local_1"."OrderPaymentsSingleOrNoInstallment"."PaymentMethod" AS "payment_type", "local_1"."OrderPaymentsSingleOrNoInstallment"."PaymentInstallments" AS "payment_installments", "local_1"."OrderPaymentsSingleOrNoInstallment"."PaymentAmount" AS "payment_value" FROM "local_1"."OrderPaymentsSingleOrNoInstallment"
UNION
SELECT "local_1"."OrderPaymentsInstallmentsBetween2And4"."OrderIdentifier" AS "order_id", "local_1"."OrderPaymentsInstallmentsBetween2And4"."PaymentSequence" AS "payment_sequential", "local_1"."OrderPaymentsInstallmentsBetween2And4"."PaymentMethod" AS "payment_type", "local_1"."OrderPaymentsInstallmentsBetween2And4"."PaymentInstallments" AS "payment_installments", "local_1"."OrderPaymentsInstallmentsBetween2And4"."PaymentAmount" AS "payment_value" FROM "local_1"."OrderPaymentsInstallmentsBetween2And4"
UNION
SELECT "local_1"."OrderPaymentsMoreThan4OrNull"."OrderIdentifier" AS "order_id", "local_1"."OrderPaymentsMoreThan4OrNull"."PaymentSequence" AS "payment_sequential", "local_1"."OrderPaymentsMoreThan4OrNull"."PaymentMethod" AS "payment_type", "local_1"."OrderPaymentsMoreThan4OrNull"."PaymentInstallments" AS "payment_installments", "local_1"."OrderPaymentsMoreThan4OrNull"."PaymentAmount" AS "payment_value" FROM "local_1"."OrderPaymentsMoreThan4OrNull";

-- Reconstruct order_reviews from row partitions (UNION (overlap))
CREATE VIEW "order_reviews" AS
SELECT "local_1"."OrderReviewsUpTo20170923000000"."ReviewIdentifier" AS "review_id", "local_1"."OrderReviewsUpTo20170923000000"."OrderIdentifier" AS "order_id", "local_1"."OrderReviewsUpTo20170923000000"."ReviewScore" AS "review_score", "local_1"."OrderReviewsUpTo20170923000000"."ReviewCommentTitle" AS "review_comment_title", "local_1"."OrderReviewsUpTo20170923000000"."ReviewCommentMessage" AS "review_comment_message", "local_1"."OrderReviewsUpTo20170923000000"."ReviewCreationTimestamp" AS "review_creation_date", "local_1"."OrderReviewsUpTo20170923000000"."ReviewAnswerTimestamp" AS "review_answer_timestamp" FROM "local_1"."OrderReviewsUpTo20170923000000"
UNION
SELECT "local_1"."OrderReviewsAfter20170923000000To20180202000000"."ReviewIdentifier" AS "review_id", "local_1"."OrderReviewsAfter20170923000000To20180202000000"."OrderIdentifier" AS "order_id", "local_1"."OrderReviewsAfter20170923000000To20180202000000"."ReviewScore" AS "review_score", "local_1"."OrderReviewsAfter20170923000000To20180202000000"."ReviewCommentTitle" AS "review_comment_title", "local_1"."OrderReviewsAfter20170923000000To20180202000000"."ReviewCommentMessage" AS "review_comment_message", "local_1"."OrderReviewsAfter20170923000000To20180202000000"."ReviewCreationTimestamp" AS "review_creation_date", "local_1"."OrderReviewsAfter20170923000000To20180202000000"."ReviewAnswerTimestamp" AS "review_answer_timestamp" FROM "local_1"."OrderReviewsAfter20170923000000To20180202000000"
UNION
SELECT "local_1"."OrderReviewsAfter20180202000000To20180516000000"."ReviewIdentifier" AS "review_id", "local_1"."OrderReviewsAfter20180202000000To20180516000000"."OrderIdentifier" AS "order_id", "local_1"."OrderReviewsAfter20180202000000To20180516000000"."ReviewScore" AS "review_score", "local_1"."OrderReviewsAfter20180202000000To20180516000000"."ReviewCommentTitle" AS "review_comment_title", "local_1"."OrderReviewsAfter20180202000000To20180516000000"."ReviewCommentMessage" AS "review_comment_message", "local_1"."OrderReviewsAfter20180202000000To20180516000000"."ReviewCreationTimestamp" AS "review_creation_date", "local_1"."OrderReviewsAfter20180202000000To20180516000000"."ReviewAnswerTimestamp" AS "review_answer_timestamp" FROM "local_1"."OrderReviewsAfter20180202000000To20180516000000"
UNION
SELECT "local_1"."OrderReviewsAfter20180516000000OrNull"."ReviewIdentifier" AS "review_id", "local_1"."OrderReviewsAfter20180516000000OrNull"."OrderIdentifier" AS "order_id", "local_1"."OrderReviewsAfter20180516000000OrNull"."ReviewScore" AS "review_score", "local_1"."OrderReviewsAfter20180516000000OrNull"."ReviewCommentTitle" AS "review_comment_title", "local_1"."OrderReviewsAfter20180516000000OrNull"."ReviewCommentMessage" AS "review_comment_message", "local_1"."OrderReviewsAfter20180516000000OrNull"."ReviewCreationTimestamp" AS "review_creation_date", "local_1"."OrderReviewsAfter20180516000000OrNull"."ReviewAnswerTimestamp" AS "review_answer_timestamp" FROM "local_1"."OrderReviewsAfter20180516000000OrNull";

-- Reconstruct orders from vertical (column) split (2 fragments)
CREATE VIEW "orders" AS
SELECT
    t0."OrderIdentifier" AS "order_id",
    t0."CustomerIdentifier" AS "customer_id",
    t0."OrderStatus" AS "order_status",
    t0."OrderPurchaseTimestamp" AS "order_purchase_timestamp",
    t0."OrderApprovedTimestamp" AS "order_approved_at",
    t1."OrderDeliveredToCarrierTimestamp" AS "order_delivered_carrier_date",
    t1."OrderDeliveredToCustomerTimestamp" AS "order_delivered_customer_date",
    t1."OrderEstimatedDeliveryTimestamp" AS "order_estimated_delivery_date"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "CustomerIdentifier" ORDER BY rowid) AS __rn FROM "local_1"."OrdersSummary") t0
JOIN "local_1"."OrdersWithDeliveryDates" t1 ON t0."CustomerIdentifier" IS t1."CustomerIdentifier" AND t0.__rn = t1.__rn;

-- Reconstruct product_category_name_translation from local_2.category_name_translations_map
CREATE VIEW "product_category_name_translation" AS
SELECT
    "local_2"."category_name_translations_map"."category_key" AS "product_category_name",
    "local_2"."category_name_translations_map"."category_name_en" AS "product_category_name_english"
FROM "local_2"."category_name_translations_map";

-- Reconstruct products from vertical split + row partition on a fragment
CREATE VIEW "products" AS
SELECT t0.[product_sku], t0.[category_key], t0.[name_length_chars], t0.[description_length_chars], t0.[photos_count], t0.[weight_g], t0.[length_cm], t1.[height_cm], t1.[width_cm]
FROM (
SELECT [auto_and_computer_accessories_products].[__orig_rowid] AS __orig_rowid, [local_2].[auto_and_computer_accessories_products].[product_sku], [local_2].[auto_and_computer_accessories_products].[category_key], [local_2].[auto_and_computer_accessories_products].[name_length_chars], [local_2].[auto_and_computer_accessories_products].[description_length_chars], [local_2].[auto_and_computer_accessories_products].[photos_count], [local_2].[auto_and_computer_accessories_products].[weight_g], [local_2].[auto_and_computer_accessories_products].[length_cm] FROM [local_2].[auto_and_computer_accessories_products]
UNION
SELECT [beauty_health_and_household_products].[__orig_rowid] AS __orig_rowid, [local_2].[beauty_health_and_household_products].[product_sku], [local_2].[beauty_health_and_household_products].[category_key], [local_2].[beauty_health_and_household_products].[name_length_chars], [local_2].[beauty_health_and_household_products].[description_length_chars], [local_2].[beauty_health_and_household_products].[photos_count], [local_2].[beauty_health_and_household_products].[weight_g], [local_2].[beauty_health_and_household_products].[length_cm] FROM [local_2].[beauty_health_and_household_products]
UNION
SELECT [bedding_bath_and_sports_products].[__orig_rowid] AS __orig_rowid, [local_2].[bedding_bath_and_sports_products].[product_sku], [local_2].[bedding_bath_and_sports_products].[category_key], [local_2].[bedding_bath_and_sports_products].[name_length_chars], [local_2].[bedding_bath_and_sports_products].[description_length_chars], [local_2].[bedding_bath_and_sports_products].[photos_count], [local_2].[bedding_bath_and_sports_products].[weight_g], [local_2].[bedding_bath_and_sports_products].[length_cm] FROM [local_2].[bedding_bath_and_sports_products]
UNION
SELECT [furniture_toys_and_gifts_products].[__orig_rowid] AS __orig_rowid, [local_2].[furniture_toys_and_gifts_products].[product_sku], [local_2].[furniture_toys_and_gifts_products].[category_key], [local_2].[furniture_toys_and_gifts_products].[name_length_chars], [local_2].[furniture_toys_and_gifts_products].[description_length_chars], [local_2].[furniture_toys_and_gifts_products].[photos_count], [local_2].[furniture_toys_and_gifts_products].[weight_g], [local_2].[furniture_toys_and_gifts_products].[length_cm] FROM [local_2].[furniture_toys_and_gifts_products]
UNION
SELECT [other_or_unclassified_products].[__orig_rowid] AS __orig_rowid, [local_2].[other_or_unclassified_products].[product_sku], [local_2].[other_or_unclassified_products].[category_key], [local_2].[other_or_unclassified_products].[name_length_chars], [local_2].[other_or_unclassified_products].[description_length_chars], [local_2].[other_or_unclassified_products].[photos_count], [local_2].[other_or_unclassified_products].[weight_g], [local_2].[other_or_unclassified_products].[length_cm] FROM [local_2].[other_or_unclassified_products]
) t0
JOIN [local_2].[product_master_catalog] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct sellers from row partitions (UNION (overlap))
CREATE VIEW "sellers" AS
SELECT "local_3"."sel_city_sao_paulo"."sel_id" AS "seller_id", "local_3"."sel_city_sao_paulo"."sel_zip_pref" AS "seller_zip_code_prefix", "local_3"."sel_city_sao_paulo"."sel_city" AS "seller_city", "local_3"."sel_city_sao_paulo"."sel_state" AS "seller_state" FROM "local_3"."sel_city_sao_paulo"
UNION
SELECT "local_3"."sel_city_selected_cities"."sel_id" AS "seller_id", "local_3"."sel_city_selected_cities"."sel_zip_pref" AS "seller_zip_code_prefix", "local_3"."sel_city_selected_cities"."sel_city" AS "seller_city", "local_3"."sel_city_selected_cities"."sel_state" AS "seller_state" FROM "local_3"."sel_city_selected_cities"
UNION
SELECT "local_3"."sel_city_other_or_null"."sel_id" AS "seller_id", "local_3"."sel_city_other_or_null"."sel_zip_pref" AS "seller_zip_code_prefix", "local_3"."sel_city_other_or_null"."sel_city" AS "seller_city", "local_3"."sel_city_other_or_null"."sel_state" AS "seller_state" FROM "local_3"."sel_city_other_or_null";
