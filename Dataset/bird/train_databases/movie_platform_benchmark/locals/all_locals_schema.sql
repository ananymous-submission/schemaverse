-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/movie_platform/movie_platform.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "curated_collections" (
    "collection_id" INTEGER,
    "cover_image_url" TEXT,
    "hero_image_url" TEXT,
    "feature_image_url" TEXT,
    "thumbnail_image_url" TEXT
);

CREATE TABLE "collection_details" (
    "collection_id" INTEGER,
    "cover_image_url" TEXT,
    "created_at_utc" TEXT,
    "description" TEXT,
    "follower_count" INTEGER,
    "title" TEXT,
    "updated_at_utc" TEXT,
    "external_url" TEXT,
    "owner_user_id" INTEGER
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "userListLinks" (
    "userId" INTEGER,
    "listId" INTEGER,
    "createdAtUtc" TEXT,
    "updatedAtUtc" TEXT
);

CREATE TABLE "listUserAccounts" (
    "userId" INTEGER,
    "listId" INTEGER,
    "avatarUrl" TEXT,
    "coverUrl" TEXT,
    "eligibleForTrial" TEXT,
    "hasPaymentMethod" TEXT,
    "subscriptionLevel" INTEGER,
    "isTrialUser" INTEGER,
    FOREIGN KEY ("listId") REFERENCES "listsWithNonPositiveComments"("listId")
);

CREATE TABLE "usersWithNonPositiveSubscription" (
    "userId" INTEGER,
    "listId" INTEGER,
    "eligibleForTrial" TEXT,
    "hasPaymentMethod" TEXT,
    "subscriptionLevel" INTEGER,
    "isTrialUser" INTEGER,
    FOREIGN KEY ("userId") REFERENCES "listsWithNonPositiveComments"("ownerUserId")
);

CREATE TABLE "usersWithPositiveOrNullSubscription" (
    "userId" INTEGER,
    "listId" INTEGER,
    "eligibleForTrial" TEXT,
    "hasPaymentMethod" TEXT,
    "subscriptionLevel" INTEGER,
    "isTrialUser" INTEGER,
    FOREIGN KEY ("userId") REFERENCES "listsWithPositiveOrNullComments"("ownerUserId"),
    FOREIGN KEY ("listId") REFERENCES "listsWithPositiveOrNullComments"("listId")
);

CREATE TABLE "ratingUserAttributes" (
    "userId" INTEGER,
    "ratingDateUtc" TEXT,
    "isTrialUser" INTEGER,
    "subscriptionLevel" INTEGER,
    "avatarUrl" TEXT,
    "coverUrl" TEXT,
    "eligibleForTrial" INTEGER,
    "hasPaymentMethod" INTEGER,
    FOREIGN KEY ("userId") REFERENCES "userListLinks"("userId"),
    FOREIGN KEY ("userId") REFERENCES "listUserAccounts"("userId")
);

CREATE TABLE "listsWithNonPositiveComments" (
    "listId" INTEGER,
    "commentCount" INTEGER,
    "description" TEXT,
    "followerCount" INTEGER,
    "movieCount" INTEGER,
    "title" TEXT,
    "url" TEXT,
    "ownerUserId" INTEGER,
    FOREIGN KEY ("ownerUserId") REFERENCES "usersWithPositiveOrNullSubscription"("userId")
);

CREATE TABLE "listsWithPositiveOrNullComments" (
    "listId" INTEGER,
    "commentCount" INTEGER,
    "description" TEXT,
    "followerCount" INTEGER,
    "movieCount" INTEGER,
    "title" TEXT,
    "url" TEXT,
    "ownerUserId" INTEGER,
    FOREIGN KEY ("ownerUserId") REFERENCES "listUserAccounts"("userId"),
    FOREIGN KEY ("ownerUserId") REFERENCES "usersWithNonPositiveSubscription"("userId")
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "MoviesByDirectorThrough1981" (
    "MovieId" INTEGER,
    "DirectorId" TEXT,
    "DirectorName" TEXT,
    "MoviePosterUrl" TEXT,
    "PopularityScore" INTEGER,
    "ReleaseYear" INTEGER,
    "Title" TEXT,
    "TitleLanguage" TEXT
);

CREATE TABLE "MoviesByDirector1982To2004" (
    "MovieId" INTEGER,
    "DirectorId" TEXT,
    "DirectorName" TEXT,
    "MoviePosterUrl" TEXT,
    "PopularityScore" INTEGER,
    "ReleaseYear" INTEGER,
    "Title" TEXT,
    "TitleLanguage" TEXT
);

CREATE TABLE "MoviesByDirector2005To2014" (
    "MovieId" INTEGER,
    "DirectorId" TEXT,
    "DirectorName" TEXT,
    "MoviePosterUrl" TEXT,
    "PopularityScore" INTEGER,
    "ReleaseYear" INTEGER,
    "Title" TEXT,
    "TitleLanguage" TEXT
);

CREATE TABLE "MoviesByDirectorAfter2014OrUnknown" (
    "MovieId" INTEGER,
    "DirectorId" TEXT,
    "DirectorName" TEXT,
    "MoviePosterUrl" TEXT,
    "PopularityScore" INTEGER,
    "ReleaseYear" INTEGER,
    "Title" TEXT,
    "TitleLanguage" TEXT
);

CREATE TABLE "MoviesDirectorOverview" (
    "MovieId" INTEGER,
    "DirectorId" TEXT,
    "DirectorProfileUrl" TEXT,
    "MoviePosterUrl" TEXT,
    "PopularityScore" INTEGER,
    "ReleaseYear" INTEGER,
    "MoviePageUrl" TEXT
);

CREATE TABLE "MovieRatings" (
    "MovieId" INTEGER,
    "RatingId" INTEGER,
    "RatingSourceUrl" TEXT,
    "Score" INTEGER,
    "ReviewTimestampUtc" TEXT,
    "CriticName" TEXT,
    "CriticLikesCount" INTEGER,
    "CriticCommentsCount" INTEGER,
    "UserId" INTEGER,
    "IsTrialist" INTEGER,
    "IsSubscriber" INTEGER,
    "IsEligibleForTrial" INTEGER,
    "HasPaymentMethod" INTEGER,
    FOREIGN KEY ("RatingId") REFERENCES "MovieRatings"("RatingId"),
    FOREIGN KEY ("MovieId") REFERENCES "MoviesByDirectorThrough1981"("MovieId"),
    FOREIGN KEY ("MovieId") REFERENCES "MoviesByDirector1982To2004"("MovieId"),
    FOREIGN KEY ("MovieId") REFERENCES "MoviesByDirector2005To2014"("MovieId")
);

