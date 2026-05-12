-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct attendance from local_1.event_attendance_links
CREATE VIEW "attendance" AS
SELECT
    "local_1"."event_attendance_links"."event_ref_id" AS "link_to_event",
    "local_1"."event_attendance_links"."participant_ref_id" AS "link_to_member"
FROM "local_1"."event_attendance_links";

-- Reconstruct budget from row partitions (UNION (overlap))
CREATE VIEW "budget" AS
SELECT "local_1"."budget_remaining_bottom_quartile"."budget_record_id" AS "budget_id", "local_1"."budget_remaining_bottom_quartile"."budget_category" AS "category", "local_1"."budget_remaining_bottom_quartile"."amount_spent" AS "spent", "local_1"."budget_remaining_bottom_quartile"."amount_remaining" AS "remaining", "local_1"."budget_remaining_bottom_quartile"."allocated_amount" AS "amount", "local_1"."budget_remaining_bottom_quartile"."event_financial_state" AS "event_status", "local_1"."budget_remaining_bottom_quartile"."event_ref_id" AS "link_to_event" FROM "local_1"."budget_remaining_bottom_quartile"
UNION
SELECT "local_1"."budget_remaining_top_quartile_or_missing"."budget_record_id" AS "budget_id", "local_1"."budget_remaining_top_quartile_or_missing"."budget_category" AS "category", "local_1"."budget_remaining_top_quartile_or_missing"."amount_spent" AS "spent", "local_1"."budget_remaining_top_quartile_or_missing"."amount_remaining" AS "remaining", "local_1"."budget_remaining_top_quartile_or_missing"."allocated_amount" AS "amount", "local_1"."budget_remaining_top_quartile_or_missing"."event_financial_state" AS "event_status", "local_1"."budget_remaining_top_quartile_or_missing"."event_ref_id" AS "link_to_event" FROM "local_1"."budget_remaining_top_quartile_or_missing"
UNION
SELECT "local_2"."budgetRemainingBetween4And20"."budgetId" AS "budget_id", "local_2"."budgetRemainingBetween4And20"."budgetCategory" AS "category", "local_2"."budgetRemainingBetween4And20"."amountSpent" AS "spent", "local_2"."budgetRemainingBetween4And20"."remainingBalance" AS "remaining", "local_2"."budgetRemainingBetween4And20"."allocatedAmount" AS "amount", "local_2"."budgetRemainingBetween4And20"."eventStatus" AS "event_status", "local_2"."budgetRemainingBetween4And20"."eventLink" AS "link_to_event" FROM "local_2"."budgetRemainingBetween4And20"
UNION
SELECT "local_2"."budgetRemainingBetween20And55"."budgetId" AS "budget_id", "local_2"."budgetRemainingBetween20And55"."budgetCategory" AS "category", "local_2"."budgetRemainingBetween20And55"."amountSpent" AS "spent", "local_2"."budgetRemainingBetween20And55"."remainingBalance" AS "remaining", "local_2"."budgetRemainingBetween20And55"."allocatedAmount" AS "amount", "local_2"."budgetRemainingBetween20And55"."eventStatus" AS "event_status", "local_2"."budgetRemainingBetween20And55"."eventLink" AS "link_to_event" FROM "local_2"."budgetRemainingBetween20And55";

-- Reconstruct event from row partitions (UNION (overlap))
CREATE VIEW "event" AS
SELECT "local_1"."events_mu_215"."event_uid" AS "event_id", "local_1"."events_mu_215"."event_title" AS "event_name", "local_1"."events_mu_215"."scheduled_date" AS "event_date", "local_1"."events_mu_215"."event_type" AS "type", "local_1"."events_mu_215"."event_notes" AS "notes", "local_1"."events_mu_215"."venue" AS "location", "local_1"."events_mu_215"."lifecycle_status" AS "status" FROM "local_1"."events_mu_215"
UNION
SELECT "local_1"."events_stadium_main_smith"."event_uid" AS "event_id", "local_1"."events_stadium_main_smith"."event_title" AS "event_name", "local_1"."events_stadium_main_smith"."scheduled_date" AS "event_date", "local_1"."events_stadium_main_smith"."event_type" AS "type", "local_1"."events_stadium_main_smith"."event_notes" AS "notes", "local_1"."events_stadium_main_smith"."venue" AS "location", "local_1"."events_stadium_main_smith"."lifecycle_status" AS "status" FROM "local_1"."events_stadium_main_smith"
UNION
SELECT "local_1"."events_washington_football_ba452_106th_maple"."event_uid" AS "event_id", "local_1"."events_washington_football_ba452_106th_maple"."event_title" AS "event_name", "local_1"."events_washington_football_ba452_106th_maple"."scheduled_date" AS "event_date", "local_1"."events_washington_football_ba452_106th_maple"."event_type" AS "type", "local_1"."events_washington_football_ba452_106th_maple"."event_notes" AS "notes", "local_1"."events_washington_football_ba452_106th_maple"."venue" AS "location", "local_1"."events_washington_football_ba452_106th_maple"."lifecycle_status" AS "status" FROM "local_1"."events_washington_football_ba452_106th_maple"
UNION
SELECT "local_1"."events_other_or_unknown_locations"."event_uid" AS "event_id", "local_1"."events_other_or_unknown_locations"."event_title" AS "event_name", "local_1"."events_other_or_unknown_locations"."scheduled_date" AS "event_date", "local_1"."events_other_or_unknown_locations"."event_type" AS "type", "local_1"."events_other_or_unknown_locations"."event_notes" AS "notes", "local_1"."events_other_or_unknown_locations"."venue" AS "location", "local_1"."events_other_or_unknown_locations"."lifecycle_status" AS "status" FROM "local_1"."events_other_or_unknown_locations";

-- Reconstruct expense from local_2.expenseEntry
CREATE VIEW "expense" AS
SELECT
    "local_2"."expenseEntry"."expenseId" AS "expense_id",
    "local_2"."expenseEntry"."description" AS "expense_description",
    "local_2"."expenseEntry"."incurredDate" AS "expense_date",
    "local_2"."expenseEntry"."costAmount" AS "cost",
    "local_2"."expenseEntry"."approvalStatus" AS "approved",
    "local_2"."expenseEntry"."memberRef" AS "link_to_member",
    "local_2"."expenseEntry"."budgetRefId" AS "link_to_budget"
FROM "local_2"."expenseEntry";

-- Reconstruct income from local_3.inc_txn
CREATE VIEW "income" AS
SELECT
    "local_3"."inc_txn"."inc_id" AS "income_id",
    "local_3"."inc_txn"."rec_date" AS "date_received",
    "local_3"."inc_txn"."amt" AS "amount",
    "local_3"."inc_txn"."src" AS "source",
    "local_3"."inc_txn"."memo" AS "notes",
    "local_3"."inc_txn"."mem_id" AS "link_to_member"
FROM "local_3"."inc_txn";

-- Reconstruct major from row partitions (UNION (overlap))
CREATE VIEW "major" AS
SELECT "local_2"."majorsAppliedSciences"."majorId" AS "major_id", "local_2"."majorsAppliedSciences"."majorName" AS "major_name", "local_2"."majorsAppliedSciences"."departmentName" AS "department", "local_2"."majorsAppliedSciences"."collegeName" AS "college" FROM "local_2"."majorsAppliedSciences"
UNION
SELECT "local_2"."majorsOtherDepartmentsOrUnknown"."majorId" AS "major_id", "local_2"."majorsOtherDepartmentsOrUnknown"."majorName" AS "major_name", "local_2"."majorsOtherDepartmentsOrUnknown"."departmentName" AS "department", "local_2"."majorsOtherDepartmentsOrUnknown"."collegeName" AS "college" FROM "local_2"."majorsOtherDepartmentsOrUnknown"
UNION
SELECT "local_3"."maj_lang_chem_env"."maj_id" AS "major_id", "local_3"."maj_lang_chem_env"."maj_title" AS "major_name", "local_3"."maj_lang_chem_env"."dept" AS "department", "local_3"."maj_lang_chem_env"."coll" AS "college" FROM "local_3"."maj_lang_chem_env"
UNION
SELECT "local_3"."maj_plant_econ_art_soc_wild"."maj_id" AS "major_id", "local_3"."maj_plant_econ_art_soc_wild"."maj_title" AS "major_name", "local_3"."maj_plant_econ_art_soc_wild"."dept" AS "department", "local_3"."maj_plant_econ_art_soc_wild"."coll" AS "college" FROM "local_3"."maj_plant_econ_art_soc_wild";

-- Reconstruct member from local_3.org_member
CREATE VIEW "member" AS
SELECT
    "local_3"."org_member"."mem_id" AS "member_id",
    "local_3"."org_member"."fname" AS "first_name",
    "local_3"."org_member"."lname" AS "last_name",
    "local_3"."org_member"."email_addr" AS "email",
    "local_3"."org_member"."role" AS "position",
    "local_3"."org_member"."tee_sz" AS "t_shirt_size",
    "local_3"."org_member"."phone_no" AS "phone",
    "local_3"."org_member"."zip_cd" AS "zip",
    "local_3"."org_member"."maj_id" AS "link_to_major"
FROM "local_3"."org_member";

-- Reconstruct zip_code from row partitions (UNION (overlap))
CREATE VIEW "zip_code" AS
SELECT "local_3"."zip_tx_ca"."zip_cd" AS "zip_code", "local_3"."zip_tx_ca"."zip_type" AS "type", "local_3"."zip_tx_ca"."city_nm" AS "city", "local_3"."zip_tx_ca"."county_nm" AS "county", "local_3"."zip_tx_ca"."state_nm" AS "state", "local_3"."zip_tx_ca"."st_abbr" AS "short_state" FROM "local_3"."zip_tx_ca"
UNION
SELECT "local_3"."zip_pa_va_mo"."zip_cd" AS "zip_code", "local_3"."zip_pa_va_mo"."zip_type" AS "type", "local_3"."zip_pa_va_mo"."city_nm" AS "city", "local_3"."zip_pa_va_mo"."county_nm" AS "county", "local_3"."zip_pa_va_mo"."state_nm" AS "state", "local_3"."zip_pa_va_mo"."st_abbr" AS "short_state" FROM "local_3"."zip_pa_va_mo"
UNION
SELECT "local_3"."zip_ny_il_fl_oh"."zip_cd" AS "zip_code", "local_3"."zip_ny_il_fl_oh"."zip_type" AS "type", "local_3"."zip_ny_il_fl_oh"."city_nm" AS "city", "local_3"."zip_ny_il_fl_oh"."county_nm" AS "county", "local_3"."zip_ny_il_fl_oh"."state_nm" AS "state", "local_3"."zip_ny_il_fl_oh"."st_abbr" AS "short_state" FROM "local_3"."zip_ny_il_fl_oh"
UNION
SELECT "local_3"."zip_other"."zip_cd" AS "zip_code", "local_3"."zip_other"."zip_type" AS "type", "local_3"."zip_other"."city_nm" AS "city", "local_3"."zip_other"."county_nm" AS "county", "local_3"."zip_other"."state_nm" AS "state", "local_3"."zip_other"."st_abbr" AS "short_state" FROM "local_3"."zip_other";
