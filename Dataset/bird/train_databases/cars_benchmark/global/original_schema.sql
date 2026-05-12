CREATE TABLE country
(
    origin  INTEGER
            primary key,
    country TEXT
);

CREATE TABLE data
(
    ID           INTEGER
            primary key,
    mpg          REAL,
    cylinders    INTEGER,
    displacement REAL,
    horsepower   INTEGER,
    weight       INTEGER,
    acceleration REAL,
    model        INTEGER,
    car_name     TEXT,
    foreign key (ID) references price(ID)
);

CREATE TABLE price
(
    ID    INTEGER
            primary key,
    price REAL
);

CREATE TABLE production
(
    ID         INTEGER,
    model_year INTEGER,
    country    INTEGER,
    primary key (ID, model_year),
    foreign key (country) references country(origin),
    foreign key (ID) references data(ID),
    foreign key (ID) references price(ID)
);