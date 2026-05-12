CREATE TABLE "act_log" (
    "sess_id" varchar(255),
    "usr_id" varchar(255),
    "act_name" varchar(255),
    "act_cat" varchar(255),
    "prod_txt" varchar(255),
    "amt" INTEGER,
    "evt_ts" varchar(255)
);

CREATE TABLE "usr_mst" (
    "usr_id" varchar(255),
    "usr_name" varchar(255),
    "phone_no" varchar(255)
);

CREATE TABLE "frm_err_log" (
    "err_ts" varchar(255),
    "sess_id" varchar(255),
    "frm_name" varchar(255),
    "fld_name" varchar(255),
    "err_type" varchar(255),
    "fld_val" varchar(255)
);