CREATE TABLE "mov_dir_rel" (
    "mov_id" INTEGER,
    "dir_id" INTEGER,
    "genre_cd" TEXT NOT NULL
);

CREATE TABLE "usr_age_25" (
    "usr_id" INTEGER DEFAULT 0,
    "age_yrs" TEXT NOT NULL,
    "usr_gender" TEXT NOT NULL,
    "occ" TEXT NOT NULL
);

CREATE TABLE "usr_age_set_45_50_56_1_null" (
    "usr_id" INTEGER DEFAULT 0,
    "age_yrs" TEXT NOT NULL,
    "usr_gender" TEXT NOT NULL,
    "occ" TEXT NOT NULL
);

CREATE TABLE "mov_other_ctry" (
    "mov_id" INTEGER DEFAULT 0,
    "yr" INTEGER NOT NULL,
    "is_eng" TEXT NOT NULL,
    "ctry" TEXT NOT NULL,
    "run_mins" INTEGER NOT NULL
);

CREATE TABLE "dir_q_gt3_null" (
    "dir_id" INTEGER,
    "q_score" INTEGER NOT NULL,
    "avg_rev" INTEGER NOT NULL
);