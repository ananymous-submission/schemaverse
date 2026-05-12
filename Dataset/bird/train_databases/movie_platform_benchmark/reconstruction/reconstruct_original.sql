-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct lists from vertical split + row partition on a fragment
CREATE VIEW "lists" AS
SELECT t1.[ownerUserId], t0.[collection_id], t1.[title], t1.[movieCount], t2.[updated_at_utc], t2.[created_at_utc], t1.[followerCount], t1.[url], t1.[commentCount], t1.[description], t0.[cover_image_url], t0.[hero_image_url], t0.[feature_image_url], t0.[thumbnail_image_url]
FROM [local_1].[curated_collections] t0
JOIN (
SELECT [listsWithNonPositiveComments].[__orig_rowid] AS __orig_rowid, [local_2].[listsWithNonPositiveComments].[ownerUserId], [local_2].[listsWithNonPositiveComments].[listId], [local_2].[listsWithNonPositiveComments].[title], [local_2].[listsWithNonPositiveComments].[movieCount], [local_2].[listsWithNonPositiveComments].[followerCount], [local_2].[listsWithNonPositiveComments].[url], [local_2].[listsWithNonPositiveComments].[commentCount], [local_2].[listsWithNonPositiveComments].[description] FROM [local_2].[listsWithNonPositiveComments]
UNION
SELECT [listsWithPositiveOrNullComments].[__orig_rowid] AS __orig_rowid, [local_2].[listsWithPositiveOrNullComments].[ownerUserId], [local_2].[listsWithPositiveOrNullComments].[listId], [local_2].[listsWithPositiveOrNullComments].[title], [local_2].[listsWithPositiveOrNullComments].[movieCount], [local_2].[listsWithPositiveOrNullComments].[followerCount], [local_2].[listsWithPositiveOrNullComments].[url], [local_2].[listsWithPositiveOrNullComments].[commentCount], [local_2].[listsWithPositiveOrNullComments].[description] FROM [local_2].[listsWithPositiveOrNullComments]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_1].[collection_details] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct lists_users from vertical split + row partition on a fragment
CREATE VIEW "lists_users" AS
SELECT t0.[userId], t0.[listId], t0.[updatedAtUtc], t0.[createdAtUtc], t1.[isTrialUser], t1.[subscriptionLevel], t1.[avatarUrl], t1.[coverUrl], t1.[eligibleForTrial], t1.[hasPaymentMethod]
FROM [local_2].[userListLinks] t0
JOIN [local_2].[listUserAccounts] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN (
SELECT [usersWithNonPositiveSubscription].[__orig_rowid] AS __orig_rowid, [local_2].[usersWithNonPositiveSubscription].[userId], [local_2].[usersWithNonPositiveSubscription].[listId], [local_2].[usersWithNonPositiveSubscription].[isTrialUser], [local_2].[usersWithNonPositiveSubscription].[subscriptionLevel], [local_2].[usersWithNonPositiveSubscription].[eligibleForTrial], [local_2].[usersWithNonPositiveSubscription].[hasPaymentMethod] FROM [local_2].[usersWithNonPositiveSubscription]
UNION
SELECT [usersWithPositiveOrNullSubscription].[__orig_rowid] AS __orig_rowid, [local_2].[usersWithPositiveOrNullSubscription].[userId], [local_2].[usersWithPositiveOrNullSubscription].[listId], [local_2].[usersWithPositiveOrNullSubscription].[isTrialUser], [local_2].[usersWithPositiveOrNullSubscription].[subscriptionLevel], [local_2].[usersWithPositiveOrNullSubscription].[eligibleForTrial], [local_2].[usersWithPositiveOrNullSubscription].[hasPaymentMethod] FROM [local_2].[usersWithPositiveOrNullSubscription]
) t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];

-- Reconstruct movies from vertical split + row partition on a fragment
CREATE VIEW "movies" AS
SELECT t0.[MovieId], t0.[Title], t0.[ReleaseYear], t1.[MoviePageUrl], t0.[TitleLanguage], t0.[PopularityScore], t0.[MoviePosterUrl], t0.[DirectorId], t0.[DirectorName], t1.[DirectorProfileUrl]
FROM (
SELECT [MoviesByDirector1982To2004].[__orig_rowid] AS __orig_rowid, [local_3].[MoviesByDirector1982To2004].[MovieId], [local_3].[MoviesByDirector1982To2004].[Title], [local_3].[MoviesByDirector1982To2004].[ReleaseYear], [local_3].[MoviesByDirector1982To2004].[TitleLanguage], [local_3].[MoviesByDirector1982To2004].[PopularityScore], [local_3].[MoviesByDirector1982To2004].[MoviePosterUrl], [local_3].[MoviesByDirector1982To2004].[DirectorId], [local_3].[MoviesByDirector1982To2004].[DirectorName] FROM [local_3].[MoviesByDirector1982To2004]
UNION
SELECT [MoviesByDirector2005To2014].[__orig_rowid] AS __orig_rowid, [local_3].[MoviesByDirector2005To2014].[MovieId], [local_3].[MoviesByDirector2005To2014].[Title], [local_3].[MoviesByDirector2005To2014].[ReleaseYear], [local_3].[MoviesByDirector2005To2014].[TitleLanguage], [local_3].[MoviesByDirector2005To2014].[PopularityScore], [local_3].[MoviesByDirector2005To2014].[MoviePosterUrl], [local_3].[MoviesByDirector2005To2014].[DirectorId], [local_3].[MoviesByDirector2005To2014].[DirectorName] FROM [local_3].[MoviesByDirector2005To2014]
UNION
SELECT [MoviesByDirectorAfter2014OrUnknown].[__orig_rowid] AS __orig_rowid, [local_3].[MoviesByDirectorAfter2014OrUnknown].[MovieId], [local_3].[MoviesByDirectorAfter2014OrUnknown].[Title], [local_3].[MoviesByDirectorAfter2014OrUnknown].[ReleaseYear], [local_3].[MoviesByDirectorAfter2014OrUnknown].[TitleLanguage], [local_3].[MoviesByDirectorAfter2014OrUnknown].[PopularityScore], [local_3].[MoviesByDirectorAfter2014OrUnknown].[MoviePosterUrl], [local_3].[MoviesByDirectorAfter2014OrUnknown].[DirectorId], [local_3].[MoviesByDirectorAfter2014OrUnknown].[DirectorName] FROM [local_3].[MoviesByDirectorAfter2014OrUnknown]
UNION
SELECT [MoviesByDirectorThrough1981].[__orig_rowid] AS __orig_rowid, [local_3].[MoviesByDirectorThrough1981].[MovieId], [local_3].[MoviesByDirectorThrough1981].[Title], [local_3].[MoviesByDirectorThrough1981].[ReleaseYear], [local_3].[MoviesByDirectorThrough1981].[TitleLanguage], [local_3].[MoviesByDirectorThrough1981].[PopularityScore], [local_3].[MoviesByDirectorThrough1981].[MoviePosterUrl], [local_3].[MoviesByDirectorThrough1981].[DirectorId], [local_3].[MoviesByDirectorThrough1981].[DirectorName] FROM [local_3].[MoviesByDirectorThrough1981]
) t0
JOIN [local_3].[MoviesDirectorOverview] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct ratings from local_3.MovieRatings
CREATE VIEW "ratings" AS
SELECT
    "local_3"."MovieRatings"."MovieId" AS "movie_id",
    "local_3"."MovieRatings"."RatingId" AS "rating_id",
    "local_3"."MovieRatings"."RatingSourceUrl" AS "rating_url",
    "local_3"."MovieRatings"."Score" AS "rating_score",
    "local_3"."MovieRatings"."ReviewTimestampUtc" AS "rating_timestamp_utc",
    "local_3"."MovieRatings"."CriticName" AS "critic",
    "local_3"."MovieRatings"."CriticLikesCount" AS "critic_likes",
    "local_3"."MovieRatings"."CriticCommentsCount" AS "critic_comments",
    "local_3"."MovieRatings"."UserId" AS "user_id",
    "local_3"."MovieRatings"."IsTrialist" AS "user_trialist",
    "local_3"."MovieRatings"."IsSubscriber" AS "user_subscriber",
    "local_3"."MovieRatings"."IsEligibleForTrial" AS "user_eligible_for_trial",
    "local_3"."MovieRatings"."HasPaymentMethod" AS "user_has_payment_method"
FROM "local_3"."MovieRatings";

-- Reconstruct ratings_users from local_2.ratingUserAttributes
CREATE VIEW "ratings_users" AS
SELECT
    "local_2"."ratingUserAttributes"."userId" AS "user_id",
    "local_2"."ratingUserAttributes"."ratingDateUtc" AS "rating_date_utc",
    "local_2"."ratingUserAttributes"."isTrialUser" AS "user_trialist",
    "local_2"."ratingUserAttributes"."subscriptionLevel" AS "user_subscriber",
    "local_2"."ratingUserAttributes"."avatarUrl" AS "user_avatar_image_url",
    "local_2"."ratingUserAttributes"."coverUrl" AS "user_cover_image_url",
    "local_2"."ratingUserAttributes"."eligibleForTrial" AS "user_eligible_for_trial",
    "local_2"."ratingUserAttributes"."hasPaymentMethod" AS "user_has_payment_method"
FROM "local_2"."ratingUserAttributes";
