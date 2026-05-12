CREATE TABLE "attributeDefinitions" (
    "attributeId" INTEGER,
    "attributeLabel" TEXT
);

CREATE TABLE "businessesInPhoenix" (
    "businessId" INTEGER,
    "isActive" TEXT,
    "cityName" TEXT,
    "stateCode" TEXT,
    "averageRating" REAL,
    "totalReviewCount" TEXT
);

CREATE TABLE "businessesChandlerAndGlendale" (
    "businessId" INTEGER,
    "isActive" TEXT,
    "cityName" TEXT,
    "stateCode" TEXT,
    "averageRating" REAL,
    "totalReviewCount" TEXT
);

CREATE TABLE "categoryCatalog" (
    "categoryId" INTEGER,
    "categoryLabel" TEXT
);

CREATE TABLE "reviewsStarsUpTo3" (
    "businessId" INTEGER,
    "userId" INTEGER,
    "starRating" INTEGER,
    "votesFunny" TEXT,
    "votesUseful" TEXT,
    "votesCool" TEXT,
    "contentLength" TEXT
);

CREATE TABLE "reviewsAbove4OrNull" (
    "businessId" INTEGER,
    "userId" INTEGER,
    "starRating" INTEGER,
    "votesFunny" TEXT,
    "votesUseful" TEXT,
    "votesCool" TEXT,
    "contentLength" TEXT
);

CREATE TABLE "businessAttributesTrue" (
    "attributeId" INTEGER,
    "businessId" INTEGER,
    "attributeEnabled" TEXT
);

CREATE TABLE "businessHoursCloses10pm" (
    "businessId" INTEGER,
    "dayOfWeek" INTEGER,
    "opensAt" TEXT,
    "closesAt" TEXT
);

CREATE TABLE "businessHoursCloses5pm" (
    "businessId" INTEGER,
    "dayOfWeek" INTEGER,
    "opensAt" TEXT,
    "closesAt" TEXT
);

CREATE TABLE "businessHoursCloses6pm" (
    "businessId" INTEGER,
    "dayOfWeek" INTEGER,
    "opensAt" TEXT,
    "closesAt" TEXT
);

CREATE TABLE "businessHoursCloses7Or11Or2am" (
    "businessId" INTEGER,
    "dayOfWeek" INTEGER,
    "opensAt" TEXT,
    "closesAt" TEXT
);

CREATE TABLE "businessHoursCloses8pmOr12am" (
    "businessId" INTEGER,
    "dayOfWeek" INTEGER,
    "opensAt" TEXT,
    "closesAt" TEXT
);

CREATE TABLE "usersAvgStars3Point5" (
    "userId" INTEGER,
    "averageStars" TEXT,
    "fanCount" TEXT,
    "votesCool" TEXT,
    "votesFunny" TEXT,
    "votesUseful" TEXT,
    "yelpingSinceYear" INTEGER
);

CREATE TABLE "usersAvgStars5Point0" (
    "userId" INTEGER,
    "averageStars" TEXT,
    "fanCount" TEXT,
    "votesCool" TEXT,
    "votesFunny" TEXT,
    "votesUseful" TEXT,
    "yelpingSinceYear" INTEGER
);

CREATE TABLE "usersAvgStars4Point5" (
    "userId" INTEGER,
    "averageStars" TEXT,
    "fanCount" TEXT,
    "votesCool" TEXT,
    "votesFunny" TEXT,
    "votesUseful" TEXT,
    "yelpingSinceYear" INTEGER
);

CREATE TABLE "usersAvgStars3Point0" (
    "userId" INTEGER,
    "averageStars" TEXT,
    "fanCount" TEXT,
    "votesCool" TEXT,
    "votesFunny" TEXT,
    "votesUseful" TEXT,
    "yelpingSinceYear" INTEGER
);

CREATE TABLE "usersAvgStarsVeryLowOrNull" (
    "userId" INTEGER,
    "averageStars" TEXT,
    "fanCount" TEXT,
    "votesCool" TEXT,
    "votesFunny" TEXT,
    "votesUseful" TEXT,
    "yelpingSinceYear" INTEGER
);

CREATE TABLE "tipsShortLongOrNull" (
    "businessId" INTEGER,
    "userId" INTEGER,
    "likeCount" INTEGER,
    "tipLengthCategory" TEXT
);