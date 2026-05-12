-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";

-- Reconstruct Attributes from local_1.attributeDefinitions
CREATE VIEW "Attributes" AS
SELECT
    "local_1"."attributeDefinitions"."attributeId" AS "attribute_id",
    "local_1"."attributeDefinitions"."attributeLabel" AS "attribute_name"
FROM "local_1"."attributeDefinitions";

-- Reconstruct Business from row partitions (UNION (overlap))
CREATE VIEW "Business" AS
SELECT "local_1"."businessesInPhoenix"."businessId" AS "business_id", "local_1"."businessesInPhoenix"."isActive" AS "active", "local_1"."businessesInPhoenix"."cityName" AS "city", "local_1"."businessesInPhoenix"."stateCode" AS "state", "local_1"."businessesInPhoenix"."averageRating" AS "stars", "local_1"."businessesInPhoenix"."totalReviewCount" AS "review_count" FROM "local_1"."businessesInPhoenix"
UNION
SELECT "local_1"."businessesChandlerAndGlendale"."businessId" AS "business_id", "local_1"."businessesChandlerAndGlendale"."isActive" AS "active", "local_1"."businessesChandlerAndGlendale"."cityName" AS "city", "local_1"."businessesChandlerAndGlendale"."stateCode" AS "state", "local_1"."businessesChandlerAndGlendale"."averageRating" AS "stars", "local_1"."businessesChandlerAndGlendale"."totalReviewCount" AS "review_count" FROM "local_1"."businessesChandlerAndGlendale"
UNION
SELECT "local_3"."BusinessInScottsdale"."BusinessId" AS "business_id", "local_3"."BusinessInScottsdale"."IsActive" AS "active", "local_3"."BusinessInScottsdale"."CityName" AS "city", "local_3"."BusinessInScottsdale"."StateCode" AS "state", "local_3"."BusinessInScottsdale"."AverageStars" AS "stars", "local_3"."BusinessInScottsdale"."ReviewCount" AS "review_count" FROM "local_3"."BusinessInScottsdale"
UNION
SELECT "local_3"."BusinessTempeAndOther"."BusinessId" AS "business_id", "local_3"."BusinessTempeAndOther"."IsActive" AS "active", "local_3"."BusinessTempeAndOther"."CityName" AS "city", "local_3"."BusinessTempeAndOther"."StateCode" AS "state", "local_3"."BusinessTempeAndOther"."AverageStars" AS "stars", "local_3"."BusinessTempeAndOther"."ReviewCount" AS "review_count" FROM "local_3"."BusinessTempeAndOther"
UNION
SELECT "local_3"."BusinessInMesaGilbertPeoriaSurprise"."BusinessId" AS "business_id", "local_3"."BusinessInMesaGilbertPeoriaSurprise"."IsActive" AS "active", "local_3"."BusinessInMesaGilbertPeoriaSurprise"."CityName" AS "city", "local_3"."BusinessInMesaGilbertPeoriaSurprise"."StateCode" AS "state", "local_3"."BusinessInMesaGilbertPeoriaSurprise"."AverageStars" AS "stars", "local_3"."BusinessInMesaGilbertPeoriaSurprise"."ReviewCount" AS "review_count" FROM "local_3"."BusinessInMesaGilbertPeoriaSurprise";

-- Reconstruct Business_Attributes from row partitions (UNION (overlap))
CREATE VIEW "Business_Attributes" AS
SELECT "local_1"."businessAttributesTrue"."attributeId" AS "attribute_id", "local_1"."businessAttributesTrue"."businessId" AS "business_id", "local_1"."businessAttributesTrue"."attributeEnabled" AS "attribute_value" FROM "local_1"."businessAttributesTrue"
UNION
SELECT "local_2"."biz_attr_false"."attr_id" AS "attribute_id", "local_2"."biz_attr_false"."biz_id" AS "business_id", "local_2"."biz_attr_false"."attr_val" AS "attribute_value" FROM "local_2"."biz_attr_false"
UNION
SELECT "local_2"."biz_attr_mixed"."attr_id" AS "attribute_id", "local_2"."biz_attr_mixed"."biz_id" AS "business_id", "local_2"."biz_attr_mixed"."attr_val" AS "attribute_value" FROM "local_2"."biz_attr_mixed";

-- Reconstruct Business_Categories from local_3.BusinessCategoryMapping
CREATE VIEW "Business_Categories" AS
SELECT
    "local_3"."BusinessCategoryMapping"."BusinessId" AS "business_id",
    "local_3"."BusinessCategoryMapping"."CategoryId" AS "category_id"
FROM "local_3"."BusinessCategoryMapping";

-- Reconstruct Business_Hours from row partitions (UNION (overlap))
CREATE VIEW "Business_Hours" AS
SELECT "local_1"."businessHoursCloses10pm"."businessId" AS "business_id", "local_1"."businessHoursCloses10pm"."dayOfWeek" AS "day_id", "local_1"."businessHoursCloses10pm"."opensAt" AS "opening_time", "local_1"."businessHoursCloses10pm"."closesAt" AS "closing_time" FROM "local_1"."businessHoursCloses10pm"
UNION
SELECT "local_1"."businessHoursCloses5pm"."businessId" AS "business_id", "local_1"."businessHoursCloses5pm"."dayOfWeek" AS "day_id", "local_1"."businessHoursCloses5pm"."opensAt" AS "opening_time", "local_1"."businessHoursCloses5pm"."closesAt" AS "closing_time" FROM "local_1"."businessHoursCloses5pm"
UNION
SELECT "local_1"."businessHoursCloses6pm"."businessId" AS "business_id", "local_1"."businessHoursCloses6pm"."dayOfWeek" AS "day_id", "local_1"."businessHoursCloses6pm"."opensAt" AS "opening_time", "local_1"."businessHoursCloses6pm"."closesAt" AS "closing_time" FROM "local_1"."businessHoursCloses6pm"
UNION
SELECT "local_1"."businessHoursCloses7Or11Or2am"."businessId" AS "business_id", "local_1"."businessHoursCloses7Or11Or2am"."dayOfWeek" AS "day_id", "local_1"."businessHoursCloses7Or11Or2am"."opensAt" AS "opening_time", "local_1"."businessHoursCloses7Or11Or2am"."closesAt" AS "closing_time" FROM "local_1"."businessHoursCloses7Or11Or2am"
UNION
SELECT "local_1"."businessHoursCloses8pmOr12am"."businessId" AS "business_id", "local_1"."businessHoursCloses8pmOr12am"."dayOfWeek" AS "day_id", "local_1"."businessHoursCloses8pmOr12am"."opensAt" AS "opening_time", "local_1"."businessHoursCloses8pmOr12am"."closesAt" AS "closing_time" FROM "local_1"."businessHoursCloses8pmOr12am"
UNION
SELECT "local_4"."business_hours_closing_nine_pm"."business_ref_id" AS "business_id", "local_4"."business_hours_closing_nine_pm"."weekday_id" AS "day_id", "local_4"."business_hours_closing_nine_pm"."opens_at" AS "opening_time", "local_4"."business_hours_closing_nine_pm"."closes_at" AS "closing_time" FROM "local_4"."business_hours_closing_nine_pm"
UNION
SELECT "local_4"."business_hours_closing_other"."business_ref_id" AS "business_id", "local_4"."business_hours_closing_other"."weekday_id" AS "day_id", "local_4"."business_hours_closing_other"."opens_at" AS "opening_time", "local_4"."business_hours_closing_other"."closes_at" AS "closing_time" FROM "local_4"."business_hours_closing_other";

-- Reconstruct Categories from local_1.categoryCatalog
CREATE VIEW "Categories" AS
SELECT
    "local_1"."categoryCatalog"."categoryId" AS "category_id",
    "local_1"."categoryCatalog"."categoryLabel" AS "category_name"
FROM "local_1"."categoryCatalog";

-- Reconstruct Checkins from vertical split + row partition on a fragment
CREATE VIEW "Checkins" AS
SELECT t0.[businessKey], t0.[dayKey], t0.[labelAtMidnight], t1.[HourLabel01], t1.[HourLabel02], t1.[HourLabel03], t0.[labelAtFourAm], t0.[labelAtFiveAm], t0.[labelAtSixAm], t0.[labelAtSevenAm], t0.[labelAtEightAm], t0.[labelAtNineAm], t2.[HourLabel10], t3.[HourLabel11], t0.[labelAtNoon], t0.[labelAtOnePm], t0.[labelAtTwoPm], t4.[HourLabel15], t0.[labelAtFourPm], t0.[labelAtFivePm], t0.[labelAtSixPm], t0.[labelAtSevenPm], t0.[labelAtEightPm], t0.[labelAtNinePm], t2.[HourLabel22], t3.[HourLabel23]
FROM [local_5].[checkinLabelsByDay] t0
JOIN [local_3].[CheckinsHoursOneToThree] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_3].[CheckinsHoursTenAndTwentyTwo] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN [local_3].[CheckinsHoursElevenAndTwentyThree] t3 ON t0.[__orig_rowid] = t3.[__orig_rowid]
JOIN (
SELECT [CheckinsHours00And12To21WithNoneAt21].[__orig_rowid] AS __orig_rowid, [local_3].[CheckinsHours00And12To21WithNoneAt21].[BusinessId], [local_3].[CheckinsHours00And12To21WithNoneAt21].[DayId], [local_3].[CheckinsHours00And12To21WithNoneAt21].[HourLabel00], [local_3].[CheckinsHours00And12To21WithNoneAt21].[HourLabel12], [local_3].[CheckinsHours00And12To21WithNoneAt21].[HourLabel13], [local_3].[CheckinsHours00And12To21WithNoneAt21].[HourLabel14], [local_3].[CheckinsHours00And12To21WithNoneAt21].[HourLabel15], [local_3].[CheckinsHours00And12To21WithNoneAt21].[HourLabel16], [local_3].[CheckinsHours00And12To21WithNoneAt21].[HourLabel17], [local_3].[CheckinsHours00And12To21WithNoneAt21].[HourLabel18], [local_3].[CheckinsHours00And12To21WithNoneAt21].[HourLabel19], [local_3].[CheckinsHours00And12To21WithNoneAt21].[HourLabel20], [local_3].[CheckinsHours00And12To21WithNoneAt21].[HourLabel21] FROM [local_3].[CheckinsHours00And12To21WithNoneAt21]
UNION
SELECT [CheckinsHours00And12To21WithVaried21].[__orig_rowid] AS __orig_rowid, [local_3].[CheckinsHours00And12To21WithVaried21].[BusinessId], [local_3].[CheckinsHours00And12To21WithVaried21].[DayId], [local_3].[CheckinsHours00And12To21WithVaried21].[HourLabel00], [local_3].[CheckinsHours00And12To21WithVaried21].[HourLabel12], [local_3].[CheckinsHours00And12To21WithVaried21].[HourLabel13], [local_3].[CheckinsHours00And12To21WithVaried21].[HourLabel14], [local_3].[CheckinsHours00And12To21WithVaried21].[HourLabel15], [local_3].[CheckinsHours00And12To21WithVaried21].[HourLabel16], [local_3].[CheckinsHours00And12To21WithVaried21].[HourLabel17], [local_3].[CheckinsHours00And12To21WithVaried21].[HourLabel18], [local_3].[CheckinsHours00And12To21WithVaried21].[HourLabel19], [local_3].[CheckinsHours00And12To21WithVaried21].[HourLabel20], [local_3].[CheckinsHours00And12To21WithVaried21].[HourLabel21] FROM [local_3].[CheckinsHours00And12To21WithVaried21]
) t4 ON t0.[__orig_rowid] = t4.[__orig_rowid];

-- Reconstruct Compliments from local_2.compl_type_ref
CREATE VIEW "Compliments" AS
SELECT
    "local_2"."compl_type_ref"."compl_id" AS "compliment_id",
    "local_2"."compl_type_ref"."compl_label" AS "compliment_type"
FROM "local_2"."compl_type_ref";

-- Reconstruct Days from local_3.DaysOfWeek
CREATE VIEW "Days" AS
SELECT
    "local_3"."DaysOfWeek"."DayId" AS "day_id",
    "local_3"."DaysOfWeek"."DayName" AS "day_of_week"
FROM "local_3"."DaysOfWeek";

-- Reconstruct Elite from local_4.elite_membership_by_year
CREATE VIEW "Elite" AS
SELECT
    "local_4"."elite_membership_by_year"."user_ref_id" AS "user_id",
    "local_4"."elite_membership_by_year"."award_year" AS "year_id"
FROM "local_4"."elite_membership_by_year";

-- Reconstruct Reviews from row partitions (UNION (overlap))
CREATE VIEW "Reviews" AS
SELECT "local_1"."reviewsStarsUpTo3"."businessId" AS "business_id", "local_1"."reviewsStarsUpTo3"."userId" AS "user_id", "local_1"."reviewsStarsUpTo3"."starRating" AS "review_stars", "local_1"."reviewsStarsUpTo3"."votesFunny" AS "review_votes_funny", "local_1"."reviewsStarsUpTo3"."votesUseful" AS "review_votes_useful", "local_1"."reviewsStarsUpTo3"."votesCool" AS "review_votes_cool", "local_1"."reviewsStarsUpTo3"."contentLength" AS "review_length" FROM "local_1"."reviewsStarsUpTo3"
UNION
SELECT "local_1"."reviewsAbove4OrNull"."businessId" AS "business_id", "local_1"."reviewsAbove4OrNull"."userId" AS "user_id", "local_1"."reviewsAbove4OrNull"."starRating" AS "review_stars", "local_1"."reviewsAbove4OrNull"."votesFunny" AS "review_votes_funny", "local_1"."reviewsAbove4OrNull"."votesUseful" AS "review_votes_useful", "local_1"."reviewsAbove4OrNull"."votesCool" AS "review_votes_cool", "local_1"."reviewsAbove4OrNull"."contentLength" AS "review_length" FROM "local_1"."reviewsAbove4OrNull"
UNION
SELECT "local_3"."ReviewsStarsGreaterThanThreeUpToFour"."BusinessId" AS "business_id", "local_3"."ReviewsStarsGreaterThanThreeUpToFour"."UserId" AS "user_id", "local_3"."ReviewsStarsGreaterThanThreeUpToFour"."ReviewStars" AS "review_stars", "local_3"."ReviewsStarsGreaterThanThreeUpToFour"."VotesFunny" AS "review_votes_funny", "local_3"."ReviewsStarsGreaterThanThreeUpToFour"."VotesUseful" AS "review_votes_useful", "local_3"."ReviewsStarsGreaterThanThreeUpToFour"."VotesCool" AS "review_votes_cool", "local_3"."ReviewsStarsGreaterThanThreeUpToFour"."ReviewTextLength" AS "review_length" FROM "local_3"."ReviewsStarsGreaterThanThreeUpToFour";

-- Reconstruct Tips from row partitions (UNION (overlap))
CREATE VIEW "Tips" AS
SELECT "local_1"."tipsShortLongOrNull"."businessId" AS "business_id", "local_1"."tipsShortLongOrNull"."userId" AS "user_id", "local_1"."tipsShortLongOrNull"."likeCount" AS "likes", "local_1"."tipsShortLongOrNull"."tipLengthCategory" AS "tip_length" FROM "local_1"."tipsShortLongOrNull"
UNION
SELECT "local_4"."tips_medium_length"."business_ref_id" AS "business_id", "local_4"."tips_medium_length"."user_ref_id" AS "user_id", "local_4"."tips_medium_length"."like_count" AS "likes", "local_4"."tips_medium_length"."length_bucket" AS "tip_length" FROM "local_4"."tips_medium_length";

-- Reconstruct Users from vertical split + row partition on a fragment
CREATE VIEW "Users" AS
SELECT t0.[user_ref_id], t0.[yelping_since_year], t0.[average_stars], t1.[votesFunny], t1.[votesUseful], t1.[votesCool], t0.[review_count], t0.[fan_count]
FROM [local_4].[user_profile_summary] t0
JOIN (
SELECT [usersAvgStars3Point0].[__orig_rowid] AS __orig_rowid, [local_1].[usersAvgStars3Point0].[userId], [local_1].[usersAvgStars3Point0].[yelpingSinceYear], [local_1].[usersAvgStars3Point0].[averageStars], [local_1].[usersAvgStars3Point0].[votesFunny], [local_1].[usersAvgStars3Point0].[votesUseful], [local_1].[usersAvgStars3Point0].[votesCool], [local_1].[usersAvgStars3Point0].[fanCount] FROM [local_1].[usersAvgStars3Point0]
UNION
SELECT [usersAvgStars3Point5].[__orig_rowid] AS __orig_rowid, [local_1].[usersAvgStars3Point5].[userId], [local_1].[usersAvgStars3Point5].[yelpingSinceYear], [local_1].[usersAvgStars3Point5].[averageStars], [local_1].[usersAvgStars3Point5].[votesFunny], [local_1].[usersAvgStars3Point5].[votesUseful], [local_1].[usersAvgStars3Point5].[votesCool], [local_1].[usersAvgStars3Point5].[fanCount] FROM [local_1].[usersAvgStars3Point5]
UNION
SELECT [usersAvgStars4Point5].[__orig_rowid] AS __orig_rowid, [local_1].[usersAvgStars4Point5].[userId], [local_1].[usersAvgStars4Point5].[yelpingSinceYear], [local_1].[usersAvgStars4Point5].[averageStars], [local_1].[usersAvgStars4Point5].[votesFunny], [local_1].[usersAvgStars4Point5].[votesUseful], [local_1].[usersAvgStars4Point5].[votesCool], [local_1].[usersAvgStars4Point5].[fanCount] FROM [local_1].[usersAvgStars4Point5]
UNION
SELECT [usersAvgStars5Point0].[__orig_rowid] AS __orig_rowid, [local_1].[usersAvgStars5Point0].[userId], [local_1].[usersAvgStars5Point0].[yelpingSinceYear], [local_1].[usersAvgStars5Point0].[averageStars], [local_1].[usersAvgStars5Point0].[votesFunny], [local_1].[usersAvgStars5Point0].[votesUseful], [local_1].[usersAvgStars5Point0].[votesCool], [local_1].[usersAvgStars5Point0].[fanCount] FROM [local_1].[usersAvgStars5Point0]
UNION
SELECT [usersAvgStarsVeryLowOrNull].[__orig_rowid] AS __orig_rowid, [local_1].[usersAvgStarsVeryLowOrNull].[userId], [local_1].[usersAvgStarsVeryLowOrNull].[yelpingSinceYear], [local_1].[usersAvgStarsVeryLowOrNull].[averageStars], [local_1].[usersAvgStarsVeryLowOrNull].[votesFunny], [local_1].[usersAvgStarsVeryLowOrNull].[votesUseful], [local_1].[usersAvgStarsVeryLowOrNull].[votesCool], [local_1].[usersAvgStarsVeryLowOrNull].[fanCount] FROM [local_1].[usersAvgStarsVeryLowOrNull]
UNION
SELECT [user_profile_fixed_four_point_zero_stars].[__orig_rowid] AS __orig_rowid, [local_4].[user_profile_fixed_four_point_zero_stars].[user_ref_id], [local_4].[user_profile_fixed_four_point_zero_stars].[yelping_since_year], [local_4].[user_profile_fixed_four_point_zero_stars].[average_stars], [local_4].[user_profile_fixed_four_point_zero_stars].[votes_funny], [local_4].[user_profile_fixed_four_point_zero_stars].[votes_useful], [local_4].[user_profile_fixed_four_point_zero_stars].[votes_cool], [local_4].[user_profile_fixed_four_point_zero_stars].[fan_count] FROM [local_4].[user_profile_fixed_four_point_zero_stars]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct Users_Compliments from row partitions (UNION (overlap))
CREATE VIEW "Users_Compliments" AS
SELECT "local_2"."user_compl_low"."compl_id" AS "compliment_id", "local_2"."user_compl_low"."usr_id" AS "user_id", "local_2"."user_compl_low"."compl_level" AS "number_of_compliments" FROM "local_2"."user_compl_low"
UNION
SELECT "local_4"."user_compliments_medium_high_uber_or_null"."compliment_ref_id" AS "compliment_id", "local_4"."user_compliments_medium_high_uber_or_null"."user_ref_id" AS "user_id", "local_4"."user_compliments_medium_high_uber_or_null"."compliments_tier" AS "number_of_compliments" FROM "local_4"."user_compliments_medium_high_uber_or_null";

-- Reconstruct Years from local_5.calendarYears
CREATE VIEW "Years" AS
SELECT
    "local_5"."calendarYears"."yearKey" AS "year_id",
    "local_5"."calendarYears"."yearNumber" AS "actual_year"
FROM "local_5"."calendarYears";
