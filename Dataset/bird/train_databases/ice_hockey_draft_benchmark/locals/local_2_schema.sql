CREATE TABLE "plyr_season_stat" (
    "elite_uid" INTEGER,
    "szn" TEXT,
    "team_nm" TEXT,
    "league_nm" TEXT,
    "game_type" TEXT,
    "gp_count" INTEGER,
    "goals" INTEGER,
    "assists" INTEGER,
    "pts" INTEGER,
    "pen_min" INTEGER,
    "plus_minus" INTEGER,
    FOREIGN KEY ("elite_uid") REFERENCES "plyr_css_r_33to81"("elite_uid"),
    FOREIGN KEY ("elite_uid") REFERENCES "plyr_css_r_82to145"("elite_uid")
);

CREATE TABLE "plyr_css_r_le32" (
    "elite_uid" INTEGER,
    "css_r" INTEGER,
    "plyr_nm" TEXT,
    "birth_loc" TEXT,
    "draft_rd" INTEGER,
    "draft_yr" INTEGER,
    "ht" INTEGER,
    "ovr_pick" INTEGER,
    "ovr_by" TEXT,
    "wt" INTEGER
);

CREATE TABLE "plyr_css_r_33to81" (
    "elite_uid" INTEGER,
    "css_r" INTEGER,
    "plyr_nm" TEXT,
    "birth_loc" TEXT,
    "draft_rd" INTEGER,
    "draft_yr" INTEGER,
    "ht" INTEGER,
    "ovr_pick" INTEGER,
    "ovr_by" TEXT,
    "wt" INTEGER
);

CREATE TABLE "plyr_css_r_82to145" (
    "elite_uid" INTEGER,
    "css_r" INTEGER,
    "plyr_nm" TEXT,
    "birth_loc" TEXT,
    "draft_rd" INTEGER,
    "draft_yr" INTEGER,
    "ht" INTEGER,
    "ovr_pick" INTEGER,
    "ovr_by" TEXT,
    "wt" INTEGER
);

CREATE TABLE "plyr_css_r_gt145_or_null" (
    "elite_uid" INTEGER,
    "css_r" INTEGER,
    "plyr_nm" TEXT,
    "birth_loc" TEXT,
    "draft_rd" INTEGER,
    "draft_yr" INTEGER,
    "ht" INTEGER,
    "ovr_pick" INTEGER,
    "ovr_by" TEXT,
    "wt" INTEGER
);

CREATE TABLE "plyr_nat_pos" (
    "elite_uid" INTEGER,
    "nat" TEXT,
    "pos_role" TEXT,
    "shot_hand" TEXT,
    "wt" INTEGER
);