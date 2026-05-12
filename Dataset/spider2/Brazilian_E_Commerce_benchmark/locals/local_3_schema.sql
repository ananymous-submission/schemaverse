CREATE TABLE "ord_itm_frt_le_13_08" (
    "ord_id" TEXT,
    "ord_itm_id" BIGINT,
    "frt_val" FLOAT,
    "itm_price" FLOAT,
    "prod_id" TEXT,
    "ship_limit_dt" TEXT
);

CREATE TABLE "ord_itm_frt_gt_13_08_le_16_26" (
    "ord_id" TEXT,
    "ord_itm_id" BIGINT,
    "frt_val" FLOAT,
    "itm_price" FLOAT,
    "prod_id" TEXT,
    "ship_limit_dt" TEXT
);

CREATE TABLE "ord_itm_frt_gt_16_26_le_21_15" (
    "ord_id" TEXT,
    "ord_itm_id" BIGINT,
    "frt_val" FLOAT,
    "itm_price" FLOAT,
    "prod_id" TEXT,
    "ship_limit_dt" TEXT
);

CREATE TABLE "ord_itm_frt_gt_21_15_or_null" (
    "ord_id" TEXT,
    "ord_itm_id" BIGINT,
    "frt_val" FLOAT,
    "itm_price" FLOAT,
    "prod_id" TEXT,
    "ship_limit_dt" TEXT
);

CREATE TABLE "ord_itm_prod_slr_ship_limit" (
    "ord_id" TEXT,
    "ord_itm_id" BIGINT,
    "prod_id" TEXT,
    "slr_id" TEXT,
    "ship_limit_dt" TEXT
);

CREATE TABLE "slr_city_sao_paulo" (
    "slr_id" TEXT,
    "slr_zip_pref" BIGINT,
    "slr_city" TEXT,
    "slr_state" TEXT
);

CREATE TABLE "slr_city_curitiba_rio_santo_andre_campinas_belo_horizonte_ribeirao_preto_guarulhos_ibitinga" (
    "slr_id" TEXT,
    "slr_zip_pref" BIGINT,
    "slr_city" TEXT,
    "slr_state" TEXT
);

CREATE TABLE "slr_city_other_or_null" (
    "slr_id" TEXT,
    "slr_zip_pref" BIGINT,
    "slr_city" TEXT,
    "slr_state" TEXT
);