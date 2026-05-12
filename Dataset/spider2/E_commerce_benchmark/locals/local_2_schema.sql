CREATE TABLE "category_name_translations_map" (
    "category_key" TEXT,
    "category_name_en" TEXT
);

CREATE TABLE "bedding_bath_and_sports_products" (
    "product_sku" TEXT,
    "category_key" TEXT,
    "description_length_chars" REAL,
    "length_cm" REAL,
    "name_length_chars" REAL,
    "photos_count" REAL,
    "weight_g" REAL
);

CREATE TABLE "furniture_toys_and_gifts_products" (
    "product_sku" TEXT,
    "category_key" TEXT,
    "description_length_chars" REAL,
    "length_cm" REAL,
    "name_length_chars" REAL,
    "photos_count" REAL,
    "weight_g" REAL
);

CREATE TABLE "beauty_health_and_household_products" (
    "product_sku" TEXT,
    "category_key" TEXT,
    "description_length_chars" REAL,
    "length_cm" REAL,
    "name_length_chars" REAL,
    "photos_count" REAL,
    "weight_g" REAL
);

CREATE TABLE "auto_and_computer_accessories_products" (
    "product_sku" TEXT,
    "category_key" TEXT,
    "description_length_chars" REAL,
    "length_cm" REAL,
    "name_length_chars" REAL,
    "photos_count" REAL,
    "weight_g" REAL
);

CREATE TABLE "other_or_unclassified_products" (
    "product_sku" TEXT,
    "category_key" TEXT,
    "description_length_chars" REAL,
    "length_cm" REAL,
    "name_length_chars" REAL,
    "photos_count" REAL,
    "weight_g" REAL
);

CREATE TABLE "product_master_catalog" (
    "product_sku" TEXT,
    "category_key" TEXT,
    "height_cm" REAL,
    "length_cm" REAL,
    "photos_count" REAL,
    "weight_g" REAL,
    "width_cm" REAL
);