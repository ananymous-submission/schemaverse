CREATE TABLE "obj_prop_grid" (
    "lbl" TEXT,
    "score_a" REAL,
    "score_b" REAL,
    "category" TEXT,
    "metric_a" REAL,
    "metric_b" REAL,
    "metric_c" REAL,
    "metric_d" REAL,
    "metric_e" REAL,
    "metric_f" REAL,
    "note" TEXT,
    "src_col" TEXT
);

CREATE TABLE "obj_prop_grid_ext" (
    "tag" TEXT,
    "score_a" REAL,
    "score_b" REAL,
    "category" TEXT,
    "note" TEXT,
    "src_col" TEXT,
    "src_table" TEXT
);

CREATE TABLE "dir_map" (
    "mv_id" TEXT,
    "nm_id" TEXT
);

CREATE TABLE "rtg_avg_5_to_6" (
    "mv_id" TEXT,
    "avg_rtg" REAL,
    "vote_cnt" INTEGER,
    "med_rtg" REAL
);

CREATE TABLE "rtg_avg_6_to_6_7" (
    "mv_id" TEXT,
    "avg_rtg" REAL,
    "vote_cnt" INTEGER,
    "med_rtg" REAL
);