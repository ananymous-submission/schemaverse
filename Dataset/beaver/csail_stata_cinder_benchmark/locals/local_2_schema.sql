CREATE TABLE "consistency_group_snapshot_link" (
    "link_id" TEXT,
    "consistency_group_id_ref" TEXT NOT NULL,
    "project_ref" TEXT DEFAULT NULL,
    "user_ref" TEXT DEFAULT NULL,
    FOREIGN KEY ("consistency_group_id_ref") REFERENCES "consistency_group_zone_snapshot_ref"("zone_entry_id"),
    FOREIGN KEY ("consistency_group_id_ref") REFERENCES "consistency_group_created_timestamps"("created_entry_id"),
    FOREIGN KEY ("consistency_group_id_ref") REFERENCES "consistency_group_snapshot_index"("index_id")
);

CREATE TABLE "snapshot_timestamps_log" (
    "snapshot_log_id" TEXT,
    "created_timestamp" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "deletion_timestamp" TEXT DEFAULT NULL,
    "description_text" TEXT DEFAULT NULL,
    "display_name_text" TEXT DEFAULT NULL,
    "status_text" TEXT DEFAULT NULL,
    "updated_timestamp" TEXT DEFAULT NULL
);

CREATE TABLE "snapshot_deletion_record" (
    "deletion_record_id" TEXT,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "description_text" TEXT DEFAULT NULL,
    "display_name_text" TEXT DEFAULT NULL,
    "status_text" TEXT DEFAULT NULL
);

CREATE TABLE "consistency_group_location" (
    "consistency_group_id" TEXT,
    "availability_zone_name" TEXT DEFAULT NULL,
    "host_name" TEXT DEFAULT NULL,
    "group_name" TEXT DEFAULT NULL
);

CREATE TABLE "consistency_group_zone_snapshot_ref" (
    "zone_entry_id" TEXT,
    "availability_zone_name" TEXT DEFAULT NULL,
    "cgsnapshot_ref_id" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "description_text" TEXT DEFAULT NULL,
    "project_ref" TEXT DEFAULT NULL,
    "source_consistency_group_ref" TEXT DEFAULT NULL,
    "user_ref" TEXT DEFAULT NULL,
    "volume_type_ref" TEXT DEFAULT NULL
);

CREATE TABLE "consistency_group_created_timestamps" (
    "created_entry_id" TEXT,
    "created_timestamp" TEXT DEFAULT NULL,
    "deletion_timestamp" TEXT DEFAULT NULL,
    "updated_timestamp" TEXT DEFAULT NULL
);

CREATE TABLE "consistency_group_snapshot_index" (
    "index_id" TEXT,
    "cgsnapshot_ref_id" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "description_text" TEXT DEFAULT NULL,
    "source_consistency_group_ref" TEXT DEFAULT NULL,
    "status_text" TEXT DEFAULT NULL,
    "volume_type_ref" TEXT DEFAULT NULL
);

CREATE TABLE "iscsi_targets_low_target_quartile" (
    "record_id" INTEGER,
    "created_timestamp" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "target_number" INTEGER DEFAULT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "volume_ref_id" TEXT DEFAULT NULL
);

CREATE TABLE "iscsi_targets_targetnum_26_50" (
    "record_id" INTEGER,
    "created_timestamp" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "target_number" INTEGER DEFAULT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "volume_ref_id" TEXT DEFAULT NULL
);

CREATE TABLE "iscsi_targets_targetnum_51_75" (
    "record_id" INTEGER,
    "created_timestamp" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "target_number" INTEGER DEFAULT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "volume_ref_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("volume_ref_id") REFERENCES "volume_records_by_name_key"("volume_id")
);

CREATE TABLE "iscsi_targets_above_75_or_null" (
    "record_id" INTEGER,
    "created_timestamp" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "target_number" INTEGER DEFAULT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "volume_ref_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("volume_ref_id") REFERENCES "volume_records_by_name_key"("volume_id"),
    FOREIGN KEY ("volume_ref_id") REFERENCES "volume_records_extended"("volume_id")
);

CREATE TABLE "iscsi_targets_deleted_info" (
    "deleted_record_id" INTEGER,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "host_name" TEXT DEFAULT NULL,
    "target_number" INTEGER DEFAULT NULL,
    "volume_ref_id" TEXT DEFAULT NULL
);

CREATE TABLE "snapshot_metadata_created_log" (
    "meta_id" INTEGER,
    "created_timestamp" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "snapshot_ref_id" TEXT NOT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "meta_value" TEXT DEFAULT NULL,
    FOREIGN KEY ("snapshot_ref_id") REFERENCES "snapshot_consistency_reference"("snapshot_id"),
    FOREIGN KEY ("snapshot_ref_id") REFERENCES "snapshots_created_log"("snapshot_created_id"),
    FOREIGN KEY ("snapshot_ref_id") REFERENCES "snapshots_consistency_deleted_rows"("snapshot_part_id")
);

CREATE TABLE "snapshot_metadata_deleted_entries" (
    "deleted_meta_id" INTEGER,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "meta_key" TEXT DEFAULT NULL,
    "snapshot_ref_id" TEXT NOT NULL,
    "meta_value" TEXT DEFAULT NULL,
    FOREIGN KEY ("snapshot_ref_id") REFERENCES "snapshot_consistency_reference"("snapshot_id"),
    FOREIGN KEY ("snapshot_ref_id") REFERENCES "snapshots_consistency_deleted_rows"("snapshot_part_id"),
    FOREIGN KEY ("snapshot_ref_id") REFERENCES "snapshot_volume_info"("snapshot_volume_id")
);

CREATE TABLE "snapshot_consistency_reference" (
    "snapshot_id" TEXT,
    "cgsnapshot_ref_id" TEXT DEFAULT NULL,
    "display_description_text" TEXT DEFAULT NULL,
    "display_name_text" TEXT DEFAULT NULL,
    "encryption_key_ref" TEXT DEFAULT NULL,
    "progress_status" TEXT DEFAULT NULL,
    "project_ref" TEXT DEFAULT NULL,
    "provider_auth_data" TEXT DEFAULT NULL,
    "provider_identifier" TEXT DEFAULT NULL,
    "provider_location_text" TEXT DEFAULT NULL,
    "status_text" TEXT DEFAULT NULL,
    "user_ref" TEXT DEFAULT NULL,
    FOREIGN KEY ("cgsnapshot_ref_id") REFERENCES "consistency_group_snapshot_link"("link_id"),
    FOREIGN KEY ("cgsnapshot_ref_id") REFERENCES "snapshot_timestamps_log"("snapshot_log_id")
);

CREATE TABLE "snapshots_created_log" (
    "snapshot_created_id" TEXT,
    "created_timestamp" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "scheduled_timestamp" TEXT DEFAULT NULL,
    "updated_timestamp" TEXT DEFAULT NULL
);

CREATE TABLE "snapshots_consistency_deleted_rows" (
    "snapshot_part_id" TEXT,
    "cgsnapshot_ref_id" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "display_description_text" TEXT DEFAULT NULL,
    "display_name_text" TEXT DEFAULT NULL,
    "progress_status" TEXT DEFAULT NULL,
    "provider_auth_data" TEXT DEFAULT NULL,
    "provider_location_text" TEXT DEFAULT NULL,
    "status_text" TEXT DEFAULT NULL,
    FOREIGN KEY ("cgsnapshot_ref_id") REFERENCES "snapshot_timestamps_log"("snapshot_log_id"),
    FOREIGN KEY ("cgsnapshot_ref_id") REFERENCES "snapshot_deletion_record"("deletion_record_id")
);

CREATE TABLE "snapshots_consistency_varied_status_rows" (
    "snapshot_part_id" TEXT,
    "cgsnapshot_ref_id" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "display_description_text" TEXT DEFAULT NULL,
    "display_name_text" TEXT DEFAULT NULL,
    "progress_status" TEXT DEFAULT NULL,
    "provider_auth_data" TEXT DEFAULT NULL,
    "provider_location_text" TEXT DEFAULT NULL,
    "status_text" TEXT DEFAULT NULL,
    FOREIGN KEY ("cgsnapshot_ref_id") REFERENCES "consistency_group_snapshot_link"("link_id")
);

CREATE TABLE "snapshot_volume_info" (
    "snapshot_volume_id" TEXT,
    "volume_ref_id" TEXT NOT NULL,
    "size_gb" INTEGER DEFAULT NULL,
    "volume_type_ref" TEXT DEFAULT NULL,
    FOREIGN KEY ("volume_ref_id") REFERENCES "volume_records_by_name_key"("volume_id"),
    FOREIGN KEY ("volume_ref_id") REFERENCES "volume_records_extended"("volume_id")
);

CREATE TABLE "transfer_creation_log" (
    "transfer_id" TEXT,
    "created_timestamp" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "display_name_text" TEXT DEFAULT NULL,
    "expires_timestamp" TEXT DEFAULT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "volume_ref_id" TEXT NOT NULL,
    FOREIGN KEY ("volume_ref_id") REFERENCES "volume_records_by_name_key"("volume_id"),
    FOREIGN KEY ("volume_ref_id") REFERENCES "volume_records_extended"("volume_id")
);

CREATE TABLE "transfer_encryption_hashes" (
    "transfer_crypto_id" TEXT,
    "crypt_hash_value" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "display_name_text" TEXT DEFAULT NULL,
    "expires_timestamp" TEXT DEFAULT NULL,
    "crypt_salt" TEXT DEFAULT NULL,
    "volume_ref_id" TEXT NOT NULL,
    FOREIGN KEY ("volume_ref_id") REFERENCES "volume_records_extended"("volume_id")
);

CREATE TABLE "volume_admin_metadata_rw_values" (
    "admin_meta_id" INTEGER,
    "created_timestamp" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "meta_value" TEXT DEFAULT NULL,
    "volume_ref_id" TEXT NOT NULL,
    FOREIGN KEY ("volume_ref_id") REFERENCES "volume_records_extended"("volume_id")
);

CREATE TABLE "volume_admin_metadata_mixed_values" (
    "admin_meta_id" INTEGER,
    "created_timestamp" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "meta_value" TEXT DEFAULT NULL,
    "volume_ref_id" TEXT NOT NULL,
    FOREIGN KEY ("volume_ref_id") REFERENCES "volume_records_by_name_key"("volume_id")
);

CREATE TABLE "volume_admin_metadata_deleted_entries" (
    "deleted_admin_meta_id" INTEGER,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "meta_key" TEXT DEFAULT NULL,
    "meta_value" TEXT DEFAULT NULL,
    "volume_ref_id" TEXT NOT NULL
);

CREATE TABLE "volume_glance_meta_created_on_or_before_2016_04_26_22_34_47" (
    "meta_id" INTEGER,
    "created_timestamp" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "meta_key" TEXT DEFAULT NULL,
    "snapshot_ref_id" TEXT DEFAULT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "meta_value" TEXT,
    FOREIGN KEY ("snapshot_ref_id") REFERENCES "snapshot_consistency_reference"("snapshot_id"),
    FOREIGN KEY ("snapshot_ref_id") REFERENCES "snapshots_created_log"("snapshot_created_id"),
    FOREIGN KEY ("snapshot_ref_id") REFERENCES "snapshots_consistency_varied_status_rows"("snapshot_part_id")
);

CREATE TABLE "volume_glance_meta_created_between_2016_04_26_and_2018_06_24" (
    "meta_id" INTEGER,
    "created_timestamp" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "meta_key" TEXT DEFAULT NULL,
    "snapshot_ref_id" TEXT DEFAULT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "meta_value" TEXT,
    FOREIGN KEY ("snapshot_ref_id") REFERENCES "snapshots_created_log"("snapshot_created_id"),
    FOREIGN KEY ("snapshot_ref_id") REFERENCES "snapshots_consistency_deleted_rows"("snapshot_part_id"),
    FOREIGN KEY ("snapshot_ref_id") REFERENCES "snapshot_volume_info"("snapshot_volume_id")
);

CREATE TABLE "volume_glance_meta_created_between_2018_06_24_and_2020_10_21" (
    "meta_id" INTEGER,
    "created_timestamp" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "meta_key" TEXT DEFAULT NULL,
    "snapshot_ref_id" TEXT DEFAULT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "meta_value" TEXT,
    FOREIGN KEY ("snapshot_ref_id") REFERENCES "snapshot_consistency_reference"("snapshot_id"),
    FOREIGN KEY ("snapshot_ref_id") REFERENCES "snapshots_consistency_varied_status_rows"("snapshot_part_id")
);

CREATE TABLE "volume_glance_meta_created_after_2020_10_21_or_null" (
    "meta_id" INTEGER,
    "created_timestamp" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "meta_key" TEXT DEFAULT NULL,
    "snapshot_ref_id" TEXT DEFAULT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "meta_value" TEXT,
    FOREIGN KEY ("snapshot_ref_id") REFERENCES "snapshots_created_log"("snapshot_created_id"),
    FOREIGN KEY ("snapshot_ref_id") REFERENCES "snapshots_consistency_deleted_rows"("snapshot_part_id"),
    FOREIGN KEY ("snapshot_ref_id") REFERENCES "snapshots_consistency_varied_status_rows"("snapshot_part_id"),
    FOREIGN KEY ("snapshot_ref_id") REFERENCES "snapshot_volume_info"("snapshot_volume_id")
);

CREATE TABLE "volume_glance_meta_deleted_entries" (
    "deleted_meta_id" INTEGER,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "meta_key" TEXT DEFAULT NULL,
    "snapshot_ref_id" TEXT DEFAULT NULL,
    "meta_value" TEXT,
    "volume_ref_id" TEXT DEFAULT NULL,
    FOREIGN KEY ("snapshot_ref_id") REFERENCES "snapshot_volume_info"("snapshot_volume_id"),
    FOREIGN KEY ("volume_ref_id") REFERENCES "volume_records_by_name_key"("volume_id"),
    FOREIGN KEY ("volume_ref_id") REFERENCES "volume_records_extended"("volume_id")
);

CREATE TABLE "volume_metadata_created_log" (
    "meta_id" INTEGER,
    "created_timestamp" TEXT DEFAULT NULL,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "meta_key" TEXT DEFAULT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "volume_ref_id" TEXT NOT NULL,
    FOREIGN KEY ("volume_ref_id") REFERENCES "volume_records_by_name_key"("volume_id")
);

CREATE TABLE "volume_metadata_deleted_value_flare2_55" (
    "deleted_meta_id" INTEGER,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "meta_key" TEXT DEFAULT NULL,
    "meta_value" TEXT DEFAULT NULL,
    "volume_ref_id" TEXT NOT NULL,
    FOREIGN KEY ("volume_ref_id") REFERENCES "volume_records_extended"("volume_id")
);

CREATE TABLE "volume_metadata_deleted_specific_values" (
    "deleted_meta_id" INTEGER,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "meta_key" TEXT DEFAULT NULL,
    "meta_value" TEXT DEFAULT NULL,
    "volume_ref_id" TEXT NOT NULL,
    FOREIGN KEY ("volume_ref_id") REFERENCES "volume_records_extended"("volume_id")
);

CREATE TABLE "volume_metadata_deleted_other_values" (
    "deleted_meta_id" INTEGER,
    "is_deleted_flag" INTEGER DEFAULT NULL,
    "meta_key" TEXT DEFAULT NULL,
    "meta_value" TEXT DEFAULT NULL,
    "volume_ref_id" TEXT NOT NULL
);

CREATE TABLE "volume_records_by_name_key" (
    "volume_id" TEXT,
    "name_key" TEXT DEFAULT NULL,
    "availability_zone_name" TEXT DEFAULT NULL,
    "consistency_group_ref" TEXT DEFAULT NULL,
    "display_description_text" TEXT DEFAULT NULL,
    "display_name_text" TEXT DEFAULT NULL,
    "ec2_instance_id" TEXT DEFAULT NULL,
    "encryption_key_ref" TEXT DEFAULT NULL,
    "host_name" TEXT DEFAULT NULL,
    "provider_auth_data" TEXT DEFAULT NULL,
    "provider_geometry_info" TEXT DEFAULT NULL,
    "provider_identifier" TEXT DEFAULT NULL,
    "provider_location_text" TEXT DEFAULT NULL,
    "replication_driver_info" TEXT DEFAULT NULL,
    "replication_status_info" TEXT DEFAULT NULL,
    "size_gb" INTEGER DEFAULT NULL,
    "snapshot_ref_id" TEXT DEFAULT NULL,
    "volume_type_ref" TEXT DEFAULT NULL
);

CREATE TABLE "volume_records_extended" (
    "volume_id" TEXT,
    "name_key" TEXT DEFAULT NULL,
    "consistency_group_ref" TEXT DEFAULT NULL,
    "ec2_instance_id" TEXT DEFAULT NULL,
    "encryption_key_ref" TEXT DEFAULT NULL,
    "project_ref" TEXT DEFAULT NULL,
    "provider_identifier" TEXT DEFAULT NULL,
    "size_gb" INTEGER DEFAULT NULL,
    "snapshot_ref_id" TEXT DEFAULT NULL,
    "source_volume_ref" TEXT DEFAULT NULL,
    "user_ref" TEXT DEFAULT NULL,
    "volume_type_ref" TEXT DEFAULT NULL,
    FOREIGN KEY ("consistency_group_ref") REFERENCES "consistency_group_location"("consistency_group_id")
);