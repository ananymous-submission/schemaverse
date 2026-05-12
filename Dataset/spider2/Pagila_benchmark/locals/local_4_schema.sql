CREATE TABLE "CountryCatalog" (
    "CountryId" SMALLINT,
    "CountryName" VARCHAR(50) NOT NULL,
    "LastUpdate" TIMESTAMP
);

CREATE TABLE "InventoryEarliest" (
    "InventoryId" INT,
    "FilmId" INT NOT NULL,
    "StoreId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL
);

CREATE TABLE "InventoryEarlyMiddle" (
    "InventoryId" INT,
    "FilmId" INT NOT NULL,
    "StoreId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL
);

CREATE TABLE "InventoryLateMiddle" (
    "InventoryId" INT,
    "FilmId" INT NOT NULL,
    "StoreId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL
);

CREATE TABLE "InventoryLatestOrNull" (
    "InventoryId" INT,
    "FilmId" INT NOT NULL,
    "StoreId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL
);

CREATE TABLE "RentalRecentHighUpdate" (
    "RentalId" INT,
    "CustomerId" INT NOT NULL,
    "InventoryId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "StaffId" SMALLINT NOT NULL,
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerActiveLate"("CustomerId"),
    FOREIGN KEY ("InventoryId") REFERENCES "InventoryLateMiddle"("InventoryId"),
    FOREIGN KEY ("InventoryId") REFERENCES "InventoryLatestOrNull"("InventoryId")
);

CREATE TABLE "RentalMidCustomerInventory" (
    "RentalId" INT,
    "CustomerId" INT NOT NULL,
    "InventoryId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "RentalDate" TIMESTAMP NOT NULL,
    "ReturnDate" TIMESTAMP DEFAULT NULL,
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerActiveModerate"("CustomerId"),
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerActiveLate"("CustomerId"),
    FOREIGN KEY ("InventoryId") REFERENCES "InventoryEarliest"("InventoryId"),
    FOREIGN KEY ("InventoryId") REFERENCES "InventoryEarlyMiddle"("InventoryId"),
    FOREIGN KEY ("InventoryId") REFERENCES "InventoryLateMiddle"("InventoryId"),
    FOREIGN KEY ("InventoryId") REFERENCES "InventoryLatestOrNull"("InventoryId")
);

CREATE TABLE "CityMiddleUpdate" (
    "CityId" INT,
    "CityName" VARCHAR(50) NOT NULL,
    "CountryId" SMALLINT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    FOREIGN KEY ("CountryId") REFERENCES "CountryCatalog"("CountryId")
);

CREATE TABLE "CustomerActiveOld" (
    "CustomerId" INT,
    "IsActive" CHAR(1) NOT NULL DEFAULT 'Y',
    "CreatedAt" TIMESTAMP NOT NULL,
    "FirstName" VARCHAR(45) NOT NULL,
    "LastName" VARCHAR(45) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "StoreId" INT NOT NULL
);

CREATE TABLE "CustomerActiveModerate" (
    "CustomerId" INT,
    "IsActive" CHAR(1) NOT NULL DEFAULT 'Y',
    "CreatedAt" TIMESTAMP NOT NULL,
    "FirstName" VARCHAR(45) NOT NULL,
    "LastName" VARCHAR(45) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "StoreId" INT NOT NULL
);

CREATE TABLE "CustomerActiveLate" (
    "CustomerId" INT,
    "IsActive" CHAR(1) NOT NULL DEFAULT 'Y',
    "CreatedAt" TIMESTAMP NOT NULL,
    "FirstName" VARCHAR(45) NOT NULL,
    "LastName" VARCHAR(45) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "StoreId" INT NOT NULL
);

CREATE TABLE "PaymentAmountFourNinetyNine" (
    "PaymentId" INT,
    "Amount" DECIMAL(5,2) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PaymentDate" TIMESTAMP NOT NULL,
    "RentalId" INT DEFAULT NULL,
    FOREIGN KEY ("RentalId") REFERENCES "RentalMidCustomerInventory"("RentalId")
);

CREATE TABLE "PaymentAmountTwoNinetyNine" (
    "PaymentId" INT,
    "Amount" DECIMAL(5,2) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PaymentDate" TIMESTAMP NOT NULL,
    "RentalId" INT DEFAULT NULL,
    FOREIGN KEY ("RentalId") REFERENCES "RentalRecentHighUpdate"("RentalId")
);

CREATE TABLE "PaymentAmountZeroNinetyNine" (
    "PaymentId" INT,
    "Amount" DECIMAL(5,2) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PaymentDate" TIMESTAMP NOT NULL,
    "RentalId" INT DEFAULT NULL,
    FOREIGN KEY ("RentalId") REFERENCES "RentalMidCustomerInventory"("RentalId")
);

CREATE TABLE "PaymentAmountFiveOrSixDollarsNinetyNineCents" (
    "PaymentId" INT,
    "Amount" DECIMAL(5,2) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PaymentDate" TIMESTAMP NOT NULL,
    "RentalId" INT DEFAULT NULL,
    FOREIGN KEY ("RentalId") REFERENCES "RentalRecentHighUpdate"("RentalId")
);

CREATE TABLE "StaffActiveStatus" (
    "StaffId" SMALLINT,
    "ActiveFlag" SMALLINT NOT NULL DEFAULT 1,
    "FirstName" VARCHAR(45) NOT NULL,
    "LastName" VARCHAR(45) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PasswordHash" VARCHAR(40) DEFAULT NULL,
    "Photo" BLOB DEFAULT NULL,
    "Username" VARCHAR(16) NOT NULL
);