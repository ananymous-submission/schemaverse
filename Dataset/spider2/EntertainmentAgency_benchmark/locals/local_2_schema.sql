CREATE TABLE "eng_price_770_410_290" (
    "eng_id" INT DEFAULT 0,
    "agt_id" INT DEFAULT 0,
    "contr_amt" decimal(15, 2) DEFAULT 0,
    "cust_id" INT DEFAULT 0,
    "end_dt" date,
    "ent_id" INT DEFAULT 0,
    "start_dt" date,
    "start_tm" time,
    FOREIGN KEY ("agt_id") REFERENCES "agt_dir"("agt_id")
);

CREATE TABLE "eng_price_1850_1670" (
    "eng_id" INT DEFAULT 0,
    "agt_id" INT DEFAULT 0,
    "contr_amt" decimal(15, 2) DEFAULT 0,
    "cust_id" INT DEFAULT 0,
    "end_dt" date,
    "ent_id" INT DEFAULT 0,
    "start_dt" date,
    "start_tm" time
);

CREATE TABLE "eng_price_950_1550_500_650" (
    "eng_id" INT DEFAULT 0,
    "agt_id" INT DEFAULT 0,
    "contr_amt" decimal(15, 2) DEFAULT 0,
    "cust_id" INT DEFAULT 0,
    "end_dt" date,
    "ent_id" INT DEFAULT 0,
    "start_dt" date,
    "start_tm" time
);

CREATE TABLE "eng_price_other" (
    "eng_id" INT DEFAULT 0,
    "agt_id" INT DEFAULT 0,
    "contr_amt" decimal(15, 2) DEFAULT 0,
    "cust_id" INT DEFAULT 0,
    "end_dt" date,
    "ent_id" INT DEFAULT 0,
    "start_dt" date,
    "start_tm" time,
    FOREIGN KEY ("agt_id") REFERENCES "agt_dir"("agt_id")
);

CREATE TABLE "eng_contract_sched" (
    "eng_id" INT DEFAULT 0,
    "contr_amt" decimal(15, 2) DEFAULT 0,
    "end_dt" date,
    "start_dt" date,
    "start_tm" time,
    "stop_tm" time
);

CREATE TABLE "cust_mus_pref" (
    "cust_id" INT DEFAULT 0,
    "sty_id" smallint DEFAULT 0,
    "pref_seq" smallint NOT NULL
);

CREATE TABLE "cal_mon_apr" (
    "yr_no" smallint,
    "mth_no" smallint,
    "m_apr" smallint DEFAULT 0,
    "m_aug" smallint DEFAULT 0,
    "m_dec" smallint DEFAULT 0,
    "m_feb" smallint DEFAULT 0,
    "m_jan" smallint DEFAULT 0,
    "m_jul" smallint DEFAULT 0,
    "m_jun" smallint DEFAULT 0,
    "m_mar" smallint DEFAULT 0,
    "m_may" smallint DEFAULT 0,
    "mth_yr" nvarchar (15),
    "m_nov" smallint DEFAULT 0,
    "m_oct" smallint DEFAULT 0,
    "m_sep" smallint DEFAULT 0
);

CREATE TABLE "cal_mon_feb" (
    "yr_no" smallint,
    "mth_no" smallint,
    "m_feb" smallint DEFAULT 0,
    "m_jan" smallint DEFAULT 0,
    "m_mar" smallint DEFAULT 0,
    "m_may" smallint DEFAULT 0,
    "mth_end" date,
    "mth_start" date,
    "mth_yr" nvarchar (15),
    "m_oct" smallint DEFAULT 0
);

CREATE TABLE "agt_dir" (
    "agt_id" INT,
    "agt_cty" nvarchar (30),
    "agt_fname" nvarchar (25),
    "agt_lname" nvarchar (25),
    "agt_phone" nvarchar (15),
    "agt_addr" nvarchar (50),
    "agt_comm_pct" float(24) DEFAULT 0
);