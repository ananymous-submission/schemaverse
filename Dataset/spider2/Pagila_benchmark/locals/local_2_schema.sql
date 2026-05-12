CREATE TABLE "addresses_oldest_quartile" (
    "address_record_id" INT,
    "address_line1" VARCHAR(50) NOT NULL,
    "address_line2" VARCHAR(50) DEFAULT NULL,
    "area_name" VARCHAR(20) NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "contact_phone" VARCHAR(20) NOT NULL,
    "postal_code_value" VARCHAR(10) DEFAULT NULL
);

CREATE TABLE "addresses_quartile" (
    "address_record_id" INT,
    "address_line1" VARCHAR(50) NOT NULL,
    "address_line2" VARCHAR(50) DEFAULT NULL,
    "area_name" VARCHAR(20) NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "contact_phone" VARCHAR(20) NOT NULL,
    "postal_code_value" VARCHAR(10) DEFAULT NULL
);

CREATE TABLE "addresses_newest_quartile" (
    "address_record_id" INT,
    "address_line1" VARCHAR(50) NOT NULL,
    "address_line2" VARCHAR(50) DEFAULT NULL,
    "area_name" VARCHAR(20) NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "contact_phone" VARCHAR(20) NOT NULL,
    "postal_code_value" VARCHAR(10) DEFAULT NULL
);

CREATE TABLE "addresses_with_city_ref" (
    "address_record_id" INT,
    "city_ref_id" INT NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "contact_phone" VARCHAR(20) NOT NULL,
    "postal_code_value" VARCHAR(10) DEFAULT NULL,
    FOREIGN KEY ("city_ref_id") REFERENCES "cities_oldest"("city_record_id")
);

CREATE TABLE "cities_oldest" (
    "city_record_id" INT,
    "city_name" VARCHAR(50) NOT NULL,
    "country_ref_id" SMALLINT NOT NULL,
    "modified_at" TIMESTAMP NOT NULL
);

CREATE TABLE "cities_recent_or_null" (
    "city_record_id" INT,
    "city_name" VARCHAR(50) NOT NULL,
    "country_ref_id" SMALLINT NOT NULL,
    "modified_at" TIMESTAMP NOT NULL
);

CREATE TABLE "customers_active_recent_updates" (
    "customer_record_id" INT,
    "is_active_flag" CHAR(1) NOT NULL DEFAULT 'Y',
    "created_at" TIMESTAMP NOT NULL,
    "given_name" VARCHAR(45) NOT NULL,
    "family_name" VARCHAR(45) NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "store_ref_id" INT NOT NULL
);

CREATE TABLE "customers_active_address_linked" (
    "customer_record_id" INT,
    "is_active_flag" CHAR(1) NOT NULL DEFAULT 'Y',
    "address_ref_id" INT NOT NULL,
    "created_at" TIMESTAMP NOT NULL,
    "email_address" VARCHAR(50) DEFAULT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "store_ref_id" INT NOT NULL,
    FOREIGN KEY ("address_ref_id") REFERENCES "addresses_quartile"("address_record_id"),
    FOREIGN KEY ("address_ref_id") REFERENCES "addresses_newest_quartile"("address_record_id"),
    FOREIGN KEY ("store_ref_id") REFERENCES "stores_locations"("store_record_id")
);

CREATE TABLE "payments_amount_bucketed" (
    "payment_record_id" INT,
    "payment_amount" DECIMAL(5,2) NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "paid_at" TIMESTAMP NOT NULL,
    "rental_ref_id" INT DEFAULT NULL,
    FOREIGN KEY ("rental_ref_id") REFERENCES "rentals_oldest_quartile"("rental_record_id"),
    FOREIGN KEY ("rental_ref_id") REFERENCES "rentals_quartile"("rental_record_id")
);

CREATE TABLE "payments_by_customer_ref" (
    "payment_record_id" INT,
    "payment_amount" DECIMAL(5,2) NOT NULL,
    "customer_ref_id" INT NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "rental_ref_id" INT DEFAULT NULL,
    "staff_ref_id" SMALLINT NOT NULL,
    FOREIGN KEY ("customer_ref_id") REFERENCES "customers_active_address_linked"("customer_record_id"),
    FOREIGN KEY ("rental_ref_id") REFERENCES "rentals_oldest_quartile"("rental_record_id")
);

CREATE TABLE "staff_members_active" (
    "staff_record_id" SMALLINT,
    "is_active_flag" SMALLINT NOT NULL DEFAULT 1,
    "address_ref_id" INT NOT NULL,
    "email_address" VARCHAR(50) DEFAULT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "password_hash" VARCHAR(40) DEFAULT NULL,
    "photo_blob" BLOB DEFAULT NULL,
    "store_ref_id" INT NOT NULL,
    FOREIGN KEY ("address_ref_id") REFERENCES "addresses_quartile"("address_record_id"),
    FOREIGN KEY ("store_ref_id") REFERENCES "stores_locations"("store_record_id")
);

CREATE TABLE "stores_locations" (
    "store_record_id" INT,
    "manager_staff_ref_id" SMALLINT NOT NULL,
    "address_ref_id" INT NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    FOREIGN KEY ("manager_staff_ref_id") REFERENCES "staff_members_active"("staff_record_id")
);

CREATE TABLE "rentals_oldest_quartile" (
    "rental_record_id" INT,
    "customer_ref_id" INT NOT NULL,
    "inventory_ref_id" INT NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "staff_ref_id" SMALLINT NOT NULL,
    FOREIGN KEY ("customer_ref_id") REFERENCES "customers_active_address_linked"("customer_record_id")
);

CREATE TABLE "rentals_quartile" (
    "rental_record_id" INT,
    "customer_ref_id" INT NOT NULL,
    "inventory_ref_id" INT NOT NULL,
    "modified_at" TIMESTAMP NOT NULL,
    "staff_ref_id" SMALLINT NOT NULL,
    FOREIGN KEY ("customer_ref_id") REFERENCES "customers_active_recent_updates"("customer_record_id"),
    FOREIGN KEY ("customer_ref_id") REFERENCES "customers_active_address_linked"("customer_record_id"),
    FOREIGN KEY ("staff_ref_id") REFERENCES "staff_members_active"("staff_record_id")
);