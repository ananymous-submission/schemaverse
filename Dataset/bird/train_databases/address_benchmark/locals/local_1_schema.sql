CREATE TABLE "micropolitanCbsa" (
    "cbsaId" INTEGER,
    "cbsaName" TEXT,
    "cbsaClassification" TEXT
);

CREATE TABLE "zipCodeAliases" (
    "zipCode" INTEGER,
    "alternateName" TEXT,
    FOREIGN KEY ("zipCode") REFERENCES "zipCbsaProfile"("zipCode"),
    FOREIGN KEY ("zipCode") REFERENCES "zipHousingValueMetrics"("zipCode")
);

CREATE TABLE "zipCbsaProfile" (
    "zipCode" INTEGER,
    "cbsaId" INTEGER,
    "americanIndianPopulation" INTEGER,
    "asianPopulation" INTEGER,
    "blackPopulation" INTEGER,
    "businessCount" INTEGER,
    "daylightSavingsObserved" TEXT,
    "censusDivision" TEXT,
    "elevationFeet" INTEGER,
    "employeeCount" INTEGER,
    "femalePopulation" INTEGER,
    "hawaiianPopulation" INTEGER,
    "hispanicPopulation" INTEGER,
    "landArea" REAL,
    "latitudeDegrees" REAL,
    "longitudeDegrees" REAL,
    "malePopulation" INTEGER,
    "spansMultipleCounties" TEXT,
    "otherPopulation" INTEGER,
    "populationOver65" INTEGER,
    "population2010" INTEGER,
    "population2020" INTEGER,
    "cbsaAreaType" TEXT,
    "waterArea" REAL,
    "whitePopulation" INTEGER
);

CREATE TABLE "zipPayrollSummary" (
    "zipCode" INTEGER,
    "annualPayroll" INTEGER,
    "businessMailboxes" INTEGER,
    "businessCount" INTEGER,
    "cityName" TEXT,
    "householdCount" INTEGER,
    "multiFamilyDeliveryUnits" INTEGER,
    "residentialMailboxes" INTEGER,
    "singleFamilyDeliveryUnits" INTEGER,
    "totalDeliveryReceptacles" INTEGER
);

CREATE TABLE "zipHousingValueMetrics" (
    "zipCode" INTEGER,
    "averageHouseValue" INTEGER,
    "averageHouseholdIncome" INTEGER,
    "femaleMedianAge" REAL,
    "maleMedianAge" REAL,
    "medianAge" REAL,
    "personsPerHousehold" REAL
);