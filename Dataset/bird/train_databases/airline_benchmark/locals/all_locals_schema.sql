-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/airline/airline.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "flt_ops_rec" (
    "flt_dt" TEXT,
    "op_cr_id" INTEGER,
    "tail_id" TEXT,
    "op_fl_no" INTEGER,
    "org_air_id" INTEGER,
    "org_air_seq" INTEGER,
    "org_city_mkt" INTEGER,
    "org_cd" TEXT,
    "dest_air_id" INTEGER,
    "dest_air_seq" INTEGER,
    "dest_city_mkt" INTEGER,
    "dest_cd" TEXT,
    "sched_dep_tm" INTEGER,
    "dep_tm" INTEGER,
    "dep_dly" INTEGER,
    "dep_dly_adj" INTEGER,
    "arr_tm" INTEGER,
    "arr_dly" INTEGER,
    "arr_dly_adj" INTEGER,
    "cancel_flg" INTEGER,
    "cancel_cd" TEXT,
    "sched_elapsed" INTEGER,
    "act_elapsed" INTEGER,
    "carrier_dly" INTEGER,
    "wx_dly" INTEGER,
    "nas_dly" INTEGER,
    "sec_dly" INTEGER,
    "late_acft_dly" INTEGER
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "airline_operators" (
    "operator_id" INTEGER,
    "operator_description" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "airportDirectory" (
    "airportCode" TEXT,
    "airportDescription" TEXT
);

