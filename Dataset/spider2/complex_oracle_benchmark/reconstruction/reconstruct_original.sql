-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct channels from local_1.marketing_channels
CREATE VIEW "channels" AS
SELECT
    "local_1"."marketing_channels"."channel_key" AS "channel_id",
    "local_1"."marketing_channels"."channel_description" AS "channel_desc",
    "local_1"."marketing_channels"."channel_category" AS "channel_class",
    "local_1"."marketing_channels"."channel_category_key" AS "channel_class_id",
    "local_1"."marketing_channels"."channel_aggregate" AS "channel_total",
    "local_1"."marketing_channels"."channel_aggregate_key" AS "channel_total_id"
FROM "local_1"."marketing_channels";

-- Reconstruct costs from local_2.sale_costs
CREATE VIEW "costs" AS
SELECT
    "local_2"."sale_costs"."prd_id_fk" AS "prod_id",
    "local_2"."sale_costs"."tm_date_fk" AS "time_id",
    "local_2"."sale_costs"."prm_id_fk" AS "promo_id",
    "local_2"."sale_costs"."chnl_id" AS "channel_id",
    "local_2"."sale_costs"."unit_cost_amt" AS "unit_cost",
    "local_2"."sale_costs"."unit_price_amt" AS "unit_price"
FROM "local_2"."sale_costs";

-- Reconstruct countries from vertical (column) split (2 fragments)
CREATE VIEW "countries" AS
SELECT
    t0."country_key" AS "country_id",
    t0."country_iso2" AS "country_iso_code",
    t0."country_label" AS "country_name",
    t0."country_subregion_label" AS "country_subregion",
    t0."country_subregion_key" AS "country_subregion_id",
    t0."country_region_label" AS "country_region",
    t0."country_region_key" AS "country_region_id",
    t1."country_total_label" AS "country_total",
    t1."country_total_key" AS "country_total_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "country_key" ORDER BY rowid) AS __rn FROM "local_1"."country_reference") t0
JOIN "local_1"."country_summary" t1 ON t0."country_key" IS t1."country_summary_key" AND t0.__rn = t1.__rn;

-- Reconstruct currency from local_1.exchange_rates
CREATE VIEW "currency" AS
SELECT
    "local_1"."exchange_rates"."country_iso2" AS "country",
    "local_1"."exchange_rates"."rate_year" AS "year",
    "local_1"."exchange_rates"."rate_month" AS "month",
    "local_1"."exchange_rates"."to_usd_rate" AS "to_us"
FROM "local_1"."exchange_rates";

-- Reconstruct customers from vertical split + row partition on a fragment
CREATE VIEW "customers" AS
SELECT t0.[customer_key], t1.[name], t1.[last_name], t2.[gender], t1.[birth_year], t3.[maritalStatus], t1.[street_address], t2.[postalCode], t0.[city_name], t0.[city_key], t0.[state_province], t0.[state_province_key], t0.[country_summary_key], t0.[primary_phone], t1.[income_bracket], t2.[creditLimit], t1.[email_address], t2.[totalCategory], t0.[customer_total_key], t0.[customer_source_key], t3.[effectiveFrom], t3.[effectiveTo], t3.[validFlag]
FROM [local_1].[customer_locations_summary] t0
JOIN [local_1].[customer_profiles] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [customerIncomeBracketE90kTo109k].[__orig_rowid] AS __orig_rowid, [local_3].[customerIncomeBracketE90kTo109k].[customerId], [local_3].[customerIncomeBracketE90kTo109k].[gender], [local_3].[customerIncomeBracketE90kTo109k].[postalCode], [local_3].[customerIncomeBracketE90kTo109k].[incomeLevel], [local_3].[customerIncomeBracketE90kTo109k].[creditLimit], [local_3].[customerIncomeBracketE90kTo109k].[emailAddress], [local_3].[customerIncomeBracketE90kTo109k].[totalCategory], [local_3].[customerIncomeBracketE90kTo109k].[totalCategoryId] FROM [local_3].[customerIncomeBracketE90kTo109k]
UNION
SELECT [customerIncomeBracketF110kTo129k].[__orig_rowid] AS __orig_rowid, [local_3].[customerIncomeBracketF110kTo129k].[customerId], [local_3].[customerIncomeBracketF110kTo129k].[gender], [local_3].[customerIncomeBracketF110kTo129k].[postalCode], [local_3].[customerIncomeBracketF110kTo129k].[incomeLevel], [local_3].[customerIncomeBracketF110kTo129k].[creditLimit], [local_3].[customerIncomeBracketF110kTo129k].[emailAddress], [local_3].[customerIncomeBracketF110kTo129k].[totalCategory], [local_3].[customerIncomeBracketF110kTo129k].[totalCategoryId] FROM [local_3].[customerIncomeBracketF110kTo129k]
UNION
SELECT [customerIncomeBucketOther].[__orig_rowid] AS __orig_rowid, [local_3].[customerIncomeBucketOther].[customerId], [local_3].[customerIncomeBucketOther].[gender], [local_3].[customerIncomeBucketOther].[postalCode], [local_3].[customerIncomeBucketOther].[incomeLevel], [local_3].[customerIncomeBucketOther].[creditLimit], [local_3].[customerIncomeBucketOther].[emailAddress], [local_3].[customerIncomeBucketOther].[totalCategory], [local_3].[customerIncomeBucketOther].[totalCategoryId] FROM [local_3].[customerIncomeBucketOther]
UNION
SELECT [customerIncomeBucketsG130kTo149kAndD70kTo89k].[__orig_rowid] AS __orig_rowid, [local_3].[customerIncomeBucketsG130kTo149kAndD70kTo89k].[customerId], [local_3].[customerIncomeBucketsG130kTo149kAndD70kTo89k].[gender], [local_3].[customerIncomeBucketsG130kTo149kAndD70kTo89k].[postalCode], [local_3].[customerIncomeBucketsG130kTo149kAndD70kTo89k].[incomeLevel], [local_3].[customerIncomeBucketsG130kTo149kAndD70kTo89k].[creditLimit], [local_3].[customerIncomeBucketsG130kTo149kAndD70kTo89k].[emailAddress], [local_3].[customerIncomeBucketsG130kTo149kAndD70kTo89k].[totalCategory], [local_3].[customerIncomeBucketsG130kTo149kAndD70kTo89k].[totalCategoryId] FROM [local_3].[customerIncomeBucketsG130kTo149kAndD70kTo89k]
UNION
SELECT [customerIncomeBucketsH150kTo169kAndJ190kTo249kAndB30kTo49k].[__orig_rowid] AS __orig_rowid, [local_3].[customerIncomeBucketsH150kTo169kAndJ190kTo249kAndB30kTo49k].[customerId], [local_3].[customerIncomeBucketsH150kTo169kAndJ190kTo249kAndB30kTo49k].[gender], [local_3].[customerIncomeBucketsH150kTo169kAndJ190kTo249kAndB30kTo49k].[postalCode], [local_3].[customerIncomeBucketsH150kTo169kAndJ190kTo249kAndB30kTo49k].[incomeLevel], [local_3].[customerIncomeBucketsH150kTo169kAndJ190kTo249kAndB30kTo49k].[creditLimit], [local_3].[customerIncomeBucketsH150kTo169kAndJ190kTo249kAndB30kTo49k].[emailAddress], [local_3].[customerIncomeBucketsH150kTo169kAndJ190kTo249kAndB30kTo49k].[totalCategory], [local_3].[customerIncomeBucketsH150kTo169kAndJ190kTo249kAndB30kTo49k].[totalCategoryId] FROM [local_3].[customerIncomeBucketsH150kTo169kAndJ190kTo249kAndB30kTo49k]
UNION
SELECT [customerIncomeBucketsI170kTo189kAndC50kTo69k].[__orig_rowid] AS __orig_rowid, [local_3].[customerIncomeBucketsI170kTo189kAndC50kTo69k].[customerId], [local_3].[customerIncomeBucketsI170kTo189kAndC50kTo69k].[gender], [local_3].[customerIncomeBucketsI170kTo189kAndC50kTo69k].[postalCode], [local_3].[customerIncomeBucketsI170kTo189kAndC50kTo69k].[incomeLevel], [local_3].[customerIncomeBucketsI170kTo189kAndC50kTo69k].[creditLimit], [local_3].[customerIncomeBucketsI170kTo189kAndC50kTo69k].[emailAddress], [local_3].[customerIncomeBucketsI170kTo189kAndC50kTo69k].[totalCategory], [local_3].[customerIncomeBucketsI170kTo189kAndC50kTo69k].[totalCategoryId] FROM [local_3].[customerIncomeBucketsI170kTo189kAndC50kTo69k]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_3].[customerProfile] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct products from vertical (column) split (4 fragments)
CREATE VIEW "products" AS
SELECT
    t0."prd_meta_id_pk" AS "prod_id",
    t2."product_name" AS "prod_name",
    t3."product_description" AS "prod_desc",
    t2."subcategory_name" AS "prod_subcategory",
    t2."subcategory_key" AS "prod_subcategory_id",
    t3."subcategory_description" AS "prod_subcategory_desc",
    t3."category_name" AS "prod_category",
    t2."category_key" AS "prod_category_id",
    t3."category_description" AS "prod_category_desc",
    t2."weight_class" AS "prod_weight_class",
    t1."uom_cd" AS "prod_unit_of_measure",
    t0."pack_sz" AS "prod_pack_size",
    t2."supplier_key" AS "supplier_id",
    t0."prod_stat" AS "prod_status",
    t1."list_prc_amt" AS "prod_list_price",
    t1."min_prc_amt" AS "prod_min_price",
    t2."product_total_label" AS "prod_total",
    t2."product_total_key" AS "prod_total_id",
    t2."product_source_key" AS "prod_src_id",
    t0."eff_from_dt" AS "prod_eff_from",
    t0."eff_to_dt" AS "prod_eff_to",
    t0."valid_flg" AS "prod_valid"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "prd_meta_id_pk" ORDER BY rowid) AS __rn FROM "local_2"."prod_lifecycle") t0
JOIN "local_2"."prod_pricing" t1 ON t0."prd_meta_id_pk" IS t1."prd_prc_id_pk" AND t0.__rn = t1.__rn
JOIN "local_1"."product_category_overview" t2 ON t0."prd_meta_id_pk" IS t2."product_key" AND t0.__rn = t2.__rn
JOIN "local_1"."products_catalog" t3 ON t0."prd_meta_id_pk" IS t3."product_key" AND t0.__rn = t3.__rn;

-- Reconstruct promotions from row partitions (UNION (overlap))
CREATE VIEW "promotions" AS
SELECT "local_2"."promos_before_20190925"."prm_id_pk" AS "promo_id", "local_2"."promos_before_20190925"."prm_name" AS "promo_name", "local_2"."promos_before_20190925"."prm_subcat" AS "promo_subcategory", "local_2"."promos_before_20190925"."prm_subcat_id" AS "promo_subcategory_id", "local_2"."promos_before_20190925"."prm_cat" AS "promo_category", "local_2"."promos_before_20190925"."prm_cat_id" AS "promo_category_id", "local_2"."promos_before_20190925"."prm_cost_amt" AS "promo_cost", "local_2"."promos_before_20190925"."prm_start_dt" AS "promo_begin_date", "local_2"."promos_before_20190925"."prm_end_dt" AS "promo_end_date", "local_2"."promos_before_20190925"."prm_total_cd" AS "promo_total", "local_2"."promos_before_20190925"."prm_total_id" AS "promo_total_id" FROM "local_2"."promos_before_20190925"
UNION
SELECT "local_2"."promos_after_20210228"."prm_id_pk" AS "promo_id", "local_2"."promos_after_20210228"."prm_name" AS "promo_name", "local_2"."promos_after_20210228"."prm_subcat" AS "promo_subcategory", "local_2"."promos_after_20210228"."prm_subcat_id" AS "promo_subcategory_id", "local_2"."promos_after_20210228"."prm_cat" AS "promo_category", "local_2"."promos_after_20210228"."prm_cat_id" AS "promo_category_id", "local_2"."promos_after_20210228"."prm_cost_amt" AS "promo_cost", "local_2"."promos_after_20210228"."prm_start_dt" AS "promo_begin_date", "local_2"."promos_after_20210228"."prm_end_dt" AS "promo_end_date", "local_2"."promos_after_20210228"."prm_total_cd" AS "promo_total", "local_2"."promos_after_20210228"."prm_total_id" AS "promo_total_id" FROM "local_2"."promos_after_20210228"
UNION
SELECT "local_3"."promotionsBegin20190925To20200330"."promotionId" AS "promo_id", "local_3"."promotionsBegin20190925To20200330"."promotionName" AS "promo_name", "local_3"."promotionsBegin20190925To20200330"."promotionSubcategory" AS "promo_subcategory", "local_3"."promotionsBegin20190925To20200330"."promotionSubcategoryId" AS "promo_subcategory_id", "local_3"."promotionsBegin20190925To20200330"."promotionCategory" AS "promo_category", "local_3"."promotionsBegin20190925To20200330"."promotionCategoryId" AS "promo_category_id", "local_3"."promotionsBegin20190925To20200330"."promotionCost" AS "promo_cost", "local_3"."promotionsBegin20190925To20200330"."promotionStartDate" AS "promo_begin_date", "local_3"."promotionsBegin20190925To20200330"."promotionEndDate" AS "promo_end_date", "local_3"."promotionsBegin20190925To20200330"."promotionTotal" AS "promo_total", "local_3"."promotionsBegin20190925To20200330"."promotionTotalId" AS "promo_total_id" FROM "local_3"."promotionsBegin20190925To20200330"
UNION
SELECT "local_3"."promotionsBeginAfter20200330To20210228"."promotionId" AS "promo_id", "local_3"."promotionsBeginAfter20200330To20210228"."promotionName" AS "promo_name", "local_3"."promotionsBeginAfter20200330To20210228"."promotionSubcategory" AS "promo_subcategory", "local_3"."promotionsBeginAfter20200330To20210228"."promotionSubcategoryId" AS "promo_subcategory_id", "local_3"."promotionsBeginAfter20200330To20210228"."promotionCategory" AS "promo_category", "local_3"."promotionsBeginAfter20200330To20210228"."promotionCategoryId" AS "promo_category_id", "local_3"."promotionsBeginAfter20200330To20210228"."promotionCost" AS "promo_cost", "local_3"."promotionsBeginAfter20200330To20210228"."promotionStartDate" AS "promo_begin_date", "local_3"."promotionsBeginAfter20200330To20210228"."promotionEndDate" AS "promo_end_date", "local_3"."promotionsBeginAfter20200330To20210228"."promotionTotal" AS "promo_total", "local_3"."promotionsBeginAfter20200330To20210228"."promotionTotalId" AS "promo_total_id" FROM "local_3"."promotionsBeginAfter20200330To20210228";

-- Reconstruct sales from local_3.salesTransactions
CREATE VIEW "sales" AS
SELECT
    "local_3"."salesTransactions"."productId" AS "prod_id",
    "local_3"."salesTransactions"."customerId" AS "cust_id",
    "local_3"."salesTransactions"."timeId" AS "time_id",
    "local_3"."salesTransactions"."channelId" AS "channel_id",
    "local_3"."salesTransactions"."promotionId" AS "promo_id",
    "local_3"."salesTransactions"."quantitySold" AS "quantity_sold",
    "local_3"."salesTransactions"."amountSold" AS "amount_sold"
FROM "local_3"."salesTransactions";

-- Reconstruct supplementary_demographics from vertical split + row partition on a fragment
CREATE VIEW "supplementary_demographics" AS
SELECT t0.[customer_key], t0.[education_level], t1.[occupation_title], t2.[household_size_label], t2.[years_in_residence], t0.[affinity_card_flag], t1.[interest_cricket], t1.[interest_baseball], t1.[interest_tennis], t1.[interest_soccer], t1.[interest_golf], t1.[interest_unknown], t0.[miscellaneous_flag], t0.[notes]
FROM [local_1].[demographics_affinity_card] t0
JOIN [local_1].[demographics_affinity_card_extended] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [household_size_occupation_clerical].[__orig_rowid] AS __orig_rowid, [local_1].[household_size_occupation_clerical].[customer_key], [local_1].[household_size_occupation_clerical].[occupation_title], [local_1].[household_size_occupation_clerical].[household_size_label], [local_1].[household_size_occupation_clerical].[years_in_residence], [local_1].[household_size_occupation_clerical].[interest_tennis], [local_1].[household_size_occupation_clerical].[interest_unknown] FROM [local_1].[household_size_occupation_clerical]
UNION
SELECT [household_size_occupation_crafts].[__orig_rowid] AS __orig_rowid, [local_1].[household_size_occupation_crafts].[customer_key], [local_1].[household_size_occupation_crafts].[occupation_title], [local_1].[household_size_occupation_crafts].[household_size_label], [local_1].[household_size_occupation_crafts].[years_in_residence], [local_1].[household_size_occupation_crafts].[interest_tennis], [local_1].[household_size_occupation_crafts].[interest_unknown] FROM [local_1].[household_size_occupation_crafts]
UNION
SELECT [household_size_occupation_executive].[__orig_rowid] AS __orig_rowid, [local_1].[household_size_occupation_executive].[customer_key], [local_1].[household_size_occupation_executive].[occupation_title], [local_1].[household_size_occupation_executive].[household_size_label], [local_1].[household_size_occupation_executive].[years_in_residence], [local_1].[household_size_occupation_executive].[interest_tennis], [local_1].[household_size_occupation_executive].[interest_unknown] FROM [local_1].[household_size_occupation_executive]
UNION
SELECT [household_size_occupation_miscellaneous].[__orig_rowid] AS __orig_rowid, [local_1].[household_size_occupation_miscellaneous].[customer_key], [local_1].[household_size_occupation_miscellaneous].[occupation_title], [local_1].[household_size_occupation_miscellaneous].[household_size_label], [local_1].[household_size_occupation_miscellaneous].[years_in_residence], [local_1].[household_size_occupation_miscellaneous].[interest_tennis], [local_1].[household_size_occupation_miscellaneous].[interest_unknown] FROM [local_1].[household_size_occupation_miscellaneous]
UNION
SELECT [household_size_occupation_other].[__orig_rowid] AS __orig_rowid, [local_1].[household_size_occupation_other].[customer_key], [local_1].[household_size_occupation_other].[occupation_title], [local_1].[household_size_occupation_other].[household_size_label], [local_1].[household_size_occupation_other].[years_in_residence], [local_1].[household_size_occupation_other].[interest_tennis], [local_1].[household_size_occupation_other].[interest_unknown] FROM [local_1].[household_size_occupation_other]
UNION
SELECT [household_size_occupation_professional].[__orig_rowid] AS __orig_rowid, [local_1].[household_size_occupation_professional].[customer_key], [local_1].[household_size_occupation_professional].[occupation_title], [local_1].[household_size_occupation_professional].[household_size_label], [local_1].[household_size_occupation_professional].[years_in_residence], [local_1].[household_size_occupation_professional].[interest_tennis], [local_1].[household_size_occupation_professional].[interest_unknown] FROM [local_1].[household_size_occupation_professional]
UNION
SELECT [household_size_occupation_sales].[__orig_rowid] AS __orig_rowid, [local_1].[household_size_occupation_sales].[customer_key], [local_1].[household_size_occupation_sales].[occupation_title], [local_1].[household_size_occupation_sales].[household_size_label], [local_1].[household_size_occupation_sales].[years_in_residence], [local_1].[household_size_occupation_sales].[interest_tennis], [local_1].[household_size_occupation_sales].[interest_unknown] FROM [local_1].[household_size_occupation_sales]
UNION
SELECT [household_size_occupations_machine_unknown_transport].[__orig_rowid] AS __orig_rowid, [local_1].[household_size_occupations_machine_unknown_transport].[customer_key], [local_1].[household_size_occupations_machine_unknown_transport].[occupation_title], [local_1].[household_size_occupations_machine_unknown_transport].[household_size_label], [local_1].[household_size_occupations_machine_unknown_transport].[years_in_residence], [local_1].[household_size_occupations_machine_unknown_transport].[interest_tennis], [local_1].[household_size_occupations_machine_unknown_transport].[interest_unknown] FROM [local_1].[household_size_occupations_machine_unknown_transport]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct times from vertical split + row partition on a fragment
CREATE VIEW "times" AS
SELECT t0.[timeId], t0.[dayName], t2.[day_in_wk], t0.[dayNumberInMonth], t2.[cal_wk_num], t2.[fis_wk_num], t2.[wk_end_dt], t2.[wk_end_id], t0.[calendarMonthNumber], t0.[fiscalMonthNumber], t0.[calendarMonthDescription], t0.[calendarMonthId], t0.[fiscalMonthDescription], t0.[fiscalMonthId], t0.[daysInCalendarMonth], t4.[days_fis_mnth], t0.[endOfCalendarMonth], t0.[endOfFiscalMonth], t0.[calendarMonthName], t0.[fiscalMonthName], t3.[cal_qtr_desc], t1.[calendarQuarterId], t3.[fis_qtr_desc], t3.[fis_qtr_id], t3.[days_cal_qtr], t4.[days_fis_qtr], t1.[endOfCalendarQuarter], t1.[endOfFiscalQuarter], t3.[cal_qtr_num], t3.[fis_qtr_num], t1.[calendarYear], t1.[calendarYearId], t1.[fiscalYear], t1.[fiscalYearId], t1.[daysInCalendarYear], t4.[days_fis_yr], t0.[endOfCalendarYear], t0.[endOfFiscalYear]
FROM [local_3].[calendarMonthDescription] t0
JOIN [local_3].[calendarMonthIdentifiers] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [time_mnth_aug_dec].[__orig_rowid] AS __orig_rowid, [local_2].[time_mnth_aug_dec].[tm_date_pk], [local_2].[time_mnth_aug_dec].[day_nm], [local_2].[time_mnth_aug_dec].[day_in_wk], [local_2].[time_mnth_aug_dec].[day_in_mnth], [local_2].[time_mnth_aug_dec].[cal_wk_num], [local_2].[time_mnth_aug_dec].[fis_wk_num], [local_2].[time_mnth_aug_dec].[wk_end_dt], [local_2].[time_mnth_aug_dec].[wk_end_id], [local_2].[time_mnth_aug_dec].[mnth_name] FROM [local_2].[time_mnth_aug_dec]
UNION
SELECT [time_mnth_jan_jul].[__orig_rowid] AS __orig_rowid, [local_2].[time_mnth_jan_jul].[tm_date_pk], [local_2].[time_mnth_jan_jul].[day_nm], [local_2].[time_mnth_jan_jul].[day_in_wk], [local_2].[time_mnth_jan_jul].[day_in_mnth], [local_2].[time_mnth_jan_jul].[cal_wk_num], [local_2].[time_mnth_jan_jul].[fis_wk_num], [local_2].[time_mnth_jan_jul].[wk_end_dt], [local_2].[time_mnth_jan_jul].[wk_end_id], [local_2].[time_mnth_jan_jul].[mnth_name] FROM [local_2].[time_mnth_jan_jul]
UNION
SELECT [time_mnth_mar_may].[__orig_rowid] AS __orig_rowid, [local_2].[time_mnth_mar_may].[tm_date_pk], [local_2].[time_mnth_mar_may].[day_nm], [local_2].[time_mnth_mar_may].[day_in_wk], [local_2].[time_mnth_mar_may].[day_in_mnth], [local_2].[time_mnth_mar_may].[cal_wk_num], [local_2].[time_mnth_mar_may].[fis_wk_num], [local_2].[time_mnth_mar_may].[wk_end_dt], [local_2].[time_mnth_mar_may].[wk_end_id], [local_2].[time_mnth_mar_may].[mnth_name] FROM [local_2].[time_mnth_mar_may]
UNION
SELECT [time_mnth_oct_apr_jun].[__orig_rowid] AS __orig_rowid, [local_2].[time_mnth_oct_apr_jun].[tm_date_pk], [local_2].[time_mnth_oct_apr_jun].[day_nm], [local_2].[time_mnth_oct_apr_jun].[day_in_wk], [local_2].[time_mnth_oct_apr_jun].[day_in_mnth], [local_2].[time_mnth_oct_apr_jun].[cal_wk_num], [local_2].[time_mnth_oct_apr_jun].[fis_wk_num], [local_2].[time_mnth_oct_apr_jun].[wk_end_dt], [local_2].[time_mnth_oct_apr_jun].[wk_end_id], [local_2].[time_mnth_oct_apr_jun].[mnth_name] FROM [local_2].[time_mnth_oct_apr_jun]
UNION
SELECT [time_mnth_other].[__orig_rowid] AS __orig_rowid, [local_2].[time_mnth_other].[tm_date_pk], [local_2].[time_mnth_other].[day_nm], [local_2].[time_mnth_other].[day_in_wk], [local_2].[time_mnth_other].[day_in_mnth], [local_2].[time_mnth_other].[cal_wk_num], [local_2].[time_mnth_other].[fis_wk_num], [local_2].[time_mnth_other].[wk_end_dt], [local_2].[time_mnth_other].[wk_end_id], [local_2].[time_mnth_other].[mnth_name] FROM [local_2].[time_mnth_other]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_2].[time_qtr_desc] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_2].[time_days_counts] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];
