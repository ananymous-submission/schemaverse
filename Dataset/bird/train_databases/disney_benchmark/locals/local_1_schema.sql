CREATE TABLE "mov_info" (
    "mov_title" TEXT,
    "rel_date" TEXT,
    "lead_char" TEXT,
    "antag_char" TEXT,
    "feat_song" TEXT
);

CREATE TABLE "gross_mpaa_comedy" (
    "mov_title" TEXT,
    "rel_date" TEXT,
    "mpaa_rt" TEXT,
    "genre_cat" TEXT
);

CREATE TABLE "gross_mpaa_adventure" (
    "mov_title" TEXT,
    "rel_date" TEXT,
    "mpaa_rt" TEXT,
    "genre_cat" TEXT,
    FOREIGN KEY ("mov_title") REFERENCES "mov_info"("mov_title")
);

CREATE TABLE "gross_mpaa_drama" (
    "mov_title" TEXT,
    "rel_date" TEXT,
    "mpaa_rt" TEXT,
    "genre_cat" TEXT
);

CREATE TABLE "gross_mpaa_act_thr_rom" (
    "mov_title" TEXT,
    "rel_date" TEXT,
    "mpaa_rt" TEXT,
    "genre_cat" TEXT
);

CREATE TABLE "gross_mpaa_other_doc_mus" (
    "mov_title" TEXT,
    "rel_date" TEXT,
    "mpaa_rt" TEXT,
    "genre_cat" TEXT
);

CREATE TABLE "gross_mpaa_full" (
    "mov_title" TEXT,
    "rel_date" TEXT,
    "mpaa_rt" TEXT,
    "genre_cat" TEXT,
    "infl_adj_gross" TEXT,
    "tot_gross" TEXT,
    FOREIGN KEY ("mov_title") REFERENCES "mov_info"("mov_title")
);