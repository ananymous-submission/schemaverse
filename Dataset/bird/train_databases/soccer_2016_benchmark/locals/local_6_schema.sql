CREATE TABLE "bat_style" (
    "bat_id" INTEGER,
    "bat_hand" TEXT
);

CREATE TABLE "vnu_ref" (
    "vnu_id" INTEGER,
    "vnu_name" TEXT,
    "cty_id" INTEGER
);

CREATE TABLE "mch_sched" (
    "mch_id" INTEGER,
    "mch_date" DATE,
    "sea_id" INTEGER,
    "vnu_id" INTEGER,
    FOREIGN KEY ("vnu_id") REFERENCES "vnu_ref"("vnu_id")
);