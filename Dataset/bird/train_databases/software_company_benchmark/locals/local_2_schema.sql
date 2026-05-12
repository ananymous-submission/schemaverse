CREATE TABLE "sls_amt_le_12_5" (
    "sale_evt_id" INTEGER,
    "mail_ref_id" INTEGER,
    "sale_evt_ts" DATETIME,
    "amt_val" REAL
);

CREATE TABLE "sls_amt_gt_17_5_or_null" (
    "sale_evt_id" INTEGER,
    "mail_ref_id" INTEGER,
    "sale_evt_ts" DATETIME,
    "amt_val" REAL
);

CREATE TABLE "mail_ref" (
    "mail_ref_id" INTEGER,
    "mail_ref_ts" DATETIME,
    "resp_text" TEXT
);