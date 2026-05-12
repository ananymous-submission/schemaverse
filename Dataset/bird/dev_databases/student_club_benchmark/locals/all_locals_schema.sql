-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/dev_databases/student_club/student_club.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "event_attendance_links" (
    "event_ref_id" TEXT,
    "participant_ref_id" TEXT,
    FOREIGN KEY ("event_ref_id") REFERENCES "events_mu_215"("event_uid"),
    FOREIGN KEY ("event_ref_id") REFERENCES "events_stadium_main_smith"("event_uid"),
    FOREIGN KEY ("event_ref_id") REFERENCES "events_washington_football_ba452_106th_maple"("event_uid")
);

CREATE TABLE "budget_remaining_bottom_quartile" (
    "budget_record_id" TEXT,
    "budget_category" TEXT,
    "amount_spent" REAL,
    "amount_remaining" REAL,
    "allocated_amount" INTEGER,
    "event_financial_state" TEXT,
    "event_ref_id" TEXT,
    FOREIGN KEY ("event_ref_id") REFERENCES "events_washington_football_ba452_106th_maple"("event_uid"),
    FOREIGN KEY ("event_ref_id") REFERENCES "events_other_or_unknown_locations"("event_uid")
);

CREATE TABLE "budget_remaining_top_quartile_or_missing" (
    "budget_record_id" TEXT,
    "budget_category" TEXT,
    "amount_spent" REAL,
    "amount_remaining" REAL,
    "allocated_amount" INTEGER,
    "event_financial_state" TEXT,
    "event_ref_id" TEXT,
    FOREIGN KEY ("event_ref_id") REFERENCES "events_mu_215"("event_uid"),
    FOREIGN KEY ("event_ref_id") REFERENCES "events_other_or_unknown_locations"("event_uid")
);

CREATE TABLE "events_mu_215" (
    "event_uid" TEXT,
    "event_title" TEXT,
    "scheduled_date" TEXT,
    "event_type" TEXT,
    "event_notes" TEXT,
    "venue" TEXT,
    "lifecycle_status" TEXT
);

CREATE TABLE "events_stadium_main_smith" (
    "event_uid" TEXT,
    "event_title" TEXT,
    "scheduled_date" TEXT,
    "event_type" TEXT,
    "event_notes" TEXT,
    "venue" TEXT,
    "lifecycle_status" TEXT
);

CREATE TABLE "events_washington_football_ba452_106th_maple" (
    "event_uid" TEXT,
    "event_title" TEXT,
    "scheduled_date" TEXT,
    "event_type" TEXT,
    "event_notes" TEXT,
    "venue" TEXT,
    "lifecycle_status" TEXT
);

CREATE TABLE "events_other_or_unknown_locations" (
    "event_uid" TEXT,
    "event_title" TEXT,
    "scheduled_date" TEXT,
    "event_type" TEXT,
    "event_notes" TEXT,
    "venue" TEXT,
    "lifecycle_status" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "expenseEntry" (
    "expenseId" TEXT,
    "description" TEXT,
    "incurredDate" TEXT,
    "costAmount" REAL,
    "approvalStatus" TEXT,
    "memberRef" TEXT,
    "budgetRefId" TEXT,
    FOREIGN KEY ("budgetRefId") REFERENCES "budgetRemainingBetween20And55"("budgetId")
);

CREATE TABLE "majorsAppliedSciences" (
    "majorId" TEXT,
    "majorName" TEXT,
    "departmentName" TEXT,
    "collegeName" TEXT
);

CREATE TABLE "majorsOtherDepartmentsOrUnknown" (
    "majorId" TEXT,
    "majorName" TEXT,
    "departmentName" TEXT,
    "collegeName" TEXT
);

CREATE TABLE "budgetRemainingBetween4And20" (
    "budgetId" TEXT,
    "budgetCategory" TEXT,
    "amountSpent" REAL,
    "remainingBalance" REAL,
    "allocatedAmount" INTEGER,
    "eventStatus" TEXT,
    "eventLink" TEXT
);

CREATE TABLE "budgetRemainingBetween20And55" (
    "budgetId" TEXT,
    "budgetCategory" TEXT,
    "amountSpent" REAL,
    "remainingBalance" REAL,
    "allocatedAmount" INTEGER,
    "eventStatus" TEXT,
    "eventLink" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "inc_txn" (
    "inc_id" TEXT,
    "rec_date" TEXT,
    "amt" INTEGER,
    "src" TEXT,
    "memo" TEXT,
    "mem_id" TEXT,
    FOREIGN KEY ("mem_id") REFERENCES "org_member"("mem_id")
);

CREATE TABLE "org_member" (
    "mem_id" TEXT,
    "fname" TEXT,
    "lname" TEXT,
    "email_addr" TEXT,
    "role" TEXT,
    "tee_sz" TEXT,
    "phone_no" TEXT,
    "zip_cd" INTEGER,
    "maj_id" TEXT,
    FOREIGN KEY ("zip_cd") REFERENCES "zip_tx_ca"("zip_cd"),
    FOREIGN KEY ("maj_id") REFERENCES "maj_plant_econ_art_soc_wild"("maj_id")
);

CREATE TABLE "zip_tx_ca" (
    "zip_cd" INTEGER,
    "zip_type" TEXT,
    "city_nm" TEXT,
    "county_nm" TEXT,
    "state_nm" TEXT,
    "st_abbr" TEXT
);

CREATE TABLE "zip_pa_va_mo" (
    "zip_cd" INTEGER,
    "zip_type" TEXT,
    "city_nm" TEXT,
    "county_nm" TEXT,
    "state_nm" TEXT,
    "st_abbr" TEXT
);

CREATE TABLE "zip_ny_il_fl_oh" (
    "zip_cd" INTEGER,
    "zip_type" TEXT,
    "city_nm" TEXT,
    "county_nm" TEXT,
    "state_nm" TEXT,
    "st_abbr" TEXT
);

CREATE TABLE "zip_other" (
    "zip_cd" INTEGER,
    "zip_type" TEXT,
    "city_nm" TEXT,
    "county_nm" TEXT,
    "state_nm" TEXT,
    "st_abbr" TEXT
);

CREATE TABLE "maj_lang_chem_env" (
    "maj_id" TEXT,
    "maj_title" TEXT,
    "dept" TEXT,
    "coll" TEXT
);

CREATE TABLE "maj_plant_econ_art_soc_wild" (
    "maj_id" TEXT,
    "maj_title" TEXT,
    "dept" TEXT,
    "coll" TEXT
);

