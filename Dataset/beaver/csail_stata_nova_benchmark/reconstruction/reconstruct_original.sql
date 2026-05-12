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

-- Reconstruct agent_builds from vertical (column) split (2 fragments)
CREATE VIEW "agent_builds" AS
SELECT
    t1."c_ts" AS "created_at",
    t1."u_ts" AS "updated_at",
    t1."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t0."hyp_nm" AS "hypervisor",
    t0."os_nm" AS "os",
    t0."arch_nm" AS "architecture",
    t0."ver" AS "version",
    t0."src_url" AS "url",
    t0."md5_sum" AS "md5hash",
    t0."is_del" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."agt_bld_arch") t0
JOIN "local_1"."agt_bld_cts" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct aggregate_hosts from vertical split + row partition on a fragment
CREATE VIEW "aggregate_hosts" AS
SELECT t1.[c_ts], t1.[u_ts], t1.[d_ts], t0.[id_pk], t0.[host_nm], t0.[agg_id_fk], t0.[is_del]
FROM (
SELECT [agg_hosts_other_bucket].[__orig_rowid] AS __orig_rowid, [local_1].[agg_hosts_other_bucket].[id_pk], [local_1].[agg_hosts_other_bucket].[host_nm], [local_1].[agg_hosts_other_bucket].[agg_id_fk], [local_1].[agg_hosts_other_bucket].[is_del] FROM [local_1].[agg_hosts_other_bucket]
UNION
SELECT [agg_hosts_spec_hosts].[__orig_rowid] AS __orig_rowid, [local_1].[agg_hosts_spec_hosts].[id_pk], [local_1].[agg_hosts_spec_hosts].[host_nm], [local_1].[agg_hosts_spec_hosts].[agg_id], [local_1].[agg_hosts_spec_hosts].[is_del] FROM [local_1].[agg_hosts_spec_hosts]
) t0
JOIN [local_1].[agg_hosts_with_aggfk] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct aggregate_metadata from vertical (column) split (2 fragments)
CREATE VIEW "aggregate_metadata" AS
SELECT
    t0."c_ts" AS "created_at",
    t0."u_ts" AS "updated_at",
    t0."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t0."agg_id" AS "aggregate_id",
    t1."meta_k" AS "key",
    t0."meta_v" AS "value",
    t0."is_del" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."agg_meta_cts_bucket") t0
JOIN "local_1"."agg_meta_with_aggfk" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct aggregates from local_1.aggs
CREATE VIEW "aggregates" AS
SELECT
    "local_1"."aggs"."c_ts" AS "created_at",
    "local_1"."aggs"."u_ts" AS "updated_at",
    "local_1"."aggs"."d_ts" AS "deleted_at",
    "local_1"."aggs"."id_pk" AS "id",
    "local_1"."aggs"."nm" AS "name",
    "local_1"."aggs"."is_del" AS "deleted",
    "local_1"."aggs"."uuid_val" AS "uuid"
FROM "local_1"."aggs";

-- Reconstruct allocations from local_2.resource_allocations
CREATE VIEW "allocations" AS
SELECT
    "local_2"."resource_allocations"."allocation_id" AS "id",
    "local_2"."resource_allocations"."provider_identifier" AS "resource_provider_id",
    "local_2"."resource_allocations"."consumer_identifier" AS "consumer_id",
    "local_2"."resource_allocations"."resource_class_identifier" AS "resource_class_id",
    "local_2"."resource_allocations"."used_amount" AS "used"
FROM "local_2"."resource_allocations";

-- Reconstruct block_device_mapping from vertical split + row partition on a fragment
CREATE VIEW "block_device_mapping" AS
SELECT t3.[c_ts], t3.[u_ts], t3.[d_ts], t0.[id_pk], t0.[dev_nm], t1.[del_on_term], t1.[snap_id], t1.[vol_id_fk], t1.[vol_size], t0.[no_dev_flg], t1.[conn_info], t1.[inst_uuid_fk], t1.[is_del], t1.[src_type], t2.[dest_type], t1.[guest_fmt], t2.[dev_type], t2.[disk_bus], t0.[boot_idx], t1.[img_id]
FROM [local_1].[bdmap_boot_idx] t0
JOIN (
SELECT [bdmap_conninfo_largevol].[__orig_rowid] AS __orig_rowid, [local_1].[bdmap_conninfo_largevol].[id_pk], [local_1].[bdmap_conninfo_largevol].[del_on_term], [local_1].[bdmap_conninfo_largevol].[snap_id], [local_1].[bdmap_conninfo_largevol].[vol_id_fk], [local_1].[bdmap_conninfo_largevol].[vol_size], [local_1].[bdmap_conninfo_largevol].[conn_info], [local_1].[bdmap_conninfo_largevol].[inst_uuid_fk], [local_1].[bdmap_conninfo_largevol].[is_del], [local_1].[bdmap_conninfo_largevol].[src_type], [local_1].[bdmap_conninfo_largevol].[guest_fmt], [local_1].[bdmap_conninfo_largevol].[img_id] FROM [local_1].[bdmap_conninfo_largevol]
UNION
SELECT [bdmap_conninfo_smallvol].[__orig_rowid] AS __orig_rowid, [local_1].[bdmap_conninfo_smallvol].[id_pk], [local_1].[bdmap_conninfo_smallvol].[del_on_term], [local_1].[bdmap_conninfo_smallvol].[snap_id], [local_1].[bdmap_conninfo_smallvol].[vol_id_fk], [local_1].[bdmap_conninfo_smallvol].[vol_size], [local_1].[bdmap_conninfo_smallvol].[conn_info], [local_1].[bdmap_conninfo_smallvol].[inst_uuid_fk], [local_1].[bdmap_conninfo_smallvol].[is_del], [local_1].[bdmap_conninfo_smallvol].[src_type], [local_1].[bdmap_conninfo_smallvol].[guest_fmt], [local_1].[bdmap_conninfo_smallvol].[img_id] FROM [local_1].[bdmap_conninfo_smallvol]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[bdmap_conninfo_voltype] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[bdmap_cts] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct bw_usage_cache from vertical (column) split (2 fragments)
CREATE VIEW "bw_usage_cache" AS
SELECT
    t0."c_ts" AS "created_at",
    t0."u_ts" AS "updated_at",
    t0."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t0."start_ts" AS "start_period",
    t0."last_ref_ts" AS "last_refreshed",
    t1."bw_in_val" AS "bw_in",
    t1."bw_out_val" AS "bw_out",
    t0."mac_addr" AS "mac",
    t0."uuid_val" AS "uuid",
    t1."last_ctr_in" AS "last_ctr_in",
    t1."last_ctr_out" AS "last_ctr_out",
    t0."is_del" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."bw_cache_cts") t0
JOIN "local_1"."bw_cache_val" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct cells from vertical (column) split (2 fragments)
CREATE VIEW "cells" AS
SELECT
    t1."c_ts" AS "created_at",
    t1."u_ts" AS "updated_at",
    t1."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t0."api_url" AS "api_url",
    t0."wt_offset" AS "weight_offset",
    t0."wt_scale" AS "weight_scale",
    t0."nm" AS "name",
    t0."is_parent_flg" AS "is_parent",
    t0."is_del" AS "deleted",
    t0."transport_url" AS "transport_url"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."cells_api_cfg") t0
JOIN "local_1"."cells_cts" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct certificates from vertical split + row partition on a fragment
CREATE VIEW "certificates" AS
SELECT t0.[c_ts], t0.[u_ts], t0.[d_ts], t0.[id_pk], t1.[usr_id], t0.[proj_id], t0.[file_nm], t0.[is_del]
FROM [local_1].[certs_cts] t0
JOIN (
SELECT [certs_deleted_proj_3008a1].[__orig_rowid] AS __orig_rowid, [local_1].[certs_deleted_proj_3008a1].[id_pk], [local_1].[certs_deleted_proj_3008a1].[usr_id], [local_1].[certs_deleted_proj_3008a1].[proj_id], [local_1].[certs_deleted_proj_3008a1].[file_nm], [local_1].[certs_deleted_proj_3008a1].[is_del] FROM [local_1].[certs_deleted_proj_3008a1]
UNION
SELECT [certs_deleted_proj_70b25_b7188_bfd50_dba6].[__orig_rowid] AS __orig_rowid, [local_1].[certs_deleted_proj_70b25_b7188_bfd50_dba6].[id_pk], [local_1].[certs_deleted_proj_70b25_b7188_bfd50_dba6].[usr_id], [local_1].[certs_deleted_proj_70b25_b7188_bfd50_dba6].[proj_id], [local_1].[certs_deleted_proj_70b25_b7188_bfd50_dba6].[file_nm], [local_1].[certs_deleted_proj_70b25_b7188_bfd50_dba6].[is_del] FROM [local_1].[certs_deleted_proj_70b25_b7188_bfd50_dba6]
UNION
SELECT [certs_deleted_proj_71322e_or_other].[__orig_rowid] AS __orig_rowid, [local_1].[certs_deleted_proj_71322e_or_other].[id_pk], [local_1].[certs_deleted_proj_71322e_or_other].[usr_id], [local_1].[certs_deleted_proj_71322e_or_other].[proj_id], [local_1].[certs_deleted_proj_71322e_or_other].[file_nm], [local_1].[certs_deleted_proj_71322e_or_other].[is_del] FROM [local_1].[certs_deleted_proj_71322e_or_other]
UNION
SELECT [certs_deleted_proj_98333_2a9b_97107].[__orig_rowid] AS __orig_rowid, [local_1].[certs_deleted_proj_98333_2a9b_97107].[id_pk], [local_1].[certs_deleted_proj_98333_2a9b_97107].[usr_id], [local_1].[certs_deleted_proj_98333_2a9b_97107].[proj_id], [local_1].[certs_deleted_proj_98333_2a9b_97107].[file_nm], [local_1].[certs_deleted_proj_98333_2a9b_97107].[is_del] FROM [local_1].[certs_deleted_proj_98333_2a9b_97107]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct compute_nodes from vertical split + row partition on a fragment
CREATE VIEW "compute_nodes" AS
SELECT t3.[c_ts], t3.[u_ts], t3.[d_ts], t0.[id_pk], t2.[svc_id_fk], t1.[vcpus], t1.[mem_mb], t4.[local_gb], t1.[vcpus_used], t1.[mem_mb_used], t4.[local_gb_used], t1.[hyp_type], t1.[hyp_ver], t1.[cpu_info_blob], t4.[disk_avail_least], t1.[free_ram_mb], t4.[free_disk_gb], t1.[curr_workload], t1.[run_vms], t2.[hyp_host_nm], t3.[is_del], t2.[host_ip], t1.[supp_instances], t1.[pci_stats], t1.[metrics_blob], t1.[extra_res], t1.[stats_blob], t1.[numa_topo], t2.[host_nm], t0.[ram_alloc_ratio], t0.[cpu_alloc_ratio], t1.[uuid_val], t0.[disk_alloc_ratio]
FROM [local_1].[compnode_cpu_alloc_rat] t0
JOIN [local_1].[compnode_cpu_info] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [compnode_cpu_info_run0].[__orig_rowid] AS __orig_rowid, [local_1].[compnode_cpu_info_run0].[id_pk], [local_1].[compnode_cpu_info_run0].[svc_id_fk], [local_1].[compnode_cpu_info_run0].[vcpus], [local_1].[compnode_cpu_info_run0].[hyp_type], [local_1].[compnode_cpu_info_run0].[hyp_ver], [local_1].[compnode_cpu_info_run0].[cpu_info_blob], [local_1].[compnode_cpu_info_run0].[curr_workload], [local_1].[compnode_cpu_info_run0].[run_vms], [local_1].[compnode_cpu_info_run0].[hyp_host_nm], [local_1].[compnode_cpu_info_run0].[host_ip], [local_1].[compnode_cpu_info_run0].[supp_instances], [local_1].[compnode_cpu_info_run0].[extra_res], [local_1].[compnode_cpu_info_run0].[stats_blob], [local_1].[compnode_cpu_info_run0].[host_nm], [local_1].[compnode_cpu_info_run0].[uuid_val] FROM [local_1].[compnode_cpu_info_run0]
UNION
SELECT [compnode_cpu_info_runpos].[__orig_rowid] AS __orig_rowid, [local_1].[compnode_cpu_info_runpos].[id_pk], [local_1].[compnode_cpu_info_runpos].[svc_id_fk], [local_1].[compnode_cpu_info_runpos].[vcpus], [local_1].[compnode_cpu_info_runpos].[hyp_type], [local_1].[compnode_cpu_info_runpos].[hyp_ver], [local_1].[compnode_cpu_info_runpos].[cpu_info_blob], [local_1].[compnode_cpu_info_runpos].[curr_workload], [local_1].[compnode_cpu_info_runpos].[run_vms], [local_1].[compnode_cpu_info_runpos].[hyp_host_nm], [local_1].[compnode_cpu_info_runpos].[host_ip], [local_1].[compnode_cpu_info_runpos].[supp_instances], [local_1].[compnode_cpu_info_runpos].[extra_res], [local_1].[compnode_cpu_info_runpos].[stats_blob], [local_1].[compnode_cpu_info_runpos].[host_nm], [local_1].[compnode_cpu_info_runpos].[uuid_val] FROM [local_1].[compnode_cpu_info_runpos]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[compnode_cts] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_1].[compnode_disk_least] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct console_pools from vertical (column) split (2 fragments)
CREATE VIEW "console_pools" AS
SELECT
    t1."c_ts" AS "created_at",
    t1."u_ts" AS "updated_at",
    t1."d_ts" AS "deleted_at",
    t0."poolEntryId" AS "id",
    t0."endpointAddress" AS "address",
    t0."accessUsername" AS "username",
    t0."accessPassword" AS "password",
    t0."consoleTypeName" AS "console_type",
    t0."publicHostName" AS "public_hostname",
    t0."localHostName" AS "host",
    t0."computeHostName" AS "compute_host",
    t0."deletedFlag" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "poolEntryId" ORDER BY rowid) AS __rn FROM "local_4"."consolePoolEntries") t0
JOIN "local_1"."console_pools_by_type" t1 ON t0."poolEntryId" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct consoles from vertical (column) split (2 fragments)
CREATE VIEW "consoles" AS
SELECT
    t0."createdTimestamp" AS "created_at",
    t0."updatedTimestamp" AS "updated_at",
    t0."deletedTimestamp" AS "deleted_at",
    t0."recordId" AS "id",
    t1."instanceDisplayName" AS "instance_name",
    t0."accessPassword" AS "password",
    t0."portNumber" AS "port",
    t0."poolEntryId" AS "pool_id",
    t1."instanceUuid" AS "instance_uuid",
    t0."deletedFlag" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "recordId" ORDER BY rowid) AS __rn FROM "local_4"."consoleCreationRecords") t0
JOIN "local_4"."consoleDeletionArchive" t1 ON t0."recordId" IS t1."archiveId" AND t0.__rn = t1.__rn;

-- Reconstruct dns_domains from vertical (column) split (2 fragments)
CREATE VIEW "dns_domains" AS
SELECT
    t1."c_ts" AS "created_at",
    t0."u_ts" AS "updated_at",
    t1."d_ts" AS "deleted_at",
    t0."is_del" AS "deleted",
    t0."domain_nm" AS "domain",
    t0."scope_k" AS "scope",
    t0."az_nm" AS "availability_zone",
    t0."proj_id" AS "project_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "domain_nm" ORDER BY rowid) AS __rn FROM "local_1"."dns_dom_az") t0
JOIN "local_1"."dns_dom_az_cts" t1 ON t0."domain_nm" IS t1."domain_nm" AND t0.__rn = t1.__rn;

-- Reconstruct fixed_ips from vertical split + row partition on a fragment
CREATE VIEW "fixed_ips" AS
SELECT t2.[c_ts], t2.[u_ts], t2.[d_ts], t0.[id_pk], t0.[addr], t1.[net_id_fk], t0.[is_alloc], t0.[is_leased], t0.[is_reserved], t1.[vif_id_fk], t0.[host_nm], t0.[inst_uuid_fk], t0.[is_del]
FROM [local_1].[fixip_addr_alloc] t0
JOIN [local_1].[fixip_addr_netinfo] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [fixip_cts_q].[__orig_rowid] AS __orig_rowid, [local_1].[fixip_cts_q].[c_ts], [local_1].[fixip_cts_q].[u_ts], [local_1].[fixip_cts_q].[d_ts], [local_1].[fixip_cts_q].[id_pk], [local_1].[fixip_cts_q].[is_del] FROM [local_1].[fixip_cts_q]
UNION
SELECT [fixip_cts_q_high].[__orig_rowid] AS __orig_rowid, [local_1].[fixip_cts_q_high].[c_ts], [local_1].[fixip_cts_q_high].[u_ts], [local_1].[fixip_cts_q_high].[d_ts], [local_1].[fixip_cts_q_high].[id_pk], [local_1].[fixip_cts_q_high].[is_del] FROM [local_1].[fixip_cts_q_high]
UNION
SELECT [fixip_cts_q_low].[__orig_rowid] AS __orig_rowid, [local_1].[fixip_cts_q_low].[c_ts], [local_1].[fixip_cts_q_low].[u_ts], [local_1].[fixip_cts_q_low].[d_ts], [local_1].[fixip_cts_q_low].[id_pk], [local_1].[fixip_cts_q_low].[is_del] FROM [local_1].[fixip_cts_q_low]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct floating_ips from vertical split + row partition on a fragment
CREATE VIEW "floating_ips" AS
SELECT t1.[c_ts], t0.[u_ts], t1.[d_ts], t0.[id_pk], t0.[addr], t2.[fip_id_fk], t2.[proj_id], t1.[host_nm], t0.[auto_assgn_flg], t0.[pool_nm], t0.[iface_nm], t0.[is_del]
FROM [local_1].[floatip_addr] t0
JOIN (
SELECT [floatip_auto_cts].[__orig_rowid] AS __orig_rowid, [local_1].[floatip_auto_cts].[c_ts], [local_1].[floatip_auto_cts].[u_ts], [local_1].[floatip_auto_cts].[d_ts], [local_1].[floatip_auto_cts].[id_pk], [local_1].[floatip_auto_cts].[host_nm], [local_1].[floatip_auto_cts].[auto_assgn_flg], [local_1].[floatip_auto_cts].[iface_nm], [local_1].[floatip_auto_cts].[is_del] FROM [local_1].[floatip_auto_cts]
UNION
SELECT [floatip_auto_cts_high].[__orig_rowid] AS __orig_rowid, [local_1].[floatip_auto_cts_high].[c_ts], [local_1].[floatip_auto_cts_high].[u_ts], [local_1].[floatip_auto_cts_high].[d_ts], [local_1].[floatip_auto_cts_high].[id_pk], [local_1].[floatip_auto_cts_high].[host_nm], [local_1].[floatip_auto_cts_high].[auto_assgn_flg], [local_1].[floatip_auto_cts_high].[iface_nm], [local_1].[floatip_auto_cts_high].[is_del] FROM [local_1].[floatip_auto_cts_high]
UNION
SELECT [floatip_auto_cts_low].[__orig_rowid] AS __orig_rowid, [local_1].[floatip_auto_cts_low].[c_ts], [local_1].[floatip_auto_cts_low].[u_ts], [local_1].[floatip_auto_cts_low].[d_ts], [local_1].[floatip_auto_cts_low].[id_pk], [local_1].[floatip_auto_cts_low].[host_nm], [local_1].[floatip_auto_cts_low].[auto_assgn_flg], [local_1].[floatip_auto_cts_low].[iface_nm], [local_1].[floatip_auto_cts_low].[is_del] FROM [local_1].[floatip_auto_cts_low]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[floatip_fixedlink] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct instance_actions from vertical split + row partition on a fragment
CREATE VIEW "instance_actions" AS
SELECT t2.[created_on], t2.[updated_at_timestamp], t2.[deleted_at_timestamp], t0.[action_id], t0.[action_name], t0.[instance_identifier], t1.[req_id], t1.[usr_id], t1.[proj_id], t0.[started_at], t0.[finished_at], t1.[msg], t1.[is_del]
FROM [local_2].[instance_action_records] t0
JOIN (
SELECT [inst_act_create_only].[__orig_rowid] AS __orig_rowid, [local_1].[inst_act_create_only].[id_pk], [local_1].[inst_act_create_only].[act_nm], [local_1].[inst_act_create_only].[inst_uuid_fk], [local_1].[inst_act_create_only].[req_id], [local_1].[inst_act_create_only].[usr_id], [local_1].[inst_act_create_only].[proj_id], [local_1].[inst_act_create_only].[msg], [local_1].[inst_act_create_only].[is_del] FROM [local_1].[inst_act_create_only]
UNION
SELECT [inst_act_misc_actions].[__orig_rowid] AS __orig_rowid, [local_1].[inst_act_misc_actions].[id_pk], [local_1].[inst_act_misc_actions].[act_nm], [local_1].[inst_act_misc_actions].[inst_uuid_fk], [local_1].[inst_act_misc_actions].[req_id], [local_1].[inst_act_misc_actions].[usr_id], [local_1].[inst_act_misc_actions].[proj_id], [local_1].[inst_act_misc_actions].[msg], [local_1].[inst_act_misc_actions].[is_del] FROM [local_1].[inst_act_misc_actions]
UNION
SELECT [instance_action_delete_records].[__orig_rowid] AS __orig_rowid, [local_2].[instance_action_delete_records].[action_id], [local_2].[instance_action_delete_records].[action_name], [local_2].[instance_action_delete_records].[instance_identifier], [local_2].[instance_action_delete_records].[request_identifier], [local_2].[instance_action_delete_records].[user_identifier], [local_2].[instance_action_delete_records].[project_identifier], [local_2].[instance_action_delete_records].[note_message], [local_2].[instance_action_delete_records].[deleted_flag] FROM [local_2].[instance_action_delete_records]
UNION
SELECT [instance_action_live_migration_records].[__orig_rowid] AS __orig_rowid, [local_2].[instance_action_live_migration_records].[action_id], [local_2].[instance_action_live_migration_records].[action_name], [local_2].[instance_action_live_migration_records].[instance_identifier], [local_2].[instance_action_live_migration_records].[request_identifier], [local_2].[instance_action_live_migration_records].[user_identifier], [local_2].[instance_action_live_migration_records].[project_identifier], [local_2].[instance_action_live_migration_records].[note_message], [local_2].[instance_action_live_migration_records].[deleted_flag] FROM [local_2].[instance_action_live_migration_records]
UNION
SELECT [instance_action_reboot_records].[__orig_rowid] AS __orig_rowid, [local_2].[instance_action_reboot_records].[action_id], [local_2].[instance_action_reboot_records].[action_name], [local_2].[instance_action_reboot_records].[instance_identifier], [local_2].[instance_action_reboot_records].[request_identifier], [local_2].[instance_action_reboot_records].[user_identifier], [local_2].[instance_action_reboot_records].[project_identifier], [local_2].[instance_action_reboot_records].[note_message], [local_2].[instance_action_reboot_records].[deleted_flag] FROM [local_2].[instance_action_reboot_records]
UNION
SELECT [instance_action_stop_records].[__orig_rowid] AS __orig_rowid, [local_2].[instance_action_stop_records].[action_id], [local_2].[instance_action_stop_records].[action_name], [local_2].[instance_action_stop_records].[instance_identifier], [local_2].[instance_action_stop_records].[request_identifier], [local_2].[instance_action_stop_records].[user_identifier], [local_2].[instance_action_stop_records].[project_identifier], [local_2].[instance_action_stop_records].[note_message], [local_2].[instance_action_stop_records].[deleted_flag] FROM [local_2].[instance_action_stop_records]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_2].[instance_action_audit] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct instance_actions_events from vertical split + row partition on a fragment
CREATE VIEW "instance_actions_events" AS
SELECT t1.[created_on], t1.[updated_at_timestamp], t1.[deleted_at_timestamp], t0.[event_id], t0.[event_name], t0.[related_action_id], t2.[started_at], t2.[finished_at], t0.[result_status], t0.[traceback_text], t0.[deleted_flag], t0.[host_name], t0.[detail_text]
FROM (
SELECT [instance_events_build_and_run].[__orig_rowid] AS __orig_rowid, [local_2].[instance_events_build_and_run].[event_id], [local_2].[instance_events_build_and_run].[event_name], [local_2].[instance_events_build_and_run].[related_action_id], [local_2].[instance_events_build_and_run].[result_status], [local_2].[instance_events_build_and_run].[traceback_text], [local_2].[instance_events_build_and_run].[deleted_flag], [local_2].[instance_events_build_and_run].[host_name], [local_2].[instance_events_build_and_run].[detail_text] FROM [local_2].[instance_events_build_and_run]
UNION
SELECT [instance_events_migration_source_and_live].[__orig_rowid] AS __orig_rowid, [local_2].[instance_events_migration_source_and_live].[event_id], [local_2].[instance_events_migration_source_and_live].[event_name], [local_2].[instance_events_migration_source_and_live].[related_action_id], [local_2].[instance_events_migration_source_and_live].[result_status], [local_2].[instance_events_migration_source_and_live].[traceback_text], [local_2].[instance_events_migration_source_and_live].[deleted_flag], [local_2].[instance_events_migration_source_and_live].[host_name], [local_2].[instance_events_migration_source_and_live].[detail_text] FROM [local_2].[instance_events_migration_source_and_live]
UNION
SELECT [instance_events_other].[__orig_rowid] AS __orig_rowid, [local_2].[instance_events_other].[event_id], [local_2].[instance_events_other].[event_name], [local_2].[instance_events_other].[related_action_id], [local_2].[instance_events_other].[result_status], [local_2].[instance_events_other].[traceback_text], [local_2].[instance_events_other].[deleted_flag], [local_2].[instance_events_other].[host_name], [local_2].[instance_events_other].[detail_text] FROM [local_2].[instance_events_other]
UNION
SELECT [instance_events_reboot_and_migration].[__orig_rowid] AS __orig_rowid, [local_2].[instance_events_reboot_and_migration].[event_id], [local_2].[instance_events_reboot_and_migration].[event_name], [local_2].[instance_events_reboot_and_migration].[related_action_id], [local_2].[instance_events_reboot_and_migration].[result_status], [local_2].[instance_events_reboot_and_migration].[traceback_text], [local_2].[instance_events_reboot_and_migration].[deleted_flag], [local_2].[instance_events_reboot_and_migration].[host_name], [local_2].[instance_events_reboot_and_migration].[detail_text] FROM [local_2].[instance_events_reboot_and_migration]
UNION
SELECT [instance_events_stop_and_migration_dest_check].[__orig_rowid] AS __orig_rowid, [local_2].[instance_events_stop_and_migration_dest_check].[event_id], [local_2].[instance_events_stop_and_migration_dest_check].[event_name], [local_2].[instance_events_stop_and_migration_dest_check].[related_action_id], [local_2].[instance_events_stop_and_migration_dest_check].[result_status], [local_2].[instance_events_stop_and_migration_dest_check].[traceback_text], [local_2].[instance_events_stop_and_migration_dest_check].[deleted_flag], [local_2].[instance_events_stop_and_migration_dest_check].[host_name], [local_2].[instance_events_stop_and_migration_dest_check].[detail_text] FROM [local_2].[instance_events_stop_and_migration_dest_check]
UNION
SELECT [instance_events_terminate].[__orig_rowid] AS __orig_rowid, [local_2].[instance_events_terminate].[event_id], [local_2].[instance_events_terminate].[event_name], [local_2].[instance_events_terminate].[related_action_id], [local_2].[instance_events_terminate].[result_status], [local_2].[instance_events_terminate].[traceback_text], [local_2].[instance_events_terminate].[deleted_flag], [local_2].[instance_events_terminate].[host_name], [local_2].[instance_events_terminate].[detail_text] FROM [local_2].[instance_events_terminate]
) t0
JOIN [local_2].[instance_event_audit] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_2].[instance_event_details] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct instance_extra from vertical (column) split (3 fragments)
CREATE VIEW "instance_extra" AS
SELECT
    t0."c_ts" AS "created_at",
    t0."u_ts" AS "updated_at",
    t0."d_ts" AS "deleted_at",
    t1."is_del" AS "deleted",
    t0."id_pk" AS "id",
    t1."inst_uuid_fk" AS "instance_uuid",
    t1."numa_topo" AS "numa_topology",
    t1."pci_reqs" AS "pci_requests",
    t1."flavor_blob" AS "flavor",
    t2."vcpu_model" AS "vcpu_model",
    t1."mig_ctx" AS "migration_context"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."inst_extra_cts") t0
JOIN "local_1"."inst_extra_deleted" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn
JOIN "local_1"."inst_extra_flavor" t2 ON t0."id_pk" IS t2."id_pk" AND t0.__rn = t2.__rn;

-- Reconstruct instance_faults from vertical split + row partition on a fragment
CREATE VIEW "instance_faults" AS
SELECT t1.[c_ts], t1.[u_ts], t1.[d_ts], t0.[id_pk], t0.[inst_uuid_fk], t0.[err_code], t0.[msg], t0.[details_hash], t0.[host_nm], t0.[is_del]
FROM [local_1].[inst_faults_code] t0
JOIN (
SELECT [inst_faults_dts_q].[__orig_rowid] AS __orig_rowid, [local_1].[inst_faults_dts_q].[c_ts], [local_1].[inst_faults_dts_q].[u_ts], [local_1].[inst_faults_dts_q].[d_ts], [local_1].[inst_faults_dts_q].[id_pk], [local_1].[inst_faults_dts_q].[msg], [local_1].[inst_faults_dts_q].[details_hash], [local_1].[inst_faults_dts_q].[host_nm], [local_1].[inst_faults_dts_q].[is_del] FROM [local_1].[inst_faults_dts_q]
UNION
SELECT [inst_faults_dts_q_high].[__orig_rowid] AS __orig_rowid, [local_1].[inst_faults_dts_q_high].[c_ts], [local_1].[inst_faults_dts_q_high].[u_ts], [local_1].[inst_faults_dts_q_high].[d_ts], [local_1].[inst_faults_dts_q_high].[id_pk], [local_1].[inst_faults_dts_q_high].[msg], [local_1].[inst_faults_dts_q_high].[details_hash], [local_1].[inst_faults_dts_q_high].[host_nm], [local_1].[inst_faults_dts_q_high].[is_del] FROM [local_1].[inst_faults_dts_q_high]
UNION
SELECT [inst_faults_dts_q_low].[__orig_rowid] AS __orig_rowid, [local_1].[inst_faults_dts_q_low].[c_ts], [local_1].[inst_faults_dts_q_low].[u_ts], [local_1].[inst_faults_dts_q_low].[d_ts], [local_1].[inst_faults_dts_q_low].[id_pk], [local_1].[inst_faults_dts_q_low].[msg], [local_1].[inst_faults_dts_q_low].[details_hash], [local_1].[inst_faults_dts_q_low].[host_nm], [local_1].[inst_faults_dts_q_low].[is_del] FROM [local_1].[inst_faults_dts_q_low]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct instance_group_member from local_5.instance_group_membership
CREATE VIEW "instance_group_member" AS
SELECT
    "local_5"."instance_group_membership"."membership_created_timestamp" AS "created_at",
    "local_5"."instance_group_membership"."membership_modified_timestamp" AS "updated_at",
    "local_5"."instance_group_membership"."membership_deleted_timestamp" AS "deleted_at",
    "local_5"."instance_group_membership"."membership_is_deleted" AS "deleted",
    "local_5"."instance_group_membership"."membership_id" AS "id",
    "local_5"."instance_group_membership"."instance_uuid" AS "instance_id",
    "local_5"."instance_group_membership"."instance_group_id" AS "group_id"
FROM "local_5"."instance_group_membership";

-- Reconstruct instance_group_policy from local_1.inst_grp_policy
CREATE VIEW "instance_group_policy" AS
SELECT
    "local_1"."inst_grp_policy"."c_ts" AS "created_at",
    "local_1"."inst_grp_policy"."u_ts" AS "updated_at",
    "local_1"."inst_grp_policy"."d_ts" AS "deleted_at",
    "local_1"."inst_grp_policy"."is_del" AS "deleted",
    "local_1"."inst_grp_policy"."id_pk" AS "id",
    "local_1"."inst_grp_policy"."policy_k" AS "policy",
    "local_1"."inst_grp_policy"."grp_id_fk" AS "group_id"
FROM "local_1"."inst_grp_policy";

-- Reconstruct instance_groups from vertical split + row partition on a fragment
CREATE VIEW "instance_groups" AS
SELECT t0.[group_created_timestamp], t0.[group_modified_timestamp], t0.[group_deleted_timestamp], t0.[group_is_deleted], t0.[instance_group_id], t1.[usr_id], t1.[proj_id], t0.[group_uuid], t0.[group_label]
FROM [local_5].[instance_group_record_created] t0
JOIN (
SELECT [inst_grps_deleted_alpha4].[__orig_rowid] AS __orig_rowid, [local_1].[inst_grps_deleted_alpha4].[u_ts], [local_1].[inst_grps_deleted_alpha4].[is_del], [local_1].[inst_grps_deleted_alpha4].[id_pk], [local_1].[inst_grps_deleted_alpha4].[usr_id], [local_1].[inst_grps_deleted_alpha4].[proj_id], [local_1].[inst_grps_deleted_alpha4].[uuid_val], [local_1].[inst_grps_deleted_alpha4].[nm] FROM [local_1].[inst_grps_deleted_alpha4]
UNION
SELECT [inst_grps_deleted_other].[__orig_rowid] AS __orig_rowid, [local_1].[inst_grps_deleted_other].[u_ts], [local_1].[inst_grps_deleted_other].[is_del], [local_1].[inst_grps_deleted_other].[id_pk], [local_1].[inst_grps_deleted_other].[usr_id], [local_1].[inst_grps_deleted_other].[proj_id], [local_1].[inst_grps_deleted_other].[uuid_val], [local_1].[inst_grps_deleted_other].[nm] FROM [local_1].[inst_grps_deleted_other]
UNION
SELECT [instance_group_deleted_array_lyric].[__orig_rowid] AS __orig_rowid, [local_5].[instance_group_deleted_array_lyric].[group_modified_timestamp], [local_5].[instance_group_deleted_array_lyric].[group_is_deleted], [local_5].[instance_group_deleted_array_lyric].[instance_group_id], [local_5].[instance_group_deleted_array_lyric].[owner_user_uuid], [local_5].[instance_group_deleted_array_lyric].[project_uuid], [local_5].[instance_group_deleted_array_lyric].[group_uuid], [local_5].[instance_group_deleted_array_lyric].[group_label] FROM [local_5].[instance_group_deleted_array_lyric]
UNION
SELECT [instance_group_deleted_comet6_twist_star_glyph4].[__orig_rowid] AS __orig_rowid, [local_5].[instance_group_deleted_comet6_twist_star_glyph4].[group_modified_timestamp], [local_5].[instance_group_deleted_comet6_twist_star_glyph4].[group_is_deleted], [local_5].[instance_group_deleted_comet6_twist_star_glyph4].[instance_group_id], [local_5].[instance_group_deleted_comet6_twist_star_glyph4].[owner_user_uuid], [local_5].[instance_group_deleted_comet6_twist_star_glyph4].[project_uuid], [local_5].[instance_group_deleted_comet6_twist_star_glyph4].[group_uuid], [local_5].[instance_group_deleted_comet6_twist_star_glyph4].[group_label] FROM [local_5].[instance_group_deleted_comet6_twist_star_glyph4]
UNION
SELECT [instance_group_deleted_helio_glint4].[__orig_rowid] AS __orig_rowid, [local_5].[instance_group_deleted_helio_glint4].[group_modified_timestamp], [local_5].[instance_group_deleted_helio_glint4].[group_is_deleted], [local_5].[instance_group_deleted_helio_glint4].[instance_group_id], [local_5].[instance_group_deleted_helio_glint4].[owner_user_uuid], [local_5].[instance_group_deleted_helio_glint4].[project_uuid], [local_5].[instance_group_deleted_helio_glint4].[group_uuid], [local_5].[instance_group_deleted_helio_glint4].[group_label] FROM [local_5].[instance_group_deleted_helio_glint4]
UNION
SELECT [instance_group_deleted_scope_speed].[__orig_rowid] AS __orig_rowid, [local_5].[instance_group_deleted_scope_speed].[group_modified_timestamp], [local_5].[instance_group_deleted_scope_speed].[group_is_deleted], [local_5].[instance_group_deleted_scope_speed].[instance_group_id], [local_5].[instance_group_deleted_scope_speed].[owner_user_uuid], [local_5].[instance_group_deleted_scope_speed].[project_uuid], [local_5].[instance_group_deleted_scope_speed].[group_uuid], [local_5].[instance_group_deleted_scope_speed].[group_label] FROM [local_5].[instance_group_deleted_scope_speed]
UNION
SELECT [instance_group_deleted_vortx_beam_glint_ether_glyph_flux].[__orig_rowid] AS __orig_rowid, [local_5].[instance_group_deleted_vortx_beam_glint_ether_glyph_flux].[group_modified_timestamp], [local_5].[instance_group_deleted_vortx_beam_glint_ether_glyph_flux].[group_is_deleted], [local_5].[instance_group_deleted_vortx_beam_glint_ether_glyph_flux].[instance_group_id], [local_5].[instance_group_deleted_vortx_beam_glint_ether_glyph_flux].[owner_user_uuid], [local_5].[instance_group_deleted_vortx_beam_glint_ether_glyph_flux].[project_uuid], [local_5].[instance_group_deleted_vortx_beam_glint_ether_glyph_flux].[group_uuid], [local_5].[instance_group_deleted_vortx_beam_glint_ether_glyph_flux].[group_label] FROM [local_5].[instance_group_deleted_vortx_beam_glint_ether_glyph_flux]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct instance_id_mappings from local_1.inst_id_map
CREATE VIEW "instance_id_mappings" AS
SELECT
    "local_1"."inst_id_map"."c_ts" AS "created_at",
    "local_1"."inst_id_map"."u_ts" AS "updated_at",
    "local_1"."inst_id_map"."d_ts" AS "deleted_at",
    "local_1"."inst_id_map"."id_pk" AS "id",
    "local_1"."inst_id_map"."uuid_val" AS "uuid",
    "local_1"."inst_id_map"."is_del" AS "deleted"
FROM "local_1"."inst_id_map";

-- Reconstruct instance_info_caches from local_1.inst_info_cache
CREATE VIEW "instance_info_caches" AS
SELECT
    "local_1"."inst_info_cache"."c_ts" AS "created_at",
    "local_1"."inst_info_cache"."u_ts" AS "updated_at",
    "local_1"."inst_info_cache"."d_ts" AS "deleted_at",
    "local_1"."inst_info_cache"."id_pk" AS "id",
    "local_1"."inst_info_cache"."net_info" AS "network_info",
    "local_1"."inst_info_cache"."inst_uuid" AS "instance_uuid",
    "local_1"."inst_info_cache"."is_del" AS "deleted"
FROM "local_1"."inst_info_cache";

-- Reconstruct instance_metadata from vertical (column) split (2 fragments)
CREATE VIEW "instance_metadata" AS
SELECT
    t0."c_ts" AS "created_at",
    t0."u_ts" AS "updated_at",
    t0."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t1."meta_k" AS "key",
    t0."meta_v" AS "value",
    t0."inst_uuid_fk" AS "instance_uuid",
    t0."is_del" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."inst_meta_cts") t0
JOIN "local_1"."inst_meta_deleted" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct instance_system_metadata from vertical split + row partition on a fragment
CREATE VIEW "instance_system_metadata" AS
SELECT t0.[c_ts], t0.[u_ts], t0.[d_ts], t0.[id_pk], t1.[inst_uuid_fk], t1.[meta_k], t0.[meta_v], t0.[is_del]
FROM (
SELECT [inst_sysmeta_cts_q].[__orig_rowid] AS __orig_rowid, [local_1].[inst_sysmeta_cts_q].[c_ts], [local_1].[inst_sysmeta_cts_q].[u_ts], [local_1].[inst_sysmeta_cts_q].[d_ts], [local_1].[inst_sysmeta_cts_q].[id_pk], [local_1].[inst_sysmeta_cts_q].[meta_v], [local_1].[inst_sysmeta_cts_q].[is_del] FROM [local_1].[inst_sysmeta_cts_q]
UNION
SELECT [inst_sysmeta_cts_q_high].[__orig_rowid] AS __orig_rowid, [local_1].[inst_sysmeta_cts_q_high].[c_ts], [local_1].[inst_sysmeta_cts_q_high].[u_ts], [local_1].[inst_sysmeta_cts_q_high].[d_ts], [local_1].[inst_sysmeta_cts_q_high].[id_pk], [local_1].[inst_sysmeta_cts_q_high].[meta_v], [local_1].[inst_sysmeta_cts_q_high].[is_del] FROM [local_1].[inst_sysmeta_cts_q_high]
UNION
SELECT [inst_sysmeta_cts_q_low].[__orig_rowid] AS __orig_rowid, [local_1].[inst_sysmeta_cts_q_low].[c_ts], [local_1].[inst_sysmeta_cts_q_low].[u_ts], [local_1].[inst_sysmeta_cts_q_low].[d_ts], [local_1].[inst_sysmeta_cts_q_low].[id_pk], [local_1].[inst_sysmeta_cts_q_low].[meta_v], [local_1].[inst_sysmeta_cts_q_low].[is_del] FROM [local_1].[inst_sysmeta_cts_q_low]
) t0
JOIN [local_1].[inst_sysmeta_deleted] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct instance_type_extra_specs from vertical split + row partition on a fragment
CREATE VIEW "instance_type_extra_specs" AS
SELECT t0.[c_ts], t0.[u_ts], t0.[d_ts], t0.[id_pk], t0.[itype_id], t1.[spec_k], t0.[spec_v], t0.[is_del]
FROM (
SELECT [itype_exspecs_mixed_vals].[__orig_rowid] AS __orig_rowid, [local_1].[itype_exspecs_mixed_vals].[c_ts], [local_1].[itype_exspecs_mixed_vals].[u_ts], [local_1].[itype_exspecs_mixed_vals].[d_ts], [local_1].[itype_exspecs_mixed_vals].[id_pk], [local_1].[itype_exspecs_mixed_vals].[itype_id], [local_1].[itype_exspecs_mixed_vals].[spec_v], [local_1].[itype_exspecs_mixed_vals].[is_del] FROM [local_1].[itype_exspecs_mixed_vals]
UNION
SELECT [itype_exspecs_other_vals].[__orig_rowid] AS __orig_rowid, [local_1].[itype_exspecs_other_vals].[c_ts], [local_1].[itype_exspecs_other_vals].[u_ts], [local_1].[itype_exspecs_other_vals].[d_ts], [local_1].[itype_exspecs_other_vals].[id_pk], [local_1].[itype_exspecs_other_vals].[itype_id_fk], [local_1].[itype_exspecs_other_vals].[spec_v], [local_1].[itype_exspecs_other_vals].[is_del] FROM [local_1].[itype_exspecs_other_vals]
UNION
SELECT [itype_exspecs_val_5].[__orig_rowid] AS __orig_rowid, [local_1].[itype_exspecs_val_5].[c_ts], [local_1].[itype_exspecs_val_5].[u_ts], [local_1].[itype_exspecs_val_5].[d_ts], [local_1].[itype_exspecs_val_5].[id_pk], [local_1].[itype_exspecs_val_5].[itype_id_fk], [local_1].[itype_exspecs_val_5].[spec_v], [local_1].[itype_exspecs_val_5].[is_del] FROM [local_1].[itype_exspecs_val_5]
UNION
SELECT [itype_exspecs_val_default].[__orig_rowid] AS __orig_rowid, [local_1].[itype_exspecs_val_default].[c_ts], [local_1].[itype_exspecs_val_default].[u_ts], [local_1].[itype_exspecs_val_default].[d_ts], [local_1].[itype_exspecs_val_default].[id_pk], [local_1].[itype_exspecs_val_default].[itype_id], [local_1].[itype_exspecs_val_default].[spec_v], [local_1].[itype_exspecs_val_default].[is_del] FROM [local_1].[itype_exspecs_val_default]
UNION
SELECT [itype_exspecs_val_true].[__orig_rowid] AS __orig_rowid, [local_1].[itype_exspecs_val_true].[c_ts], [local_1].[itype_exspecs_val_true].[u_ts], [local_1].[itype_exspecs_val_true].[d_ts], [local_1].[itype_exspecs_val_true].[id_pk], [local_1].[itype_exspecs_val_true].[itype_id], [local_1].[itype_exspecs_val_true].[spec_v], [local_1].[itype_exspecs_val_true].[is_del] FROM [local_1].[itype_exspecs_val_true]
) t0
JOIN [local_1].[itype_exspecs_deleted] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct instance_type_projects from row partitions (UNION (overlap))
CREATE VIEW "instance_type_projects" AS
SELECT "local_1"."itype_proj_deleted_range"."c_ts" AS "created_at", "local_1"."itype_proj_deleted_range"."u_ts" AS "updated_at", "local_1"."itype_proj_deleted_range"."d_ts" AS "deleted_at", "local_1"."itype_proj_deleted_range"."id_pk" AS "id", "local_1"."itype_proj_deleted_range"."itype_id" AS "instance_type_id", "local_1"."itype_proj_deleted_range"."proj_id" AS "project_id", "local_1"."itype_proj_deleted_range"."deleted_cnt" AS "deleted" FROM "local_1"."itype_proj_deleted_range"
UNION
SELECT "local_6"."instanceTypeProjectLinksDeletedZeroOrLess"."createdAt" AS "created_at", "local_6"."instanceTypeProjectLinksDeletedZeroOrLess"."updatedAt" AS "updated_at", "local_6"."instanceTypeProjectLinksDeletedZeroOrLess"."deletedAt" AS "deleted_at", "local_6"."instanceTypeProjectLinksDeletedZeroOrLess"."recordId" AS "id", "local_6"."instanceTypeProjectLinksDeletedZeroOrLess"."instanceTypeRefId" AS "instance_type_id", "local_6"."instanceTypeProjectLinksDeletedZeroOrLess"."projectId" AS "project_id", "local_6"."instanceTypeProjectLinksDeletedZeroOrLess"."isDeleted" AS "deleted" FROM "local_6"."instanceTypeProjectLinksDeletedZeroOrLess"
UNION
SELECT "local_6"."instanceTypeProjectLinksDeletedAbove206OrNull"."createdAt" AS "created_at", "local_6"."instanceTypeProjectLinksDeletedAbove206OrNull"."updatedAt" AS "updated_at", "local_6"."instanceTypeProjectLinksDeletedAbove206OrNull"."deletedAt" AS "deleted_at", "local_6"."instanceTypeProjectLinksDeletedAbove206OrNull"."recordId" AS "id", "local_6"."instanceTypeProjectLinksDeletedAbove206OrNull"."instanceTypeRefId" AS "instance_type_id", "local_6"."instanceTypeProjectLinksDeletedAbove206OrNull"."projectId" AS "project_id", "local_6"."instanceTypeProjectLinksDeletedAbove206OrNull"."isDeleted" AS "deleted" FROM "local_6"."instanceTypeProjectLinksDeletedAbove206OrNull";

-- Reconstruct instance_types from vertical split + row partition on a fragment
CREATE VIEW "instance_types" AS
SELECT t0.[createdAt], t0.[updatedAt], t0.[deletedAt], t1.[nm], t0.[recordId], t1.[mem_mb], t1.[vcpus], t2.[swap_mb], t1.[vcpu_wt], t1.[flavorid], t1.[rxtx_fac], t2.[root_gb], t2.[ephemeral_gb], t1.[is_disabled], t1.[is_public_flg], t1.[is_del]
FROM [local_6].[instanceTypesByCreationTimestamp] t0
JOIN (
SELECT [itypes_deleted_membig].[__orig_rowid] AS __orig_rowid, [local_1].[itypes_deleted_membig].[nm], [local_1].[itypes_deleted_membig].[id_pk], [local_1].[itypes_deleted_membig].[mem_mb], [local_1].[itypes_deleted_membig].[vcpus], [local_1].[itypes_deleted_membig].[vcpu_wt], [local_1].[itypes_deleted_membig].[flavorid], [local_1].[itypes_deleted_membig].[rxtx_fac], [local_1].[itypes_deleted_membig].[is_disabled], [local_1].[itypes_deleted_membig].[is_public_flg], [local_1].[itypes_deleted_membig].[is_del] FROM [local_1].[itypes_deleted_membig]
UNION
SELECT [instanceTypesMemoryAbove2048To8192].[__orig_rowid] AS __orig_rowid, [local_6].[instanceTypesMemoryAbove2048To8192].[typeName], [local_6].[instanceTypesMemoryAbove2048To8192].[recordId], [local_6].[instanceTypesMemoryAbove2048To8192].[memoryMb], [local_6].[instanceTypesMemoryAbove2048To8192].[vcpusCount], [local_6].[instanceTypesMemoryAbove2048To8192].[vcpuWeight], [local_6].[instanceTypesMemoryAbove2048To8192].[flavorIdentifier], [local_6].[instanceTypesMemoryAbove2048To8192].[rxtxFactor], [local_6].[instanceTypesMemoryAbove2048To8192].[isDisabled], [local_6].[instanceTypesMemoryAbove2048To8192].[isPublic], [local_6].[instanceTypesMemoryAbove2048To8192].[isDeleted] FROM [local_6].[instanceTypesMemoryAbove2048To8192]
UNION
SELECT [instanceTypesMemoryAbove8192To24576].[__orig_rowid] AS __orig_rowid, [local_6].[instanceTypesMemoryAbove8192To24576].[typeName], [local_6].[instanceTypesMemoryAbove8192To24576].[recordId], [local_6].[instanceTypesMemoryAbove8192To24576].[memoryMb], [local_6].[instanceTypesMemoryAbove8192To24576].[vcpusCount], [local_6].[instanceTypesMemoryAbove8192To24576].[vcpuWeight], [local_6].[instanceTypesMemoryAbove8192To24576].[flavorIdentifier], [local_6].[instanceTypesMemoryAbove8192To24576].[rxtxFactor], [local_6].[instanceTypesMemoryAbove8192To24576].[isDisabled], [local_6].[instanceTypesMemoryAbove8192To24576].[isPublic], [local_6].[instanceTypesMemoryAbove8192To24576].[isDeleted] FROM [local_6].[instanceTypesMemoryAbove8192To24576]
UNION
SELECT [instanceTypesMemoryAtMost2048].[__orig_rowid] AS __orig_rowid, [local_6].[instanceTypesMemoryAtMost2048].[typeName], [local_6].[instanceTypesMemoryAtMost2048].[recordId], [local_6].[instanceTypesMemoryAtMost2048].[memoryMb], [local_6].[instanceTypesMemoryAtMost2048].[vcpusCount], [local_6].[instanceTypesMemoryAtMost2048].[vcpuWeight], [local_6].[instanceTypesMemoryAtMost2048].[flavorIdentifier], [local_6].[instanceTypesMemoryAtMost2048].[rxtxFactor], [local_6].[instanceTypesMemoryAtMost2048].[isDisabled], [local_6].[instanceTypesMemoryAtMost2048].[isPublic], [local_6].[instanceTypesMemoryAtMost2048].[isDeleted] FROM [local_6].[instanceTypesMemoryAtMost2048]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[itypes_ephemeral] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct instances from vertical split + row partition on a fragment
CREATE VIEW "instances" AS
SELECT t4.[CreatedAt], t4.[UpdatedAt], t4.[DeletedAt], t0.[Id], t2.[internal_id], t2.[usr_id], t2.[proj_id], t2.[img_ref], t1.[kernel_id], t2.[ramdisk_id], t1.[launch_idx], t0.[KeyPairName], t1.[key_data], t1.[power_state], t1.[vm_state], t3.[MemoryMb], t1.[vcpus], t0.[HostName], t0.[HostService], t1.[user_data], t2.[resv_id], t4.[ScheduledAt], t4.[LaunchedAt], t4.[TerminatedAt], t0.[DisplayName], t0.[DisplayDescription], t0.[AvailabilityZone], t1.[is_locked], t1.[os_nm], t0.[LaunchedOn], t2.[itype_id_fk], t1.[vm_mode], t2.[uuid_val], t1.[arch_nm], t3.[RootDeviceName], t0.[Ipv4Address], t0.[Ipv6Address], t1.[cfg_drive], t0.[TaskState], t3.[DefaultEphemeralDevice], t3.[DefaultSwapDevice], t0.[ProgressPercent], t1.[auto_disk_cfg], t1.[shut_term_flg], t1.[dis_term_flg], t3.[RootGb], t3.[EphemeralGb], t0.[CellName], t0.[ComputeNode], t1.[is_del], t1.[locked_by], t1.[is_cleaned], t1.[ephem_key_uuid]
FROM [local_7].[InstanceAccessIpV4Records] t0
JOIN [local_1].[inst_access_netinfo] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[inst_rec] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN (
SELECT [InstanceDiskConfigMemory1025To4096Mb].[__orig_rowid] AS __orig_rowid, [local_7].[InstanceDiskConfigMemory1025To4096Mb].[Id], [local_7].[InstanceDiskConfigMemory1025To4096Mb].[MemoryMb], [local_7].[InstanceDiskConfigMemory1025To4096Mb].[VcpuCount], [local_7].[InstanceDiskConfigMemory1025To4096Mb].[RootDeviceName], [local_7].[InstanceDiskConfigMemory1025To4096Mb].[DefaultEphemeralDevice], [local_7].[InstanceDiskConfigMemory1025To4096Mb].[DefaultSwapDevice], [local_7].[InstanceDiskConfigMemory1025To4096Mb].[AutoDiskConfigEnabled], [local_7].[InstanceDiskConfigMemory1025To4096Mb].[RootGb], [local_7].[InstanceDiskConfigMemory1025To4096Mb].[EphemeralGb] FROM [local_7].[InstanceDiskConfigMemory1025To4096Mb]
UNION
SELECT [InstanceDiskConfigMemory4097To16384Mb].[__orig_rowid] AS __orig_rowid, [local_7].[InstanceDiskConfigMemory4097To16384Mb].[Id], [local_7].[InstanceDiskConfigMemory4097To16384Mb].[MemoryMb], [local_7].[InstanceDiskConfigMemory4097To16384Mb].[VcpuCount], [local_7].[InstanceDiskConfigMemory4097To16384Mb].[RootDeviceName], [local_7].[InstanceDiskConfigMemory4097To16384Mb].[DefaultEphemeralDevice], [local_7].[InstanceDiskConfigMemory4097To16384Mb].[DefaultSwapDevice], [local_7].[InstanceDiskConfigMemory4097To16384Mb].[AutoDiskConfigEnabled], [local_7].[InstanceDiskConfigMemory4097To16384Mb].[RootGb], [local_7].[InstanceDiskConfigMemory4097To16384Mb].[EphemeralGb] FROM [local_7].[InstanceDiskConfigMemory4097To16384Mb]
UNION
SELECT [InstanceDiskConfigMemoryGreaterThan16384MbOrNull].[__orig_rowid] AS __orig_rowid, [local_7].[InstanceDiskConfigMemoryGreaterThan16384MbOrNull].[Id], [local_7].[InstanceDiskConfigMemoryGreaterThan16384MbOrNull].[MemoryMb], [local_7].[InstanceDiskConfigMemoryGreaterThan16384MbOrNull].[VcpuCount], [local_7].[InstanceDiskConfigMemoryGreaterThan16384MbOrNull].[RootDeviceName], [local_7].[InstanceDiskConfigMemoryGreaterThan16384MbOrNull].[DefaultEphemeralDevice], [local_7].[InstanceDiskConfigMemoryGreaterThan16384MbOrNull].[DefaultSwapDevice], [local_7].[InstanceDiskConfigMemoryGreaterThan16384MbOrNull].[AutoDiskConfigEnabled], [local_7].[InstanceDiskConfigMemoryGreaterThan16384MbOrNull].[RootGb], [local_7].[InstanceDiskConfigMemoryGreaterThan16384MbOrNull].[EphemeralGb] FROM [local_7].[InstanceDiskConfigMemoryGreaterThan16384MbOrNull]
UNION
SELECT [InstanceDiskConfigMemoryUpTo1024Mb].[__orig_rowid] AS __orig_rowid, [local_7].[InstanceDiskConfigMemoryUpTo1024Mb].[Id], [local_7].[InstanceDiskConfigMemoryUpTo1024Mb].[MemoryMb], [local_7].[InstanceDiskConfigMemoryUpTo1024Mb].[VcpuCount], [local_7].[InstanceDiskConfigMemoryUpTo1024Mb].[RootDeviceName], [local_7].[InstanceDiskConfigMemoryUpTo1024Mb].[DefaultEphemeralDevice], [local_7].[InstanceDiskConfigMemoryUpTo1024Mb].[DefaultSwapDevice], [local_7].[InstanceDiskConfigMemoryUpTo1024Mb].[AutoDiskConfigEnabled], [local_7].[InstanceDiskConfigMemoryUpTo1024Mb].[RootGb], [local_7].[InstanceDiskConfigMemoryUpTo1024Mb].[EphemeralGb] FROM [local_7].[InstanceDiskConfigMemoryUpTo1024Mb]
) t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_7].[InstanceTimestamps] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct inventories from vertical (column) split (2 fragments)
CREATE VIEW "inventories" AS
SELECT
    t0."id_pk" AS "id",
    t0."rp_id_fk" AS "resource_provider_id",
    t0."resclass_id" AS "resource_class_id",
    t0."total_units" AS "total",
    t0."reserved_cnt" AS "reserved",
    t1."min_unit" AS "min_unit",
    t1."max_unit" AS "max_unit",
    t0."step_size" AS "step_size",
    t0."alloc_ratio" AS "allocation_ratio"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."inv_alloc_ratio") t0
JOIN "local_1"."inv_alloc_ratio_ext" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct key_pairs from vertical split + row partition on a fragment
CREATE VIEW "key_pairs" AS
SELECT t0.[c_ts], t0.[u_ts], t0.[d_ts], t0.[id_pk], t0.[nm], t0.[usr_id], t1.[fp], t1.[pub_key], t0.[is_del], t0.[kp_type]
FROM (
SELECT [kp_cts_q].[__orig_rowid] AS __orig_rowid, [local_1].[kp_cts_q].[c_ts], [local_1].[kp_cts_q].[u_ts], [local_1].[kp_cts_q].[d_ts], [local_1].[kp_cts_q].[id_pk], [local_1].[kp_cts_q].[nm], [local_1].[kp_cts_q].[usr_id], [local_1].[kp_cts_q].[is_del], [local_1].[kp_cts_q].[kp_type] FROM [local_1].[kp_cts_q]
UNION
SELECT [kp_cts_q_high].[__orig_rowid] AS __orig_rowid, [local_1].[kp_cts_q_high].[c_ts], [local_1].[kp_cts_q_high].[u_ts], [local_1].[kp_cts_q_high].[d_ts], [local_1].[kp_cts_q_high].[id_pk], [local_1].[kp_cts_q_high].[nm], [local_1].[kp_cts_q_high].[usr_id], [local_1].[kp_cts_q_high].[is_del], [local_1].[kp_cts_q_high].[kp_type] FROM [local_1].[kp_cts_q_high]
UNION
SELECT [kp_cts_q_low].[__orig_rowid] AS __orig_rowid, [local_1].[kp_cts_q_low].[c_ts], [local_1].[kp_cts_q_low].[u_ts], [local_1].[kp_cts_q_low].[d_ts], [local_1].[kp_cts_q_low].[id_pk], [local_1].[kp_cts_q_low].[nm], [local_1].[kp_cts_q_low].[usr_id], [local_1].[kp_cts_q_low].[is_del], [local_1].[kp_cts_q_low].[kp_type] FROM [local_1].[kp_cts_q_low]
) t0
JOIN [local_1].[kp_deleted] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct migrate_version from local_1.mig_version
CREATE VIEW "migrate_version" AS
SELECT
    "local_1"."mig_version"."repo_id_pk" AS "repository_id",
    "local_1"."mig_version"."repo_path" AS "repository_path",
    "local_1"."mig_version"."ver_num" AS "version"
FROM "local_1"."mig_version";

-- Reconstruct migrations from vertical split + row partition on a fragment
CREATE VIEW "migrations" AS
SELECT t0.[CreatedAt], t0.[UpdatedAt], t0.[DeletedAt], t0.[Id], t1.[SourceComputeService], t1.[DestinationComputeService], t0.[DestinationHost], t0.[Status], t0.[InstanceUuid], t3.[old_itype_id], t3.[new_itype_id], t0.[SourceNode], t1.[DestinationNode], t0.[IsDeleted], t0.[MigrationType], t0.[IsHidden], t2.[mem_total], t2.[mem_done], t2.[mem_rem], t0.[DiskTotal], t2.[disk_done], t2.[disk_rem]
FROM [local_7].[MigrationRecordsWithCreatedAt] t0
JOIN [local_7].[MigrationDeletionRecords] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[migr_disk_progress] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN (
SELECT [migr_inst_newtype_70to80].[__orig_rowid] AS __orig_rowid, [local_1].[migr_inst_newtype_70to80].[id_pk], [local_1].[migr_inst_newtype_70to80].[status_k], [local_1].[migr_inst_newtype_70to80].[inst_uuid], [local_1].[migr_inst_newtype_70to80].[old_itype_id], [local_1].[migr_inst_newtype_70to80].[new_itype_id], [local_1].[migr_inst_newtype_70to80].[migr_type] FROM [local_1].[migr_inst_newtype_70to80]
UNION
SELECT [migr_inst_newtype_81to135].[__orig_rowid] AS __orig_rowid, [local_1].[migr_inst_newtype_81to135].[id_pk], [local_1].[migr_inst_newtype_81to135].[status_k], [local_1].[migr_inst_newtype_81to135].[inst_uuid], [local_1].[migr_inst_newtype_81to135].[old_itype_id], [local_1].[migr_inst_newtype_81to135].[new_itype_id], [local_1].[migr_inst_newtype_81to135].[migr_type] FROM [local_1].[migr_inst_newtype_81to135]
UNION
SELECT [migr_inst_newtype_gt135].[__orig_rowid] AS __orig_rowid, [local_1].[migr_inst_newtype_gt135].[id_pk], [local_1].[migr_inst_newtype_gt135].[status_k], [local_1].[migr_inst_newtype_gt135].[inst_uuid_fk], [local_1].[migr_inst_newtype_gt135].[old_itype_id], [local_1].[migr_inst_newtype_gt135].[new_itype_id], [local_1].[migr_inst_newtype_gt135].[migr_type] FROM [local_1].[migr_inst_newtype_gt135]
UNION
SELECT [migr_inst_newtype_le69].[__orig_rowid] AS __orig_rowid, [local_1].[migr_inst_newtype_le69].[id_pk], [local_1].[migr_inst_newtype_le69].[status_k], [local_1].[migr_inst_newtype_le69].[inst_uuid_fk], [local_1].[migr_inst_newtype_le69].[old_itype_id], [local_1].[migr_inst_newtype_le69].[new_itype_id], [local_1].[migr_inst_newtype_le69].[migr_type] FROM [local_1].[migr_inst_newtype_le69]
) t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct networks from vertical (column) split (5 fragments)
CREATE VIEW "networks" AS
SELECT
    t3."c_ts" AS "created_at",
    t3."u_ts" AS "updated_at",
    t3."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t4."is_injected" AS "injected",
    t1."cidr" AS "cidr",
    t0."netmask" AS "netmask",
    t0."bridge_nm" AS "bridge",
    t0."gw" AS "gateway",
    t0."broadcast_addr" AS "broadcast",
    t0."dns_1" AS "dns1",
    t0."vlan_id" AS "vlan",
    t2."vpn_pub_addr" AS "vpn_public_address",
    t2."vpn_pub_port" AS "vpn_public_port",
    t2."vpn_priv_addr" AS "vpn_private_address",
    t1."dhcp_start" AS "dhcp_start",
    t0."proj_id" AS "project_id",
    t0."host_nm" AS "host",
    t1."cidr_v6" AS "cidr_v6",
    t1."gw_v6" AS "gateway_v6",
    t0."label_k" AS "label",
    t1."netmask_v6" AS "netmask_v6",
    t0."bridge_if" AS "bridge_interface",
    t4."multi_host_flg" AS "multi_host",
    t0."dns_2" AS "dns2",
    t0."uuid_val" AS "uuid",
    t0."priority" AS "priority",
    t0."rxtx_base" AS "rxtx_base",
    t4."is_del" AS "deleted",
    t0."mtu" AS "mtu",
    t0."dhcp_srv" AS "dhcp_server",
    t1."enable_dhcp_flg" AS "enable_dhcp",
    t4."share_addr_flg" AS "share_address"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."net_bridge") t0
JOIN "local_1"."net_bridge_if" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn
JOIN "local_1"."net_rxtx_cfg" t2 ON t0."id_pk" IS t2."id_pk" AND t0.__rn = t2.__rn
JOIN "local_1"."networks_cts" t3 ON t0."id_pk" IS t3."id_pk" AND t0.__rn = t3.__rn
JOIN "local_1"."networks_deleted_flags" t4 ON t0."id_pk" IS t4."id_pk" AND t0.__rn = t4.__rn;

-- Reconstruct pci_devices from vertical (column) split (3 fragments)
CREATE VIEW "pci_devices" AS
SELECT
    t2."c_ts" AS "created_at",
    t2."u_ts" AS "updated_at",
    t2."d_ts" AS "deleted_at",
    t2."is_del" AS "deleted",
    t0."id_pk" AS "id",
    t1."comp_node_id_fk" AS "compute_node_id",
    t0."addr" AS "address",
    t1."prod_id" AS "product_id",
    t1."vendor_id" AS "vendor_id",
    t0."dev_type" AS "dev_type",
    t0."dev_id" AS "dev_id",
    t0."lbl" AS "label",
    t0."status_k" AS "status",
    t0."extra_info" AS "extra_info",
    t0."inst_uuid" AS "instance_uuid",
    t1."req_id" AS "request_id",
    t0."numa_node" AS "numa_node",
    t0."parent_addr" AS "parent_addr"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."pci_dev_addr") t0
JOIN "local_1"."pci_dev_compnode_fk" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn
JOIN "local_1"."pci_dev_cts" t2 ON t0."id_pk" IS t2."id_pk" AND t0.__rn = t2.__rn;

-- Reconstruct project_user_quotas from vertical (column) split (2 fragments)
CREATE VIEW "project_user_quotas" AS
SELECT
    t0."quota_id" AS "id",
    t0."created_on" AS "created_at",
    t0."updated_at_timestamp" AS "updated_at",
    t0."deleted_at_timestamp" AS "deleted_at",
    t0."deleted_flag" AS "deleted",
    t1."user_identifier" AS "user_id",
    t1."project_identifier" AS "project_id",
    t0."resource_name" AS "resource",
    t0."hard_limit_value" AS "hard_limit"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "quota_id" ORDER BY rowid) AS __rn FROM "local_2"."project_user_quota_created_audit") t0
JOIN "local_2"."project_user_quota_deleted" t1 ON t0."quota_id" IS t1."quota_id" AND t0.__rn = t1.__rn;

-- Reconstruct provider_fw_rules from vertical (column) split (2 fragments)
CREATE VIEW "provider_fw_rules" AS
SELECT
    t1."c_ts" AS "created_at",
    t0."u_ts" AS "updated_at",
    t1."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t0."proto" AS "protocol",
    t0."port_from" AS "from_port",
    t0."port_to" AS "to_port",
    t0."cidr" AS "cidr",
    t0."is_del" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."prov_fw_rules") t0
JOIN "local_1"."prov_fw_rules_cts" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct quota_classes from vertical (column) split (2 fragments)
CREATE VIEW "quota_classes" AS
SELECT
    t1."c_ts" AS "created_at",
    t1."u_ts" AS "updated_at",
    t1."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t0."class_nm" AS "class_name",
    t0."res_k" AS "resource",
    t0."hard_lim" AS "hard_limit",
    t0."is_del" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."quota_cls") t0
JOIN "local_1"."quota_cls_cts" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct quota_usages from vertical split + row partition on a fragment
CREATE VIEW "quota_usages" AS
SELECT t0.[CreatedAt], t0.[UpdatedAt], t0.[DeletedAt], t0.[Id], t1.[ProjectId], t0.[ResourceType], t1.[InUseCount], t0.[ReservedCount], t0.[SecondsUntilRefresh], t0.[IsDeleted], t1.[UserId]
FROM (
SELECT [QuotaUsageCreatedAfter20150701OnOrBefore20170309].[__orig_rowid] AS __orig_rowid, [local_3].[QuotaUsageCreatedAfter20150701OnOrBefore20170309].[CreatedAt], [local_3].[QuotaUsageCreatedAfter20150701OnOrBefore20170309].[UpdatedAt], [local_3].[QuotaUsageCreatedAfter20150701OnOrBefore20170309].[DeletedAt], [local_3].[QuotaUsageCreatedAfter20150701OnOrBefore20170309].[Id], [local_3].[QuotaUsageCreatedAfter20150701OnOrBefore20170309].[ResourceType], [local_3].[QuotaUsageCreatedAfter20150701OnOrBefore20170309].[ReservedCount], [local_3].[QuotaUsageCreatedAfter20150701OnOrBefore20170309].[SecondsUntilRefresh], [local_3].[QuotaUsageCreatedAfter20150701OnOrBefore20170309].[IsDeleted] FROM [local_3].[QuotaUsageCreatedAfter20150701OnOrBefore20170309]
UNION
SELECT [QuotaUsageCreatedAfter20170309OnOrBefore20191121].[__orig_rowid] AS __orig_rowid, [local_3].[QuotaUsageCreatedAfter20170309OnOrBefore20191121].[CreatedAt], [local_3].[QuotaUsageCreatedAfter20170309OnOrBefore20191121].[UpdatedAt], [local_3].[QuotaUsageCreatedAfter20170309OnOrBefore20191121].[DeletedAt], [local_3].[QuotaUsageCreatedAfter20170309OnOrBefore20191121].[Id], [local_3].[QuotaUsageCreatedAfter20170309OnOrBefore20191121].[ResourceType], [local_3].[QuotaUsageCreatedAfter20170309OnOrBefore20191121].[ReservedCount], [local_3].[QuotaUsageCreatedAfter20170309OnOrBefore20191121].[SecondsUntilRefresh], [local_3].[QuotaUsageCreatedAfter20170309OnOrBefore20191121].[IsDeleted] FROM [local_3].[QuotaUsageCreatedAfter20170309OnOrBefore20191121]
UNION
SELECT [QuotaUsageCreatedAfter20191121OrNull].[__orig_rowid] AS __orig_rowid, [local_3].[QuotaUsageCreatedAfter20191121OrNull].[CreatedAt], [local_3].[QuotaUsageCreatedAfter20191121OrNull].[UpdatedAt], [local_3].[QuotaUsageCreatedAfter20191121OrNull].[DeletedAt], [local_3].[QuotaUsageCreatedAfter20191121OrNull].[Id], [local_3].[QuotaUsageCreatedAfter20191121OrNull].[ResourceType], [local_3].[QuotaUsageCreatedAfter20191121OrNull].[ReservedCount], [local_3].[QuotaUsageCreatedAfter20191121OrNull].[SecondsUntilRefresh], [local_3].[QuotaUsageCreatedAfter20191121OrNull].[IsDeleted] FROM [local_3].[QuotaUsageCreatedAfter20191121OrNull]
UNION
SELECT [QuotaUsageCreatedOnOrBefore20150701].[__orig_rowid] AS __orig_rowid, [local_3].[QuotaUsageCreatedOnOrBefore20150701].[CreatedAt], [local_3].[QuotaUsageCreatedOnOrBefore20150701].[UpdatedAt], [local_3].[QuotaUsageCreatedOnOrBefore20150701].[DeletedAt], [local_3].[QuotaUsageCreatedOnOrBefore20150701].[Id], [local_3].[QuotaUsageCreatedOnOrBefore20150701].[ResourceType], [local_3].[QuotaUsageCreatedOnOrBefore20150701].[ReservedCount], [local_3].[QuotaUsageCreatedOnOrBefore20150701].[SecondsUntilRefresh], [local_3].[QuotaUsageCreatedOnOrBefore20150701].[IsDeleted] FROM [local_3].[QuotaUsageCreatedOnOrBefore20150701]
) t0
JOIN [local_3].[QuotaUsageDeletedRecords] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct quotas from vertical split + row partition on a fragment
CREATE VIEW "quotas" AS
SELECT t0.[id_pk], t0.[c_ts], t0.[u_ts], t0.[d_ts], t0.[proj_id], t0.[res_k], t1.[hard_lim], t0.[is_del]
FROM [local_1].[quotas_cts] t0
JOIN (
SELECT [quotas_deleted_high].[__orig_rowid] AS __orig_rowid, [local_1].[quotas_deleted_high].[id_pk], [local_1].[quotas_deleted_high].[proj_id], [local_1].[quotas_deleted_high].[res_k], [local_1].[quotas_deleted_high].[hard_lim], [local_1].[quotas_deleted_high].[is_del] FROM [local_1].[quotas_deleted_high]
UNION
SELECT [quotas_deleted_low].[__orig_rowid] AS __orig_rowid, [local_1].[quotas_deleted_low].[id_pk], [local_1].[quotas_deleted_low].[proj_id], [local_1].[quotas_deleted_low].[res_k], [local_1].[quotas_deleted_low].[hard_lim], [local_1].[quotas_deleted_low].[is_del] FROM [local_1].[quotas_deleted_low]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct reservations from vertical split + row partition on a fragment
CREATE VIEW "reservations" AS
SELECT t0.[CreatedAt], t0.[UpdatedAt], t0.[DeletedAt], t0.[Id], t1.[Uuid], t1.[UsageId], t2.[ProjectId], t1.[ResourceType], t1.[Delta], t0.[ExpiresAt], t1.[IsDeleted], t1.[UserId]
FROM (
SELECT [ReservationCreatedAfter20200528OnOrBefore20210521].[__orig_rowid] AS __orig_rowid, [local_3].[ReservationCreatedAfter20200528OnOrBefore20210521].[CreatedAt], [local_3].[ReservationCreatedAfter20200528OnOrBefore20210521].[UpdatedAt], [local_3].[ReservationCreatedAfter20200528OnOrBefore20210521].[DeletedAt], [local_3].[ReservationCreatedAfter20200528OnOrBefore20210521].[Id], [local_3].[ReservationCreatedAfter20200528OnOrBefore20210521].[ExpiresAt] FROM [local_3].[ReservationCreatedAfter20200528OnOrBefore20210521]
UNION
SELECT [ReservationCreatedAfter20210521OnOrBefore20220805].[__orig_rowid] AS __orig_rowid, [local_3].[ReservationCreatedAfter20210521OnOrBefore20220805].[CreatedAt], [local_3].[ReservationCreatedAfter20210521OnOrBefore20220805].[UpdatedAt], [local_3].[ReservationCreatedAfter20210521OnOrBefore20220805].[DeletedAt], [local_3].[ReservationCreatedAfter20210521OnOrBefore20220805].[Id], [local_3].[ReservationCreatedAfter20210521OnOrBefore20220805].[ExpiresAt] FROM [local_3].[ReservationCreatedAfter20210521OnOrBefore20220805]
UNION
SELECT [ReservationCreatedAfter20220805OrNull].[__orig_rowid] AS __orig_rowid, [local_3].[ReservationCreatedAfter20220805OrNull].[CreatedAt], [local_3].[ReservationCreatedAfter20220805OrNull].[UpdatedAt], [local_3].[ReservationCreatedAfter20220805OrNull].[DeletedAt], [local_3].[ReservationCreatedAfter20220805OrNull].[Id], [local_3].[ReservationCreatedAfter20220805OrNull].[ExpiresAt] FROM [local_3].[ReservationCreatedAfter20220805OrNull]
UNION
SELECT [ReservationCreatedOnOrBefore20200528].[__orig_rowid] AS __orig_rowid, [local_3].[ReservationCreatedOnOrBefore20200528].[CreatedAt], [local_3].[ReservationCreatedOnOrBefore20200528].[UpdatedAt], [local_3].[ReservationCreatedOnOrBefore20200528].[DeletedAt], [local_3].[ReservationCreatedOnOrBefore20200528].[Id], [local_3].[ReservationCreatedOnOrBefore20200528].[ExpiresAt] FROM [local_3].[ReservationCreatedOnOrBefore20200528]
) t0
JOIN [local_3].[ReservationDeletedRecords] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_3].[ReservationDeletedProjectScope] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct resource_provider_aggregates from local_8.rp_agg_link
CREATE VIEW "resource_provider_aggregates" AS
SELECT
    "local_8"."rp_agg_link"."rp_id" AS "resource_provider_id",
    "local_8"."rp_agg_link"."agg_id" AS "aggregate_id"
FROM "local_8"."rp_agg_link";

-- Reconstruct resource_providers from local_1.res_providers
CREATE VIEW "resource_providers" AS
SELECT
    "local_1"."res_providers"."id_pk" AS "id",
    "local_1"."res_providers"."uuid_val" AS "uuid",
    "local_1"."res_providers"."nm" AS "name",
    "local_1"."res_providers"."generation",
    "local_1"."res_providers"."can_host_flg" AS "can_host"
FROM "local_1"."res_providers";

-- Reconstruct s3_images from local_1.s3_imgs
CREATE VIEW "s3_images" AS
SELECT
    "local_1"."s3_imgs"."c_ts" AS "created_at",
    "local_1"."s3_imgs"."u_ts" AS "updated_at",
    "local_1"."s3_imgs"."d_ts" AS "deleted_at",
    "local_1"."s3_imgs"."id_pk" AS "id",
    "local_1"."s3_imgs"."uuid_val" AS "uuid",
    "local_1"."s3_imgs"."is_del" AS "deleted"
FROM "local_1"."s3_imgs";

-- Reconstruct security_group_default_rules from vertical (column) split (2 fragments)
CREATE VIEW "security_group_default_rules" AS
SELECT
    t0."c_ts" AS "created_at",
    t1."u_ts" AS "updated_at",
    t1."d_ts" AS "deleted_at",
    t0."is_del" AS "deleted",
    t0."id_pk" AS "id",
    t0."proto" AS "protocol",
    t0."port_from" AS "from_port",
    t0."port_to" AS "to_port",
    t0."cidr" AS "cidr"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."sg_def_rules") t0
JOIN "local_1"."sg_def_rules_cts" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct security_group_instance_association from local_2.security_group_instance_links
CREATE VIEW "security_group_instance_association" AS
SELECT
    "local_2"."security_group_instance_links"."created_on" AS "created_at",
    "local_2"."security_group_instance_links"."updated_on" AS "updated_at",
    "local_2"."security_group_instance_links"."deleted_at_timestamp" AS "deleted_at",
    "local_2"."security_group_instance_links"."association_id" AS "id",
    "local_2"."security_group_instance_links"."security_group_ref" AS "security_group_id",
    "local_2"."security_group_instance_links"."instance_identifier" AS "instance_uuid",
    "local_2"."security_group_instance_links"."deleted_flag" AS "deleted"
FROM "local_2"."security_group_instance_links";

-- Reconstruct security_group_rules from vertical split + row partition on a fragment
CREATE VIEW "security_group_rules" AS
SELECT t1.[c_ts], t1.[u_ts], t1.[d_ts], t0.[id_pk], t0.[parent_grp_id], t0.[proto], t0.[port_from], t0.[port_to], t0.[cidr], t0.[grp_id_fk], t0.[is_del]
FROM [local_1].[sg_rules] t0
JOIN (
SELECT [sg_rules_cidr_10_71_29_205].[__orig_rowid] AS __orig_rowid, [local_1].[sg_rules_cidr_10_71_29_205].[c_ts], [local_1].[sg_rules_cidr_10_71_29_205].[u_ts], [local_1].[sg_rules_cidr_10_71_29_205].[d_ts], [local_1].[sg_rules_cidr_10_71_29_205].[id_pk], [local_1].[sg_rules_cidr_10_71_29_205].[parent_grp_id], [local_1].[sg_rules_cidr_10_71_29_205].[proto], [local_1].[sg_rules_cidr_10_71_29_205].[cidr], [local_1].[sg_rules_cidr_10_71_29_205].[is_del] FROM [local_1].[sg_rules_cidr_10_71_29_205]
UNION
SELECT [sg_rules_cidr_specifics].[__orig_rowid] AS __orig_rowid, [local_1].[sg_rules_cidr_specifics].[c_ts], [local_1].[sg_rules_cidr_specifics].[u_ts], [local_1].[sg_rules_cidr_specifics].[d_ts], [local_1].[sg_rules_cidr_specifics].[id_pk], [local_1].[sg_rules_cidr_specifics].[parent_grp_id_fk], [local_1].[sg_rules_cidr_specifics].[proto], [local_1].[sg_rules_cidr_specifics].[cidr], [local_1].[sg_rules_cidr_specifics].[is_del] FROM [local_1].[sg_rules_cidr_specifics]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct security_groups from vertical (column) split (2 fragments)
CREATE VIEW "security_groups" AS
SELECT
    t1."c_ts" AS "created_at",
    t1."u_ts" AS "updated_at",
    t1."d_ts" AS "deleted_at",
    t0."security_group_id" AS "id",
    t0."group_name" AS "name",
    t0."description_text" AS "description",
    t0."user_identifier" AS "user_id",
    t0."project_identifier" AS "project_id",
    t0."deleted_flag" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "security_group_id" ORDER BY rowid) AS __rn FROM "local_2"."security_group_deleted_entries") t0
JOIN "local_1"."sgs_cts" t1 ON t0."security_group_id" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct services from vertical split + row partition on a fragment
CREATE VIEW "services" AS
SELECT t1.[c_ts], t1.[u_ts], t1.[d_ts], t0.[id_pk], t0.[host_nm], t0.[bin_nm], t0.[topic_k], t0.[report_cnt], t2.[is_disabled], t0.[is_del], t2.[disabled_reason], t1.[last_seen_ts], t0.[forced_down_flg], t0.[ver_num]
FROM [local_1].[svcs_bin] t0
JOIN [local_1].[svcs_cts] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [svcs_deleted_other_topics].[__orig_rowid] AS __orig_rowid, [local_1].[svcs_deleted_other_topics].[id_pk], [local_1].[svcs_deleted_other_topics].[host_nm], [local_1].[svcs_deleted_other_topics].[topic_k], [local_1].[svcs_deleted_other_topics].[report_cnt], [local_1].[svcs_deleted_other_topics].[is_disabled], [local_1].[svcs_deleted_other_topics].[is_del], [local_1].[svcs_deleted_other_topics].[disabled_reason], [local_1].[svcs_deleted_other_topics].[forced_down_flg], [local_1].[svcs_deleted_other_topics].[ver_num] FROM [local_1].[svcs_deleted_other_topics]
UNION
SELECT [svcs_deleted_topic_compute].[__orig_rowid] AS __orig_rowid, [local_1].[svcs_deleted_topic_compute].[id_pk], [local_1].[svcs_deleted_topic_compute].[host_nm], [local_1].[svcs_deleted_topic_compute].[topic_k], [local_1].[svcs_deleted_topic_compute].[report_cnt], [local_1].[svcs_deleted_topic_compute].[is_disabled], [local_1].[svcs_deleted_topic_compute].[is_del], [local_1].[svcs_deleted_topic_compute].[disabled_reason], [local_1].[svcs_deleted_topic_compute].[forced_down_flg], [local_1].[svcs_deleted_topic_compute].[ver_num] FROM [local_1].[svcs_deleted_topic_compute]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct shadow_agent_builds from vertical (column) split (2 fragments)
CREATE VIEW "shadow_agent_builds" AS
SELECT
    t1."c_ts" AS "created_at",
    t1."u_ts" AS "updated_at",
    t1."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t0."hyp_nm" AS "hypervisor",
    t0."os_nm" AS "os",
    t0."arch_nm" AS "architecture",
    t0."ver" AS "version",
    t0."src_url" AS "url",
    t0."md5_sum" AS "md5hash",
    t0."is_del" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."shdw_agt_bld_arch") t0
JOIN "local_1"."shdw_agt_bld_arch_cts" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct shadow_aggregate_hosts from row partitions (UNION (overlap))
CREATE VIEW "shadow_aggregate_hosts" AS
SELECT "local_3"."AggregateHostAggregateIdLe2"."CreatedAt" AS "created_at", "local_3"."AggregateHostAggregateIdLe2"."UpdatedAt" AS "updated_at", "local_3"."AggregateHostAggregateIdLe2"."DeletedAt" AS "deleted_at", "local_3"."AggregateHostAggregateIdLe2"."Id" AS "id", "local_3"."AggregateHostAggregateIdLe2"."HostName" AS "host", "local_3"."AggregateHostAggregateIdLe2"."AggregateId" AS "aggregate_id", "local_3"."AggregateHostAggregateIdLe2"."IsDeleted" AS "deleted" FROM "local_3"."AggregateHostAggregateIdLe2"
UNION
SELECT "local_3"."AggregateHostAggregateIdRange3To7"."CreatedAt" AS "created_at", "local_3"."AggregateHostAggregateIdRange3To7"."UpdatedAt" AS "updated_at", "local_3"."AggregateHostAggregateIdRange3To7"."DeletedAt" AS "deleted_at", "local_3"."AggregateHostAggregateIdRange3To7"."Id" AS "id", "local_3"."AggregateHostAggregateIdRange3To7"."HostName" AS "host", "local_3"."AggregateHostAggregateIdRange3To7"."AggregateId" AS "aggregate_id", "local_3"."AggregateHostAggregateIdRange3To7"."IsDeleted" AS "deleted" FROM "local_3"."AggregateHostAggregateIdRange3To7"
UNION
SELECT "local_3"."AggregateHostAggregateIdGt7OrNull"."CreatedAt" AS "created_at", "local_3"."AggregateHostAggregateIdGt7OrNull"."UpdatedAt" AS "updated_at", "local_3"."AggregateHostAggregateIdGt7OrNull"."DeletedAt" AS "deleted_at", "local_3"."AggregateHostAggregateIdGt7OrNull"."Id" AS "id", "local_3"."AggregateHostAggregateIdGt7OrNull"."HostName" AS "host", "local_3"."AggregateHostAggregateIdGt7OrNull"."AggregateId" AS "aggregate_id", "local_3"."AggregateHostAggregateIdGt7OrNull"."IsDeleted" AS "deleted" FROM "local_3"."AggregateHostAggregateIdGt7OrNull";

-- Reconstruct shadow_aggregate_metadata from vertical (column) split (2 fragments)
CREATE VIEW "shadow_aggregate_metadata" AS
SELECT
    t1."c_ts" AS "created_at",
    t1."u_ts" AS "updated_at",
    t1."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t0."agg_id" AS "aggregate_id",
    t0."meta_k" AS "key",
    t0."meta_v" AS "value",
    t0."is_del" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."shdw_agg_meta") t0
JOIN "local_1"."shdw_agg_meta_cts" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct shadow_aggregates from local_1.shdw_aggs
CREATE VIEW "shadow_aggregates" AS
SELECT
    "local_1"."shdw_aggs"."c_ts" AS "created_at",
    "local_1"."shdw_aggs"."u_ts" AS "updated_at",
    "local_1"."shdw_aggs"."d_ts" AS "deleted_at",
    "local_1"."shdw_aggs"."id_pk" AS "id",
    "local_1"."shdw_aggs"."nm" AS "name",
    "local_1"."shdw_aggs"."is_del" AS "deleted",
    "local_1"."shdw_aggs"."uuid_val" AS "uuid"
FROM "local_1"."shdw_aggs";

-- Reconstruct shadow_block_device_mapping from vertical split + row partition on a fragment
CREATE VIEW "shadow_block_device_mapping" AS
SELECT t3.[c_ts], t3.[u_ts], t3.[d_ts], t0.[id_pk], t0.[dev_nm], t0.[del_on_term], t4.[snap_id], t2.[vol_id], t2.[vol_size], t0.[no_dev_flg], t2.[conn_info], t4.[inst_uuid], t0.[is_del], t0.[src_type], t0.[dest_type], t0.[guest_fmt], t0.[dev_type], t0.[disk_bus], t0.[boot_idx], t4.[img_id]
FROM [local_1].[shdw_bdmap_boot_full] t0
JOIN [local_1].[shdw_bdmap_boot_lite] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[shdw_bdmap_conn_simple] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[shdw_bdmap_cts] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN (
SELECT [shdw_bdmap_img_a73c9f].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_bdmap_img_a73c9f].[id_pk], [local_1].[shdw_bdmap_img_a73c9f].[snap_id], [local_1].[shdw_bdmap_img_a73c9f].[inst_uuid], [local_1].[shdw_bdmap_img_a73c9f].[src_type], [local_1].[shdw_bdmap_img_a73c9f].[img_id] FROM [local_1].[shdw_bdmap_img_a73c9f]
UNION
SELECT [shdw_bdmap_img_other].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_bdmap_img_other].[id_pk], [local_1].[shdw_bdmap_img_other].[snap_id], [local_1].[shdw_bdmap_img_other].[inst_uuid], [local_1].[shdw_bdmap_img_other].[src_type], [local_1].[shdw_bdmap_img_other].[img_id] FROM [local_1].[shdw_bdmap_img_other]
UNION
SELECT [shdw_bdmap_img_some_ids].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_bdmap_img_some_ids].[id_pk], [local_1].[shdw_bdmap_img_some_ids].[snap_id], [local_1].[shdw_bdmap_img_some_ids].[inst_uuid], [local_1].[shdw_bdmap_img_some_ids].[src_type], [local_1].[shdw_bdmap_img_some_ids].[img_id] FROM [local_1].[shdw_bdmap_img_some_ids]
) t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct shadow_bw_usage_cache from vertical (column) split (2 fragments)
CREATE VIEW "shadow_bw_usage_cache" AS
SELECT
    t0."c_ts" AS "created_at",
    t0."u_ts" AS "updated_at",
    t0."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t0."start_ts" AS "start_period",
    t0."last_ref_ts" AS "last_refreshed",
    t1."bw_in_val" AS "bw_in",
    t1."bw_out_val" AS "bw_out",
    t0."mac_addr" AS "mac",
    t0."uuid_val" AS "uuid",
    t1."last_ctr_in" AS "last_ctr_in",
    t1."last_ctr_out" AS "last_ctr_out",
    t0."is_del" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."shdw_bw_cache_cts") t0
JOIN "local_1"."shdw_bw_cache_val" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct shadow_cells from vertical (column) split (2 fragments)
CREATE VIEW "shadow_cells" AS
SELECT
    t1."c_ts" AS "created_at",
    t1."u_ts" AS "updated_at",
    t1."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t0."api_url" AS "api_url",
    t0."wt_offset" AS "weight_offset",
    t0."wt_scale" AS "weight_scale",
    t0."nm" AS "name",
    t0."is_parent_flg" AS "is_parent",
    t0."is_del" AS "deleted",
    t0."transport_url" AS "transport_url"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."shdw_cells_api_cfg") t0
JOIN "local_1"."shdw_cells_cts" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct shadow_certificates from vertical (column) split (2 fragments)
CREATE VIEW "shadow_certificates" AS
SELECT
    t0."c_ts" AS "created_at",
    t0."u_ts" AS "updated_at",
    t0."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t0."usr_id" AS "user_id",
    t1."proj_id" AS "project_id",
    t0."file_nm" AS "file_name",
    t0."is_del" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."shdw_certs_cts") t0
JOIN "local_1"."shdw_certs_deleted" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct shadow_compute_nodes from vertical (column) split (5 fragments)
CREATE VIEW "shadow_compute_nodes" AS
SELECT
    t1."c_ts" AS "created_at",
    t1."u_ts" AS "updated_at",
    t1."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t1."svc_id_fk" AS "service_id",
    t0."vcpus" AS "vcpus",
    t2."mem_mb" AS "memory_mb",
    t3."local_gb" AS "local_gb",
    t0."vcpus_used" AS "vcpus_used",
    t2."mem_mb_used" AS "memory_mb_used",
    t3."local_gb_used" AS "local_gb_used",
    t4."hyp_type" AS "hypervisor_type",
    t4."hyp_ver" AS "hypervisor_version",
    t0."cpu_info_blob" AS "cpu_info",
    t3."disk_avail_least" AS "disk_available_least",
    t2."free_ram_mb" AS "free_ram_mb",
    t3."free_disk_gb" AS "free_disk_gb",
    t1."curr_workload" AS "current_workload",
    t1."run_vms" AS "running_vms",
    t4."hyp_host_nm" AS "hypervisor_hostname",
    t1."is_del" AS "deleted",
    t1."host_ip" AS "host_ip",
    t1."supp_instances" AS "supported_instances",
    t1."pci_stats" AS "pci_stats",
    t1."metrics_blob" AS "metrics",
    t1."extra_res" AS "extra_resources",
    t1."stats_blob" AS "stats",
    t1."numa_topo" AS "numa_topology",
    t1."host_nm" AS "host",
    t0."ram_alloc_ratio" AS "ram_allocation_ratio",
    t0."cpu_alloc_ratio" AS "cpu_allocation_ratio",
    t1."uuid_val" AS "uuid",
    t0."disk_alloc_ratio" AS "disk_allocation_ratio"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."shdw_compnode_cpu_alloc") t0
JOIN "local_1"."shdw_compnode_cpu_info" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn
JOIN "local_1"."shdw_compnode_curr_load" t2 ON t0."id_pk" IS t2."id_pk" AND t0.__rn = t2.__rn
JOIN "local_1"."shdw_compnode_disk_least" t3 ON t0."id_pk" IS t3."id_pk" AND t0.__rn = t3.__rn
JOIN "local_1"."shdw_compnode_hostinfo" t4 ON t0."id_pk" IS t4."id_pk" AND t0.__rn = t4.__rn;

-- Reconstruct shadow_console_pools from vertical (column) split (2 fragments)
CREATE VIEW "shadow_console_pools" AS
SELECT
    t1."c_ts" AS "created_at",
    t1."u_ts" AS "updated_at",
    t1."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t0."addr" AS "address",
    t0."user_nm" AS "username",
    t0."pwd" AS "password",
    t0."console_type" AS "console_type",
    t0."pub_host" AS "public_hostname",
    t0."host_nm" AS "host",
    t0."compute_host" AS "compute_host",
    t0."is_del" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."shdw_console_pool_addr") t0
JOIN "local_1"."shdw_console_pool_host" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct shadow_consoles from vertical (column) split (2 fragments)
CREATE VIEW "shadow_consoles" AS
SELECT
    t0."c_ts" AS "created_at",
    t0."u_ts" AS "updated_at",
    t0."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t1."inst_nm" AS "instance_name",
    t0."pwd" AS "password",
    t0."port_num" AS "port",
    t0."pool_id_fk" AS "pool_id",
    t1."inst_uuid" AS "instance_uuid",
    t0."is_del" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."shdw_consoles_cts") t0
JOIN "local_1"."shdw_consoles_deleted" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct shadow_dns_domains from vertical (column) split (2 fragments)
CREATE VIEW "shadow_dns_domains" AS
SELECT
    t1."c_ts" AS "created_at",
    t1."u_ts" AS "updated_at",
    t1."d_ts" AS "deleted_at",
    t0."is_del" AS "deleted",
    t0."domain_nm" AS "domain",
    t0."scope_k" AS "scope",
    t0."az_nm" AS "availability_zone",
    t0."proj_id" AS "project_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "domain_nm" ORDER BY rowid) AS __rn FROM "local_1"."shdw_dns_dom_az") t0
JOIN "local_1"."shdw_dns_dom_az_cts" t1 ON t0."domain_nm" IS t1."domain_nm" AND t0.__rn = t1.__rn;

-- Reconstruct shadow_fixed_ips from vertical (column) split (3 fragments)
CREATE VIEW "shadow_fixed_ips" AS
SELECT
    t2."c_ts" AS "created_at",
    t2."u_ts" AS "updated_at",
    t2."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t0."addr" AS "address",
    t1."net_id_fk" AS "network_id",
    t0."is_alloc" AS "allocated",
    t0."is_leased" AS "leased",
    t0."is_reserved" AS "reserved",
    t1."vif_id_fk" AS "virtual_interface_id",
    t0."host_nm" AS "host",
    t0."inst_uuid" AS "instance_uuid",
    t0."is_del" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."shdw_fixip_addr_alloc") t0
JOIN "local_1"."shdw_fixip_addr_netinfo" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn
JOIN "local_1"."shdw_fixip_cts" t2 ON t0."id_pk" IS t2."id_pk" AND t0.__rn = t2.__rn;

-- Reconstruct shadow_floating_ips from vertical (column) split (2 fragments)
CREATE VIEW "shadow_floating_ips" AS
SELECT
    t0."createdTimestamp" AS "created_at",
    t0."updatedTimestamp" AS "updated_at",
    t0."deletedTimestamp" AS "deleted_at",
    t0."allocationId" AS "id",
    t0."ipAddress" AS "address",
    t1."fixedIpId" AS "fixed_ip_id",
    t0."projectId" AS "project_id",
    t1."hostName" AS "host",
    t0."autoAssignedFlag" AS "auto_assigned",
    t1."addressPool" AS "pool",
    t0."networkInterface" AS "interface",
    t0."deletedFlag" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "allocationId" ORDER BY rowid) AS __rn FROM "local_4"."floatingIpAllocationHistory") t0
JOIN "local_4"."floatingIpAllocations" t1 ON t0."allocationId" IS t1."allocationId" AND t0.__rn = t1.__rn;

-- Reconstruct shadow_instance_actions from vertical split + row partition on a fragment
CREATE VIEW "shadow_instance_actions" AS
SELECT t1.[c_ts], t1.[u_ts], t1.[d_ts], t0.[id_pk], t0.[act_nm], t0.[inst_uuid], t0.[req_id], t0.[usr_id], t0.[proj_id], t1.[start_ts], t1.[finish_ts], t0.[msg], t0.[is_del]
FROM (
SELECT [shdw_inst_act_create_only].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_inst_act_create_only].[id_pk], [local_1].[shdw_inst_act_create_only].[act_nm], [local_1].[shdw_inst_act_create_only].[inst_uuid], [local_1].[shdw_inst_act_create_only].[req_id], [local_1].[shdw_inst_act_create_only].[usr_id], [local_1].[shdw_inst_act_create_only].[proj_id], [local_1].[shdw_inst_act_create_only].[msg], [local_1].[shdw_inst_act_create_only].[is_del] FROM [local_1].[shdw_inst_act_create_only]
UNION
SELECT [shdw_inst_act_various].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_inst_act_various].[id_pk], [local_1].[shdw_inst_act_various].[act_nm], [local_1].[shdw_inst_act_various].[inst_uuid], [local_1].[shdw_inst_act_various].[req_id], [local_1].[shdw_inst_act_various].[usr_id], [local_1].[shdw_inst_act_various].[proj_id], [local_1].[shdw_inst_act_various].[msg], [local_1].[shdw_inst_act_various].[is_del] FROM [local_1].[shdw_inst_act_various]
) t0
JOIN [local_1].[shdw_inst_act_full] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct shadow_instance_actions_events from vertical split + row partition on a fragment
CREATE VIEW "shadow_instance_actions_events" AS
SELECT t2.[event_created_timestamp], t2.[event_modified_timestamp], t2.[deleted_timestamp], t0.[action_event_id], t0.[event_name], t0.[action_ref_id], t2.[started_at], t2.[finished_at], t0.[action_result], t0.[error_traceback], t1.[is_deleted], t0.[host_name], t0.[action_details]
FROM (
SELECT [instance_action_events_build_and_run_audit].[__orig_rowid] AS __orig_rowid, [local_5].[instance_action_events_build_and_run_audit].[action_event_id], [local_5].[instance_action_events_build_and_run_audit].[event_name], [local_5].[instance_action_events_build_and_run_audit].[action_ref_id], [local_5].[instance_action_events_build_and_run_audit].[action_result], [local_5].[instance_action_events_build_and_run_audit].[error_traceback], [local_5].[instance_action_events_build_and_run_audit].[host_name], [local_5].[instance_action_events_build_and_run_audit].[action_details] FROM [local_5].[instance_action_events_build_and_run_audit]
UNION
SELECT [instance_action_events_misc_audit].[__orig_rowid] AS __orig_rowid, [local_5].[instance_action_events_misc_audit].[action_event_id], [local_5].[instance_action_events_misc_audit].[event_name], [local_5].[instance_action_events_misc_audit].[action_ref_id], [local_5].[instance_action_events_misc_audit].[action_result], [local_5].[instance_action_events_misc_audit].[error_traceback], [local_5].[instance_action_events_misc_audit].[host_name], [local_5].[instance_action_events_misc_audit].[action_details] FROM [local_5].[instance_action_events_misc_audit]
UNION
SELECT [instance_action_events_schedule_audit].[__orig_rowid] AS __orig_rowid, [local_5].[instance_action_events_schedule_audit].[action_event_id], [local_5].[instance_action_events_schedule_audit].[event_name], [local_5].[instance_action_events_schedule_audit].[action_ref_id], [local_5].[instance_action_events_schedule_audit].[action_result], [local_5].[instance_action_events_schedule_audit].[error_traceback], [local_5].[instance_action_events_schedule_audit].[host_name], [local_5].[instance_action_events_schedule_audit].[action_details] FROM [local_5].[instance_action_events_schedule_audit]
UNION
SELECT [instance_action_events_terminate_audit].[__orig_rowid] AS __orig_rowid, [local_5].[instance_action_events_terminate_audit].[action_event_id], [local_5].[instance_action_events_terminate_audit].[event_name], [local_5].[instance_action_events_terminate_audit].[action_ref_id], [local_5].[instance_action_events_terminate_audit].[action_result], [local_5].[instance_action_events_terminate_audit].[error_traceback], [local_5].[instance_action_events_terminate_audit].[host_name], [local_5].[instance_action_events_terminate_audit].[action_details] FROM [local_5].[instance_action_events_terminate_audit]
) t0
JOIN [local_5].[instance_action_event_outcome_audit] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_5].[instance_action_event_timings_archive] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct shadow_instance_extra from vertical (column) split (3 fragments)
CREATE VIEW "shadow_instance_extra" AS
SELECT
    t0."c_ts" AS "created_at",
    t0."u_ts" AS "updated_at",
    t0."d_ts" AS "deleted_at",
    t1."is_del" AS "deleted",
    t0."id_pk" AS "id",
    t1."inst_uuid" AS "instance_uuid",
    t1."numa_topo" AS "numa_topology",
    t1."pci_reqs" AS "pci_requests",
    t1."flavor_blob" AS "flavor",
    t2."vcpu_model" AS "vcpu_model",
    t1."mig_ctx" AS "migration_context"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."shdw_inst_extra_cts") t0
JOIN "local_1"."shdw_inst_extra_deleted" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn
JOIN "local_1"."shdw_inst_extra_flavor" t2 ON t0."id_pk" IS t2."id_pk" AND t0.__rn = t2.__rn;

-- Reconstruct shadow_instance_faults from vertical split + row partition on a fragment
CREATE VIEW "shadow_instance_faults" AS
SELECT t1.[c_ts], t1.[u_ts], t1.[d_ts], t0.[id_pk], t0.[inst_uuid], t0.[err_code], t0.[msg], t0.[details_hash], t0.[host_nm], t0.[is_del]
FROM (
SELECT [shdw_inst_faults_details_ee9f89].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_inst_faults_details_ee9f89].[id_pk], [local_1].[shdw_inst_faults_details_ee9f89].[inst_uuid], [local_1].[shdw_inst_faults_details_ee9f89].[err_code], [local_1].[shdw_inst_faults_details_ee9f89].[msg], [local_1].[shdw_inst_faults_details_ee9f89].[details_hash], [local_1].[shdw_inst_faults_details_ee9f89].[host_nm], [local_1].[shdw_inst_faults_details_ee9f89].[is_del] FROM [local_1].[shdw_inst_faults_details_ee9f89]
UNION
SELECT [shdw_inst_faults_details_list].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_inst_faults_details_list].[id_pk], [local_1].[shdw_inst_faults_details_list].[inst_uuid], [local_1].[shdw_inst_faults_details_list].[err_code], [local_1].[shdw_inst_faults_details_list].[msg], [local_1].[shdw_inst_faults_details_list].[details_hash], [local_1].[shdw_inst_faults_details_list].[host_nm], [local_1].[shdw_inst_faults_details_list].[is_del] FROM [local_1].[shdw_inst_faults_details_list]
UNION
SELECT [shdw_inst_faults_details_other].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_inst_faults_details_other].[id_pk], [local_1].[shdw_inst_faults_details_other].[inst_uuid], [local_1].[shdw_inst_faults_details_other].[err_code], [local_1].[shdw_inst_faults_details_other].[msg], [local_1].[shdw_inst_faults_details_other].[details_hash], [local_1].[shdw_inst_faults_details_other].[host_nm], [local_1].[shdw_inst_faults_details_other].[is_del] FROM [local_1].[shdw_inst_faults_details_other]
) t0
JOIN [local_1].[shdw_inst_faults_cts] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct shadow_instance_group_member from local_4.instanceGroupMembers
CREATE VIEW "shadow_instance_group_member" AS
SELECT
    "local_4"."instanceGroupMembers"."createdTimestamp" AS "created_at",
    "local_4"."instanceGroupMembers"."updatedTimestamp" AS "updated_at",
    "local_4"."instanceGroupMembers"."deletedTimestamp" AS "deleted_at",
    "local_4"."instanceGroupMembers"."deletedFlag" AS "deleted",
    "local_4"."instanceGroupMembers"."membershipId" AS "id",
    "local_4"."instanceGroupMembers"."instanceId" AS "instance_id",
    "local_4"."instanceGroupMembers"."groupId" AS "group_id"
FROM "local_4"."instanceGroupMembers";

-- Reconstruct shadow_instance_group_policy from local_1.shdw_inst_grp_policy
CREATE VIEW "shadow_instance_group_policy" AS
SELECT
    "local_1"."shdw_inst_grp_policy"."c_ts" AS "created_at",
    "local_1"."shdw_inst_grp_policy"."u_ts" AS "updated_at",
    "local_1"."shdw_inst_grp_policy"."d_ts" AS "deleted_at",
    "local_1"."shdw_inst_grp_policy"."is_del" AS "deleted",
    "local_1"."shdw_inst_grp_policy"."id_pk" AS "id",
    "local_1"."shdw_inst_grp_policy"."policy_k" AS "policy",
    "local_1"."shdw_inst_grp_policy"."grp_id" AS "group_id"
FROM "local_1"."shdw_inst_grp_policy";

-- Reconstruct shadow_instance_groups from vertical (column) split (2 fragments)
CREATE VIEW "shadow_instance_groups" AS
SELECT
    t0."c_ts" AS "created_at",
    t0."u_ts" AS "updated_at",
    t0."d_ts" AS "deleted_at",
    t0."is_del" AS "deleted",
    t0."id_pk" AS "id",
    t1."usr_id" AS "user_id",
    t0."proj_id" AS "project_id",
    t0."uuid_val" AS "uuid",
    t0."nm" AS "name"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."shdw_inst_grps_cts") t0
JOIN "local_1"."shdw_inst_grps_deleted" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct shadow_instance_id_mappings from local_1.shdw_inst_id_map
CREATE VIEW "shadow_instance_id_mappings" AS
SELECT
    "local_1"."shdw_inst_id_map"."c_ts" AS "created_at",
    "local_1"."shdw_inst_id_map"."u_ts" AS "updated_at",
    "local_1"."shdw_inst_id_map"."d_ts" AS "deleted_at",
    "local_1"."shdw_inst_id_map"."id_pk" AS "id",
    "local_1"."shdw_inst_id_map"."uuid_val" AS "uuid",
    "local_1"."shdw_inst_id_map"."is_del" AS "deleted"
FROM "local_1"."shdw_inst_id_map";

-- Reconstruct shadow_instance_info_caches from local_1.shdw_inst_info_cache
CREATE VIEW "shadow_instance_info_caches" AS
SELECT
    "local_1"."shdw_inst_info_cache"."c_ts" AS "created_at",
    "local_1"."shdw_inst_info_cache"."u_ts" AS "updated_at",
    "local_1"."shdw_inst_info_cache"."d_ts" AS "deleted_at",
    "local_1"."shdw_inst_info_cache"."id_pk" AS "id",
    "local_1"."shdw_inst_info_cache"."net_info" AS "network_info",
    "local_1"."shdw_inst_info_cache"."inst_uuid" AS "instance_uuid",
    "local_1"."shdw_inst_info_cache"."is_del" AS "deleted"
FROM "local_1"."shdw_inst_info_cache";

-- Reconstruct shadow_instance_metadata from vertical split + row partition on a fragment
CREATE VIEW "shadow_instance_metadata" AS
SELECT t0.[c_ts], t0.[u_ts], t0.[d_ts], t0.[id_pk], t1.[meta_k], t0.[meta_v], t0.[inst_uuid], t0.[is_del]
FROM (
SELECT [shdw_inst_meta_cts_q].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_inst_meta_cts_q].[c_ts], [local_1].[shdw_inst_meta_cts_q].[u_ts], [local_1].[shdw_inst_meta_cts_q].[d_ts], [local_1].[shdw_inst_meta_cts_q].[id_pk], [local_1].[shdw_inst_meta_cts_q].[meta_v], [local_1].[shdw_inst_meta_cts_q].[inst_uuid], [local_1].[shdw_inst_meta_cts_q].[is_del] FROM [local_1].[shdw_inst_meta_cts_q]
UNION
SELECT [shdw_inst_meta_cts_q_high].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_inst_meta_cts_q_high].[c_ts], [local_1].[shdw_inst_meta_cts_q_high].[u_ts], [local_1].[shdw_inst_meta_cts_q_high].[d_ts], [local_1].[shdw_inst_meta_cts_q_high].[id_pk], [local_1].[shdw_inst_meta_cts_q_high].[meta_v], [local_1].[shdw_inst_meta_cts_q_high].[inst_uuid], [local_1].[shdw_inst_meta_cts_q_high].[is_del] FROM [local_1].[shdw_inst_meta_cts_q_high]
UNION
SELECT [shdw_inst_meta_cts_q_low].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_inst_meta_cts_q_low].[c_ts], [local_1].[shdw_inst_meta_cts_q_low].[u_ts], [local_1].[shdw_inst_meta_cts_q_low].[d_ts], [local_1].[shdw_inst_meta_cts_q_low].[id_pk], [local_1].[shdw_inst_meta_cts_q_low].[meta_v], [local_1].[shdw_inst_meta_cts_q_low].[inst_uuid], [local_1].[shdw_inst_meta_cts_q_low].[is_del] FROM [local_1].[shdw_inst_meta_cts_q_low]
) t0
JOIN [local_1].[shdw_inst_meta_deleted] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct shadow_instance_system_metadata from vertical split + row partition on a fragment
CREATE VIEW "shadow_instance_system_metadata" AS
SELECT t0.[c_ts], t0.[u_ts], t0.[d_ts], t0.[id_pk], t0.[inst_uuid], t1.[meta_k], t0.[meta_v], t0.[is_del]
FROM (
SELECT [shdw_inst_sysmeta_cts_q].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_inst_sysmeta_cts_q].[c_ts], [local_1].[shdw_inst_sysmeta_cts_q].[u_ts], [local_1].[shdw_inst_sysmeta_cts_q].[d_ts], [local_1].[shdw_inst_sysmeta_cts_q].[id_pk], [local_1].[shdw_inst_sysmeta_cts_q].[inst_uuid], [local_1].[shdw_inst_sysmeta_cts_q].[meta_v], [local_1].[shdw_inst_sysmeta_cts_q].[is_del] FROM [local_1].[shdw_inst_sysmeta_cts_q]
UNION
SELECT [shdw_inst_sysmeta_cts_q_high].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_inst_sysmeta_cts_q_high].[c_ts], [local_1].[shdw_inst_sysmeta_cts_q_high].[u_ts], [local_1].[shdw_inst_sysmeta_cts_q_high].[d_ts], [local_1].[shdw_inst_sysmeta_cts_q_high].[id_pk], [local_1].[shdw_inst_sysmeta_cts_q_high].[inst_uuid], [local_1].[shdw_inst_sysmeta_cts_q_high].[meta_v], [local_1].[shdw_inst_sysmeta_cts_q_high].[is_del] FROM [local_1].[shdw_inst_sysmeta_cts_q_high]
UNION
SELECT [shdw_inst_sysmeta_cts_q_low].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_inst_sysmeta_cts_q_low].[c_ts], [local_1].[shdw_inst_sysmeta_cts_q_low].[u_ts], [local_1].[shdw_inst_sysmeta_cts_q_low].[d_ts], [local_1].[shdw_inst_sysmeta_cts_q_low].[id_pk], [local_1].[shdw_inst_sysmeta_cts_q_low].[inst_uuid], [local_1].[shdw_inst_sysmeta_cts_q_low].[meta_v], [local_1].[shdw_inst_sysmeta_cts_q_low].[is_del] FROM [local_1].[shdw_inst_sysmeta_cts_q_low]
) t0
JOIN [local_1].[shdw_inst_sysmeta_deleted] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct shadow_instance_type_extra_specs from vertical split + row partition on a fragment
CREATE VIEW "shadow_instance_type_extra_specs" AS
SELECT t0.[c_ts], t0.[u_ts], t0.[d_ts], t0.[id_pk], t1.[itype_id], t1.[spec_k], t0.[spec_v], t0.[is_del]
FROM [local_1].[shdw_itype_exspecs_cts] t0
JOIN (
SELECT [shdw_itype_exspecs_key_overcommit].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_itype_exspecs_key_overcommit].[c_ts], [local_1].[shdw_itype_exspecs_key_overcommit].[id_pk], [local_1].[shdw_itype_exspecs_key_overcommit].[itype_id], [local_1].[shdw_itype_exspecs_key_overcommit].[spec_k], [local_1].[shdw_itype_exspecs_key_overcommit].[spec_v], [local_1].[shdw_itype_exspecs_key_overcommit].[is_del] FROM [local_1].[shdw_itype_exspecs_key_overcommit]
UNION
SELECT [shdw_itype_exspecs_key_tig].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_itype_exspecs_key_tig].[c_ts], [local_1].[shdw_itype_exspecs_key_tig].[id_pk], [local_1].[shdw_itype_exspecs_key_tig].[itype_id], [local_1].[shdw_itype_exspecs_key_tig].[spec_k], [local_1].[shdw_itype_exspecs_key_tig].[spec_v], [local_1].[shdw_itype_exspecs_key_tig].[is_del] FROM [local_1].[shdw_itype_exspecs_key_tig]
UNION
SELECT [shdw_itype_exspecs_key_ups_test].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_itype_exspecs_key_ups_test].[c_ts], [local_1].[shdw_itype_exspecs_key_ups_test].[id_pk], [local_1].[shdw_itype_exspecs_key_ups_test].[itype_id], [local_1].[shdw_itype_exspecs_key_ups_test].[spec_k], [local_1].[shdw_itype_exspecs_key_ups_test].[spec_v], [local_1].[shdw_itype_exspecs_key_ups_test].[is_del] FROM [local_1].[shdw_itype_exspecs_key_ups_test]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct shadow_instance_type_projects from row partitions (UNION (overlap))
CREATE VIEW "shadow_instance_type_projects" AS
SELECT "local_5"."instance_type_project_deleted_pre_2014_04_27"."link_created_timestamp" AS "created_at", "local_5"."instance_type_project_deleted_pre_2014_04_27"."link_modified_timestamp" AS "updated_at", "local_5"."instance_type_project_deleted_pre_2014_04_27"."link_deleted_timestamp" AS "deleted_at", "local_5"."instance_type_project_deleted_pre_2014_04_27"."type_project_link_id" AS "id", "local_5"."instance_type_project_deleted_pre_2014_04_27"."instance_type_ref_id" AS "instance_type_id", "local_5"."instance_type_project_deleted_pre_2014_04_27"."project_uuid" AS "project_id", "local_5"."instance_type_project_deleted_pre_2014_04_27"."is_deleted" AS "deleted" FROM "local_5"."instance_type_project_deleted_pre_2014_04_27"
UNION
SELECT "local_5"."instance_type_project_deleted_2014_04_27_to_2014_10_14"."link_created_timestamp" AS "created_at", "local_5"."instance_type_project_deleted_2014_04_27_to_2014_10_14"."link_modified_timestamp" AS "updated_at", "local_5"."instance_type_project_deleted_2014_04_27_to_2014_10_14"."link_deleted_timestamp" AS "deleted_at", "local_5"."instance_type_project_deleted_2014_04_27_to_2014_10_14"."type_project_link_id" AS "id", "local_5"."instance_type_project_deleted_2014_04_27_to_2014_10_14"."instance_type_ref_id" AS "instance_type_id", "local_5"."instance_type_project_deleted_2014_04_27_to_2014_10_14"."project_uuid" AS "project_id", "local_5"."instance_type_project_deleted_2014_04_27_to_2014_10_14"."is_deleted" AS "deleted" FROM "local_5"."instance_type_project_deleted_2014_04_27_to_2014_10_14"
UNION
SELECT "local_5"."instance_type_project_deleted_2014_10_14_to_2015_04_10"."link_created_timestamp" AS "created_at", "local_5"."instance_type_project_deleted_2014_10_14_to_2015_04_10"."link_modified_timestamp" AS "updated_at", "local_5"."instance_type_project_deleted_2014_10_14_to_2015_04_10"."link_deleted_timestamp" AS "deleted_at", "local_5"."instance_type_project_deleted_2014_10_14_to_2015_04_10"."type_project_link_id" AS "id", "local_5"."instance_type_project_deleted_2014_10_14_to_2015_04_10"."instance_type_ref_id" AS "instance_type_id", "local_5"."instance_type_project_deleted_2014_10_14_to_2015_04_10"."project_uuid" AS "project_id", "local_5"."instance_type_project_deleted_2014_10_14_to_2015_04_10"."is_deleted" AS "deleted" FROM "local_5"."instance_type_project_deleted_2014_10_14_to_2015_04_10"
UNION
SELECT "local_5"."instance_type_project_deleted_post_2015_04_10_or_null"."link_created_timestamp" AS "created_at", "local_5"."instance_type_project_deleted_post_2015_04_10_or_null"."link_modified_timestamp" AS "updated_at", "local_5"."instance_type_project_deleted_post_2015_04_10_or_null"."link_deleted_timestamp" AS "deleted_at", "local_5"."instance_type_project_deleted_post_2015_04_10_or_null"."type_project_link_id" AS "id", "local_5"."instance_type_project_deleted_post_2015_04_10_or_null"."instance_type_ref_id" AS "instance_type_id", "local_5"."instance_type_project_deleted_post_2015_04_10_or_null"."project_uuid" AS "project_id", "local_5"."instance_type_project_deleted_post_2015_04_10_or_null"."is_deleted" AS "deleted" FROM "local_5"."instance_type_project_deleted_post_2015_04_10_or_null";

-- Reconstruct shadow_instance_types from vertical (column) split (4 fragments)
CREATE VIEW "shadow_instance_types" AS
SELECT
    t1."c_ts" AS "created_at",
    t1."u_ts" AS "updated_at",
    t1."d_ts" AS "deleted_at",
    t0."nm" AS "name",
    t0."id_pk" AS "id",
    t0."mem_mb" AS "memory_mb",
    t0."vcpus" AS "vcpus",
    t3."swap_mb" AS "swap",
    t0."vcpu_wt" AS "vcpu_weight",
    t0."flavorid" AS "flavorid",
    t0."rxtx_fac" AS "rxtx_factor",
    t3."root_gb" AS "root_gb",
    t3."ephemeral_gb" AS "ephemeral_gb",
    t2."is_disabled" AS "disabled",
    t2."is_public_flg" AS "is_public",
    t2."is_del" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."shdw_itypes_by_flavorid") t0
JOIN "local_1"."shdw_itypes_cts" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn
JOIN "local_1"."shdw_itypes_deleted_flags" t2 ON t0."id_pk" IS t2."id_pk" AND t0.__rn = t2.__rn
JOIN "local_1"."shdw_itypes_ephemeral" t3 ON t0."id_pk" IS t3."id_pk" AND t0.__rn = t3.__rn;

-- Reconstruct shadow_instances from vertical split + row partition on a fragment
CREATE VIEW "shadow_instances" AS
SELECT t4.[c_ts], t4.[u_ts], t4.[d_ts], t0.[id_pk], t2.[internal_id], t2.[usr_id], t2.[proj_id], t2.[img_ref], t2.[kernel_id], t2.[ramdisk_id], t0.[launch_idx], t0.[key_nm], t0.[key_data], t0.[power_state], t0.[vm_state], t1.[mem_mb], t0.[vcpus], t1.[host_full], t1.[host_nm], t0.[user_data], t2.[resv_id], t4.[sched_ts], t4.[laun_ts], t4.[term_ts], t1.[disp_nm], t0.[disp_desc], t0.[az_nm], t0.[is_locked], t0.[os_nm], t1.[laun_ts], t2.[itype_id_fk], t0.[vm_mode], t2.[uuid_val], t0.[arch_nm], t3.[root_dev_nm], t0.[acc_ip_v4], t0.[acc_ip_v6], t3.[cfg_drive], t0.[task_state], t3.[def_ephem_dev], t1.[def_swap_dev], t0.[progress_pct], t0.[auto_disk_cfg], t0.[shut_term_flg], t0.[dis_term_flg], t3.[root_gb], t3.[ephemeral_gb], t0.[cell_nm], t1.[node_nm], t0.[is_del], t1.[locked_by], t0.[is_cleaned], t0.[ephem_key_uuid]
FROM [local_1].[shdw_inst_access_base] t0
JOIN (
SELECT [shdw_inst_access_host_empty].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_inst_access_host_empty].[id_pk], [local_1].[shdw_inst_access_host_empty].[launch_idx], [local_1].[shdw_inst_access_host_empty].[key_nm], [local_1].[shdw_inst_access_host_empty].[mem_mb], [local_1].[shdw_inst_access_host_empty].[host_full], [local_1].[shdw_inst_access_host_empty].[host_nm], [local_1].[shdw_inst_access_host_empty].[disp_nm], [local_1].[shdw_inst_access_host_empty].[disp_desc], [local_1].[shdw_inst_access_host_empty].[az_nm], [local_1].[shdw_inst_access_host_empty].[is_locked], [local_1].[shdw_inst_access_host_empty].[laun_ts], [local_1].[shdw_inst_access_host_empty].[acc_ip_v4], [local_1].[shdw_inst_access_host_empty].[acc_ip_v6], [local_1].[shdw_inst_access_host_empty].[def_swap_dev], [local_1].[shdw_inst_access_host_empty].[cell_nm], [local_1].[shdw_inst_access_host_empty].[node_nm], [local_1].[shdw_inst_access_host_empty].[locked_by] FROM [local_1].[shdw_inst_access_host_empty]
UNION
SELECT [shdw_inst_access_host_list].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_inst_access_host_list].[id_pk], [local_1].[shdw_inst_access_host_list].[launch_idx], [local_1].[shdw_inst_access_host_list].[key_nm], [local_1].[shdw_inst_access_host_list].[mem_mb], [local_1].[shdw_inst_access_host_list].[host_full], [local_1].[shdw_inst_access_host_list].[host_nm], [local_1].[shdw_inst_access_host_list].[disp_nm], [local_1].[shdw_inst_access_host_list].[disp_desc], [local_1].[shdw_inst_access_host_list].[az_nm], [local_1].[shdw_inst_access_host_list].[is_locked], [local_1].[shdw_inst_access_host_list].[laun_ts], [local_1].[shdw_inst_access_host_list].[acc_ip_v4], [local_1].[shdw_inst_access_host_list].[acc_ip_v6], [local_1].[shdw_inst_access_host_list].[def_swap_dev], [local_1].[shdw_inst_access_host_list].[cell_nm], [local_1].[shdw_inst_access_host_list].[node_nm], [local_1].[shdw_inst_access_host_list].[locked_by] FROM [local_1].[shdw_inst_access_host_list]
UNION
SELECT [shdw_inst_access_host_other].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_inst_access_host_other].[id_pk], [local_1].[shdw_inst_access_host_other].[launch_idx], [local_1].[shdw_inst_access_host_other].[key_nm], [local_1].[shdw_inst_access_host_other].[mem_mb], [local_1].[shdw_inst_access_host_other].[host_full], [local_1].[shdw_inst_access_host_other].[host_nm], [local_1].[shdw_inst_access_host_other].[disp_nm], [local_1].[shdw_inst_access_host_other].[disp_desc], [local_1].[shdw_inst_access_host_other].[az_nm], [local_1].[shdw_inst_access_host_other].[is_locked], [local_1].[shdw_inst_access_host_other].[laun_ts], [local_1].[shdw_inst_access_host_other].[acc_ip_v4], [local_1].[shdw_inst_access_host_other].[acc_ip_v6], [local_1].[shdw_inst_access_host_other].[def_swap_dev], [local_1].[shdw_inst_access_host_other].[cell_nm], [local_1].[shdw_inst_access_host_other].[node_nm], [local_1].[shdw_inst_access_host_other].[locked_by] FROM [local_1].[shdw_inst_access_host_other]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[shdw_inst_rec] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[shdw_inst_disk_cfg] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_1].[shdw_inst_cts] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct shadow_key_pairs from vertical split + row partition on a fragment
CREATE VIEW "shadow_key_pairs" AS
SELECT t0.[c_ts], t0.[u_ts], t0.[d_ts], t0.[id_pk], t0.[nm], t0.[usr_id], t1.[fp], t1.[pub_key], t0.[is_del], t0.[kp_type]
FROM (
SELECT [shdw_kp_cts_user_7415].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_kp_cts_user_7415].[c_ts], [local_1].[shdw_kp_cts_user_7415].[u_ts], [local_1].[shdw_kp_cts_user_7415].[d_ts], [local_1].[shdw_kp_cts_user_7415].[id_pk], [local_1].[shdw_kp_cts_user_7415].[nm], [local_1].[shdw_kp_cts_user_7415].[usr_id], [local_1].[shdw_kp_cts_user_7415].[is_del], [local_1].[shdw_kp_cts_user_7415].[kp_type] FROM [local_1].[shdw_kp_cts_user_7415]
UNION
SELECT [shdw_kp_cts_user_other].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_kp_cts_user_other].[c_ts], [local_1].[shdw_kp_cts_user_other].[u_ts], [local_1].[shdw_kp_cts_user_other].[d_ts], [local_1].[shdw_kp_cts_user_other].[id_pk], [local_1].[shdw_kp_cts_user_other].[nm], [local_1].[shdw_kp_cts_user_other].[usr_id], [local_1].[shdw_kp_cts_user_other].[is_del], [local_1].[shdw_kp_cts_user_other].[kp_type] FROM [local_1].[shdw_kp_cts_user_other]
UNION
SELECT [shdw_kp_cts_user_some].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_kp_cts_user_some].[c_ts], [local_1].[shdw_kp_cts_user_some].[u_ts], [local_1].[shdw_kp_cts_user_some].[d_ts], [local_1].[shdw_kp_cts_user_some].[id_pk], [local_1].[shdw_kp_cts_user_some].[nm], [local_1].[shdw_kp_cts_user_some].[usr_id], [local_1].[shdw_kp_cts_user_some].[is_del], [local_1].[shdw_kp_cts_user_some].[kp_type] FROM [local_1].[shdw_kp_cts_user_some]
UNION
SELECT [shdw_kp_cts_user_three].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_kp_cts_user_three].[c_ts], [local_1].[shdw_kp_cts_user_three].[u_ts], [local_1].[shdw_kp_cts_user_three].[d_ts], [local_1].[shdw_kp_cts_user_three].[id_pk], [local_1].[shdw_kp_cts_user_three].[nm], [local_1].[shdw_kp_cts_user_three].[usr_id], [local_1].[shdw_kp_cts_user_three].[is_del], [local_1].[shdw_kp_cts_user_three].[kp_type] FROM [local_1].[shdw_kp_cts_user_three]
UNION
SELECT [shdw_kp_cts_user_two].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_kp_cts_user_two].[c_ts], [local_1].[shdw_kp_cts_user_two].[u_ts], [local_1].[shdw_kp_cts_user_two].[d_ts], [local_1].[shdw_kp_cts_user_two].[id_pk], [local_1].[shdw_kp_cts_user_two].[nm], [local_1].[shdw_kp_cts_user_two].[usr_id], [local_1].[shdw_kp_cts_user_two].[is_del], [local_1].[shdw_kp_cts_user_two].[kp_type] FROM [local_1].[shdw_kp_cts_user_two]
) t0
JOIN [local_1].[shdw_kp_deleted] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct shadow_migrate_version from local_1.shdw_mig_version
CREATE VIEW "shadow_migrate_version" AS
SELECT
    "local_1"."shdw_mig_version"."repo_id_pk" AS "repository_id",
    "local_1"."shdw_mig_version"."repo_path" AS "repository_path",
    "local_1"."shdw_mig_version"."ver_num" AS "version"
FROM "local_1"."shdw_mig_version";

-- Reconstruct shadow_migrations from vertical split + row partition on a fragment
CREATE VIEW "shadow_migrations" AS
SELECT t0.[c_ts], t0.[u_ts], t0.[d_ts], t0.[id_pk], t0.[src_compute], t0.[dest_compute], t0.[dest_host], t0.[status_k], t1.[inst_uuid], t3.[old_itype_id], t3.[new_itype_id], t1.[src_node], t1.[dest_node], t0.[is_del], t0.[migr_type], t0.[is_hidden], t4.[mem_total], t4.[mem_done], t4.[mem_rem], t2.[disk_total], t2.[disk_done], t2.[disk_rem]
FROM [local_1].[shdw_migr_cts] t0
JOIN [local_1].[shdw_migr_deleted] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[shdw_migr_disk_progress] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN (
SELECT [shdw_migr_newtype_66to73].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_migr_newtype_66to73].[id_pk], [local_1].[shdw_migr_newtype_66to73].[status_k], [local_1].[shdw_migr_newtype_66to73].[inst_uuid], [local_1].[shdw_migr_newtype_66to73].[old_itype_id], [local_1].[shdw_migr_newtype_66to73].[new_itype_id], [local_1].[shdw_migr_newtype_66to73].[migr_type] FROM [local_1].[shdw_migr_newtype_66to73]
UNION
SELECT [shdw_migr_newtype_74to81].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_migr_newtype_74to81].[id_pk], [local_1].[shdw_migr_newtype_74to81].[status_k], [local_1].[shdw_migr_newtype_74to81].[inst_uuid], [local_1].[shdw_migr_newtype_74to81].[old_itype_id], [local_1].[shdw_migr_newtype_74to81].[new_itype_id], [local_1].[shdw_migr_newtype_74to81].[migr_type] FROM [local_1].[shdw_migr_newtype_74to81]
UNION
SELECT [shdw_migr_newtype_gt81].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_migr_newtype_gt81].[id_pk], [local_1].[shdw_migr_newtype_gt81].[status_k], [local_1].[shdw_migr_newtype_gt81].[inst_uuid], [local_1].[shdw_migr_newtype_gt81].[old_itype_id], [local_1].[shdw_migr_newtype_gt81].[new_itype_id], [local_1].[shdw_migr_newtype_gt81].[migr_type] FROM [local_1].[shdw_migr_newtype_gt81]
UNION
SELECT [shdw_migr_newtype_le65].[__orig_rowid] AS __orig_rowid, [local_1].[shdw_migr_newtype_le65].[id_pk], [local_1].[shdw_migr_newtype_le65].[status_k], [local_1].[shdw_migr_newtype_le65].[inst_uuid], [local_1].[shdw_migr_newtype_le65].[old_itype_id], [local_1].[shdw_migr_newtype_le65].[new_itype_id], [local_1].[shdw_migr_newtype_le65].[migr_type] FROM [local_1].[shdw_migr_newtype_le65]
) t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_1].[shdw_migr_mem_progress] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct shadow_networks from vertical (column) split (5 fragments)
CREATE VIEW "shadow_networks" AS
SELECT
    t4."c_ts" AS "created_at",
    t4."u_ts" AS "updated_at",
    t4."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t2."is_injected" AS "injected",
    t3."cidr" AS "cidr",
    t2."netmask" AS "netmask",
    t0."bridge_nm" AS "bridge",
    t3."gw" AS "gateway",
    t2."broadcast_addr" AS "broadcast",
    t0."dns_1" AS "dns1",
    t2."vlan_id" AS "vlan",
    t1."vpn_pub_addr" AS "vpn_public_address",
    t1."vpn_pub_port" AS "vpn_public_port",
    t1."vpn_priv_addr" AS "vpn_private_address",
    t2."dhcp_start" AS "dhcp_start",
    t2."proj_id" AS "project_id",
    t0."host_nm" AS "host",
    t3."cidr_v6" AS "cidr_v6",
    t3."gw_v6" AS "gateway_v6",
    t0."label_k" AS "label",
    t3."netmask_v6" AS "netmask_v6",
    t0."bridge_if" AS "bridge_interface",
    t2."multi_host_flg" AS "multi_host",
    t0."dns_2" AS "dns2",
    t2."uuid_val" AS "uuid",
    t2."priority" AS "priority",
    t1."rxtx_base" AS "rxtx_base",
    t2."is_del" AS "deleted",
    t2."mtu" AS "mtu",
    t2."dhcp_srv" AS "dhcp_server",
    t2."enable_dhcp_flg" AS "enable_dhcp",
    t2."share_addr_flg" AS "share_address"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."shdw_net_bridge") t0
JOIN "local_1"."shdw_net_bridge_vpn" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn
JOIN "local_1"."shdw_net_broadcast_cfg" t2 ON t0."id_pk" IS t2."id_pk" AND t0.__rn = t2.__rn
JOIN "local_1"."shdw_net_broadcast_full" t3 ON t0."id_pk" IS t3."id_pk" AND t0.__rn = t3.__rn
JOIN "local_1"."shdw_networks_cts" t4 ON t0."id_pk" IS t4."id_pk" AND t0.__rn = t4.__rn;

-- Reconstruct shadow_pci_devices from vertical (column) split (3 fragments)
CREATE VIEW "shadow_pci_devices" AS
SELECT
    t1."c_ts" AS "created_at",
    t1."u_ts" AS "updated_at",
    t1."d_ts" AS "deleted_at",
    t2."is_del" AS "deleted",
    t0."id_pk" AS "id",
    t0."comp_node_id" AS "compute_node_id",
    t0."addr" AS "address",
    t0."prod_id" AS "product_id",
    t0."vendor_id" AS "vendor_id",
    t2."dev_type" AS "dev_type",
    t0."dev_id" AS "dev_id",
    t0."lbl" AS "label",
    t2."status_k" AS "status",
    t0."extra_info" AS "extra_info",
    t0."inst_uuid" AS "instance_uuid",
    t0."req_id" AS "request_id",
    t0."numa_node" AS "numa_node",
    t0."parent_addr" AS "parent_addr"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."shdw_pci_dev_addr") t0
JOIN "local_1"."shdw_pci_dev_cts" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn
JOIN "local_1"."shdw_pci_dev_deleted" t2 ON t0."id_pk" IS t2."id_pk" AND t0.__rn = t2.__rn;

-- Reconstruct shadow_project_user_quotas from vertical (column) split (2 fragments)
CREATE VIEW "shadow_project_user_quotas" AS
SELECT
    t0."id_pk" AS "id",
    t0."c_ts" AS "created_at",
    t0."u_ts" AS "updated_at",
    t0."d_ts" AS "deleted_at",
    t0."is_del" AS "deleted",
    t0."usr_id" AS "user_id",
    t1."proj_id" AS "project_id",
    t0."res_k" AS "resource",
    t0."hard_lim" AS "hard_limit"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."shdw_proj_user_quota_cts") t0
JOIN "local_1"."shdw_proj_user_quota_deleted" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct shadow_provider_fw_rules from vertical (column) split (2 fragments)
CREATE VIEW "shadow_provider_fw_rules" AS
SELECT
    t0."c_ts" AS "created_at",
    t1."u_ts" AS "updated_at",
    t1."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t0."proto" AS "protocol",
    t0."port_from" AS "from_port",
    t0."port_to" AS "to_port",
    t0."cidr" AS "cidr",
    t0."is_del" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."shdw_prov_fw_rules") t0
JOIN "local_1"."shdw_prov_fw_rules_cts" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct shadow_quota_classes from vertical (column) split (2 fragments)
CREATE VIEW "shadow_quota_classes" AS
SELECT
    t1."c_ts" AS "created_at",
    t1."u_ts" AS "updated_at",
    t1."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t0."class_nm" AS "class_name",
    t0."res_k" AS "resource",
    t0."hard_lim" AS "hard_limit",
    t0."is_del" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."shdw_quota_cls") t0
JOIN "local_1"."shdw_quota_cls_cts" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct shadow_quota_usages from vertical (column) split (3 fragments)
CREATE VIEW "shadow_quota_usages" AS
SELECT
    t0."c_ts" AS "created_at",
    t0."u_ts" AS "updated_at",
    t0."d_ts" AS "deleted_at",
    t0."id_pk" AS "id",
    t2."proj_id" AS "project_id",
    t1."res_k" AS "resource",
    t1."in_use" AS "in_use",
    t1."reserved_cnt" AS "reserved",
    t0."until_refresh" AS "until_refresh",
    t0."is_del" AS "deleted",
    t2."usr_id" AS "user_id"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."shdw_quota_usage_cts") t0
JOIN "local_1"."shdw_quota_usage_deleted" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn
JOIN "local_1"."shdw_quota_usage_inuse" t2 ON t0."id_pk" IS t2."id_pk" AND t0.__rn = t2.__rn;

-- Reconstruct shadow_quotas from vertical (column) split (2 fragments)
CREATE VIEW "shadow_quotas" AS
SELECT
    t0."id_pk" AS "id",
    t0."c_ts" AS "created_at",
    t0."u_ts" AS "updated_at",
    t0."d_ts" AS "deleted_at",
    t0."proj_id" AS "project_id",
    t0."res_k" AS "resource",
    t1."hard_lim" AS "hard_limit",
    t0."is_del" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "id_pk" ORDER BY rowid) AS __rn FROM "local_1"."shdw_quotas_cts") t0
JOIN "local_1"."shdw_quotas_deleted" t1 ON t0."id_pk" IS t1."id_pk" AND t0.__rn = t1.__rn;

-- Reconstruct shadow_reservations from vertical split + row partition on a fragment
CREATE VIEW "shadow_reservations" AS
SELECT t0.[createdAt], t0.[updatedAt], t0.[deletedAt], t0.[recordId], t2.[reservationUuid], t1.[usageId], t2.[projectId], t0.[resourceName], t1.[deltaChange], t0.[expiresAt], t0.[isDeleted], t2.[userId]
FROM (
SELECT [shadowReservationsCreatedAfter2015Apr13To2015Dec08].[__orig_rowid] AS __orig_rowid, [local_6].[shadowReservationsCreatedAfter2015Apr13To2015Dec08].[createdAt], [local_6].[shadowReservationsCreatedAfter2015Apr13To2015Dec08].[updatedAt], [local_6].[shadowReservationsCreatedAfter2015Apr13To2015Dec08].[deletedAt], [local_6].[shadowReservationsCreatedAfter2015Apr13To2015Dec08].[recordId], [local_6].[shadowReservationsCreatedAfter2015Apr13To2015Dec08].[resourceName], [local_6].[shadowReservationsCreatedAfter2015Apr13To2015Dec08].[expiresAt], [local_6].[shadowReservationsCreatedAfter2015Apr13To2015Dec08].[isDeleted] FROM [local_6].[shadowReservationsCreatedAfter2015Apr13To2015Dec08]
UNION
SELECT [shadowReservationsCreatedAfter2015Dec08OrNull].[__orig_rowid] AS __orig_rowid, [local_6].[shadowReservationsCreatedAfter2015Dec08OrNull].[createdAt], [local_6].[shadowReservationsCreatedAfter2015Dec08OrNull].[updatedAt], [local_6].[shadowReservationsCreatedAfter2015Dec08OrNull].[deletedAt], [local_6].[shadowReservationsCreatedAfter2015Dec08OrNull].[recordId], [local_6].[shadowReservationsCreatedAfter2015Dec08OrNull].[resourceName], [local_6].[shadowReservationsCreatedAfter2015Dec08OrNull].[expiresAt], [local_6].[shadowReservationsCreatedAfter2015Dec08OrNull].[isDeleted] FROM [local_6].[shadowReservationsCreatedAfter2015Dec08OrNull]
UNION
SELECT [shadowReservationsCreatedAfter2015Mar01To2015Apr13].[__orig_rowid] AS __orig_rowid, [local_6].[shadowReservationsCreatedAfter2015Mar01To2015Apr13].[createdAt], [local_6].[shadowReservationsCreatedAfter2015Mar01To2015Apr13].[updatedAt], [local_6].[shadowReservationsCreatedAfter2015Mar01To2015Apr13].[deletedAt], [local_6].[shadowReservationsCreatedAfter2015Mar01To2015Apr13].[recordId], [local_6].[shadowReservationsCreatedAfter2015Mar01To2015Apr13].[resourceName], [local_6].[shadowReservationsCreatedAfter2015Mar01To2015Apr13].[expiresAt], [local_6].[shadowReservationsCreatedAfter2015Mar01To2015Apr13].[isDeleted] FROM [local_6].[shadowReservationsCreatedAfter2015Mar01To2015Apr13]
UNION
SELECT [shadowReservationsCreatedBefore2015Mar01].[__orig_rowid] AS __orig_rowid, [local_6].[shadowReservationsCreatedBefore2015Mar01].[createdAt], [local_6].[shadowReservationsCreatedBefore2015Mar01].[updatedAt], [local_6].[shadowReservationsCreatedBefore2015Mar01].[deletedAt], [local_6].[shadowReservationsCreatedBefore2015Mar01].[recordId], [local_6].[shadowReservationsCreatedBefore2015Mar01].[resourceName], [local_6].[shadowReservationsCreatedBefore2015Mar01].[expiresAt], [local_6].[shadowReservationsCreatedBefore2015Mar01].[isDeleted] FROM [local_6].[shadowReservationsCreatedBefore2015Mar01]
) t0
JOIN [local_6].[shadowReservationsUsageDelta] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_6].[shadowReservationsByProject] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct shadow_s3_images from local_1.shdw_s3_imgs
CREATE VIEW "shadow_s3_images" AS
SELECT
    "local_1"."shdw_s3_imgs"."c_ts" AS "created_at",
    "local_1"."shdw_s3_imgs"."u_ts" AS "updated_at",
    "local_1"."shdw_s3_imgs"."d_ts" AS "deleted_at",
    "local_1"."shdw_s3_imgs"."id_pk" AS "id",
    "local_1"."shdw_s3_imgs"."uuid_val" AS "uuid",
    "local_1"."shdw_s3_imgs"."is_del" AS "deleted"
FROM "local_1"."shdw_s3_imgs";

-- Reconstruct shadow_security_group_default_rules from vertical (column) split (2 fragments)
CREATE VIEW "shadow_security_group_default_rules" AS
SELECT
    t1."created_on" AS "created_at",
    t0."updated_at_timestamp" AS "updated_at",
    t1."deleted_at_timestamp" AS "deleted_at",
    t0."deleted_flag" AS "deleted",
    t0."rule_id" AS "id",
    t0."ip_protocol" AS "protocol",
    t0."port_from" AS "from_port",
    t0."port_to" AS "to_port",
    t0."cidr_block" AS "cidr"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "rule_id" ORDER BY rowid) AS __rn FROM "local_2"."shadow_sg_default_rule_cidrs") t0
JOIN "local_2"."shadow_sg_default_rule_cidrs_archive" t1 ON t0."rule_id" IS t1."rule_archive_id" AND t0.__rn = t1.__rn;

-- Reconstruct shadow_security_group_instance_association from local_6.securityGroupInstanceLinksShadow
CREATE VIEW "shadow_security_group_instance_association" AS
SELECT
    "local_6"."securityGroupInstanceLinksShadow"."createdAt" AS "created_at",
    "local_6"."securityGroupInstanceLinksShadow"."updatedAt" AS "updated_at",
    "local_6"."securityGroupInstanceLinksShadow"."deletedAt" AS "deleted_at",
    "local_6"."securityGroupInstanceLinksShadow"."recordId" AS "id",
    "local_6"."securityGroupInstanceLinksShadow"."securityGroupRefId" AS "security_group_id",
    "local_6"."securityGroupInstanceLinksShadow"."instanceUuidRef" AS "instance_uuid",
    "local_6"."securityGroupInstanceLinksShadow"."isDeleted" AS "deleted"
FROM "local_6"."securityGroupInstanceLinksShadow";

-- Reconstruct shadow_security_group_rules from vertical split + row partition on a fragment
CREATE VIEW "shadow_security_group_rules" AS
SELECT t1.[CreatedAt], t1.[UpdatedAt], t1.[DeletedAt], t0.[Id], t1.[ParentGroupId], t0.[Protocol], t0.[PortFrom], t0.[PortTo], t0.[Cidr], t0.[GroupId], t0.[IsDeleted]
FROM [local_3].[SecurityGroupRuleCidrShadow] t0
JOIN (
SELECT [SecurityGroupRuleCidrParentGroupId23To55].[__orig_rowid] AS __orig_rowid, [local_3].[SecurityGroupRuleCidrParentGroupId23To55].[CreatedAt], [local_3].[SecurityGroupRuleCidrParentGroupId23To55].[UpdatedAt], [local_3].[SecurityGroupRuleCidrParentGroupId23To55].[DeletedAt], [local_3].[SecurityGroupRuleCidrParentGroupId23To55].[Id], [local_3].[SecurityGroupRuleCidrParentGroupId23To55].[ParentGroupId], [local_3].[SecurityGroupRuleCidrParentGroupId23To55].[Protocol], [local_3].[SecurityGroupRuleCidrParentGroupId23To55].[Cidr], [local_3].[SecurityGroupRuleCidrParentGroupId23To55].[GroupId], [local_3].[SecurityGroupRuleCidrParentGroupId23To55].[IsDeleted] FROM [local_3].[SecurityGroupRuleCidrParentGroupId23To55]
UNION
SELECT [SecurityGroupRuleCidrParentGroupIdGt55OrNull].[__orig_rowid] AS __orig_rowid, [local_3].[SecurityGroupRuleCidrParentGroupIdGt55OrNull].[CreatedAt], [local_3].[SecurityGroupRuleCidrParentGroupIdGt55OrNull].[UpdatedAt], [local_3].[SecurityGroupRuleCidrParentGroupIdGt55OrNull].[DeletedAt], [local_3].[SecurityGroupRuleCidrParentGroupIdGt55OrNull].[Id], [local_3].[SecurityGroupRuleCidrParentGroupIdGt55OrNull].[ParentGroupId], [local_3].[SecurityGroupRuleCidrParentGroupIdGt55OrNull].[Protocol], [local_3].[SecurityGroupRuleCidrParentGroupIdGt55OrNull].[Cidr], [local_3].[SecurityGroupRuleCidrParentGroupIdGt55OrNull].[GroupId], [local_3].[SecurityGroupRuleCidrParentGroupIdGt55OrNull].[IsDeleted] FROM [local_3].[SecurityGroupRuleCidrParentGroupIdGt55OrNull]
UNION
SELECT [SecurityGroupRuleCidrParentGroupIdLe22].[__orig_rowid] AS __orig_rowid, [local_3].[SecurityGroupRuleCidrParentGroupIdLe22].[CreatedAt], [local_3].[SecurityGroupRuleCidrParentGroupIdLe22].[UpdatedAt], [local_3].[SecurityGroupRuleCidrParentGroupIdLe22].[DeletedAt], [local_3].[SecurityGroupRuleCidrParentGroupIdLe22].[Id], [local_3].[SecurityGroupRuleCidrParentGroupIdLe22].[ParentGroupId], [local_3].[SecurityGroupRuleCidrParentGroupIdLe22].[Protocol], [local_3].[SecurityGroupRuleCidrParentGroupIdLe22].[Cidr], [local_3].[SecurityGroupRuleCidrParentGroupIdLe22].[GroupId], [local_3].[SecurityGroupRuleCidrParentGroupIdLe22].[IsDeleted] FROM [local_3].[SecurityGroupRuleCidrParentGroupIdLe22]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct shadow_security_groups from vertical (column) split (2 fragments)
CREATE VIEW "shadow_security_groups" AS
SELECT
    t0."CreatedAt" AS "created_at",
    t0."UpdatedAt" AS "updated_at",
    t0."DeletedAt" AS "deleted_at",
    t0."Id" AS "id",
    t0."Name" AS "name",
    t0."Description" AS "description",
    t0."UserId" AS "user_id",
    t1."ProjectId" AS "project_id",
    t0."IsDeleted" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "Id" ORDER BY rowid) AS __rn FROM "local_3"."SecurityGroupShadowCreatedAt") t0
JOIN "local_3"."SecurityGroupShadowDeleted" t1 ON t0."Id" IS t1."Id" AND t0.__rn = t1.__rn;

-- Reconstruct shadow_services from vertical split + row partition on a fragment
CREATE VIEW "shadow_services" AS
SELECT t1.[createdTimestamp], t0.[updatedTimestamp], t1.[deletedTimestamp], t0.[binaryId], t0.[hostName], t0.[binaryName], t0.[serviceTopic], t0.[reportCount], t2.[isDisabledFlag], t0.[deletedCount], t0.[disabledReason], t1.[lastSeenUpTimestamp], t2.[forcedDownFlag], t0.[versionNumber]
FROM (
SELECT [serviceBinariesDeletedGreaterThanOneUpTo139].[__orig_rowid] AS __orig_rowid, [local_4].[serviceBinariesDeletedGreaterThanOneUpTo139].[updatedTimestamp], [local_4].[serviceBinariesDeletedGreaterThanOneUpTo139].[binaryId], [local_4].[serviceBinariesDeletedGreaterThanOneUpTo139].[hostName], [local_4].[serviceBinariesDeletedGreaterThanOneUpTo139].[binaryName], [local_4].[serviceBinariesDeletedGreaterThanOneUpTo139].[serviceTopic], [local_4].[serviceBinariesDeletedGreaterThanOneUpTo139].[reportCount], [local_4].[serviceBinariesDeletedGreaterThanOneUpTo139].[deletedCount], [local_4].[serviceBinariesDeletedGreaterThanOneUpTo139].[disabledReason], [local_4].[serviceBinariesDeletedGreaterThanOneUpTo139].[versionNumber] FROM [local_4].[serviceBinariesDeletedGreaterThanOneUpTo139]
UNION
SELECT [serviceBinariesDeletedOver139OrNull].[__orig_rowid] AS __orig_rowid, [local_4].[serviceBinariesDeletedOver139OrNull].[updatedTimestamp], [local_4].[serviceBinariesDeletedOver139OrNull].[binaryId], [local_4].[serviceBinariesDeletedOver139OrNull].[hostName], [local_4].[serviceBinariesDeletedOver139OrNull].[binaryName], [local_4].[serviceBinariesDeletedOver139OrNull].[serviceTopic], [local_4].[serviceBinariesDeletedOver139OrNull].[reportCount], [local_4].[serviceBinariesDeletedOver139OrNull].[deletedCount], [local_4].[serviceBinariesDeletedOver139OrNull].[disabledReason], [local_4].[serviceBinariesDeletedOver139OrNull].[versionNumber] FROM [local_4].[serviceBinariesDeletedOver139OrNull]
UNION
SELECT [serviceBinariesDeletedZeroOrOne].[__orig_rowid] AS __orig_rowid, [local_4].[serviceBinariesDeletedZeroOrOne].[updatedTimestamp], [local_4].[serviceBinariesDeletedZeroOrOne].[binaryId], [local_4].[serviceBinariesDeletedZeroOrOne].[hostName], [local_4].[serviceBinariesDeletedZeroOrOne].[binaryName], [local_4].[serviceBinariesDeletedZeroOrOne].[serviceTopic], [local_4].[serviceBinariesDeletedZeroOrOne].[reportCount], [local_4].[serviceBinariesDeletedZeroOrOne].[deletedCount], [local_4].[serviceBinariesDeletedZeroOrOne].[disabledReason], [local_4].[serviceBinariesDeletedZeroOrOne].[versionNumber] FROM [local_4].[serviceBinariesDeletedZeroOrOne]
) t0
JOIN [local_4].[serviceStatusTimestamps] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_4].[serviceDeletionRecords] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct shadow_snapshot_id_mappings from local_5.snapshot_id_mappings_archive
CREATE VIEW "shadow_snapshot_id_mappings" AS
SELECT
    "local_5"."snapshot_id_mappings_archive"."mapping_created_timestamp" AS "created_at",
    "local_5"."snapshot_id_mappings_archive"."mapping_modified_timestamp" AS "updated_at",
    "local_5"."snapshot_id_mappings_archive"."mapping_deleted_timestamp" AS "deleted_at",
    "local_5"."snapshot_id_mappings_archive"."mapping_id" AS "id",
    "local_5"."snapshot_id_mappings_archive"."snapshot_uuid" AS "uuid",
    "local_5"."snapshot_id_mappings_archive"."is_deleted" AS "deleted"
FROM "local_5"."snapshot_id_mappings_archive";

-- Reconstruct shadow_snapshots from vertical (column) split (3 fragments)
CREATE VIEW "shadow_snapshots" AS
SELECT
    t2."snapshot_created_timestamp" AS "created_at",
    t2."snapshot_modified_timestamp" AS "updated_at",
    t2."snapshot_deleted_timestamp" AS "deleted_at",
    t0."snapshot_uuid" AS "id",
    t1."volume_uuid" AS "volume_id",
    t1."owner_user_uuid" AS "user_id",
    t1."project_uuid" AS "project_id",
    t0."lifecycle_status" AS "status",
    t0."progress_percent" AS "progress",
    t0."size_gb" AS "volume_size",
    t2."scheduled_timestamp" AS "scheduled_at",
    t0."display_title" AS "display_name",
    t0."description" AS "display_description",
    t0."is_deleted" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "snapshot_uuid" ORDER BY rowid) AS __rn FROM "local_5"."snapshot_deleted_details") t0
JOIN "local_5"."snapshot_deleted_with_owner" t1 ON t0."snapshot_uuid" IS t1."snapshot_uuid" AND t0.__rn = t1.__rn
JOIN "local_5"."snapshot_record_created_archive" t2 ON t0."snapshot_uuid" IS t2."snapshot_uuid" AND t0.__rn = t2.__rn;

-- Reconstruct shadow_task_log from vertical (column) split (3 fragments)
CREATE VIEW "shadow_task_log" AS
SELECT
    t2."createdTimestamp" AS "created_at",
    t2."updatedTimestamp" AS "updated_at",
    t2."deletedTimestamp" AS "deleted_at",
    t0."logId" AS "id",
    t0."taskName" AS "task_name",
    t0."stateName" AS "state",
    t0."hostName" AS "host",
    t1."periodStart" AS "period_beginning",
    t1."periodEnd" AS "period_ending",
    t0."messageText" AS "message",
    t0."taskItemCount" AS "task_items",
    t0."errorCount" AS "errors",
    t0."deletedFlag" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "logId" ORDER BY rowid) AS __rn FROM "local_4"."taskLogDeletionRecords") t0
JOIN "local_4"."taskLogDeletionSummaries" t1 ON t0."logId" IS t1."summaryId" AND t0.__rn = t1.__rn
JOIN "local_4"."taskLogTimestamps" t2 ON t0."logId" IS t2."logId" AND t0.__rn = t2.__rn;

-- Reconstruct shadow_virtual_interfaces from vertical (column) split (2 fragments)
CREATE VIEW "shadow_virtual_interfaces" AS
SELECT
    t1."CreatedAt" AS "created_at",
    t1."UpdatedAt" AS "updated_at",
    t1."DeletedAt" AS "deleted_at",
    t0."Id" AS "id",
    t0."AddressValue" AS "address",
    t0."NetworkId" AS "network_id",
    t0."Uuid" AS "uuid",
    t0."InstanceUuid" AS "instance_uuid",
    t0."IsDeleted" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "Id" ORDER BY rowid) AS __rn FROM "local_7"."VirtualInterfaceAddressShadow") t0
JOIN "local_7"."VirtualInterfaceAddressShadowWithTimestamps" t1 ON t0."Id" IS t1."Id" AND t0.__rn = t1.__rn;

-- Reconstruct shadow_volume_id_mappings from local_6.volumeIdMappingsShadow
CREATE VIEW "shadow_volume_id_mappings" AS
SELECT
    "local_6"."volumeIdMappingsShadow"."createdAt" AS "created_at",
    "local_6"."volumeIdMappingsShadow"."updatedAt" AS "updated_at",
    "local_6"."volumeIdMappingsShadow"."deletedAt" AS "deleted_at",
    "local_6"."volumeIdMappingsShadow"."recordId" AS "id",
    "local_6"."volumeIdMappingsShadow"."volumeUuid" AS "uuid",
    "local_6"."volumeIdMappingsShadow"."isDeleted" AS "deleted"
FROM "local_6"."volumeIdMappingsShadow";

-- Reconstruct shadow_volume_usage_cache from vertical (column) split (3 fragments)
CREATE VIEW "shadow_volume_usage_cache" AS
SELECT
    t0."createdAt" AS "created_at",
    t0."updatedAt" AS "updated_at",
    t0."deletedAt" AS "deleted_at",
    t0."recordId" AS "id",
    t1."volumeId" AS "volume_id",
    t0."totLastRefreshed" AS "tot_last_refreshed",
    t0."totReads" AS "tot_reads",
    t2."totReadBytes" AS "tot_read_bytes",
    t0."totWrites" AS "tot_writes",
    t2."totWriteBytes" AS "tot_write_bytes",
    t0."currLastRefreshed" AS "curr_last_refreshed",
    t2."currReads" AS "curr_reads",
    t2."currReadBytes" AS "curr_read_bytes",
    t0."currWrites" AS "curr_writes",
    t2."currWriteBytes" AS "curr_write_bytes",
    t0."isDeleted" AS "deleted",
    t0."instanceUuid" AS "instance_uuid",
    t1."projectId" AS "project_id",
    t1."userId" AS "user_id",
    t0."availabilityZone" AS "availability_zone"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "recordId" ORDER BY rowid) AS __rn FROM "local_6"."volumeUsageCacheByAvailabilityZoneShadow") t0
JOIN "local_6"."volumeUsageCacheByInstanceShadow" t1 ON t0."recordId" IS t1."recordId" AND t0.__rn = t1.__rn
JOIN "local_6"."volumeUsageCacheBytesByAvailabilityZoneShadow" t2 ON t0."recordId" IS t2."recordId" AND t0.__rn = t2.__rn;

-- Reconstruct snapshot_id_mappings from local_7.SnapshotIdentifierMappings
CREATE VIEW "snapshot_id_mappings" AS
SELECT
    "local_7"."SnapshotIdentifierMappings"."CreatedAt" AS "created_at",
    "local_7"."SnapshotIdentifierMappings"."UpdatedAt" AS "updated_at",
    "local_7"."SnapshotIdentifierMappings"."DeletedAt" AS "deleted_at",
    "local_7"."SnapshotIdentifierMappings"."Id" AS "id",
    "local_7"."SnapshotIdentifierMappings"."SnapshotUuid" AS "uuid",
    "local_7"."SnapshotIdentifierMappings"."IsDeleted" AS "deleted"
FROM "local_7"."SnapshotIdentifierMappings";

-- Reconstruct snapshots from vertical (column) split (3 fragments)
CREATE VIEW "snapshots" AS
SELECT
    t0."CreatedAt" AS "created_at",
    t0."UpdatedAt" AS "updated_at",
    t0."DeletedAt" AS "deleted_at",
    t0."SnapshotId" AS "id",
    t2."VolumeId" AS "volume_id",
    t2."UserId" AS "user_id",
    t2."ProjectId" AS "project_id",
    t0."Status" AS "status",
    t0."Progress" AS "progress",
    t1."VolumeSize" AS "volume_size",
    t0."ScheduledAt" AS "scheduled_at",
    t0."DisplayName" AS "display_name",
    t1."DisplayDescription" AS "display_description",
    t0."IsDeletedFlag" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "SnapshotId" ORDER BY rowid) AS __rn FROM "local_7"."SnapshotCreateTimestamps") t0
JOIN "local_7"."SnapshotDeletionRecords" t1 ON t0."SnapshotId" IS t1."SnapshotId" AND t0.__rn = t1.__rn
JOIN "local_7"."SnapshotDisplayDetails" t2 ON t0."SnapshotId" IS t2."SnapshotId" AND t0.__rn = t2.__rn;

-- Reconstruct tags from local_7.ResourceTags
CREATE VIEW "tags" AS
SELECT
    "local_7"."ResourceTags"."ResourceId" AS "resource_id",
    "local_7"."ResourceTags"."Tag" AS "tag"
FROM "local_7"."ResourceTags";

-- Reconstruct task_log from vertical (column) split (2 fragments)
CREATE VIEW "task_log" AS
SELECT
    t1."crt_ts" AS "created_at",
    t1."upd_ts" AS "updated_at",
    t1."del_ts" AS "deleted_at",
    t0."task_log_id" AS "id",
    t0."task_label" AS "task_name",
    t0."status" AS "state",
    t0."host_name" AS "host",
    t1."period_start" AS "period_beginning",
    t0."period_end" AS "period_ending",
    t0."msg" AS "message",
    t0."item_count" AS "task_items",
    t0."err_count" AS "errors",
    t0."is_deleted" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "task_log_id" ORDER BY rowid) AS __rn FROM "local_8"."task_log_del_rec") t0
JOIN "local_8"."task_log_time_rec" t1 ON t0."task_log_id" IS t1."task_log_id" AND t0.__rn = t1.__rn;

-- Reconstruct virtual_interfaces from vertical (column) split (2 fragments)
CREATE VIEW "virtual_interfaces" AS
SELECT
    t1."crt_ts" AS "created_at",
    t0."upd_ts" AS "updated_at",
    t1."del_ts" AS "deleted_at",
    t0."vif_addr_id" AS "id",
    t0."mac_addr" AS "address",
    t0."net_id" AS "network_id",
    t0."addr_uuid" AS "uuid",
    t0."inst_uuid" AS "instance_uuid",
    t0."is_deleted" AS "deleted"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "vif_addr_id" ORDER BY rowid) AS __rn FROM "local_8"."vif_addr_assoc") t0
JOIN "local_8"."vif_addr_link" t1 ON t0."vif_addr_id" IS t1."addr_id" AND t0.__rn = t1.__rn;

-- Reconstruct volume_id_mappings from row partitions (UNION (overlap))
CREATE VIEW "volume_id_mappings" AS
SELECT "local_8"."vol_map_upto_2013_10_03_22_43_33"."crt_ts" AS "created_at", "local_8"."vol_map_upto_2013_10_03_22_43_33"."upd_ts" AS "updated_at", "local_8"."vol_map_upto_2013_10_03_22_43_33"."del_ts" AS "deleted_at", "local_8"."vol_map_upto_2013_10_03_22_43_33"."map_id" AS "id", "local_8"."vol_map_upto_2013_10_03_22_43_33"."vol_uuid" AS "uuid", "local_8"."vol_map_upto_2013_10_03_22_43_33"."is_deleted" AS "deleted" FROM "local_8"."vol_map_upto_2013_10_03_22_43_33"
UNION
SELECT "local_8"."vol_map_2013_10_03_22_43_33_to_2014_05_29_13_53_00"."crt_ts" AS "created_at", "local_8"."vol_map_2013_10_03_22_43_33_to_2014_05_29_13_53_00"."upd_ts" AS "updated_at", "local_8"."vol_map_2013_10_03_22_43_33_to_2014_05_29_13_53_00"."del_ts" AS "deleted_at", "local_8"."vol_map_2013_10_03_22_43_33_to_2014_05_29_13_53_00"."map_id" AS "id", "local_8"."vol_map_2013_10_03_22_43_33_to_2014_05_29_13_53_00"."vol_uuid" AS "uuid", "local_8"."vol_map_2013_10_03_22_43_33_to_2014_05_29_13_53_00"."is_deleted" AS "deleted" FROM "local_8"."vol_map_2013_10_03_22_43_33_to_2014_05_29_13_53_00"
UNION
SELECT "local_8"."vol_map_2014_05_29_13_53_00_to_2014_12_08_21_45_01"."crt_ts" AS "created_at", "local_8"."vol_map_2014_05_29_13_53_00_to_2014_12_08_21_45_01"."upd_ts" AS "updated_at", "local_8"."vol_map_2014_05_29_13_53_00_to_2014_12_08_21_45_01"."del_ts" AS "deleted_at", "local_8"."vol_map_2014_05_29_13_53_00_to_2014_12_08_21_45_01"."map_id" AS "id", "local_8"."vol_map_2014_05_29_13_53_00_to_2014_12_08_21_45_01"."vol_uuid" AS "uuid", "local_8"."vol_map_2014_05_29_13_53_00_to_2014_12_08_21_45_01"."is_deleted" AS "deleted" FROM "local_8"."vol_map_2014_05_29_13_53_00_to_2014_12_08_21_45_01"
UNION
SELECT "local_8"."vol_map_after_2014_12_08_21_45_01_or_null"."crt_ts" AS "created_at", "local_8"."vol_map_after_2014_12_08_21_45_01_or_null"."upd_ts" AS "updated_at", "local_8"."vol_map_after_2014_12_08_21_45_01_or_null"."del_ts" AS "deleted_at", "local_8"."vol_map_after_2014_12_08_21_45_01_or_null"."map_id" AS "id", "local_8"."vol_map_after_2014_12_08_21_45_01_or_null"."vol_uuid" AS "uuid", "local_8"."vol_map_after_2014_12_08_21_45_01_or_null"."is_deleted" AS "deleted" FROM "local_8"."vol_map_after_2014_12_08_21_45_01_or_null";

-- Reconstruct volume_usage_cache from vertical (column) split (4 fragments)
CREATE VIEW "volume_usage_cache" AS
SELECT
    t0."crt_ts" AS "created_at",
    t0."upd_ts" AS "updated_at",
    t0."del_ts" AS "deleted_at",
    t0."usage_id" AS "id",
    t0."vol_id" AS "volume_id",
    t0."tot_last_ref" AS "tot_last_refreshed",
    t3."tot_read_ops" AS "tot_reads",
    t2."tot_read_b" AS "tot_read_bytes",
    t3."tot_write_ops" AS "tot_writes",
    t2."tot_write_b" AS "tot_write_bytes",
    t0."cur_last_ref" AS "curr_last_refreshed",
    t3."cur_read_ops" AS "curr_reads",
    t2."cur_read_b" AS "curr_read_bytes",
    t3."cur_write_ops" AS "curr_writes",
    t2."cur_write_b" AS "curr_write_bytes",
    t0."is_deleted" AS "deleted",
    t0."inst_uuid" AS "instance_uuid",
    t0."proj_id" AS "project_id",
    t1."usr_id" AS "user_id",
    t0."az" AS "availability_zone"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "usage_id" ORDER BY rowid) AS __rn FROM "local_8"."vol_usage_az_refresh") t0
JOIN "local_8"."vol_usage_az_snapshot" t1 ON t0."usage_id" IS t1."usage_id" AND t0.__rn = t1.__rn
JOIN "local_8"."vol_usage_bytes_cur" t2 ON t0."usage_id" IS t2."usage_id" AND t0.__rn = t2.__rn
JOIN "local_8"."vol_usage_ops_cur" t3 ON t0."usage_id" IS t3."usage_id" AND t0.__rn = t3.__rn;
