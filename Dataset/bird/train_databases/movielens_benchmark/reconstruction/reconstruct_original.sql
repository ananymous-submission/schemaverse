-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct actors from row partitions (UNION (overlap))
CREATE VIEW "actors" AS
SELECT "local_1"."actorsQualityAtMostThree"."actorId" AS "actorid", "local_1"."actorsQualityAtMostThree"."gender" AS "a_gender", "local_1"."actorsQualityAtMostThree"."qualityRating" AS "a_quality" FROM "local_1"."actorsQualityAtMostThree"
UNION
SELECT "local_2"."actors_quality_above_three"."actor_id" AS "actorid", "local_2"."actors_quality_above_three"."gender" AS "a_gender", "local_2"."actors_quality_above_three"."quality_score" AS "a_quality" FROM "local_2"."actors_quality_above_three";

-- Reconstruct directors from row partitions (UNION (overlap))
CREATE VIEW "directors" AS
SELECT "local_1"."directorsQualityAtMostThree"."directorId" AS "directorid", "local_1"."directorsQualityAtMostThree"."qualityRating" AS "d_quality", "local_1"."directorsQualityAtMostThree"."averageRevenue" AS "avg_revenue" FROM "local_1"."directorsQualityAtMostThree"
UNION
SELECT "local_3"."dir_q_gt3_null"."dir_id" AS "directorid", "local_3"."dir_q_gt3_null"."q_score" AS "d_quality", "local_3"."dir_q_gt3_null"."avg_rev" AS "avg_revenue" FROM "local_3"."dir_q_gt3_null";

-- Reconstruct movies from row partitions (UNION (overlap))
CREATE VIEW "movies" AS
SELECT "local_2"."movies_usa"."movie_id" AS "movieid", "local_2"."movies_usa"."release_year" AS "year", "local_2"."movies_usa"."is_english" AS "isEnglish", "local_2"."movies_usa"."country_of_origin" AS "country", "local_2"."movies_usa"."running_time_minutes" AS "runningtime" FROM "local_2"."movies_usa"
UNION
SELECT "local_2"."movies_uk_france_or_null"."movie_id" AS "movieid", "local_2"."movies_uk_france_or_null"."release_year" AS "year", "local_2"."movies_uk_france_or_null"."is_english" AS "isEnglish", "local_2"."movies_uk_france_or_null"."country_of_origin" AS "country", "local_2"."movies_uk_france_or_null"."running_time_minutes" AS "runningtime" FROM "local_2"."movies_uk_france_or_null"
UNION
SELECT "local_3"."mov_other_ctry"."mov_id" AS "movieid", "local_3"."mov_other_ctry"."yr" AS "year", "local_3"."mov_other_ctry"."is_eng" AS "isEnglish", "local_3"."mov_other_ctry"."ctry" AS "country", "local_3"."mov_other_ctry"."run_mins" AS "runningtime" FROM "local_3"."mov_other_ctry";

-- Reconstruct movies2actors from row partitions (UNION (overlap))
CREATE VIEW "movies2actors" AS
SELECT "local_1"."movieCastMembershipsOverTwoOrUnknown"."movieId" AS "movieid", "local_1"."movieCastMembershipsOverTwoOrUnknown"."actorId" AS "actorid", "local_1"."movieCastMembershipsOverTwoOrUnknown"."castSize" AS "cast_num" FROM "local_1"."movieCastMembershipsOverTwoOrUnknown"
UNION
SELECT "local_2"."movie_cast_top_two"."movie_id" AS "movieid", "local_2"."movie_cast_top_two"."actor_id" AS "actorid", "local_2"."movie_cast_top_two"."cast_order" AS "cast_num" FROM "local_2"."movie_cast_top_two";

-- Reconstruct movies2directors from local_3.mov_dir_rel
CREATE VIEW "movies2directors" AS
SELECT
    "local_3"."mov_dir_rel"."mov_id" AS "movieid",
    "local_3"."mov_dir_rel"."dir_id" AS "directorid",
    "local_3"."mov_dir_rel"."genre_cd" AS "genre"
FROM "local_3"."mov_dir_rel";

-- Reconstruct u2base from local_2.user_movie_ratings
CREATE VIEW "u2base" AS
SELECT
    "local_2"."user_movie_ratings"."user_id" AS "userid",
    "local_2"."user_movie_ratings"."movie_id" AS "movieid",
    "local_2"."user_movie_ratings"."rating_value" AS "rating"
FROM "local_2"."user_movie_ratings";

-- Reconstruct users from row partitions (UNION (overlap))
CREATE VIEW "users" AS
SELECT "local_2"."users_age_35"."user_id" AS "userid", "local_2"."users_age_35"."age_years" AS "age", "local_2"."users_age_35"."gender" AS "u_gender", "local_2"."users_age_35"."job_title" AS "occupation" FROM "local_2"."users_age_35"
UNION
SELECT "local_2"."users_age_18"."user_id" AS "userid", "local_2"."users_age_18"."age_years" AS "age", "local_2"."users_age_18"."gender" AS "u_gender", "local_2"."users_age_18"."job_title" AS "occupation" FROM "local_2"."users_age_18"
UNION
SELECT "local_3"."usr_age_25"."usr_id" AS "userid", "local_3"."usr_age_25"."age_yrs" AS "age", "local_3"."usr_age_25"."usr_gender" AS "u_gender", "local_3"."usr_age_25"."occ" AS "occupation" FROM "local_3"."usr_age_25"
UNION
SELECT "local_3"."usr_age_set_45_50_56_1_null"."usr_id" AS "userid", "local_3"."usr_age_set_45_50_56_1_null"."age_yrs" AS "age", "local_3"."usr_age_set_45_50_56_1_null"."usr_gender" AS "u_gender", "local_3"."usr_age_set_45_50_56_1_null"."occ" AS "occupation" FROM "local_3"."usr_age_set_45_50_56_1_null";
