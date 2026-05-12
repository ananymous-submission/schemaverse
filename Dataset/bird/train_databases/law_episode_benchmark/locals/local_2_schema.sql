CREATE TABLE "ep_keyword" (
    "ep_id" TEXT,
    "kw" TEXT
);

CREATE TABLE "person_birth_cntry_us_ca_co_de_in_ie_gb_it_pl" (
    "person_ref" TEXT,
    "birth_cntry" TEXT,
    "birth_loc" TEXT,
    "birth_area" TEXT,
    "dob" DATE,
    "ht_m" REAL,
    "nick" TEXT
);

CREATE TABLE "person_bio_ext" (
    "person_ref" TEXT,
    "birth_cntry" TEXT,
    "name_birth" TEXT,
    "dob" DATE,
    "ht_m" REAL,
    "name_pref" TEXT,
    "nick" TEXT
);

CREATE TABLE "credit_prod_addcrew" (
    "ep_id" TEXT,
    "person_ref" TEXT,
    "cred_cat" TEXT,
    "cred_role" TEXT,
    "cred_as" TEXT
);

CREATE TABLE "credit_general_art" (
    "ep_id" TEXT,
    "person_ref" TEXT,
    "cred_cat" TEXT,
    "cred_role" TEXT,
    "cred_as" TEXT
);

CREATE TABLE "credit_cam_elec_sound_loc_mgmt_edit" (
    "ep_id" TEXT,
    "person_ref" TEXT,
    "cred_cat" TEXT,
    "cred_role" TEXT,
    "cred_as" TEXT
);

CREATE TABLE "award_ep_link" (
    "award_key" INTEGER,
    "ep_id" TEXT,
    "person_ref" TEXT,
    "award_res" TEXT,
    "award_role" TEXT,
    "tv_series" TEXT,
    "award_year" INTEGER,
    FOREIGN KEY ("person_ref") REFERENCES "person_birth_cntry_us_ca_co_de_in_ie_gb_it_pl"("person_ref")
);