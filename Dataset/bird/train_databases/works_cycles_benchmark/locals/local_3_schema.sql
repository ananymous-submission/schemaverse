CREATE TABLE "currency_rate_avg_up_to_1_0684" (
    "currency_rate_id" INTEGER,
    "rate_effective_date" DATETIME NOT NULL,
    "source_currency_code" TEXT NOT NULL,
    "target_currency_code" TEXT NOT NULL,
    "average_exchange_rate" REAL NOT NULL,
    "end_of_day_exchange_rate" REAL NOT NULL,
    "last_modified_at" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "currency_rate_avg_above_8_2871_or_null" (
    "currency_rate_id" INTEGER,
    "rate_effective_date" DATETIME NOT NULL,
    "source_currency_code" TEXT NOT NULL,
    "target_currency_code" TEXT NOT NULL,
    "average_exchange_rate" REAL NOT NULL,
    "end_of_day_exchange_rate" REAL NOT NULL,
    "last_modified_at" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "job_candidate_profile" (
    "job_candidate_id" INTEGER,
    "business_entity_id" INTEGER,
    "resume_text" TEXT,
    "last_modified_at" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "product_description_as_of_2013_04_30" (
    "product_description_id" INTEGER,
    "description_text" TEXT NOT NULL,
    "row_guid" TEXT NOT NULL,
    "last_modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "product_description_as_of_2014_02_08" (
    "product_description_id" INTEGER,
    "description_text" TEXT NOT NULL,
    "row_guid" TEXT NOT NULL,
    "last_modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "product_model_description_culture_link" (
    "product_model_id" INTEGER,
    "product_description_id" INTEGER,
    "culture_code" TEXT,
    "last_modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("product_description_id") REFERENCES "product_description_as_of_2014_02_08"("product_description_id"),
    FOREIGN KEY ("product_model_id") REFERENCES "product_model_filtered_by_modified_date"("product_model_id")
);

CREATE TABLE "product_model_filtered_by_modified_date" (
    "product_model_id" INTEGER,
    "model_name" TEXT NOT NULL,
    "catalog_summary" TEXT,
    "usage_instructions" TEXT,
    "row_guid" TEXT NOT NULL,
    "last_modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "sales_order_due_on_or_before_2013_07_02" (
    "sales_order_id" INTEGER,
    "due_date" DATETIME NOT NULL,
    "last_modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "order_date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ship_date" DATETIME
);

CREATE TABLE "sales_order_due_between_2013_07_02_and_2013_11_15" (
    "sales_order_id" INTEGER,
    "due_date" DATETIME NOT NULL,
    "last_modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "order_date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ship_date" DATETIME
);

CREATE TABLE "sales_order_due_between_2013_11_15_and_2014_03_12" (
    "sales_order_id" INTEGER,
    "due_date" DATETIME NOT NULL,
    "last_modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "order_date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ship_date" DATETIME
);

CREATE TABLE "sales_order_due_after_2014_03_12_or_null" (
    "sales_order_id" INTEGER,
    "due_date" DATETIME NOT NULL,
    "last_modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "order_date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ship_date" DATETIME
);

CREATE TABLE "sales_order_freight_financials" (
    "sales_order_id" INTEGER,
    "freight_charge" REAL NOT NULL DEFAULT 0.0000,
    "subtotal_amount" REAL NOT NULL DEFAULT 0.0000,
    "tax_amount" REAL NOT NULL DEFAULT 0.0000,
    "total_due_amount" REAL NOT NULL
);