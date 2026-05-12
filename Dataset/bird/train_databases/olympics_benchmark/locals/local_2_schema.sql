CREATE TABLE "comp_evt_rel" (
    "evt_id" INTEGER DEFAULT NULL,
    "comp_id" INTEGER DEFAULT NULL,
    "medal_ref" INTEGER DEFAULT NULL
);

CREATE TABLE "games_comp_under22" (
    "comp_rec_id" INTEGER,
    "games_ref" INTEGER DEFAULT NULL,
    "ath_id" INTEGER DEFAULT NULL,
    "age_yrs" INTEGER DEFAULT NULL,
    FOREIGN KEY ("ath_id") REFERENCES "person_ht_160_172"("person_id")
);

CREATE TABLE "games_comp_over29" (
    "comp_rec_id" INTEGER,
    "games_ref" INTEGER DEFAULT NULL,
    "ath_id" INTEGER DEFAULT NULL,
    "age_yrs" INTEGER DEFAULT NULL,
    FOREIGN KEY ("ath_id") REFERENCES "person_ht_173_181"("person_id")
);

CREATE TABLE "noc_region_map" (
    "noc_id" INTEGER,
    "noc_code" TEXT DEFAULT NULL,
    "region_label" TEXT DEFAULT NULL
);

CREATE TABLE "person_ht_160_172" (
    "person_id" INTEGER,
    "name_full" TEXT DEFAULT NULL,
    "gender_cd" TEXT DEFAULT NULL,
    "ht_cm" INTEGER DEFAULT NULL,
    "wt_kg" INTEGER DEFAULT NULL
);

CREATE TABLE "person_ht_173_181" (
    "person_id" INTEGER,
    "name_full" TEXT DEFAULT NULL,
    "gender_cd" TEXT DEFAULT NULL,
    "ht_cm" INTEGER DEFAULT NULL,
    "wt_kg" INTEGER DEFAULT NULL
);

CREATE TABLE "winter_games" (
    "games_id" INTEGER,
    "game_year" INTEGER DEFAULT NULL,
    "game_title" TEXT DEFAULT NULL,
    "season_type" TEXT DEFAULT NULL
);