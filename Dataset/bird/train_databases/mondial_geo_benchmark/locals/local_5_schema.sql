CREATE TABLE "isl_geo" (
    "isl_name" TEXT DEFAULT '',
    "isl_ctry" TEXT DEFAULT '',
    "isl_prv" TEXT DEFAULT ''
);

CREATE TABLE "lk_named_rivs" (
    "lk_name" TEXT DEFAULT '',
    "lk_area" REAL,
    "lk_max_depth" REAL,
    "lk_alt_m" REAL,
    "lk_class" TEXT,
    "lk_riv" TEXT,
    "lk_lon" REAL,
    "lk_lat" REAL
);

CREATE TABLE "loc_point" (
    "loc_city" TEXT,
    "loc_prv" TEXT,
    "loc_ctry" TEXT,
    "loc_riv" TEXT,
    "loc_lk" TEXT,
    "loc_sea" TEXT
);

CREATE TABLE "riv_lk_named" (
    "rl_name" TEXT DEFAULT '',
    "rl_lk" TEXT,
    "rl_len" REAL,
    "rl_riv" TEXT,
    "rl_sea" TEXT
);

CREATE TABLE "riv_lk_other" (
    "rl_name" TEXT DEFAULT '',
    "rl_lk" TEXT,
    "rl_len" REAL,
    "rl_riv" TEXT,
    "rl_sea" TEXT
);