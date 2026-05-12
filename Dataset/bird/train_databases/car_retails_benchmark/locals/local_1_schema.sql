CREATE TABLE "customersByStatesCaNyPaBcCountyCork" (
    "customerId" INTEGER,
    "addressPrimary" TEXT NOT NULL,
    "addressSecondary" TEXT,
    "creditLimitAmount" REAL,
    "customerFullName" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "postalCodeValue" TEXT,
    "salesRepresentativeId" INTEGER,
    "region" TEXT,
    FOREIGN KEY ("salesRepresentativeId") REFERENCES "employeesDirectory"("employeeId")
);

CREATE TABLE "customersByStatesMaCtNswVictoria" (
    "customerId" INTEGER,
    "addressPrimary" TEXT NOT NULL,
    "addressSecondary" TEXT,
    "creditLimitAmount" REAL,
    "customerFullName" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "postalCodeValue" TEXT,
    "salesRepresentativeId" INTEGER,
    "region" TEXT,
    FOREIGN KEY ("salesRepresentativeId") REFERENCES "employeesContactEmails"("employeeId"),
    FOREIGN KEY ("salesRepresentativeId") REFERENCES "employeesDirectory"("employeeId")
);

CREATE TABLE "customersOtherStates" (
    "customerId" INTEGER,
    "addressPrimary" TEXT NOT NULL,
    "addressSecondary" TEXT,
    "creditLimitAmount" REAL,
    "customerFullName" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "postalCodeValue" TEXT,
    "salesRepresentativeId" INTEGER,
    "region" TEXT,
    FOREIGN KEY ("salesRepresentativeId") REFERENCES "employeesContactEmails"("employeeId")
);

CREATE TABLE "customersByCity" (
    "customerId" INTEGER,
    "cityName" TEXT NOT NULL,
    "contactGivenName" TEXT NOT NULL,
    "contactFamilyName" TEXT NOT NULL,
    "countryName" TEXT NOT NULL,
    "creditLimitAmount" REAL,
    "customerFullName" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "postalCodeValue" TEXT,
    "salesRepresentativeId" INTEGER
);

CREATE TABLE "employeesContactEmails" (
    "employeeId" INTEGER,
    "emailAddress" TEXT NOT NULL,
    "phoneExtension" TEXT NOT NULL,
    "jobRole" TEXT NOT NULL,
    "officeId" TEXT NOT NULL,
    "managerId" INTEGER
);

CREATE TABLE "employeesDirectory" (
    "employeeId" INTEGER,
    "phoneExtension" TEXT NOT NULL,
    "givenName" TEXT NOT NULL,
    "jobRole" TEXT NOT NULL,
    "familyName" TEXT NOT NULL,
    "managerId" INTEGER,
    FOREIGN KEY ("managerId") REFERENCES "employeesDirectory"("employeeId")
);

CREATE TABLE "ordersWithCommentsForOtherStateCustomers" (
    "orderId" INTEGER,
    "orderNotes" TEXT,
    "customerId" INTEGER NOT NULL,
    "orderPlacedDate" DATE NOT NULL,
    "requiredByDate" DATE NOT NULL,
    "dateShipped" DATE,
    "orderStatus" TEXT NOT NULL,
    FOREIGN KEY ("customerId") REFERENCES "customersOtherStates"("customerId")
);

CREATE TABLE "customerPaymentRecords" (
    "customerId" INTEGER,
    "paymentReference" TEXT,
    "paymentPostedDate" DATE NOT NULL,
    "paymentAmount" REAL NOT NULL,
    FOREIGN KEY ("customerId") REFERENCES "customersByStatesCaNyPaBcCountyCork"("customerId"),
    FOREIGN KEY ("customerId") REFERENCES "customersByStatesMaCtNswVictoria"("customerId"),
    FOREIGN KEY ("customerId") REFERENCES "customersByCity"("customerId")
);

CREATE TABLE "orderDetailsLinesFourToSix" (
    "orderId" INTEGER,
    "productId" TEXT,
    "quantity" INTEGER NOT NULL,
    "unitPrice" REAL NOT NULL,
    "lineNumber" INTEGER NOT NULL
);

CREATE TABLE "orderDetailsLinesSevenToNine" (
    "orderId" INTEGER,
    "productId" TEXT,
    "quantity" INTEGER NOT NULL,
    "unitPrice" REAL NOT NULL,
    "lineNumber" INTEGER NOT NULL
);

CREATE TABLE "officesPrimaryAddress" (
    "officeId" TEXT,
    "addressPrimary" TEXT NOT NULL,
    "addressSecondary" TEXT,
    "cityName" TEXT NOT NULL,
    "countryName" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "postalCodeValue" TEXT NOT NULL
);

CREATE TABLE "productsFromCarouselAndSecondGear" (
    "productId" TEXT,
    "productTitle" TEXT NOT NULL,
    "productCategory" TEXT NOT NULL,
    "scale" TEXT NOT NULL,
    "vendorName" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "stockQuantity" INTEGER NOT NULL,
    "costPrice" REAL NOT NULL,
    "listPrice" REAL NOT NULL
);

CREATE TABLE "productsFromExotoAndGearbox" (
    "productId" TEXT,
    "productTitle" TEXT NOT NULL,
    "productCategory" TEXT NOT NULL,
    "scale" TEXT NOT NULL,
    "vendorName" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "stockQuantity" INTEGER NOT NULL,
    "costPrice" REAL NOT NULL,
    "listPrice" REAL NOT NULL
);

CREATE TABLE "productsFromHighway66AndMotorCity" (
    "productId" TEXT,
    "productTitle" TEXT NOT NULL,
    "productCategory" TEXT NOT NULL,
    "scale" TEXT NOT NULL,
    "vendorName" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "stockQuantity" INTEGER NOT NULL,
    "costPrice" REAL NOT NULL,
    "listPrice" REAL NOT NULL
);