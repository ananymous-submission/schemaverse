CREATE TABLE "agt_bld_arch" (
    "id_pk" INTEGER,
    "arch_nm" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "hyp_nm" TEXT DEFAULT NULL,
    "md5_sum" TEXT DEFAULT NULL,
    "os_nm" TEXT DEFAULT NULL,
    "src_url" TEXT DEFAULT NULL,
    "ver" TEXT DEFAULT NULL
);

CREATE TABLE "agt_bld_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "md5_sum" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "src_url" TEXT DEFAULT NULL,
    "ver" TEXT DEFAULT NULL
);

CREATE TABLE "agg_hosts_spec_hosts" (
    "id_pk" INTEGER,
    "agg_id" INTEGER NOT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL
);

CREATE TABLE "agg_hosts_other_bucket" (
    "id_pk" INTEGER,
    "agg_id_fk" INTEGER NOT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    FOREIGN KEY ("agg_id_fk") REFERENCES "aggs"("id_pk")
);

CREATE TABLE "agg_hosts_with_aggfk" (
    "id_pk" INTEGER,
    "agg_id_fk" INTEGER NOT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    FOREIGN KEY ("agg_id_fk") REFERENCES "aggs"("id_pk")
);

CREATE TABLE "agg_meta_with_aggfk" (
    "id_pk" INTEGER,
    "agg_id_fk" INTEGER NOT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "meta_k" TEXT NOT NULL,
    "meta_v" TEXT NOT NULL,
    FOREIGN KEY ("agg_id_fk") REFERENCES "aggs"("id_pk")
);

CREATE TABLE "agg_meta_cts_bucket" (
    "id_pk" INTEGER,
    "agg_id" INTEGER NOT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "meta_v" TEXT NOT NULL
);

CREATE TABLE "aggs" (
    "c_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "id_pk" INTEGER,
    "nm" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "uuid_val" TEXT DEFAULT NULL
);

CREATE TABLE "bdmap_boot_idx" (
    "id_pk" INTEGER,
    "boot_idx" INTEGER DEFAULT NULL,
    "dev_nm" TEXT DEFAULT NULL,
    "no_dev_flg" INTEGER DEFAULT NULL
);

CREATE TABLE "bdmap_conninfo_smallvol" (
    "id_pk" INTEGER,
    "conn_info" TEXT,
    "del_on_term" INTEGER DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "guest_fmt" TEXT DEFAULT NULL,
    "img_id" TEXT DEFAULT NULL,
    "inst_uuid_fk" TEXT DEFAULT NULL,
    "snap_id" TEXT DEFAULT NULL,
    "src_type" TEXT DEFAULT NULL,
    "vol_id_fk" TEXT DEFAULT NULL,
    "vol_size" INTEGER DEFAULT NULL
);

CREATE TABLE "bdmap_conninfo_largevol" (
    "id_pk" INTEGER,
    "conn_info" TEXT,
    "del_on_term" INTEGER DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "guest_fmt" TEXT DEFAULT NULL,
    "img_id" TEXT DEFAULT NULL,
    "inst_uuid_fk" TEXT DEFAULT NULL,
    "snap_id" TEXT DEFAULT NULL,
    "src_type" TEXT DEFAULT NULL,
    "vol_id_fk" TEXT DEFAULT NULL,
    "vol_size" INTEGER DEFAULT NULL
);

CREATE TABLE "bdmap_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "bdmap_conninfo_voltype" (
    "id_pk" INTEGER,
    "conn_info" TEXT,
    "del_on_term" INTEGER DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "dest_type" TEXT DEFAULT NULL,
    "dev_type" TEXT DEFAULT NULL,
    "disk_bus" TEXT DEFAULT NULL,
    "guest_fmt" TEXT DEFAULT NULL,
    "img_id" TEXT DEFAULT NULL,
    "snap_id" TEXT DEFAULT NULL,
    "src_type" TEXT DEFAULT NULL,
    "vol_size" INTEGER DEFAULT NULL
);

CREATE TABLE "bw_cache_val" (
    "id_pk" INTEGER,
    "bw_in_val" INTEGER DEFAULT NULL,
    "bw_out_val" INTEGER DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "last_ctr_in" INTEGER DEFAULT NULL,
    "last_ctr_out" INTEGER DEFAULT NULL,
    "last_ref_ts" TEXT DEFAULT NULL,
    "mac_addr" TEXT DEFAULT NULL,
    "start_ts" TEXT NOT NULL,
    "uuid_val" TEXT DEFAULT NULL
);

CREATE TABLE "bw_cache_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "last_ref_ts" TEXT DEFAULT NULL,
    "mac_addr" TEXT DEFAULT NULL,
    "start_ts" TEXT NOT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "uuid_val" TEXT DEFAULT NULL
);

CREATE TABLE "cells_api_cfg" (
    "id_pk" INTEGER,
    "api_url" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "is_parent_flg" INTEGER DEFAULT NULL,
    "nm" TEXT DEFAULT NULL,
    "transport_url" TEXT NOT NULL,
    "wt_offset" REAL DEFAULT NULL,
    "wt_scale" REAL DEFAULT NULL
);

CREATE TABLE "cells_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "is_parent_flg" INTEGER DEFAULT NULL,
    "nm" TEXT DEFAULT NULL,
    "transport_url" TEXT NOT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "certs_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "file_nm" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "certs_deleted_proj_3008a1" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "file_nm" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "certs_deleted_proj_71322e_or_other" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "file_nm" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "certs_deleted_proj_98333_2a9b_97107" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "file_nm" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "certs_deleted_proj_70b25_b7188_bfd50_dba6" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "file_nm" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "compnode_cpu_alloc_rat" (
    "id_pk" INTEGER,
    "cpu_alloc_ratio" REAL DEFAULT NULL,
    "disk_alloc_ratio" REAL DEFAULT NULL,
    "ram_alloc_ratio" REAL DEFAULT NULL
);

CREATE TABLE "compnode_cpu_info" (
    "id_pk" INTEGER,
    "cpu_info_blob" TEXT NOT NULL,
    "curr_workload" INTEGER DEFAULT NULL,
    "extra_res" TEXT,
    "free_ram_mb" INTEGER DEFAULT NULL,
    "hyp_type" TEXT NOT NULL,
    "hyp_ver" INTEGER NOT NULL,
    "mem_mb" INTEGER NOT NULL,
    "mem_mb_used" INTEGER NOT NULL,
    "metrics_blob" TEXT,
    "numa_topo" TEXT,
    "pci_stats" TEXT,
    "run_vms" INTEGER DEFAULT NULL,
    "stats_blob" TEXT,
    "supp_instances" TEXT,
    "uuid_val" TEXT DEFAULT NULL,
    "vcpus" INTEGER NOT NULL,
    "vcpus_used" INTEGER NOT NULL
);

CREATE TABLE "compnode_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "metrics_blob" TEXT,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "compnode_disk_least" (
    "id_pk" INTEGER,
    "disk_avail_least" INTEGER DEFAULT NULL,
    "free_disk_gb" INTEGER DEFAULT NULL,
    "free_ram_mb" INTEGER DEFAULT NULL,
    "local_gb" INTEGER NOT NULL,
    "local_gb_used" INTEGER NOT NULL,
    "mem_mb_used" INTEGER NOT NULL
);

CREATE TABLE "compnode_cpu_info_run0" (
    "id_pk" INTEGER,
    "cpu_info_blob" TEXT NOT NULL,
    "curr_workload" INTEGER DEFAULT NULL,
    "extra_res" TEXT,
    "host_nm" TEXT DEFAULT NULL,
    "host_ip" TEXT DEFAULT NULL,
    "hyp_host_nm" TEXT DEFAULT NULL,
    "hyp_type" TEXT NOT NULL,
    "hyp_ver" INTEGER NOT NULL,
    "run_vms" INTEGER DEFAULT NULL,
    "svc_id_fk" INTEGER DEFAULT NULL,
    "stats_blob" TEXT,
    "supp_instances" TEXT,
    "uuid_val" TEXT DEFAULT NULL,
    "vcpus" INTEGER NOT NULL
);

CREATE TABLE "compnode_cpu_info_runpos" (
    "id_pk" INTEGER,
    "cpu_info_blob" TEXT NOT NULL,
    "curr_workload" INTEGER DEFAULT NULL,
    "extra_res" TEXT,
    "host_nm" TEXT DEFAULT NULL,
    "host_ip" TEXT DEFAULT NULL,
    "hyp_host_nm" TEXT DEFAULT NULL,
    "hyp_type" TEXT NOT NULL,
    "hyp_ver" INTEGER NOT NULL,
    "run_vms" INTEGER DEFAULT NULL,
    "svc_id_fk" INTEGER DEFAULT NULL,
    "stats_blob" TEXT,
    "supp_instances" TEXT,
    "uuid_val" TEXT DEFAULT NULL,
    "vcpus" INTEGER NOT NULL
);

CREATE TABLE "console_pools_by_type" (
    "id_pk" INTEGER,
    "console_type" TEXT DEFAULT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "pwd" TEXT DEFAULT NULL,
    "pub_host" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "user_nm" TEXT DEFAULT NULL
);

CREATE TABLE "dns_dom_az" (
    "domain_nm" TEXT,
    "az_nm" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "scope_k" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "dns_dom_az_cts" (
    "domain_nm" TEXT,
    "az_nm" TEXT DEFAULT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "fixip_addr_alloc" (
    "id_pk" INTEGER,
    "addr" TEXT DEFAULT NULL,
    "is_alloc" INTEGER DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    "inst_uuid_fk" TEXT DEFAULT NULL,
    "is_leased" INTEGER DEFAULT NULL,
    "is_reserved" INTEGER DEFAULT NULL,
    FOREIGN KEY ("inst_uuid_fk") REFERENCES "inst_rec"("uuid_val")
);

CREATE TABLE "fixip_cts_q_low" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "fixip_cts_q" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "fixip_cts_q_high" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "fixip_addr_netinfo" (
    "id_pk" INTEGER,
    "addr" TEXT DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    "inst_uuid_fk" TEXT DEFAULT NULL,
    "net_id_fk" INTEGER DEFAULT NULL,
    "is_reserved" INTEGER DEFAULT NULL,
    "vif_id_fk" INTEGER DEFAULT NULL,
    FOREIGN KEY ("inst_uuid_fk") REFERENCES "inst_rec"("uuid_val")
);

CREATE TABLE "floatip_addr" (
    "id_pk" INTEGER,
    "addr" TEXT DEFAULT NULL,
    "auto_assgn_flg" INTEGER DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "iface_nm" TEXT DEFAULT NULL,
    "pool_nm" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "floatip_auto_cts_low" (
    "id_pk" INTEGER,
    "auto_assgn_flg" INTEGER DEFAULT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    "iface_nm" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "floatip_auto_cts" (
    "id_pk" INTEGER,
    "auto_assgn_flg" INTEGER DEFAULT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    "iface_nm" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "floatip_auto_cts_high" (
    "id_pk" INTEGER,
    "auto_assgn_flg" INTEGER DEFAULT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    "iface_nm" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "floatip_fixedlink" (
    "id_pk" INTEGER,
    "fip_id_fk" INTEGER DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL
);

CREATE TABLE "inst_act_create_only" (
    "id_pk" INTEGER,
    "act_nm" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "inst_uuid_fk" TEXT DEFAULT NULL,
    "msg" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "req_id" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "inst_act_misc_actions" (
    "id_pk" INTEGER,
    "act_nm" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "inst_uuid_fk" TEXT DEFAULT NULL,
    "msg" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "req_id" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "inst_extra_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "inst_extra_deleted" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "flavor_blob" TEXT,
    "inst_uuid_fk" TEXT NOT NULL,
    "mig_ctx" TEXT,
    "numa_topo" TEXT,
    "pci_reqs" TEXT,
    FOREIGN KEY ("inst_uuid_fk") REFERENCES "inst_rec"("uuid_val")
);

CREATE TABLE "inst_extra_flavor" (
    "id_pk" INTEGER,
    "flavor_blob" TEXT,
    "mig_ctx" TEXT,
    "numa_topo" TEXT,
    "pci_reqs" TEXT,
    "vcpu_model" TEXT
);

CREATE TABLE "inst_faults_code" (
    "id_pk" INTEGER,
    "err_code" INTEGER NOT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "details_hash" TEXT,
    "host_nm" TEXT DEFAULT NULL,
    "inst_uuid_fk" TEXT DEFAULT NULL,
    "msg" TEXT DEFAULT NULL,
    FOREIGN KEY ("inst_uuid_fk") REFERENCES "inst_rec"("uuid_val")
);

CREATE TABLE "inst_faults_dts_q_low" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "details_hash" TEXT,
    "host_nm" TEXT DEFAULT NULL,
    "msg" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "inst_faults_dts_q" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "details_hash" TEXT,
    "host_nm" TEXT DEFAULT NULL,
    "msg" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "inst_faults_dts_q_high" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "details_hash" TEXT,
    "host_nm" TEXT DEFAULT NULL,
    "msg" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "inst_grp_policy" (
    "c_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "id_pk" INTEGER,
    "policy_k" TEXT DEFAULT NULL,
    "grp_id_fk" INTEGER NOT NULL,
    FOREIGN KEY ("grp_id_fk") REFERENCES "inst_grps_deleted_alpha4"("id_pk")
);

CREATE TABLE "inst_grps_deleted_alpha4" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "nm" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL,
    "uuid_val" TEXT NOT NULL
);

CREATE TABLE "inst_grps_deleted_other" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "nm" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL,
    "uuid_val" TEXT NOT NULL
);

CREATE TABLE "inst_id_map" (
    "c_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "id_pk" INTEGER,
    "uuid_val" TEXT NOT NULL,
    "is_del" INTEGER DEFAULT NULL
);

CREATE TABLE "inst_info_cache" (
    "c_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "id_pk" INTEGER,
    "net_info" TEXT,
    "inst_uuid" TEXT NOT NULL,
    "is_del" INTEGER DEFAULT NULL
);

CREATE TABLE "inst_meta_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "inst_uuid_fk" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "meta_v" TEXT DEFAULT NULL
);

CREATE TABLE "inst_meta_deleted" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "inst_uuid_fk" TEXT DEFAULT NULL,
    "meta_k" TEXT DEFAULT NULL,
    "meta_v" TEXT DEFAULT NULL,
    FOREIGN KEY ("inst_uuid_fk") REFERENCES "inst_rec"("uuid_val")
);

CREATE TABLE "inst_sysmeta_cts_q_low" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "meta_v" TEXT DEFAULT NULL
);

CREATE TABLE "inst_sysmeta_cts_q" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "meta_v" TEXT DEFAULT NULL
);

CREATE TABLE "inst_sysmeta_cts_q_high" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "meta_v" TEXT DEFAULT NULL
);

CREATE TABLE "inst_sysmeta_deleted" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "inst_uuid_fk" TEXT NOT NULL,
    "meta_k" TEXT NOT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "meta_v" TEXT DEFAULT NULL,
    FOREIGN KEY ("inst_uuid_fk") REFERENCES "inst_rec"("uuid_val")
);

CREATE TABLE "itype_exspecs_val_default" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "itype_id" INTEGER NOT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "spec_v" TEXT DEFAULT NULL
);

CREATE TABLE "itype_exspecs_val_true" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "itype_id" INTEGER NOT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "spec_v" TEXT DEFAULT NULL
);

CREATE TABLE "itype_exspecs_val_5" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "itype_id_fk" INTEGER NOT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "spec_v" TEXT DEFAULT NULL
);

CREATE TABLE "itype_exspecs_mixed_vals" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "itype_id" INTEGER NOT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "spec_v" TEXT DEFAULT NULL
);

CREATE TABLE "itype_exspecs_other_vals" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "itype_id_fk" INTEGER NOT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "spec_v" TEXT DEFAULT NULL
);

CREATE TABLE "itype_exspecs_deleted" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "itype_id" INTEGER NOT NULL,
    "spec_k" TEXT DEFAULT NULL,
    "spec_v" TEXT DEFAULT NULL
);

CREATE TABLE "itypes_deleted_membig" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "is_disabled" INTEGER DEFAULT NULL,
    "flavorid" TEXT DEFAULT NULL,
    "is_public_flg" INTEGER DEFAULT NULL,
    "mem_mb" INTEGER NOT NULL,
    "nm" TEXT DEFAULT NULL,
    "rxtx_fac" REAL DEFAULT NULL,
    "vcpu_wt" INTEGER DEFAULT NULL,
    "vcpus" INTEGER NOT NULL
);

CREATE TABLE "itypes_ephemeral" (
    "id_pk" INTEGER,
    "ephemeral_gb" INTEGER DEFAULT NULL,
    "flavorid" TEXT DEFAULT NULL,
    "mem_mb" INTEGER NOT NULL,
    "nm" TEXT DEFAULT NULL,
    "root_gb" INTEGER DEFAULT NULL,
    "rxtx_fac" REAL DEFAULT NULL,
    "swap_mb" INTEGER NOT NULL,
    "vcpu_wt" INTEGER DEFAULT NULL,
    "vcpus" INTEGER NOT NULL
);

CREATE TABLE "inst_access_netinfo" (
    "id_pk" INTEGER,
    "acc_ip_v4" TEXT DEFAULT NULL,
    "acc_ip_v6" TEXT DEFAULT NULL,
    "arch_nm" TEXT DEFAULT NULL,
    "auto_disk_cfg" INTEGER DEFAULT NULL,
    "az_nm" TEXT DEFAULT NULL,
    "is_cleaned" INTEGER DEFAULT NULL,
    "cfg_drive" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "dis_term_flg" INTEGER DEFAULT NULL,
    "disp_desc" TEXT DEFAULT NULL,
    "ephem_key_uuid" TEXT DEFAULT NULL,
    "kernel_id" TEXT DEFAULT NULL,
    "key_data" TEXT,
    "key_nm" TEXT DEFAULT NULL,
    "launch_idx" INTEGER DEFAULT NULL,
    "is_locked" INTEGER DEFAULT NULL,
    "locked_by" TEXT DEFAULT NULL,
    "os_nm" TEXT DEFAULT NULL,
    "power_state" INTEGER DEFAULT NULL,
    "progress_pct" INTEGER DEFAULT NULL,
    "shut_term_flg" INTEGER DEFAULT NULL,
    "task_state" TEXT DEFAULT NULL,
    "user_data" TEXT,
    "vcpus" INTEGER DEFAULT NULL,
    "vm_mode" TEXT DEFAULT NULL,
    "vm_state" TEXT DEFAULT NULL
);

CREATE TABLE "inst_rec" (
    "id_pk" INTEGER,
    "arch_nm" TEXT DEFAULT NULL,
    "cfg_drive" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "ephem_key_uuid" TEXT DEFAULT NULL,
    "img_ref" TEXT DEFAULT NULL,
    "itype_id_fk" INTEGER DEFAULT NULL,
    "internal_id" INTEGER DEFAULT NULL,
    "kernel_id" TEXT DEFAULT NULL,
    "key_data" TEXT,
    "launch_idx" INTEGER DEFAULT NULL,
    "locked_by" TEXT DEFAULT NULL,
    "os_nm" TEXT DEFAULT NULL,
    "power_state" INTEGER DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "ramdisk_id" TEXT DEFAULT NULL,
    "resv_id" TEXT DEFAULT NULL,
    "user_data" TEXT,
    "usr_id" TEXT DEFAULT NULL,
    "uuid_val" TEXT NOT NULL,
    "vm_mode" TEXT DEFAULT NULL
);

CREATE TABLE "inv_alloc_ratio" (
    "id_pk" INTEGER,
    "alloc_ratio" REAL NOT NULL,
    "reserved_cnt" INTEGER NOT NULL,
    "resclass_id" INTEGER NOT NULL,
    "rp_id_fk" INTEGER NOT NULL,
    "step_size" INTEGER NOT NULL,
    "total_units" INTEGER NOT NULL
);

CREATE TABLE "inv_alloc_ratio_ext" (
    "id_pk" INTEGER,
    "alloc_ratio" REAL NOT NULL,
    "max_unit" INTEGER NOT NULL,
    "min_unit" INTEGER NOT NULL,
    "reserved_cnt" INTEGER NOT NULL,
    "step_size" INTEGER NOT NULL,
    "total_units" INTEGER NOT NULL
);

CREATE TABLE "kp_cts_q_low" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "nm" TEXT NOT NULL,
    "kp_type" TEXT NOT NULL DEFAULT 'ssh',
    "u_ts" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "kp_cts_q" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "nm" TEXT NOT NULL,
    "kp_type" TEXT NOT NULL DEFAULT 'ssh',
    "u_ts" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "kp_cts_q_high" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "nm" TEXT NOT NULL,
    "kp_type" TEXT NOT NULL DEFAULT 'ssh',
    "u_ts" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "kp_deleted" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "fp" TEXT DEFAULT NULL,
    "nm" TEXT NOT NULL,
    "pub_key" TEXT,
    "kp_type" TEXT NOT NULL DEFAULT 'ssh',
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "mig_version" (
    "repo_id_pk" TEXT,
    "repo_path" TEXT,
    "ver_num" INTEGER DEFAULT NULL
);

CREATE TABLE "net_bridge" (
    "id_pk" INTEGER,
    "bridge_nm" TEXT DEFAULT NULL,
    "bridge_if" TEXT DEFAULT NULL,
    "broadcast_addr" TEXT DEFAULT NULL,
    "dhcp_srv" TEXT DEFAULT NULL,
    "dns_1" TEXT DEFAULT NULL,
    "dns_2" TEXT DEFAULT NULL,
    "gw" TEXT DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    "label_k" TEXT DEFAULT NULL,
    "mtu" INTEGER DEFAULT NULL,
    "netmask" TEXT DEFAULT NULL,
    "priority" INTEGER DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "rxtx_base" INTEGER DEFAULT NULL,
    "uuid_val" TEXT DEFAULT NULL,
    "vlan_id" INTEGER DEFAULT NULL
);

CREATE TABLE "net_bridge_if" (
    "id_pk" INTEGER,
    "bridge_if" TEXT DEFAULT NULL,
    "broadcast_addr" TEXT DEFAULT NULL,
    "cidr" TEXT DEFAULT NULL,
    "cidr_v6" TEXT DEFAULT NULL,
    "dhcp_srv" TEXT DEFAULT NULL,
    "dhcp_start" TEXT DEFAULT NULL,
    "dns_1" TEXT DEFAULT NULL,
    "enable_dhcp_flg" INTEGER DEFAULT NULL,
    "gw" TEXT DEFAULT NULL,
    "gw_v6" TEXT DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    "mtu" INTEGER DEFAULT NULL,
    "netmask" TEXT DEFAULT NULL,
    "netmask_v6" TEXT DEFAULT NULL,
    "priority" INTEGER DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL
);

CREATE TABLE "networks_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "uuid_val" TEXT DEFAULT NULL
);

CREATE TABLE "networks_deleted_flags" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "enable_dhcp_flg" INTEGER DEFAULT NULL,
    "is_injected" INTEGER DEFAULT NULL,
    "multi_host_flg" INTEGER DEFAULT NULL,
    "share_addr_flg" INTEGER DEFAULT NULL
);

CREATE TABLE "net_rxtx_cfg" (
    "id_pk" INTEGER,
    "rxtx_base" INTEGER DEFAULT NULL,
    "vpn_priv_addr" TEXT DEFAULT NULL,
    "vpn_pub_addr" TEXT DEFAULT NULL,
    "vpn_pub_port" INTEGER DEFAULT NULL
);

CREATE TABLE "pci_dev_addr" (
    "id_pk" INTEGER,
    "addr" TEXT NOT NULL,
    "dev_id" TEXT DEFAULT NULL,
    "dev_type" TEXT NOT NULL,
    "extra_info" TEXT,
    "inst_uuid" TEXT DEFAULT NULL,
    "lbl" TEXT NOT NULL,
    "numa_node" INTEGER DEFAULT NULL,
    "parent_addr" TEXT DEFAULT NULL,
    "status_k" TEXT NOT NULL
);

CREATE TABLE "pci_dev_compnode_fk" (
    "id_pk" INTEGER,
    "comp_node_id_fk" INTEGER NOT NULL,
    "dev_id" TEXT DEFAULT NULL,
    "dev_type" TEXT NOT NULL,
    "extra_info" TEXT,
    "inst_uuid" TEXT DEFAULT NULL,
    "lbl" TEXT NOT NULL,
    "numa_node" INTEGER DEFAULT NULL,
    "prod_id" TEXT NOT NULL,
    "req_id" TEXT DEFAULT NULL,
    "vendor_id" TEXT NOT NULL,
    FOREIGN KEY ("comp_node_id_fk") REFERENCES "compnode_cts"("id_pk"),
    FOREIGN KEY ("comp_node_id_fk") REFERENCES "compnode_cpu_info_run0"("id_pk"),
    FOREIGN KEY ("comp_node_id_fk") REFERENCES "compnode_cpu_info_runpos"("id_pk")
);

CREATE TABLE "pci_dev_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "status_k" TEXT NOT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "prov_fw_rules" (
    "id_pk" INTEGER,
    "cidr" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "port_from" INTEGER DEFAULT NULL,
    "proto" TEXT DEFAULT NULL,
    "port_to" INTEGER DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "prov_fw_rules_cts" (
    "id_pk" INTEGER,
    "cidr" TEXT DEFAULT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "proto" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "quota_cls" (
    "id_pk" INTEGER,
    "class_nm" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "hard_lim" INTEGER DEFAULT NULL,
    "res_k" TEXT DEFAULT NULL
);

CREATE TABLE "quota_cls_cts" (
    "id_pk" INTEGER,
    "class_nm" TEXT DEFAULT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "hard_lim" INTEGER DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "quotas_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "res_k" TEXT NOT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "quotas_deleted_low" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "hard_lim" INTEGER DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "res_k" TEXT NOT NULL
);

CREATE TABLE "quotas_deleted_high" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "hard_lim" INTEGER DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "res_k" TEXT NOT NULL
);

CREATE TABLE "res_providers" (
    "id_pk" INTEGER,
    "uuid_val" TEXT NOT NULL,
    "nm" TEXT DEFAULT NULL,
    "generation" INTEGER DEFAULT NULL,
    "can_host_flg" INTEGER DEFAULT NULL
);

CREATE TABLE "s3_imgs" (
    "c_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "id_pk" INTEGER,
    "uuid_val" TEXT NOT NULL,
    "is_del" INTEGER DEFAULT NULL
);

CREATE TABLE "sg_def_rules" (
    "id_pk" INTEGER,
    "cidr" TEXT DEFAULT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "port_from" INTEGER DEFAULT NULL,
    "proto" TEXT DEFAULT NULL,
    "port_to" INTEGER DEFAULT NULL
);

CREATE TABLE "sg_def_rules_cts" (
    "id_pk" INTEGER,
    "cidr" TEXT DEFAULT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "proto" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "sg_rules" (
    "id_pk" INTEGER,
    "cidr" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "port_from" INTEGER DEFAULT NULL,
    "grp_id_fk" INTEGER DEFAULT NULL,
    "parent_grp_id" INTEGER DEFAULT NULL,
    "proto" TEXT DEFAULT NULL,
    "port_to" INTEGER DEFAULT NULL,
    FOREIGN KEY ("grp_id_fk") REFERENCES "sgs_cts"("id_pk")
);

CREATE TABLE "sg_rules_cidr_10_71_29_205" (
    "id_pk" INTEGER,
    "cidr" TEXT DEFAULT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "parent_grp_id" INTEGER DEFAULT NULL,
    "proto" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "sg_rules_cidr_specifics" (
    "id_pk" INTEGER,
    "cidr" TEXT DEFAULT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "parent_grp_id_fk" INTEGER DEFAULT NULL,
    "proto" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    FOREIGN KEY ("parent_grp_id_fk") REFERENCES "sgs_cts"("id_pk")
);

CREATE TABLE "sgs_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "desc" TEXT DEFAULT NULL,
    "nm" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "svcs_bin" (
    "id_pk" INTEGER,
    "bin_nm" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "forced_down_flg" INTEGER DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    "report_cnt" INTEGER NOT NULL,
    "topic_k" TEXT DEFAULT NULL,
    "ver_num" INTEGER DEFAULT NULL
);

CREATE TABLE "svcs_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "last_seen_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "svcs_deleted_topic_compute" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "is_disabled" INTEGER DEFAULT NULL,
    "disabled_reason" TEXT DEFAULT NULL,
    "forced_down_flg" INTEGER DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    "report_cnt" INTEGER NOT NULL,
    "topic_k" TEXT DEFAULT NULL,
    "ver_num" INTEGER DEFAULT NULL
);

CREATE TABLE "svcs_deleted_other_topics" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "is_disabled" INTEGER DEFAULT NULL,
    "disabled_reason" TEXT DEFAULT NULL,
    "forced_down_flg" INTEGER DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    "report_cnt" INTEGER NOT NULL,
    "topic_k" TEXT DEFAULT NULL,
    "ver_num" INTEGER DEFAULT NULL
);

CREATE TABLE "shdw_agt_bld_arch" (
    "id_pk" INTEGER,
    "arch_nm" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "hyp_nm" TEXT DEFAULT NULL,
    "md5_sum" TEXT DEFAULT NULL,
    "os_nm" TEXT DEFAULT NULL,
    "src_url" TEXT DEFAULT NULL,
    "ver" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_agt_bld_arch_cts" (
    "id_pk" INTEGER,
    "arch_nm" TEXT DEFAULT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "src_url" TEXT DEFAULT NULL,
    "ver" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_agg_meta" (
    "id_pk" INTEGER,
    "agg_id" INTEGER NOT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "meta_k" TEXT NOT NULL,
    "meta_v" TEXT NOT NULL
);

CREATE TABLE "shdw_agg_meta_cts" (
    "id_pk" INTEGER,
    "agg_id" INTEGER NOT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "meta_k" TEXT NOT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_aggs" (
    "c_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "id_pk" INTEGER,
    "nm" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "uuid_val" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_bdmap_boot_full" (
    "id_pk" INTEGER,
    "boot_idx" INTEGER DEFAULT NULL,
    "del_on_term" INTEGER DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "dest_type" TEXT DEFAULT NULL,
    "dev_nm" TEXT DEFAULT NULL,
    "dev_type" TEXT DEFAULT NULL,
    "disk_bus" TEXT DEFAULT NULL,
    "guest_fmt" TEXT DEFAULT NULL,
    "no_dev_flg" INTEGER DEFAULT NULL,
    "src_type" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_bdmap_conn_simple" (
    "id_pk" INTEGER,
    "conn_info" TEXT,
    "vol_id" TEXT DEFAULT NULL,
    "vol_size" INTEGER DEFAULT NULL
);

CREATE TABLE "shdw_bdmap_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_bdmap_boot_lite" (
    "id_pk" INTEGER,
    "boot_idx" INTEGER DEFAULT NULL,
    "del_on_term" INTEGER DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "dest_type" TEXT DEFAULT NULL,
    "dev_nm" TEXT DEFAULT NULL,
    "guest_fmt" TEXT DEFAULT NULL,
    "no_dev_flg" INTEGER DEFAULT NULL
);

CREATE TABLE "shdw_bdmap_img_a73c9f" (
    "id_pk" INTEGER,
    "img_id" TEXT DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "snap_id" TEXT DEFAULT NULL,
    "src_type" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_bdmap_img_some_ids" (
    "id_pk" INTEGER,
    "img_id" TEXT DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "snap_id" TEXT DEFAULT NULL,
    "src_type" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_bdmap_img_other" (
    "id_pk" INTEGER,
    "img_id" TEXT DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "snap_id" TEXT DEFAULT NULL,
    "src_type" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_bw_cache_val" (
    "id_pk" INTEGER,
    "bw_in_val" INTEGER DEFAULT NULL,
    "bw_out_val" INTEGER DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "last_ctr_in" INTEGER DEFAULT NULL,
    "last_ctr_out" INTEGER DEFAULT NULL,
    "last_ref_ts" TEXT DEFAULT NULL,
    "mac_addr" TEXT DEFAULT NULL,
    "start_ts" TEXT NOT NULL,
    "uuid_val" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_bw_cache_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "last_ref_ts" TEXT DEFAULT NULL,
    "mac_addr" TEXT DEFAULT NULL,
    "start_ts" TEXT NOT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "uuid_val" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_cells_api_cfg" (
    "id_pk" INTEGER,
    "api_url" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "is_parent_flg" INTEGER DEFAULT NULL,
    "nm" TEXT DEFAULT NULL,
    "transport_url" TEXT NOT NULL,
    "wt_offset" REAL DEFAULT NULL,
    "wt_scale" REAL DEFAULT NULL
);

CREATE TABLE "shdw_cells_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "is_parent_flg" INTEGER DEFAULT NULL,
    "nm" TEXT DEFAULT NULL,
    "transport_url" TEXT NOT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_certs_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "file_nm" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_certs_deleted" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "file_nm" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_compnode_cpu_alloc" (
    "id_pk" INTEGER,
    "cpu_alloc_ratio" REAL DEFAULT NULL,
    "cpu_info_blob" TEXT NOT NULL,
    "disk_alloc_ratio" REAL DEFAULT NULL,
    "ram_alloc_ratio" REAL DEFAULT NULL,
    "vcpus" INTEGER NOT NULL,
    "vcpus_used" INTEGER NOT NULL
);

CREATE TABLE "shdw_compnode_cpu_info" (
    "id_pk" INTEGER,
    "cpu_info_blob" TEXT NOT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "curr_workload" INTEGER DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "extra_res" TEXT,
    "host_nm" TEXT DEFAULT NULL,
    "host_ip" TEXT DEFAULT NULL,
    "metrics_blob" TEXT,
    "numa_topo" TEXT,
    "pci_stats" TEXT,
    "run_vms" INTEGER DEFAULT NULL,
    "svc_id_fk" INTEGER DEFAULT NULL,
    "stats_blob" TEXT,
    "supp_instances" TEXT,
    "u_ts" TEXT DEFAULT NULL,
    "uuid_val" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_compnode_disk_least" (
    "id_pk" INTEGER,
    "disk_avail_least" INTEGER DEFAULT NULL,
    "free_disk_gb" INTEGER DEFAULT NULL,
    "local_gb" INTEGER NOT NULL,
    "local_gb_used" INTEGER NOT NULL
);

CREATE TABLE "shdw_compnode_curr_load" (
    "id_pk" INTEGER,
    "curr_workload" INTEGER DEFAULT NULL,
    "extra_res" TEXT,
    "free_ram_mb" INTEGER DEFAULT NULL,
    "mem_mb" INTEGER NOT NULL,
    "mem_mb_used" INTEGER NOT NULL,
    "metrics_blob" TEXT,
    "numa_topo" TEXT,
    "pci_stats" TEXT,
    "run_vms" INTEGER DEFAULT NULL,
    "stats_blob" TEXT,
    "supp_instances" TEXT,
    "uuid_val" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_compnode_hostinfo" (
    "id_pk" INTEGER,
    "host_nm" TEXT DEFAULT NULL,
    "host_ip" TEXT DEFAULT NULL,
    "hyp_host_nm" TEXT DEFAULT NULL,
    "hyp_type" TEXT NOT NULL,
    "hyp_ver" INTEGER NOT NULL,
    "svc_id_fk" INTEGER DEFAULT NULL
);

CREATE TABLE "shdw_console_pool_addr" (
    "id_pk" INTEGER,
    "addr" TEXT DEFAULT NULL,
    "compute_host" TEXT DEFAULT NULL,
    "console_type" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    "pwd" TEXT DEFAULT NULL,
    "pub_host" TEXT DEFAULT NULL,
    "user_nm" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_console_pool_host" (
    "id_pk" INTEGER,
    "compute_host" TEXT DEFAULT NULL,
    "console_type" TEXT DEFAULT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "pwd" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "user_nm" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_consoles_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "pwd" TEXT DEFAULT NULL,
    "pool_id_fk" INTEGER DEFAULT NULL,
    "port_num" INTEGER DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_consoles_deleted" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "inst_nm" TEXT DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "pwd" TEXT DEFAULT NULL,
    "pool_id_fk" INTEGER DEFAULT NULL,
    "port_num" INTEGER DEFAULT NULL
);

CREATE TABLE "shdw_dns_dom_az" (
    "domain_nm" TEXT,
    "az_nm" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "scope_k" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_dns_dom_az_cts" (
    "domain_nm" TEXT,
    "az_nm" TEXT DEFAULT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "scope_k" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_fixip_addr_netinfo" (
    "id_pk" INTEGER,
    "addr" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "net_id_fk" INTEGER DEFAULT NULL,
    "is_reserved" INTEGER DEFAULT NULL,
    "vif_id_fk" INTEGER DEFAULT NULL
);

CREATE TABLE "shdw_fixip_addr_alloc" (
    "id_pk" INTEGER,
    "addr" TEXT DEFAULT NULL,
    "is_alloc" INTEGER DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "is_leased" INTEGER DEFAULT NULL,
    "is_reserved" INTEGER DEFAULT NULL
);

CREATE TABLE "shdw_fixip_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_act_create_only" (
    "id_pk" INTEGER,
    "act_nm" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "msg" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "req_id" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_act_various" (
    "id_pk" INTEGER,
    "act_nm" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "msg" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "req_id" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_act_full" (
    "id_pk" INTEGER,
    "act_nm" TEXT DEFAULT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "finish_ts" TEXT DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "msg" TEXT DEFAULT NULL,
    "req_id" TEXT DEFAULT NULL,
    "start_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_extra_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_extra_deleted" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "flavor_blob" TEXT,
    "inst_uuid" TEXT NOT NULL,
    "mig_ctx" TEXT,
    "numa_topo" TEXT,
    "pci_reqs" TEXT
);

CREATE TABLE "shdw_inst_extra_flavor" (
    "id_pk" INTEGER,
    "flavor_blob" TEXT,
    "mig_ctx" TEXT,
    "numa_topo" TEXT,
    "pci_reqs" TEXT,
    "vcpu_model" TEXT
);

CREATE TABLE "shdw_inst_faults_details_ee9f89" (
    "id_pk" INTEGER,
    "err_code" INTEGER NOT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "details_hash" TEXT,
    "host_nm" TEXT DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "msg" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_faults_details_list" (
    "id_pk" INTEGER,
    "err_code" INTEGER NOT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "details_hash" TEXT,
    "host_nm" TEXT DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "msg" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_faults_details_other" (
    "id_pk" INTEGER,
    "err_code" INTEGER NOT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "details_hash" TEXT,
    "host_nm" TEXT DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "msg" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_faults_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "details_hash" TEXT,
    "inst_uuid" TEXT DEFAULT NULL,
    "msg" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_grp_policy" (
    "c_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "id_pk" INTEGER,
    "policy_k" TEXT DEFAULT NULL,
    "grp_id" INTEGER NOT NULL
);

CREATE TABLE "shdw_inst_grps_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "nm" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "uuid_val" TEXT NOT NULL
);

CREATE TABLE "shdw_inst_grps_deleted" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "nm" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL,
    "uuid_val" TEXT NOT NULL
);

CREATE TABLE "shdw_inst_id_map" (
    "c_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "id_pk" INTEGER,
    "uuid_val" TEXT NOT NULL,
    "is_del" INTEGER DEFAULT NULL
);

CREATE TABLE "shdw_inst_info_cache" (
    "c_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "id_pk" INTEGER,
    "net_info" TEXT,
    "inst_uuid" TEXT NOT NULL,
    "is_del" INTEGER DEFAULT NULL
);

CREATE TABLE "shdw_inst_meta_cts_q_low" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "meta_v" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_meta_cts_q" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "meta_v" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_meta_cts_q_high" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "meta_v" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_meta_deleted" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "meta_k" TEXT DEFAULT NULL,
    "meta_v" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_sysmeta_cts_q_low" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "inst_uuid" TEXT NOT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "meta_v" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_sysmeta_cts_q" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "inst_uuid" TEXT NOT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "meta_v" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_sysmeta_cts_q_high" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "inst_uuid" TEXT NOT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "meta_v" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_sysmeta_deleted" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "inst_uuid" TEXT NOT NULL,
    "meta_k" TEXT NOT NULL,
    "meta_v" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_itype_exspecs_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "spec_v" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_itype_exspecs_key_overcommit" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "itype_id" INTEGER NOT NULL,
    "spec_k" TEXT DEFAULT NULL,
    "spec_v" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_itype_exspecs_key_tig" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "itype_id" INTEGER NOT NULL,
    "spec_k" TEXT DEFAULT NULL,
    "spec_v" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_itype_exspecs_key_ups_test" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "itype_id" INTEGER NOT NULL,
    "spec_k" TEXT DEFAULT NULL,
    "spec_v" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_itypes_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_itypes_deleted_flags" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "is_disabled" INTEGER DEFAULT NULL,
    "is_public_flg" INTEGER DEFAULT NULL
);

CREATE TABLE "shdw_itypes_ephemeral" (
    "id_pk" INTEGER,
    "ephemeral_gb" INTEGER DEFAULT NULL,
    "flavorid" TEXT DEFAULT NULL,
    "mem_mb" INTEGER NOT NULL,
    "nm" TEXT DEFAULT NULL,
    "root_gb" INTEGER DEFAULT NULL,
    "rxtx_fac" REAL DEFAULT NULL,
    "swap_mb" INTEGER NOT NULL,
    "vcpu_wt" INTEGER DEFAULT NULL,
    "vcpus" INTEGER NOT NULL
);

CREATE TABLE "shdw_itypes_by_flavorid" (
    "id_pk" INTEGER,
    "flavorid" TEXT DEFAULT NULL,
    "mem_mb" INTEGER NOT NULL,
    "nm" TEXT DEFAULT NULL,
    "rxtx_fac" REAL DEFAULT NULL,
    "vcpu_wt" INTEGER DEFAULT NULL,
    "vcpus" INTEGER NOT NULL
);

CREATE TABLE "shdw_inst_access_base" (
    "id_pk" INTEGER,
    "acc_ip_v4" TEXT DEFAULT NULL,
    "acc_ip_v6" TEXT DEFAULT NULL,
    "arch_nm" TEXT DEFAULT NULL,
    "auto_disk_cfg" INTEGER DEFAULT NULL,
    "az_nm" TEXT DEFAULT NULL,
    "cell_nm" TEXT DEFAULT NULL,
    "is_cleaned" INTEGER DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "dis_term_flg" INTEGER DEFAULT NULL,
    "disp_desc" TEXT DEFAULT NULL,
    "ephem_key_uuid" TEXT DEFAULT NULL,
    "key_data" TEXT,
    "key_nm" TEXT DEFAULT NULL,
    "launch_idx" INTEGER DEFAULT NULL,
    "is_locked" INTEGER DEFAULT NULL,
    "os_nm" TEXT DEFAULT NULL,
    "power_state" INTEGER DEFAULT NULL,
    "progress_pct" INTEGER DEFAULT NULL,
    "shut_term_flg" INTEGER DEFAULT NULL,
    "task_state" TEXT DEFAULT NULL,
    "user_data" TEXT,
    "vcpus" INTEGER DEFAULT NULL,
    "vm_mode" TEXT DEFAULT NULL,
    "vm_state" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_disk_cfg" (
    "id_pk" INTEGER,
    "auto_disk_cfg" INTEGER DEFAULT NULL,
    "cfg_drive" TEXT DEFAULT NULL,
    "def_ephem_dev" TEXT DEFAULT NULL,
    "def_swap_dev" TEXT DEFAULT NULL,
    "ephemeral_gb" INTEGER DEFAULT NULL,
    "mem_mb" INTEGER DEFAULT NULL,
    "root_dev_nm" TEXT DEFAULT NULL,
    "root_gb" INTEGER DEFAULT NULL,
    "shut_term_flg" INTEGER DEFAULT NULL,
    "user_data" TEXT,
    "vcpus" INTEGER DEFAULT NULL
);

CREATE TABLE "shdw_inst_access_host_empty" (
    "id_pk" INTEGER,
    "acc_ip_v4" TEXT DEFAULT NULL,
    "acc_ip_v6" TEXT DEFAULT NULL,
    "az_nm" TEXT DEFAULT NULL,
    "cell_nm" TEXT DEFAULT NULL,
    "def_swap_dev" TEXT DEFAULT NULL,
    "disp_desc" TEXT DEFAULT NULL,
    "disp_nm" TEXT DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    "host_full" TEXT DEFAULT NULL,
    "key_nm" TEXT DEFAULT NULL,
    "launch_idx" INTEGER DEFAULT NULL,
    "laun_ts" TEXT,
    "is_locked" INTEGER DEFAULT NULL,
    "locked_by" TEXT DEFAULT NULL,
    "mem_mb" INTEGER DEFAULT NULL,
    "node_nm" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_access_host_list" (
    "id_pk" INTEGER,
    "acc_ip_v4" TEXT DEFAULT NULL,
    "acc_ip_v6" TEXT DEFAULT NULL,
    "az_nm" TEXT DEFAULT NULL,
    "cell_nm" TEXT DEFAULT NULL,
    "def_swap_dev" TEXT DEFAULT NULL,
    "disp_desc" TEXT DEFAULT NULL,
    "disp_nm" TEXT DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    "host_full" TEXT DEFAULT NULL,
    "key_nm" TEXT DEFAULT NULL,
    "launch_idx" INTEGER DEFAULT NULL,
    "laun_ts" TEXT,
    "is_locked" INTEGER DEFAULT NULL,
    "locked_by" TEXT DEFAULT NULL,
    "mem_mb" INTEGER DEFAULT NULL,
    "node_nm" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_access_host_other" (
    "id_pk" INTEGER,
    "acc_ip_v4" TEXT DEFAULT NULL,
    "acc_ip_v6" TEXT DEFAULT NULL,
    "az_nm" TEXT DEFAULT NULL,
    "cell_nm" TEXT DEFAULT NULL,
    "def_swap_dev" TEXT DEFAULT NULL,
    "disp_desc" TEXT DEFAULT NULL,
    "disp_nm" TEXT DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    "host_full" TEXT DEFAULT NULL,
    "key_nm" TEXT DEFAULT NULL,
    "launch_idx" INTEGER DEFAULT NULL,
    "laun_ts" TEXT,
    "is_locked" INTEGER DEFAULT NULL,
    "locked_by" TEXT DEFAULT NULL,
    "mem_mb" INTEGER DEFAULT NULL,
    "node_nm" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "laun_ts" TEXT DEFAULT NULL,
    "sched_ts" TEXT DEFAULT NULL,
    "term_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_inst_rec" (
    "id_pk" INTEGER,
    "arch_nm" TEXT DEFAULT NULL,
    "ephem_key_uuid" TEXT DEFAULT NULL,
    "img_ref" TEXT DEFAULT NULL,
    "itype_id_fk" INTEGER DEFAULT NULL,
    "internal_id" INTEGER DEFAULT NULL,
    "kernel_id" TEXT DEFAULT NULL,
    "key_data" TEXT,
    "locked_by" TEXT DEFAULT NULL,
    "os_nm" TEXT DEFAULT NULL,
    "progress_pct" INTEGER DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "ramdisk_id" TEXT DEFAULT NULL,
    "resv_id" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL,
    "uuid_val" TEXT NOT NULL,
    "vm_mode" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_kp_cts_user_7415" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "nm" TEXT DEFAULT NULL,
    "kp_type" TEXT NOT NULL DEFAULT 'ssh',
    "u_ts" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_kp_cts_user_some" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "nm" TEXT DEFAULT NULL,
    "kp_type" TEXT NOT NULL DEFAULT 'ssh',
    "u_ts" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_kp_cts_user_two" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "nm" TEXT DEFAULT NULL,
    "kp_type" TEXT NOT NULL DEFAULT 'ssh',
    "u_ts" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_kp_cts_user_three" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "nm" TEXT DEFAULT NULL,
    "kp_type" TEXT NOT NULL DEFAULT 'ssh',
    "u_ts" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_kp_cts_user_other" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "nm" TEXT DEFAULT NULL,
    "kp_type" TEXT NOT NULL DEFAULT 'ssh',
    "u_ts" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_kp_deleted" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "fp" TEXT DEFAULT NULL,
    "nm" TEXT DEFAULT NULL,
    "pub_key" TEXT,
    "kp_type" TEXT NOT NULL DEFAULT 'ssh',
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_mig_version" (
    "repo_id_pk" TEXT,
    "repo_path" TEXT,
    "ver_num" INTEGER DEFAULT NULL
);

CREATE TABLE "shdw_migr_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "dest_compute" TEXT DEFAULT NULL,
    "dest_host" TEXT DEFAULT NULL,
    "is_hidden" INTEGER DEFAULT NULL,
    "migr_type" TEXT DEFAULT NULL,
    "src_compute" TEXT DEFAULT NULL,
    "status_k" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_migr_deleted" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "dest_compute" TEXT DEFAULT NULL,
    "dest_host" TEXT DEFAULT NULL,
    "dest_node" TEXT DEFAULT NULL,
    "is_hidden" INTEGER DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "src_compute" TEXT DEFAULT NULL,
    "src_node" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_migr_disk_progress" (
    "id_pk" INTEGER,
    "disk_done" INTEGER DEFAULT NULL,
    "disk_rem" INTEGER DEFAULT NULL,
    "disk_total" INTEGER DEFAULT NULL
);

CREATE TABLE "shdw_migr_newtype_le65" (
    "id_pk" INTEGER,
    "inst_uuid" TEXT DEFAULT NULL,
    "migr_type" TEXT DEFAULT NULL,
    "new_itype_id" INTEGER DEFAULT NULL,
    "old_itype_id" INTEGER DEFAULT NULL,
    "status_k" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_migr_newtype_66to73" (
    "id_pk" INTEGER,
    "inst_uuid" TEXT DEFAULT NULL,
    "migr_type" TEXT DEFAULT NULL,
    "new_itype_id" INTEGER DEFAULT NULL,
    "old_itype_id" INTEGER DEFAULT NULL,
    "status_k" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_migr_newtype_74to81" (
    "id_pk" INTEGER,
    "inst_uuid" TEXT DEFAULT NULL,
    "migr_type" TEXT DEFAULT NULL,
    "new_itype_id" INTEGER DEFAULT NULL,
    "old_itype_id" INTEGER DEFAULT NULL,
    "status_k" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_migr_newtype_gt81" (
    "id_pk" INTEGER,
    "inst_uuid" TEXT DEFAULT NULL,
    "migr_type" TEXT DEFAULT NULL,
    "new_itype_id" INTEGER DEFAULT NULL,
    "old_itype_id" INTEGER DEFAULT NULL,
    "status_k" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_migr_mem_progress" (
    "id_pk" INTEGER,
    "mem_done" INTEGER DEFAULT NULL,
    "mem_rem" INTEGER DEFAULT NULL,
    "mem_total" INTEGER DEFAULT NULL
);

CREATE TABLE "shdw_net_bridge" (
    "id_pk" INTEGER,
    "bridge_nm" TEXT DEFAULT NULL,
    "bridge_if" TEXT DEFAULT NULL,
    "dns_1" TEXT DEFAULT NULL,
    "dns_2" TEXT DEFAULT NULL,
    "host_nm" TEXT DEFAULT NULL,
    "label_k" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_net_bridge_vpn" (
    "id_pk" INTEGER,
    "bridge_nm" TEXT DEFAULT NULL,
    "bridge_if" TEXT DEFAULT NULL,
    "rxtx_base" INTEGER DEFAULT NULL,
    "vpn_priv_addr" TEXT DEFAULT NULL,
    "vpn_pub_addr" TEXT DEFAULT NULL,
    "vpn_pub_port" INTEGER DEFAULT NULL
);

CREATE TABLE "shdw_net_broadcast_full" (
    "id_pk" INTEGER,
    "broadcast_addr" TEXT DEFAULT NULL,
    "cidr" TEXT DEFAULT NULL,
    "cidr_v6" TEXT DEFAULT NULL,
    "gw" TEXT DEFAULT NULL,
    "gw_v6" TEXT DEFAULT NULL,
    "is_injected" INTEGER DEFAULT NULL,
    "label_k" TEXT DEFAULT NULL,
    "mtu" INTEGER DEFAULT NULL,
    "netmask" TEXT DEFAULT NULL,
    "netmask_v6" TEXT DEFAULT NULL,
    "priority" INTEGER DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "rxtx_base" INTEGER DEFAULT NULL,
    "uuid_val" TEXT DEFAULT NULL,
    "vlan_id" INTEGER DEFAULT NULL
);

CREATE TABLE "shdw_networks_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_net_broadcast_cfg" (
    "id_pk" INTEGER,
    "broadcast_addr" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "dhcp_srv" TEXT DEFAULT NULL,
    "dhcp_start" TEXT DEFAULT NULL,
    "enable_dhcp_flg" INTEGER DEFAULT NULL,
    "is_injected" INTEGER DEFAULT NULL,
    "mtu" INTEGER DEFAULT NULL,
    "multi_host_flg" INTEGER DEFAULT NULL,
    "netmask" TEXT DEFAULT NULL,
    "priority" INTEGER DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "share_addr_flg" INTEGER DEFAULT NULL,
    "uuid_val" TEXT DEFAULT NULL,
    "vlan_id" INTEGER DEFAULT NULL
);

CREATE TABLE "shdw_pci_dev_addr" (
    "id_pk" INTEGER,
    "addr" TEXT NOT NULL,
    "comp_node_id" INTEGER NOT NULL,
    "dev_id" TEXT DEFAULT NULL,
    "extra_info" TEXT,
    "inst_uuid" TEXT DEFAULT NULL,
    "lbl" TEXT NOT NULL,
    "numa_node" INTEGER DEFAULT NULL,
    "parent_addr" TEXT DEFAULT NULL,
    "prod_id" TEXT DEFAULT NULL,
    "req_id" TEXT DEFAULT NULL,
    "vendor_id" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_pci_dev_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_pci_dev_deleted" (
    "id_pk" INTEGER,
    "is_del" INTEGER NOT NULL,
    "dev_type" TEXT DEFAULT NULL,
    "extra_info" TEXT,
    "inst_uuid" TEXT DEFAULT NULL,
    "lbl" TEXT NOT NULL,
    "numa_node" INTEGER DEFAULT NULL,
    "parent_addr" TEXT DEFAULT NULL,
    "prod_id" TEXT DEFAULT NULL,
    "req_id" TEXT DEFAULT NULL,
    "status_k" TEXT NOT NULL
);

CREATE TABLE "shdw_proj_user_quota_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "hard_lim" INTEGER DEFAULT NULL,
    "res_k" TEXT NOT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "usr_id" TEXT NOT NULL
);

CREATE TABLE "shdw_proj_user_quota_deleted" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "hard_lim" INTEGER DEFAULT NULL,
    "proj_id" TEXT NOT NULL,
    "res_k" TEXT NOT NULL,
    "usr_id" TEXT NOT NULL
);

CREATE TABLE "shdw_prov_fw_rules" (
    "id_pk" INTEGER,
    "cidr" TEXT DEFAULT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "port_from" INTEGER DEFAULT NULL,
    "proto" TEXT DEFAULT NULL,
    "port_to" INTEGER DEFAULT NULL
);

CREATE TABLE "shdw_prov_fw_rules_cts" (
    "id_pk" INTEGER,
    "cidr" TEXT DEFAULT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "proto" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_quota_cls" (
    "id_pk" INTEGER,
    "class_nm" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "hard_lim" INTEGER DEFAULT NULL,
    "res_k" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_quota_cls_cts" (
    "id_pk" INTEGER,
    "class_nm" TEXT DEFAULT NULL,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "hard_lim" INTEGER DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_quota_usage_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "until_refresh" INTEGER DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_quota_usage_deleted" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "in_use" INTEGER NOT NULL,
    "reserved_cnt" INTEGER NOT NULL,
    "res_k" TEXT DEFAULT NULL,
    "until_refresh" INTEGER DEFAULT NULL
);

CREATE TABLE "shdw_quota_usage_inuse" (
    "id_pk" INTEGER,
    "in_use" INTEGER NOT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "res_k" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_quotas_cts" (
    "id_pk" INTEGER,
    "c_ts" TEXT DEFAULT NULL,
    "is_del" INTEGER DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "res_k" TEXT NOT NULL,
    "u_ts" TEXT DEFAULT NULL
);

CREATE TABLE "shdw_quotas_deleted" (
    "id_pk" INTEGER,
    "is_del" INTEGER DEFAULT NULL,
    "hard_lim" INTEGER DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "res_k" TEXT NOT NULL
);

CREATE TABLE "shdw_s3_imgs" (
    "c_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "id_pk" INTEGER,
    "uuid_val" TEXT NOT NULL,
    "is_del" INTEGER DEFAULT NULL
);

CREATE TABLE "migr_inst_newtype_le69" (
    "id_pk" INTEGER,
    "inst_uuid_fk" TEXT DEFAULT NULL,
    "migr_type" TEXT DEFAULT NULL,
    "new_itype_id" INTEGER DEFAULT NULL,
    "old_itype_id" INTEGER DEFAULT NULL,
    "status_k" TEXT DEFAULT NULL,
    FOREIGN KEY ("inst_uuid_fk") REFERENCES "inst_rec"("uuid_val")
);

CREATE TABLE "migr_inst_newtype_70to80" (
    "id_pk" INTEGER,
    "inst_uuid" TEXT DEFAULT NULL,
    "migr_type" TEXT DEFAULT NULL,
    "new_itype_id" INTEGER DEFAULT NULL,
    "old_itype_id" INTEGER DEFAULT NULL,
    "status_k" TEXT DEFAULT NULL
);

CREATE TABLE "migr_inst_newtype_81to135" (
    "id_pk" INTEGER,
    "inst_uuid" TEXT DEFAULT NULL,
    "migr_type" TEXT DEFAULT NULL,
    "new_itype_id" INTEGER DEFAULT NULL,
    "old_itype_id" INTEGER DEFAULT NULL,
    "status_k" TEXT DEFAULT NULL
);

CREATE TABLE "migr_inst_newtype_gt135" (
    "id_pk" INTEGER,
    "inst_uuid_fk" TEXT DEFAULT NULL,
    "migr_type" TEXT DEFAULT NULL,
    "new_itype_id" INTEGER DEFAULT NULL,
    "old_itype_id" INTEGER DEFAULT NULL,
    "status_k" TEXT DEFAULT NULL,
    FOREIGN KEY ("inst_uuid_fk") REFERENCES "inst_rec"("uuid_val")
);

CREATE TABLE "migr_disk_progress" (
    "id_pk" INTEGER,
    "disk_done" INTEGER DEFAULT NULL,
    "disk_rem" INTEGER DEFAULT NULL,
    "disk_total" INTEGER DEFAULT NULL,
    "mem_done" INTEGER DEFAULT NULL,
    "mem_rem" INTEGER DEFAULT NULL,
    "mem_total" INTEGER DEFAULT NULL
);

CREATE TABLE "itype_proj_deleted_range" (
    "c_ts" TEXT DEFAULT NULL,
    "u_ts" TEXT DEFAULT NULL,
    "d_ts" TEXT DEFAULT NULL,
    "id_pk" INTEGER,
    "itype_id" INTEGER NOT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "deleted_cnt" INTEGER DEFAULT NULL
);