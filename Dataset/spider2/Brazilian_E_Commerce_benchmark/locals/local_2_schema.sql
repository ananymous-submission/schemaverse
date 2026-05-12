CREATE TABLE "products_master_bed_bath_and_sports" (
    "product_sku" TEXT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_master_furniture_toys_and_gifts" (
    "product_sku" TEXT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_master_beauty_health_and_household" (
    "product_sku" TEXT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_master_automotive_and_it_accessories" (
    "product_sku" TEXT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_master_other" (
    "product_sku" TEXT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_master_dimensions" (
    "product_sku" TEXT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "height_cm_value" FLOAT,
    "length_cm_value" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT,
    "width_cm_value" FLOAT
);

CREATE TABLE "products_dataset_index_bed_bath_and_sports" (
    "product_sku" TEXT,
    "dataset_index" BIGINT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_dataset_index_furniture_toys_and_gifts" (
    "product_sku" TEXT,
    "dataset_index" BIGINT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_dataset_index_beauty_health_and_household" (
    "product_sku" TEXT,
    "dataset_index" BIGINT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_dataset_index_automotive_and_it_accessories" (
    "product_sku" TEXT,
    "dataset_index" BIGINT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_dataset_index_other" (
    "product_sku" TEXT,
    "dataset_index" BIGINT,
    "category_label" TEXT,
    "description_length_chars" FLOAT,
    "name_length_chars" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT
);

CREATE TABLE "products_dataset_index_dimensions" (
    "product_sku" TEXT,
    "dataset_index" BIGINT,
    "category_label" TEXT,
    "height_cm_value" FLOAT,
    "length_cm_value" FLOAT,
    "photo_count" FLOAT,
    "weight_grams" FLOAT,
    "width_cm_value" FLOAT
);

CREATE TABLE "category_translation_map" (
    "category_label_original" TEXT,
    "category_label_english" TEXT
);