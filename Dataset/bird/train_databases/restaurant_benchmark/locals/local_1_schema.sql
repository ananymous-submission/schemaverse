CREATE TABLE "RestaurantProfile" (
    "RestaurantId" INTEGER,
    "RestaurantName" TEXT,
    "CuisineType" TEXT,
    "CityName" TEXT,
    "ReviewScore" REAL,
    FOREIGN KEY ("CityName") REFERENCES "ContraCostaMarinNapaGeography"("CityName"),
    FOREIGN KEY ("CityName") REFERENCES "AlamedaSantaClaraGeography"("CityName"),
    FOREIGN KEY ("CityName") REFERENCES "SonomaMontereyGeography"("CityName")
);

CREATE TABLE "LocationStreetNumRangeGt518To1459" (
    "RestaurantId" INTEGER,
    "StreetNumber" INTEGER,
    "StreetName" TEXT,
    "CityName" TEXT,
    FOREIGN KEY ("CityName") REFERENCES "SanMateoCountyGeography"("CityName"),
    FOREIGN KEY ("CityName") REFERENCES "AlamedaSantaClaraGeography"("CityName"),
    FOREIGN KEY ("CityName") REFERENCES "SonomaMontereyGeography"("CityName")
);

CREATE TABLE "LocationStreetNumRangeGt1459To3080" (
    "RestaurantId" INTEGER,
    "StreetNumber" INTEGER,
    "StreetName" TEXT,
    "CityName" TEXT,
    FOREIGN KEY ("CityName") REFERENCES "SanMateoCountyGeography"("CityName"),
    FOREIGN KEY ("CityName") REFERENCES "SonomaMontereyGeography"("CityName")
);

CREATE TABLE "SanMateoCountyGeography" (
    "CityName" TEXT,
    "CountyName" TEXT,
    "RegionName" TEXT
);

CREATE TABLE "ContraCostaMarinNapaGeography" (
    "CityName" TEXT,
    "CountyName" TEXT,
    "RegionName" TEXT
);

CREATE TABLE "AlamedaSantaClaraGeography" (
    "CityName" TEXT,
    "CountyName" TEXT,
    "RegionName" TEXT
);

CREATE TABLE "SonomaMontereyGeography" (
    "CityName" TEXT,
    "CountyName" TEXT,
    "RegionName" TEXT
);