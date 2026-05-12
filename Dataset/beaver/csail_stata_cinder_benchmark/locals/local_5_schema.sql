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