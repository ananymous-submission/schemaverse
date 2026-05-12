CREATE TABLE "comm_chan" (
    "chan_id" INTEGER,
    "chan_label" VARCHAR(50),
    "chan_kind" VARCHAR(50)
);

CREATE TABLE "drv_freelance" (
    "drv_id" INTEGER,
    "drv_mode" VARCHAR(50),
    "drv_role" VARCHAR(50)
);

CREATE TABLE "drv_logop" (
    "drv_id" INTEGER,
    "drv_mode" VARCHAR(50),
    "drv_role" VARCHAR(50)
);

CREATE TABLE "dist_hub" (
    "hub_uid" INTEGER,
    "hub_label" VARCHAR(50),
    "hub_town" VARCHAR(50),
    "hub_st" CHAR(2),
    "hub_lat" DECIMAL(9, 6),
    "hub_lon" DECIMAL(9, 6)
);