-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/donor/donor.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "projectMatchingEligibility" (
    "projectId" TEXT,
    "almostHomeMatchEligible" TEXT,
    "doubleYourImpactMatchEligible" TEXT,
    "studentsReached" INTEGER
);

CREATE TABLE "projectPostings" (
    "projectId" TEXT,
    "postingDate" DATE,
    "gradeLevel" TEXT,
    "povertyLevel" TEXT,
    "resourceType" TEXT,
    "schoolCharterIndicator" TEXT,
    "charterReadyPromise" TEXT,
    "schoolCity" TEXT,
    "schoolCounty" TEXT,
    "schoolDistrict" TEXT,
    "schoolKippIndicator" TEXT,
    "schoolLatitude" REAL,
    "schoolLongitude" REAL,
    "schoolMagnetProgram" TEXT,
    "schoolMetroIndicator" TEXT,
    "schoolNcesId" TEXT,
    "schoolNlns" TEXT,
    "schoolState" TEXT,
    "schoolYearRound" TEXT,
    "schoolZip" INTEGER,
    "teacherNyTeachingFellow" TEXT,
    "teacherTfaParticipant" TEXT
);

CREATE TABLE "projectPrimaryFocus" (
    "projectId" TEXT,
    "primaryFocusArea" TEXT,
    "primaryFocusSubject" TEXT,
    "resourceType" TEXT,
    "secondaryFocusArea" TEXT,
    "secondaryFocusSubject" TEXT
);

CREATE TABLE "projectSchoolCharterDetails" (
    "projectId" TEXT,
    "charterReadyPromise" TEXT,
    "schoolCity" TEXT,
    "schoolKippIndicator" TEXT,
    "schoolNcesId" TEXT,
    "schoolNlns" TEXT,
    "schoolState" TEXT,
    "schoolYearRound" TEXT,
    "schoolZip" INTEGER,
    "schoolId" TEXT,
    "teacherAccountId" TEXT,
    "teacherNyTeachingFellow" TEXT,
    "teacherPrefix" TEXT,
    "teacherTfaParticipant" TEXT
);

CREATE TABLE "resourceItemsPriceUpToSixPointTwoNine" (
    "resourceId" TEXT,
    "itemName" TEXT,
    "itemNumber" TEXT,
    "itemQuantity" INTEGER,
    "itemUnitPrice" REAL,
    "projectResourceType" TEXT,
    "vendorName" TEXT
);

CREATE TABLE "resourceItemsPriceOverSixPointTwoNineToThirteenPointNineEight" (
    "resourceId" TEXT,
    "itemName" TEXT,
    "itemNumber" TEXT,
    "itemQuantity" INTEGER,
    "itemUnitPrice" REAL,
    "projectResourceType" TEXT,
    "vendorName" TEXT
);

CREATE TABLE "resourceItemsPriceOverThirteenPointNineEightToThirtySix" (
    "resourceId" TEXT,
    "itemName" TEXT,
    "itemNumber" TEXT,
    "itemQuantity" INTEGER,
    "itemUnitPrice" REAL,
    "projectResourceType" TEXT,
    "vendorName" TEXT
);

CREATE TABLE "resourceItemsPriceOverThirtySixOrNull" (
    "resourceId" TEXT,
    "itemName" TEXT,
    "itemNumber" TEXT,
    "itemQuantity" INTEGER,
    "itemUnitPrice" REAL,
    "projectResourceType" TEXT,
    "vendorName" TEXT
);

CREATE TABLE "resourceItemsByIdentifier" (
    "resourceId" TEXT,
    "itemNumber" TEXT,
    "itemQuantity" INTEGER,
    "itemUnitPrice" REAL,
    "projectResourceType" TEXT,
    "projectId" TEXT,
    "vendorId" INTEGER,
    FOREIGN KEY ("projectId") REFERENCES "projectPostings"("projectId"),
    FOREIGN KEY ("projectId") REFERENCES "projectSchoolCharterDetails"("projectId")
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "proj_essay_texts" (
    "proj_id" TEXT,
    "teacher_acct_id" TEXT,
    "title_text" TEXT,
    "short_desc" TEXT,
    "need_stmt" TEXT,
    "essay_text" TEXT
);

CREATE TABLE "donations_opt_le_1_5" (
    "don_id" TEXT,
    "amt_text" TEXT,
    "incl_opt_support" TEXT,
    "opt_support_amt" REAL,
    "proj_share_amt" REAL,
    "total_amt" REAL,
    "pay_method" TEXT,
    "proj_id" TEXT,
    FOREIGN KEY ("proj_id") REFERENCES "projects_date_gt_2013_02_07_or_null"("proj_id")
);

CREATE TABLE "donations_opt_gt_1_5_to_3_75" (
    "don_id" TEXT,
    "amt_text" TEXT,
    "incl_opt_support" TEXT,
    "opt_support_amt" REAL,
    "proj_share_amt" REAL,
    "total_amt" REAL,
    "pay_method" TEXT,
    "proj_id" TEXT,
    FOREIGN KEY ("proj_id") REFERENCES "projects_date_le_2009_10_10"("proj_id"),
    FOREIGN KEY ("proj_id") REFERENCES "projects_date_gt_2009_10_10_to_2011_09_04"("proj_id")
);

CREATE TABLE "donations_opt_gt_3_75_to_7_5" (
    "don_id" TEXT,
    "amt_text" TEXT,
    "incl_opt_support" TEXT,
    "opt_support_amt" REAL,
    "proj_share_amt" REAL,
    "total_amt" REAL,
    "pay_method" TEXT,
    "proj_id" TEXT,
    FOREIGN KEY ("proj_id") REFERENCES "projects_date_gt_2011_09_04_to_2013_02_07"("proj_id"),
    FOREIGN KEY ("proj_id") REFERENCES "projects_date_gt_2013_02_07_or_null"("proj_id")
);

CREATE TABLE "donations_opt_gt_7_5_or_null" (
    "don_id" TEXT,
    "amt_text" TEXT,
    "incl_opt_support" TEXT,
    "opt_support_amt" REAL,
    "proj_share_amt" REAL,
    "total_amt" REAL,
    "pay_method" TEXT,
    "proj_id" TEXT
);

CREATE TABLE "projects_date_le_2009_10_10" (
    "proj_id" TEXT,
    "posted_dt" DATE,
    "fulfill_costs" REAL,
    "grade_lvl" TEXT,
    "poverty_lvl" TEXT,
    "total_price_excl_opt" REAL,
    "total_price_incl_opt" REAL
);

CREATE TABLE "projects_date_gt_2009_10_10_to_2011_09_04" (
    "proj_id" TEXT,
    "posted_dt" DATE,
    "fulfill_costs" REAL,
    "grade_lvl" TEXT,
    "poverty_lvl" TEXT,
    "total_price_excl_opt" REAL,
    "total_price_incl_opt" REAL
);

CREATE TABLE "projects_date_gt_2011_09_04_to_2013_02_07" (
    "proj_id" TEXT,
    "posted_dt" DATE,
    "fulfill_costs" REAL,
    "grade_lvl" TEXT,
    "poverty_lvl" TEXT,
    "total_price_excl_opt" REAL,
    "total_price_incl_opt" REAL
);

CREATE TABLE "projects_date_gt_2013_02_07_or_null" (
    "proj_id" TEXT,
    "posted_dt" DATE,
    "fulfill_costs" REAL,
    "grade_lvl" TEXT,
    "poverty_lvl" TEXT,
    "total_price_excl_opt" REAL,
    "total_price_incl_opt" REAL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "contribution_messages" (
    "contribution_id" TEXT,
    "donor_message" TEXT,
    "donated_at" DATETIME,
    "donor_account_id" TEXT,
    "donor_city_name" TEXT,
    "donor_state_code" TEXT,
    "donor_postal_code" TEXT,
    "donor_is_teacher" TEXT,
    "payment_used_account_credit" TEXT,
    "payment_method_type" TEXT,
    "payment_promo_matched" TEXT,
    "project_id" TEXT,
    "source_giving_page" TEXT
);

CREATE TABLE "honor_contribution_messages" (
    "contribution_id" TEXT,
    "tribute_message" TEXT,
    "donated_at" DATETIME,
    "honoree_name" TEXT,
    "donor_is_teacher" TEXT,
    "payment_used_account_credit" TEXT,
    "payment_used_campaign_gift_card" TEXT,
    "payment_used_online_gift_card" TEXT,
    "payment_promo_matched" TEXT,
    "source_giving_page" TEXT
);

