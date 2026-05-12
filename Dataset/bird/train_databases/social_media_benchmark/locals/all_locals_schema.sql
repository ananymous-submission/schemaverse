-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/social_media/social_media.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "geoLocation" (
    "placeId" INTEGER,
    "countryName" TEXT,
    "stateName" TEXT,
    "stateAbbreviation" TEXT,
    "cityName" TEXT
);

CREATE TABLE "tweetHourlyStats" (
    "statusId" TEXT,
    "hourOfDay" INTEGER,
    "influenceScore" INTEGER,
    "placeId" INTEGER,
    "sentimentScore" REAL,
    "authorId" TEXT
);

CREATE TABLE "tweetReshareInfo" (
    "statusId" TEXT,
    "isRepost" TEXT,
    "influenceScore" INTEGER,
    "languageCode" TEXT,
    "sentimentScore" REAL,
    "tweetText" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "tweet_daily_stats" (
    "tweet_id" TEXT,
    "day_of_month" INTEGER,
    "hour_of_day" INTEGER,
    "language_code" TEXT,
    "user_profile_id" TEXT,
    "weekday_name" TEXT,
    "tweet_text" TEXT,
    FOREIGN KEY ("user_profile_id") REFERENCES "user_profiles_unknown_gender"("user_profile_id")
);

CREATE TABLE "tweet_reach_above_1494" (
    "tweet_id" TEXT,
    "like_count" INTEGER,
    "reach_estimate" INTEGER,
    "retweet_count" INTEGER
);

CREATE TABLE "user_profiles_unknown_gender" (
    "user_profile_id" TEXT,
    "gender_value" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "UsersGenderMale" (
    "UserIdentifier" TEXT,
    "GenderLabel" TEXT
);

CREATE TABLE "UsersGenderFemaleOrUnisexOrNull" (
    "UserIdentifier" TEXT,
    "GenderLabel" TEXT
);

CREATE TABLE "TwitterLikesReachUpTo151" (
    "TweetIdentifier" TEXT,
    "LikeCount" INTEGER,
    "AudienceReach" INTEGER,
    "RetweetTotal" INTEGER
);

CREATE TABLE "TwitterLikesReachAbove151To448" (
    "TweetIdentifier" TEXT,
    "LikeCount" INTEGER,
    "AudienceReach" INTEGER,
    "RetweetTotal" INTEGER
);

CREATE TABLE "TwitterLikesReachAbove448To1494" (
    "TweetIdentifier" TEXT,
    "LikeCount" INTEGER,
    "AudienceReach" INTEGER,
    "RetweetTotal" INTEGER
);

