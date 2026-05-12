CREATE TABLE "business_entity_contact_modified_earliest_quartile" (
    "business_entity_id" INTEGER,
    "person_id" INTEGER,
    "contact_type_id" INTEGER,
    "modified_at" DATETIME NOT NULL DEFAULT current_timestamp,
    "row_guid" TEXT NOT NULL,
    FOREIGN KEY ("business_entity_id") REFERENCES "business_entity_modified_quartile"("business_entity_id"),
    FOREIGN KEY ("business_entity_id") REFERENCES "business_entity_modified_quartile"("business_entity_id")
);

CREATE TABLE "business_entity_contact_modified_latest_quartile" (
    "business_entity_id" INTEGER,
    "person_id" INTEGER,
    "contact_type_id" INTEGER,
    "modified_at" DATETIME NOT NULL DEFAULT current_timestamp,
    "row_guid" TEXT NOT NULL,
    FOREIGN KEY ("business_entity_id") REFERENCES "business_entity_modified_quartile"("business_entity_id")
);

CREATE TABLE "supplier_product_lead_time" (
    "product_id" INTEGER,
    "vendor_business_entity_id" INTEGER,
    "average_lead_time_days" INTEGER NOT NULL,
    "last_receipt_cost" REAL,
    "last_receipt_date" DATETIME,
    "modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "standard_price" REAL NOT NULL,
    "unit_measure_code" TEXT NOT NULL,
    FOREIGN KEY ("vendor_business_entity_id") REFERENCES "vendor_modified_quartile"("business_entity_id"),
    FOREIGN KEY ("vendor_business_entity_id") REFERENCES "vendor_modified_quartile"("business_entity_id"),
    FOREIGN KEY ("product_id") REFERENCES "product_classification_core"("product_id")
);

CREATE TABLE "transaction_history_archive_actualcost_lowest" (
    "transaction_id" INTEGER,
    "product_id" INTEGER NOT NULL,
    "reference_order_id" INTEGER NOT NULL,
    "reference_order_line_id" INTEGER NOT NULL DEFAULT 0,
    "transaction_date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "transaction_type" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "actual_cost" REAL NOT NULL,
    "modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "transaction_history_archive_actualcost_middle" (
    "transaction_id" INTEGER,
    "product_id" INTEGER NOT NULL,
    "reference_order_id" INTEGER NOT NULL,
    "reference_order_line_id" INTEGER NOT NULL DEFAULT 0,
    "transaction_date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "transaction_type" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "actual_cost" REAL NOT NULL,
    "modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "transaction_history_archive_actualcost_highest" (
    "transaction_id" INTEGER,
    "product_id" INTEGER NOT NULL,
    "reference_order_id" INTEGER NOT NULL,
    "reference_order_line_id" INTEGER NOT NULL DEFAULT 0,
    "transaction_date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "transaction_type" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "actual_cost" REAL NOT NULL,
    "modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "vendor_modified_quartile" (
    "business_entity_id" INTEGER,
    "account_number" TEXT NOT NULL,
    "vendor_name" TEXT NOT NULL,
    "credit_rating" INTEGER NOT NULL,
    "preferred_vendor_status" INTEGER NOT NULL DEFAULT 1,
    "active_flag" INTEGER NOT NULL DEFAULT 1,
    "purchasing_webservice_url" TEXT,
    "modified_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("business_entity_id") REFERENCES "business_entity_modified_quartile"("business_entity_id"),
    FOREIGN KEY ("business_entity_id") REFERENCES "business_entity_modified_quartile"("business_entity_id")
);

CREATE TABLE "product_classification_core" (
    "product_id" INTEGER,
    "product_class" TEXT,
    "color" TEXT,
    "list_price" REAL NOT NULL,
    "product_name" TEXT NOT NULL,
    "product_line" TEXT,
    "product_number" TEXT NOT NULL,
    "size" TEXT,
    "size_unit_code" TEXT,
    "standard_cost" REAL NOT NULL,
    "style" TEXT,
    "weight" REAL,
    "weight_unit_code" TEXT,
    "row_guid" TEXT NOT NULL
);

CREATE TABLE "address_other_cities" (
    "address_id" INTEGER,
    "address_line_primary" TEXT NOT NULL,
    "address_line_secondary" TEXT,
    "city_name" TEXT NOT NULL,
    "state_province_id" INTEGER NOT NULL,
    "postal_code" TEXT NOT NULL,
    "spatial_location" TEXT,
    "row_guid" TEXT NOT NULL,
    "modified_at" DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE "business_entity_modified_quartile" (
    "business_entity_id" INTEGER,
    "row_guid" TEXT NOT NULL,
    "modified_at" DATETIME NOT NULL DEFAULT current_timestamp
);