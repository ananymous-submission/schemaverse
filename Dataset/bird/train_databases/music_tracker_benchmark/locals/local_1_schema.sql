CREATE TABLE "tag_assoc" (
    "assoc_pk" INTEGER,
    "media_ref" INTEGER,
    "tag_lbl" TEXT
);

CREATE TABLE "media_grp_2006_2011" (
    "grp_name" TEXT,
    "snatch_cnt" INTEGER,
    "artist_name" TEXT,
    "grp_year" INTEGER,
    "rel_type" TEXT,
    "grp_key" INTEGER,
    "media_pk" INTEGER
);

CREATE TABLE "media_grp_2012_2014" (
    "grp_name" TEXT,
    "snatch_cnt" INTEGER,
    "artist_name" TEXT,
    "grp_year" INTEGER,
    "rel_type" TEXT,
    "grp_key" INTEGER,
    "media_pk" INTEGER
);