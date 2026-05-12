CREATE TABLE "Customers"
(
    ID             INTEGER
        constraint Customers_pk
            primary key,
    SEX            TEXT,
    MARITAL_STATUS TEXT,
    GEOID          INTEGER
        constraint Customers_Demog_GEOID_fk
            references Demog,
    EDUCATIONNUM   INTEGER,
    OCCUPATION     TEXT,
    age            INTEGER
);

CREATE TABLE Demog
(
    GEOID         INTEGER
        constraint Demog_pk
            primary key,
    INHABITANTS_K REAL,
    INCOME_K      REAL,
    A_VAR1        REAL,
    A_VAR2        REAL,
    A_VAR3        REAL,
    A_VAR4        REAL,
    A_VAR5        REAL,
    A_VAR6        REAL,
    A_VAR7        REAL,
    A_VAR8        REAL,
    A_VAR9        REAL,
    A_VAR10       REAL,
    A_VAR11       REAL,
    A_VAR12       REAL,
    A_VAR13       REAL,
    A_VAR14       REAL,
    A_VAR15       REAL,
    A_VAR16       REAL,
    A_VAR17       REAL,
    A_VAR18       REAL
);

CREATE TABLE "Mailings1_2"
(
    REFID    INTEGER
        constraint Mailings1_2_pk
            primary key
        constraint Mailings1_2_Customers_ID_fk
            references Customers,
    REF_DATE DATETIME,
    RESPONSE TEXT
);

CREATE TABLE "Sales"
(
    EVENTID    INTEGER
        constraint Sales_pk
            primary key,
    REFID      INTEGER
        references Customers,
    EVENT_DATE DATETIME,
    AMOUNT     REAL
);

CREATE TABLE mailings3
(
    REFID    INTEGER
        constraint mailings3_pk
            primary key,
    REF_DATE DATETIME,
    RESPONSE TEXT
);