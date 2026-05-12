CREATE TABLE "encryption_cipher_map" (
    "encryption_identifier" TEXT DEFAULT '',
    "cipher_name" TEXT DEFAULT NULL,
    "control_location_ref" TEXT NOT NULL,
    "is_deleted" INTEGER DEFAULT NULL,
    "key_length" INTEGER DEFAULT NULL,
    "provider_name" TEXT NOT NULL,
    "volume_type_identifier" TEXT NOT NULL
);

CREATE TABLE "encryption_control_registry" (
    "encryption_identifier" TEXT DEFAULT '',
    "control_location_detail" TEXT NOT NULL,
    "created_timestamp" TEXT DEFAULT NULL,
    "is_deleted" INTEGER DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "key_length" INTEGER DEFAULT NULL,
    "provider_name" TEXT NOT NULL,
    "updated_timestamp" TEXT DEFAULT NULL
);

CREATE TABLE "volume_type_extra_options" (
    "created_timestamp" TEXT DEFAULT NULL,
    "updated_timestamp" TEXT DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "is_deleted" INTEGER DEFAULT NULL,
    "extra_option_id" INTEGER,
    "volume_type_identifier" TEXT NOT NULL,
    "option_key" TEXT DEFAULT NULL,
    "option_value" TEXT DEFAULT NULL
);

CREATE TABLE "volume_type_records_with_creation" (
    "volume_type_identifier" TEXT,
    "created_timestamp" TEXT DEFAULT NULL,
    "is_deleted" INTEGER DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "description_text" TEXT DEFAULT NULL,
    "is_public_flag" INTEGER DEFAULT NULL,
    "type_name" TEXT DEFAULT NULL,
    "updated_timestamp" TEXT DEFAULT NULL
);

CREATE TABLE "volume_attachments_instance_9b309acd_a62c_436e_b116_ff7554e6ec1e" (
    "attachment_id" TEXT,
    "attach_mode_type" TEXT DEFAULT NULL,
    "attach_state" TEXT DEFAULT NULL,
    "attached_host_name" TEXT DEFAULT NULL,
    "is_deleted" INTEGER DEFAULT NULL,
    "instance_reference_uuid" TEXT DEFAULT NULL,
    "mount_point" TEXT DEFAULT NULL,
    "volume_identifier" TEXT NOT NULL,
    FOREIGN KEY ("volume_identifier") REFERENCES "volume_attach_status_detached"("volume_identifier"),
    FOREIGN KEY ("volume_identifier") REFERENCES "volume_attach_status_attached_or_null"("volume_identifier")
);

CREATE TABLE "volume_attachments_instance_f651937a_8bcd_43f1_910e_f5b61fa358ac" (
    "attachment_id" TEXT,
    "attach_mode_type" TEXT DEFAULT NULL,
    "attach_state" TEXT DEFAULT NULL,
    "attached_host_name" TEXT DEFAULT NULL,
    "is_deleted" INTEGER DEFAULT NULL,
    "instance_reference_uuid" TEXT DEFAULT NULL,
    "mount_point" TEXT DEFAULT NULL,
    "volume_identifier" TEXT NOT NULL,
    FOREIGN KEY ("volume_identifier") REFERENCES "volume_boot_attributes"("volume_identifier"),
    FOREIGN KEY ("volume_identifier") REFERENCES "volume_attach_status_detached"("volume_identifier")
);

CREATE TABLE "volume_attachments_instance_64d7cd79_6dc6_404c_b603_8cdd4f9263a0" (
    "attachment_id" TEXT,
    "attach_mode_type" TEXT DEFAULT NULL,
    "attach_state" TEXT DEFAULT NULL,
    "attached_host_name" TEXT DEFAULT NULL,
    "is_deleted" INTEGER DEFAULT NULL,
    "instance_reference_uuid" TEXT DEFAULT NULL,
    "mount_point" TEXT DEFAULT NULL,
    "volume_identifier" TEXT NOT NULL,
    FOREIGN KEY ("volume_identifier") REFERENCES "volume_event_timestamps"("volume_identifier")
);

CREATE TABLE "volume_attachments_for_selected_instances" (
    "attachment_id" TEXT,
    "attach_mode_type" TEXT DEFAULT NULL,
    "attach_state" TEXT DEFAULT NULL,
    "attached_host_name" TEXT DEFAULT NULL,
    "is_deleted" INTEGER DEFAULT NULL,
    "instance_reference_uuid" TEXT DEFAULT NULL,
    "mount_point" TEXT DEFAULT NULL,
    "volume_identifier" TEXT NOT NULL,
    FOREIGN KEY ("volume_identifier") REFERENCES "volume_event_timestamps"("volume_identifier"),
    FOREIGN KEY ("volume_identifier") REFERENCES "volume_boot_attributes"("volume_identifier"),
    FOREIGN KEY ("volume_identifier") REFERENCES "volume_attach_status_attached_or_null"("volume_identifier")
);

CREATE TABLE "volume_event_timestamps" (
    "volume_identifier" TEXT,
    "created_timestamp" TEXT DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "launched_timestamp" TEXT DEFAULT NULL,
    "scheduled_timestamp" TEXT DEFAULT NULL,
    "terminated_timestamp" TEXT DEFAULT NULL,
    "updated_timestamp" TEXT DEFAULT NULL
);

CREATE TABLE "volume_boot_attributes" (
    "volume_identifier" TEXT,
    "is_bootable" INTEGER DEFAULT NULL,
    "is_deleted" INTEGER DEFAULT NULL,
    "description_text" TEXT DEFAULT NULL,
    "display_label" TEXT DEFAULT NULL,
    "host_name" TEXT DEFAULT NULL,
    "multi_attach_enabled" INTEGER DEFAULT NULL
);

CREATE TABLE "volume_attach_status_detached" (
    "volume_identifier" TEXT,
    "attach_state" TEXT DEFAULT NULL,
    "availability_zone_name" TEXT DEFAULT NULL,
    "migration_state" TEXT DEFAULT NULL,
    "previous_state" TEXT DEFAULT NULL,
    "replication_driver_info" TEXT DEFAULT NULL,
    "replication_extended_info" TEXT DEFAULT NULL,
    "replication_state" TEXT DEFAULT NULL,
    "current_status" TEXT DEFAULT NULL
);

CREATE TABLE "volume_attach_status_attached_or_null" (
    "volume_identifier" TEXT,
    "attach_state" TEXT DEFAULT NULL,
    "availability_zone_name" TEXT DEFAULT NULL,
    "migration_state" TEXT DEFAULT NULL,
    "previous_state" TEXT DEFAULT NULL,
    "replication_driver_info" TEXT DEFAULT NULL,
    "replication_extended_info" TEXT DEFAULT NULL,
    "replication_state" TEXT DEFAULT NULL,
    "current_status" TEXT DEFAULT NULL
);

CREATE TABLE "qos_specs_deletion_archive" (
    "deletion_id" TEXT,
    "is_deleted" INTEGER DEFAULT NULL,
    "spec_key" TEXT DEFAULT NULL,
    "specs_identifier" TEXT DEFAULT NULL,
    "spec_value" TEXT DEFAULT NULL
);