CREATE TABLE "pwd_store" (
    "pwd_id" INTEGER,
    "usr_ref" INTEGER NOT NULL,
    "pwd_hash" TEXT NOT NULL
);

CREATE TABLE "plc_rule" (
    "plc_id" TEXT,
    "plc_kind" TEXT NOT NULL,
    "plc_payload" TEXT NOT NULL,
    "plc_meta" TEXT
);

CREATE TABLE "prj_ep_grp" (
    "ep_grp_id" TEXT,
    "prj_ref" TEXT
);