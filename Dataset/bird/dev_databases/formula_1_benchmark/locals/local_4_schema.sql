CREATE TABLE "drv_stand_lowpts" (
    "stand_id" INTEGER,
    "race_fk" INTEGER NOT NULL DEFAULT 0,
    "driver_fk" INTEGER NOT NULL DEFAULT 0,
    "pts" REAL NOT NULL DEFAULT 0,
    "pos" INTEGER,
    "pos_txt" TEXT,
    "wins_cnt" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("driver_fk") REFERENCES "drv_profile"("driver_id"),
    FOREIGN KEY ("race_fk") REFERENCES "races_bel_germ"("race_id")
);

CREATE TABLE "drv_stand_highpts" (
    "stand_id" INTEGER,
    "race_fk" INTEGER NOT NULL DEFAULT 0,
    "driver_fk" INTEGER NOT NULL DEFAULT 0,
    "pts" REAL NOT NULL DEFAULT 0,
    "pos" INTEGER,
    "pos_txt" TEXT,
    "wins_cnt" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("race_fk") REFERENCES "races_ita_esp_bra"("race_id")
);

CREATE TABLE "results_ctor_map" (
    "result_id" INTEGER,
    "ctor_fk" INTEGER NOT NULL DEFAULT 0,
    "driver_fk" INTEGER NOT NULL DEFAULT 0,
    "race_fk" INTEGER NOT NULL DEFAULT 0,
    "status_fk" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("status_fk") REFERENCES "race_status"("status_id"),
    FOREIGN KEY ("race_fk") REFERENCES "races_bel_germ"("race_id")
);

CREATE TABLE "res_fast_lap" (
    "result_id" INTEGER,
    "fast_lap_no" INTEGER,
    "fast_lap_speed" TEXT,
    "fast_lap_time" TEXT,
    "lap_rank" INTEGER DEFAULT 0
);

CREATE TABLE "res_grid" (
    "result_id" INTEGER,
    "grid_pos" INTEGER NOT NULL DEFAULT 0,
    "laps" INTEGER NOT NULL DEFAULT 0,
    "car_no" INTEGER,
    "pts" REAL NOT NULL DEFAULT 0,
    "pos" INTEGER,
    "pos_order" INTEGER NOT NULL DEFAULT 0,
    "pos_txt" TEXT NOT NULL DEFAULT '',
    "status_fk" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("status_fk") REFERENCES "race_status"("status_id")
);

CREATE TABLE "race_status" (
    "status_id" INTEGER,
    "status_txt" TEXT NOT NULL DEFAULT ''
);

CREATE TABLE "races_ita_esp_bra" (
    "race_id" INTEGER,
    "yr" INTEGER NOT NULL DEFAULT 0,
    "rnd" INTEGER NOT NULL DEFAULT 0,
    "circuit_fk" INTEGER NOT NULL DEFAULT 0,
    "race_name" TEXT NOT NULL DEFAULT '',
    "race_date" DATE NOT NULL DEFAULT '0000-00-00',
    "race_time" TEXT,
    "race_url" TEXT
);

CREATE TABLE "races_bel_germ" (
    "race_id" INTEGER,
    "yr" INTEGER NOT NULL DEFAULT 0,
    "rnd" INTEGER NOT NULL DEFAULT 0,
    "circuit_fk" INTEGER NOT NULL DEFAULT 0,
    "race_name" TEXT NOT NULL DEFAULT '',
    "race_date" DATE NOT NULL DEFAULT '0000-00-00',
    "race_time" TEXT,
    "race_url" TEXT
);

CREATE TABLE "races_fra_can" (
    "race_id" INTEGER,
    "yr" INTEGER NOT NULL DEFAULT 0,
    "rnd" INTEGER NOT NULL DEFAULT 0,
    "circuit_fk" INTEGER NOT NULL DEFAULT 0,
    "race_name" TEXT NOT NULL DEFAULT '',
    "race_date" DATE NOT NULL DEFAULT '0000-00-00',
    "race_time" TEXT,
    "race_url" TEXT
);

CREATE TABLE "drv_profile" (
    "driver_id" INTEGER,
    "drv_code" TEXT,
    "birth_dt" DATE,
    "drv_ref" TEXT NOT NULL DEFAULT '',
    "nation" TEXT,
    "car_no" INTEGER,
    "bio_url" TEXT NOT NULL DEFAULT ''
);