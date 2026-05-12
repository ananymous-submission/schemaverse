CREATE TABLE "locationDistrict" (
    "districtId" INTEGER,
    "districtCity" TEXT,
    "stateCodeRef" TEXT,
    "divisionName" TEXT,
    FOREIGN KEY ("stateCodeRef") REFERENCES "usState"("stateCode")
);

CREATE TABLE "usState" (
    "stateCode" TEXT,
    "stateName" TEXT,
    "regionName" TEXT
);

CREATE TABLE "clientAgeProfile" (
    "clientId" TEXT,
    "ageYears" INTEGER,
    "cityName" TEXT,
    "districtRefId" INTEGER,
    "emailAddress" TEXT,
    "gender" TEXT,
    "socialId" TEXT,
    "residenceState" TEXT,
    "postalCode" INTEGER,
    FOREIGN KEY ("districtRefId") REFERENCES "locationDistrict"("districtId")
);

CREATE TABLE "clientAddressAge32To45" (
    "clientId" TEXT,
    "streetAddressPrimary" TEXT,
    "streetAddressSecondary" TEXT,
    "ageYears" INTEGER,
    "cityName" TEXT,
    "districtRefId" INTEGER,
    "emailAddress" TEXT,
    "phoneNumber" TEXT,
    "gender" TEXT,
    "socialId" TEXT,
    "postalCode" INTEGER,
    FOREIGN KEY ("districtRefId") REFERENCES "locationDistrict"("districtId")
);

CREATE TABLE "clientAddressAge46To59" (
    "clientId" TEXT,
    "streetAddressPrimary" TEXT,
    "streetAddressSecondary" TEXT,
    "ageYears" INTEGER,
    "cityName" TEXT,
    "districtRefId" INTEGER,
    "emailAddress" TEXT,
    "phoneNumber" TEXT,
    "gender" TEXT,
    "socialId" TEXT,
    "postalCode" INTEGER,
    FOREIGN KEY ("districtRefId") REFERENCES "locationDistrict"("districtId")
);

CREATE TABLE "clientAddressAge60OrAbove" (
    "clientId" TEXT,
    "streetAddressPrimary" TEXT,
    "streetAddressSecondary" TEXT,
    "ageYears" INTEGER,
    "cityName" TEXT,
    "districtRefId" INTEGER,
    "emailAddress" TEXT,
    "phoneNumber" TEXT,
    "gender" TEXT,
    "socialId" TEXT,
    "postalCode" INTEGER
);

CREATE TABLE "reviewsEagleBanksOrUnspecified" (
    "reviewDate" DATE,
    "starRating" INTEGER,
    "reviewText" TEXT,
    "productName" TEXT,
    "districtRefId" INTEGER
);