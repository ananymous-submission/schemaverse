CREATE TABLE "alloc_topo_map" (
    "tnt_id" TEXT,
    "net_id" TEXT NOT NULL,
    "rtr_id" TEXT DEFAULT NULL
);

CREATE TABLE "rtr_host_map" (
    "rtr_id" TEXT,
    "auto_sched_flag" INTEGER NOT NULL,
    "host_dev_id" TEXT DEFAULT NULL
);

CREATE TABLE "ipam_avail_ranges" (
    "alloc_pool_id" TEXT,
    "start_ip" TEXT,
    "end_ip" TEXT
);

CREATE TABLE "port_bind_lvl_drv" (
    "prt_id" TEXT,
    "host_ref" TEXT,
    "lvl" INTEGER,
    "drv_name" TEXT DEFAULT NULL
);

CREATE TABLE "port_bind_lvl_drv_seg" (
    "prt_id" TEXT,
    "host_ref" TEXT,
    "lvl" INTEGER,
    "drv_name" TEXT DEFAULT NULL,
    "seg_ref" TEXT DEFAULT NULL,
    FOREIGN KEY ("seg_ref") REFERENCES "net_seg_vlan"("seg_id")
);

CREATE TABLE "pool_mon_assoc" (
    "pool_ref" TEXT,
    "mon_id" TEXT,
    "assoc_status" TEXT NOT NULL,
    "status_desc" TEXT DEFAULT NULL,
    FOREIGN KEY ("pool_ref") REFERENCES "pool_admin_state"("pool_id")
);

CREATE TABLE "quota_usg_le1" (
    "tnt_id" TEXT,
    "res_key" TEXT,
    "dirty_flag" INTEGER NOT NULL DEFAULT '0',
    "used_cnt" INTEGER NOT NULL DEFAULT '0',
    "reserved_cnt" INTEGER NOT NULL DEFAULT '0'
);

CREATE TABLE "quota_usg_gt1_le2" (
    "tnt_id" TEXT,
    "res_key" TEXT,
    "dirty_flag" INTEGER NOT NULL DEFAULT '0',
    "used_cnt" INTEGER NOT NULL DEFAULT '0',
    "reserved_cnt" INTEGER NOT NULL DEFAULT '0'
);

CREATE TABLE "quota_usg_gt2_or_null" (
    "tnt_id" TEXT,
    "res_key" TEXT,
    "dirty_flag" INTEGER NOT NULL DEFAULT '0',
    "used_cnt" INTEGER NOT NULL DEFAULT '0',
    "reserved_cnt" INTEGER NOT NULL DEFAULT '0'
);

CREATE TABLE "host_dev_admin_state" (
    "dev_id" TEXT,
    "admin_up_flag" INTEGER NOT NULL,
    "comp_ref_id" TEXT DEFAULT NULL,
    "created_ts" TEXT NOT NULL,
    "proto_port" INTEGER DEFAULT NULL,
    "oper_status" TEXT DEFAULT NULL,
    "tnt_id" TEXT DEFAULT NULL
);

CREATE TABLE "hm_delay_cfg" (
    "hm_id" TEXT,
    "delay_sec" INTEGER NOT NULL,
    "exp_codes" TEXT DEFAULT NULL,
    "max_retry" INTEGER NOT NULL,
    "timeout_sec" INTEGER NOT NULL
);

CREATE TABLE "net_seg_vlan" (
    "seg_id" TEXT,
    "net_id" TEXT NOT NULL,
    "net_type" TEXT NOT NULL,
    "phys_net" TEXT DEFAULT NULL,
    "seg_tag" INTEGER DEFAULT NULL,
    "dyn_flag" INTEGER NOT NULL DEFAULT '0',
    "seg_idx" INTEGER NOT NULL DEFAULT '0'
);

CREATE TABLE "pool_admin_state" (
    "pool_id" TEXT,
    "admin_up_flag" INTEGER NOT NULL,
    "desc" TEXT DEFAULT NULL,
    "lb_algo" TEXT NOT NULL,
    "pool_name" TEXT DEFAULT NULL,
    "proto" TEXT NOT NULL,
    "cur_status" TEXT NOT NULL,
    "status_desc" TEXT DEFAULT NULL
);