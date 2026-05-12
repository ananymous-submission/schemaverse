CREATE TABLE "awd_comedy_series" (
    "awd_id" INTEGER,
    "awd_title" TEXT,
    "awd_cat" TEXT,
    "org_name" TEXT,
    "person_name" TEXT,
    "outcome" TEXT,
    "role_desc" TEXT,
    "yr" INTEGER
);

CREATE TABLE "awd_other_misc" (
    "awd_id" INTEGER,
    "awd_title" TEXT,
    "awd_cat" TEXT,
    "org_name" TEXT,
    "person_name" TEXT,
    "outcome" TEXT,
    "role_desc" TEXT,
    "yr" INTEGER
);

CREATE TABLE "ep_air_info" (
    "ep_id" TEXT,
    "air_dt" TEXT,
    "img_url" TEXT,
    "avg_rating" REAL,
    "season_no" INTEGER,
    "synopsis" TEXT,
    "ep_title" TEXT,
    "vote_cnt" INTEGER
);

CREATE TABLE "ep_keyword" (
    "ep_id" TEXT,
    "kwd_term" TEXT,
    FOREIGN KEY ("ep_id") REFERENCES "ep_air_info"("ep_id")
);