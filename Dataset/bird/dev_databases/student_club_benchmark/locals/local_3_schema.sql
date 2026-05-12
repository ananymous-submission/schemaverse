CREATE TABLE "inc_txn" (
    "inc_id" TEXT,
    "rec_date" TEXT,
    "amt" INTEGER,
    "src" TEXT,
    "memo" TEXT,
    "mem_id" TEXT,
    FOREIGN KEY ("mem_id") REFERENCES "org_member"("mem_id")
);

CREATE TABLE "org_member" (
    "mem_id" TEXT,
    "fname" TEXT,
    "lname" TEXT,
    "email_addr" TEXT,
    "role" TEXT,
    "tee_sz" TEXT,
    "phone_no" TEXT,
    "zip_cd" INTEGER,
    "maj_id" TEXT,
    FOREIGN KEY ("zip_cd") REFERENCES "zip_tx_ca"("zip_cd"),
    FOREIGN KEY ("maj_id") REFERENCES "maj_plant_econ_art_soc_wild"("maj_id")
);

CREATE TABLE "zip_tx_ca" (
    "zip_cd" INTEGER,
    "zip_type" TEXT,
    "city_nm" TEXT,
    "county_nm" TEXT,
    "state_nm" TEXT,
    "st_abbr" TEXT
);

CREATE TABLE "zip_pa_va_mo" (
    "zip_cd" INTEGER,
    "zip_type" TEXT,
    "city_nm" TEXT,
    "county_nm" TEXT,
    "state_nm" TEXT,
    "st_abbr" TEXT
);

CREATE TABLE "zip_ny_il_fl_oh" (
    "zip_cd" INTEGER,
    "zip_type" TEXT,
    "city_nm" TEXT,
    "county_nm" TEXT,
    "state_nm" TEXT,
    "st_abbr" TEXT
);

CREATE TABLE "zip_other" (
    "zip_cd" INTEGER,
    "zip_type" TEXT,
    "city_nm" TEXT,
    "county_nm" TEXT,
    "state_nm" TEXT,
    "st_abbr" TEXT
);

CREATE TABLE "maj_lang_chem_env" (
    "maj_id" TEXT,
    "maj_title" TEXT,
    "dept" TEXT,
    "coll" TEXT
);

CREATE TABLE "maj_plant_econ_art_soc_wild" (
    "maj_id" TEXT,
    "maj_title" TEXT,
    "dept" TEXT,
    "coll" TEXT
);