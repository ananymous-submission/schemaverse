CREATE TABLE "cat_name_xlat" (
    "xlat_idx" INTEGER,
    "cat_label_src" TEXT,
    "cat_label_en" TEXT
);

CREATE TABLE "prod_idx_stats" (
    "prod_id" TEXT,
    "ent_idx" INTEGER,
    "cat_label" TEXT,
    "desc_len" REAL,
    "name_len" REAL,
    "photo_cnt" REAL,
    "wt_g" REAL
);

CREATE TABLE "prod_idx_dims" (
    "prod_id" TEXT,
    "ent_idx" INTEGER,
    "cat_label" TEXT,
    "ht_cm" REAL,
    "len_cm" REAL,
    "photo_cnt" REAL,
    "wt_g" REAL,
    "wdth_cm" REAL
);