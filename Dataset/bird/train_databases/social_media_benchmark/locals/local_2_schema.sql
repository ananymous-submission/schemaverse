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