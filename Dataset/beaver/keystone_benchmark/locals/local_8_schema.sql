CREATE TABLE "pol_binding" (
    "rec_id" TEXT,
    "pol_id" TEXT NOT NULL,
    "endp_id" TEXT DEFAULT NULL,
    "svc_id" TEXT DEFAULT NULL,
    "reg_id" TEXT DEFAULT NULL
);

CREATE TABLE "trust_del_heat_role" (
    "rec_id" TEXT,
    "del_at" TEXT DEFAULT NULL,
    "exp_at" TEXT DEFAULT NULL,
    "ext_json" TEXT,
    "imp_flag" INTEGER NOT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "uses_left" INTEGER DEFAULT NULL
);

CREATE TABLE "trust_del_redeleg_zero" (
    "rec_id" TEXT,
    "del_at" TEXT DEFAULT NULL,
    "exp_at" TEXT DEFAULT NULL,
    "ext_json" TEXT,
    "imp_flag" INTEGER NOT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "uses_left" INTEGER DEFAULT NULL
);

CREATE TABLE "trust_meta" (
    "rec_id" TEXT,
    "ext_json" TEXT,
    "imp_flag" INTEGER NOT NULL,
    "proj_id" TEXT DEFAULT NULL,
    "uses_left" INTEGER DEFAULT NULL,
    "trustee_uid" TEXT NOT NULL,
    "trustor_uid" TEXT NOT NULL
);