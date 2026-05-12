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