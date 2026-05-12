CREATE TABLE "raw_activity_events" (
    "event_timestamp" varchar(255),
    "session_id" varchar(255),
    "action_type" varchar(255),
    "product_reference" varchar(255),
    "request_url" TEXT,
    "client_ip" varchar(255),
    "client_user_agent" TEXT
);

CREATE TABLE "product_catalog_archive_december_2016" (
    "product_sku" varchar(255),
    "product_name" varchar(255),
    "price_cents" INTEGER,
    "record_updated_at" varchar(255)
);

CREATE TABLE "category_product_sales" (
    "product_category" varchar(255),
    "product_sku_ref" varchar(255),
    "units_sold" INTEGER
);