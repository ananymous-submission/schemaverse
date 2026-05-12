CREATE TABLE "rp_agg_link" (
    "rp_id" INTEGER,
    "agg_id" INTEGER
);

CREATE TABLE "task_log_time_rec" (
    "task_log_id" INTEGER,
    "crt_ts" TEXT DEFAULT NULL,
    "is_deleted" INTEGER DEFAULT NULL,
    "del_ts" TEXT DEFAULT NULL,
    "host_name" TEXT NOT NULL,
    "msg" TEXT NOT NULL,
    "period_start" TEXT NOT NULL,
    "period_end" TEXT NOT NULL,
    "item_count" INTEGER DEFAULT NULL,
    "upd_ts" TEXT DEFAULT NULL
);

CREATE TABLE "task_log_del_rec" (
    "task_log_id" INTEGER,
    "is_deleted" INTEGER DEFAULT NULL,
    "err_count" INTEGER DEFAULT NULL,
    "host_name" TEXT NOT NULL,
    "msg" TEXT NOT NULL,
    "period_end" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "item_count" INTEGER DEFAULT NULL,
    "task_label" TEXT NOT NULL
);

CREATE TABLE "vif_addr_link" (
    "addr_id" INTEGER,
    "mac_addr" TEXT DEFAULT NULL,
    "crt_ts" TEXT DEFAULT NULL,
    "is_deleted" INTEGER DEFAULT NULL,
    "del_ts" TEXT DEFAULT NULL,
    "net_id" INTEGER DEFAULT NULL,
    "upd_ts" TEXT DEFAULT NULL
);

CREATE TABLE "vif_addr_assoc" (
    "vif_addr_id" INTEGER,
    "mac_addr" TEXT DEFAULT NULL,
    "is_deleted" INTEGER DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "net_id" INTEGER DEFAULT NULL,
    "upd_ts" TEXT DEFAULT NULL,
    "addr_uuid" TEXT DEFAULT NULL
);

CREATE TABLE "vol_map_upto_2013_10_03_22_43_33" (
    "crt_ts" TEXT DEFAULT NULL,
    "upd_ts" TEXT DEFAULT NULL,
    "del_ts" TEXT DEFAULT NULL,
    "map_id" INTEGER,
    "vol_uuid" TEXT NOT NULL,
    "is_deleted" INTEGER DEFAULT NULL
);

CREATE TABLE "vol_map_2013_10_03_22_43_33_to_2014_05_29_13_53_00" (
    "crt_ts" TEXT DEFAULT NULL,
    "upd_ts" TEXT DEFAULT NULL,
    "del_ts" TEXT DEFAULT NULL,
    "map_id" INTEGER,
    "vol_uuid" TEXT NOT NULL,
    "is_deleted" INTEGER DEFAULT NULL
);

CREATE TABLE "vol_map_2014_05_29_13_53_00_to_2014_12_08_21_45_01" (
    "crt_ts" TEXT DEFAULT NULL,
    "upd_ts" TEXT DEFAULT NULL,
    "del_ts" TEXT DEFAULT NULL,
    "map_id" INTEGER,
    "vol_uuid" TEXT NOT NULL,
    "is_deleted" INTEGER DEFAULT NULL
);

CREATE TABLE "vol_map_after_2014_12_08_21_45_01_or_null" (
    "crt_ts" TEXT DEFAULT NULL,
    "upd_ts" TEXT DEFAULT NULL,
    "del_ts" TEXT DEFAULT NULL,
    "map_id" INTEGER,
    "vol_uuid" TEXT NOT NULL,
    "is_deleted" INTEGER DEFAULT NULL
);

CREATE TABLE "vol_usage_az_snapshot" (
    "usage_id" INTEGER,
    "az" TEXT DEFAULT NULL,
    "crt_ts" TEXT DEFAULT NULL,
    "cur_last_ref" TEXT DEFAULT NULL,
    "is_deleted" INTEGER DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "tot_last_ref" TEXT DEFAULT NULL,
    "usr_id" TEXT DEFAULT NULL,
    "vol_id" TEXT NOT NULL
);

CREATE TABLE "vol_usage_az_refresh" (
    "usage_id" INTEGER,
    "az" TEXT DEFAULT NULL,
    "crt_ts" TEXT DEFAULT NULL,
    "cur_last_ref" TEXT DEFAULT NULL,
    "is_deleted" INTEGER DEFAULT NULL,
    "del_ts" TEXT DEFAULT NULL,
    "inst_uuid" TEXT DEFAULT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "tot_last_ref" TEXT DEFAULT NULL,
    "upd_ts" TEXT DEFAULT NULL,
    "vol_id" TEXT NOT NULL
);

CREATE TABLE "vol_usage_bytes_cur" (
    "usage_id" INTEGER,
    "cur_read_b" INTEGER DEFAULT NULL,
    "cur_write_b" INTEGER DEFAULT NULL,
    "tot_read_b" INTEGER DEFAULT NULL,
    "tot_write_b" INTEGER DEFAULT NULL
);

CREATE TABLE "vol_usage_ops_cur" (
    "usage_id" INTEGER,
    "cur_read_ops" INTEGER DEFAULT NULL,
    "cur_write_ops" INTEGER DEFAULT NULL,
    "tot_read_ops" INTEGER DEFAULT NULL,
    "tot_write_ops" INTEGER DEFAULT NULL
);