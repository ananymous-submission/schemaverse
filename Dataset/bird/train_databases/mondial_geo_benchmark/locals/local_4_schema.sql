CREATE TABLE "desert_zone" (
    "desert_name" TEXT DEFAULT '',
    "country_label" TEXT DEFAULT '',
    "prov_label" TEXT DEFAULT ''
);

CREATE TABLE "isl_named_arch" (
    "isl_label" TEXT DEFAULT '',
    "arch_name" TEXT,
    "area_km2" REAL,
    "max_ht_m" REAL,
    "isl_class" TEXT,
    "lon_deg" REAL,
    "lat_deg" REAL
);

CREATE TABLE "isl_other" (
    "isl_label" TEXT DEFAULT '',
    "arch_name" TEXT,
    "area_km2" REAL,
    "max_ht_m" REAL,
    "isl_class" TEXT,
    "lon_deg" REAL,
    "lat_deg" REAL
);

CREATE TABLE "isl_in_wtr" (
    "isl_label" TEXT,
    "sea_name" TEXT,
    "lake_name" TEXT,
    "river_name" TEXT
);

CREATE TABLE "city_on_isl" (
    "city_label" TEXT DEFAULT '',
    "prov_label" TEXT DEFAULT '',
    "country_label" TEXT DEFAULT '',
    "isl_label" TEXT DEFAULT ''
);