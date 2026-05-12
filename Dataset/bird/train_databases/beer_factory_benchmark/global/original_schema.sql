CREATE TABLE customers
(
    CustomerID            INTEGER
            primary key,
    First                 TEXT,
    Last                  TEXT,
    StreetAddress         TEXT,
    City                  TEXT,
    State                 TEXT,
    ZipCode               INTEGER,
    Email                 TEXT,
    PhoneNumber           TEXT,
    FirstPurchaseDate     DATE,
    SubscribedToEmailList TEXT,
    Gender                TEXT
);

CREATE TABLE geolocation
(
    LocationID INTEGER
            primary key,
    Latitude   REAL,
    Longitude  REAL,
    foreign key (LocationID) references location(LocationID)
);

CREATE TABLE location
(
    LocationID    INTEGER
            primary key,
    LocationName  TEXT,
    StreetAddress TEXT,
    City          TEXT,
    State         TEXT,
    ZipCode       INTEGER,
    foreign key (LocationID) references geolocation(LocationID)
);

CREATE TABLE rootbeer
(
    RootBeerID    INTEGER
            primary key,
    BrandID       INTEGER,
    ContainerType TEXT,
    LocationID    INTEGER,
    PurchaseDate  DATE,
    foreign key (LocationID) references geolocation(LocationID),
    foreign key (LocationID) references location(LocationID),
    foreign key (BrandID) references rootbeerbrand(BrandID)
);

CREATE TABLE rootbeerbrand
(
    BrandID             INTEGER
            primary key,
    BrandName           TEXT,
    FirstBrewedYear     INTEGER,
    BreweryName         TEXT,
    City                TEXT,
    State               TEXT,
    Country             TEXT,
    Description         TEXT,
    CaneSugar           TEXT,
    CornSyrup           TEXT,
    Honey               TEXT,
    ArtificialSweetener TEXT,
    Caffeinated         TEXT,
    Alcoholic           TEXT,
    AvailableInCans     TEXT,
    AvailableInBottles  TEXT,
    AvailableInKegs     TEXT,
    Website             TEXT,
    FacebookPage        TEXT,
    Twitter             TEXT,
    WholesaleCost       REAL,
    CurrentRetailPrice  REAL
);

CREATE TABLE rootbeerreview
(
    CustomerID INTEGER,
    BrandID    INTEGER,
    StarRating INTEGER,
    ReviewDate DATE,
    Review     TEXT,
    primary key (CustomerID, BrandID),
    foreign key (CustomerID) references customers(CustomerID),
    foreign key (BrandID) references rootbeerbrand(BrandID)
);

CREATE TABLE "transaction"
(
    TransactionID    INTEGER
            primary key,
    CreditCardNumber INTEGER,
    CustomerID       INTEGER,
    TransactionDate  DATE,
    CreditCardType   TEXT,
    LocationID       INTEGER,
    RootBeerID       INTEGER,
    PurchasePrice    REAL,
    foreign key (CustomerID) references customers(CustomerID),
    foreign key (LocationID) references location(LocationID),
    foreign key (RootBeerID) references rootbeer(RootBeerID)
);