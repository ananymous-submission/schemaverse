CREATE TABLE "street_address" (
    "location_id" INTEGER,
    "house_number" TEXT,
    "street_label" TEXT,
    "locality_name" TEXT,
    "country_ref" INTEGER
);

CREATE TABLE "nation" (
    "nation_id" INTEGER,
    "nation_name" TEXT
);

CREATE TABLE "customer_order" (
    "purchase_id" INTEGER,
    "placed_at" DATETIME,
    "client_ref" INTEGER,
    "delivery_option_ref" INTEGER,
    "destination_address_ref" INTEGER
);

CREATE TABLE "client_profile" (
    "client_id" INTEGER,
    "given_name" TEXT,
    "family_name" TEXT,
    "contact_email" TEXT
);

CREATE TABLE "order_event_log" (
    "event_id" INTEGER,
    "purchase_ref" INTEGER,
    "status_ref" INTEGER,
    "status_timestamp" DATETIME
);

CREATE TABLE "order_status_lookup" (
    "status_code_id" INTEGER,
    "status_label" TEXT
);

CREATE TABLE "delivery_option" (
    "option_id" INTEGER,
    "option_label" TEXT,
    "price" REAL
);

CREATE TABLE "client_address_status_greater_than_one" (
    "client_id" INTEGER,
    "address_ref" INTEGER,
    "link_status_id" INTEGER,
    FOREIGN KEY ("client_id") REFERENCES "client_profile"("client_id"),
    FOREIGN KEY ("address_ref") REFERENCES "street_address"("location_id")
);