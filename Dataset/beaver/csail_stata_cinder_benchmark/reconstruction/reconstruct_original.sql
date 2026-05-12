-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";
ATTACH DATABASE 'local_6.sqlite' AS "local_6";
ATTACH DATABASE 'local_7.sqlite' AS "local_7";
ATTACH DATABASE 'local_8.sqlite' AS "local_8";

-- Reconstruct backups from vertical (column) split (4 fragments)
CREATE VIEW "backups" AS
SELECT
    t3."created_ts" AS "created_at",
    t3."upd_ts" AS "updated_at",
    t3."del_ts" AS "deleted_at",
    t0."del_flg" AS "deleted",
    t0."bkp_id" AS "id",
    t1."vol_id" AS "volume_id",
    t0."usr_id" AS "user_id",
    t0."proj_id" AS "project_id",
    t0."host_node" AS "host",
    t0."az" AS "availability_zone",
    t0."disp_name" AS "display_name",
    t0."disp_desc" AS "display_description",
    t0."cont" AS "container",
    t0."bkp_stat" AS "status",
    t0."fail_res" AS "fail_reason",
    t0."svc_meta" AS "service_metadata",
    t0."svc" AS "service",
    t2."size_bytes" AS "size",
    t2."obj_cnt" AS "object_count",
    t0."parent_bkp" AS "parent_id",
    t1."tmp_vol" AS "temp_volume_id",
    t1."tmp_snap" AS "temp_snapshot_id",
    t2."dep_cnt" AS "num_dependent_backups",
    t1."snap_id" AS "snapshot_id",
    t0."data_ts" AS "data_timestamp",
    t1."restore_vol" AS "restore_volume_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "bkp_id" ORDER BY rowid) AS __rn FROM "local_1"."bkp_az") t0
JOIN "local_1"."bkp_az_vol" t1 ON t0."bkp_id" IS t1."bkp_vol_id" AND t0.__rn = t1.__rn
JOIN "local_1"."bkp_dep_stats" t2 ON t0."bkp_id" IS t2."bkp_id" AND t0.__rn = t2.__rn
JOIN "local_1"."bkp_ts" t3 ON t0."bkp_id" IS t3."bkp_id" AND t0.__rn = t3.__rn;

-- Reconstruct cgsnapshots from vertical (column) split (3 fragments)
CREATE VIEW "cgsnapshots" AS
SELECT
    t2."created_timestamp" AS "created_at",
    t2."updated_timestamp" AS "updated_at",
    t2."deletion_timestamp" AS "deleted_at",
    t1."is_deleted_flag" AS "deleted",
    t0."link_id" AS "id",
    t0."consistency_group_id_ref" AS "consistencygroup_id",
    t0."user_ref" AS "user_id",
    t0."project_ref" AS "project_id",
    t1."display_name_text" AS "name",
    t1."description_text" AS "description",
    t1."status_text" AS "status"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "link_id" ORDER BY rowid) AS __rn FROM "local_2"."consistency_group_snapshot_link") t0
JOIN "local_2"."snapshot_deletion_record" t1 ON t0."link_id" IS t1."deletion_record_id" AND t0.__rn = t1.__rn
JOIN "local_2"."snapshot_timestamps_log" t2 ON t0."link_id" IS t2."snapshot_log_id" AND t0.__rn = t2.__rn;

-- Reconstruct consistencygroups from vertical (column) split (4 fragments)
CREATE VIEW "consistencygroups" AS
SELECT
    t0."created_timestamp" AS "created_at",
    t0."updated_timestamp" AS "updated_at",
    t0."deletion_timestamp" AS "deleted_at",
    t2."is_deleted_flag" AS "deleted",
    t0."created_entry_id" AS "id",
    t3."user_ref" AS "user_id",
    t3."project_ref" AS "project_id",
    t1."host_name" AS "host",
    t1."availability_zone_name" AS "availability_zone",
    t1."group_name" AS "name",
    t2."description_text" AS "description",
    t2."volume_type_ref" AS "volume_type_id",
    t2."status_text" AS "status",
    t2."cgsnapshot_ref_id" AS "cgsnapshot_id",
    t2."source_consistency_group_ref" AS "source_cgid"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "created_entry_id" ORDER BY rowid) AS __rn FROM "local_2"."consistency_group_created_timestamps") t0
JOIN "local_2"."consistency_group_location" t1 ON t0."created_entry_id" IS t1."consistency_group_id" AND t0.__rn = t1.__rn
JOIN "local_2"."consistency_group_snapshot_index" t2 ON t0."created_entry_id" IS t2."index_id" AND t0.__rn = t2.__rn
JOIN "local_2"."consistency_group_zone_snapshot_ref" t3 ON t0."created_entry_id" IS t3."zone_entry_id" AND t0.__rn = t3.__rn;

-- Reconstruct driver_initiator_data from local_1.drv_init_kv
CREATE VIEW "driver_initiator_data" AS
SELECT
    "local_1"."drv_init_kv"."created_ts" AS "created_at",
    "local_1"."drv_init_kv"."upd_ts" AS "updated_at",
    "local_1"."drv_init_kv"."drv_init_id" AS "id",
    "local_1"."drv_init_kv"."initr" AS "initiator",
    "local_1"."drv_init_kv"."ns" AS "namespace",
    "local_1"."drv_init_kv"."kv_key" AS "key",
    "local_1"."drv_init_kv"."kv_val" AS "value"
FROM "local_1"."drv_init_kv";

-- Reconstruct encryption from vertical (column) split (2 fragments)
CREATE VIEW "encryption" AS
SELECT
    t1."created_timestamp" AS "created_at",
    t1."updated_timestamp" AS "updated_at",
    t1."deleted_timestamp" AS "deleted_at",
    t0."is_deleted" AS "deleted",
    t0."cipher_name" AS "cipher",
    t0."control_location_ref" AS "control_location",
    t0."key_length" AS "key_size",
    t0."provider_name" AS "provider",
    t0."volume_type_identifier" AS "volume_type_id",
    t0."encryption_identifier" AS "encryption_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "encryption_identifier" ORDER BY rowid) AS __rn FROM "local_8"."encryption_cipher_map") t0
JOIN "local_8"."encryption_control_registry" t1 ON t0."encryption_identifier" IS t1."encryption_identifier" AND t0.__rn = t1.__rn;

-- Reconstruct image_volume_cache_entries from local_3.ImageVolumeCacheRecords
CREATE VIEW "image_volume_cache_entries" AS
SELECT
    "local_3"."ImageVolumeCacheRecords"."ImageUpdatedAt" AS "image_updated_at",
    "local_3"."ImageVolumeCacheRecords"."CacheEntryId" AS "id",
    "local_3"."ImageVolumeCacheRecords"."HostName" AS "host",
    "local_3"."ImageVolumeCacheRecords"."ImageIdentifier" AS "image_id",
    "local_3"."ImageVolumeCacheRecords"."VolumeIdentifier" AS "volume_id",
    "local_3"."ImageVolumeCacheRecords"."SizeBytes" AS "size",
    "local_3"."ImageVolumeCacheRecords"."LastAccessedAt" AS "last_used"
FROM "local_3"."ImageVolumeCacheRecords";

-- Reconstruct iscsi_targets from vertical split + row partition on a fragment
CREATE VIEW "iscsi_targets" AS
SELECT t0.[created_timestamp], t0.[updated_timestamp], t0.[deleted_timestamp], t0.[is_deleted_flag], t0.[record_id], t0.[target_number], t1.[host_name], t0.[volume_ref_id]
FROM (
SELECT [iscsi_targets_above_75_or_null].[__orig_rowid] AS __orig_rowid, [local_2].[iscsi_targets_above_75_or_null].[created_timestamp], [local_2].[iscsi_targets_above_75_or_null].[updated_timestamp], [local_2].[iscsi_targets_above_75_or_null].[deleted_timestamp], [local_2].[iscsi_targets_above_75_or_null].[is_deleted_flag], [local_2].[iscsi_targets_above_75_or_null].[record_id], [local_2].[iscsi_targets_above_75_or_null].[target_number], [local_2].[iscsi_targets_above_75_or_null].[volume_ref_id] FROM [local_2].[iscsi_targets_above_75_or_null]
UNION
SELECT [iscsi_targets_low_target_quartile].[__orig_rowid] AS __orig_rowid, [local_2].[iscsi_targets_low_target_quartile].[created_timestamp], [local_2].[iscsi_targets_low_target_quartile].[updated_timestamp], [local_2].[iscsi_targets_low_target_quartile].[deleted_timestamp], [local_2].[iscsi_targets_low_target_quartile].[is_deleted_flag], [local_2].[iscsi_targets_low_target_quartile].[record_id], [local_2].[iscsi_targets_low_target_quartile].[target_number], [local_2].[iscsi_targets_low_target_quartile].[volume_ref_id] FROM [local_2].[iscsi_targets_low_target_quartile]
UNION
SELECT [iscsi_targets_targetnum_26_50].[__orig_rowid] AS __orig_rowid, [local_2].[iscsi_targets_targetnum_26_50].[created_timestamp], [local_2].[iscsi_targets_targetnum_26_50].[updated_timestamp], [local_2].[iscsi_targets_targetnum_26_50].[deleted_timestamp], [local_2].[iscsi_targets_targetnum_26_50].[is_deleted_flag], [local_2].[iscsi_targets_targetnum_26_50].[record_id], [local_2].[iscsi_targets_targetnum_26_50].[target_number], [local_2].[iscsi_targets_targetnum_26_50].[volume_ref_id] FROM [local_2].[iscsi_targets_targetnum_26_50]
UNION
SELECT [iscsi_targets_targetnum_51_75].[__orig_rowid] AS __orig_rowid, [local_2].[iscsi_targets_targetnum_51_75].[created_timestamp], [local_2].[iscsi_targets_targetnum_51_75].[updated_timestamp], [local_2].[iscsi_targets_targetnum_51_75].[deleted_timestamp], [local_2].[iscsi_targets_targetnum_51_75].[is_deleted_flag], [local_2].[iscsi_targets_targetnum_51_75].[record_id], [local_2].[iscsi_targets_targetnum_51_75].[target_number], [local_2].[iscsi_targets_targetnum_51_75].[volume_ref_id] FROM [local_2].[iscsi_targets_targetnum_51_75]
) t0
JOIN [local_2].[iscsi_targets_deleted_info] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct migrate_version from local_3.MigrationVersion
CREATE VIEW "migrate_version" AS
SELECT
    "local_3"."MigrationVersion"."RepositoryIdentifier" AS "repository_id",
    "local_3"."MigrationVersion"."RepositoryLocation" AS "repository_path",
    "local_3"."MigrationVersion"."VersionNumber" AS "version"
FROM "local_3"."MigrationVersion";

-- Reconstruct quality_of_service_specs from vertical (column) split (2 fragments)
CREATE VIEW "quality_of_service_specs" AS
SELECT
    t1."createdAt" AS "created_at",
    t1."updatedAt" AS "updated_at",
    t1."deletedAt" AS "deleted_at",
    t0."is_deleted" AS "deleted",
    t0."deletion_id" AS "id",
    t0."specs_identifier" AS "specs_id",
    t0."spec_key" AS "key",
    t0."spec_value" AS "value"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "deletion_id" ORDER BY rowid) AS __rn FROM "local_8"."qos_specs_deletion_archive") t0
JOIN "local_4"."qualityOfServiceSpecsSnapshot" t1 ON t0."deletion_id" IS t1."qosSpecId" AND t0.__rn = t1.__rn;

-- Reconstruct quota_classes from vertical (column) split (2 fragments)
CREATE VIEW "quota_classes" AS
SELECT
    t0."crt_ts" AS "created_at",
    t0."upd_ts" AS "updated_at",
    t0."del_ts" AS "deleted_at",
    t0."del_flag" AS "deleted",
    t0."audit_id" AS "id",
    t0."cls_name" AS "class_name",
    t1."res_name" AS "resource",
    t0."hard_lim" AS "hard_limit"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "audit_id" ORDER BY rowid) AS __rn FROM "local_5"."quota_cls_audit") t0
JOIN "local_5"."quota_cls_meta" t1 ON t0."audit_id" IS t1."cls_id" AND t0.__rn = t1.__rn;

-- Reconstruct quota_usages from vertical split + row partition on a fragment
CREATE VIEW "quota_usages" AS
SELECT t0.[createdAt], t0.[updatedAt], t0.[deletedAt], t0.[isDeleted], t0.[usageId], t1.[ProjectId], t0.[resourceName], t1.[InUseCount], t1.[ReservedCount], t0.[untilRefresh]
FROM (
SELECT [quotaUsageCreatedAfter2015Aug05T141702AndOnOrBefore2017Apr15T064739].[__orig_rowid] AS __orig_rowid, [local_4].[quotaUsageCreatedAfter2015Aug05T141702AndOnOrBefore2017Apr15T064739].[createdAt], [local_4].[quotaUsageCreatedAfter2015Aug05T141702AndOnOrBefore2017Apr15T064739].[updatedAt], [local_4].[quotaUsageCreatedAfter2015Aug05T141702AndOnOrBefore2017Apr15T064739].[deletedAt], [local_4].[quotaUsageCreatedAfter2015Aug05T141702AndOnOrBefore2017Apr15T064739].[isDeleted], [local_4].[quotaUsageCreatedAfter2015Aug05T141702AndOnOrBefore2017Apr15T064739].[usageId], [local_4].[quotaUsageCreatedAfter2015Aug05T141702AndOnOrBefore2017Apr15T064739].[resourceName], [local_4].[quotaUsageCreatedAfter2015Aug05T141702AndOnOrBefore2017Apr15T064739].[untilRefresh] FROM [local_4].[quotaUsageCreatedAfter2015Aug05T141702AndOnOrBefore2017Apr15T064739]
UNION
SELECT [quotaUsageCreatedAfter2017Apr15T064739AndOnOrBefore2019Oct29T195722].[__orig_rowid] AS __orig_rowid, [local_4].[quotaUsageCreatedAfter2017Apr15T064739AndOnOrBefore2019Oct29T195722].[createdAt], [local_4].[quotaUsageCreatedAfter2017Apr15T064739AndOnOrBefore2019Oct29T195722].[updatedAt], [local_4].[quotaUsageCreatedAfter2017Apr15T064739AndOnOrBefore2019Oct29T195722].[deletedAt], [local_4].[quotaUsageCreatedAfter2017Apr15T064739AndOnOrBefore2019Oct29T195722].[isDeleted], [local_4].[quotaUsageCreatedAfter2017Apr15T064739AndOnOrBefore2019Oct29T195722].[usageId], [local_4].[quotaUsageCreatedAfter2017Apr15T064739AndOnOrBefore2019Oct29T195722].[resourceName], [local_4].[quotaUsageCreatedAfter2017Apr15T064739AndOnOrBefore2019Oct29T195722].[untilRefresh] FROM [local_4].[quotaUsageCreatedAfter2017Apr15T064739AndOnOrBefore2019Oct29T195722]
UNION
SELECT [quotaUsageCreatedOnOrBefore2015Aug05T141702].[__orig_rowid] AS __orig_rowid, [local_4].[quotaUsageCreatedOnOrBefore2015Aug05T141702].[createdAt], [local_4].[quotaUsageCreatedOnOrBefore2015Aug05T141702].[updatedAt], [local_4].[quotaUsageCreatedOnOrBefore2015Aug05T141702].[deletedAt], [local_4].[quotaUsageCreatedOnOrBefore2015Aug05T141702].[isDeleted], [local_4].[quotaUsageCreatedOnOrBefore2015Aug05T141702].[usageId], [local_4].[quotaUsageCreatedOnOrBefore2015Aug05T141702].[resourceName], [local_4].[quotaUsageCreatedOnOrBefore2015Aug05T141702].[untilRefresh] FROM [local_4].[quotaUsageCreatedOnOrBefore2015Aug05T141702]
UNION
SELECT [QuotaUsageCreatedAfter2019Oct29OrNull].[__orig_rowid] AS __orig_rowid, [local_6].[QuotaUsageCreatedAfter2019Oct29OrNull].[CreatedAt], [local_6].[QuotaUsageCreatedAfter2019Oct29OrNull].[UpdatedAt], [local_6].[QuotaUsageCreatedAfter2019Oct29OrNull].[DeletedAt], [local_6].[QuotaUsageCreatedAfter2019Oct29OrNull].[IsDeleted], [local_6].[QuotaUsageCreatedAfter2019Oct29OrNull].[Id], [local_6].[QuotaUsageCreatedAfter2019Oct29OrNull].[ResourceName], [local_6].[QuotaUsageCreatedAfter2019Oct29OrNull].[SecondsUntilRefresh] FROM [local_6].[QuotaUsageCreatedAfter2019Oct29OrNull]
) t0
JOIN [local_6].[DeletedQuotaUsageSnapshot] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct quotas from vertical split + row partition on a fragment
CREATE VIEW "quotas" AS
SELECT t0.[quotaId], t1.[createdAt], t1.[updatedAt], t1.[deletedAt], t0.[isDeleted], t0.[projectId], t0.[resourceName], t0.[hardLimit], t0.[allocatedAmount]
FROM [local_4].[quotaAllocations] t0
JOIN (
SELECT [quotaCreatedAfter2015Oct26T081449AndOnOrBefore2017Jun15T032250].[__orig_rowid] AS __orig_rowid, [local_4].[quotaCreatedAfter2015Oct26T081449AndOnOrBefore2017Jun15T032250].[quotaId], [local_4].[quotaCreatedAfter2015Oct26T081449AndOnOrBefore2017Jun15T032250].[createdAt], [local_4].[quotaCreatedAfter2015Oct26T081449AndOnOrBefore2017Jun15T032250].[updatedAt], [local_4].[quotaCreatedAfter2015Oct26T081449AndOnOrBefore2017Jun15T032250].[deletedAt], [local_4].[quotaCreatedAfter2015Oct26T081449AndOnOrBefore2017Jun15T032250].[isDeleted], [local_4].[quotaCreatedAfter2015Oct26T081449AndOnOrBefore2017Jun15T032250].[projectId], [local_4].[quotaCreatedAfter2015Oct26T081449AndOnOrBefore2017Jun15T032250].[resourceName], [local_4].[quotaCreatedAfter2015Oct26T081449AndOnOrBefore2017Jun15T032250].[hardLimit] FROM [local_4].[quotaCreatedAfter2015Oct26T081449AndOnOrBefore2017Jun15T032250]
UNION
SELECT [quotaCreatedAfter2017Jun15T032250AndOnOrBefore2020Apr30T142201].[__orig_rowid] AS __orig_rowid, [local_4].[quotaCreatedAfter2017Jun15T032250AndOnOrBefore2020Apr30T142201].[quotaId], [local_4].[quotaCreatedAfter2017Jun15T032250AndOnOrBefore2020Apr30T142201].[createdAt], [local_4].[quotaCreatedAfter2017Jun15T032250AndOnOrBefore2020Apr30T142201].[updatedAt], [local_4].[quotaCreatedAfter2017Jun15T032250AndOnOrBefore2020Apr30T142201].[deletedAt], [local_4].[quotaCreatedAfter2017Jun15T032250AndOnOrBefore2020Apr30T142201].[isDeleted], [local_4].[quotaCreatedAfter2017Jun15T032250AndOnOrBefore2020Apr30T142201].[projectId], [local_4].[quotaCreatedAfter2017Jun15T032250AndOnOrBefore2020Apr30T142201].[resourceName], [local_4].[quotaCreatedAfter2017Jun15T032250AndOnOrBefore2020Apr30T142201].[hardLimit] FROM [local_4].[quotaCreatedAfter2017Jun15T032250AndOnOrBefore2020Apr30T142201]
UNION
SELECT [QuotaCreatedAfter2020Apr30OrNull].[__orig_rowid] AS __orig_rowid, [local_6].[QuotaCreatedAfter2020Apr30OrNull].[Id], [local_6].[QuotaCreatedAfter2020Apr30OrNull].[CreatedAt], [local_6].[QuotaCreatedAfter2020Apr30OrNull].[UpdatedAt], [local_6].[QuotaCreatedAfter2020Apr30OrNull].[DeletedAt], [local_6].[QuotaCreatedAfter2020Apr30OrNull].[IsDeleted], [local_6].[QuotaCreatedAfter2020Apr30OrNull].[ProjectId], [local_6].[QuotaCreatedAfter2020Apr30OrNull].[ResourceName], [local_6].[QuotaCreatedAfter2020Apr30OrNull].[HardLimit] FROM [local_6].[QuotaCreatedAfter2020Apr30OrNull]
UNION
SELECT [QuotaCreatedOnOrBefore2015Oct26].[__orig_rowid] AS __orig_rowid, [local_6].[QuotaCreatedOnOrBefore2015Oct26].[Id], [local_6].[QuotaCreatedOnOrBefore2015Oct26].[CreatedAt], [local_6].[QuotaCreatedOnOrBefore2015Oct26].[UpdatedAt], [local_6].[QuotaCreatedOnOrBefore2015Oct26].[DeletedAt], [local_6].[QuotaCreatedOnOrBefore2015Oct26].[IsDeleted], [local_6].[QuotaCreatedOnOrBefore2015Oct26].[ProjectId], [local_6].[QuotaCreatedOnOrBefore2015Oct26].[ResourceName], [local_6].[QuotaCreatedOnOrBefore2015Oct26].[HardLimit] FROM [local_6].[QuotaCreatedOnOrBefore2015Oct26]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct reservations from vertical split + row partition on a fragment
CREATE VIEW "reservations" AS
SELECT t1.[createdAt], t1.[updatedAt], t1.[deletedAt], t0.[isDeleted], t0.[reservationId], t0.[reservationUuid], t0.[usageId], t0.[projectId], t0.[resourceName], t0.[deltaAmount], t1.[expiresAt], t0.[allocatedQuotaId]
FROM (
SELECT [reservationsAllocatedDeltaAtMostMinusOne].[__orig_rowid] AS __orig_rowid, [local_4].[reservationsAllocatedDeltaAtMostMinusOne].[isDeleted], [local_4].[reservationsAllocatedDeltaAtMostMinusOne].[reservationId], [local_4].[reservationsAllocatedDeltaAtMostMinusOne].[reservationUuid], [local_4].[reservationsAllocatedDeltaAtMostMinusOne].[usageId], [local_4].[reservationsAllocatedDeltaAtMostMinusOne].[projectId], [local_4].[reservationsAllocatedDeltaAtMostMinusOne].[resourceName], [local_4].[reservationsAllocatedDeltaAtMostMinusOne].[deltaAmount], [local_4].[reservationsAllocatedDeltaAtMostMinusOne].[allocatedQuotaId] FROM [local_4].[reservationsAllocatedDeltaAtMostMinusOne]
UNION
SELECT [reservationsAllocatedDeltaBetweenMinusOneAndOneInclusive].[__orig_rowid] AS __orig_rowid, [local_4].[reservationsAllocatedDeltaBetweenMinusOneAndOneInclusive].[isDeleted], [local_4].[reservationsAllocatedDeltaBetweenMinusOneAndOneInclusive].[reservationId], [local_4].[reservationsAllocatedDeltaBetweenMinusOneAndOneInclusive].[reservationUuid], [local_4].[reservationsAllocatedDeltaBetweenMinusOneAndOneInclusive].[usageId], [local_4].[reservationsAllocatedDeltaBetweenMinusOneAndOneInclusive].[projectId], [local_4].[reservationsAllocatedDeltaBetweenMinusOneAndOneInclusive].[resourceName], [local_4].[reservationsAllocatedDeltaBetweenMinusOneAndOneInclusive].[deltaAmount], [local_4].[reservationsAllocatedDeltaBetweenMinusOneAndOneInclusive].[allocatedQuotaId] FROM [local_4].[reservationsAllocatedDeltaBetweenMinusOneAndOneInclusive]
UNION
SELECT [reservationsAllocatedDeltaGreaterThanOneOrNull].[__orig_rowid] AS __orig_rowid, [local_4].[reservationsAllocatedDeltaGreaterThanOneOrNull].[isDeleted], [local_4].[reservationsAllocatedDeltaGreaterThanOneOrNull].[reservationId], [local_4].[reservationsAllocatedDeltaGreaterThanOneOrNull].[reservationUuid], [local_4].[reservationsAllocatedDeltaGreaterThanOneOrNull].[usageId], [local_4].[reservationsAllocatedDeltaGreaterThanOneOrNull].[projectId], [local_4].[reservationsAllocatedDeltaGreaterThanOneOrNull].[resourceName], [local_4].[reservationsAllocatedDeltaGreaterThanOneOrNull].[deltaAmount], [local_4].[reservationsAllocatedDeltaGreaterThanOneOrNull].[allocatedQuotaId] FROM [local_4].[reservationsAllocatedDeltaGreaterThanOneOrNull]
) t0
JOIN [local_4].[reservationsByCreatedAt] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct services from vertical (column) split (4 fragments)
CREATE VIEW "services" AS
SELECT
    t2."CreatedAtTimestamp" AS "created_at",
    t2."UpdatedAtTimestamp" AS "updated_at",
    t2."DeletedAtTimestamp" AS "deleted_at",
    t0."IsDeleted" AS "deleted",
    t0."DetailsId" AS "id",
    t0."Hostname" AS "host",
    t0."ServiceBinary" AS "binary",
    t0."MessageTopic" AS "topic",
    t0."ReportCount" AS "report_count",
    t0."IsDisabled" AS "disabled",
    t0."AvailabilityZone" AS "availability_zone",
    t0."DisabledReason" AS "disabled_reason",
    t2."ModifiedAtTimestamp" AS "modified_at",
    t3."RpcCurrentVersion" AS "rpc_current_version",
    t3."RpcAvailableVersion" AS "rpc_available_version",
    t3."ObjectCurrentVersion" AS "object_current_version",
    t3."ObjectAvailableVersion" AS "object_available_version",
    t0."ReplicationStatus" AS "replication_status",
    t0."IsFrozen" AS "frozen",
    t0."ActiveBackendIdentifier" AS "active_backend_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "DetailsId" ORDER BY rowid) AS __rn FROM "local_7"."ServiceBackendDetails") t0
JOIN "local_7"."ServiceBackendStatus" t1 ON t0."DetailsId" IS t1."ServiceStatusId" AND t0.__rn = t1.__rn
JOIN "local_7"."ServiceLifecycleTimestamps" t2 ON t0."DetailsId" IS t2."LifecycleId" AND t0.__rn = t2.__rn
JOIN "local_7"."ServiceVersionCompatibility" t3 ON t0."DetailsId" IS t3."VersionRecordId" AND t0.__rn = t3.__rn;

-- Reconstruct snapshot_metadata from vertical (column) split (2 fragments)
CREATE VIEW "snapshot_metadata" AS
SELECT
    t0."created_timestamp" AS "created_at",
    t0."updated_timestamp" AS "updated_at",
    t0."deleted_timestamp" AS "deleted_at",
    t0."is_deleted_flag" AS "deleted",
    t0."meta_id" AS "id",
    t0."snapshot_ref_id" AS "snapshot_id",
    t1."meta_key" AS "key",
    t0."meta_value" AS "value"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "meta_id" ORDER BY rowid) AS __rn FROM "local_2"."snapshot_metadata_created_log") t0
JOIN "local_2"."snapshot_metadata_deleted_entries" t1 ON t0."meta_id" IS t1."deleted_meta_id" AND t0.__rn = t1.__rn;

-- Reconstruct snapshots from vertical split + row partition on a fragment
CREATE VIEW "snapshots" AS
SELECT t2.[created_timestamp], t2.[updated_timestamp], t2.[deleted_timestamp], t1.[is_deleted_flag], t0.[snapshot_id], t3.[volume_ref_id], t0.[user_ref], t0.[project_ref], t0.[status_text], t0.[progress_status], t3.[size_gb], t2.[scheduled_timestamp], t0.[display_name_text], t0.[display_description_text], t0.[provider_location_text], t0.[encryption_key_ref], t3.[volume_type_ref], t0.[cgsnapshot_ref_id], t0.[provider_identifier], t0.[provider_auth_data]
FROM [local_2].[snapshot_consistency_reference] t0
JOIN (
SELECT [snapshots_consistency_deleted_rows].[__orig_rowid] AS __orig_rowid, [local_2].[snapshots_consistency_deleted_rows].[is_deleted_flag], [local_2].[snapshots_consistency_deleted_rows].[snapshot_part_id], [local_2].[snapshots_consistency_deleted_rows].[status_text], [local_2].[snapshots_consistency_deleted_rows].[progress_status], [local_2].[snapshots_consistency_deleted_rows].[display_name_text], [local_2].[snapshots_consistency_deleted_rows].[display_description_text], [local_2].[snapshots_consistency_deleted_rows].[provider_location_text], [local_2].[snapshots_consistency_deleted_rows].[cgsnapshot_ref_id], [local_2].[snapshots_consistency_deleted_rows].[provider_auth_data] FROM [local_2].[snapshots_consistency_deleted_rows]
UNION
SELECT [snapshots_consistency_varied_status_rows].[__orig_rowid] AS __orig_rowid, [local_2].[snapshots_consistency_varied_status_rows].[is_deleted_flag], [local_2].[snapshots_consistency_varied_status_rows].[snapshot_part_id], [local_2].[snapshots_consistency_varied_status_rows].[status_text], [local_2].[snapshots_consistency_varied_status_rows].[progress_status], [local_2].[snapshots_consistency_varied_status_rows].[display_name_text], [local_2].[snapshots_consistency_varied_status_rows].[display_description_text], [local_2].[snapshots_consistency_varied_status_rows].[provider_location_text], [local_2].[snapshots_consistency_varied_status_rows].[cgsnapshot_ref_id], [local_2].[snapshots_consistency_varied_status_rows].[provider_auth_data] FROM [local_2].[snapshots_consistency_varied_status_rows]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_2].[snapshots_created_log] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_2].[snapshot_volume_info] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct transfers from vertical (column) split (2 fragments)
CREATE VIEW "transfers" AS
SELECT
    t0."created_timestamp" AS "created_at",
    t0."updated_timestamp" AS "updated_at",
    t0."deleted_timestamp" AS "deleted_at",
    t0."is_deleted_flag" AS "deleted",
    t0."transfer_id" AS "id",
    t0."volume_ref_id" AS "volume_id",
    t0."display_name_text" AS "display_name",
    t1."crypt_salt" AS "salt",
    t1."crypt_hash_value" AS "crypt_hash",
    t0."expires_timestamp" AS "expires_at"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "transfer_id" ORDER BY rowid) AS __rn FROM "local_2"."transfer_creation_log") t0
JOIN "local_2"."transfer_encryption_hashes" t1 ON t0."transfer_id" IS t1."transfer_crypto_id" AND t0.__rn = t1.__rn;

-- Reconstruct volume_admin_metadata from vertical split + row partition on a fragment
CREATE VIEW "volume_admin_metadata" AS
SELECT t0.[created_timestamp], t0.[updated_timestamp], t0.[deleted_timestamp], t0.[is_deleted_flag], t0.[admin_meta_id], t0.[volume_ref_id], t1.[meta_key], t0.[meta_value]
FROM (
SELECT [volume_admin_metadata_mixed_values].[__orig_rowid] AS __orig_rowid, [local_2].[volume_admin_metadata_mixed_values].[created_timestamp], [local_2].[volume_admin_metadata_mixed_values].[updated_timestamp], [local_2].[volume_admin_metadata_mixed_values].[deleted_timestamp], [local_2].[volume_admin_metadata_mixed_values].[is_deleted_flag], [local_2].[volume_admin_metadata_mixed_values].[admin_meta_id], [local_2].[volume_admin_metadata_mixed_values].[volume_ref_id], [local_2].[volume_admin_metadata_mixed_values].[meta_value] FROM [local_2].[volume_admin_metadata_mixed_values]
UNION
SELECT [volume_admin_metadata_rw_values].[__orig_rowid] AS __orig_rowid, [local_2].[volume_admin_metadata_rw_values].[created_timestamp], [local_2].[volume_admin_metadata_rw_values].[updated_timestamp], [local_2].[volume_admin_metadata_rw_values].[deleted_timestamp], [local_2].[volume_admin_metadata_rw_values].[is_deleted_flag], [local_2].[volume_admin_metadata_rw_values].[admin_meta_id], [local_2].[volume_admin_metadata_rw_values].[volume_ref_id], [local_2].[volume_admin_metadata_rw_values].[meta_value] FROM [local_2].[volume_admin_metadata_rw_values]
) t0
JOIN [local_2].[volume_admin_metadata_deleted_entries] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct volume_attachment from vertical split + row partition on a fragment
CREATE VIEW "volume_attachment" AS
SELECT t1.[crt_ts], t1.[upd_ts], t1.[del_ts], t0.[del_flag], t0.[attach_ref], t0.[vol_id], t0.[att_host], t0.[inst_uuid], t0.[mnt_point], t1.[att_ts], t1.[detach_ts], t0.[att_mode], t0.[att_status]
FROM (
SELECT [vol_attach_inst_other].[__orig_rowid] AS __orig_rowid, [local_5].[vol_attach_inst_other].[del_flag], [local_5].[vol_attach_inst_other].[attach_ref], [local_5].[vol_attach_inst_other].[vol_id], [local_5].[vol_attach_inst_other].[att_host], [local_5].[vol_attach_inst_other].[inst_uuid], [local_5].[vol_attach_inst_other].[mnt_point], [local_5].[vol_attach_inst_other].[att_mode], [local_5].[vol_attach_inst_other].[att_status] FROM [local_5].[vol_attach_inst_other]
UNION
SELECT [volume_attachments_for_selected_instances].[__orig_rowid] AS __orig_rowid, [local_8].[volume_attachments_for_selected_instances].[is_deleted], [local_8].[volume_attachments_for_selected_instances].[attachment_id], [local_8].[volume_attachments_for_selected_instances].[volume_identifier], [local_8].[volume_attachments_for_selected_instances].[attached_host_name], [local_8].[volume_attachments_for_selected_instances].[instance_reference_uuid], [local_8].[volume_attachments_for_selected_instances].[mount_point], [local_8].[volume_attachments_for_selected_instances].[attach_mode_type], [local_8].[volume_attachments_for_selected_instances].[attach_state] FROM [local_8].[volume_attachments_for_selected_instances]
UNION
SELECT [volume_attachments_instance_64d7cd79_6dc6_404c_b603_8cdd4f9263a0].[__orig_rowid] AS __orig_rowid, [local_8].[volume_attachments_instance_64d7cd79_6dc6_404c_b603_8cdd4f9263a0].[is_deleted], [local_8].[volume_attachments_instance_64d7cd79_6dc6_404c_b603_8cdd4f9263a0].[attachment_id], [local_8].[volume_attachments_instance_64d7cd79_6dc6_404c_b603_8cdd4f9263a0].[volume_identifier], [local_8].[volume_attachments_instance_64d7cd79_6dc6_404c_b603_8cdd4f9263a0].[attached_host_name], [local_8].[volume_attachments_instance_64d7cd79_6dc6_404c_b603_8cdd4f9263a0].[instance_reference_uuid], [local_8].[volume_attachments_instance_64d7cd79_6dc6_404c_b603_8cdd4f9263a0].[mount_point], [local_8].[volume_attachments_instance_64d7cd79_6dc6_404c_b603_8cdd4f9263a0].[attach_mode_type], [local_8].[volume_attachments_instance_64d7cd79_6dc6_404c_b603_8cdd4f9263a0].[attach_state] FROM [local_8].[volume_attachments_instance_64d7cd79_6dc6_404c_b603_8cdd4f9263a0]
UNION
SELECT [volume_attachments_instance_9b309acd_a62c_436e_b116_ff7554e6ec1e].[__orig_rowid] AS __orig_rowid, [local_8].[volume_attachments_instance_9b309acd_a62c_436e_b116_ff7554e6ec1e].[is_deleted], [local_8].[volume_attachments_instance_9b309acd_a62c_436e_b116_ff7554e6ec1e].[attachment_id], [local_8].[volume_attachments_instance_9b309acd_a62c_436e_b116_ff7554e6ec1e].[volume_identifier], [local_8].[volume_attachments_instance_9b309acd_a62c_436e_b116_ff7554e6ec1e].[attached_host_name], [local_8].[volume_attachments_instance_9b309acd_a62c_436e_b116_ff7554e6ec1e].[instance_reference_uuid], [local_8].[volume_attachments_instance_9b309acd_a62c_436e_b116_ff7554e6ec1e].[mount_point], [local_8].[volume_attachments_instance_9b309acd_a62c_436e_b116_ff7554e6ec1e].[attach_mode_type], [local_8].[volume_attachments_instance_9b309acd_a62c_436e_b116_ff7554e6ec1e].[attach_state] FROM [local_8].[volume_attachments_instance_9b309acd_a62c_436e_b116_ff7554e6ec1e]
UNION
SELECT [volume_attachments_instance_f651937a_8bcd_43f1_910e_f5b61fa358ac].[__orig_rowid] AS __orig_rowid, [local_8].[volume_attachments_instance_f651937a_8bcd_43f1_910e_f5b61fa358ac].[is_deleted], [local_8].[volume_attachments_instance_f651937a_8bcd_43f1_910e_f5b61fa358ac].[attachment_id], [local_8].[volume_attachments_instance_f651937a_8bcd_43f1_910e_f5b61fa358ac].[volume_identifier], [local_8].[volume_attachments_instance_f651937a_8bcd_43f1_910e_f5b61fa358ac].[attached_host_name], [local_8].[volume_attachments_instance_f651937a_8bcd_43f1_910e_f5b61fa358ac].[instance_reference_uuid], [local_8].[volume_attachments_instance_f651937a_8bcd_43f1_910e_f5b61fa358ac].[mount_point], [local_8].[volume_attachments_instance_f651937a_8bcd_43f1_910e_f5b61fa358ac].[attach_mode_type], [local_8].[volume_attachments_instance_f651937a_8bcd_43f1_910e_f5b61fa358ac].[attach_state] FROM [local_8].[volume_attachments_instance_f651937a_8bcd_43f1_910e_f5b61fa358ac]
) t0
JOIN [local_5].[vol_attach_state] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct volume_glance_metadata from vertical split + row partition on a fragment
CREATE VIEW "volume_glance_metadata" AS
SELECT t0.[created_timestamp], t0.[updated_timestamp], t0.[deleted_timestamp], t0.[is_deleted_flag], t0.[meta_id], t1.[volume_ref_id], t0.[snapshot_ref_id], t0.[meta_key], t0.[meta_value]
FROM (
SELECT [volume_glance_meta_created_after_2020_10_21_or_null].[__orig_rowid] AS __orig_rowid, [local_2].[volume_glance_meta_created_after_2020_10_21_or_null].[created_timestamp], [local_2].[volume_glance_meta_created_after_2020_10_21_or_null].[updated_timestamp], [local_2].[volume_glance_meta_created_after_2020_10_21_or_null].[deleted_timestamp], [local_2].[volume_glance_meta_created_after_2020_10_21_or_null].[is_deleted_flag], [local_2].[volume_glance_meta_created_after_2020_10_21_or_null].[meta_id], [local_2].[volume_glance_meta_created_after_2020_10_21_or_null].[snapshot_ref_id], [local_2].[volume_glance_meta_created_after_2020_10_21_or_null].[meta_key], [local_2].[volume_glance_meta_created_after_2020_10_21_or_null].[meta_value] FROM [local_2].[volume_glance_meta_created_after_2020_10_21_or_null]
UNION
SELECT [volume_glance_meta_created_between_2016_04_26_and_2018_06_24].[__orig_rowid] AS __orig_rowid, [local_2].[volume_glance_meta_created_between_2016_04_26_and_2018_06_24].[created_timestamp], [local_2].[volume_glance_meta_created_between_2016_04_26_and_2018_06_24].[updated_timestamp], [local_2].[volume_glance_meta_created_between_2016_04_26_and_2018_06_24].[deleted_timestamp], [local_2].[volume_glance_meta_created_between_2016_04_26_and_2018_06_24].[is_deleted_flag], [local_2].[volume_glance_meta_created_between_2016_04_26_and_2018_06_24].[meta_id], [local_2].[volume_glance_meta_created_between_2016_04_26_and_2018_06_24].[snapshot_ref_id], [local_2].[volume_glance_meta_created_between_2016_04_26_and_2018_06_24].[meta_key], [local_2].[volume_glance_meta_created_between_2016_04_26_and_2018_06_24].[meta_value] FROM [local_2].[volume_glance_meta_created_between_2016_04_26_and_2018_06_24]
UNION
SELECT [volume_glance_meta_created_between_2018_06_24_and_2020_10_21].[__orig_rowid] AS __orig_rowid, [local_2].[volume_glance_meta_created_between_2018_06_24_and_2020_10_21].[created_timestamp], [local_2].[volume_glance_meta_created_between_2018_06_24_and_2020_10_21].[updated_timestamp], [local_2].[volume_glance_meta_created_between_2018_06_24_and_2020_10_21].[deleted_timestamp], [local_2].[volume_glance_meta_created_between_2018_06_24_and_2020_10_21].[is_deleted_flag], [local_2].[volume_glance_meta_created_between_2018_06_24_and_2020_10_21].[meta_id], [local_2].[volume_glance_meta_created_between_2018_06_24_and_2020_10_21].[snapshot_ref_id], [local_2].[volume_glance_meta_created_between_2018_06_24_and_2020_10_21].[meta_key], [local_2].[volume_glance_meta_created_between_2018_06_24_and_2020_10_21].[meta_value] FROM [local_2].[volume_glance_meta_created_between_2018_06_24_and_2020_10_21]
UNION
SELECT [volume_glance_meta_created_on_or_before_2016_04_26_22_34_47].[__orig_rowid] AS __orig_rowid, [local_2].[volume_glance_meta_created_on_or_before_2016_04_26_22_34_47].[created_timestamp], [local_2].[volume_glance_meta_created_on_or_before_2016_04_26_22_34_47].[updated_timestamp], [local_2].[volume_glance_meta_created_on_or_before_2016_04_26_22_34_47].[deleted_timestamp], [local_2].[volume_glance_meta_created_on_or_before_2016_04_26_22_34_47].[is_deleted_flag], [local_2].[volume_glance_meta_created_on_or_before_2016_04_26_22_34_47].[meta_id], [local_2].[volume_glance_meta_created_on_or_before_2016_04_26_22_34_47].[snapshot_ref_id], [local_2].[volume_glance_meta_created_on_or_before_2016_04_26_22_34_47].[meta_key], [local_2].[volume_glance_meta_created_on_or_before_2016_04_26_22_34_47].[meta_value] FROM [local_2].[volume_glance_meta_created_on_or_before_2016_04_26_22_34_47]
) t0
JOIN [local_2].[volume_glance_meta_deleted_entries] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct volume_metadata from vertical split + row partition on a fragment
CREATE VIEW "volume_metadata" AS
SELECT t0.[created_timestamp], t0.[updated_timestamp], t0.[deleted_timestamp], t0.[is_deleted_flag], t0.[meta_id], t0.[volume_ref_id], t0.[meta_key], t1.[meta_value]
FROM [local_2].[volume_metadata_created_log] t0
JOIN (
SELECT [volume_metadata_deleted_other_values].[__orig_rowid] AS __orig_rowid, [local_2].[volume_metadata_deleted_other_values].[is_deleted_flag], [local_2].[volume_metadata_deleted_other_values].[deleted_meta_id], [local_2].[volume_metadata_deleted_other_values].[volume_ref_id], [local_2].[volume_metadata_deleted_other_values].[meta_key], [local_2].[volume_metadata_deleted_other_values].[meta_value] FROM [local_2].[volume_metadata_deleted_other_values]
UNION
SELECT [volume_metadata_deleted_specific_values].[__orig_rowid] AS __orig_rowid, [local_2].[volume_metadata_deleted_specific_values].[is_deleted_flag], [local_2].[volume_metadata_deleted_specific_values].[deleted_meta_id], [local_2].[volume_metadata_deleted_specific_values].[volume_ref_id], [local_2].[volume_metadata_deleted_specific_values].[meta_key], [local_2].[volume_metadata_deleted_specific_values].[meta_value] FROM [local_2].[volume_metadata_deleted_specific_values]
UNION
SELECT [volume_metadata_deleted_value_flare2_55].[__orig_rowid] AS __orig_rowid, [local_2].[volume_metadata_deleted_value_flare2_55].[is_deleted_flag], [local_2].[volume_metadata_deleted_value_flare2_55].[deleted_meta_id], [local_2].[volume_metadata_deleted_value_flare2_55].[volume_ref_id], [local_2].[volume_metadata_deleted_value_flare2_55].[meta_key], [local_2].[volume_metadata_deleted_value_flare2_55].[meta_value] FROM [local_2].[volume_metadata_deleted_value_flare2_55]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct volume_type_extra_specs from local_8.volume_type_extra_options
CREATE VIEW "volume_type_extra_specs" AS
SELECT
    "local_8"."volume_type_extra_options"."created_timestamp" AS "created_at",
    "local_8"."volume_type_extra_options"."updated_timestamp" AS "updated_at",
    "local_8"."volume_type_extra_options"."deleted_timestamp" AS "deleted_at",
    "local_8"."volume_type_extra_options"."is_deleted" AS "deleted",
    "local_8"."volume_type_extra_options"."extra_option_id" AS "id",
    "local_8"."volume_type_extra_options"."volume_type_identifier" AS "volume_type_id",
    "local_8"."volume_type_extra_options"."option_key" AS "key",
    "local_8"."volume_type_extra_options"."option_value" AS "value"
FROM "local_8"."volume_type_extra_options";

-- Reconstruct volume_type_projects from local_7.VolumeTypeProjectAssignments
CREATE VIEW "volume_type_projects" AS
SELECT
    "local_7"."VolumeTypeProjectAssignments"."AssignmentId" AS "id",
    "local_7"."VolumeTypeProjectAssignments"."CreatedAtTimestamp" AS "created_at",
    "local_7"."VolumeTypeProjectAssignments"."UpdatedAtTimestamp" AS "updated_at",
    "local_7"."VolumeTypeProjectAssignments"."DeletedAtTimestamp" AS "deleted_at",
    "local_7"."VolumeTypeProjectAssignments"."VolumeTypeId" AS "volume_type_id",
    "local_7"."VolumeTypeProjectAssignments"."ProjectId" AS "project_id",
    "local_7"."VolumeTypeProjectAssignments"."IsDeleted" AS "deleted"
FROM "local_7"."VolumeTypeProjectAssignments";

-- Reconstruct volume_types from vertical (column) split (2 fragments)
CREATE VIEW "volume_types" AS
SELECT
    t1."created_timestamp" AS "created_at",
    t1."updated_timestamp" AS "updated_at",
    t1."deleted_timestamp" AS "deleted_at",
    t0."del_flag" AS "deleted",
    t0."type_id" AS "id",
    t0."type_name" AS "name",
    t0."qos_id" AS "qos_specs_id",
    t0."pub_flag" AS "is_public",
    t0."descr" AS "description"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "type_id" ORDER BY rowid) AS __rn FROM "local_5"."vol_type_del") t0
JOIN "local_8"."volume_type_records_with_creation" t1 ON t0."type_id" IS t1."volume_type_identifier" AND t0.__rn = t1.__rn;

-- Reconstruct volumes from vertical split + row partition on a fragment
CREATE VIEW "volumes" AS
SELECT t2.[created_timestamp], t2.[updated_timestamp], t2.[deleted_timestamp], t1.[is_deleted], t0.[volume_identifier], t3.[ec2_instance_id], t4.[user_ref], t4.[project_ref], t1.[host_name], t3.[size_gb], t0.[availability_zone_name], t0.[current_status], t0.[attach_state], t2.[scheduled_timestamp], t2.[launched_timestamp], t2.[terminated_timestamp], t1.[display_label], t1.[description_text], t3.[provider_location_text], t3.[provider_auth_data], t3.[snapshot_ref_id], t3.[volume_type_ref], t4.[source_volume_ref], t1.[is_bootable], t3.[provider_geometry_info], t3.[name_key], t3.[encryption_key_ref], t0.[migration_state], t0.[replication_state], t0.[replication_extended_info], t0.[replication_driver_info], t3.[consistency_group_ref], t3.[provider_identifier], t1.[multi_attach_enabled], t0.[previous_state]
FROM (
SELECT [volume_attach_status_attached_or_null].[__orig_rowid] AS __orig_rowid, [local_8].[volume_attach_status_attached_or_null].[volume_identifier], [local_8].[volume_attach_status_attached_or_null].[availability_zone_name], [local_8].[volume_attach_status_attached_or_null].[current_status], [local_8].[volume_attach_status_attached_or_null].[attach_state], [local_8].[volume_attach_status_attached_or_null].[migration_state], [local_8].[volume_attach_status_attached_or_null].[replication_state], [local_8].[volume_attach_status_attached_or_null].[replication_extended_info], [local_8].[volume_attach_status_attached_or_null].[replication_driver_info], [local_8].[volume_attach_status_attached_or_null].[previous_state] FROM [local_8].[volume_attach_status_attached_or_null]
UNION
SELECT [volume_attach_status_detached].[__orig_rowid] AS __orig_rowid, [local_8].[volume_attach_status_detached].[volume_identifier], [local_8].[volume_attach_status_detached].[availability_zone_name], [local_8].[volume_attach_status_detached].[current_status], [local_8].[volume_attach_status_detached].[attach_state], [local_8].[volume_attach_status_detached].[migration_state], [local_8].[volume_attach_status_detached].[replication_state], [local_8].[volume_attach_status_detached].[replication_extended_info], [local_8].[volume_attach_status_detached].[replication_driver_info], [local_8].[volume_attach_status_detached].[previous_state] FROM [local_8].[volume_attach_status_detached]
) t0
JOIN [local_8].[volume_boot_attributes] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_8].[volume_event_timestamps] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_2].[volume_records_by_name_key] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_2].[volume_records_extended] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];
