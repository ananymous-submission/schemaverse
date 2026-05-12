CREATE TABLE "eventCityMap" (
    "eventId" INTEGER DEFAULT NULL,
    "cityId" INTEGER DEFAULT NULL
);

CREATE TABLE "peopleHeightAtMost159" (
    "personId" INTEGER,
    "fullName" TEXT DEFAULT NULL,
    "genderIdentity" TEXT DEFAULT NULL,
    "heightCm" INTEGER DEFAULT NULL,
    "weightKg" INTEGER DEFAULT NULL
);

CREATE TABLE "peopleHeightAbove181OrUnknown" (
    "personId" INTEGER,
    "fullName" TEXT DEFAULT NULL,
    "genderIdentity" TEXT DEFAULT NULL,
    "heightCm" INTEGER DEFAULT NULL,
    "weightKg" INTEGER DEFAULT NULL
);

CREATE TABLE "personRegionMap" (
    "personId" INTEGER DEFAULT NULL,
    "regionId" INTEGER DEFAULT NULL
);

CREATE TABLE "competitorsAgeAbove22UpTo25" (
    "competitorId" INTEGER,
    "eventId" INTEGER DEFAULT NULL,
    "personIdRef" INTEGER DEFAULT NULL,
    "participantAge" INTEGER DEFAULT NULL,
    FOREIGN KEY ("personIdRef") REFERENCES "peopleHeightAtMost159"("personId")
);

CREATE TABLE "competitorsAgeAbove25UpTo29" (
    "competitorId" INTEGER,
    "eventId" INTEGER DEFAULT NULL,
    "personIdRef" INTEGER DEFAULT NULL,
    "participantAge" INTEGER DEFAULT NULL
);