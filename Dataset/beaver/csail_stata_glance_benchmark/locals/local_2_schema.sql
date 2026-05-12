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