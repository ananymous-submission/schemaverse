CREATE TABLE "instance_group_membership" (
    "membership_created_timestamp" TEXT DEFAULT NULL,
    "membership_modified_timestamp" TEXT DEFAULT NULL,
    "membership_deleted_timestamp" TEXT DEFAULT NULL,
    "membership_is_deleted" INTEGER DEFAULT NULL,
    "membership_id" INTEGER,
    "instance_uuid" TEXT DEFAULT NULL,
    "instance_group_id" INTEGER NOT NULL,
    FOREIGN KEY ("instance_group_id") REFERENCES "instance_group_record_created"("instance_group_id"),
    FOREIGN KEY ("instance_group_id") REFERENCES "instance_group_deleted_vortx_beam_glint_ether_glyph_flux"("instance_group_id")
);

CREATE TABLE "instance_action_events_terminate_audit" (
    "action_event_id" INTEGER,
    "action_ref_id" INTEGER DEFAULT NULL,
    "action_details" TEXT,
    "event_name" TEXT DEFAULT NULL,
    "host_name" TEXT DEFAULT NULL,
    "action_result" TEXT DEFAULT NULL,
    "error_traceback" TEXT
);

CREATE TABLE "instance_action_events_build_and_run_audit" (
    "action_event_id" INTEGER,
    "action_ref_id" INTEGER DEFAULT NULL,
    "action_details" TEXT,
    "event_name" TEXT DEFAULT NULL,
    "host_name" TEXT DEFAULT NULL,
    "action_result" TEXT DEFAULT NULL,
    "error_traceback" TEXT
);

CREATE TABLE "instance_action_events_schedule_audit" (
    "action_event_id" INTEGER,
    "action_ref_id" INTEGER DEFAULT NULL,
    "action_details" TEXT,
    "event_name" TEXT DEFAULT NULL,
    "host_name" TEXT DEFAULT NULL,
    "action_result" TEXT DEFAULT NULL,
    "error_traceback" TEXT
);

CREATE TABLE "instance_action_events_misc_audit" (
    "action_event_id" INTEGER,
    "action_ref_id" INTEGER DEFAULT NULL,
    "action_details" TEXT,
    "event_name" TEXT DEFAULT NULL,
    "host_name" TEXT DEFAULT NULL,
    "action_result" TEXT DEFAULT NULL,
    "error_traceback" TEXT
);

CREATE TABLE "instance_action_event_timings_archive" (
    "action_event_id" INTEGER,
    "event_created_timestamp" TEXT DEFAULT NULL,
    "is_deleted" INTEGER DEFAULT NULL,
    "deleted_timestamp" TEXT DEFAULT NULL,
    "finished_at" TEXT DEFAULT NULL,
    "started_at" TEXT DEFAULT NULL,
    "event_modified_timestamp" TEXT DEFAULT NULL
);

CREATE TABLE "instance_action_event_outcome_audit" (
    "action_event_id" INTEGER,
    "action_ref_id" INTEGER DEFAULT NULL,
    "is_deleted" INTEGER DEFAULT NULL,
    "action_details" TEXT,
    "action_result" TEXT DEFAULT NULL,
    "error_traceback" TEXT
);

CREATE TABLE "instance_type_project_deleted_pre_2014_04_27" (
    "link_created_timestamp" TEXT DEFAULT NULL,
    "link_modified_timestamp" TEXT DEFAULT NULL,
    "link_deleted_timestamp" TEXT DEFAULT NULL,
    "type_project_link_id" INTEGER,
    "instance_type_ref_id" INTEGER NOT NULL,
    "project_uuid" TEXT DEFAULT NULL,
    "is_deleted" INTEGER DEFAULT NULL
);

CREATE TABLE "instance_type_project_deleted_2014_04_27_to_2014_10_14" (
    "link_created_timestamp" TEXT DEFAULT NULL,
    "link_modified_timestamp" TEXT DEFAULT NULL,
    "link_deleted_timestamp" TEXT DEFAULT NULL,
    "type_project_link_id" INTEGER,
    "instance_type_ref_id" INTEGER NOT NULL,
    "project_uuid" TEXT DEFAULT NULL,
    "is_deleted" INTEGER DEFAULT NULL
);

CREATE TABLE "instance_type_project_deleted_2014_10_14_to_2015_04_10" (
    "link_created_timestamp" TEXT DEFAULT NULL,
    "link_modified_timestamp" TEXT DEFAULT NULL,
    "link_deleted_timestamp" TEXT DEFAULT NULL,
    "type_project_link_id" INTEGER,
    "instance_type_ref_id" INTEGER NOT NULL,
    "project_uuid" TEXT DEFAULT NULL,
    "is_deleted" INTEGER DEFAULT NULL
);

CREATE TABLE "instance_type_project_deleted_post_2015_04_10_or_null" (
    "link_created_timestamp" TEXT DEFAULT NULL,
    "link_modified_timestamp" TEXT DEFAULT NULL,
    "link_deleted_timestamp" TEXT DEFAULT NULL,
    "type_project_link_id" INTEGER,
    "instance_type_ref_id" INTEGER NOT NULL,
    "project_uuid" TEXT DEFAULT NULL,
    "is_deleted" INTEGER DEFAULT NULL
);

CREATE TABLE "snapshot_id_mappings_archive" (
    "mapping_created_timestamp" TEXT DEFAULT NULL,
    "mapping_modified_timestamp" TEXT DEFAULT NULL,
    "mapping_deleted_timestamp" TEXT DEFAULT NULL,
    "mapping_id" INTEGER,
    "snapshot_uuid" TEXT NOT NULL,
    "is_deleted" INTEGER DEFAULT NULL
);

CREATE TABLE "snapshot_record_created_archive" (
    "snapshot_uuid" TEXT,
    "snapshot_created_timestamp" TEXT DEFAULT NULL,
    "snapshot_deleted_timestamp" TEXT DEFAULT NULL,
    "scheduled_timestamp" TEXT DEFAULT NULL,
    "snapshot_modified_timestamp" TEXT DEFAULT NULL
);

CREATE TABLE "snapshot_deleted_details" (
    "snapshot_uuid" TEXT,
    "is_deleted" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "display_title" TEXT DEFAULT NULL,
    "progress_percent" TEXT DEFAULT NULL,
    "lifecycle_status" TEXT DEFAULT NULL,
    "size_gb" INTEGER DEFAULT NULL
);

CREATE TABLE "snapshot_deleted_with_owner" (
    "snapshot_uuid" TEXT,
    "is_deleted" TEXT DEFAULT NULL,
    "description" TEXT DEFAULT NULL,
    "display_title" TEXT DEFAULT NULL,
    "progress_percent" TEXT DEFAULT NULL,
    "project_uuid" TEXT DEFAULT NULL,
    "lifecycle_status" TEXT DEFAULT NULL,
    "owner_user_uuid" TEXT DEFAULT NULL,
    "volume_uuid" TEXT NOT NULL,
    "size_gb" INTEGER DEFAULT NULL
);

CREATE TABLE "instance_group_record_created" (
    "instance_group_id" INTEGER,
    "group_created_timestamp" TEXT DEFAULT NULL,
    "group_is_deleted" INTEGER DEFAULT NULL,
    "group_deleted_timestamp" TEXT DEFAULT NULL,
    "group_label" TEXT DEFAULT NULL,
    "group_modified_timestamp" TEXT DEFAULT NULL,
    "group_uuid" TEXT NOT NULL
);

CREATE TABLE "instance_group_deleted_array_lyric" (
    "instance_group_id" INTEGER,
    "group_is_deleted" INTEGER DEFAULT NULL,
    "group_label" TEXT DEFAULT NULL,
    "project_uuid" TEXT DEFAULT NULL,
    "group_modified_timestamp" TEXT DEFAULT NULL,
    "owner_user_uuid" TEXT DEFAULT NULL,
    "group_uuid" TEXT NOT NULL
);

CREATE TABLE "instance_group_deleted_helio_glint4" (
    "instance_group_id" INTEGER,
    "group_is_deleted" INTEGER DEFAULT NULL,
    "group_label" TEXT DEFAULT NULL,
    "project_uuid" TEXT DEFAULT NULL,
    "group_modified_timestamp" TEXT DEFAULT NULL,
    "owner_user_uuid" TEXT DEFAULT NULL,
    "group_uuid" TEXT NOT NULL
);

CREATE TABLE "instance_group_deleted_scope_speed" (
    "instance_group_id" INTEGER,
    "group_is_deleted" INTEGER DEFAULT NULL,
    "group_label" TEXT DEFAULT NULL,
    "project_uuid" TEXT DEFAULT NULL,
    "group_modified_timestamp" TEXT DEFAULT NULL,
    "owner_user_uuid" TEXT DEFAULT NULL,
    "group_uuid" TEXT NOT NULL
);

CREATE TABLE "instance_group_deleted_vortx_beam_glint_ether_glyph_flux" (
    "instance_group_id" INTEGER,
    "group_is_deleted" INTEGER DEFAULT NULL,
    "group_label" TEXT DEFAULT NULL,
    "project_uuid" TEXT DEFAULT NULL,
    "group_modified_timestamp" TEXT DEFAULT NULL,
    "owner_user_uuid" TEXT DEFAULT NULL,
    "group_uuid" TEXT NOT NULL
);

CREATE TABLE "instance_group_deleted_comet6_twist_star_glyph4" (
    "instance_group_id" INTEGER,
    "group_is_deleted" INTEGER DEFAULT NULL,
    "group_label" TEXT DEFAULT NULL,
    "project_uuid" TEXT DEFAULT NULL,
    "group_modified_timestamp" TEXT DEFAULT NULL,
    "owner_user_uuid" TEXT DEFAULT NULL,
    "group_uuid" TEXT NOT NULL
);