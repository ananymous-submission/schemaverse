CREATE TABLE "brw_registry" (
    "brw_id" INTEGER,
    "brw_nm" TEXT,
    "loc_city" TEXT,
    "loc_state" TEXT
);

CREATE TABLE "beer_abv_0p05_0p056" (
    "beer_id" INTEGER,
    "brw_id_fk" INTEGER NOT NULL,
    "alc_frac" REAL,
    "ibu_val" REAL,
    "beer_nm" TEXT NOT NULL,
    "beer_style" TEXT,
    "vol_oz" REAL NOT NULL
);

CREATE TABLE "beer_abv_0p056_0p067" (
    "beer_id" INTEGER,
    "brw_id_fk" INTEGER NOT NULL,
    "alc_frac" REAL,
    "ibu_val" REAL,
    "beer_nm" TEXT NOT NULL,
    "beer_style" TEXT,
    "vol_oz" REAL NOT NULL
);