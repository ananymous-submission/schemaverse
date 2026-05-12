-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/SchemaVerse/extra_hard/beaver/_staging/csail_stata_cinder/csail_stata_cinder.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "bkp_az" (
    "bkp_id" TEXT,
    "az" TEXT DEFAULT NULL,
    "cont" TEXT DEFAULT NULL,
    "data_ts" TEXT DEFAULT NULL,
    "del_flg" INTEGER DEFAULT NULL,
    "disp_desc" TEXT DEFAULT NULL,
    "disp_name" TEXT DEFAULT NULL,
    "fail_res" TEXT DEFAULT NULL,
    "host_node" TEXT DEFAULT NULL,
    "parent_bkp" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "svc" TEXT DEFAULT NULL,
    "svc_meta" TEXT DEFAULT NULL,
    "bkp_stat" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "bkp_ts" (
    "bkp_id" TEXT,
    "created_ts" TEXT DEFAULT NULL,
    "data_ts" TEXT DEFAULT NULL,
    "del_flg" INTEGER DEFAULT NULL,
    "del_ts" TEXT DEFAULT NULL,
    "upd_ts" TEXT DEFAULT NULL
);

CREATE TABLE "bkp_dep_stats" (
    "bkp_id" TEXT,
    "dep_cnt" INTEGER DEFAULT NULL,
    "obj_cnt" INTEGER DEFAULT NULL,
    "size_bytes" INTEGER DEFAULT NULL
);

CREATE TABLE "bkp_az_vol" (
    "bkp_vol_id" TEXT,
    "az" TEXT DEFAULT NULL,
    "disp_desc" TEXT DEFAULT NULL,
    "fail_res" TEXT DEFAULT NULL,
    "parent_bkp" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "restore_vol" TEXT DEFAULT NULL,
    "svc_meta" TEXT DEFAULT NULL,
    "snap_id" TEXT DEFAULT NULL,
    "bkp_stat" TEXT DEFAULT NULL,
    "tmp_snap" TEXT DEFAULT NULL,
    "tmp_vol" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL,
    "vol_id" TEXT NOT NULL
);

CREATE TABLE "drv_init_kv" (
    "created_ts" TEXT DEFAULT NULL,
    "upd_ts" TEXT DEFAULT NULL,
    "drv_init_id" INTEGER,
    "initr" TEXT NOT NULL,
    "ns" TEXT NOT NULL,
    "kv_key" TEXT NOT NULL,
    "kv_val" TEXT DEFAULT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "ImageVolumeCacheRecords" (
    "ImageUpdatedAt" TEXT DEFAULT NULL,
    "CacheEntryId" INTEGER,
    "HostName" TEXT NOT NULL,
    "ImageIdentifier" TEXT NOT NULL,
    "VolumeIdentifier" TEXT NOT NULL,
    "SizeBytes" INTEGER NOT NULL,
    "LastAccessedAt" TEXT NOT NULL
);

CREATE TABLE "MigrationVersion" (
    "RepositoryIdentifier" TEXT,
    "RepositoryLocation" TEXT,
    "VersionNumber" INTEGER DEFAULT NULL
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "qualityOfServiceSpecsSnapshot" (
    "qosSpecId" TEXT,
    "createdAt" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "specKey" TEXT DEFAULT NULL,
    "parentSpecId" TEXT DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "reservationsAllocatedDeltaAtMostMinusOne" (
    "reservationId" INTEGER,
    "allocatedQuotaId" INTEGER DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deltaAmount" INTEGER NOT NULL,
    "projectId" TEXT DEFAULT NULL,
    "resourceName" TEXT DEFAULT NULL,
    "usageId" INTEGER DEFAULT NULL,
    "reservationUuid" TEXT NOT NULL
);

CREATE TABLE "reservationsAllocatedDeltaBetweenMinusOneAndOneInclusive" (
    "reservationId" INTEGER,
    "allocatedQuotaId" INTEGER DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deltaAmount" INTEGER NOT NULL,
    "projectId" TEXT DEFAULT NULL,
    "resourceName" TEXT DEFAULT NULL,
    "usageId" INTEGER DEFAULT NULL,
    "reservationUuid" TEXT NOT NULL,
    FOREIGN KEY ("allocatedQuotaId") REFERENCES "quotaAllocations"("quotaId"),
    FOREIGN KEY ("allocatedQuotaId") REFERENCES "quotaCreatedAfter2015Oct26T081449AndOnOrBefore2017Jun15T032250"("quotaId"),
    FOREIGN KEY ("allocatedQuotaId") REFERENCES "quotaCreatedAfter2017Jun15T032250AndOnOrBefore2020Apr30T142201"("quotaId"),
    FOREIGN KEY ("usageId") REFERENCES "quotaUsageCreatedOnOrBefore2015Aug05T141702"("usageId"),
    FOREIGN KEY ("usageId") REFERENCES "quotaUsageCreatedAfter2015Aug05T141702AndOnOrBefore2017Apr15T064739"("usageId")
);

CREATE TABLE "reservationsAllocatedDeltaGreaterThanOneOrNull" (
    "reservationId" INTEGER,
    "allocatedQuotaId" INTEGER DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deltaAmount" INTEGER NOT NULL,
    "projectId" TEXT DEFAULT NULL,
    "resourceName" TEXT DEFAULT NULL,
    "usageId" INTEGER DEFAULT NULL,
    "reservationUuid" TEXT NOT NULL,
    FOREIGN KEY ("allocatedQuotaId") REFERENCES "quotaCreatedAfter2015Oct26T081449AndOnOrBefore2017Jun15T032250"("quotaId"),
    FOREIGN KEY ("allocatedQuotaId") REFERENCES "quotaCreatedAfter2017Jun15T032250AndOnOrBefore2020Apr30T142201"("quotaId")
);

CREATE TABLE "reservationsByCreatedAt" (
    "reservationId" INTEGER,
    "createdAt" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "deltaAmount" INTEGER NOT NULL,
    "expiresAt" TEXT DEFAULT NULL,
    "projectId" TEXT DEFAULT NULL,
    "resourceName" TEXT DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL,
    "reservationUuid" TEXT NOT NULL
);

CREATE TABLE "quotaUsageCreatedOnOrBefore2015Aug05T141702" (
    "usageId" INTEGER,
    "createdAt" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "resourceName" TEXT DEFAULT NULL,
    "untilRefresh" INTEGER DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "quotaUsageCreatedAfter2015Aug05T141702AndOnOrBefore2017Apr15T064739" (
    "usageId" INTEGER,
    "createdAt" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "resourceName" TEXT DEFAULT NULL,
    "untilRefresh" INTEGER DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "quotaUsageCreatedAfter2017Apr15T064739AndOnOrBefore2019Oct29T195722" (
    "usageId" INTEGER,
    "createdAt" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "resourceName" TEXT DEFAULT NULL,
    "untilRefresh" INTEGER DEFAULT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "quotaAllocations" (
    "quotaId" INTEGER,
    "allocatedAmount" INTEGER DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "hardLimit" INTEGER DEFAULT NULL,
    "projectId" TEXT DEFAULT NULL,
    "resourceName" TEXT NOT NULL
);

CREATE TABLE "quotaCreatedAfter2015Oct26T081449AndOnOrBefore2017Jun15T032250" (
    "quotaId" INTEGER,
    "createdAt" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "hardLimit" INTEGER DEFAULT NULL,
    "projectId" TEXT DEFAULT NULL,
    "resourceName" TEXT NOT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "quotaCreatedAfter2017Jun15T032250AndOnOrBefore2020Apr30T142201" (
    "quotaId" INTEGER,
    "createdAt" TEXT DEFAULT NULL,
    "isDeleted" INTEGER DEFAULT NULL,
    "deletedAt" TEXT DEFAULT NULL,
    "hardLimit" INTEGER DEFAULT NULL,
    "projectId" TEXT DEFAULT NULL,
    "resourceName" TEXT NOT NULL,
    "updatedAt" TEXT DEFAULT NULL
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "quota_cls_meta" (
    "cls_id" INTEGER,
    "cls_name" TEXT DEFAULT NULL,
    "del_flag" INTEGER DEFAULT NULL,
    "hard_lim" INTEGER DEFAULT NULL,
    "res_name" TEXT DEFAULT NULL
);

CREATE TABLE "quota_cls_audit" (
    "audit_id" INTEGER,
    "cls_name" TEXT DEFAULT NULL,
    "crt_ts" TEXT DEFAULT NULL,
    "del_flag" INTEGER DEFAULT NULL,
    "del_ts" TEXT DEFAULT NULL,
    "hard_lim" INTEGER DEFAULT NULL,
    "upd_ts" TEXT DEFAULT NULL
);

CREATE TABLE "vol_attach_inst_other" (
    "attach_ref" TEXT,
    "att_mode" TEXT DEFAULT NULL,
    "att_status" TEXT DEFAULT NULL,
    "att_host" TEXT DEFAULT NULL,
    "del_flag" INTEGER DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "mnt_point" TEXT DEFAULT NULL,
    "vol_id" TEXT NOT NULL
);

CREATE TABLE "vol_attach_state" (
    "attach_id" TEXT,
    "att_mode" TEXT DEFAULT NULL,
    "att_status" TEXT DEFAULT NULL,
    "att_ts" TEXT DEFAULT NULL,
    "crt_ts" TEXT DEFAULT NULL,
    "del_flag" INTEGER DEFAULT NULL,
    "del_ts" TEXT DEFAULT NULL,
    "detach_ts" TEXT DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "upd_ts" TEXT DEFAULT NULL,
    "vol_id" TEXT NOT NULL
);

CREATE TABLE "vol_type_del" (
    "type_id" TEXT,
    "del_flag" INTEGER DEFAULT NULL,
    "descr" TEXT DEFAULT NULL,
    "pub_flag" INTEGER DEFAULT NULL,
    "type_name" TEXT DEFAULT NULL,
    "qos_id" TEXT DEFAULT NULL
);

-- ========================================================================
-- local_6
-- DDL file: local_6_schema.sql
-- ========================================================================

CREATE TABLE "QuotaUsageCreatedAfter2019Oct29OrNull" (
    "Id" INTEGER,
    "CreatedAt" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "ResourceName" TEXT DEFAULT NULL,
    "SecondsUntilRefresh" INTEGER DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "DeletedQuotaUsageSnapshot" (
    "Id" INTEGER,
    "IsDeleted" INTEGER DEFAULT NULL,
    "InUseCount" INTEGER NOT NULL,
    "ProjectId" TEXT DEFAULT NULL,
    "ReservedCount" INTEGER NOT NULL,
    "ResourceName" TEXT DEFAULT NULL,
    "SecondsUntilRefresh" INTEGER DEFAULT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "QuotaCreatedOnOrBefore2015Oct26" (
    "Id" INTEGER,
    "CreatedAt" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "HardLimit" INTEGER DEFAULT NULL,
    "ProjectId" TEXT DEFAULT NULL,
    "ResourceName" TEXT NOT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

CREATE TABLE "QuotaCreatedAfter2020Apr30OrNull" (
    "Id" INTEGER,
    "CreatedAt" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "DeletedAt" TEXT DEFAULT NULL,
    "HardLimit" INTEGER DEFAULT NULL,
    "ProjectId" TEXT DEFAULT NULL,
    "ResourceName" TEXT NOT NULL,
    "UpdatedAt" TEXT DEFAULT NULL
);

-- ========================================================================
-- local_7
-- DDL file: local_7_schema.sql
-- ========================================================================

CREATE TABLE "ServiceBackendStatus" (
    "ServiceStatusId" INTEGER,
    "ActiveBackendIdentifier" TEXT DEFAULT NULL,
    "AvailabilityZone" TEXT DEFAULT NULL,
    "ServiceBinary" TEXT DEFAULT NULL,
    "DisabledReason" TEXT DEFAULT NULL,
    "Hostname" TEXT DEFAULT NULL,
    "ReplicationStatus" TEXT DEFAULT NULL,
    "ReportCount" INTEGER NOT NULL,
    "MessageTopic" TEXT DEFAULT NULL
);

CREATE TABLE "ServiceLifecycleTimestamps" (
    "LifecycleId" INTEGER,
    "CreatedAtTimestamp" TEXT DEFAULT NULL,
    "DeletedAtTimestamp" TEXT DEFAULT NULL,
    "ModifiedAtTimestamp" TEXT DEFAULT NULL,
    "UpdatedAtTimestamp" TEXT DEFAULT NULL
);

CREATE TABLE "ServiceBackendDetails" (
    "DetailsId" INTEGER,
    "ActiveBackendIdentifier" TEXT DEFAULT NULL,
    "AvailabilityZone" TEXT DEFAULT NULL,
    "ServiceBinary" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL,
    "IsDisabled" INTEGER DEFAULT NULL,
    "DisabledReason" TEXT DEFAULT NULL,
    "IsFrozen" INTEGER DEFAULT NULL,
    "Hostname" TEXT DEFAULT NULL,
    "ReplicationStatus" TEXT DEFAULT NULL,
    "ReportCount" INTEGER NOT NULL,
    "MessageTopic" TEXT DEFAULT NULL
);

CREATE TABLE "ServiceVersionCompatibility" (
    "VersionRecordId" INTEGER,
    "ObjectAvailableVersion" TEXT DEFAULT NULL,
    "ObjectCurrentVersion" TEXT DEFAULT NULL,
    "RpcAvailableVersion" TEXT DEFAULT NULL,
    "RpcCurrentVersion" TEXT DEFAULT NULL
);

CREATE TABLE "VolumeTypeProjectAssignments" (
    "AssignmentId" INTEGER,
    "CreatedAtTimestamp" TEXT DEFAULT NULL,
    "UpdatedAtTimestamp" TEXT DEFAULT NULL,
    "DeletedAtTimestamp" TEXT DEFAULT NULL,
    "VolumeTypeId" TEXT DEFAULT NULL,
    "ProjectId" TEXT DEFAULT NULL,
    "IsDeleted" INTEGER DEFAULT NULL
);

-- ========================================================================
-- local_8
-- DDL file: local_8_schema.sql
-- ========================================================================

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

