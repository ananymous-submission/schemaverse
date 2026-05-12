CREATE TABLE "gm_pub_map" (
    "pub_map_id" INTEGER,
    "gm_id" INTEGER DEFAULT NULL,
    "pub_id" INTEGER DEFAULT NULL
);

CREATE TABLE "geo_region" (
    "reg_id" INTEGER,
    "reg_name" TEXT DEFAULT NULL
);

CREATE TABLE "gm_plat_rel_2004_2007" (
    "rel_id" INTEGER,
    "pub_map_id" INTEGER DEFAULT NULL,
    "plat_id" INTEGER DEFAULT NULL,
    "rel_yr" INTEGER DEFAULT NULL,
    FOREIGN KEY ("pub_map_id") REFERENCES "gm_pub_map"("pub_map_id")
);

CREATE TABLE "gm_plat_rel_2008_2010" (
    "rel_id" INTEGER,
    "pub_map_id" INTEGER DEFAULT NULL,
    "plat_id" INTEGER DEFAULT NULL,
    "rel_yr" INTEGER DEFAULT NULL,
    FOREIGN KEY ("pub_map_id") REFERENCES "gm_pub_map"("pub_map_id")
);