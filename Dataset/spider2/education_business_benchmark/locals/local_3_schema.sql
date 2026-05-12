CREATE TABLE "dim_product_personal_laptop" (
    "product_sku" TEXT,
    "business_division" TEXT,
    "market_segment" TEXT,
    "product_category" TEXT,
    "product_name" TEXT,
    "product_variant" TEXT
);

CREATE TABLE "dim_product_other_categories" (
    "product_sku" TEXT,
    "business_division" TEXT,
    "market_segment" TEXT,
    "product_category" TEXT,
    "product_name" TEXT,
    "product_variant" TEXT
);

CREATE TABLE "fact_gross_price_year_le_2020" (
    "product_sku" TEXT,
    "price_year" INTEGER,
    "gross_price_amount" REAL
);

CREATE TABLE "fact_gross_price_post_2020_or_null" (
    "product_sku" TEXT,
    "price_year" INTEGER,
    "gross_price_amount" REAL
);

CREATE TABLE "fact_manufacturing_cost_year_le_2020" (
    "product_sku" TEXT,
    "cost_year_report" INTEGER,
    "manufacturing_cost_amount" REAL
);

CREATE TABLE "fact_manufacturing_cost_post_2020_or_null" (
    "product_sku" TEXT,
    "cost_year_report" INTEGER,
    "manufacturing_cost_amount" REAL
);