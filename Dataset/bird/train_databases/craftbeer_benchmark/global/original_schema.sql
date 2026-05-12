CREATE TABLE "beers"
(
    id         INTEGER not null
        primary key,
    brewery_id INTEGER not null
        constraint beers_ibfk_1
            references breweries,
    abv        REAL,
    ibu        REAL,
    name       TEXT    not null,
    style      TEXT,
    ounces     REAL    not null
);

CREATE TABLE breweries
(
    id    INTEGER          not null
        primary key,
    name  TEXT null,
    city  TEXT null,
    state TEXT null
);