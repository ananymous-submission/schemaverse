CREATE TABLE Customers
(
    CustomerID       INTEGER
        constraint Customers_pk
            primary key,
    "Customer Names" TEXT
);

CREATE TABLE Products
(
    ProductID      INTEGER
        constraint Products_pk
            primary key,
    "Product Name" TEXT
);

CREATE TABLE Regions
(
    StateCode TEXT
        constraint Regions_pk
            primary key,
    State     TEXT,
    Region    TEXT
);

CREATE TABLE "Sales Orders"
(
    OrderNumber        TEXT
        constraint "Sales Orders_pk"
            primary key,
    "Sales Channel"    TEXT,
    WarehouseCode      TEXT,
    ProcuredDate       TEXT,
    OrderDate          TEXT,
    ShipDate           TEXT,
    DeliveryDate       TEXT,
    CurrencyCode       TEXT,
    _SalesTeamID       INTEGER
        constraint "Sales Orders_Sales Team_SalesTeamID_fk"
            references "Sales Team"(SalesTeamID),
    _CustomerID        INTEGER
        constraint "Sales Orders_Customers_CustomerID_fk"
            references Customers(CustomerID),
    _StoreID           INTEGER
        constraint "Sales Orders_Store Locations_StoreID_fk"
            references "Store Locations"(StoreID),
    _ProductID         INTEGER
        constraint "Sales Orders_Products_ProductID_fk"
            references Products(ProductID),
    "Order Quantity"   INTEGER,
    "Discount Applied" REAL,
    "Unit Price"       TEXT,
    "Unit Cost"        TEXT
);

CREATE TABLE "Sales Team"
(
    SalesTeamID  INTEGER
        constraint "Sales Team_pk"
            primary key,
    "Sales Team" TEXT,
    Region       TEXT
);

CREATE TABLE "Store Locations"
(
    StoreID            INTEGER
        constraint "Store Locations_pk"
            primary key,
    "City Name"        TEXT,
    County             TEXT,
    StateCode          TEXT
        constraint "Store Locations_Regions_StateCode_fk"
            references Regions(StateCode),
    State              TEXT,
    Type               TEXT,
    Latitude           REAL,
    Longitude          REAL,
    AreaCode           INTEGER,
    Population         INTEGER,
    "Household Income" INTEGER,
    "Median Income"    INTEGER,
    "Land Area"        INTEGER,
    "Water Area"       INTEGER,
    "Time Zone"        TEXT
);