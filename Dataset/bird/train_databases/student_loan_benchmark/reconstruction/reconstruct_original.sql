-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct bool from local_2.BinaryFlag
CREATE VIEW "bool" AS
SELECT
    "local_2"."BinaryFlag"."FlagKey" AS "name"
FROM "local_2"."BinaryFlag";

-- Reconstruct disabled from local_2.DeactivatedItem
CREATE VIEW "disabled" AS
SELECT
    "local_2"."DeactivatedItem"."ItemKey" AS "name"
FROM "local_2"."DeactivatedItem";

-- Reconstruct enlist from local_3.applicantEnrollment
CREATE VIEW "enlist" AS
SELECT
    "local_3"."applicantEnrollment"."applicantName" AS "name",
    "local_3"."applicantEnrollment"."organizationName" AS "organ"
FROM "local_3"."applicantEnrollment";

-- Reconstruct enrolled from row partitions (UNION (overlap))
CREATE VIEW "enrolled" AS
SELECT "local_1"."enrollment_month_up_to_3"."person_name" AS "name", "local_1"."enrollment_month_up_to_3"."school_name" AS "school", "local_1"."enrollment_month_up_to_3"."enrolled_month" AS "month" FROM "local_1"."enrollment_month_up_to_3"
UNION
SELECT "local_1"."enrollment_month_4_to_6"."person_name" AS "name", "local_1"."enrollment_month_4_to_6"."school_name" AS "school", "local_1"."enrollment_month_4_to_6"."enrolled_month" AS "month" FROM "local_1"."enrollment_month_4_to_6"
UNION
SELECT "local_1"."enrollment_month_7_to_10"."person_name" AS "name", "local_1"."enrollment_month_7_to_10"."school_name" AS "school", "local_1"."enrollment_month_7_to_10"."enrolled_month" AS "month" FROM "local_1"."enrollment_month_7_to_10"
UNION
SELECT "local_1"."enrollment_month_over_10_or_null"."person_name" AS "name", "local_1"."enrollment_month_over_10_or_null"."school_name" AS "school", "local_1"."enrollment_month_over_10_or_null"."enrolled_month" AS "month" FROM "local_1"."enrollment_month_over_10_or_null";

-- Reconstruct filed_for_bankrupcy from local_1.bankruptcy_filings
CREATE VIEW "filed_for_bankrupcy" AS
SELECT
    "local_1"."bankruptcy_filings"."person_name" AS "name"
FROM "local_1"."bankruptcy_filings";

-- Reconstruct longest_absense_from_school from row partitions (UNION (overlap))
CREATE VIEW "longest_absense_from_school" AS
SELECT "local_1"."longest_absence_3_to_4_months"."person_name" AS "name", "local_1"."longest_absence_3_to_4_months"."longest_absence_months" AS "month" FROM "local_1"."longest_absence_3_to_4_months"
UNION
SELECT "local_1"."longest_absence_5_to_7_months"."person_name" AS "name", "local_1"."longest_absence_5_to_7_months"."longest_absence_months" AS "month" FROM "local_1"."longest_absence_5_to_7_months"
UNION
SELECT "local_2"."AbsenceDurationAtMostTwoMonths"."StudentIdentifier" AS "name", "local_2"."AbsenceDurationAtMostTwoMonths"."AbsenceMonths" AS "month" FROM "local_2"."AbsenceDurationAtMostTwoMonths"
UNION
SELECT "local_2"."AbsenceDurationGreaterThanSevenMonthsOrMissing"."StudentIdentifier" AS "name", "local_2"."AbsenceDurationGreaterThanSevenMonthsOrMissing"."AbsenceMonths" AS "month" FROM "local_2"."AbsenceDurationGreaterThanSevenMonthsOrMissing";

-- Reconstruct male from local_1.male_persons
CREATE VIEW "male" AS
SELECT
    "local_1"."male_persons"."person_name" AS "name"
FROM "local_1"."male_persons";

-- Reconstruct no_payment_due from local_3.paymentExemption
CREATE VIEW "no_payment_due" AS
SELECT
    "local_3"."paymentExemption"."entityName" AS "name",
    "local_3"."paymentExemption"."isExempt" AS "bool"
FROM "local_3"."paymentExemption";

-- Reconstruct person from local_1.person_registry
CREATE VIEW "person" AS
SELECT
    "local_1"."person_registry"."person_name" AS "name"
FROM "local_1"."person_registry";

-- Reconstruct unemployed from local_1.unemployed_persons
CREATE VIEW "unemployed" AS
SELECT
    "local_1"."unemployed_persons"."person_name" AS "name"
FROM "local_1"."unemployed_persons";
