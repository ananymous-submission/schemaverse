CREATE TABLE "geoLocation" (
    "placeId" INTEGER,
    "countryName" TEXT,
    "stateName" TEXT,
    "stateAbbreviation" TEXT,
    "cityName" TEXT
);

CREATE TABLE "tweetHourlyStats" (
    "statusId" TEXT,
    "hourOfDay" INTEGER,
    "influenceScore" INTEGER,
    "placeId" INTEGER,
    "sentimentScore" REAL,
    "authorId" TEXT
);

CREATE TABLE "tweetReshareInfo" (
    "statusId" TEXT,
    "isRepost" TEXT,
    "influenceScore" INTEGER,
    "languageCode" TEXT,
    "sentimentScore" REAL,
    "tweetText" TEXT
);