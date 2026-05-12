CREATE TABLE "proj_sub_area_map" (
    "proj_unics_id" INTEGER,
    "subj_code" TEXT,
    FOREIGN KEY ("subj_code") REFERENCES "subj_area_ref"("subj_code"),
    FOREIGN KEY ("proj_unics_id") REFERENCES "proj_cordis_meta"("proj_unics_id")
);

CREATE TABLE "subj_area_ref" (
    "subj_code" TEXT,
    "area_title" TEXT,
    "area_desc" TEXT
);

CREATE TABLE "proj_cordis_meta" (
    "proj_unics_id" INTEGER,
    "cordis_ref_code" TEXT,
    "ec_call_code" TEXT,
    "ec_fund_sch" TEXT,
    "ec_max_contrib_amt" REAL,
    "ec_reference" TEXT,
    "framework_prog" TEXT,
    "proj_objective" TEXT,
    "pi_person_id" INTEGER,
    "total_cost_amt" REAL
);