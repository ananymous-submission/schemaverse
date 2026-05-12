-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";

-- Reconstruct playstore from local_1.apps_repo
CREATE VIEW "playstore" AS
SELECT
    "local_1"."apps_repo"."app_name" AS "App",
    "local_1"."apps_repo"."app_cat" AS "Category",
    "local_1"."apps_repo"."avg_rating" AS "Rating",
    "local_1"."apps_repo"."rev_count" AS "Reviews",
    "local_1"."apps_repo"."app_size" AS "Size",
    "local_1"."apps_repo"."inst_count" AS "Installs",
    "local_1"."apps_repo"."app_type" AS "Type",
    "local_1"."apps_repo"."price_amt" AS "Price",
    "local_1"."apps_repo"."age_rating" AS "Content Rating",
    "local_1"."apps_repo"."genre_list" AS "Genres"
FROM "local_1"."apps_repo";

-- Reconstruct user_reviews from local_2.app_feedback
CREATE VIEW "user_reviews" AS
SELECT
    "local_2"."app_feedback"."app_name" AS "App",
    "local_2"."app_feedback"."translated_review_text" AS "Translated_Review",
    "local_2"."app_feedback"."sentiment_label" AS "Sentiment",
    "local_2"."app_feedback"."sentiment_polarity_score" AS "Sentiment_Polarity",
    "local_2"."app_feedback"."sentiment_subjectivity_score" AS "Sentiment_Subjectivity"
FROM "local_2"."app_feedback";
