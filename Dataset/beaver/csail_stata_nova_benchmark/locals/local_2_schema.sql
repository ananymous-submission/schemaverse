CREATE TABLE "resource_allocations" (
    "allocation_id" INTEGER,
    "provider_identifier" INTEGER NOT NULL,
    "consumer_identifier" TEXT NOT NULL,
    "resource_class_identifier" INTEGER NOT NULL,
    "used_amount" INTEGER NOT NULL
);

CREATE TABLE "instance_events_build_and_run" (
    "event_id" INTEGER,
    "related_action_id" INTEGER DEFAULT NULL,
    "deleted_flag" INTEGER DEFAULT NULL,
    "detail_text" TEXT,
    "event_name" TEXT DEFAULT NULL,
    "host_name" TEXT DEFAULT NULL,
    "result_status" TEXT DEFAULT NULL,
    "traceback_text" TEXT,
    FOREIGN KEY ("related_action_id") REFERENCES "instance_action_records"("action_id"),
    FOREIGN KEY ("related_action_id") REFERENCES "instance_action_delete_records"("action_id"),
    FOREIGN KEY ("related_action_id") REFERENCES "instance_action_reboot_records"("action_id"),
    FOREIGN KEY ("related_action_id") REFERENCES "instance_action_live_migration_records"("action_id")
);

CREATE TABLE "instance_events_terminate" (
    "event_id" INTEGER,
    "related_action_id" INTEGER DEFAULT NULL,
    "deleted_flag" INTEGER DEFAULT NULL,
    "detail_text" TEXT,
    "event_name" TEXT DEFAULT NULL,
    "host_name" TEXT DEFAULT NULL,
    "result_status" TEXT DEFAULT NULL,
    "traceback_text" TEXT,
    FOREIGN KEY ("related_action_id") REFERENCES "instance_action_reboot_records"("action_id")
);

CREATE TABLE "instance_events_reboot_and_migration" (
    "event_id" INTEGER,
    "related_action_id" INTEGER DEFAULT NULL,
    "deleted_flag" INTEGER DEFAULT NULL,
    "detail_text" TEXT,
    "event_name" TEXT DEFAULT NULL,
    "host_name" TEXT DEFAULT NULL,
    "result_status" TEXT DEFAULT NULL,
    "traceback_text" TEXT,
    FOREIGN KEY ("related_action_id") REFERENCES "instance_action_delete_records"("action_id"),
    FOREIGN KEY ("related_action_id") REFERENCES "instance_action_reboot_records"("action_id"),
    FOREIGN KEY ("related_action_id") REFERENCES "instance_action_live_migration_records"("action_id"),
    FOREIGN KEY ("related_action_id") REFERENCES "instance_action_stop_records"("action_id")
);

CREATE TABLE "instance_events_stop_and_migration_dest_check" (
    "event_id" INTEGER,
    "related_action_id" INTEGER DEFAULT NULL,
    "deleted_flag" INTEGER DEFAULT NULL,
    "detail_text" TEXT,
    "event_name" TEXT DEFAULT NULL,
    "host_name" TEXT DEFAULT NULL,
    "result_status" TEXT DEFAULT NULL,
    "traceback_text" TEXT,
    FOREIGN KEY ("related_action_id") REFERENCES "instance_action_records"("action_id"),
    FOREIGN KEY ("related_action_id") REFERENCES "instance_action_delete_records"("action_id"),
    FOREIGN KEY ("related_action_id") REFERENCES "instance_action_reboot_records"("action_id"),
    FOREIGN KEY ("related_action_id") REFERENCES "instance_action_live_migration_records"("action_id"),
    FOREIGN KEY ("related_action_id") REFERENCES "instance_action_stop_records"("action_id")
);

CREATE TABLE "instance_events_migration_source_and_live" (
    "event_id" INTEGER,
    "related_action_id" INTEGER DEFAULT NULL,
    "deleted_flag" INTEGER DEFAULT NULL,
    "detail_text" TEXT,
    "event_name" TEXT DEFAULT NULL,
    "host_name" TEXT DEFAULT NULL,
    "result_status" TEXT DEFAULT NULL,
    "traceback_text" TEXT,
    FOREIGN KEY ("related_action_id") REFERENCES "instance_action_audit"("action_id"),
    FOREIGN KEY ("related_action_id") REFERENCES "instance_action_reboot_records"("action_id"),
    FOREIGN KEY ("related_action_id") REFERENCES "instance_action_live_migration_records"("action_id")
);

CREATE TABLE "instance_events_other" (
    "event_id" INTEGER,
    "related_action_id" INTEGER DEFAULT NULL,
    "deleted_flag" INTEGER DEFAULT NULL,
    "detail_text" TEXT,
    "event_name" TEXT DEFAULT NULL,
    "host_name" TEXT DEFAULT NULL,
    "result_status" TEXT DEFAULT NULL,
    "traceback_text" TEXT,
    FOREIGN KEY ("related_action_id") REFERENCES "instance_action_reboot_records"("action_id"),
    FOREIGN KEY ("related_action_id") REFERENCES "instance_action_stop_records"("action_id")
);

CREATE TABLE "instance_event_audit" (
    "event_audit_id" INTEGER,
    "created_on" TEXT DEFAULT NULL,
    "deleted_flag" INTEGER DEFAULT NULL,
    "deleted_at_timestamp" TEXT DEFAULT NULL,
    "updated_at_timestamp" TEXT DEFAULT NULL
);

CREATE TABLE "instance_event_details" (
    "event_detail_id" INTEGER,
    "detail_text" TEXT,
    "finished_at" TEXT DEFAULT NULL,
    "host_name" TEXT DEFAULT NULL,
    "result_status" TEXT DEFAULT NULL,
    "started_at" TEXT DEFAULT NULL,
    "traceback_text" TEXT
);

CREATE TABLE "project_user_quota_created_audit" (
    "quota_id" INTEGER,
    "created_on" TEXT DEFAULT NULL,
    "deleted_flag" INTEGER DEFAULT NULL,
    "deleted_at_timestamp" TEXT DEFAULT NULL,
    "hard_limit_value" INTEGER DEFAULT NULL,
    "resource_name" TEXT NOT NULL,
    "updated_at_timestamp" TEXT DEFAULT NULL
);

CREATE TABLE "project_user_quota_deleted" (
    "quota_id" INTEGER,
    "deleted_flag" INTEGER DEFAULT NULL,
    "hard_limit_value" INTEGER DEFAULT NULL,
    "project_identifier" TEXT NOT NULL,
    "resource_name" TEXT NOT NULL,
    "updated_at_timestamp" TEXT DEFAULT NULL,
    "user_identifier" TEXT NOT NULL
);

CREATE TABLE "security_group_instance_links" (
    "created_on" TEXT DEFAULT NULL,
    "updated_on" TEXT DEFAULT NULL,
    "deleted_at_timestamp" TEXT DEFAULT NULL,
    "association_id" INTEGER,
    "security_group_ref" INTEGER DEFAULT NULL,
    "instance_identifier" TEXT DEFAULT NULL,
    "deleted_flag" INTEGER DEFAULT NULL,
    FOREIGN KEY ("security_group_ref") REFERENCES "security_group_deleted_entries"("security_group_id")
);

CREATE TABLE "shadow_sg_default_rule_cidrs" (
    "rule_id" INTEGER,
    "cidr_block" TEXT DEFAULT NULL,
    "deleted_flag" INTEGER DEFAULT NULL,
    "port_from" INTEGER DEFAULT NULL,
    "ip_protocol" TEXT DEFAULT NULL,
    "port_to" INTEGER DEFAULT NULL,
    "updated_at_timestamp" TEXT DEFAULT NULL
);

CREATE TABLE "shadow_sg_default_rule_cidrs_archive" (
    "rule_archive_id" INTEGER,
    "cidr_block" TEXT DEFAULT NULL,
    "created_on" TEXT DEFAULT NULL,
    "deleted_flag" INTEGER DEFAULT NULL,
    "deleted_at_timestamp" TEXT DEFAULT NULL,
    "ip_protocol" TEXT DEFAULT NULL,
    "updated_at_timestamp" TEXT DEFAULT NULL
);

CREATE TABLE "instance_action_records" (
    "action_id" INTEGER,
    "action_name" TEXT DEFAULT NULL,
    "finished_at" TEXT DEFAULT NULL,
    "instance_identifier" TEXT DEFAULT NULL,
    "started_at" TEXT DEFAULT NULL
);

CREATE TABLE "instance_action_audit" (
    "action_id" INTEGER,
    "created_on" TEXT DEFAULT NULL,
    "deleted_flag" INTEGER DEFAULT NULL,
    "deleted_at_timestamp" TEXT DEFAULT NULL,
    "note_message" TEXT DEFAULT NULL,
    "project_identifier" TEXT DEFAULT NULL,
    "updated_at_timestamp" TEXT DEFAULT NULL
);

CREATE TABLE "instance_action_delete_records" (
    "action_id" INTEGER,
    "action_name" TEXT DEFAULT NULL,
    "deleted_flag" INTEGER DEFAULT NULL,
    "instance_identifier" TEXT DEFAULT NULL,
    "note_message" TEXT DEFAULT NULL,
    "project_identifier" TEXT DEFAULT NULL,
    "request_identifier" TEXT DEFAULT NULL,
    "user_identifier" TEXT DEFAULT NULL
);

CREATE TABLE "instance_action_reboot_records" (
    "action_id" INTEGER,
    "action_name" TEXT DEFAULT NULL,
    "deleted_flag" INTEGER DEFAULT NULL,
    "instance_identifier" TEXT DEFAULT NULL,
    "note_message" TEXT DEFAULT NULL,
    "project_identifier" TEXT DEFAULT NULL,
    "request_identifier" TEXT DEFAULT NULL,
    "user_identifier" TEXT DEFAULT NULL
);

CREATE TABLE "instance_action_live_migration_records" (
    "action_id" INTEGER,
    "action_name" TEXT DEFAULT NULL,
    "deleted_flag" INTEGER DEFAULT NULL,
    "instance_identifier" TEXT DEFAULT NULL,
    "note_message" TEXT DEFAULT NULL,
    "project_identifier" TEXT DEFAULT NULL,
    "request_identifier" TEXT DEFAULT NULL,
    "user_identifier" TEXT DEFAULT NULL
);

CREATE TABLE "instance_action_stop_records" (
    "action_id" INTEGER,
    "action_name" TEXT DEFAULT NULL,
    "deleted_flag" INTEGER DEFAULT NULL,
    "instance_identifier" TEXT DEFAULT NULL,
    "note_message" TEXT DEFAULT NULL,
    "project_identifier" TEXT DEFAULT NULL,
    "request_identifier" TEXT DEFAULT NULL,
    "user_identifier" TEXT DEFAULT NULL
);

CREATE TABLE "security_group_deleted_entries" (
    "security_group_id" INTEGER,
    "deleted_flag" INTEGER DEFAULT NULL,
    "description_text" TEXT DEFAULT NULL,
    "group_name" TEXT DEFAULT NULL,
    "project_identifier" TEXT DEFAULT NULL,
    "user_identifier" TEXT DEFAULT NULL
);