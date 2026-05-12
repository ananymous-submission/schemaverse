CREATE TABLE "app_evt_inst_inact_lte_zero" (
    "ev_id" INTEGER,
    "app_ref" INTEGER,
    "inst_flag" INTEGER DEFAULT NULL,
    "act_score" INTEGER DEFAULT NULL
);

CREATE TABLE "lbl_cat_map" (
    "lbl_id" INTEGER,
    "cat_name" TEXT DEFAULT NULL
);

CREATE TABLE "evt_loc_ts_negvals" (
    "ev_id" INTEGER,
    "dev_id" INTEGER DEFAULT NULL,
    "ts_raw" DATETIME NOT NULL,
    "lon" REAL NOT NULL,
    "lat" REAL NOT NULL
);