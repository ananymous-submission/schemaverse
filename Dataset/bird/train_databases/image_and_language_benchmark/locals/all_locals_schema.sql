-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/image_and_language/image_and_language.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "attr_cat" (
    "attr_cat_id" INTEGER DEFAULT 0,
    "attr_lbl" TEXT NOT NULL
);

CREATE TABLE "img_obj_attr_map" (
    "img_ref_id" INTEGER DEFAULT 0,
    "attr_cat_id" INTEGER DEFAULT 0,
    "obj_samp_id" INTEGER DEFAULT 0
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "imageFragmentsHeightGreater129OrNull" (
    "imageId" INTEGER DEFAULT 0,
    "objectSampleId" INTEGER DEFAULT 0,
    "heightPixels" INTEGER,
    "objectClassId" INTEGER,
    "widthPixels" INTEGER
);

CREATE TABLE "imageObjectsByClass" (
    "imageId" INTEGER DEFAULT 0,
    "objectSampleId" INTEGER DEFAULT 0,
    "objectClassId" INTEGER,
    "widthPixels" INTEGER,
    "xCoordinate" INTEGER,
    "yCoordinate" INTEGER
);

CREATE TABLE "imageRelationshipLinks" (
    "imageId" INTEGER DEFAULT 0,
    "predicateClassId" INTEGER DEFAULT 0,
    "primaryObjectSampleId" INTEGER DEFAULT 0,
    "relatedObjectSampleId" INTEGER DEFAULT 0,
    FOREIGN KEY ("imageId") REFERENCES "imageFragmentsHeightGreater129OrNull"("imageId"),
    FOREIGN KEY ("relatedObjectSampleId") REFERENCES "imageObjectsByClass"("objectSampleId"),
    FOREIGN KEY ("imageId") REFERENCES "imageFragmentsHeightGreater129OrNull"("imageId"),
    FOREIGN KEY ("imageId") REFERENCES "imageObjectsByClass"("imageId")
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

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

