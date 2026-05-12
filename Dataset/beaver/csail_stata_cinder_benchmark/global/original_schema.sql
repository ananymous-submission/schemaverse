CREATE TABLE "backups" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" TEXT NOT NULL,
  "volume_id" TEXT NOT NULL,
  "user_id" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "host" TEXT DEFAULT NULL,
  "availability_zone" TEXT DEFAULT NULL,
  "display_name" TEXT DEFAULT NULL,
  "display_description" TEXT DEFAULT NULL,
  "container" TEXT DEFAULT NULL,
  "status" TEXT DEFAULT NULL,
  "fail_reason" TEXT DEFAULT NULL,
  "service_metadata" TEXT DEFAULT NULL,
  "service" TEXT DEFAULT NULL,
  "size" INTEGER DEFAULT NULL,
  "object_count" INTEGER DEFAULT NULL,
  "parent_id" TEXT DEFAULT NULL,
  "temp_volume_id" TEXT DEFAULT NULL,
  "temp_snapshot_id" TEXT DEFAULT NULL,
  "num_dependent_backups" INTEGER DEFAULT NULL,
  "snapshot_id" TEXT DEFAULT NULL,
  "data_timestamp" TEXT DEFAULT NULL,
  "restore_volume_id" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "cgsnapshots" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" TEXT NOT NULL,
  "consistencygroup_id" TEXT NOT NULL,
  "user_id" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  "description" TEXT DEFAULT NULL,
  "status" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "cgsnapshots_ibfk_1" FOREIGN KEY ("consistencygroup_id") REFERENCES "consistencygroups" ("id")
);

CREATE TABLE "consistencygroups" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" TEXT NOT NULL,
  "user_id" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "host" TEXT DEFAULT NULL,
  "availability_zone" TEXT DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  "description" TEXT DEFAULT NULL,
  "volume_type_id" TEXT DEFAULT NULL,
  "status" TEXT DEFAULT NULL,
  "cgsnapshot_id" TEXT DEFAULT NULL,
  "source_cgid" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "driver_initiator_data" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "initiator" TEXT NOT NULL,
  "namespace" TEXT NOT NULL,
  "key" TEXT NOT NULL,
  "value" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "encryption" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "cipher" TEXT DEFAULT NULL,
  "control_location" TEXT NOT NULL,
  "key_size" INTEGER DEFAULT NULL,
  "provider" TEXT NOT NULL,
  "volume_type_id" TEXT NOT NULL,
  "encryption_id" TEXT NOT NULL DEFAULT '',
  PRIMARY KEY ("encryption_id")
);

CREATE TABLE "image_volume_cache_entries" (
  "image_updated_at" TEXT DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "host" TEXT NOT NULL,
  "image_id" TEXT NOT NULL,
  "volume_id" TEXT NOT NULL,
  "size" INTEGER NOT NULL,
  "last_used" TEXT NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "iscsi_targets" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "target_num" INTEGER DEFAULT NULL,
  "host" TEXT DEFAULT NULL,
  "volume_id" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "iscsi_targets_ibfk_1" FOREIGN KEY ("volume_id") REFERENCES "volumes" ("id")
);

CREATE TABLE "migrate_version" (
  "repository_id" TEXT NOT NULL,
  "repository_path" TEXT,
  "version" INTEGER DEFAULT NULL,
  PRIMARY KEY ("repository_id")
);

CREATE TABLE "quality_of_service_specs" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" TEXT NOT NULL,
  "specs_id" TEXT DEFAULT NULL,
  "key" TEXT DEFAULT NULL,
  "value" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "quality_of_service_specs_ibfk_1" FOREIGN KEY ("specs_id") REFERENCES "quality_of_service_specs" ("id")
);

CREATE TABLE "quota_classes" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "class_name" TEXT DEFAULT NULL,
  "resource" TEXT DEFAULT NULL,
  "hard_limit" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "quota_usages" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "project_id" TEXT DEFAULT NULL,
  "resource" TEXT DEFAULT NULL,
  "in_use" INTEGER NOT NULL,
  "reserved" INTEGER NOT NULL,
  "until_refresh" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "quotas" (
  "id" INTEGER NOT NULL ,
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "resource" TEXT NOT NULL,
  "hard_limit" INTEGER DEFAULT NULL,
  "allocated" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "reservations" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "uuid" TEXT NOT NULL,
  "usage_id" INTEGER DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "resource" TEXT DEFAULT NULL,
  "delta" INTEGER NOT NULL,
  "expire" TEXT DEFAULT NULL,
  "allocated_id" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "reservations_ibfk_1" FOREIGN KEY ("usage_id") REFERENCES "quota_usages" ("id"),
  CONSTRAINT "reservations_ibfk_2" FOREIGN KEY ("allocated_id") REFERENCES "quotas" ("id")
);

CREATE TABLE "services" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "host" TEXT DEFAULT NULL,
  "binary" TEXT DEFAULT NULL,
  "topic" TEXT DEFAULT NULL,
  "report_count" INTEGER NOT NULL,
  "disabled" INTEGER DEFAULT NULL,
  "availability_zone" TEXT DEFAULT NULL,
  "disabled_reason" TEXT DEFAULT NULL,
  "modified_at" TEXT DEFAULT NULL,
  "rpc_current_version" TEXT DEFAULT NULL,
  "rpc_available_version" TEXT DEFAULT NULL,
  "object_current_version" TEXT DEFAULT NULL,
  "object_available_version" TEXT DEFAULT NULL,
  "replication_status" TEXT DEFAULT NULL,
  "frozen" INTEGER DEFAULT NULL,
  "active_backend_id" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "snapshot_metadata" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "snapshot_id" TEXT NOT NULL,
  "key" TEXT DEFAULT NULL,
  "value" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "snapshot_metadata_ibfk_1" FOREIGN KEY ("snapshot_id") REFERENCES "snapshots" ("id")
);

CREATE TABLE "snapshots" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" TEXT NOT NULL,
  "volume_id" TEXT NOT NULL,
  "user_id" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "status" TEXT DEFAULT NULL,
  "progress" TEXT DEFAULT NULL,
  "volume_size" INTEGER DEFAULT NULL,
  "scheduled_at" TEXT DEFAULT NULL,
  "display_name" TEXT DEFAULT NULL,
  "display_description" TEXT DEFAULT NULL,
  "provider_location" TEXT DEFAULT NULL,
  "encryption_key_id" TEXT DEFAULT NULL,
  "volume_type_id" TEXT DEFAULT NULL,
  "cgsnapshot_id" TEXT DEFAULT NULL,
  "provider_id" TEXT DEFAULT NULL,
  "provider_auth" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "snapshots_ibfk_1" FOREIGN KEY ("cgsnapshot_id") REFERENCES "cgsnapshots" ("id"),
  CONSTRAINT "snapshots_volume_id_fkey" FOREIGN KEY ("volume_id") REFERENCES "volumes" ("id")
);

CREATE TABLE "transfers" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" TEXT NOT NULL,
  "volume_id" TEXT NOT NULL,
  "display_name" TEXT DEFAULT NULL,
  "salt" TEXT DEFAULT NULL,
  "crypt_hash" TEXT DEFAULT NULL,
  "expires_at" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "transfers_ibfk_1" FOREIGN KEY ("volume_id") REFERENCES "volumes" ("id")
);

CREATE TABLE "volume_admin_metadata" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "volume_id" TEXT NOT NULL,
  "key" TEXT DEFAULT NULL,
  "value" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "volume_admin_metadata_ibfk_1" FOREIGN KEY ("volume_id") REFERENCES "volumes" ("id")
);

CREATE TABLE "volume_attachment" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" TEXT NOT NULL,
  "volume_id" TEXT NOT NULL,
  "attached_host" TEXT DEFAULT NULL,
  "instance_uuid" TEXT DEFAULT NULL,
  "mountpoint" TEXT DEFAULT NULL,
  "attach_time" TEXT DEFAULT NULL,
  "detach_time" TEXT DEFAULT NULL,
  "attach_mode" TEXT DEFAULT NULL,
  "attach_status" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "volume_attachment_ibfk_1" FOREIGN KEY ("volume_id") REFERENCES "volumes" ("id")
);

CREATE TABLE "volume_glance_metadata" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "volume_id" TEXT DEFAULT NULL,
  "snapshot_id" TEXT DEFAULT NULL,
  "key" TEXT DEFAULT NULL,
  "value" TEXT,
  PRIMARY KEY ("id"),
  CONSTRAINT "volume_glance_metadata_ibfk_1" FOREIGN KEY ("volume_id") REFERENCES "volumes" ("id"),
  CONSTRAINT "volume_glance_metadata_ibfk_2" FOREIGN KEY ("snapshot_id") REFERENCES "snapshots" ("id")
);

CREATE TABLE "volume_metadata" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "volume_id" TEXT NOT NULL,
  "key" TEXT DEFAULT NULL,
  "value" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "volume_metadata_ibfk_1" FOREIGN KEY ("volume_id") REFERENCES "volumes" ("id")
);

CREATE TABLE "volume_type_extra_specs" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" INTEGER NOT NULL ,
  "volume_type_id" TEXT NOT NULL,
  "key" TEXT DEFAULT NULL,
  "value" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "volume_type_extra_specs_ibfk_1" FOREIGN KEY ("volume_type_id") REFERENCES "volume_types" ("id")
);

CREATE TABLE "volume_type_projects" (
  "id" INTEGER NOT NULL ,
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "volume_type_id" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "volume_type_projects_ibfk_1" FOREIGN KEY ("volume_type_id") REFERENCES "volume_types" ("id")
);

CREATE TABLE "volume_types" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" TEXT NOT NULL,
  "name" TEXT DEFAULT NULL,
  "qos_specs_id" TEXT DEFAULT NULL,
  "is_public" INTEGER DEFAULT NULL,
  "description" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "volume_types_ibfk_1" FOREIGN KEY ("qos_specs_id") REFERENCES "quality_of_service_specs" ("id")
);

CREATE TABLE "volumes" (
  "created_at" TEXT DEFAULT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER DEFAULT NULL,
  "id" TEXT NOT NULL,
  "ec2_id" TEXT DEFAULT NULL,
  "user_id" TEXT DEFAULT NULL,
  "project_id" TEXT DEFAULT NULL,
  "host" TEXT DEFAULT NULL,
  "size" INTEGER DEFAULT NULL,
  "availability_zone" TEXT DEFAULT NULL,
  "status" TEXT DEFAULT NULL,
  "attach_status" TEXT DEFAULT NULL,
  "scheduled_at" TEXT DEFAULT NULL,
  "launched_at" TEXT DEFAULT NULL,
  "terminated_at" TEXT DEFAULT NULL,
  "display_name" TEXT DEFAULT NULL,
  "display_description" TEXT DEFAULT NULL,
  "provider_location" TEXT DEFAULT NULL,
  "provider_auth" TEXT DEFAULT NULL,
  "snapshot_id" TEXT DEFAULT NULL,
  "volume_type_id" TEXT DEFAULT NULL,
  "source_volid" TEXT DEFAULT NULL,
  "bootable" INTEGER DEFAULT NULL,
  "provider_geometry" TEXT DEFAULT NULL,
  "_name_id" TEXT DEFAULT NULL,
  "encryption_key_id" TEXT DEFAULT NULL,
  "migration_status" TEXT DEFAULT NULL,
  "replication_status" TEXT DEFAULT NULL,
  "replication_extended_status" TEXT DEFAULT NULL,
  "replication_driver_data" TEXT DEFAULT NULL,
  "consistencygroup_id" TEXT DEFAULT NULL,
  "provider_id" TEXT DEFAULT NULL,
  "multiattach" INTEGER DEFAULT NULL,
  "previous_status" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "volumes_ibfk_1" FOREIGN KEY ("consistencygroup_id") REFERENCES "consistencygroups" ("id")
);