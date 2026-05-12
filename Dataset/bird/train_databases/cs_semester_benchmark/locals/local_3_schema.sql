CREATE TABLE "stud_profile" (
    "stud_id" INTEGER,
    "fst_nm" TEXT,
    "lst_nm" TEXT,
    "ph_num" TEXT,
    "eml" TEXT,
    "iq_sc" INTEGER,
    "gpa_val" REAL,
    "stud_type" TEXT
);

CREATE TABLE "reg_mid_sat" (
    "crs_id" INTEGER,
    "stud_id" INTEGER,
    "grd" TEXT,
    "sat_mid" INTEGER
);