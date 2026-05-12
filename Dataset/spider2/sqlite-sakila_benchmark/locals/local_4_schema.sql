CREATE TABLE "CountryReference" (
    "CountryId" SMALLINT,
    "CountryName" VARCHAR(50) NOT NULL,
    "LastUpdate" TIMESTAMP
);

CREATE TABLE "InventoryUpdatedOnOrBefore155217" (
    "InventoryId" INT,
    "FilmId" INT NOT NULL,
    "StoreId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL
);

CREATE TABLE "InventoryUpdatedAfter155236OrNull" (
    "InventoryId" INT,
    "FilmId" INT NOT NULL,
    "StoreId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL
);

CREATE TABLE "RentalCustomerUpdatedOnOrBefore155413" (
    "RentalId" INT,
    "CustomerId" INT NOT NULL,
    "InventoryId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "StaffId" SMALLINT NOT NULL,
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerUpdated153338To153339"("CustomerId"),
    FOREIGN KEY ("InventoryId") REFERENCES "InventoryUpdatedAfter155236OrNull"("InventoryId"),
    FOREIGN KEY ("StaffId") REFERENCES "StaffEmploymentStatus"("StaffId")
);

CREATE TABLE "RentalCustomerUpdatedAfter155520OrNull" (
    "RentalId" INT,
    "CustomerId" INT NOT NULL,
    "InventoryId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "StaffId" SMALLINT NOT NULL,
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerUpdated153338To153339"("CustomerId"),
    FOREIGN KEY ("InventoryId") REFERENCES "InventoryUpdatedOnOrBefore155217"("InventoryId"),
    FOREIGN KEY ("InventoryId") REFERENCES "InventoryUpdatedAfter155236OrNull"("InventoryId"),
    FOREIGN KEY ("StaffId") REFERENCES "StaffEmploymentStatus"("StaffId")
);

CREATE TABLE "RentalByInventory" (
    "RentalId" INT,
    "InventoryId" INT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "RentalDate" TIMESTAMP NOT NULL,
    "ReturnDate" TIMESTAMP DEFAULT NULL,
    "StaffId" SMALLINT NOT NULL,
    FOREIGN KEY ("StaffId") REFERENCES "StaffEmploymentStatus"("StaffId")
);

CREATE TABLE "CityMidUpdateWindow" (
    "CityId" INT,
    "CityName" VARCHAR(50) NOT NULL,
    "CountryId" SMALLINT NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    FOREIGN KEY ("CountryId") REFERENCES "CountryReference"("CountryId")
);

CREATE TABLE "CustomerUpdated153337To153338" (
    "CustomerId" INT,
    "StoreId" INT NOT NULL,
    "GivenName" VARCHAR(45) NOT NULL,
    "Surname" VARCHAR(45) NOT NULL,
    "EmailAddress" VARCHAR(50) DEFAULT NULL,
    "AddressId" INT NOT NULL,
    "IsActive" CHAR(1) NOT NULL DEFAULT 'Y',
    "CreatedAt" TIMESTAMP NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL
);

CREATE TABLE "CustomerUpdated153338To153339" (
    "CustomerId" INT,
    "StoreId" INT NOT NULL,
    "GivenName" VARCHAR(45) NOT NULL,
    "Surname" VARCHAR(45) NOT NULL,
    "EmailAddress" VARCHAR(50) DEFAULT NULL,
    "AddressId" INT NOT NULL,
    "IsActive" CHAR(1) NOT NULL DEFAULT 'Y',
    "CreatedAt" TIMESTAMP NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL
);

CREATE TABLE "PaymentAmountFixed499" (
    "PaymentId" INT,
    "Amount" DECIMAL(5,2) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PaymentDate" TIMESTAMP NOT NULL,
    "RentalId" INT DEFAULT NULL,
    FOREIGN KEY ("RentalId") REFERENCES "RentalCustomerUpdatedAfter155520OrNull"("RentalId"),
    FOREIGN KEY ("RentalId") REFERENCES "RentalByInventory"("RentalId")
);

CREATE TABLE "PaymentAmountFixed299" (
    "PaymentId" INT,
    "Amount" DECIMAL(5,2) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PaymentDate" TIMESTAMP NOT NULL,
    "RentalId" INT DEFAULT NULL,
    FOREIGN KEY ("RentalId") REFERENCES "RentalCustomerUpdatedOnOrBefore155413"("RentalId"),
    FOREIGN KEY ("RentalId") REFERENCES "RentalCustomerUpdatedAfter155520OrNull"("RentalId"),
    FOREIGN KEY ("RentalId") REFERENCES "RentalByInventory"("RentalId")
);

CREATE TABLE "PaymentAmountFixed099" (
    "PaymentId" INT,
    "Amount" DECIMAL(5,2) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PaymentDate" TIMESTAMP NOT NULL,
    "RentalId" INT DEFAULT NULL,
    FOREIGN KEY ("RentalId") REFERENCES "RentalCustomerUpdatedOnOrBefore155413"("RentalId")
);

CREATE TABLE "PaymentAmountSplit599And699" (
    "PaymentId" INT,
    "Amount" DECIMAL(5,2) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PaymentDate" TIMESTAMP NOT NULL,
    "RentalId" INT DEFAULT NULL,
    FOREIGN KEY ("RentalId") REFERENCES "RentalCustomerUpdatedOnOrBefore155413"("RentalId")
);

CREATE TABLE "StaffEmploymentStatus" (
    "StaffId" SMALLINT,
    "ActiveFlag" SMALLINT NOT NULL DEFAULT 1,
    "GivenName" VARCHAR(45) NOT NULL,
    "Surname" VARCHAR(45) NOT NULL,
    "LastUpdate" TIMESTAMP NOT NULL,
    "PasswordHash" VARCHAR(40) DEFAULT NULL,
    "Photo" BLOB DEFAULT NULL,
    "Username" VARCHAR(16) NOT NULL
);