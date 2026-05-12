CREATE TABLE "country_region_currency_map" (
    "country_region_code" TEXT,
    "currency_code" TEXT,
    "modified_at" DATE
);

CREATE TABLE "sales_territory_financials_last_year" (
    "territory_name" TEXT,
    "cost_previous_year" FLOAT,
    "cost_year_to_date" FLOAT,
    "country_region_code" TEXT,
    "territory_group" TEXT,
    "modified_at" DATE,
    "sales_previous_year" FLOAT,
    "sales_year_to_date" FLOAT,
    "territory_id" INTEGER
);

CREATE TABLE "sales_territory_region_mapping" (
    "territory_name" TEXT,
    "country_region_code" TEXT,
    "territory_group" TEXT,
    "modified_at" DATE,
    "row_guid" TEXT,
    "territory_id" INTEGER
);