CREATE TABLE "zip_area_code" (
    "zip_id" INTEGER,
    "tel_area" INTEGER,
    FOREIGN KEY ("zip_id") REFERENCES "zip_payroll_geo"("zip_id")
);

CREATE TABLE "zip_alias_block" (
    "zip_id" INTEGER,
    "alias_block" TEXT
);

CREATE TABLE "zip_county_st" (
    "zip_id" INTEGER,
    "county_nm" TEXT,
    "st_abbr" TEXT,
    FOREIGN KEY ("st_abbr") REFERENCES "st_ref"("st_abbr"),
    FOREIGN KEY ("zip_id") REFERENCES "zip_payroll_top_quart"("zip_id"),
    FOREIGN KEY ("zip_id") REFERENCES "zip_payroll_geo"("zip_id")
);

CREATE TABLE "st_ref" (
    "st_abbr" TEXT,
    "st_name" TEXT
);

CREATE TABLE "zip_payroll_top_quart" (
    "zip_id" INTEGER,
    "payroll" INTEGER,
    "pop_children" INTEGER,
    "wk_disabled" INTEGER,
    "mth_ben_all" INTEGER,
    "mth_ben_retired" INTEGER,
    "mth_ben_widowed" INTEGER,
    "parent_widow" INTEGER,
    "wk_retired" INTEGER,
    "spouse_count" INTEGER,
    "total_ben" INTEGER
);

CREATE TABLE "zip_payroll_geo" (
    "zip_id" INTEGER,
    "payroll" INTEGER,
    "msa_id" INTEGER,
    "pop_amer_ind" INTEGER,
    "payroll_annual" INTEGER,
    "pop_asian" INTEGER,
    "avg_house_val" INTEGER,
    "avg_income_hh" INTEGER,
    "pop_children" INTEGER,
    "city_name" TEXT,
    "cnty_fips" INTEGER,
    "dst_flag" TEXT,
    "div_code" TEXT,
    "elev" INTEGER,
    "emp_count" INTEGER,
    "hh_count" INTEGER,
    "land_sqmi" REAL,
    "lat" REAL,
    "lon" REAL,
    "multi_cnty_flag" TEXT,
    "org_name" TEXT,
    "pers_per_hh" REAL,
    "region_code" TEXT,
    "st_abbr" TEXT,
    "st_fips" INTEGER,
    "tz_name" TEXT,
    "area_type" TEXT,
    "water_sqmi" REAL,
    FOREIGN KEY ("msa_id") REFERENCES "msa_metro"("msa_id"),
    FOREIGN KEY ("st_abbr") REFERENCES "st_ref"("st_abbr")
);

CREATE TABLE "msa_metro" (
    "msa_id" INTEGER,
    "msa_name" TEXT,
    "msa_kind" TEXT
);

CREATE TABLE "cong_rep_dst_le3" (
    "rep_id" TEXT,
    "cid_id" TEXT,
    "dist_num" INTEGER,
    "chamber" TEXT,
    "st_abbr" TEXT,
    "land_sqmi" REAL,
    "party_affil" TEXT
);

CREATE TABLE "cong_rep_dst_4_6" (
    "rep_id" TEXT,
    "cid_id" TEXT,
    "dist_num" INTEGER,
    "chamber" TEXT,
    "st_abbr" TEXT,
    "land_sqmi" REAL,
    "party_affil" TEXT,
    FOREIGN KEY ("st_abbr") REFERENCES "st_ref"("st_abbr")
);

CREATE TABLE "cong_rep_dst_7_13" (
    "rep_id" TEXT,
    "cid_id" TEXT,
    "dist_num" INTEGER,
    "chamber" TEXT,
    "st_abbr" TEXT,
    "land_sqmi" REAL,
    "party_affil" TEXT
);