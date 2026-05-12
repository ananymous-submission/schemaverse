-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct frpm from vertical split + row partition on a fragment
CREATE VIEW "frpm" AS
SELECT t0.[cdsUniqueId], t0.[academicYearLabel], t0.[countyCode], t0.[districtId], t0.[schoolId], t0.[countyName], t0.[districtLabel], t0.[schoolLabel], t0.[districtCategory], t0.[schoolCategory], t0.[educationOptionCategory], t0.[nslpProvisionClassification], t1.[IsCharterSchool], t1.[CharterSchoolNumber], t1.[CharterFundingType], t0.[instructionResourceCode], t2.[lowestGradeServed], t2.[highestGradeServed], t0.[enrollmentK12], t4.[FreeMealCountK12], t4.[PercentEligibleFreeK12], t4.[FrpmCountK12], t4.[PercentEligibleFrpmK12], t3.[EnrollmentAges5To17], t3.[FreeMealCountAges5To17], t3.[PercentEligibleFreeAges5To17], t3.[FrpmCountAges5To17], t3.[PercentEligibleFrpmAges5To17], t0.[calpadsFallCertificationStatus2013to2014]
FROM [local_2].[frpmCalpadsFallCert2013to2014] t0
JOIN [local_1].[CalpadsFall2013To2014Certification] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_2].[frpmDistrictClassification] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_1].[EnrollmentAges5To17] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN (
SELECT [EnrollmentK12Over303UpTo528].[__orig_rowid] AS __orig_rowid, [local_1].[EnrollmentK12Over303UpTo528].[SchoolCdsCode], [local_1].[EnrollmentK12Over303UpTo528].[EnrollmentK12], [local_1].[EnrollmentK12Over303UpTo528].[FreeMealCountK12], [local_1].[EnrollmentK12Over303UpTo528].[PercentEligibleFreeK12], [local_1].[EnrollmentK12Over303UpTo528].[FrpmCountK12], [local_1].[EnrollmentK12Over303UpTo528].[PercentEligibleFrpmK12] FROM [local_1].[EnrollmentK12Over303UpTo528]
UNION
SELECT [EnrollmentK12Over528UpTo758].[__orig_rowid] AS __orig_rowid, [local_1].[EnrollmentK12Over528UpTo758].[SchoolCdsCode], [local_1].[EnrollmentK12Over528UpTo758].[EnrollmentK12], [local_1].[EnrollmentK12Over528UpTo758].[FreeMealCountK12], [local_1].[EnrollmentK12Over528UpTo758].[PercentEligibleFreeK12], [local_1].[EnrollmentK12Over528UpTo758].[FrpmCountK12], [local_1].[EnrollmentK12Over528UpTo758].[PercentEligibleFrpmK12] FROM [local_1].[EnrollmentK12Over528UpTo758]
UNION
SELECT [EnrollmentK12Over758OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[EnrollmentK12Over758OrNull].[SchoolCdsCode], [local_1].[EnrollmentK12Over758OrNull].[EnrollmentK12], [local_1].[EnrollmentK12Over758OrNull].[FreeMealCountK12], [local_1].[EnrollmentK12Over758OrNull].[PercentEligibleFreeK12], [local_1].[EnrollmentK12Over758OrNull].[FrpmCountK12], [local_1].[EnrollmentK12Over758OrNull].[PercentEligibleFrpmK12] FROM [local_1].[EnrollmentK12Over758OrNull]
UNION
SELECT [EnrollmentK12UpTo303].[__orig_rowid] AS __orig_rowid, [local_1].[EnrollmentK12UpTo303].[SchoolCdsCode], [local_1].[EnrollmentK12UpTo303].[EnrollmentK12], [local_1].[EnrollmentK12UpTo303].[FreeMealCountK12], [local_1].[EnrollmentK12UpTo303].[PercentEligibleFreeK12], [local_1].[EnrollmentK12UpTo303].[FrpmCountK12], [local_1].[EnrollmentK12UpTo303].[PercentEligibleFrpmK12] FROM [local_1].[EnrollmentK12UpTo303]
) t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct satscores from vertical (column) split (3 fragments)
CREATE VIEW "satscores" AS
SELECT
    t0."SchoolCdsCode" AS "cds",
    t1."report_type" AS "rtype",
    t2."school_name" AS "sname",
    t2."district_name" AS "dname",
    t1."county_name" AS "cname",
    t1."enrollment_grade_12" AS "enroll12",
    t1."total_test_takers" AS "NumTstTakr",
    t0."AverageSatReading" AS "AvgScrRead",
    t0."AverageSatMath" AS "AvgScrMath",
    t0."AverageSatWriting" AS "AvgScrWrite",
    t1."students_with_sat_ge_1500" AS "NumGE1500"
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "SchoolCdsCode" ORDER BY rowid) AS __rn FROM "local_1"."SatAverageScores") t0
JOIN "local_3"."sat_scores_over_1500_by_school" t1 ON t0."SchoolCdsCode" IS t1."school_cds_code" AND t0.__rn = t1.__rn
JOIN "local_3"."sat_scores_over_1500_district_view" t2 ON t0."SchoolCdsCode" IS t2."school_cds_code" AND t0.__rn = t2.__rn;

-- Reconstruct schools from vertical split + row partition on a fragment
CREATE VIEW "schools" AS
SELECT t0.[school_cds_code], t4.[ncesDistrictId], t4.[ncesSchoolId], t1.[OperationalStatus], t1.[CountyName], t1.[DistrictName], t1.[SchoolDisplayName], t2.[streetName], t2.[streetAbbrev], t1.[CityName], t1.[ZipCode], t1.[StateCode], t2.[mailingStreet], t2.[mailingStreetAbbrev], t2.[mailingCity], t2.[mailingZipCode], t2.[mailingState], t1.[PhoneNumber], t1.[PhoneExtension], t1.[WebsiteUrl], t3.[SchoolOpenDate], t3.[SchoolClosedDate], t1.[IsCharter], t1.[CharterNumber], t1.[FundingTypeCategory], t1.[DocCode], t1.[DocType], t1.[SocCode], t1.[SocType], t1.[EdOpsAreaCode], t1.[EdOpsAreaName], t1.[EilCode], t1.[EilName], t1.[GsOfferStatus], t1.[GsServedCount], t1.[IsVirtualSchool], t1.[IsMagnetSchool], t1.[GeoLatitude], t1.[GeoLongitude], t0.[admin_primary_name], t0.[admin_primary_last_name], t0.[admin_primary_email], t0.[admin_secondary_name], t0.[admin_secondary_last_name], t0.[admin_secondary_email], t0.[admin_tertiary_name], t0.[admin_tertiary_last_name], t0.[admin_tertiary_email], t3.[LastUpdatedDate]
FROM [local_3].[school_administration_contacts] t0
JOIN [local_1].[CharterSchoolDirectory] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_2].[schoolAddressCity] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN (
SELECT [SchoolsLastUpdateAfter20091002To20150618].[__orig_rowid] AS __orig_rowid, [local_1].[SchoolsLastUpdateAfter20091002To20150618].[SchoolCdsCode], [local_1].[SchoolsLastUpdateAfter20091002To20150618].[SchoolOpenDate], [local_1].[SchoolsLastUpdateAfter20091002To20150618].[SchoolClosedDate], [local_1].[SchoolsLastUpdateAfter20091002To20150618].[LastUpdatedDate] FROM [local_1].[SchoolsLastUpdateAfter20091002To20150618]
UNION
SELECT [SchoolsLastUpdateAfter20150618To20160303].[__orig_rowid] AS __orig_rowid, [local_1].[SchoolsLastUpdateAfter20150618To20160303].[SchoolCdsCode], [local_1].[SchoolsLastUpdateAfter20150618To20160303].[SchoolOpenDate], [local_1].[SchoolsLastUpdateAfter20150618To20160303].[SchoolClosedDate], [local_1].[SchoolsLastUpdateAfter20150618To20160303].[LastUpdatedDate] FROM [local_1].[SchoolsLastUpdateAfter20150618To20160303]
UNION
SELECT [SchoolsLastUpdateAfter20160303OrNull].[__orig_rowid] AS __orig_rowid, [local_1].[SchoolsLastUpdateAfter20160303OrNull].[SchoolCdsCode], [local_1].[SchoolsLastUpdateAfter20160303OrNull].[SchoolOpenDate], [local_1].[SchoolsLastUpdateAfter20160303OrNull].[SchoolClosedDate], [local_1].[SchoolsLastUpdateAfter20160303OrNull].[LastUpdatedDate] FROM [local_1].[SchoolsLastUpdateAfter20160303OrNull]
UNION
SELECT [SchoolsLastUpdateUpTo20091002].[__orig_rowid] AS __orig_rowid, [local_1].[SchoolsLastUpdateUpTo20091002].[SchoolCdsCode], [local_1].[SchoolsLastUpdateUpTo20091002].[SchoolOpenDate], [local_1].[SchoolsLastUpdateUpTo20091002].[SchoolClosedDate], [local_1].[SchoolsLastUpdateUpTo20091002].[LastUpdatedDate] FROM [local_1].[SchoolsLastUpdateUpTo20091002]
) t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN [local_2].[schoolAttributesCounty] t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];
