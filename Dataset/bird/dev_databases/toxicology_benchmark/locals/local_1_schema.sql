CREATE TABLE "atm_h_only" (
    "atm_id" TEXT,
    "mol_id" TEXT DEFAULT NULL,
    "el_sym" TEXT DEFAULT NULL
);

CREATE TABLE "atm_hetero_other" (
    "atm_id" TEXT,
    "mol_id" TEXT DEFAULT NULL,
    "el_sym" TEXT DEFAULT NULL
);

CREATE TABLE "mol_label_dash" (
    "mol_id" TEXT,
    "lbl_val" TEXT DEFAULT NULL
);

CREATE TABLE "bnd_eq_sharp_null" (
    "bnd_id" TEXT,
    "mol_id" TEXT DEFAULT NULL,
    "btype" TEXT DEFAULT NULL
);