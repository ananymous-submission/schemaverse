-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";

-- Reconstruct Agents from vertical (column) split (2 fragments)
CREATE VIEW "Agents" AS
SELECT
    t0."agent_id" AS "AgentID",
    t1."agt_fname" AS "AgtFirstName",
    t1."agt_lname" AS "AgtLastName",
    t0."street_address" AS "AgtStreetAddress",
    t0."city" AS "AgtCity",
    t0."state_code" AS "AgtState",
    t0."postal_code" AS "AgtZipCode",
    t0."phone_number" AS "AgtPhoneNumber",
    t0."hire_date" AS "DateHired",
    t0."salary_amount" AS "Salary",
    t0."commission_rate" AS "CommissionRate"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "agent_id" ORDER BY rowid) AS __rn FROM "local_1"."agents_directory") t0
JOIN "local_2"."agt_dir" t1 ON t0."agent_id" IS t1."agt_id" AND t0.__rn = t1.__rn;

-- Reconstruct Customers from local_1.client_records
CREATE VIEW "Customers" AS
SELECT
    "local_1"."client_records"."client_id" AS "CustomerID",
    "local_1"."client_records"."name" AS "CustFirstName",
    "local_1"."client_records"."last_name" AS "CustLastName",
    "local_1"."client_records"."street_address" AS "CustStreetAddress",
    "local_1"."client_records"."city" AS "CustCity",
    "local_1"."client_records"."state_code" AS "CustState",
    "local_1"."client_records"."postal_code" AS "CustZipCode",
    "local_1"."client_records"."phone_number" AS "CustPhoneNumber"
FROM "local_1"."client_records";

-- Reconstruct Engagements from vertical split + row partition on a fragment
CREATE VIEW "Engagements" AS
SELECT t0.[eng_id], t0.[start_dt], t0.[end_dt], t0.[start_tm], t1.[stop_tm], t0.[contr_amt], t0.[cust_id], t0.[agt_id], t0.[ent_id]
FROM (
SELECT [eng_price_1850_1670].[__orig_rowid] AS __orig_rowid, [local_2].[eng_price_1850_1670].[eng_id], [local_2].[eng_price_1850_1670].[start_dt], [local_2].[eng_price_1850_1670].[end_dt], [local_2].[eng_price_1850_1670].[start_tm], [local_2].[eng_price_1850_1670].[contr_amt], [local_2].[eng_price_1850_1670].[cust_id], [local_2].[eng_price_1850_1670].[agt_id], [local_2].[eng_price_1850_1670].[ent_id] FROM [local_2].[eng_price_1850_1670]
UNION
SELECT [eng_price_770_410_290].[__orig_rowid] AS __orig_rowid, [local_2].[eng_price_770_410_290].[eng_id], [local_2].[eng_price_770_410_290].[start_dt], [local_2].[eng_price_770_410_290].[end_dt], [local_2].[eng_price_770_410_290].[start_tm], [local_2].[eng_price_770_410_290].[contr_amt], [local_2].[eng_price_770_410_290].[cust_id], [local_2].[eng_price_770_410_290].[agt_id], [local_2].[eng_price_770_410_290].[ent_id] FROM [local_2].[eng_price_770_410_290]
UNION
SELECT [eng_price_950_1550_500_650].[__orig_rowid] AS __orig_rowid, [local_2].[eng_price_950_1550_500_650].[eng_id], [local_2].[eng_price_950_1550_500_650].[start_dt], [local_2].[eng_price_950_1550_500_650].[end_dt], [local_2].[eng_price_950_1550_500_650].[start_tm], [local_2].[eng_price_950_1550_500_650].[contr_amt], [local_2].[eng_price_950_1550_500_650].[cust_id], [local_2].[eng_price_950_1550_500_650].[agt_id], [local_2].[eng_price_950_1550_500_650].[ent_id] FROM [local_2].[eng_price_950_1550_500_650]
UNION
SELECT [eng_price_other].[__orig_rowid] AS __orig_rowid, [local_2].[eng_price_other].[eng_id], [local_2].[eng_price_other].[start_dt], [local_2].[eng_price_other].[end_dt], [local_2].[eng_price_other].[start_tm], [local_2].[eng_price_other].[contr_amt], [local_2].[eng_price_other].[cust_id], [local_2].[eng_price_other].[agt_id], [local_2].[eng_price_other].[ent_id] FROM [local_2].[eng_price_other]
) t0
JOIN [local_2].[eng_contract_sched] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct Entertainer_Members from row partitions (UNION (overlap))
CREATE VIEW "Entertainer_Members" AS
SELECT "local_1"."entertainer_member_associations_status_fixed"."entertainer_id" AS "EntertainerID", "local_1"."entertainer_member_associations_status_fixed"."member_id" AS "MemberID", "local_1"."entertainer_member_associations_status_fixed"."membership_status" AS "Status" FROM "local_1"."entertainer_member_associations_status_fixed"
UNION
SELECT "local_3"."PerformerMemberAssociationsActive"."PerformerReferenceId" AS "EntertainerID", "local_3"."PerformerMemberAssociationsActive"."AssociatedMemberId" AS "MemberID", "local_3"."PerformerMemberAssociationsActive"."ActiveFlag" AS "Status" FROM "local_3"."PerformerMemberAssociationsActive";

-- Reconstruct Entertainer_Styles from local_4.performerStyleAssignments
CREATE VIEW "Entertainer_Styles" AS
SELECT
    "local_4"."performerStyleAssignments"."performerId" AS "EntertainerID",
    "local_4"."performerStyleAssignments"."styleCategoryId" AS "StyleID",
    "local_4"."performerStyleAssignments"."styleProficiency" AS "StyleStrength"
FROM "local_4"."performerStyleAssignments";

-- Reconstruct Entertainers from vertical (column) split (2 fragments)
CREATE VIEW "Entertainers" AS
SELECT
    t0."entertainer_id" AS "EntertainerID",
    t0."stage_name" AS "EntStageName",
    t0."ssn" AS "EntSSN",
    t0."street_address" AS "EntStreetAddress",
    t1."city" AS "EntCity",
    t1."state_code" AS "EntState",
    t1."postal_code" AS "EntZipCode",
    t0."phone_number" AS "EntPhoneNumber",
    t0."website_url" AS "EntWebPage",
    t0."email_address" AS "EntEMailAddress",
    t0."date_entered" AS "DateEntered"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "entertainer_id" ORDER BY rowid) AS __rn FROM "local_1"."entertainer_profile_contact_by_date") t0
JOIN "local_1"."entertainer_profile_location_by_date" t1 ON t0."entertainer_id" IS t1."entertainer_id" AND t0.__rn = t1.__rn;

-- Reconstruct Members from local_1.group_members
CREATE VIEW "Members" AS
SELECT
    "local_1"."group_members"."member_id" AS "MemberID",
    "local_1"."group_members"."name" AS "MbrFirstName",
    "local_1"."group_members"."last_name" AS "MbrLastName",
    "local_1"."group_members"."phone_number" AS "MbrPhoneNumber",
    "local_1"."group_members"."gender_code" AS "Gender"
FROM "local_1"."group_members";

-- Reconstruct Musical_Preferences from local_2.cust_mus_pref
CREATE VIEW "Musical_Preferences" AS
SELECT
    "local_2"."cust_mus_pref"."cust_id" AS "CustomerID",
    "local_2"."cust_mus_pref"."sty_id" AS "StyleID",
    "local_2"."cust_mus_pref"."pref_seq" AS "PreferenceSeq"
FROM "local_2"."cust_mus_pref";

-- Reconstruct Musical_Styles from local_1.music_genres
CREATE VIEW "Musical_Styles" AS
SELECT
    "local_1"."music_genres"."genre_id" AS "StyleID",
    "local_1"."music_genres"."genre_name" AS "StyleName"
FROM "local_1"."music_genres";

-- Reconstruct ztblDays from local_1.reference_dates
CREATE VIEW "ztblDays" AS
SELECT
    "local_1"."reference_dates"."calendar_date" AS "DateField"
FROM "local_1"."reference_dates";

-- Reconstruct ztblMonths from vertical (column) split (2 fragments)
CREATE VIEW "ztblMonths" AS
SELECT
    t0."mth_yr" AS "MonthYear",
    t0."yr_no" AS "YearNumber",
    t0."mth_no" AS "MonthNumber",
    t1."mth_start" AS "MonthStart",
    t1."mth_end" AS "MonthEnd",
    t0."m_jan" AS "January",
    t0."m_feb" AS "February",
    t0."m_mar" AS "March",
    t0."m_apr" AS "April",
    t0."m_may" AS "May",
    t0."m_jun" AS "June",
    t0."m_jul" AS "July",
    t0."m_aug" AS "August",
    t0."m_sep" AS "September",
    t0."m_oct" AS "October",
    t0."m_nov" AS "November",
    t0."m_dec" AS "December"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "yr_no", "mth_no" ORDER BY rowid) AS __rn FROM "local_2"."cal_mon_apr") t0
JOIN "local_2"."cal_mon_feb" t1 ON t0."yr_no" IS t1."yr_no" AND t0."mth_no" IS t1."mth_no" AND t0.__rn = t1.__rn;

-- Reconstruct ztblSkipLabels from local_3.SkippedLabelRegistry
CREATE VIEW "ztblSkipLabels" AS
SELECT
    "local_3"."SkippedLabelRegistry"."SkippedLabelCount" AS "LabelCount"
FROM "local_3"."SkippedLabelRegistry";

-- Reconstruct ztblWeeks from local_4.calendarWeekRanges
CREATE VIEW "ztblWeeks" AS
SELECT
    "local_4"."calendarWeekRanges"."weekPeriodStart" AS "WeekStart",
    "local_4"."calendarWeekRanges"."weekPeriodEnd" AS "WeekEnd"
FROM "local_4"."calendarWeekRanges";
