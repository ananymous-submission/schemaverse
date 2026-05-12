-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct categories from local_3.pod_cat_map
CREATE VIEW "categories" AS
SELECT
    "local_3"."pod_cat_map"."pod_id" AS "podcast_id",
    "local_3"."pod_cat_map"."cat_tag" AS "category"
FROM "local_3"."pod_cat_map";

-- Reconstruct podcasts from local_1.PodcastSeries
CREATE VIEW "podcasts" AS
SELECT
    "local_1"."PodcastSeries"."SeriesId" AS "podcast_id",
    "local_1"."PodcastSeries"."ItunesIdentifier" AS "itunes_id",
    "local_1"."PodcastSeries"."UrlSlug" AS "slug",
    "local_1"."PodcastSeries"."ItunesLink" AS "itunes_url",
    "local_1"."PodcastSeries"."SeriesTitle" AS "title"
FROM "local_1"."PodcastSeries";

-- Reconstruct reviews from local_1.PodcastReview
CREATE VIEW "reviews" AS
SELECT
    "local_1"."PodcastReview"."SeriesId" AS "podcast_id",
    "local_1"."PodcastReview"."ReviewTitle" AS "title",
    "local_1"."PodcastReview"."ReviewContent" AS "content",
    "local_1"."PodcastReview"."RatingScore" AS "rating",
    "local_1"."PodcastReview"."ReviewerId" AS "author_id",
    "local_1"."PodcastReview"."SubmittedAt" AS "created_at"
FROM "local_1"."PodcastReview";

-- Reconstruct runs from local_2.batch_executions
CREATE VIEW "runs" AS
SELECT
    "local_2"."batch_executions"."executed_at" AS "run_at",
    "local_2"."batch_executions"."highest_record_id" AS "max_rowid",
    "local_2"."batch_executions"."inserted_reviews_count" AS "reviews_added"
FROM "local_2"."batch_executions";
