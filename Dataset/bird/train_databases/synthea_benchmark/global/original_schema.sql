CREATE TABLE all_prevalences
(
    ITEM                    TEXT
            primary key,
    "POPULATION TYPE"       TEXT,
    OCCURRENCES             INTEGER,
    "POPULATION COUNT"      INTEGER,
    "PREVALENCE RATE"       REAL,
    "PREVALENCE PERCENTAGE" REAL
);

CREATE TABLE allergies
(
    START       TEXT,
    STOP        TEXT,
    PATIENT     TEXT,
    ENCOUNTER   TEXT,
    CODE        INTEGER,
    DESCRIPTION TEXT,
    primary key (PATIENT, ENCOUNTER, CODE),
    foreign key (ENCOUNTER) references encounters(ID),
    foreign key (PATIENT) references patients(patient)
);

CREATE TABLE careplans
(
    ID                TEXT,
    START             DATE,
    STOP              DATE,
    PATIENT           TEXT,
    ENCOUNTER         TEXT,
    CODE              REAL,
    DESCRIPTION       TEXT,
    REASONCODE        INTEGER,
    REASONDESCRIPTION TEXT,
    foreign key (ENCOUNTER) references encounters(ID),
    foreign key (PATIENT) references patients(patient)
);

CREATE TABLE "claims"
(
    ID             TEXT
        primary key,
    PATIENT        TEXT
        references patients,
    BILLABLEPERIOD DATE,
    ORGANIZATION   TEXT,
    ENCOUNTER      TEXT
        references encounters,
    DIAGNOSIS      TEXT,
    TOTAL          INTEGER
);

CREATE TABLE conditions
(
    START       DATE,
    STOP        DATE,
    PATIENT     TEXT,
    ENCOUNTER   TEXT,
    CODE        INTEGER,
    DESCRIPTION TEXT,
    foreign key (ENCOUNTER) references encounters(ID),
    foreign key (PATIENT) references patients(patient),
    foreign key (DESCRIPTION) references all_prevalences(ITEM)
);

CREATE TABLE encounters
(
    ID                TEXT
            primary key,
    DATE              DATE,
    PATIENT           TEXT,
    CODE              INTEGER,
    DESCRIPTION       TEXT,
    REASONCODE        INTEGER,
    REASONDESCRIPTION TEXT,
    foreign key (PATIENT) references patients(patient)
);

CREATE TABLE immunizations
(
    DATE        DATE,
    PATIENT     TEXT,
    ENCOUNTER   TEXT,
    CODE        INTEGER,
    DESCRIPTION TEXT,
    primary key (DATE, PATIENT, ENCOUNTER, CODE),
    foreign key (ENCOUNTER) references encounters(ID),
    foreign key (PATIENT) references patients(patient)
);

CREATE TABLE medications
(
    START             DATE,
    STOP              DATE,
    PATIENT           TEXT,
    ENCOUNTER         TEXT,
    CODE              INTEGER,
    DESCRIPTION       TEXT,
    REASONCODE        INTEGER,
    REASONDESCRIPTION TEXT,
    primary key (START, PATIENT, ENCOUNTER, CODE),
    foreign key (ENCOUNTER) references encounters(ID),
    foreign key (PATIENT) references patients(patient)
);

CREATE TABLE observations
(
    DATE        DATE,
    PATIENT     TEXT,
    ENCOUNTER   TEXT,
    CODE        TEXT,
    DESCRIPTION TEXT,
    VALUE       REAL,
    UNITS       TEXT,
    foreign key (ENCOUNTER) references encounters(ID),
    foreign key (PATIENT) references patients(patient)
);

CREATE TABLE patients
(
    patient    TEXT
            primary key,
    birthdate  DATE,
    deathdate  DATE,
    ssn        TEXT,
    drivers    TEXT,
    passport   TEXT,
    prefix     TEXT,
    first      TEXT,
    last       TEXT,
    suffix     TEXT,
    maiden     TEXT,
    marital    TEXT,
    race       TEXT,
    ethnicity  TEXT,
    gender     TEXT,
    birthplace TEXT,
    address    TEXT
);

CREATE TABLE procedures
(
    DATE              DATE,
    PATIENT           TEXT,
    ENCOUNTER         TEXT,
    CODE              INTEGER,
    DESCRIPTION       TEXT,
    REASONCODE        INTEGER,
    REASONDESCRIPTION TEXT,
    foreign key (ENCOUNTER) references encounters(ID),
    foreign key (PATIENT) references patients(patient)
);