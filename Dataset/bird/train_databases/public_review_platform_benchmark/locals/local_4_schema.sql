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