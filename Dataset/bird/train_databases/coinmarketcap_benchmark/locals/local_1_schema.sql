CREATE TABLE "CoinClassification" (
    "Id" INTEGER,
    "CategoryCode" TEXT,
    "Description" TEXT,
    "DisplayName" TEXT,
    "Notice" TEXT,
    "PlatformId" INTEGER,
    "Status" TEXT,
    "Symbol" TEXT,
    "TagNames" TEXT,
    "Tags" TEXT
);

CREATE TABLE "CoinReleaseAddedOnOrBefore2017Dec06" (
    "Id" INTEGER,
    "DateAdded" TEXT,
    "LaunchDate" TEXT,
    "Description" TEXT,
    "Name" TEXT,
    "Notice" TEXT,
    "PlatformId" INTEGER,
    "Slug" TEXT,
    "Status" TEXT,
    "Subreddit" TEXT,
    "Symbol" TEXT,
    "Website" TEXT
);

CREATE TABLE "CoinReleaseAddedAfter2017Dec06Through2020Mar18" (
    "Id" INTEGER,
    "DateAdded" TEXT,
    "LaunchDate" TEXT,
    "Description" TEXT,
    "Name" TEXT,
    "Notice" TEXT,
    "PlatformId" INTEGER,
    "Slug" TEXT,
    "Status" TEXT,
    "Subreddit" TEXT,
    "Symbol" TEXT,
    "Website" TEXT
);

CREATE TABLE "CoinReleaseAddedAfter2020Mar18Through2021Jan29" (
    "Id" INTEGER,
    "DateAdded" TEXT,
    "LaunchDate" TEXT,
    "Description" TEXT,
    "Name" TEXT,
    "Notice" TEXT,
    "PlatformId" INTEGER,
    "Slug" TEXT,
    "Status" TEXT,
    "Subreddit" TEXT,
    "Symbol" TEXT,
    "Website" TEXT
);

CREATE TABLE "CoinReleaseAddedAfter2021Jan29OrNull" (
    "Id" INTEGER,
    "DateAdded" TEXT,
    "LaunchDate" TEXT,
    "Description" TEXT,
    "Name" TEXT,
    "Notice" TEXT,
    "PlatformId" INTEGER,
    "Slug" TEXT,
    "Status" TEXT,
    "Subreddit" TEXT,
    "Symbol" TEXT,
    "Website" TEXT
);