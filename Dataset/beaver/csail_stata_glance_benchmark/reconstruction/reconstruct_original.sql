-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";
ATTACH DATABASE 'local_6.sqlite' AS "local_6";

-- Reconstruct artifact_blob_locations from local_4.BlobAssetLocations
CREATE VIEW "artifact_blob_locations" AS
SELECT
    "local_4"."BlobAssetLocations"."LocationId" AS "id",
    "local_4"."BlobAssetLocations"."ChecksumId" AS "blob_id",
    "local_4"."BlobAssetLocations"."LocationValue" AS "value",
    "local_4"."BlobAssetLocations"."CreatedTimestamp" AS "created_at",
    "local_4"."BlobAssetLocations"."UpdatedTimestamp" AS "updated_at",
    "local_4"."BlobAssetLocations"."DisplayOrder" AS "position",
    "local_4"."BlobAssetLocations"."LifecycleStatus" AS "status"
FROM "local_4"."BlobAssetLocations";

-- Reconstruct artifact_blobs from vertical (column) split (2 fragments)
CREATE VIEW "artifact_blobs" AS
SELECT
    t0."ChecksumId" AS "id",
    t1."art_ref" AS "artifact_id",
    t0."ByteSize" AS "size",
    t0."Digest" AS "checksum",
    t1."obj_name" AS "name",
    t0."ObjectKey" AS "item_key",
    t0."OrderIndex" AS "position",
    t0."CreatedTimestamp" AS "created_at",
    t0."UpdatedTimestamp" AS "updated_at"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "ChecksumId" ORDER BY rowid) AS __rn FROM "local_4"."BlobChecksums") t0
JOIN "local_1"."art_blob_refs" t1 ON t0."ChecksumId" IS t1."blob_uid" AND t0.__rn = t1.__rn;

-- Reconstruct artifact_dependencies from vertical (column) split (2 fragments)
CREATE VIEW "artifact_dependencies" AS
SELECT
    t0."dep_uid" AS "id",
    t0."art_src_ref" AS "artifact_source",
    t0."art_dest_ref" AS "artifact_dest",
    t0."art_origin_ref" AS "artifact_origin",
    t0."direct_flg" AS "is_direct",
    t0."pos" AS "position",
    t0."rel_name" AS "name",
    t1."ts_created" AS "created_at",
    t0."ts_updated" AS "updated_at"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "dep_uid" ORDER BY rowid) AS __rn FROM "local_1"."art_deps_dest") t0
JOIN "local_1"."art_deps_meta" t1 ON t0."dep_uid" IS t1."dep_uid" AND t0.__rn = t1.__rn;

-- Reconstruct artifact_properties from vertical (column) split (2 fragments)
CREATE VIEW "artifact_properties" AS
SELECT
    t0."prop_val_uid" AS "id",
    t0."art_ref" AS "artifact_id",
    t0."prop_name" AS "name",
    t0."val_str" AS "string_value",
    t0."val_int" AS "int_value",
    t0."val_num" AS "numeric_value",
    t0."val_bool" AS "bool_value",
    t0."val_text" AS "text_value",
    t1."ts_created" AS "created_at",
    t0."ts_updated" AS "updated_at",
    t0."pos" AS "position"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "prop_val_uid" ORDER BY rowid) AS __rn FROM "local_1"."art_prop_vals") t0
JOIN "local_1"."art_props_meta" t1 ON t0."prop_val_uid" IS t1."prop_uid" AND t0.__rn = t1.__rn;

-- Reconstruct artifact_tags from local_1.art_tags
CREATE VIEW "artifact_tags" AS
SELECT
    "local_1"."art_tags"."tag_uid" AS "id",
    "local_1"."art_tags"."art_ref" AS "artifact_id",
    "local_1"."art_tags"."tag_val" AS "value",
    "local_1"."art_tags"."ts_created" AS "created_at",
    "local_1"."art_tags"."ts_updated" AS "updated_at"
FROM "local_1"."art_tags";

-- Reconstruct artifacts from vertical (column) split (3 fragments)
CREATE VIEW "artifacts" AS
SELECT
    t0."art_uid" AS "id",
    t0."art_name" AS "name",
    t1."type_ref" AS "type_name",
    t2."ty_ver_pref" AS "type_version_prefix",
    t2."ty_ver_suf" AS "type_version_suffix",
    t2."ty_ver_meta" AS "type_version_meta",
    t1."ver_pref" AS "version_prefix",
    t2."ver_suf" AS "version_suffix",
    t2."ver_meta" AS "version_meta",
    t0."desc_txt" AS "description",
    t0."vis" AS "visibility",
    t0."st" AS "state",
    t0."owner_ref" AS "owner",
    t0."ts_created" AS "created_at",
    t0."ts_updated" AS "updated_at",
    t0."ts_deleted" AS "deleted_at",
    t0."ts_published" AS "published_at"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "art_uid" ORDER BY rowid) AS __rn FROM "local_1"."art_meta_add") t0
JOIN "local_1"."art_meta_desc" t1 ON t0."art_uid" IS t1."art_uid" AND t0.__rn = t1.__rn
JOIN "local_1"."art_type_meta" t2 ON t0."art_uid" IS t2."type_uid" AND t0.__rn = t2.__rn;

-- Reconstruct image_locations from vertical split + row partition on a fragment
CREATE VIEW "image_locations" AS
SELECT t0.[location_record_id], t0.[image_ref_id], t1.[location_value], t0.[created_timestamp], t0.[updated_timestamp], t0.[deleted_timestamp], t0.[deleted_flag], t0.[metadata_json], t0.[record_status]
FROM (
SELECT [image_locations_deleted_nonpositive].[__orig_rowid] AS __orig_rowid, [local_2].[image_locations_deleted_nonpositive].[location_record_id], [local_2].[image_locations_deleted_nonpositive].[image_ref_id], [local_2].[image_locations_deleted_nonpositive].[created_timestamp], [local_2].[image_locations_deleted_nonpositive].[updated_timestamp], [local_2].[image_locations_deleted_nonpositive].[deleted_timestamp], [local_2].[image_locations_deleted_nonpositive].[deleted_flag], [local_2].[image_locations_deleted_nonpositive].[metadata_json], [local_2].[image_locations_deleted_nonpositive].[record_status] FROM [local_2].[image_locations_deleted_nonpositive]
UNION
SELECT [image_locations_deleted_positive_or_null].[__orig_rowid] AS __orig_rowid, [local_2].[image_locations_deleted_positive_or_null].[location_record_id], [local_2].[image_locations_deleted_positive_or_null].[image_ref_id], [local_2].[image_locations_deleted_positive_or_null].[created_timestamp], [local_2].[image_locations_deleted_positive_or_null].[updated_timestamp], [local_2].[image_locations_deleted_positive_or_null].[deleted_timestamp], [local_2].[image_locations_deleted_positive_or_null].[deleted_flag], [local_2].[image_locations_deleted_positive_or_null].[metadata_json], [local_2].[image_locations_deleted_positive_or_null].[record_status] FROM [local_2].[image_locations_deleted_positive_or_null]
) t0
JOIN [local_2].[image_locations_removed] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct image_members from vertical split + row partition on a fragment
CREATE VIEW "image_members" AS
SELECT t0.[membership_record_id], t0.[image_ref_id], t0.[member_id], t0.[can_share_flag], t1.[created_timestamp], t0.[updated_timestamp], t1.[deleted_timestamp], t0.[deleted_flag], t0.[record_status]
FROM (
SELECT [image_members_share_member_17ea94ad74b64b9d92f4888336a598c7_and_47c0857cf5b5452a86f640fd44be1d40].[__orig_rowid] AS __orig_rowid, [local_2].[image_members_share_member_17ea94ad74b64b9d92f4888336a598c7_and_47c0857cf5b5452a86f640fd44be1d40].[membership_record_id], [local_2].[image_members_share_member_17ea94ad74b64b9d92f4888336a598c7_and_47c0857cf5b5452a86f640fd44be1d40].[image_ref_id], [local_2].[image_members_share_member_17ea94ad74b64b9d92f4888336a598c7_and_47c0857cf5b5452a86f640fd44be1d40].[member_id], [local_2].[image_members_share_member_17ea94ad74b64b9d92f4888336a598c7_and_47c0857cf5b5452a86f640fd44be1d40].[can_share_flag], [local_2].[image_members_share_member_17ea94ad74b64b9d92f4888336a598c7_and_47c0857cf5b5452a86f640fd44be1d40].[updated_timestamp], [local_2].[image_members_share_member_17ea94ad74b64b9d92f4888336a598c7_and_47c0857cf5b5452a86f640fd44be1d40].[deleted_flag], [local_2].[image_members_share_member_17ea94ad74b64b9d92f4888336a598c7_and_47c0857cf5b5452a86f640fd44be1d40].[record_status] FROM [local_2].[image_members_share_member_17ea94ad74b64b9d92f4888336a598c7_and_47c0857cf5b5452a86f640fd44be1d40]
UNION
SELECT [image_members_share_member_98333a1a28e746fa8c629c83a818ad57].[__orig_rowid] AS __orig_rowid, [local_2].[image_members_share_member_98333a1a28e746fa8c629c83a818ad57].[membership_record_id], [local_2].[image_members_share_member_98333a1a28e746fa8c629c83a818ad57].[image_ref_id], [local_2].[image_members_share_member_98333a1a28e746fa8c629c83a818ad57].[member_id], [local_2].[image_members_share_member_98333a1a28e746fa8c629c83a818ad57].[can_share_flag], [local_2].[image_members_share_member_98333a1a28e746fa8c629c83a818ad57].[updated_timestamp], [local_2].[image_members_share_member_98333a1a28e746fa8c629c83a818ad57].[deleted_flag], [local_2].[image_members_share_member_98333a1a28e746fa8c629c83a818ad57].[record_status] FROM [local_2].[image_members_share_member_98333a1a28e746fa8c629c83a818ad57]
UNION
SELECT [image_members_share_members_1140b46602e84c47838f707b060d6fd2_4e101cf5264b4e739b7b5ebe0f6b5c68_56c81513d259464a9a58763f4eed2432].[__orig_rowid] AS __orig_rowid, [local_2].[image_members_share_members_1140b46602e84c47838f707b060d6fd2_4e101cf5264b4e739b7b5ebe0f6b5c68_56c81513d259464a9a58763f4eed2432].[membership_record_id], [local_2].[image_members_share_members_1140b46602e84c47838f707b060d6fd2_4e101cf5264b4e739b7b5ebe0f6b5c68_56c81513d259464a9a58763f4eed2432].[image_ref_id], [local_2].[image_members_share_members_1140b46602e84c47838f707b060d6fd2_4e101cf5264b4e739b7b5ebe0f6b5c68_56c81513d259464a9a58763f4eed2432].[member_id], [local_2].[image_members_share_members_1140b46602e84c47838f707b060d6fd2_4e101cf5264b4e739b7b5ebe0f6b5c68_56c81513d259464a9a58763f4eed2432].[can_share_flag], [local_2].[image_members_share_members_1140b46602e84c47838f707b060d6fd2_4e101cf5264b4e739b7b5ebe0f6b5c68_56c81513d259464a9a58763f4eed2432].[updated_timestamp], [local_2].[image_members_share_members_1140b46602e84c47838f707b060d6fd2_4e101cf5264b4e739b7b5ebe0f6b5c68_56c81513d259464a9a58763f4eed2432].[deleted_flag], [local_2].[image_members_share_members_1140b46602e84c47838f707b060d6fd2_4e101cf5264b4e739b7b5ebe0f6b5c68_56c81513d259464a9a58763f4eed2432].[record_status] FROM [local_2].[image_members_share_members_1140b46602e84c47838f707b060d6fd2_4e101cf5264b4e739b7b5ebe0f6b5c68_56c81513d259464a9a58763f4eed2432]
UNION
SELECT [image_members_share_members_3008a142e9524f7295b06ea811908f93_d3ac3958f14941cdb205e76ba43bbe49].[__orig_rowid] AS __orig_rowid, [local_2].[image_members_share_members_3008a142e9524f7295b06ea811908f93_d3ac3958f14941cdb205e76ba43bbe49].[membership_record_id], [local_2].[image_members_share_members_3008a142e9524f7295b06ea811908f93_d3ac3958f14941cdb205e76ba43bbe49].[image_ref_id], [local_2].[image_members_share_members_3008a142e9524f7295b06ea811908f93_d3ac3958f14941cdb205e76ba43bbe49].[member_id], [local_2].[image_members_share_members_3008a142e9524f7295b06ea811908f93_d3ac3958f14941cdb205e76ba43bbe49].[can_share_flag], [local_2].[image_members_share_members_3008a142e9524f7295b06ea811908f93_d3ac3958f14941cdb205e76ba43bbe49].[updated_timestamp], [local_2].[image_members_share_members_3008a142e9524f7295b06ea811908f93_d3ac3958f14941cdb205e76ba43bbe49].[deleted_flag], [local_2].[image_members_share_members_3008a142e9524f7295b06ea811908f93_d3ac3958f14941cdb205e76ba43bbe49].[record_status] FROM [local_2].[image_members_share_members_3008a142e9524f7295b06ea811908f93_d3ac3958f14941cdb205e76ba43bbe49]
UNION
SELECT [imageShareForMember09ad0543].[__orig_rowid] AS __orig_rowid, [local_5].[imageShareForMember09ad0543].[shareId], [local_5].[imageShareForMember09ad0543].[imageId], [local_5].[imageShareForMember09ad0543].[memberId], [local_5].[imageShareForMember09ad0543].[isShareable], [local_5].[imageShareForMember09ad0543].[lastUpdatedAt], [local_5].[imageShareForMember09ad0543].[isDeleted], [local_5].[imageShareForMember09ad0543].[shareStatus] FROM [local_5].[imageShareForMember09ad0543]
UNION
SELECT [imageShareForOtherMembers].[__orig_rowid] AS __orig_rowid, [local_5].[imageShareForOtherMembers].[shareId], [local_5].[imageShareForOtherMembers].[imageId], [local_5].[imageShareForOtherMembers].[memberId], [local_5].[imageShareForOtherMembers].[isShareable], [local_5].[imageShareForOtherMembers].[lastUpdatedAt], [local_5].[imageShareForOtherMembers].[isDeleted], [local_5].[imageShareForOtherMembers].[shareStatus] FROM [local_5].[imageShareForOtherMembers]
) t0
JOIN [local_2].[image_members_sharing_with_timestamps] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct image_properties from vertical split + row partition on a fragment
CREATE VIEW "image_properties" AS
SELECT t0.[property_record_id], t0.[image_ref_id], t1.[property_name], t0.[property_value], t0.[created_timestamp], t0.[updated_timestamp], t0.[deleted_timestamp], t0.[deleted_flag]
FROM (
SELECT [image_properties_created_2014_12_02_to_2016_09_27_14_14_35].[__orig_rowid] AS __orig_rowid, [local_2].[image_properties_created_2014_12_02_to_2016_09_27_14_14_35].[property_record_id], [local_2].[image_properties_created_2014_12_02_to_2016_09_27_14_14_35].[image_ref_id], [local_2].[image_properties_created_2014_12_02_to_2016_09_27_14_14_35].[property_value], [local_2].[image_properties_created_2014_12_02_to_2016_09_27_14_14_35].[created_timestamp], [local_2].[image_properties_created_2014_12_02_to_2016_09_27_14_14_35].[updated_timestamp], [local_2].[image_properties_created_2014_12_02_to_2016_09_27_14_14_35].[deleted_timestamp], [local_2].[image_properties_created_2014_12_02_to_2016_09_27_14_14_35].[deleted_flag] FROM [local_2].[image_properties_created_2014_12_02_to_2016_09_27_14_14_35]
UNION
SELECT [image_properties_created_2016_09_27_to_2021_01_28_17_22_32].[__orig_rowid] AS __orig_rowid, [local_2].[image_properties_created_2016_09_27_to_2021_01_28_17_22_32].[property_record_id], [local_2].[image_properties_created_2016_09_27_to_2021_01_28_17_22_32].[image_ref_id], [local_2].[image_properties_created_2016_09_27_to_2021_01_28_17_22_32].[property_value], [local_2].[image_properties_created_2016_09_27_to_2021_01_28_17_22_32].[created_timestamp], [local_2].[image_properties_created_2016_09_27_to_2021_01_28_17_22_32].[updated_timestamp], [local_2].[image_properties_created_2016_09_27_to_2021_01_28_17_22_32].[deleted_timestamp], [local_2].[image_properties_created_2016_09_27_to_2021_01_28_17_22_32].[deleted_flag] FROM [local_2].[image_properties_created_2016_09_27_to_2021_01_28_17_22_32]
UNION
SELECT [image_properties_created_after_2021_01_28_or_null].[__orig_rowid] AS __orig_rowid, [local_2].[image_properties_created_after_2021_01_28_or_null].[property_record_id], [local_2].[image_properties_created_after_2021_01_28_or_null].[image_ref_id], [local_2].[image_properties_created_after_2021_01_28_or_null].[property_value], [local_2].[image_properties_created_after_2021_01_28_or_null].[created_timestamp], [local_2].[image_properties_created_after_2021_01_28_or_null].[updated_timestamp], [local_2].[image_properties_created_after_2021_01_28_or_null].[deleted_timestamp], [local_2].[image_properties_created_after_2021_01_28_or_null].[deleted_flag] FROM [local_2].[image_properties_created_after_2021_01_28_or_null]
UNION
SELECT [image_properties_created_before_2014_12_02_17_48_10].[__orig_rowid] AS __orig_rowid, [local_2].[image_properties_created_before_2014_12_02_17_48_10].[property_record_id], [local_2].[image_properties_created_before_2014_12_02_17_48_10].[image_ref_id], [local_2].[image_properties_created_before_2014_12_02_17_48_10].[property_value], [local_2].[image_properties_created_before_2014_12_02_17_48_10].[created_timestamp], [local_2].[image_properties_created_before_2014_12_02_17_48_10].[updated_timestamp], [local_2].[image_properties_created_before_2014_12_02_17_48_10].[deleted_timestamp], [local_2].[image_properties_created_before_2014_12_02_17_48_10].[deleted_flag] FROM [local_2].[image_properties_created_before_2014_12_02_17_48_10]
) t0
JOIN [local_2].[image_properties_removed] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct image_tags from row partitions (UNION (overlap))
CREATE VIEW "image_tags" AS
SELECT "local_2"."image_tags_created_before_2017_11_12_01_24_39"."tag_id" AS "id", "local_2"."image_tags_created_before_2017_11_12_01_24_39"."image_ref_id" AS "image_id", "local_2"."image_tags_created_before_2017_11_12_01_24_39"."tag_value" AS "value", "local_2"."image_tags_created_before_2017_11_12_01_24_39"."created_timestamp" AS "created_at", "local_2"."image_tags_created_before_2017_11_12_01_24_39"."updated_timestamp" AS "updated_at", "local_2"."image_tags_created_before_2017_11_12_01_24_39"."deleted_timestamp" AS "deleted_at", "local_2"."image_tags_created_before_2017_11_12_01_24_39"."deleted_flag" AS "deleted" FROM "local_2"."image_tags_created_before_2017_11_12_01_24_39"
UNION
SELECT "local_2"."image_tags_created_2017_11_12_to_2019_02_07_18_27_19"."tag_id" AS "id", "local_2"."image_tags_created_2017_11_12_to_2019_02_07_18_27_19"."image_ref_id" AS "image_id", "local_2"."image_tags_created_2017_11_12_to_2019_02_07_18_27_19"."tag_value" AS "value", "local_2"."image_tags_created_2017_11_12_to_2019_02_07_18_27_19"."created_timestamp" AS "created_at", "local_2"."image_tags_created_2017_11_12_to_2019_02_07_18_27_19"."updated_timestamp" AS "updated_at", "local_2"."image_tags_created_2017_11_12_to_2019_02_07_18_27_19"."deleted_timestamp" AS "deleted_at", "local_2"."image_tags_created_2017_11_12_to_2019_02_07_18_27_19"."deleted_flag" AS "deleted" FROM "local_2"."image_tags_created_2017_11_12_to_2019_02_07_18_27_19"
UNION
SELECT "local_2"."image_tags_created_2019_02_07_to_2020_02_13_14_42_44"."tag_id" AS "id", "local_2"."image_tags_created_2019_02_07_to_2020_02_13_14_42_44"."image_ref_id" AS "image_id", "local_2"."image_tags_created_2019_02_07_to_2020_02_13_14_42_44"."tag_value" AS "value", "local_2"."image_tags_created_2019_02_07_to_2020_02_13_14_42_44"."created_timestamp" AS "created_at", "local_2"."image_tags_created_2019_02_07_to_2020_02_13_14_42_44"."updated_timestamp" AS "updated_at", "local_2"."image_tags_created_2019_02_07_to_2020_02_13_14_42_44"."deleted_timestamp" AS "deleted_at", "local_2"."image_tags_created_2019_02_07_to_2020_02_13_14_42_44"."deleted_flag" AS "deleted" FROM "local_2"."image_tags_created_2019_02_07_to_2020_02_13_14_42_44"
UNION
SELECT "local_2"."image_tags_created_after_2020_02_13_or_null"."tag_id" AS "id", "local_2"."image_tags_created_after_2020_02_13_or_null"."image_ref_id" AS "image_id", "local_2"."image_tags_created_after_2020_02_13_or_null"."tag_value" AS "value", "local_2"."image_tags_created_after_2020_02_13_or_null"."created_timestamp" AS "created_at", "local_2"."image_tags_created_after_2020_02_13_or_null"."updated_timestamp" AS "updated_at", "local_2"."image_tags_created_after_2020_02_13_or_null"."deleted_timestamp" AS "deleted_at", "local_2"."image_tags_created_after_2020_02_13_or_null"."deleted_flag" AS "deleted" FROM "local_2"."image_tags_created_after_2020_02_13_or_null";

-- Reconstruct images from vertical split + row partition on a fragment
CREATE VIEW "images" AS
SELECT t0.[image_id_pk], t0.[image_name], t0.[file_size_bytes], t0.[image_status], t1.[public_flag], t3.[created_timestamp], t3.[updated_timestamp], t3.[deleted_timestamp], t1.[deleted_flag], t2.[disk_format_type], t2.[container_format_type], t0.[checksum_value], t0.[owner_id], t0.[min_disk_gb], t0.[min_ram_mb], t1.[protected_flag], t0.[virtual_size_gb]
FROM [local_2].[images_master_checksum] t0
JOIN (
SELECT [images_checksum_known_names_bucket].[__orig_rowid] AS __orig_rowid, [local_2].[images_checksum_known_names_bucket].[image_id_pk], [local_2].[images_checksum_known_names_bucket].[image_name], [local_2].[images_checksum_known_names_bucket].[file_size_bytes], [local_2].[images_checksum_known_names_bucket].[image_status], [local_2].[images_checksum_known_names_bucket].[public_flag], [local_2].[images_checksum_known_names_bucket].[deleted_flag], [local_2].[images_checksum_known_names_bucket].[checksum_value], [local_2].[images_checksum_known_names_bucket].[min_ram_mb], [local_2].[images_checksum_known_names_bucket].[protected_flag] FROM [local_2].[images_checksum_known_names_bucket]
UNION
SELECT [images_checksum_other_or_null].[__orig_rowid] AS __orig_rowid, [local_2].[images_checksum_other_or_null].[image_id_pk], [local_2].[images_checksum_other_or_null].[image_name], [local_2].[images_checksum_other_or_null].[file_size_bytes], [local_2].[images_checksum_other_or_null].[image_status], [local_2].[images_checksum_other_or_null].[public_flag], [local_2].[images_checksum_other_or_null].[deleted_flag], [local_2].[images_checksum_other_or_null].[checksum_value], [local_2].[images_checksum_other_or_null].[min_ram_mb], [local_2].[images_checksum_other_or_null].[protected_flag] FROM [local_2].[images_checksum_other_or_null]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_2].[images_by_container_and_disk_format] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_2].[images_by_creation_timestamp] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct metadef_namespace_resource_types from vertical (column) split (2 fragments)
CREATE VIEW "metadef_namespace_resource_types" AS
SELECT
    t0."ResourceTypeId" AS "resource_type_id",
    t0."NamespaceId" AS "namespace_id",
    t0."TargetProperties" AS "properties_target",
    t0."NamePrefix" AS "prefix",
    t0."AssociationCreatedAt" AS "created_at",
    t0."AssociationUpdatedAt" AS "updated_at"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "ResourceTypeId", "NamespaceId" ORDER BY rowid) AS __rn FROM "local_4"."NamespaceResourceTypeRecords") t0
JOIN "local_3"."namespaceResourceTypePrefixes" t1 ON t0."ResourceTypeId" IS t1."resourceTypeId" AND t0."NamespaceId" IS t1."namespaceId" AND t0.__rn = t1.__rn;

-- Reconstruct metadef_namespaces from local_3.namespaceDefinitions
CREATE VIEW "metadef_namespaces" AS
SELECT
    "local_3"."namespaceDefinitions"."namespaceId" AS "id",
    "local_3"."namespaceDefinitions"."namespaceKey" AS "namespace",
    "local_3"."namespaceDefinitions"."displayName" AS "display_name",
    "local_3"."namespaceDefinitions"."descriptionText" AS "description",
    "local_3"."namespaceDefinitions"."visibilityPolicy" AS "visibility",
    "local_3"."namespaceDefinitions"."isProtected" AS "protected",
    "local_3"."namespaceDefinitions"."ownerName" AS "owner",
    "local_3"."namespaceDefinitions"."createdAt" AS "created_at",
    "local_3"."namespaceDefinitions"."updatedAt" AS "updated_at"
FROM "local_3"."namespaceDefinitions";

-- Reconstruct metadef_objects from local_3.metadataObjects
CREATE VIEW "metadef_objects" AS
SELECT
    "local_3"."metadataObjects"."objectId" AS "id",
    "local_3"."metadataObjects"."namespaceId" AS "namespace_id",
    "local_3"."metadataObjects"."objectName" AS "name",
    "local_3"."metadataObjects"."descriptionText" AS "description",
    "local_3"."metadataObjects"."requiredFields" AS "required",
    "local_3"."metadataObjects"."jsonSchema" AS "json_schema",
    "local_3"."metadataObjects"."createdAt" AS "created_at",
    "local_3"."metadataObjects"."updatedAt" AS "updated_at"
FROM "local_3"."metadataObjects";

-- Reconstruct metadef_properties from local_3.metadataProperties
CREATE VIEW "metadef_properties" AS
SELECT
    "local_3"."metadataProperties"."propertyId" AS "id",
    "local_3"."metadataProperties"."namespaceId" AS "namespace_id",
    "local_3"."metadataProperties"."propertyName" AS "name",
    "local_3"."metadataProperties"."jsonSchema" AS "json_schema",
    "local_3"."metadataProperties"."createdAt" AS "created_at",
    "local_3"."metadataProperties"."updatedAt" AS "updated_at"
FROM "local_3"."metadataProperties";

-- Reconstruct metadef_resource_types from local_4.ResourceTypeDefinitions
CREATE VIEW "metadef_resource_types" AS
SELECT
    "local_4"."ResourceTypeDefinitions"."ResourceTypeId" AS "id",
    "local_4"."ResourceTypeDefinitions"."TypeName" AS "name",
    "local_4"."ResourceTypeDefinitions"."IsProtected" AS "protected",
    "local_4"."ResourceTypeDefinitions"."CreatedTimestamp" AS "created_at",
    "local_4"."ResourceTypeDefinitions"."UpdatedTimestamp" AS "updated_at"
FROM "local_4"."ResourceTypeDefinitions";

-- Reconstruct metadef_tags from local_3.metadataTags
CREATE VIEW "metadef_tags" AS
SELECT
    "local_3"."metadataTags"."tagId" AS "id",
    "local_3"."metadataTags"."namespaceId" AS "namespace_id",
    "local_3"."metadataTags"."tagName" AS "name",
    "local_3"."metadataTags"."createdAt" AS "created_at",
    "local_3"."metadataTags"."updatedAt" AS "updated_at"
FROM "local_3"."metadataTags";

-- Reconstruct migrate_version from local_5.migrationRepositoryVersion
CREATE VIEW "migrate_version" AS
SELECT
    "local_5"."migrationRepositoryVersion"."repositoryId" AS "repository_id",
    "local_5"."migrationRepositoryVersion"."repositoryPath" AS "repository_path",
    "local_5"."migrationRepositoryVersion"."schemaVersion" AS "version"
FROM "local_5"."migrationRepositoryVersion";

-- Reconstruct task_info from local_6.TaskDetails
CREATE VIEW "task_info" AS
SELECT
    "local_6"."TaskDetails"."TaskIdentifier" AS "task_id",
    "local_6"."TaskDetails"."InputPayload" AS "input",
    "local_6"."TaskDetails"."OutputResult" AS "result",
    "local_6"."TaskDetails"."StatusMessage" AS "message"
FROM "local_6"."TaskDetails";

-- Reconstruct tasks from vertical (column) split (2 fragments)
CREATE VIEW "tasks" AS
SELECT
    t0."DeletionRecordId" AS "id",
    t0."TaskCategory" AS "type",
    t0."DeletionStatus" AS "status",
    t0."OwnerIdentifier" AS "owner",
    t0."ExpirationTimestamp" AS "expires_at",
    t1."CreationTimestamp" AS "created_at",
    t1."ModificationTimestamp" AS "updated_at",
    t1."DeletionTimestamp" AS "deleted_at",
    t0."WasDeleted" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "DeletionRecordId" ORDER BY rowid) AS __rn FROM "local_6"."TaskDeletionLog") t0
JOIN "local_6"."TaskLifecycle" t1 ON t0."DeletionRecordId" IS t1."LifecycleId" AND t0.__rn = t1.__rn;
