CREATE TABLE city
(
    city_id    INTEGER
            primary key,
    city_name  TEXT,
    state      TEXT,
    population INTEGER,
    area       REAL
);

CREATE TABLE customer
(
    cust_id        INTEGER
            primary key,
    cust_name      TEXT,
    annual_revenue INTEGER,
    cust_type      TEXT,
    address        TEXT,
    city           TEXT,
    state          TEXT,
    zip            REAL,
    phone          TEXT
);

CREATE TABLE driver
(
    driver_id  INTEGER
            primary key,
    first_name TEXT,
    last_name  TEXT,
    address    TEXT,
    city       TEXT,
    state      TEXT,
    zip_code   INTEGER,
    phone      TEXT
);

CREATE TABLE shipment
(
    ship_id   INTEGER
            primary key,
    cust_id   INTEGER,
    weight    REAL,
    truck_id  INTEGER,
    driver_id INTEGER,
    city_id   INTEGER,
    ship_date TEXT,
    foreign key (cust_id) references customer(cust_id),
    foreign key (city_id) references city(city_id),
    foreign key (driver_id) references driver(driver_id),
    foreign key (truck_id) references truck(truck_id)
);

CREATE TABLE truck
(
    truck_id   INTEGER
            primary key,
    make       TEXT,
    model_year INTEGER
);