-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/SchemaVerse/extra_hard/beaver/_staging/csail_stata_glance/csail_stata_glance.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "art_blob_refs" (
    "blob_uid" TEXT,
    "art_ref" TEXT NOT NULL,
    "ck_sum" TEXT DEFAULT NULL,
    "itm_key" TEXT DEFAULT NULL,
    "obj_name" TEXT NOT NULL,
    "pos" INTEGER DEFAULT NULL,
    "sz_bytes" INTEGER NOT NULL,
    FOREIGN KEY ("art_ref") REFERENCES "art_meta_add"("art_uid"),
    FOREIGN KEY ("art_ref") REFERENCES "art_meta_desc"("art_uid")
);

CREATE TABLE "art_deps_dest" (
    "dep_uid" TEXT,
    "art_dest_ref" TEXT NOT NULL,
    "art_origin_ref" TEXT NOT NULL,
    "art_src_ref" TEXT NOT NULL,
    "direct_flg" INTEGER NOT NULL,
    "rel_name" TEXT DEFAULT NULL,
    "pos" INTEGER DEFAULT NULL,
    "ts_updated" TEXT NOT NULL,
    FOREIGN KEY ("art_origin_ref") REFERENCES "art_type_meta"("type_uid"),
    FOREIGN KEY ("art_dest_ref") REFERENCES "art_meta_add"("art_uid"),
    FOREIGN KEY ("art_dest_ref") REFERENCES "art_meta_desc"("art_uid"),
    FOREIGN KEY ("art_dest_ref") REFERENCES "art_type_meta"("type_uid"),
    FOREIGN KEY ("art_src_ref") REFERENCES "art_meta_desc"("art_uid"),
    FOREIGN KEY ("art_src_ref") REFERENCES "art_type_meta"("type_uid")
);

CREATE TABLE "art_deps_meta" (
    "dep_uid" TEXT,
    "ts_created" TEXT NOT NULL,
    "direct_flg" INTEGER NOT NULL,
    "rel_name" TEXT DEFAULT NULL,
    "pos" INTEGER DEFAULT NULL,
    "ts_updated" TEXT NOT NULL
);

CREATE TABLE "art_props_meta" (
    "prop_uid" TEXT,
    "art_ref" TEXT NOT NULL,
    "ts_created" TEXT NOT NULL,
    "prop_name" TEXT NOT NULL,
    "pos" INTEGER DEFAULT NULL,
    "ts_updated" TEXT NOT NULL,
    FOREIGN KEY ("art_ref") REFERENCES "art_type_meta"("type_uid")
);

CREATE TABLE "art_prop_vals" (
    "prop_val_uid" TEXT,
    "art_ref" TEXT NOT NULL,
    "val_bool" INTEGER DEFAULT NULL,
    "val_int" INTEGER DEFAULT NULL,
    "prop_name" TEXT NOT NULL,
    "val_num" REAL DEFAULT NULL,
    "pos" INTEGER DEFAULT NULL,
    "val_str" TEXT DEFAULT NULL,
    "val_text" TEXT,
    "ts_updated" TEXT NOT NULL,
    FOREIGN KEY ("art_ref") REFERENCES "art_type_meta"("type_uid")
);

CREATE TABLE "art_tags" (
    "tag_uid" TEXT,
    "art_ref" TEXT NOT NULL,
    "tag_val" TEXT NOT NULL,
    "ts_created" TEXT NOT NULL,
    "ts_updated" TEXT NOT NULL,
    FOREIGN KEY ("art_ref") REFERENCES "art_type_meta"("type_uid")
);

CREATE TABLE "art_meta_add" (
    "art_uid" TEXT,
    "ts_created" TEXT NOT NULL,
    "ts_deleted" TEXT DEFAULT NULL,
    "desc_txt" TEXT,
    "art_name" TEXT NOT NULL,
    "owner_ref" TEXT NOT NULL,
    "ts_published" TEXT DEFAULT NULL,
    "st" TEXT NOT NULL,
    "ts_updated" TEXT NOT NULL,
    "vis" TEXT NOT NULL
);

CREATE TABLE "art_meta_desc" (
    "art_uid" TEXT,
    "desc_txt" TEXT,
    "art_name" TEXT NOT NULL,
    "owner_ref" TEXT NOT NULL,
    "st" TEXT NOT NULL,
    "type_ref" TEXT NOT NULL,
    "ver_pref" INTEGER NOT NULL,
    "vis" TEXT NOT NULL
);

CREATE TABLE "art_type_meta" (
    "type_uid" TEXT,
    "ty_name" TEXT NOT NULL,
    "ty_ver_meta" TEXT DEFAULT NULL,
    "ty_ver_pref" INTEGER NOT NULL,
    "ty_ver_suf" TEXT DEFAULT NULL,
    "ver_meta" TEXT DEFAULT NULL,
    "ver_pref" INTEGER NOT NULL,
    "ver_suf" TEXT DEFAULT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "image_locations_deleted_nonpositive" (
    "location_record_id" INTEGER,
    "created_timestamp" TEXT NOT NULL,
    "deleted_flag" INTEGER NOT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "image_ref_id" TEXT NOT NULL,
    "metadata_json" TEXT,
    "record_status" TEXT NOT NULL DEFAULT 'active',
    "updated_timestamp" TEXT DEFAULT NULL,
    FOREIGN KEY ("image_ref_id") REFERENCES "images_master_checksum"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_by_creation_timestamp"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_checksum_known_names_bucket"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_checksum_other_or_null"("image_id_pk")
);

CREATE TABLE "image_locations_deleted_positive_or_null" (
    "location_record_id" INTEGER,
    "created_timestamp" TEXT NOT NULL,
    "deleted_flag" INTEGER NOT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "image_ref_id" TEXT NOT NULL,
    "metadata_json" TEXT,
    "record_status" TEXT NOT NULL DEFAULT 'active',
    "updated_timestamp" TEXT DEFAULT NULL
);

CREATE TABLE "image_locations_removed" (
    "location_record_id" INTEGER,
    "deleted_flag" INTEGER NOT NULL,
    "image_ref_id" TEXT NOT NULL,
    "metadata_json" TEXT,
    "record_status" TEXT NOT NULL DEFAULT 'active',
    "location_value" TEXT NOT NULL,
    FOREIGN KEY ("image_ref_id") REFERENCES "images_by_container_and_disk_format"("image_id_pk")
);

CREATE TABLE "image_properties_created_before_2014_12_02_17_48_10" (
    "property_record_id" INTEGER,
    "created_timestamp" TEXT NOT NULL,
    "deleted_flag" INTEGER NOT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "image_ref_id" TEXT NOT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "property_value" TEXT,
    FOREIGN KEY ("image_ref_id") REFERENCES "images_master_checksum"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_by_container_and_disk_format"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_by_creation_timestamp"("image_id_pk")
);

CREATE TABLE "image_properties_created_2014_12_02_to_2016_09_27_14_14_35" (
    "property_record_id" INTEGER,
    "created_timestamp" TEXT NOT NULL,
    "deleted_flag" INTEGER NOT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "image_ref_id" TEXT NOT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "property_value" TEXT,
    FOREIGN KEY ("image_ref_id") REFERENCES "images_master_checksum"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_checksum_other_or_null"("image_id_pk")
);

CREATE TABLE "image_properties_created_2016_09_27_to_2021_01_28_17_22_32" (
    "property_record_id" INTEGER,
    "created_timestamp" TEXT NOT NULL,
    "deleted_flag" INTEGER NOT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "image_ref_id" TEXT NOT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "property_value" TEXT,
    FOREIGN KEY ("image_ref_id") REFERENCES "images_master_checksum"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_by_container_and_disk_format"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_checksum_known_names_bucket"("image_id_pk")
);

CREATE TABLE "image_properties_created_after_2021_01_28_or_null" (
    "property_record_id" INTEGER,
    "created_timestamp" TEXT NOT NULL,
    "deleted_flag" INTEGER NOT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "image_ref_id" TEXT NOT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "property_value" TEXT,
    FOREIGN KEY ("image_ref_id") REFERENCES "images_by_container_and_disk_format"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_by_creation_timestamp"("image_id_pk")
);

CREATE TABLE "image_properties_removed" (
    "property_record_id" INTEGER,
    "deleted_flag" INTEGER NOT NULL,
    "image_ref_id" TEXT NOT NULL,
    "property_name" TEXT NOT NULL,
    "property_value" TEXT,
    FOREIGN KEY ("image_ref_id") REFERENCES "images_master_checksum"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_by_container_and_disk_format"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_by_creation_timestamp"("image_id_pk")
);

CREATE TABLE "image_tags_created_before_2017_11_12_01_24_39" (
    "tag_id" INTEGER,
    "image_ref_id" TEXT NOT NULL,
    "tag_value" TEXT NOT NULL,
    "created_timestamp" TEXT NOT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "deleted_flag" INTEGER NOT NULL,
    FOREIGN KEY ("image_ref_id") REFERENCES "images_master_checksum"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_by_container_and_disk_format"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_by_creation_timestamp"("image_id_pk")
);

CREATE TABLE "image_tags_created_2017_11_12_to_2019_02_07_18_27_19" (
    "tag_id" INTEGER,
    "image_ref_id" TEXT NOT NULL,
    "tag_value" TEXT NOT NULL,
    "created_timestamp" TEXT NOT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "deleted_flag" INTEGER NOT NULL,
    FOREIGN KEY ("image_ref_id") REFERENCES "images_by_creation_timestamp"("image_id_pk")
);

CREATE TABLE "image_tags_created_2019_02_07_to_2020_02_13_14_42_44" (
    "tag_id" INTEGER,
    "image_ref_id" TEXT NOT NULL,
    "tag_value" TEXT NOT NULL,
    "created_timestamp" TEXT NOT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "deleted_flag" INTEGER NOT NULL,
    FOREIGN KEY ("image_ref_id") REFERENCES "images_by_container_and_disk_format"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_checksum_known_names_bucket"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_checksum_other_or_null"("image_id_pk")
);

CREATE TABLE "image_tags_created_after_2020_02_13_or_null" (
    "tag_id" INTEGER,
    "image_ref_id" TEXT NOT NULL,
    "tag_value" TEXT NOT NULL,
    "created_timestamp" TEXT NOT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "deleted_flag" INTEGER NOT NULL,
    FOREIGN KEY ("image_ref_id") REFERENCES "images_master_checksum"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_checksum_known_names_bucket"("image_id_pk")
);

CREATE TABLE "images_master_checksum" (
    "image_id_pk" TEXT,
    "checksum_value" TEXT DEFAULT NULL,
    "min_disk_gb" INTEGER NOT NULL,
    "min_ram_mb" INTEGER NOT NULL,
    "image_name" TEXT DEFAULT NULL,
    "owner_id" TEXT DEFAULT NULL,
    "file_size_bytes" INTEGER DEFAULT NULL,
    "image_status" TEXT NOT NULL,
    "virtual_size_gb" INTEGER DEFAULT NULL
);

CREATE TABLE "images_by_container_and_disk_format" (
    "image_id_pk" TEXT,
    "container_format_type" TEXT DEFAULT NULL,
    "disk_format_type" TEXT DEFAULT NULL,
    "min_disk_gb" INTEGER NOT NULL,
    "owner_id" TEXT DEFAULT NULL
);

CREATE TABLE "images_by_creation_timestamp" (
    "image_id_pk" TEXT,
    "created_timestamp" TEXT NOT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "updated_timestamp" TEXT DEFAULT NULL
);

CREATE TABLE "images_checksum_known_names_bucket" (
    "image_id_pk" TEXT,
    "checksum_value" TEXT DEFAULT NULL,
    "deleted_flag" INTEGER NOT NULL,
    "public_flag" INTEGER NOT NULL,
    "min_ram_mb" INTEGER NOT NULL,
    "image_name" TEXT DEFAULT NULL,
    "protected_flag" INTEGER NOT NULL DEFAULT '0',
    "file_size_bytes" INTEGER DEFAULT NULL,
    "image_status" TEXT NOT NULL
);

CREATE TABLE "images_checksum_other_or_null" (
    "image_id_pk" TEXT,
    "checksum_value" TEXT DEFAULT NULL,
    "deleted_flag" INTEGER NOT NULL,
    "public_flag" INTEGER NOT NULL,
    "min_ram_mb" INTEGER NOT NULL,
    "image_name" TEXT DEFAULT NULL,
    "protected_flag" INTEGER NOT NULL DEFAULT '0',
    "file_size_bytes" INTEGER DEFAULT NULL,
    "image_status" TEXT NOT NULL
);

CREATE TABLE "image_members_sharing_with_timestamps" (
    "membership_record_id" INTEGER,
    "can_share_flag" INTEGER NOT NULL,
    "created_timestamp" TEXT NOT NULL,
    "deleted_flag" INTEGER NOT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "record_status" TEXT NOT NULL DEFAULT 'pending',
    "updated_timestamp" TEXT DEFAULT NULL
);

CREATE TABLE "image_members_share_member_98333a1a28e746fa8c629c83a818ad57" (
    "membership_record_id" INTEGER,
    "can_share_flag" INTEGER NOT NULL,
    "deleted_flag" INTEGER NOT NULL,
    "image_ref_id" TEXT NOT NULL,
    "member_id" TEXT NOT NULL,
    "record_status" TEXT NOT NULL DEFAULT 'pending',
    "updated_timestamp" TEXT DEFAULT NULL,
    FOREIGN KEY ("image_ref_id") REFERENCES "images_checksum_known_names_bucket"("image_id_pk")
);

CREATE TABLE "image_members_share_member_17ea94ad74b64b9d92f4888336a598c7_and_47c0857cf5b5452a86f640fd44be1d40" (
    "membership_record_id" INTEGER,
    "can_share_flag" INTEGER NOT NULL,
    "deleted_flag" INTEGER NOT NULL,
    "image_ref_id" TEXT NOT NULL,
    "member_id" TEXT NOT NULL,
    "record_status" TEXT NOT NULL DEFAULT 'pending',
    "updated_timestamp" TEXT DEFAULT NULL,
    FOREIGN KEY ("image_ref_id") REFERENCES "images_master_checksum"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_by_container_and_disk_format"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_by_creation_timestamp"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_checksum_known_names_bucket"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_checksum_other_or_null"("image_id_pk")
);

CREATE TABLE "image_members_share_members_1140b46602e84c47838f707b060d6fd2_4e101cf5264b4e739b7b5ebe0f6b5c68_56c81513d259464a9a58763f4eed2432" (
    "membership_record_id" INTEGER,
    "can_share_flag" INTEGER NOT NULL,
    "deleted_flag" INTEGER NOT NULL,
    "image_ref_id" TEXT NOT NULL,
    "member_id" TEXT NOT NULL,
    "record_status" TEXT NOT NULL DEFAULT 'pending',
    "updated_timestamp" TEXT DEFAULT NULL,
    FOREIGN KEY ("image_ref_id") REFERENCES "images_by_container_and_disk_format"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_by_creation_timestamp"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_checksum_known_names_bucket"("image_id_pk"),
    FOREIGN KEY ("image_ref_id") REFERENCES "images_checksum_other_or_null"("image_id_pk")
);

CREATE TABLE "image_members_share_members_3008a142e9524f7295b06ea811908f93_d3ac3958f14941cdb205e76ba43bbe49" (
    "membership_record_id" INTEGER,
    "can_share_flag" INTEGER NOT NULL,
    "deleted_flag" INTEGER NOT NULL,
    "image_ref_id" TEXT NOT NULL,
    "member_id" TEXT NOT NULL,
    "record_status" TEXT NOT NULL DEFAULT 'pending',
    "updated_timestamp" TEXT DEFAULT NULL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "namespaceDefinitions" (
    "namespaceId" INTEGER,
    "namespaceKey" TEXT NOT NULL,
    "displayName" TEXT DEFAULT NULL,
    "descriptionText" TEXT,
    "visibilityPolicy" TEXT DEFAULT NULL,
    "isProtected" INTEGER DEFAULT NULL,
    "ownerName" TEXT NOT NULL,
    "createdAt" TEXT NOT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "metadataObjects" (
    "objectId" INTEGER,
    "namespaceId" INTEGER NOT NULL,
    "objectName" TEXT NOT NULL,
    "descriptionText" TEXT,
    "requiredFields" TEXT,
    "jsonSchema" TEXT NOT NULL,
    "createdAt" TEXT NOT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "metadataProperties" (
    "propertyId" INTEGER,
    "namespaceId" INTEGER NOT NULL,
    "propertyName" TEXT NOT NULL,
    "jsonSchema" TEXT NOT NULL,
    "createdAt" TEXT NOT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "metadataTags" (
    "tagId" INTEGER,
    "namespaceId" INTEGER NOT NULL,
    "tagName" TEXT NOT NULL,
    "createdAt" TEXT NOT NULL,
    "updatedAt" TEXT DEFAULT NULL,
    FOREIGN KEY ("namespaceId") REFERENCES "namespaceDefinitions"("namespaceId")
);

CREATE TABLE "namespaceResourceTypePrefixes" (
    "resourceTypeId" INTEGER,
    "namespaceId" INTEGER,
    "resourcePrefix" TEXT DEFAULT NULL,
    "propertiesTarget" TEXT DEFAULT NULL,
    FOREIGN KEY ("namespaceId") REFERENCES "namespaceDefinitions"("namespaceId")
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "BlobAssetLocations" (
    "LocationId" TEXT,
    "ChecksumId" TEXT NOT NULL,
    "LocationValue" TEXT NOT NULL,
    "CreatedTimestamp" TEXT NOT NULL,
    "UpdatedTimestamp" TEXT NOT NULL,
    "DisplayOrder" INTEGER DEFAULT NULL,
    "LifecycleStatus" TEXT DEFAULT NULL,
    FOREIGN KEY ("ChecksumId") REFERENCES "BlobChecksums"("ChecksumId")
);

CREATE TABLE "NamespaceResourceTypeRecords" (
    "ResourceTypeId" INTEGER,
    "NamespaceId" INTEGER,
    "AssociationCreatedAt" TEXT NOT NULL,
    "NamePrefix" TEXT DEFAULT NULL,
    "TargetProperties" TEXT DEFAULT NULL,
    "AssociationUpdatedAt" TEXT DEFAULT NULL,
    FOREIGN KEY ("ResourceTypeId") REFERENCES "ResourceTypeDefinitions"("ResourceTypeId")
);

CREATE TABLE "ResourceTypeDefinitions" (
    "ResourceTypeId" INTEGER,
    "TypeName" TEXT NOT NULL,
    "IsProtected" INTEGER NOT NULL,
    "CreatedTimestamp" TEXT NOT NULL,
    "UpdatedTimestamp" TEXT DEFAULT NULL
);

CREATE TABLE "BlobChecksums" (
    "ChecksumId" TEXT,
    "Digest" TEXT DEFAULT NULL,
    "CreatedTimestamp" TEXT NOT NULL,
    "ObjectKey" TEXT DEFAULT NULL,
    "OrderIndex" INTEGER DEFAULT NULL,
    "ByteSize" INTEGER NOT NULL,
    "UpdatedTimestamp" TEXT NOT NULL
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "imageShareForMember09ad0543" (
    "shareId" INTEGER,
    "isShareable" INTEGER NOT NULL,
    "isDeleted" INTEGER NOT NULL,
    "imageId" TEXT NOT NULL,
    "memberId" TEXT NOT NULL,
    "shareStatus" TEXT NOT NULL DEFAULT 'pending',
    "lastUpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "imageShareForOtherMembers" (
    "shareId" INTEGER,
    "isShareable" INTEGER NOT NULL,
    "isDeleted" INTEGER NOT NULL,
    "imageId" TEXT NOT NULL,
    "memberId" TEXT NOT NULL,
    "shareStatus" TEXT NOT NULL DEFAULT 'pending',
    "lastUpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "migrationRepositoryVersion" (
    "repositoryId" TEXT,
    "repositoryPath" TEXT,
    "schemaVersion" INTEGER DEFAULT NULL
);

-- ========================================================================
-- local_6
-- DDL file: local_6_schema.sql
-- ========================================================================

CREATE TABLE "TaskDetails" (
    "TaskIdentifier" TEXT,
    "InputPayload" TEXT,
    "OutputResult" TEXT,
    "StatusMessage" TEXT
);

CREATE TABLE "TaskLifecycle" (
    "LifecycleId" TEXT,
    "CreationTimestamp" TEXT NOT NULL,
    "IsDeleted" INTEGER NOT NULL,
    "DeletionTimestamp" TEXT DEFAULT NULL,
    "ExpirationTimestamp" TEXT DEFAULT NULL,
    "OwnerIdentifier" TEXT NOT NULL,
    "TaskCategory" TEXT NOT NULL,
    "ModificationTimestamp" TEXT DEFAULT NULL
);

CREATE TABLE "TaskDeletionLog" (
    "DeletionRecordId" TEXT,
    "WasDeleted" INTEGER NOT NULL,
    "ExpirationTimestamp" TEXT DEFAULT NULL,
    "OwnerIdentifier" TEXT NOT NULL,
    "DeletionStatus" TEXT NOT NULL,
    "TaskCategory" TEXT NOT NULL
);

