CREATE TABLE callcenterlogs
(
    "Date received" DATE,
    "Complaint ID"  TEXT,
    "rand client"   TEXT,
    phonefinal      TEXT,
    "vru+line"      TEXT,
    call_id         INTEGER,
    priority        INTEGER,
    type            TEXT,
    outcome         TEXT,
    server          TEXT,
    ser_start       TEXT,
    ser_exit        TEXT,
    ser_time        TEXT,
    primary key ("Complaint ID"),
    foreign key ("rand client") references client(client_id)
);

CREATE TABLE client
(
    client_id   TEXT
            primary key,
    sex         TEXT,
    day         INTEGER,
    month       INTEGER,
    year        INTEGER,
    age         INTEGER,
    social      TEXT,
    first       TEXT,
    middle      TEXT,
    last        TEXT,
    phone       TEXT,
    email       TEXT,
    address_1   TEXT,
    address_2   TEXT,
    city        TEXT,
    state       TEXT,
    zipcode     INTEGER,
    district_id INTEGER,
    foreign key (district_id) references district(district_id)
);

CREATE TABLE district
(
    district_id  INTEGER
            primary key,
    city         TEXT,
    state_abbrev TEXT,
    division     TEXT,
    foreign key (state_abbrev) references state(StateCode)
);

CREATE TABLE events
(
    "Date received"                DATE,
    Product                        TEXT,
    "Sub-product"                  TEXT,
    Issue                          TEXT,
    "Sub-issue"                    TEXT,
    "Consumer complaint narrative" TEXT,
    Tags                           TEXT,
    "Consumer consent provided?"   TEXT,
    "Submitted via"                TEXT,
    "Date sent to company"         TEXT,
    "Company response to consumer" TEXT,
    "Timely response?"             TEXT,
    "Consumer disputed?"           TEXT,
    "Complaint ID"                 TEXT,
    Client_ID                      TEXT,
    primary key ("Complaint ID", Client_ID),
    foreign key ("Complaint ID") references callcenterlogs("Complaint ID"),
    foreign key (Client_ID) references client(client_id)
);

CREATE TABLE reviews
(
    "Date"        DATE
            primary key,
    Stars       INTEGER,
    Reviews     TEXT,
    Product     TEXT,
    district_id INTEGER,
    foreign key (district_id) references district(district_id)
);

CREATE TABLE state
(
    StateCode TEXT
        constraint state_pk
            primary key,
    State     TEXT,
    Region    TEXT
);