CREATE TABLE "california_city_registry" (
    "city_key" INTEGER,
    "city_label" TEXT,
    "state_name" TEXT,
    "population_count" INTEGER,
    "surface_area" REAL
);

CREATE TABLE "other_states_city_registry" (
    "city_key" INTEGER,
    "city_label" TEXT,
    "state_name" TEXT,
    "population_count" INTEGER,
    "surface_area" REAL
);

CREATE TABLE "manufacturer_customer_addresses" (
    "customer_key" INTEGER,
    "street_address" TEXT,
    "annual_revenue_amount" INTEGER,
    "city_name" TEXT,
    "customer_name" TEXT,
    "customer_category" TEXT,
    "phone_number" TEXT
);

CREATE TABLE "customer_address_records" (
    "customer_key" INTEGER,
    "street_address" TEXT,
    "annual_revenue_amount" INTEGER,
    "city_name" TEXT,
    "phone_number" TEXT,
    "state_name" TEXT,
    "postal_code_value" REAL
);