CREATE TABLE "CustomerWithNation" (
    "CustomerId" INTEGER,
    "AccountBalance" REAL DEFAULT NULL,
    "Address" TEXT DEFAULT NULL,
    "Name" TEXT DEFAULT NULL,
    "NationId" INTEGER DEFAULT NULL
);

CREATE TABLE "CustomerFurnitureSegment" (
    "CustomerId" INTEGER,
    "AccountBalance" REAL DEFAULT NULL,
    "Address" TEXT DEFAULT NULL,
    "Comment" TEXT DEFAULT NULL,
    "MarketSegment" TEXT DEFAULT NULL,
    "Name" TEXT DEFAULT NULL,
    "PhoneNumber" TEXT DEFAULT NULL
);

CREATE TABLE "CustomerMachinerySegment" (
    "CustomerId" INTEGER,
    "AccountBalance" REAL DEFAULT NULL,
    "Address" TEXT DEFAULT NULL,
    "Comment" TEXT DEFAULT NULL,
    "MarketSegment" TEXT DEFAULT NULL,
    "Name" TEXT DEFAULT NULL,
    "PhoneNumber" TEXT DEFAULT NULL
);

CREATE TABLE "CustomerBuildingSegment" (
    "CustomerId" INTEGER,
    "AccountBalance" REAL DEFAULT NULL,
    "Address" TEXT DEFAULT NULL,
    "Comment" TEXT DEFAULT NULL,
    "MarketSegment" TEXT DEFAULT NULL,
    "Name" TEXT DEFAULT NULL,
    "PhoneNumber" TEXT DEFAULT NULL
);

CREATE TABLE "CustomerAutomobileSegment" (
    "CustomerId" INTEGER,
    "AccountBalance" REAL DEFAULT NULL,
    "Address" TEXT DEFAULT NULL,
    "Comment" TEXT DEFAULT NULL,
    "MarketSegment" TEXT DEFAULT NULL,
    "Name" TEXT DEFAULT NULL,
    "PhoneNumber" TEXT DEFAULT NULL
);

CREATE TABLE "CustomerHouseholdSegment" (
    "CustomerId" INTEGER,
    "AccountBalance" REAL DEFAULT NULL,
    "Address" TEXT DEFAULT NULL,
    "Comment" TEXT DEFAULT NULL,
    "MarketSegment" TEXT DEFAULT NULL,
    "Name" TEXT DEFAULT NULL,
    "PhoneNumber" TEXT DEFAULT NULL
);

CREATE TABLE "NationLookup" (
    "NationId" INTEGER,
    "NationName" TEXT,
    "RegionId" INTEGER,
    "Comment" TEXT
);

CREATE TABLE "OrdersOrderDateUpTo1993Aug24" (
    "OrderDate" DATE,
    "OrderId" INTEGER,
    "CustomerId" INTEGER NOT NULL,
    "OrderPriority" TEXT,
    "ShipPriority" INTEGER,
    "Clerk" TEXT,
    "OrderStatus" TEXT,
    "TotalPrice" REAL,
    "Comment" TEXT,
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerBuildingSegment"("CustomerId"),
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerAutomobileSegment"("CustomerId")
);

CREATE TABLE "OrdersOrderDateAfter1996Dec07OrNull" (
    "OrderDate" DATE,
    "OrderId" INTEGER,
    "CustomerId" INTEGER NOT NULL,
    "OrderPriority" TEXT,
    "ShipPriority" INTEGER,
    "Clerk" TEXT,
    "OrderStatus" TEXT,
    "TotalPrice" REAL,
    "Comment" TEXT,
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerFurnitureSegment"("CustomerId"),
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerMachinerySegment"("CustomerId"),
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerBuildingSegment"("CustomerId"),
    FOREIGN KEY ("CustomerId") REFERENCES "CustomerHouseholdSegment"("CustomerId")
);

CREATE TABLE "RegionCatalog" (
    "RegionId" INTEGER,
    "RegionName" TEXT,
    "Comment" TEXT
);

CREATE TABLE "LineItemCommitUpTo1995Feb09" (
    "OrderId" INTEGER,
    "LineNumber" INTEGER,
    "CommitDate" DATE,
    "ReceiptDate" DATE,
    "ShipDate" DATE,
    FOREIGN KEY ("OrderId") REFERENCES "OrdersOrderDateUpTo1993Aug24"("OrderId"),
    FOREIGN KEY ("OrderId") REFERENCES "OrdersOrderDateAfter1996Dec07OrNull"("OrderId")
);

CREATE TABLE "LineItemCommitAfter1995Feb09To1996Apr27" (
    "OrderId" INTEGER,
    "LineNumber" INTEGER,
    "CommitDate" DATE,
    "ReceiptDate" DATE,
    "ShipDate" DATE,
    FOREIGN KEY ("OrderId") REFERENCES "OrdersOrderDateUpTo1993Aug24"("OrderId")
);

CREATE TABLE "LineItemCommitAfter1996Apr27To1997Jul14" (
    "OrderId" INTEGER,
    "LineNumber" INTEGER,
    "CommitDate" DATE,
    "ReceiptDate" DATE,
    "ShipDate" DATE
);