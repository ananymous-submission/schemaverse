-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct callcenterlogs from vertical split + row partition on a fragment
CREATE VIEW "callcenterlogs" AS
SELECT t2.[recv_date], t0.[comp_id], t0.[client_rand_id], t0.[phone_term], t0.[vru_line], t0.[call_num], t2.[prio], t2.[comp_type], t0.[call_outcome], t0.[srv_name], t1.[srv_start_time], t1.[srv_exit_time], t1.[srv_dur]
FROM [local_1].[cc_call_meta] t0
JOIN [local_1].[cc_call_serv] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [cc_recv_20130830_20150325].[__orig_rowid] AS __orig_rowid, [local_1].[cc_recv_20130830_20150325].[recv_date], [local_1].[cc_recv_20130830_20150325].[comp_id], [local_1].[cc_recv_20130830_20150325].[prio], [local_1].[cc_recv_20130830_20150325].[comp_type] FROM [local_1].[cc_recv_20130830_20150325]
UNION
SELECT [cc_recv_20150326_20160822].[__orig_rowid] AS __orig_rowid, [local_1].[cc_recv_20150326_20160822].[recv_date], [local_1].[cc_recv_20150326_20160822].[comp_id], [local_1].[cc_recv_20150326_20160822].[prio], [local_1].[cc_recv_20150326_20160822].[comp_type] FROM [local_1].[cc_recv_20150326_20160822]
UNION
SELECT [cc_recv_gt_20160822_null].[__orig_rowid] AS __orig_rowid, [local_1].[cc_recv_gt_20160822_null].[recv_date], [local_1].[cc_recv_gt_20160822_null].[comp_id], [local_1].[cc_recv_gt_20160822_null].[prio], [local_1].[cc_recv_gt_20160822_null].[comp_type] FROM [local_1].[cc_recv_gt_20160822_null]
UNION
SELECT [cc_recv_le_20130829].[__orig_rowid] AS __orig_rowid, [local_1].[cc_recv_le_20130829].[recv_date], [local_1].[cc_recv_le_20130829].[comp_id], [local_1].[cc_recv_le_20130829].[prio], [local_1].[cc_recv_le_20130829].[comp_type] FROM [local_1].[cc_recv_le_20130829]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct client from vertical split + row partition on a fragment
CREATE VIEW "client" AS
SELECT t0.[cli_id], t0.[sex_code], t2.[day_n], t2.[mon_n], t2.[yr_n], t0.[age_yrs], t0.[social_id], t3.[FirstName], t3.[MiddleName], t3.[LastName], t0.[phone_num], t0.[email_addr], t0.[addr_line1], t0.[addr_line2], t0.[city], t1.[residenceState], t0.[zip_code], t0.[district_code]
FROM (
SELECT [client_addr_le_31].[__orig_rowid] AS __orig_rowid, [local_1].[client_addr_le_31].[cli_id], [local_1].[client_addr_le_31].[sex_code], [local_1].[client_addr_le_31].[age_yrs], [local_1].[client_addr_le_31].[social_id], [local_1].[client_addr_le_31].[phone_num], [local_1].[client_addr_le_31].[email_addr], [local_1].[client_addr_le_31].[addr_line1], [local_1].[client_addr_le_31].[addr_line2], [local_1].[client_addr_le_31].[city], [local_1].[client_addr_le_31].[zip_code], [local_1].[client_addr_le_31].[district_code] FROM [local_1].[client_addr_le_31]
UNION
SELECT [clientAddressAge32To45].[__orig_rowid] AS __orig_rowid, [local_3].[clientAddressAge32To45].[clientId], [local_3].[clientAddressAge32To45].[gender], [local_3].[clientAddressAge32To45].[ageYears], [local_3].[clientAddressAge32To45].[socialId], [local_3].[clientAddressAge32To45].[phoneNumber], [local_3].[clientAddressAge32To45].[emailAddress], [local_3].[clientAddressAge32To45].[streetAddressPrimary], [local_3].[clientAddressAge32To45].[streetAddressSecondary], [local_3].[clientAddressAge32To45].[cityName], [local_3].[clientAddressAge32To45].[postalCode], [local_3].[clientAddressAge32To45].[districtRefId] FROM [local_3].[clientAddressAge32To45]
UNION
SELECT [clientAddressAge46To59].[__orig_rowid] AS __orig_rowid, [local_3].[clientAddressAge46To59].[clientId], [local_3].[clientAddressAge46To59].[gender], [local_3].[clientAddressAge46To59].[ageYears], [local_3].[clientAddressAge46To59].[socialId], [local_3].[clientAddressAge46To59].[phoneNumber], [local_3].[clientAddressAge46To59].[emailAddress], [local_3].[clientAddressAge46To59].[streetAddressPrimary], [local_3].[clientAddressAge46To59].[streetAddressSecondary], [local_3].[clientAddressAge46To59].[cityName], [local_3].[clientAddressAge46To59].[postalCode], [local_3].[clientAddressAge46To59].[districtRefId] FROM [local_3].[clientAddressAge46To59]
UNION
SELECT [clientAddressAge60OrAbove].[__orig_rowid] AS __orig_rowid, [local_3].[clientAddressAge60OrAbove].[clientId], [local_3].[clientAddressAge60OrAbove].[gender], [local_3].[clientAddressAge60OrAbove].[ageYears], [local_3].[clientAddressAge60OrAbove].[socialId], [local_3].[clientAddressAge60OrAbove].[phoneNumber], [local_3].[clientAddressAge60OrAbove].[emailAddress], [local_3].[clientAddressAge60OrAbove].[streetAddressPrimary], [local_3].[clientAddressAge60OrAbove].[streetAddressSecondary], [local_3].[clientAddressAge60OrAbove].[cityName], [local_3].[clientAddressAge60OrAbove].[postalCode], [local_3].[clientAddressAge60OrAbove].[districtRefId] FROM [local_3].[clientAddressAge60OrAbove]
) t0
JOIN [local_3].[clientAgeProfile] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[client_date_parts] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_2].[ClientNameProfile] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct district from local_3.locationDistrict
CREATE VIEW "district" AS
SELECT
    "local_3"."locationDistrict"."districtId" AS "district_id",
    "local_3"."locationDistrict"."districtCity" AS "city",
    "local_3"."locationDistrict"."stateCodeRef" AS "state_abbrev",
    "local_3"."locationDistrict"."divisionName" AS "division"
FROM "local_3"."locationDistrict";

-- Reconstruct events from vertical split + row partition on a fragment
CREATE VIEW "events" AS
SELECT t2.[recv_date], t3.[product], t3.[sub_product], t0.[IssueCategory], t0.[IssueSubcategory], t0.[ConsumerComplaintNarrative], t4.[SubmissionTags], t0.[ConsumerConsentProvided], t4.[SubmissionChannel], t2.[sent_to_co_date], t0.[CompanyResponseToConsumer], t0.[TimelyResponse], t0.[ConsumerDisputed], t0.[ComplaintId], t0.[ClientId]
FROM [local_2].[CompanyResponsesToConsumers] t0
JOIN [local_1].[ev_cons_narr] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [ev_recv_20130525_20141229].[__orig_rowid] AS __orig_rowid, [local_1].[ev_recv_20130525_20141229].[recv_date], [local_1].[ev_recv_20130525_20141229].[sent_to_co_date], [local_1].[ev_recv_20130525_20141229].[comp_id], [local_1].[ev_recv_20130525_20141229].[cli_id] FROM [local_1].[ev_recv_20130525_20141229]
UNION
SELECT [ev_recv_20141230_20160308].[__orig_rowid] AS __orig_rowid, [local_1].[ev_recv_20141230_20160308].[recv_date], [local_1].[ev_recv_20141230_20160308].[sent_to_co_date], [local_1].[ev_recv_20141230_20160308].[comp_id], [local_1].[ev_recv_20141230_20160308].[cli_id] FROM [local_1].[ev_recv_20141230_20160308]
UNION
SELECT [ev_recv_gt_20160308_null].[__orig_rowid] AS __orig_rowid, [local_1].[ev_recv_gt_20160308_null].[recv_date], [local_1].[ev_recv_gt_20160308_null].[sent_to_co_date], [local_1].[ev_recv_gt_20160308_null].[comp_id], [local_1].[ev_recv_gt_20160308_null].[cli_id] FROM [local_1].[ev_recv_gt_20160308_null]
UNION
SELECT [ev_recv_le_20130524].[__orig_rowid] AS __orig_rowid, [local_1].[ev_recv_le_20130524].[recv_date], [local_1].[ev_recv_le_20130524].[sent_to_co_date], [local_1].[ev_recv_le_20130524].[comp_id], [local_1].[ev_recv_le_20130524].[cli_id] FROM [local_1].[ev_recv_le_20130524]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[ev_product] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_2].[ComplaintSubmissionChannels] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct reviews from row partitions (UNION (overlap))
CREATE VIEW "reviews" AS
SELECT "local_2"."EagleNationalMortgageReviews"."ReviewDate" AS "Date", "local_2"."EagleNationalMortgageReviews"."StarRating" AS "Stars", "local_2"."EagleNationalMortgageReviews"."ReviewText" AS "Reviews", "local_2"."EagleNationalMortgageReviews"."ProductName" AS "Product", "local_2"."EagleNationalMortgageReviews"."DistrictId" AS "district_id" FROM "local_2"."EagleNationalMortgageReviews"
UNION
SELECT "local_3"."reviewsEagleBanksOrUnspecified"."reviewDate" AS "Date", "local_3"."reviewsEagleBanksOrUnspecified"."starRating" AS "Stars", "local_3"."reviewsEagleBanksOrUnspecified"."reviewText" AS "Reviews", "local_3"."reviewsEagleBanksOrUnspecified"."productName" AS "Product", "local_3"."reviewsEagleBanksOrUnspecified"."districtRefId" AS "district_id" FROM "local_3"."reviewsEagleBanksOrUnspecified";

-- Reconstruct state from local_3.usState
CREATE VIEW "state" AS
SELECT
    "local_3"."usState"."stateCode" AS "StateCode",
    "local_3"."usState"."stateName" AS "State",
    "local_3"."usState"."regionName" AS "Region"
FROM "local_3"."usState";
