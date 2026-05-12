CREATE TABLE "roles_fin_pa_named_users" (
    "usr_name" TEXT DEFAULT NULL,
    "dlc_id" TEXT DEFAULT NULL
);

CREATE TABLE "roles_fin_pa_named_users_alt" (
    "usr_name" TEXT DEFAULT NULL,
    "dlc_id" TEXT DEFAULT NULL
);

CREATE TABLE "roles_fin_pa_users_other" (
    "usr_name" TEXT DEFAULT NULL,
    "dlc_id" TEXT DEFAULT NULL
);

CREATE TABLE "tld_ref" (
    "tld_key" TEXT DEFAULT NULL,
    "tld_name" TEXT DEFAULT NULL,
    "tld_desc" TEXT DEFAULT NULL,
    "wh_load_dt" TEXT DEFAULT NULL
);

CREATE TABLE "zip_us_city_type_s_only" (
    "zip_cd" TEXT DEFAULT NULL,
    "city_nm" TEXT DEFAULT NULL,
    "city_typ" TEXT DEFAULT NULL,
    "county_nm" TEXT DEFAULT NULL,
    "wh_load_dt" TEXT DEFAULT NULL,
    "zip_typ" TEXT DEFAULT NULL
);

CREATE TABLE "zip_us_city_type_pum_null" (
    "zip_cd" TEXT DEFAULT NULL,
    "city_nm" TEXT DEFAULT NULL,
    "city_typ" TEXT DEFAULT NULL,
    "county_nm" TEXT DEFAULT NULL,
    "wh_load_dt" TEXT DEFAULT NULL,
    "zip_typ" TEXT DEFAULT NULL
);

CREATE TABLE "zip_us_city_state_master" (
    "zip_cd" TEXT DEFAULT NULL,
    "city_nm" TEXT DEFAULT NULL,
    "city_typ" TEXT DEFAULT NULL,
    "county_nm" TEXT DEFAULT NULL,
    "st_abbr" TEXT DEFAULT NULL,
    "st_nm" TEXT DEFAULT NULL,
    "wh_load_dt" TEXT DEFAULT NULL
);