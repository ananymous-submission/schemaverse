CREATE TABLE relation
(
    store_nbr   INTEGER
            primary key,
    station_nbr INTEGER,
    foreign key (store_nbr) references sales_in_weather(store_nbr),
    foreign key (station_nbr) references weather(station_nbr)
);

CREATE TABLE sales_in_weather
(
    date      DATE,
    store_nbr INTEGER,
    item_nbr  INTEGER,
    units     INTEGER,
    primary key (store_nbr, date, item_nbr)
);

CREATE TABLE weather
(
    station_nbr INTEGER,
    date        DATE,
    tmax        INTEGER,
    tmin        INTEGER,
    tavg        INTEGER,
    depart      INTEGER,
    dewpoint    INTEGER,
    wetbulb     INTEGER,
    heat        INTEGER,
    cool        INTEGER,
    sunrise     TEXT,
    sunset      TEXT,
    codesum     TEXT,
    snowfall    REAL,
    preciptotal REAL,
    stnpressure REAL,
    sealevel    REAL,
    resultspeed REAL,
    resultdir   INTEGER,
    avgspeed    REAL,
    primary key (station_nbr, date)
);