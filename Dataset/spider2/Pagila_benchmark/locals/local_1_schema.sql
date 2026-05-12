CREATE TABLE "actor_ts_155159" (
    "act_id" numeric,
    "giv_nm" VARCHAR(45) NOT NULL,
    "fam_nm" VARCHAR(45) NOT NULL,
    "upd_ts" TIMESTAMP NOT NULL
);

CREATE TABLE "actor_ts_155200_nullok" (
    "act_id" numeric,
    "giv_nm" VARCHAR(45) NOT NULL,
    "fam_nm" VARCHAR(45) NOT NULL,
    "upd_ts" TIMESTAMP NOT NULL
);

CREATE TABLE "film_act_lte_155255" (
    "act_id" INT,
    "flm_id" INT,
    "upd_ts" TIMESTAMP NOT NULL,
    FOREIGN KEY ("act_id") REFERENCES "actor_ts_155159"("act_id")
);

CREATE TABLE "film_act_gt_155255_lte_155306" (
    "act_id" INT,
    "flm_id" INT,
    "upd_ts" TIMESTAMP NOT NULL
);

CREATE TABLE "film_act_gt_155306_lte_155317" (
    "act_id" INT,
    "flm_id" INT,
    "upd_ts" TIMESTAMP NOT NULL
);

CREATE TABLE "film_act_gt_155317_nullok" (
    "act_id" INT,
    "flm_id" INT,
    "upd_ts" TIMESTAMP NOT NULL,
    FOREIGN KEY ("act_id") REFERENCES "actor_ts_155159"("act_id")
);