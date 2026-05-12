CREATE TABLE "cty_series_notes" (
    "cty_code" TEXT,
    "ser_code" TEXT,
    "note_text" TEXT
);

CREATE TABLE "series_notes_mfg_only" (
    "ser_code" TEXT,
    "yr" TEXT,
    "note_text" TEXT
);

CREATE TABLE "series_notes_other" (
    "ser_code" TEXT,
    "yr" TEXT,
    "note_text" TEXT
);

CREATE TABLE "cty_alpha2_map" (
    "cty_code" TEXT,
    "iso2" TEXT,
    "cur_unit" TEXT,
    "name_long" TEXT,
    "name_short" TEXT,
    "src_table" TEXT,
    "wb2_code" TEXT
);

CREATE TABLE "series_gen_comments" (
    "ser_code" TEXT,
    "gen_comment" TEXT,
    "lims_ex" TEXT,
    "oth_notes" INTEGER
);