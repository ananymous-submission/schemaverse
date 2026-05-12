CREATE TABLE "BusinessCategoryMapping" (
    "BusinessId" INTEGER,
    "CategoryId" INTEGER
);

CREATE TABLE "DaysOfWeek" (
    "DayId" INTEGER,
    "DayName" TEXT
);

CREATE TABLE "BusinessInScottsdale" (
    "BusinessId" INTEGER,
    "IsActive" TEXT,
    "CityName" TEXT,
    "StateCode" TEXT,
    "AverageStars" REAL,
    "ReviewCount" TEXT
);

CREATE TABLE "BusinessTempeAndOther" (
    "BusinessId" INTEGER,
    "IsActive" TEXT,
    "CityName" TEXT,
    "StateCode" TEXT,
    "AverageStars" REAL,
    "ReviewCount" TEXT
);

CREATE TABLE "BusinessInMesaGilbertPeoriaSurprise" (
    "BusinessId" INTEGER,
    "IsActive" TEXT,
    "CityName" TEXT,
    "StateCode" TEXT,
    "AverageStars" REAL,
    "ReviewCount" TEXT
);

CREATE TABLE "ReviewsStarsGreaterThanThreeUpToFour" (
    "BusinessId" INTEGER,
    "UserId" INTEGER,
    "ReviewStars" INTEGER,
    "VotesFunny" TEXT,
    "VotesUseful" TEXT,
    "VotesCool" TEXT,
    "ReviewTextLength" TEXT
);

CREATE TABLE "CheckinsHoursTenAndTwentyTwo" (
    "BusinessId" INTEGER,
    "DayId" INTEGER,
    "HourLabel10" TEXT,
    "HourLabel22" TEXT
);

CREATE TABLE "CheckinsHoursElevenAndTwentyThree" (
    "BusinessId" INTEGER,
    "DayId" INTEGER,
    "HourLabel11" TEXT,
    "HourLabel23" TEXT
);

CREATE TABLE "CheckinsHoursOneToThree" (
    "BusinessId" INTEGER,
    "DayId" INTEGER,
    "HourLabel01" TEXT,
    "HourLabel02" TEXT,
    "HourLabel03" TEXT
);

CREATE TABLE "CheckinsHours00And12To21WithNoneAt21" (
    "BusinessId" INTEGER,
    "DayId" INTEGER,
    "HourLabel00" TEXT,
    "HourLabel12" TEXT,
    "HourLabel13" TEXT,
    "HourLabel14" TEXT,
    "HourLabel15" TEXT,
    "HourLabel16" TEXT,
    "HourLabel17" TEXT,
    "HourLabel18" TEXT,
    "HourLabel19" TEXT,
    "HourLabel20" TEXT,
    "HourLabel21" TEXT
);

CREATE TABLE "CheckinsHours00And12To21WithVaried21" (
    "BusinessId" INTEGER,
    "DayId" INTEGER,
    "HourLabel00" TEXT,
    "HourLabel12" TEXT,
    "HourLabel13" TEXT,
    "HourLabel14" TEXT,
    "HourLabel15" TEXT,
    "HourLabel16" TEXT,
    "HourLabel17" TEXT,
    "HourLabel18" TEXT,
    "HourLabel19" TEXT,
    "HourLabel20" TEXT,
    "HourLabel21" TEXT
);