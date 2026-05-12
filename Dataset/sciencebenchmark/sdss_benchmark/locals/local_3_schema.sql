CREATE TABLE "spc_ancil_main_tgt_hi_fbr" (
    "spc_id" NUMERIC,
    "ancil_tgt_main" INTEGER,
    "best_obj_ref" INTEGER,
    "obj_cls" TEXT,
    "fbr_id" INTEGER,
    "obs_mjd" INTEGER,
    "plt_id" NUMERIC,
    "ra_deg" REAL,
    "sg2_tgt_main" INTEGER,
    "sg2_tgt_extra" INTEGER,
    "spcl_tgt_main" INTEGER,
    "obj_subcls" TEXT,
    "vel_disp" REAL,
    "z_err" REAL
);

CREATE TABLE "spc_best_match" (
    "spc_id" NUMERIC,
    "best_obj_ref" INTEGER,
    "obj_cls" TEXT,
    "dec_deg" REAL,
    "fbr_id" INTEGER,
    "load_ver" INTEGER,
    "obs_mjd" INTEGER,
    "plt_num" INTEGER,
    "plt_id" NUMERIC,
    "prog_name" TEXT,
    "ra_deg" REAL,
    "sci_primary" INTEGER,
    "sg2_tgt_extra" INTEGER,
    "sg2_primary" INTEGER,
    "obj_subcls" TEXT,
    "survey_name" TEXT,
    "vel_disp" REAL,
    "vel_disp_err" REAL,
    "z_value" REAL,
    "z_err" REAL,
    "z_warn" INTEGER
);

CREATE TABLE "spc_spline_ref" (
    "spc_id" NUMERIC,
    FOREIGN KEY ("spc_id") REFERENCES "spc_ancil_main_tgt_hi_fbr"("spc_id")
);