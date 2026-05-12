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