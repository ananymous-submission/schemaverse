-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/Spider2/spider2-lite/resource/databases/spider2-localdb/EntertainmentAgency/EntertainmentAgency.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "agents_directory" (
    "agent_id" INT,
    "city" nvarchar (30),
    "phone_number" nvarchar (15),
    "state_code" nvarchar (2),
    "street_address" nvarchar (50),
    "postal_code" nvarchar (10),
    "commission_rate" float(24) DEFAULT 0,
    "hire_date" date,
    "salary_amount" decimal(15, 2) DEFAULT 0
);

CREATE TABLE "client_records" (
    "client_id" INT,
    "name" nvarchar (25),
    "last_name" nvarchar (25),
    "street_address" nvarchar (50),
    "city" nvarchar (30),
    "state_code" nvarchar (2),
    "postal_code" nvarchar (10),
    "phone_number" nvarchar (15)
);

CREATE TABLE "entertainer_profile_location_by_date" (
    "entertainer_id" INT,
    "date_entered" date,
    "city" nvarchar (30),
    "stage_name" nvarchar (50),
    "state_code" nvarchar (2),
    "street_address" nvarchar (50),
    "website_url" nvarchar (50),
    "postal_code" nvarchar (10)
);

CREATE TABLE "entertainer_profile_contact_by_date" (
    "entertainer_id" INT,
    "date_entered" date,
    "email_address" nvarchar (50),
    "phone_number" nvarchar (15),
    "ssn" nvarchar (12),
    "stage_name" nvarchar (50),
    "street_address" nvarchar (50),
    "website_url" nvarchar (50)
);

CREATE TABLE "group_members" (
    "member_id" INT DEFAULT 0,
    "name" nvarchar (25),
    "last_name" nvarchar (25),
    "phone_number" nvarchar (15),
    "gender_code" nvarchar (2)
);

CREATE TABLE "music_genres" (
    "genre_id" smallint DEFAULT 0,
    "genre_name" nvarchar (75)
);

CREATE TABLE "reference_dates" (
    "calendar_date" date
);

CREATE TABLE "entertainer_member_associations_status_fixed" (
    "entertainer_id" INT,
    "member_id" INT DEFAULT 0,
    "membership_status" smallint DEFAULT 0,
    FOREIGN KEY ("entertainer_id") REFERENCES "entertainer_profile_contact_by_date"("entertainer_id")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "PerformerMemberAssociationsActive" (
    "PerformerReferenceId" INT,
    "AssociatedMemberId" INT DEFAULT 0,
    "ActiveFlag" smallint DEFAULT 0
);

CREATE TABLE "SkippedLabelRegistry" (
    "SkippedLabelCount" INT
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "performerStyleAssignments" (
    "performerId" INT,
    "styleCategoryId" smallint DEFAULT 0,
    "styleProficiency" smallint NOT NULL
);

CREATE TABLE "calendarWeekRanges" (
    "weekPeriodStart" date,
    "weekPeriodEnd" date
);

