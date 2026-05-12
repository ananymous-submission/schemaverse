CREATE TABLE "loc_ref" (
    "rec_idx" INTEGER,
    "loc_name" TEXT,
    "loc_id" INTEGER
);

CREATE TABLE "mv_cast_rel" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "prsn_id" TEXT,
    "ent_id" INTEGER
);

CREATE TABLE "mv_genre_gid_lte19" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "gen_id" INTEGER,
    "ent_id" INTEGER
);

CREATE TABLE "mv_genre_gid_20to46" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "gen_id" INTEGER,
    "ent_id" INTEGER
);

CREATE TABLE "mv_genre_gid_47to76" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "gen_id" INTEGER,
    "ent_id" INTEGER
);

CREATE TABLE "mv_genre_gid_gt76_or_null" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "gen_id" INTEGER,
    "ent_id" INTEGER
);

CREATE TABLE "mv_lang_rel" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "lang_id" INTEGER,
    "ent_id" INTEGER
);

CREATE TABLE "mv_loc_lid_lte35" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "loc_id" REAL,
    "ent_id" INTEGER
);

CREATE TABLE "mv_loc_lid_36to124" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "loc_id" REAL,
    "ent_id" INTEGER
);

CREATE TABLE "mv_loc_lid_125to259" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "loc_id" REAL,
    "ent_id" INTEGER
);

CREATE TABLE "mv_loc_lid_gt259_or_null" (
    "rec_idx" INTEGER,
    "mv_id" TEXT,
    "loc_id" REAL,
    "ent_id" INTEGER
);