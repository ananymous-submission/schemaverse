-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/complex_oracle/complex_oracle.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "marketing_channels" (
    "channel_key" INTEGER,
    "channel_description" TEXT NOT NULL,
    "channel_category" TEXT NOT NULL,
    "channel_category_key" INTEGER NOT NULL,
    "channel_aggregate" TEXT NOT NULL,
    "channel_aggregate_key" INTEGER NOT NULL
);

CREATE TABLE "country_reference" (
    "country_key" INTEGER,
    "country_iso2" CHAR(2) NOT NULL,
    "country_label" TEXT NOT NULL,
    "country_region_label" TEXT NOT NULL,
    "country_region_key" INTEGER NOT NULL,
    "country_subregion_label" TEXT NOT NULL,
    "country_subregion_key" INTEGER NOT NULL
);

CREATE TABLE "country_summary" (
    "country_summary_key" INTEGER,
    "iso_code2" CHAR(2) NOT NULL,
    "country_display_name" TEXT NOT NULL,
    "subregion_label" TEXT NOT NULL,
    "subregion_key" INTEGER NOT NULL,
    "country_total_label" TEXT NOT NULL,
    "country_total_key" INTEGER NOT NULL
);

CREATE TABLE "exchange_rates" (
    "country_iso2" TEXT,
    "rate_year" INTEGER,
    "rate_month" INTEGER,
    "to_usd_rate" REAL
);

CREATE TABLE "customer_locations_summary" (
    "customer_key" INTEGER,
    "country_summary_key" INTEGER NOT NULL,
    "city_name" TEXT NOT NULL,
    "city_key" INTEGER NOT NULL,
    "primary_phone" TEXT NOT NULL,
    "customer_source_key" INTEGER,
    "state_province" TEXT NOT NULL,
    "state_province_key" INTEGER NOT NULL,
    "customer_total_key" INTEGER NOT NULL,
    FOREIGN KEY ("country_summary_key") REFERENCES "country_summary"("country_summary_key")
);

CREATE TABLE "customer_profiles" (
    "customer_key" INTEGER,
    "country_key" INTEGER NOT NULL,
    "city_name" TEXT NOT NULL,
    "email_address" TEXT,
    "name" TEXT NOT NULL,
    "income_bracket" TEXT,
    "last_name" TEXT NOT NULL,
    "primary_phone" TEXT NOT NULL,
    "state_province" TEXT NOT NULL,
    "street_address" TEXT NOT NULL,
    "birth_year" INTEGER NOT NULL,
    FOREIGN KEY ("country_key") REFERENCES "country_reference"("country_key"),
    FOREIGN KEY ("country_key") REFERENCES "country_summary"("country_summary_key")
);

CREATE TABLE "products_catalog" (
    "product_key" INTEGER,
    "category_name" TEXT NOT NULL,
    "category_description" TEXT NOT NULL,
    "category_key" INTEGER NOT NULL,
    "product_description" TEXT NOT NULL,
    "product_name" TEXT NOT NULL,
    "pack_size" TEXT NOT NULL,
    "product_source_key" INTEGER,
    "status" TEXT NOT NULL,
    "subcategory_name" TEXT NOT NULL,
    "subcategory_description" TEXT NOT NULL,
    "subcategory_key" INTEGER NOT NULL,
    "unit_of_measure" TEXT,
    "weight_class" INTEGER NOT NULL
);

CREATE TABLE "product_category_overview" (
    "product_key" INTEGER,
    "category_key" INTEGER NOT NULL,
    "product_name" TEXT NOT NULL,
    "product_source_key" INTEGER,
    "subcategory_name" TEXT NOT NULL,
    "subcategory_key" INTEGER NOT NULL,
    "product_total_label" TEXT NOT NULL,
    "product_total_key" INTEGER NOT NULL,
    "weight_class" INTEGER NOT NULL,
    "supplier_key" INTEGER NOT NULL
);

CREATE TABLE "demographics_affinity_card" (
    "customer_key" INTEGER,
    "affinity_card_flag" INTEGER,
    "notes" TEXT,
    "education_level" TEXT,
    "miscellaneous_flag" INTEGER
);

CREATE TABLE "demographics_affinity_card_extended" (
    "customer_key" INTEGER,
    "affinity_card_flag" INTEGER,
    "interest_baseball" INTEGER,
    "interest_cricket" INTEGER,
    "education_level" TEXT,
    "interest_golf" INTEGER,
    "miscellaneous_flag" INTEGER,
    "occupation_title" TEXT,
    "interest_soccer" INTEGER,
    "interest_tennis" INTEGER,
    "interest_unknown" INTEGER
);

CREATE TABLE "household_size_occupation_crafts" (
    "customer_key" INTEGER,
    "household_size_label" TEXT,
    "occupation_title" TEXT,
    "interest_tennis" INTEGER,
    "interest_unknown" INTEGER,
    "years_in_residence" INTEGER
);

CREATE TABLE "household_size_occupation_sales" (
    "customer_key" INTEGER,
    "household_size_label" TEXT,
    "occupation_title" TEXT,
    "interest_tennis" INTEGER,
    "interest_unknown" INTEGER,
    "years_in_residence" INTEGER
);

CREATE TABLE "household_size_occupation_executive" (
    "customer_key" INTEGER,
    "household_size_label" TEXT,
    "occupation_title" TEXT,
    "interest_tennis" INTEGER,
    "interest_unknown" INTEGER,
    "years_in_residence" INTEGER
);

CREATE TABLE "household_size_occupation_professional" (
    "customer_key" INTEGER,
    "household_size_label" TEXT,
    "occupation_title" TEXT,
    "interest_tennis" INTEGER,
    "interest_unknown" INTEGER,
    "years_in_residence" INTEGER
);

CREATE TABLE "household_size_occupation_clerical" (
    "customer_key" INTEGER,
    "household_size_label" TEXT,
    "occupation_title" TEXT,
    "interest_tennis" INTEGER,
    "interest_unknown" INTEGER,
    "years_in_residence" INTEGER
);

CREATE TABLE "household_size_occupation_other" (
    "customer_key" INTEGER,
    "household_size_label" TEXT,
    "occupation_title" TEXT,
    "interest_tennis" INTEGER,
    "interest_unknown" INTEGER,
    "years_in_residence" INTEGER
);

CREATE TABLE "household_size_occupations_machine_unknown_transport" (
    "customer_key" INTEGER,
    "household_size_label" TEXT,
    "occupation_title" TEXT,
    "interest_tennis" INTEGER,
    "interest_unknown" INTEGER,
    "years_in_residence" INTEGER
);

CREATE TABLE "household_size_occupation_miscellaneous" (
    "customer_key" INTEGER,
    "household_size_label" TEXT,
    "occupation_title" TEXT,
    "interest_tennis" INTEGER,
    "interest_unknown" INTEGER,
    "years_in_residence" INTEGER
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "sale_costs" (
    "prd_id_fk" INTEGER NOT NULL,
    "tm_date_fk" DATE NOT NULL,
    "prm_id_fk" INTEGER NOT NULL,
    "chnl_id" INTEGER NOT NULL,
    "unit_cost_amt" REAL NOT NULL,
    "unit_price_amt" REAL NOT NULL,
    FOREIGN KEY ("tm_date_fk") REFERENCES "time_mnth_jan_jul"("tm_date_pk"),
    FOREIGN KEY ("prd_id_fk") REFERENCES "prod_pricing"("prd_prc_id_pk"),
    FOREIGN KEY ("prd_id_fk") REFERENCES "prod_lifecycle"("prd_meta_id_pk"),
    FOREIGN KEY ("prm_id_fk") REFERENCES "promos_before_20190925"("prm_id_pk"),
    FOREIGN KEY ("prm_id_fk") REFERENCES "promos_after_20210228"("prm_id_pk")
);

CREATE TABLE "promos_before_20190925" (
    "prm_id_pk" INTEGER,
    "prm_name" TEXT NOT NULL,
    "prm_subcat" TEXT NOT NULL,
    "prm_subcat_id" INTEGER NOT NULL,
    "prm_cat" TEXT NOT NULL,
    "prm_cat_id" INTEGER NOT NULL,
    "prm_cost_amt" REAL NOT NULL,
    "prm_start_dt" DATE NOT NULL,
    "prm_end_dt" DATE NOT NULL,
    "prm_total_cd" TEXT NOT NULL,
    "prm_total_id" INTEGER NOT NULL
);

CREATE TABLE "promos_after_20210228" (
    "prm_id_pk" INTEGER,
    "prm_name" TEXT NOT NULL,
    "prm_subcat" TEXT NOT NULL,
    "prm_subcat_id" INTEGER NOT NULL,
    "prm_cat" TEXT NOT NULL,
    "prm_cat_id" INTEGER NOT NULL,
    "prm_cost_amt" REAL NOT NULL,
    "prm_start_dt" DATE NOT NULL,
    "prm_end_dt" DATE NOT NULL,
    "prm_total_cd" TEXT NOT NULL,
    "prm_total_id" INTEGER NOT NULL
);

CREATE TABLE "prod_pricing" (
    "prd_prc_id_pk" INTEGER,
    "list_prc_amt" REAL NOT NULL,
    "min_prc_amt" REAL NOT NULL,
    "uom_cd" TEXT
);

CREATE TABLE "prod_lifecycle" (
    "prd_meta_id_pk" INTEGER,
    "eff_from_dt" DATE,
    "eff_to_dt" DATE,
    "pack_sz" TEXT NOT NULL,
    "prod_stat" TEXT NOT NULL,
    "valid_flg" CHAR(1)
);

CREATE TABLE "time_days_counts" (
    "tm_date_pk" DATE,
    "days_cal_mnth" INTEGER NOT NULL,
    "days_cal_qtr" INTEGER NOT NULL,
    "days_cal_yr" INTEGER NOT NULL,
    "days_fis_mnth" INTEGER NOT NULL,
    "days_fis_qtr" INTEGER NOT NULL,
    "days_fis_yr" INTEGER NOT NULL
);

CREATE TABLE "time_mnth_aug_dec" (
    "tm_date_pk" DATE,
    "mnth_name" TEXT NOT NULL,
    "cal_wk_num" INTEGER NOT NULL,
    "day_nm" TEXT NOT NULL,
    "day_in_mnth" INTEGER NOT NULL,
    "day_in_wk" INTEGER NOT NULL,
    "fis_wk_num" INTEGER NOT NULL,
    "wk_end_dt" DATE NOT NULL,
    "wk_end_id" INTEGER NOT NULL
);

CREATE TABLE "time_mnth_jan_jul" (
    "tm_date_pk" DATE,
    "mnth_name" TEXT NOT NULL,
    "cal_wk_num" INTEGER NOT NULL,
    "day_nm" TEXT NOT NULL,
    "day_in_mnth" INTEGER NOT NULL,
    "day_in_wk" INTEGER NOT NULL,
    "fis_wk_num" INTEGER NOT NULL,
    "wk_end_dt" DATE NOT NULL,
    "wk_end_id" INTEGER NOT NULL
);

CREATE TABLE "time_mnth_mar_may" (
    "tm_date_pk" DATE,
    "mnth_name" TEXT NOT NULL,
    "cal_wk_num" INTEGER NOT NULL,
    "day_nm" TEXT NOT NULL,
    "day_in_mnth" INTEGER NOT NULL,
    "day_in_wk" INTEGER NOT NULL,
    "fis_wk_num" INTEGER NOT NULL,
    "wk_end_dt" DATE NOT NULL,
    "wk_end_id" INTEGER NOT NULL
);

CREATE TABLE "time_mnth_oct_apr_jun" (
    "tm_date_pk" DATE,
    "mnth_name" TEXT NOT NULL,
    "cal_wk_num" INTEGER NOT NULL,
    "day_nm" TEXT NOT NULL,
    "day_in_mnth" INTEGER NOT NULL,
    "day_in_wk" INTEGER NOT NULL,
    "fis_wk_num" INTEGER NOT NULL,
    "wk_end_dt" DATE NOT NULL,
    "wk_end_id" INTEGER NOT NULL
);

CREATE TABLE "time_mnth_other" (
    "tm_date_pk" DATE,
    "mnth_name" TEXT NOT NULL,
    "cal_wk_num" INTEGER NOT NULL,
    "day_nm" TEXT NOT NULL,
    "day_in_mnth" INTEGER NOT NULL,
    "day_in_wk" INTEGER NOT NULL,
    "fis_wk_num" INTEGER NOT NULL,
    "wk_end_dt" DATE NOT NULL,
    "wk_end_id" INTEGER NOT NULL
);

CREATE TABLE "time_qtr_desc" (
    "tm_date_pk" DATE,
    "cal_qtr_desc" CHAR(7) NOT NULL,
    "cal_qtr_id" INTEGER NOT NULL,
    "cal_qtr_num" INTEGER NOT NULL,
    "days_cal_qtr" INTEGER NOT NULL,
    "end_cal_qtr_dt" DATE NOT NULL,
    "end_fis_qtr_dt" DATE NOT NULL,
    "fis_qtr_desc" CHAR(7) NOT NULL,
    "fis_qtr_id" INTEGER NOT NULL,
    "fis_qtr_num" INTEGER NOT NULL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "salesTransactions" (
    "productId" INTEGER NOT NULL,
    "customerId" INTEGER NOT NULL,
    "timeId" DATE NOT NULL,
    "channelId" INTEGER NOT NULL,
    "promotionId" INTEGER NOT NULL,
    "quantitySold" INTEGER NOT NULL,
    "amountSold" REAL NOT NULL,
    FOREIGN KEY ("timeId") REFERENCES "calendarMonthIdentifiers"("timeId"),
    FOREIGN KEY ("customerId") REFERENCES "customerIncomeBracketE90kTo109k"("customerId"),
    FOREIGN KEY ("customerId") REFERENCES "customerIncomeBucketsG130kTo149kAndD70kTo89k"("customerId"),
    FOREIGN KEY ("customerId") REFERENCES "customerIncomeBucketsI170kTo189kAndC50kTo69k"("customerId"),
    FOREIGN KEY ("customerId") REFERENCES "customerIncomeBucketOther"("customerId")
);

CREATE TABLE "calendarMonthDescription" (
    "timeId" DATE,
    "calendarMonthDescription" TEXT NOT NULL,
    "calendarMonthId" INTEGER NOT NULL,
    "calendarMonthName" TEXT NOT NULL,
    "calendarMonthNumber" INTEGER NOT NULL,
    "dayName" TEXT NOT NULL,
    "dayNumberInMonth" INTEGER NOT NULL,
    "daysInCalendarMonth" INTEGER NOT NULL,
    "endOfCalendarMonth" DATE NOT NULL,
    "endOfCalendarYear" DATE NOT NULL,
    "endOfFiscalMonth" DATE NOT NULL,
    "endOfFiscalYear" DATE NOT NULL,
    "fiscalMonthDescription" TEXT NOT NULL,
    "fiscalMonthId" INTEGER NOT NULL,
    "fiscalMonthName" TEXT NOT NULL,
    "fiscalMonthNumber" INTEGER NOT NULL
);

CREATE TABLE "calendarMonthIdentifiers" (
    "timeId" DATE,
    "calendarMonthId" INTEGER NOT NULL,
    "calendarQuarterId" INTEGER NOT NULL,
    "calendarYear" INTEGER NOT NULL,
    "calendarYearId" INTEGER NOT NULL,
    "daysInCalendarYear" INTEGER NOT NULL,
    "endOfCalendarMonth" DATE NOT NULL,
    "endOfCalendarQuarter" DATE NOT NULL,
    "endOfCalendarYear" DATE NOT NULL,
    "endOfFiscalMonth" DATE NOT NULL,
    "endOfFiscalQuarter" DATE NOT NULL,
    "endOfFiscalYear" DATE NOT NULL,
    "fiscalMonthId" INTEGER NOT NULL,
    "fiscalYear" INTEGER NOT NULL,
    "fiscalYearId" INTEGER NOT NULL
);

CREATE TABLE "customerProfile" (
    "customerId" INTEGER,
    "effectiveFrom" DATE,
    "effectiveTo" DATE,
    "maritalStatus" TEXT,
    "sourceId" INTEGER,
    "validFlag" CHAR(1),
    "birthYear" INTEGER NOT NULL
);

CREATE TABLE "customerIncomeBracketF110kTo129k" (
    "customerId" INTEGER,
    "creditLimit" REAL,
    "emailAddress" TEXT,
    "gender" CHAR(1) NOT NULL,
    "incomeLevel" TEXT,
    "postalCode" TEXT NOT NULL,
    "totalCategory" TEXT NOT NULL,
    "totalCategoryId" INTEGER NOT NULL
);

CREATE TABLE "customerIncomeBracketE90kTo109k" (
    "customerId" INTEGER,
    "creditLimit" REAL,
    "emailAddress" TEXT,
    "gender" CHAR(1) NOT NULL,
    "incomeLevel" TEXT,
    "postalCode" TEXT NOT NULL,
    "totalCategory" TEXT NOT NULL,
    "totalCategoryId" INTEGER NOT NULL
);

CREATE TABLE "customerIncomeBucketsG130kTo149kAndD70kTo89k" (
    "customerId" INTEGER,
    "creditLimit" REAL,
    "emailAddress" TEXT,
    "gender" CHAR(1) NOT NULL,
    "incomeLevel" TEXT,
    "postalCode" TEXT NOT NULL,
    "totalCategory" TEXT NOT NULL,
    "totalCategoryId" INTEGER NOT NULL
);

CREATE TABLE "customerIncomeBucketsH150kTo169kAndJ190kTo249kAndB30kTo49k" (
    "customerId" INTEGER,
    "creditLimit" REAL,
    "emailAddress" TEXT,
    "gender" CHAR(1) NOT NULL,
    "incomeLevel" TEXT,
    "postalCode" TEXT NOT NULL,
    "totalCategory" TEXT NOT NULL,
    "totalCategoryId" INTEGER NOT NULL
);

CREATE TABLE "customerIncomeBucketsI170kTo189kAndC50kTo69k" (
    "customerId" INTEGER,
    "creditLimit" REAL,
    "emailAddress" TEXT,
    "gender" CHAR(1) NOT NULL,
    "incomeLevel" TEXT,
    "postalCode" TEXT NOT NULL,
    "totalCategory" TEXT NOT NULL,
    "totalCategoryId" INTEGER NOT NULL
);

CREATE TABLE "customerIncomeBucketOther" (
    "customerId" INTEGER,
    "creditLimit" REAL,
    "emailAddress" TEXT,
    "gender" CHAR(1) NOT NULL,
    "incomeLevel" TEXT,
    "postalCode" TEXT NOT NULL,
    "totalCategory" TEXT NOT NULL,
    "totalCategoryId" INTEGER NOT NULL
);

CREATE TABLE "promotionsBegin20190925To20200330" (
    "promotionId" INTEGER,
    "promotionName" TEXT NOT NULL,
    "promotionSubcategory" TEXT NOT NULL,
    "promotionSubcategoryId" INTEGER NOT NULL,
    "promotionCategory" TEXT NOT NULL,
    "promotionCategoryId" INTEGER NOT NULL,
    "promotionCost" REAL NOT NULL,
    "promotionStartDate" DATE NOT NULL,
    "promotionEndDate" DATE NOT NULL,
    "promotionTotal" TEXT NOT NULL,
    "promotionTotalId" INTEGER NOT NULL
);

CREATE TABLE "promotionsBeginAfter20200330To20210228" (
    "promotionId" INTEGER,
    "promotionName" TEXT NOT NULL,
    "promotionSubcategory" TEXT NOT NULL,
    "promotionSubcategoryId" INTEGER NOT NULL,
    "promotionCategory" TEXT NOT NULL,
    "promotionCategoryId" INTEGER NOT NULL,
    "promotionCost" REAL NOT NULL,
    "promotionStartDate" DATE NOT NULL,
    "promotionEndDate" DATE NOT NULL,
    "promotionTotal" TEXT NOT NULL,
    "promotionTotalId" INTEGER NOT NULL
);

