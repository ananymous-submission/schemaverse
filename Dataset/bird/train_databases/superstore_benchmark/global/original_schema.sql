CREATE TABLE central_superstore
(
    "Row ID"      INTEGER
            primary key,
    "Order ID"    TEXT,
    "Order Date"  DATE,
    "Ship Date"   DATE,
    "Ship Mode"   TEXT,
    "Customer ID" TEXT,
    Region        TEXT,
    "Product ID"  TEXT,
    Sales         REAL,
    Quantity      INTEGER,
    Discount      REAL,
    Profit        REAL,
    foreign key ("Customer ID", Region) references people("Customer ID",Region),
    foreign key ("Product ID", Region) references product("Product ID",Region)
);

CREATE TABLE east_superstore
(
    "Row ID"      INTEGER
            primary key,
    "Order ID"    TEXT,
    "Order Date"  DATE,
    "Ship Date"   DATE,
    "Ship Mode"   TEXT,
    "Customer ID" TEXT,
    Region        TEXT,
    "Product ID"  TEXT,
    Sales         REAL,
    Quantity      INTEGER,
    Discount      REAL,
    Profit        REAL,
    foreign key ("Customer ID", Region) references people("Customer ID",Region),
    foreign key ("Product ID", Region) references product("Product ID",Region)
);

CREATE TABLE people
(
    "Customer ID"   TEXT,
    "Customer Name" TEXT,
    Segment         TEXT,
    Country         TEXT,
    City            TEXT,
    State           TEXT,
    "Postal Code"   INTEGER,
    Region          TEXT,
    primary key ("Customer ID", Region)
);

CREATE TABLE product
(
    "Product ID"   TEXT,
    "Product Name" TEXT,
    Category       TEXT,
    "Sub-Category" TEXT,
    Region         TEXT,
    primary key ("Product ID", Region)
);

CREATE TABLE south_superstore
(
    "Row ID"      INTEGER
            primary key,
    "Order ID"    TEXT,
    "Order Date"  DATE,
    "Ship Date"   DATE,
    "Ship Mode"   TEXT,
    "Customer ID" TEXT,
    Region        TEXT,
    "Product ID"  TEXT,
    Sales         REAL,
    Quantity      INTEGER,
    Discount      REAL,
    Profit        REAL,
    foreign key ("Customer ID", Region) references people("Customer ID",Region),
    foreign key ("Product ID", Region) references product("Product ID",Region)
);

CREATE TABLE west_superstore
(
    "Row ID"      INTEGER
            primary key,
    "Order ID"    TEXT,
    "Order Date"  DATE,
    "Ship Date"   DATE,
    "Ship Mode"   TEXT,
    "Customer ID" TEXT,
    Region        TEXT,
    "Product ID"  TEXT,
    Sales         REAL,
    Quantity      INTEGER,
    Discount      REAL,
    Profit        REAL,
    foreign key ("Customer ID", Region) references people("Customer ID",Region),
    foreign key ("Product ID", Region) references product("Product ID",Region)
);