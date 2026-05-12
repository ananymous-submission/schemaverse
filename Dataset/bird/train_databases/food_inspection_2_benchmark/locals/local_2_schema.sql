CREATE TABLE "estab_rest_addr" (
    "lic_no" INTEGER,
    "addr_line" TEXT,
    "alt_name" TEXT,
    "city_nm" TEXT,
    "dba_nm" TEXT,
    "fac_type" TEXT,
    "risk_lvl" INTEGER,
    "st_cd" TEXT,
    "ward_no" INTEGER,
    "zip_cd" INTEGER
);

CREATE TABLE "estab_rest_geo" (
    "lic_no" INTEGER,
    "city_nm" TEXT,
    "fac_type" TEXT,
    "lat" REAL,
    "lng" REAL,
    "risk_lvl" INTEGER,
    "ward_no" INTEGER,
    "zip_cd" INTEGER
);

CREATE TABLE "insp_20111213_20131015" (
    "insp_id" INTEGER,
    "insp_dt" DATE,
    "insp_type" TEXT,
    "insp_res" TEXT,
    "emp_id" INTEGER,
    "lic_no" INTEGER,
    "fup_to" INTEGER,
    FOREIGN KEY ("lic_no") REFERENCES "estab_rest_addr"("lic_no")
);

CREATE TABLE "insp_20131015_20150707" (
    "insp_id" INTEGER,
    "insp_dt" DATE,
    "insp_type" TEXT,
    "insp_res" TEXT,
    "emp_id" INTEGER,
    "lic_no" INTEGER,
    "fup_to" INTEGER
);