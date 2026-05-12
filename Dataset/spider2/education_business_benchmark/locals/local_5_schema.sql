CREATE TABLE "monthlyHardwareSalesFact" (
    "salesMonth" TEXT,
    "productId" TEXT,
    "customerId" INTEGER,
    "unitsSold" INTEGER,
    "fiscalYear" INTEGER
);

CREATE TABLE "facultyDirectoryPrimary" (
    "postalCode" TEXT,
    "cityName" TEXT,
    "department" TEXT,
    "hireDate" TEXT,
    "facultyNumber" INTEGER,
    "salaryAmount" INTEGER,
    "stateCode" TEXT,
    "supervisorId" REAL
);

CREATE TABLE "facultyDirectorySecondary" (
    "postalCode" TEXT,
    "department" TEXT,
    "firstName" TEXT,
    "hireDate" TEXT,
    "lastName" TEXT,
    "academicRank" TEXT,
    "salaryAmount" INTEGER,
    "stateCode" TEXT
);

CREATE TABLE "customerDimAtliqStore" (
    "customerId" INTEGER,
    "customerName" TEXT,
    "salesPlatform" TEXT,
    "salesChannel" TEXT,
    "marketArea" TEXT,
    "subZone" TEXT,
    "regionName" TEXT
);

CREATE TABLE "customerDimRetailerNetwork" (
    "customerId" INTEGER,
    "customerName" TEXT,
    "salesPlatform" TEXT,
    "salesChannel" TEXT,
    "marketArea" TEXT,
    "subZone" TEXT,
    "regionName" TEXT
);

CREATE TABLE "productDimKeyboard" (
    "productId" TEXT,
    "productDivision" TEXT,
    "productSegment" TEXT,
    "productCategory" TEXT,
    "productName" TEXT,
    "productVariant" TEXT
);

CREATE TABLE "productDimMouse" (
    "productId" TEXT,
    "productDivision" TEXT,
    "productSegment" TEXT,
    "productCategory" TEXT,
    "productName" TEXT,
    "productVariant" TEXT
);

CREATE TABLE "productDimBusinessLaptop" (
    "productId" TEXT,
    "productDivision" TEXT,
    "productSegment" TEXT,
    "productCategory" TEXT,
    "productName" TEXT,
    "productVariant" TEXT
);

CREATE TABLE "productDimGamingBatteriesProcessors" (
    "productId" TEXT,
    "productDivision" TEXT,
    "productSegment" TEXT,
    "productCategory" TEXT,
    "productName" TEXT,
    "productVariant" TEXT
);

CREATE TABLE "productDimGraphicsMotherboards" (
    "productId" TEXT,
    "productDivision" TEXT,
    "productSegment" TEXT,
    "productCategory" TEXT,
    "productName" TEXT,
    "productVariant" TEXT
);