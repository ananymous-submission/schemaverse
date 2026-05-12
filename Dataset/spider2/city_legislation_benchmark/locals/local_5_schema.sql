CREATE TABLE "countries_subsaharan_africa" (
    "country_key" INTEGER,
    "country_label" TEXT,
    "iso_alpha2" TEXT,
    "iso_alpha3" TEXT,
    "macro_region" TEXT,
    "subregion_label" TEXT,
    "intermediate_area" TEXT,
    "record_created_at" TEXT
);

CREATE TABLE "countries_other_subregions" (
    "country_key" INTEGER,
    "country_label" TEXT,
    "iso_alpha2" TEXT,
    "iso_alpha3" TEXT,
    "macro_region" TEXT,
    "subregion_label" TEXT,
    "intermediate_area" TEXT,
    "record_created_at" TEXT
);

CREATE TABLE "skills_catalog" (
    "skill_key" INTEGER,
    "skill_name" TEXT,
    "skill_category" TEXT
);