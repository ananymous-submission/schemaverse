-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct Customers from row partitions (UNION (overlap))
CREATE VIEW "Customers" AS
SELECT "local_1"."customersEducationLowerThird"."customerId" AS "ID", "local_1"."customersEducationLowerThird"."gender" AS "SEX", "local_1"."customersEducationLowerThird"."maritalStatus" AS "MARITAL_STATUS", "local_1"."customersEducationLowerThird"."geographicId" AS "GEOID", "local_1"."customersEducationLowerThird"."educationLevel" AS "EDUCATIONNUM", "local_1"."customersEducationLowerThird"."jobTitle" AS "OCCUPATION", "local_1"."customersEducationLowerThird"."ageYears" AS "age" FROM "local_1"."customersEducationLowerThird"
UNION
SELECT "local_1"."customersEducationAboveSevenOrMissing"."customerId" AS "ID", "local_1"."customersEducationAboveSevenOrMissing"."gender" AS "SEX", "local_1"."customersEducationAboveSevenOrMissing"."maritalStatus" AS "MARITAL_STATUS", "local_1"."customersEducationAboveSevenOrMissing"."geographicId" AS "GEOID", "local_1"."customersEducationAboveSevenOrMissing"."educationLevel" AS "EDUCATIONNUM", "local_1"."customersEducationAboveSevenOrMissing"."jobTitle" AS "OCCUPATION", "local_1"."customersEducationAboveSevenOrMissing"."ageYears" AS "age" FROM "local_1"."customersEducationAboveSevenOrMissing"
UNION
SELECT "local_3"."CustomerProfilesEducationMiddleThird"."CustomerId" AS "ID", "local_3"."CustomerProfilesEducationMiddleThird"."Gender" AS "SEX", "local_3"."CustomerProfilesEducationMiddleThird"."RelationshipStatus" AS "MARITAL_STATUS", "local_3"."CustomerProfilesEducationMiddleThird"."GeoAreaId" AS "GEOID", "local_3"."CustomerProfilesEducationMiddleThird"."EducationLevelMiddleThird" AS "EDUCATIONNUM", "local_3"."CustomerProfilesEducationMiddleThird"."OccupationTitle" AS "OCCUPATION", "local_3"."CustomerProfilesEducationMiddleThird"."AgeYears" AS "age" FROM "local_3"."CustomerProfilesEducationMiddleThird";

-- Reconstruct Demog from local_3.AreaDemographics
CREATE VIEW "Demog" AS
SELECT
    "local_3"."AreaDemographics"."GeoAreaId" AS "GEOID",
    "local_3"."AreaDemographics"."PopulationThousands" AS "INHABITANTS_K",
    "local_3"."AreaDemographics"."IncomeThousands" AS "INCOME_K",
    "local_3"."AreaDemographics"."HouseholdSizeAverage" AS "A_VAR1",
    "local_3"."AreaDemographics"."EmploymentRate" AS "A_VAR2",
    "local_3"."AreaDemographics"."EducationAttainmentScore" AS "A_VAR3",
    "local_3"."AreaDemographics"."UrbanizationShare" AS "A_VAR4",
    "local_3"."AreaDemographics"."RuralPopulationShare" AS "A_VAR5",
    "local_3"."AreaDemographics"."MedianAge" AS "A_VAR6",
    "local_3"."AreaDemographics"."PopulationGrowthRate" AS "A_VAR7",
    "local_3"."AreaDemographics"."PovertyRate" AS "A_VAR8",
    "local_3"."AreaDemographics"."AccessibilityIndex" AS "A_VAR9",
    "local_3"."AreaDemographics"."HealthOutcomeIndex" AS "A_VAR10",
    "local_3"."AreaDemographics"."CrimeIncidenceRate" AS "A_VAR11",
    "local_3"."AreaDemographics"."InternetPenetrationRate" AS "A_VAR12",
    "local_3"."AreaDemographics"."PublicTransportUsage" AS "A_VAR13",
    "local_3"."AreaDemographics"."GreenSpacePercentage" AS "A_VAR14",
    "local_3"."AreaDemographics"."CommercialDensityIndex" AS "A_VAR15",
    "local_3"."AreaDemographics"."SchoolDensity" AS "A_VAR16",
    "local_3"."AreaDemographics"."HospitalDensity" AS "A_VAR17",
    "local_3"."AreaDemographics"."RecreationFacilityIndex" AS "A_VAR18"
FROM "local_3"."AreaDemographics";

-- Reconstruct Mailings1_2 from row partitions (UNION (overlap))
CREATE VIEW "Mailings1_2" AS
SELECT "local_1"."mailingsFeb2007Snapshot"."mailingRefId" AS "REFID", "local_1"."mailingsFeb2007Snapshot"."mailingDate" AS "REF_DATE", "local_1"."mailingsFeb2007Snapshot"."responseStatus" AS "RESPONSE" FROM "local_1"."mailingsFeb2007Snapshot"
UNION
SELECT "local_1"."mailingsMar2007Snapshot"."mailingRefId" AS "REFID", "local_1"."mailingsMar2007Snapshot"."mailingDate" AS "REF_DATE", "local_1"."mailingsMar2007Snapshot"."responseStatus" AS "RESPONSE" FROM "local_1"."mailingsMar2007Snapshot";

-- Reconstruct Sales from row partitions (UNION (overlap))
CREATE VIEW "Sales" AS
SELECT "local_1"."salesAmountBetweenTwelvePointFiveAndFifteenPointZeroZeroOne"."saleEventId" AS "EVENTID", "local_1"."salesAmountBetweenTwelvePointFiveAndFifteenPointZeroZeroOne"."mailingRefId" AS "REFID", "local_1"."salesAmountBetweenTwelvePointFiveAndFifteenPointZeroZeroOne"."transactionDate" AS "EVENT_DATE", "local_1"."salesAmountBetweenTwelvePointFiveAndFifteenPointZeroZeroOne"."saleAmount" AS "AMOUNT" FROM "local_1"."salesAmountBetweenTwelvePointFiveAndFifteenPointZeroZeroOne"
UNION
SELECT "local_1"."salesAmountBetweenFifteenPointZeroZeroOneAndSeventeenPointFive"."saleEventId" AS "EVENTID", "local_1"."salesAmountBetweenFifteenPointZeroZeroOneAndSeventeenPointFive"."mailingRefId" AS "REFID", "local_1"."salesAmountBetweenFifteenPointZeroZeroOneAndSeventeenPointFive"."transactionDate" AS "EVENT_DATE", "local_1"."salesAmountBetweenFifteenPointZeroZeroOneAndSeventeenPointFive"."saleAmount" AS "AMOUNT" FROM "local_1"."salesAmountBetweenFifteenPointZeroZeroOneAndSeventeenPointFive"
UNION
SELECT "local_2"."sls_amt_le_12_5"."sale_evt_id" AS "EVENTID", "local_2"."sls_amt_le_12_5"."mail_ref_id" AS "REFID", "local_2"."sls_amt_le_12_5"."sale_evt_ts" AS "EVENT_DATE", "local_2"."sls_amt_le_12_5"."amt_val" AS "AMOUNT" FROM "local_2"."sls_amt_le_12_5"
UNION
SELECT "local_2"."sls_amt_gt_17_5_or_null"."sale_evt_id" AS "EVENTID", "local_2"."sls_amt_gt_17_5_or_null"."mail_ref_id" AS "REFID", "local_2"."sls_amt_gt_17_5_or_null"."sale_evt_ts" AS "EVENT_DATE", "local_2"."sls_amt_gt_17_5_or_null"."amt_val" AS "AMOUNT" FROM "local_2"."sls_amt_gt_17_5_or_null";

-- Reconstruct mailings3 from local_2.mail_ref
CREATE VIEW "mailings3" AS
SELECT
    "local_2"."mail_ref"."mail_ref_id" AS "REFID",
    "local_2"."mail_ref"."mail_ref_ts" AS "REF_DATE",
    "local_2"."mail_ref"."resp_text" AS "RESPONSE"
FROM "local_2"."mail_ref";
