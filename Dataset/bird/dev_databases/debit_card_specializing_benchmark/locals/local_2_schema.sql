CREATE TABLE "service_stations_chain_up_to_3" (
    "station_id" INTEGER,
    "brand_id" INTEGER,
    "country_name" TEXT,
    "market_segment" TEXT
);

CREATE TABLE "service_stations_chain_4_to_33" (
    "station_id" INTEGER,
    "brand_id" INTEGER,
    "country_name" TEXT,
    "market_segment" TEXT
);

CREATE TABLE "service_stations_chain_above_33_or_missing" (
    "station_id" INTEGER,
    "brand_id" INTEGER,
    "country_name" TEXT,
    "market_segment" TEXT
);

CREATE TABLE "transactions_amount_up_to_5" (
    "transaction_id" INTEGER,
    "amount_value" INTEGER,
    "card_id" INTEGER,
    "customer_id" INTEGER,
    "station_id" INTEGER,
    "price_value" REAL,
    "product_id" INTEGER
);

CREATE TABLE "transactions_amount_over_5_to_19" (
    "transaction_id" INTEGER,
    "amount_value" INTEGER,
    "card_id" INTEGER,
    "customer_id" INTEGER,
    "station_id" INTEGER,
    "price_value" REAL,
    "product_id" INTEGER
);

CREATE TABLE "transactions_amount_over_19_to_27" (
    "transaction_id" INTEGER,
    "amount_value" INTEGER,
    "card_id" INTEGER,
    "customer_id" INTEGER,
    "station_id" INTEGER,
    "price_value" REAL,
    "product_id" INTEGER
);

CREATE TABLE "transactions_amount_over_27_or_missing" (
    "transaction_id" INTEGER,
    "amount_value" INTEGER,
    "card_id" INTEGER,
    "customer_id" INTEGER,
    "station_id" INTEGER,
    "price_value" REAL,
    "product_id" INTEGER
);

CREATE TABLE "transactions_with_datetime" (
    "transaction_id" INTEGER,
    "amount_value" INTEGER,
    "card_id" INTEGER,
    "transaction_date" DATE,
    "station_id" INTEGER,
    "price_value" REAL,
    "transaction_time" TEXT
);