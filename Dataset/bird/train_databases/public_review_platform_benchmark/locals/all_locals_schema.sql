-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/public_review_platform/public_review_platform.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "attributeDefinitions" (
    "attributeId" INTEGER,
    "attributeLabel" TEXT
);

CREATE TABLE "businessesInPhoenix" (
    "businessId" INTEGER,
    "isActive" TEXT,
    "cityName" TEXT,
    "stateCode" TEXT,
    "averageRating" REAL,
    "totalReviewCount" TEXT
);

CREATE TABLE "businessesChandlerAndGlendale" (
    "businessId" INTEGER,
    "isActive" TEXT,
    "cityName" TEXT,
    "stateCode" TEXT,
    "averageRating" REAL,
    "totalReviewCount" TEXT
);

CREATE TABLE "categoryCatalog" (
    "categoryId" INTEGER,
    "categoryLabel" TEXT
);

CREATE TABLE "reviewsStarsUpTo3" (
    "businessId" INTEGER,
    "userId" INTEGER,
    "starRating" INTEGER,
    "votesFunny" TEXT,
    "votesUseful" TEXT,
    "votesCool" TEXT,
    "contentLength" TEXT
);

CREATE TABLE "reviewsAbove4OrNull" (
    "businessId" INTEGER,
    "userId" INTEGER,
    "starRating" INTEGER,
    "votesFunny" TEXT,
    "votesUseful" TEXT,
    "votesCool" TEXT,
    "contentLength" TEXT
);

CREATE TABLE "businessAttributesTrue" (
    "attributeId" INTEGER,
    "businessId" INTEGER,
    "attributeEnabled" TEXT
);

CREATE TABLE "businessHoursCloses10pm" (
    "businessId" INTEGER,
    "dayOfWeek" INTEGER,
    "opensAt" TEXT,
    "closesAt" TEXT
);

CREATE TABLE "businessHoursCloses5pm" (
    "businessId" INTEGER,
    "dayOfWeek" INTEGER,
    "opensAt" TEXT,
    "closesAt" TEXT
);

CREATE TABLE "businessHoursCloses6pm" (
    "businessId" INTEGER,
    "dayOfWeek" INTEGER,
    "opensAt" TEXT,
    "closesAt" TEXT
);

CREATE TABLE "businessHoursCloses7Or11Or2am" (
    "businessId" INTEGER,
    "dayOfWeek" INTEGER,
    "opensAt" TEXT,
    "closesAt" TEXT
);

CREATE TABLE "businessHoursCloses8pmOr12am" (
    "businessId" INTEGER,
    "dayOfWeek" INTEGER,
    "opensAt" TEXT,
    "closesAt" TEXT
);

CREATE TABLE "usersAvgStars3Point5" (
    "userId" INTEGER,
    "averageStars" TEXT,
    "fanCount" TEXT,
    "votesCool" TEXT,
    "votesFunny" TEXT,
    "votesUseful" TEXT,
    "yelpingSinceYear" INTEGER
);

CREATE TABLE "usersAvgStars5Point0" (
    "userId" INTEGER,
    "averageStars" TEXT,
    "fanCount" TEXT,
    "votesCool" TEXT,
    "votesFunny" TEXT,
    "votesUseful" TEXT,
    "yelpingSinceYear" INTEGER
);

CREATE TABLE "usersAvgStars4Point5" (
    "userId" INTEGER,
    "averageStars" TEXT,
    "fanCount" TEXT,
    "votesCool" TEXT,
    "votesFunny" TEXT,
    "votesUseful" TEXT,
    "yelpingSinceYear" INTEGER
);

CREATE TABLE "usersAvgStars3Point0" (
    "userId" INTEGER,
    "averageStars" TEXT,
    "fanCount" TEXT,
    "votesCool" TEXT,
    "votesFunny" TEXT,
    "votesUseful" TEXT,
    "yelpingSinceYear" INTEGER
);

CREATE TABLE "usersAvgStarsVeryLowOrNull" (
    "userId" INTEGER,
    "averageStars" TEXT,
    "fanCount" TEXT,
    "votesCool" TEXT,
    "votesFunny" TEXT,
    "votesUseful" TEXT,
    "yelpingSinceYear" INTEGER
);

CREATE TABLE "tipsShortLongOrNull" (
    "businessId" INTEGER,
    "userId" INTEGER,
    "likeCount" INTEGER,
    "tipLengthCategory" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "biz_attr_false" (
    "attr_id" INTEGER,
    "biz_id" INTEGER,
    "attr_val" TEXT
);

CREATE TABLE "biz_attr_mixed" (
    "attr_id" INTEGER,
    "biz_id" INTEGER,
    "attr_val" TEXT
);

CREATE TABLE "compl_type_ref" (
    "compl_id" INTEGER,
    "compl_label" TEXT
);

CREATE TABLE "user_compl_low" (
    "compl_id" INTEGER,
    "usr_id" INTEGER,
    "compl_level" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "BusinessCategoryMapping" (
    "BusinessId" INTEGER,
    "CategoryId" INTEGER
);

CREATE TABLE "DaysOfWeek" (
    "DayId" INTEGER,
    "DayName" TEXT
);

CREATE TABLE "BusinessInScottsdale" (
    "BusinessId" INTEGER,
    "IsActive" TEXT,
    "CityName" TEXT,
    "StateCode" TEXT,
    "AverageStars" REAL,
    "ReviewCount" TEXT
);

CREATE TABLE "BusinessTempeAndOther" (
    "BusinessId" INTEGER,
    "IsActive" TEXT,
    "CityName" TEXT,
    "StateCode" TEXT,
    "AverageStars" REAL,
    "ReviewCount" TEXT
);

CREATE TABLE "BusinessInMesaGilbertPeoriaSurprise" (
    "BusinessId" INTEGER,
    "IsActive" TEXT,
    "CityName" TEXT,
    "StateCode" TEXT,
    "AverageStars" REAL,
    "ReviewCount" TEXT
);

CREATE TABLE "ReviewsStarsGreaterThanThreeUpToFour" (
    "BusinessId" INTEGER,
    "UserId" INTEGER,
    "ReviewStars" INTEGER,
    "VotesFunny" TEXT,
    "VotesUseful" TEXT,
    "VotesCool" TEXT,
    "ReviewTextLength" TEXT
);

CREATE TABLE "CheckinsHoursTenAndTwentyTwo" (
    "BusinessId" INTEGER,
    "DayId" INTEGER,
    "HourLabel10" TEXT,
    "HourLabel22" TEXT
);

CREATE TABLE "CheckinsHoursElevenAndTwentyThree" (
    "BusinessId" INTEGER,
    "DayId" INTEGER,
    "HourLabel11" TEXT,
    "HourLabel23" TEXT
);

CREATE TABLE "CheckinsHoursOneToThree" (
    "BusinessId" INTEGER,
    "DayId" INTEGER,
    "HourLabel01" TEXT,
    "HourLabel02" TEXT,
    "HourLabel03" TEXT
);

CREATE TABLE "CheckinsHours00And12To21WithNoneAt21" (
    "BusinessId" INTEGER,
    "DayId" INTEGER,
    "HourLabel00" TEXT,
    "HourLabel12" TEXT,
    "HourLabel13" TEXT,
    "HourLabel14" TEXT,
    "HourLabel15" TEXT,
    "HourLabel16" TEXT,
    "HourLabel17" TEXT,
    "HourLabel18" TEXT,
    "HourLabel19" TEXT,
    "HourLabel20" TEXT,
    "HourLabel21" TEXT
);

CREATE TABLE "CheckinsHours00And12To21WithVaried21" (
    "BusinessId" INTEGER,
    "DayId" INTEGER,
    "HourLabel00" TEXT,
    "HourLabel12" TEXT,
    "HourLabel13" TEXT,
    "HourLabel14" TEXT,
    "HourLabel15" TEXT,
    "HourLabel16" TEXT,
    "HourLabel17" TEXT,
    "HourLabel18" TEXT,
    "HourLabel19" TEXT,
    "HourLabel20" TEXT,
    "HourLabel21" TEXT
);

-- ========================================================================
-- local_4
-- DDL file: local_4_schema.sql
-- ========================================================================

CREATE TABLE "business_hours_closing_nine_pm" (
    "business_ref_id" INTEGER,
    "weekday_id" INTEGER,
    "opens_at" TEXT,
    "closes_at" TEXT
);

CREATE TABLE "business_hours_closing_other" (
    "business_ref_id" INTEGER,
    "weekday_id" INTEGER,
    "opens_at" TEXT,
    "closes_at" TEXT
);

CREATE TABLE "elite_membership_by_year" (
    "user_ref_id" INTEGER,
    "award_year" INTEGER
);

CREATE TABLE "tips_medium_length" (
    "business_ref_id" INTEGER,
    "user_ref_id" INTEGER,
    "like_count" INTEGER,
    "length_bucket" TEXT
);

CREATE TABLE "user_profile_summary" (
    "user_ref_id" INTEGER,
    "average_stars" TEXT,
    "fan_count" TEXT,
    "review_count" TEXT,
    "yelping_since_year" INTEGER
);

CREATE TABLE "user_profile_fixed_four_point_zero_stars" (
    "user_ref_id" INTEGER,
    "average_stars" TEXT,
    "fan_count" TEXT,
    "votes_cool" TEXT,
    "votes_funny" TEXT,
    "votes_useful" TEXT,
    "yelping_since_year" INTEGER
);

CREATE TABLE "user_compliments_medium_high_uber_or_null" (
    "compliment_ref_id" INTEGER,
    "user_ref_id" INTEGER,
    "compliments_tier" TEXT
);

-- ========================================================================
-- local_5
-- DDL file: local_5_schema.sql
-- ========================================================================

CREATE TABLE "checkinLabelsByDay" (
    "businessKey" INTEGER,
    "dayKey" INTEGER,
    "labelAtMidnight" TEXT,
    "labelAtNoon" TEXT,
    "labelAtOnePm" TEXT,
    "labelAtTwoPm" TEXT,
    "labelAtFourPm" TEXT,
    "labelAtFivePm" TEXT,
    "labelAtSixPm" TEXT,
    "labelAtSevenPm" TEXT,
    "labelAtEightPm" TEXT,
    "labelAtNinePm" TEXT,
    "labelAtFourAm" TEXT,
    "labelAtFiveAm" TEXT,
    "labelAtSixAm" TEXT,
    "labelAtSevenAm" TEXT,
    "labelAtEightAm" TEXT,
    "labelAtNineAm" TEXT
);

CREATE TABLE "calendarYears" (
    "yearKey" INTEGER,
    "yearNumber" INTEGER
);

