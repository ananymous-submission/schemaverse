CREATE TABLE "object_categories" (
    "object_category_id" INTEGER DEFAULT 0,
    "object_category_name" TEXT NOT NULL
);

CREATE TABLE "predicted_categories" (
    "predicted_category_id" INTEGER DEFAULT 0,
    "predicted_category_name" TEXT NOT NULL
);

CREATE TABLE "image_object_samples_height_le_26" (
    "image_record_id" INTEGER DEFAULT 0,
    "object_sample_key" INTEGER DEFAULT 0,
    "height_pixels" INTEGER,
    "object_category_id" INTEGER,
    "width_pixels" INTEGER,
    FOREIGN KEY ("object_category_id") REFERENCES "object_categories"("object_category_id")
);

CREATE TABLE "image_object_samples_height_27_to_58" (
    "image_record_id" INTEGER DEFAULT 0,
    "object_sample_key" INTEGER DEFAULT 0,
    "height_pixels" INTEGER,
    "object_category_id" INTEGER,
    "width_pixels" INTEGER,
    FOREIGN KEY ("object_category_id") REFERENCES "object_categories"("object_category_id")
);

CREATE TABLE "image_object_samples_height_59_to_129" (
    "image_record_id" INTEGER DEFAULT 0,
    "object_sample_key" INTEGER DEFAULT 0,
    "height_pixels" INTEGER,
    "object_category_id" INTEGER,
    "width_pixels" INTEGER
);