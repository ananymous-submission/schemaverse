CREATE TABLE "monthly_budget_lowest_quartile" (
    "product_identifier" INTEGER,
    "calendar_month" TEXT,
    "quantity" REAL NOT NULL
);

CREATE TABLE "monthly_budget_highest_quartile" (
    "product_identifier" INTEGER,
    "calendar_month" TEXT,
    "quantity" REAL NOT NULL
);

CREATE TABLE "daily_demographics_facebook_metrics" (
    "report_date" TEXT,
    "female_facebook_count" INTEGER,
    "female_facebook_quantity" INTEGER,
    "female_twitter_quantity" INTEGER,
    "male_facebook_count" INTEGER,
    "male_facebook_quantity" INTEGER,
    "male_twitter_quantity" INTEGER
);

CREATE TABLE "daily_demographics_twitter_metrics" (
    "report_date" TEXT,
    "female_facebook_quantity" INTEGER,
    "female_twitter_count" INTEGER,
    "female_twitter_quantity" INTEGER,
    "male_facebook_quantity" INTEGER,
    "male_twitter_count" INTEGER,
    "male_twitter_quantity" INTEGER
);