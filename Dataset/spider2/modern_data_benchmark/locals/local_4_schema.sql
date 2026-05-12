CREATE TABLE "CustomerOrderExclusions" (
    "CustomerIdentifier" INTEGER,
    "SpecialInstructions" TEXT,
    "ItemExclusions" TEXT,
    "OrderIdentifier" INTEGER,
    "OrderTimestamp" TEXT
);

CREATE TABLE "CustomerOrderPizzas" (
    "CustomerIdentifier" INTEGER,
    "SpecialInstructions" TEXT,
    "OrderIdentifier" INTEGER,
    "OrderTimestamp" TEXT,
    "PizzaIdentifier" INTEGER
);

CREATE TABLE "RunnerOrderAssignments" (
    "OrderIdentifier" INTEGER,
    "RunnerIdentifier" INTEGER,
    "PickupTimestamp" TEXT,
    "TripDistance" REAL,
    "TripDuration" REAL,
    "CancellationNote" TEXT
);

CREATE TABLE "RunnerOrderRecords" (
    "OrderIdentifier" INTEGER,
    "RunnerIdentifier" INTEGER,
    "PickupTimestamp" TEXT,
    "TripDistance" TEXT,
    "TripDuration" TEXT,
    "CancellationNote" TEXT
);

CREATE TABLE "StreetTreeInventory" (
    "RecordIndex" INTEGER,
    "TreeIdentifier" INTEGER,
    "DiameterAtBreastHeight" INTEGER,
    "StumpDiameter" INTEGER,
    "TreeCondition" TEXT,
    "HealthStatus" TEXT,
    "SpeciesLatinName" TEXT,
    "SpeciesCommonName" TEXT,
    "StreetAddress" TEXT,
    "ZipCode" INTEGER,
    "BoroughCode" INTEGER,
    "BoroughName" TEXT,
    "NeighborhoodName" TEXT,
    "StateCode" TEXT,
    "LatitudeCoordinate" REAL,
    "LongitudeCoordinate" REAL
);