CREATE TABLE "emp_terrs_emp_lte3" (
    "emp_id" INTEGER NOT NULL,
    "terr_code" TEXT NOT NULL
);

CREATE TABLE "emp_terrs_emp_gt3_lte6" (
    "emp_id" INTEGER NOT NULL,
    "terr_code" TEXT NOT NULL
);

CREATE TABLE "emp_terrs_emp_gt6_lte7" (
    "emp_id" INTEGER NOT NULL,
    "terr_code" TEXT NOT NULL
);

CREATE TABLE "emp_terrs_emp_gt7_or_null" (
    "emp_id" INTEGER NOT NULL,
    "terr_code" TEXT NOT NULL
);

CREATE TABLE "suppl_addr_view" (
    "postal_cd" TEXT,
    "addr" TEXT,
    "cty" TEXT,
    "comp_name" TEXT NOT NULL,
    "cont_name" TEXT,
    "cntry" TEXT,
    "web_url" TEXT,
    "regn" TEXT,
    "sup_id" INTEGER NOT NULL
);

CREATE TABLE "suppl_profile_comp" (
    "postal_cd" TEXT,
    "comp_name" TEXT NOT NULL,
    "cont_name" TEXT,
    "cont_title" TEXT,
    "fax_num" TEXT,
    "web_url" TEXT,
    "phone_num" TEXT,
    "regn" TEXT,
    "sup_id" INTEGER NOT NULL
);