CREATE TABLE "drv_profile" (
    "drv_uid" INTEGER,
    "fname" TEXT,
    "lname" TEXT,
    "addr_line" TEXT,
    "drv_city" TEXT,
    "st_code" TEXT,
    "zip_cd" INTEGER,
    "phone_no" TEXT
);

CREATE TABLE "ship_manifest" (
    "shp_uid" INTEGER,
    "cust_uid" INTEGER,
    "shp_wt" REAL,
    "trk_uid" INTEGER,
    "drv_uid" INTEGER,
    "cty_uid" INTEGER,
    "shp_dt" TEXT,
    FOREIGN KEY ("drv_uid") REFERENCES "drv_profile"("drv_uid"),
    FOREIGN KEY ("cust_uid") REFERENCES "cust_addr_retail"("cust_uid"),
    FOREIGN KEY ("cust_uid") REFERENCES "cust_addr_wholesale"("cust_uid")
);

CREATE TABLE "city_tx_fl" (
    "cty_uid" INTEGER,
    "cty_name" TEXT,
    "st_code" TEXT,
    "pop_count" INTEGER,
    "area_sq_mi" REAL
);

CREATE TABLE "city_il_mi_ma_oh_nc_mn" (
    "cty_uid" INTEGER,
    "cty_name" TEXT,
    "st_code" TEXT,
    "pop_count" INTEGER,
    "area_sq_mi" REAL
);

CREATE TABLE "cust_addr_retail" (
    "cust_uid" INTEGER,
    "addr_line" TEXT,
    "rev_annual" INTEGER,
    "cty_name" TEXT,
    "cust_nm" TEXT,
    "cust_cat" TEXT,
    "phone_no" TEXT
);

CREATE TABLE "cust_addr_wholesale" (
    "cust_uid" INTEGER,
    "addr_line" TEXT,
    "rev_annual" INTEGER,
    "cty_name" TEXT,
    "cust_nm" TEXT,
    "cust_cat" TEXT,
    "phone_no" TEXT
);