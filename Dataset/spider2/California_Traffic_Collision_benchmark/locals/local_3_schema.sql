CREATE TABLE "pty_fault" (
    "row_id" INTEGER,
    "fault_ind" INTEGER,
    "case_ref" REAL,
    "dir_trav" TEXT,
    "fin_resp" TEXT,
    "haz_mat" REAL,
    "mov_pre_coll" TEXT,
    "pty_age_yrs" REAL,
    "drug_phys" TEXT,
    "pty_race" TEXT,
    "pty_sex" TEXT,
    "pty_sobriety" TEXT,
    "pty_type" TEXT,
    "sch_bus_flag" REAL,
    "veh_make" TEXT,
    "veh_year" REAL
);

CREATE TABLE "case_pty_counts" (
    "row_id" INTEGER,
    "case_ref" REAL,
    "pty_seq" INTEGER,
    "pty_inj_cnt" INTEGER,
    "pty_kill_cnt" INTEGER,
    "pty_race" TEXT,
    "pty_sex" TEXT
);

CREATE TABLE "cp_inuse_airbag_not_deployed" (
    "row_id" INTEGER,
    "cp_inuse_ind" REAL,
    "cp_use_type" TEXT,
    "drug_phys" TEXT,
    "safety_equip_primary" TEXT,
    "safety_equip_secondary" TEXT
);

CREATE TABLE "cp_inuse_lap_shldr_harness" (
    "row_id" INTEGER,
    "cp_inuse_ind" REAL,
    "cp_use_type" TEXT,
    "drug_phys" TEXT,
    "safety_equip_primary" TEXT,
    "safety_equip_secondary" TEXT
);

CREATE TABLE "cp_inuse_safety_varied" (
    "row_id" INTEGER,
    "cp_inuse_ind" REAL,
    "cp_use_type" TEXT,
    "drug_phys" TEXT,
    "safety_equip_primary" TEXT,
    "safety_equip_secondary" TEXT
);

CREATE TABLE "cp_inuse_safety_other" (
    "row_id" INTEGER,
    "cp_inuse_ind" REAL,
    "cp_use_type" TEXT,
    "drug_phys" TEXT,
    "safety_equip_primary" TEXT,
    "safety_equip_secondary" TEXT
);

CREATE TABLE "pty_fault_tow" (
    "row_id" INTEGER,
    "fault_ind" INTEGER,
    "chp_veh_towed" TEXT,
    "chp_veh_towing" TEXT,
    "dir_trav" TEXT,
    "fin_resp" TEXT,
    "haz_mat" REAL,
    "mov_pre_coll" TEXT,
    "pty_type" TEXT,
    "sch_bus_flag" REAL,
    "stwide_veh_type" TEXT,
    "veh_make" TEXT,
    "veh_year" REAL
);

CREATE TABLE "oaf_viol_meta" (
    "row_id" INTEGER,
    "oaf_cat" TEXT,
    "oaf_code" TEXT,
    "oaf_sect_num" REAL,
    "oaf_suffix" TEXT,
    "other_assoc_primary" TEXT,
    "other_assoc_alternate" TEXT
);