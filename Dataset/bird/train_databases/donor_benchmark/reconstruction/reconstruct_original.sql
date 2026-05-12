-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct donations from vertical split + row partition on a fragment
CREATE VIEW "donations" AS
SELECT t0.[don_id], t0.[proj_id], t1.[donor_account_id], t1.[donor_city_name], t1.[donor_state_code], t1.[donor_postal_code], t1.[donor_is_teacher], t1.[donated_at], t0.[proj_share_amt], t0.[opt_support_amt], t0.[total_amt], t0.[amt_text], t0.[incl_opt_support], t0.[pay_method], t1.[payment_used_account_credit], t2.[payment_used_campaign_gift_card], t2.[payment_used_online_gift_card], t1.[payment_promo_matched], t1.[source_giving_page], t2.[honoree_name], t1.[donor_message]
FROM (
SELECT [donations_opt_gt_1_5_to_3_75].[__orig_rowid] AS __orig_rowid, [local_2].[donations_opt_gt_1_5_to_3_75].[don_id], [local_2].[donations_opt_gt_1_5_to_3_75].[proj_id], [local_2].[donations_opt_gt_1_5_to_3_75].[proj_share_amt], [local_2].[donations_opt_gt_1_5_to_3_75].[opt_support_amt], [local_2].[donations_opt_gt_1_5_to_3_75].[total_amt], [local_2].[donations_opt_gt_1_5_to_3_75].[amt_text], [local_2].[donations_opt_gt_1_5_to_3_75].[incl_opt_support], [local_2].[donations_opt_gt_1_5_to_3_75].[pay_method] FROM [local_2].[donations_opt_gt_1_5_to_3_75]
UNION
SELECT [donations_opt_gt_3_75_to_7_5].[__orig_rowid] AS __orig_rowid, [local_2].[donations_opt_gt_3_75_to_7_5].[don_id], [local_2].[donations_opt_gt_3_75_to_7_5].[proj_id], [local_2].[donations_opt_gt_3_75_to_7_5].[proj_share_amt], [local_2].[donations_opt_gt_3_75_to_7_5].[opt_support_amt], [local_2].[donations_opt_gt_3_75_to_7_5].[total_amt], [local_2].[donations_opt_gt_3_75_to_7_5].[amt_text], [local_2].[donations_opt_gt_3_75_to_7_5].[incl_opt_support], [local_2].[donations_opt_gt_3_75_to_7_5].[pay_method] FROM [local_2].[donations_opt_gt_3_75_to_7_5]
UNION
SELECT [donations_opt_gt_7_5_or_null].[__orig_rowid] AS __orig_rowid, [local_2].[donations_opt_gt_7_5_or_null].[don_id], [local_2].[donations_opt_gt_7_5_or_null].[proj_id], [local_2].[donations_opt_gt_7_5_or_null].[proj_share_amt], [local_2].[donations_opt_gt_7_5_or_null].[opt_support_amt], [local_2].[donations_opt_gt_7_5_or_null].[total_amt], [local_2].[donations_opt_gt_7_5_or_null].[amt_text], [local_2].[donations_opt_gt_7_5_or_null].[incl_opt_support], [local_2].[donations_opt_gt_7_5_or_null].[pay_method] FROM [local_2].[donations_opt_gt_7_5_or_null]
UNION
SELECT [donations_opt_le_1_5].[__orig_rowid] AS __orig_rowid, [local_2].[donations_opt_le_1_5].[don_id], [local_2].[donations_opt_le_1_5].[proj_id], [local_2].[donations_opt_le_1_5].[proj_share_amt], [local_2].[donations_opt_le_1_5].[opt_support_amt], [local_2].[donations_opt_le_1_5].[total_amt], [local_2].[donations_opt_le_1_5].[amt_text], [local_2].[donations_opt_le_1_5].[incl_opt_support], [local_2].[donations_opt_le_1_5].[pay_method] FROM [local_2].[donations_opt_le_1_5]
) t0
JOIN [local_3].[contribution_messages] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_3].[honor_contribution_messages] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct essays from local_2.proj_essay_texts
CREATE VIEW "essays" AS
SELECT
    "local_2"."proj_essay_texts"."proj_id" AS "projectid",
    "local_2"."proj_essay_texts"."teacher_acct_id" AS "teacher_acctid",
    "local_2"."proj_essay_texts"."title_text" AS "title",
    "local_2"."proj_essay_texts"."short_desc" AS "short_description",
    "local_2"."proj_essay_texts"."need_stmt" AS "need_statement",
    "local_2"."proj_essay_texts"."essay_text" AS "essay"
FROM "local_2"."proj_essay_texts";

-- Reconstruct projects from vertical split + row partition on a fragment
CREATE VIEW "projects" AS
SELECT t0.[proj_id], t4.[teacherAccountId], t4.[schoolId], t1.[schoolNcesId], t1.[schoolLatitude], t1.[schoolLongitude], t1.[schoolCity], t1.[schoolState], t1.[schoolZip], t1.[schoolMetroIndicator], t1.[schoolDistrict], t1.[schoolCounty], t1.[schoolCharterIndicator], t1.[schoolMagnetProgram], t1.[schoolYearRound], t1.[schoolNlns], t1.[schoolKippIndicator], t1.[charterReadyPromise], t4.[teacherPrefix], t1.[teacherTfaParticipant], t1.[teacherNyTeachingFellow], t3.[primaryFocusSubject], t3.[primaryFocusArea], t3.[secondaryFocusSubject], t3.[secondaryFocusArea], t1.[resourceType], t0.[poverty_lvl], t0.[grade_lvl], t0.[fulfill_costs], t0.[total_price_excl_opt], t0.[total_price_incl_opt], t2.[studentsReached], t2.[doubleYourImpactMatchEligible], t2.[almostHomeMatchEligible], t0.[posted_dt]
FROM (
SELECT [projects_date_gt_2009_10_10_to_2011_09_04].[__orig_rowid] AS __orig_rowid, [local_2].[projects_date_gt_2009_10_10_to_2011_09_04].[proj_id], [local_2].[projects_date_gt_2009_10_10_to_2011_09_04].[poverty_lvl], [local_2].[projects_date_gt_2009_10_10_to_2011_09_04].[grade_lvl], [local_2].[projects_date_gt_2009_10_10_to_2011_09_04].[fulfill_costs], [local_2].[projects_date_gt_2009_10_10_to_2011_09_04].[total_price_excl_opt], [local_2].[projects_date_gt_2009_10_10_to_2011_09_04].[total_price_incl_opt], [local_2].[projects_date_gt_2009_10_10_to_2011_09_04].[posted_dt] FROM [local_2].[projects_date_gt_2009_10_10_to_2011_09_04]
UNION
SELECT [projects_date_gt_2011_09_04_to_2013_02_07].[__orig_rowid] AS __orig_rowid, [local_2].[projects_date_gt_2011_09_04_to_2013_02_07].[proj_id], [local_2].[projects_date_gt_2011_09_04_to_2013_02_07].[poverty_lvl], [local_2].[projects_date_gt_2011_09_04_to_2013_02_07].[grade_lvl], [local_2].[projects_date_gt_2011_09_04_to_2013_02_07].[fulfill_costs], [local_2].[projects_date_gt_2011_09_04_to_2013_02_07].[total_price_excl_opt], [local_2].[projects_date_gt_2011_09_04_to_2013_02_07].[total_price_incl_opt], [local_2].[projects_date_gt_2011_09_04_to_2013_02_07].[posted_dt] FROM [local_2].[projects_date_gt_2011_09_04_to_2013_02_07]
UNION
SELECT [projects_date_gt_2013_02_07_or_null].[__orig_rowid] AS __orig_rowid, [local_2].[projects_date_gt_2013_02_07_or_null].[proj_id], [local_2].[projects_date_gt_2013_02_07_or_null].[poverty_lvl], [local_2].[projects_date_gt_2013_02_07_or_null].[grade_lvl], [local_2].[projects_date_gt_2013_02_07_or_null].[fulfill_costs], [local_2].[projects_date_gt_2013_02_07_or_null].[total_price_excl_opt], [local_2].[projects_date_gt_2013_02_07_or_null].[total_price_incl_opt], [local_2].[projects_date_gt_2013_02_07_or_null].[posted_dt] FROM [local_2].[projects_date_gt_2013_02_07_or_null]
UNION
SELECT [projects_date_le_2009_10_10].[__orig_rowid] AS __orig_rowid, [local_2].[projects_date_le_2009_10_10].[proj_id], [local_2].[projects_date_le_2009_10_10].[poverty_lvl], [local_2].[projects_date_le_2009_10_10].[grade_lvl], [local_2].[projects_date_le_2009_10_10].[fulfill_costs], [local_2].[projects_date_le_2009_10_10].[total_price_excl_opt], [local_2].[projects_date_le_2009_10_10].[total_price_incl_opt], [local_2].[projects_date_le_2009_10_10].[posted_dt] FROM [local_2].[projects_date_le_2009_10_10]
) t0
JOIN [local_1].[projectPostings] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[projectMatchingEligibility] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[projectPrimaryFocus] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_1].[projectSchoolCharterDetails] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct resources from vertical split + row partition on a fragment
CREATE VIEW "resources" AS
SELECT t0.[resourceId], t1.[projectId], t1.[vendorId], t0.[vendorName], t0.[projectResourceType], t0.[itemName], t0.[itemNumber], t0.[itemUnitPrice], t0.[itemQuantity]
FROM (
SELECT [resourceItemsPriceOverSixPointTwoNineToThirteenPointNineEight].[__orig_rowid] AS __orig_rowid, [local_1].[resourceItemsPriceOverSixPointTwoNineToThirteenPointNineEight].[resourceId], [local_1].[resourceItemsPriceOverSixPointTwoNineToThirteenPointNineEight].[vendorName], [local_1].[resourceItemsPriceOverSixPointTwoNineToThirteenPointNineEight].[projectResourceType], [local_1].[resourceItemsPriceOverSixPointTwoNineToThirteenPointNineEight].[itemName], [local_1].[resourceItemsPriceOverSixPointTwoNineToThirteenPointNineEight].[itemNumber], [local_1].[resourceItemsPriceOverSixPointTwoNineToThirteenPointNineEight].[itemUnitPrice], [local_1].[resourceItemsPriceOverSixPointTwoNineToThirteenPointNineEight].[itemQuantity] FROM [local_1].[resourceItemsPriceOverSixPointTwoNineToThirteenPointNineEight]
UNION
SELECT [resourceItemsPriceOverThirteenPointNineEightToThirtySix].[__orig_rowid] AS __orig_rowid, [local_1].[resourceItemsPriceOverThirteenPointNineEightToThirtySix].[resourceId], [local_1].[resourceItemsPriceOverThirteenPointNineEightToThirtySix].[vendorName], [local_1].[resourceItemsPriceOverThirteenPointNineEightToThirtySix].[projectResourceType], [local_1].[resourceItemsPriceOverThirteenPointNineEightToThirtySix].[itemName], [local_1].[resourceItemsPriceOverThirteenPointNineEightToThirtySix].[itemNumber], [local_1].[resourceItemsPriceOverThirteenPointNineEightToThirtySix].[itemUnitPrice], [local_1].[resourceItemsPriceOverThirteenPointNineEightToThirtySix].[itemQuantity] FROM [local_1].[resourceItemsPriceOverThirteenPointNineEightToThirtySix]
UNION
SELECT [resourceItemsPriceOverThirtySixOrNull].[__orig_rowid] AS __orig_rowid, [local_1].[resourceItemsPriceOverThirtySixOrNull].[resourceId], [local_1].[resourceItemsPriceOverThirtySixOrNull].[vendorName], [local_1].[resourceItemsPriceOverThirtySixOrNull].[projectResourceType], [local_1].[resourceItemsPriceOverThirtySixOrNull].[itemName], [local_1].[resourceItemsPriceOverThirtySixOrNull].[itemNumber], [local_1].[resourceItemsPriceOverThirtySixOrNull].[itemUnitPrice], [local_1].[resourceItemsPriceOverThirtySixOrNull].[itemQuantity] FROM [local_1].[resourceItemsPriceOverThirtySixOrNull]
UNION
SELECT [resourceItemsPriceUpToSixPointTwoNine].[__orig_rowid] AS __orig_rowid, [local_1].[resourceItemsPriceUpToSixPointTwoNine].[resourceId], [local_1].[resourceItemsPriceUpToSixPointTwoNine].[vendorName], [local_1].[resourceItemsPriceUpToSixPointTwoNine].[projectResourceType], [local_1].[resourceItemsPriceUpToSixPointTwoNine].[itemName], [local_1].[resourceItemsPriceUpToSixPointTwoNine].[itemNumber], [local_1].[resourceItemsPriceUpToSixPointTwoNine].[itemUnitPrice], [local_1].[resourceItemsPriceUpToSixPointTwoNine].[itemQuantity] FROM [local_1].[resourceItemsPriceUpToSixPointTwoNine]
) t0
JOIN [local_1].[resourceItemsByIdentifier] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];
