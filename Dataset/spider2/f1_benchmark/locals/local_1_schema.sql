CREATE TABLE "circ_alt_core" (
    "circ_id" INT(11),
    "alt_m" INT(11) DEFAULT NULL,
    "lat_deg" FLOAT DEFAULT NULL,
    "lng_deg" FLOAT DEFAULT NULL,
    "loc" VARCHAR(255) DEFAULT NULL,
    "circ_name" VARCHAR(255) NOT NULL DEFAULT '',
    "ref_url" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "circ_alt_usa" (
    "circ_id" INT(11),
    "alt_m" INT(11) DEFAULT NULL,
    "circ_ref" VARCHAR(255) NOT NULL DEFAULT '',
    "cntry" VARCHAR(255) DEFAULT NULL,
    "loc" VARCHAR(255) DEFAULT NULL,
    "circ_name" VARCHAR(255) NOT NULL DEFAULT '',
    "ref_url" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "circ_alt_fr_it_de" (
    "circ_id" INT(11),
    "alt_m" INT(11) DEFAULT NULL,
    "circ_ref" VARCHAR(255) NOT NULL DEFAULT '',
    "cntry" VARCHAR(255) DEFAULT NULL,
    "loc" VARCHAR(255) DEFAULT NULL,
    "circ_name" VARCHAR(255) NOT NULL DEFAULT '',
    "ref_url" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "circ_alt_es_be_ca" (
    "circ_id" INT(11),
    "alt_m" INT(11) DEFAULT NULL,
    "circ_ref" VARCHAR(255) NOT NULL DEFAULT '',
    "cntry" VARCHAR(255) DEFAULT NULL,
    "loc" VARCHAR(255) DEFAULT NULL,
    "circ_name" VARCHAR(255) NOT NULL DEFAULT '',
    "ref_url" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "circ_alt_pt_uk" (
    "circ_id" INT(11),
    "alt_m" INT(11) DEFAULT NULL,
    "circ_ref" VARCHAR(255) NOT NULL DEFAULT '',
    "cntry" VARCHAR(255) DEFAULT NULL,
    "loc" VARCHAR(255) DEFAULT NULL,
    "circ_name" VARCHAR(255) NOT NULL DEFAULT '',
    "ref_url" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "circ_alt_other" (
    "circ_id" INT(11),
    "alt_m" INT(11) DEFAULT NULL,
    "circ_ref" VARCHAR(255) NOT NULL DEFAULT '',
    "cntry" VARCHAR(255) DEFAULT NULL,
    "loc" VARCHAR(255) DEFAULT NULL,
    "circ_name" VARCHAR(255) NOT NULL DEFAULT '',
    "ref_url" VARCHAR(255) NOT NULL DEFAULT ''
);

CREATE TABLE "circ_ext_dets" (
    "circ_id_ext" INT,
    "circ_ref_ext" TEXT,
    "circ_name" TEXT,
    "loc" TEXT,
    "cntry" TEXT,
    "lat_deg" REAL,
    "lng_deg" REAL,
    "alt_m" INT,
    "ref_url" TEXT,
    "last_race_yr" TEXT,
    "race_count" TEXT
);

CREATE TABLE "cons_res_cids_1_6" (
    "cons_res_id" INT(11),
    "race_ref" INT(11) NOT NULL DEFAULT '0',
    "cons_id" INT(11) NOT NULL DEFAULT '0',
    "pts" FLOAT DEFAULT NULL,
    "res_status" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "cons_res_cids_3_15_25" (
    "cons_res_id" INT(11),
    "race_ref" INT(11) NOT NULL DEFAULT '0',
    "cons_id" INT(11) NOT NULL DEFAULT '0',
    "pts" FLOAT DEFAULT NULL,
    "res_status" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "cons_res_cids_4_9_18_32" (
    "cons_res_id" INT(11),
    "race_ref" INT(11) NOT NULL DEFAULT '0',
    "cons_id" INT(11) NOT NULL DEFAULT '0',
    "pts" FLOAT DEFAULT NULL,
    "res_status" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "cons_res_other" (
    "cons_res_id" INT(11),
    "race_ref" INT(11) NOT NULL DEFAULT '0',
    "cons_id" INT(11) NOT NULL DEFAULT '0',
    "pts" FLOAT DEFAULT NULL,
    "res_status" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "lap_pos" (
    "race_ref" INT,
    "drv_id" INT,
    "lap_no" INT,
    "pos" INT,
    "lap_kind" TEXT
);

CREATE TABLE "res_ctor_map" (
    "res_id" INT(11),
    "cons_id" INT(11) NOT NULL DEFAULT '0',
    "drv_id" INT(11) NOT NULL DEFAULT '0',
    "race_ref" INT(11) NOT NULL DEFAULT '0',
    "status_ref" INT(11) NOT NULL DEFAULT '0'
);

CREATE TABLE "res_fast_lap" (
    "res_id" INT(11),
    "fl_lap_no" INT(11) DEFAULT NULL,
    "fl_speed" VARCHAR(255) DEFAULT NULL,
    "fl_time" VARCHAR(255) DEFAULT NULL,
    "fl_rank" INT(11) DEFAULT '0'
);

CREATE TABLE "res_grid_grp_0_1_3_7_10" (
    "res_id" INT(11),
    "grid_pos" INT(11) NOT NULL DEFAULT '0',
    "lap_count" INT(11) NOT NULL DEFAULT '0',
    "car_no" INT(11) DEFAULT NULL,
    "pts" FLOAT NOT NULL DEFAULT '0',
    "pos" INT(11) DEFAULT NULL,
    "pos_ord" INT(11) NOT NULL DEFAULT '0',
    "pos_txt" VARCHAR(255) NOT NULL DEFAULT '',
    "time_txt" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "res_grid_grp_4_5_9_11" (
    "res_id" INT(11),
    "grid_pos" INT(11) NOT NULL DEFAULT '0',
    "lap_count" INT(11) NOT NULL DEFAULT '0',
    "car_no" INT(11) DEFAULT NULL,
    "pts" FLOAT NOT NULL DEFAULT '0',
    "pos" INT(11) DEFAULT NULL,
    "pos_ord" INT(11) NOT NULL DEFAULT '0',
    "pos_txt" VARCHAR(255) NOT NULL DEFAULT '',
    "time_txt" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "res_grid_other" (
    "res_id" INT(11),
    "grid_pos" INT(11) NOT NULL DEFAULT '0',
    "lap_count" INT(11) NOT NULL DEFAULT '0',
    "car_no" INT(11) DEFAULT NULL,
    "pts" FLOAT NOT NULL DEFAULT '0',
    "pos" INT(11) DEFAULT NULL,
    "pos_ord" INT(11) NOT NULL DEFAULT '0',
    "pos_txt" VARCHAR(255) NOT NULL DEFAULT '',
    "time_txt" VARCHAR(255) DEFAULT NULL
);

CREATE TABLE "res_grid_full" (
    "res_id" INT(11),
    "grid_pos" INT(11) NOT NULL DEFAULT '0',
    "lap_count" INT(11) NOT NULL DEFAULT '0',
    "ms_time" INT(11) DEFAULT NULL,
    "car_no" INT(11) DEFAULT NULL,
    "pts" FLOAT NOT NULL DEFAULT '0',
    "pos_ord" INT(11) NOT NULL DEFAULT '0',
    "status_ref" INT(11) NOT NULL DEFAULT '0',
    "time_txt" VARCHAR(255) DEFAULT NULL
);