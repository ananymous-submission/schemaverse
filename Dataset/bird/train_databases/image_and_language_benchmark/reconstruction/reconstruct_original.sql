-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct ATT_CLASSES from local_1.attr_cat
CREATE VIEW "ATT_CLASSES" AS
SELECT
    "local_1"."attr_cat"."attr_cat_id" AS "ATT_CLASS_ID",
    "local_1"."attr_cat"."attr_lbl" AS "ATT_CLASS"
FROM "local_1"."attr_cat";

-- Reconstruct IMG_OBJ from vertical split + row partition on a fragment
CREATE VIEW "IMG_OBJ" AS
SELECT t0.[imageId], t0.[objectSampleId], t0.[objectClassId], t1.[xCoordinate], t1.[yCoordinate], t0.[widthPixels], t0.[heightPixels]
FROM (
SELECT [imageFragmentsHeightGreater129OrNull].[__orig_rowid] AS __orig_rowid, [local_2].[imageFragmentsHeightGreater129OrNull].[imageId], [local_2].[imageFragmentsHeightGreater129OrNull].[objectSampleId], [local_2].[imageFragmentsHeightGreater129OrNull].[objectClassId], [local_2].[imageFragmentsHeightGreater129OrNull].[widthPixels], [local_2].[imageFragmentsHeightGreater129OrNull].[heightPixels] FROM [local_2].[imageFragmentsHeightGreater129OrNull]
UNION
SELECT [image_object_samples_height_27_to_58].[__orig_rowid] AS __orig_rowid, [local_3].[image_object_samples_height_27_to_58].[image_record_id], [local_3].[image_object_samples_height_27_to_58].[object_sample_key], [local_3].[image_object_samples_height_27_to_58].[object_category_id], [local_3].[image_object_samples_height_27_to_58].[width_pixels], [local_3].[image_object_samples_height_27_to_58].[height_pixels] FROM [local_3].[image_object_samples_height_27_to_58]
UNION
SELECT [image_object_samples_height_59_to_129].[__orig_rowid] AS __orig_rowid, [local_3].[image_object_samples_height_59_to_129].[image_record_id], [local_3].[image_object_samples_height_59_to_129].[object_sample_key], [local_3].[image_object_samples_height_59_to_129].[object_category_id], [local_3].[image_object_samples_height_59_to_129].[width_pixels], [local_3].[image_object_samples_height_59_to_129].[height_pixels] FROM [local_3].[image_object_samples_height_59_to_129]
UNION
SELECT [image_object_samples_height_le_26].[__orig_rowid] AS __orig_rowid, [local_3].[image_object_samples_height_le_26].[image_record_id], [local_3].[image_object_samples_height_le_26].[object_sample_key], [local_3].[image_object_samples_height_le_26].[object_category_id], [local_3].[image_object_samples_height_le_26].[width_pixels], [local_3].[image_object_samples_height_le_26].[height_pixels] FROM [local_3].[image_object_samples_height_le_26]
) t0
JOIN [local_2].[imageObjectsByClass] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct IMG_OBJ_ATT from local_1.img_obj_attr_map
CREATE VIEW "IMG_OBJ_ATT" AS
SELECT
    "local_1"."img_obj_attr_map"."img_ref_id" AS "IMG_ID",
    "local_1"."img_obj_attr_map"."attr_cat_id" AS "ATT_CLASS_ID",
    "local_1"."img_obj_attr_map"."obj_samp_id" AS "OBJ_SAMPLE_ID"
FROM "local_1"."img_obj_attr_map";

-- Reconstruct IMG_REL from local_2.imageRelationshipLinks
CREATE VIEW "IMG_REL" AS
SELECT
    "local_2"."imageRelationshipLinks"."imageId" AS "IMG_ID",
    "local_2"."imageRelationshipLinks"."predicateClassId" AS "PRED_CLASS_ID",
    "local_2"."imageRelationshipLinks"."primaryObjectSampleId" AS "OBJ1_SAMPLE_ID",
    "local_2"."imageRelationshipLinks"."relatedObjectSampleId" AS "OBJ2_SAMPLE_ID"
FROM "local_2"."imageRelationshipLinks";

-- Reconstruct OBJ_CLASSES from local_3.object_categories
CREATE VIEW "OBJ_CLASSES" AS
SELECT
    "local_3"."object_categories"."object_category_id" AS "OBJ_CLASS_ID",
    "local_3"."object_categories"."object_category_name" AS "OBJ_CLASS"
FROM "local_3"."object_categories";

-- Reconstruct PRED_CLASSES from local_3.predicted_categories
CREATE VIEW "PRED_CLASSES" AS
SELECT
    "local_3"."predicted_categories"."predicted_category_id" AS "PRED_CLASS_ID",
    "local_3"."predicted_categories"."predicted_category_name" AS "PRED_CLASS"
FROM "local_3"."predicted_categories";
