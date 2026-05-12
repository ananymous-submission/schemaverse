-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct location from local_1.geoLocation
CREATE VIEW "location" AS
SELECT
    "local_1"."geoLocation"."placeId" AS "LocationID",
    "local_1"."geoLocation"."countryName" AS "Country",
    "local_1"."geoLocation"."stateName" AS "State",
    "local_1"."geoLocation"."stateAbbreviation" AS "StateCode",
    "local_1"."geoLocation"."cityName" AS "City"
FROM "local_1"."geoLocation";

-- Reconstruct twitter from vertical split + row partition on a fragment
CREATE VIEW "twitter" AS
SELECT t0.[tweet_id], t0.[weekday_name], t0.[hour_of_day], t0.[day_of_month], t0.[language_code], t2.[isRepost], t3.[reach_estimate], t3.[retweet_count], t3.[like_count], t1.[influenceScore], t1.[sentimentScore], t0.[tweet_text], t1.[placeId], t0.[user_profile_id]
FROM [local_2].[tweet_daily_stats] t0
JOIN [local_1].[tweetHourlyStats] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[tweetReshareInfo] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid]
JOIN (
SELECT [tweet_reach_above_1494].[__orig_rowid] AS __orig_rowid, [local_2].[tweet_reach_above_1494].[tweet_id], [local_2].[tweet_reach_above_1494].[reach_estimate], [local_2].[tweet_reach_above_1494].[retweet_count], [local_2].[tweet_reach_above_1494].[like_count] FROM [local_2].[tweet_reach_above_1494]
UNION
SELECT [TwitterLikesReachAbove151To448].[__orig_rowid] AS __orig_rowid, [local_3].[TwitterLikesReachAbove151To448].[TweetIdentifier], [local_3].[TwitterLikesReachAbove151To448].[AudienceReach], [local_3].[TwitterLikesReachAbove151To448].[RetweetTotal], [local_3].[TwitterLikesReachAbove151To448].[LikeCount] FROM [local_3].[TwitterLikesReachAbove151To448]
UNION
SELECT [TwitterLikesReachAbove448To1494].[__orig_rowid] AS __orig_rowid, [local_3].[TwitterLikesReachAbove448To1494].[TweetIdentifier], [local_3].[TwitterLikesReachAbove448To1494].[AudienceReach], [local_3].[TwitterLikesReachAbove448To1494].[RetweetTotal], [local_3].[TwitterLikesReachAbove448To1494].[LikeCount] FROM [local_3].[TwitterLikesReachAbove448To1494]
UNION
SELECT [TwitterLikesReachUpTo151].[__orig_rowid] AS __orig_rowid, [local_3].[TwitterLikesReachUpTo151].[TweetIdentifier], [local_3].[TwitterLikesReachUpTo151].[AudienceReach], [local_3].[TwitterLikesReachUpTo151].[RetweetTotal], [local_3].[TwitterLikesReachUpTo151].[LikeCount] FROM [local_3].[TwitterLikesReachUpTo151]
) t3 ON t0.[__orig_rowid] = t3.[__orig_rowid];

-- Reconstruct user from row partitions (UNION (overlap))
CREATE VIEW "user" AS
SELECT "local_2"."user_profiles_unknown_gender"."user_profile_id" AS "UserID", "local_2"."user_profiles_unknown_gender"."gender_value" AS "Gender" FROM "local_2"."user_profiles_unknown_gender"
UNION
SELECT "local_3"."UsersGenderMale"."UserIdentifier" AS "UserID", "local_3"."UsersGenderMale"."GenderLabel" AS "Gender" FROM "local_3"."UsersGenderMale"
UNION
SELECT "local_3"."UsersGenderFemaleOrUnisexOrNull"."UserIdentifier" AS "UserID", "local_3"."UsersGenderFemaleOrUnisexOrNull"."GenderLabel" AS "Gender" FROM "local_3"."UsersGenderFemaleOrUnisexOrNull";
