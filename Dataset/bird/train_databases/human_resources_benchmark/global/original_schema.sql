CREATE TABLE employee
(
    ssn         TEXT
            primary key,
    lastname    TEXT,
    firstname   TEXT,
    hiredate    TEXT,
    salary      TEXT,
    gender      TEXT,
    performance TEXT,
    positionID  INTEGER,
    locationID  INTEGER,
    foreign key (locationID) references location(locationID),
    foreign key (positionID) references position(positionID)
);

CREATE TABLE location
(
    locationID   INTEGER
        constraint location_pk
            primary key,
    locationcity TEXT,
    address      TEXT,
    state        TEXT,
    zipcode      INTEGER,
    officephone  TEXT
);

CREATE TABLE position
(
    positionID        INTEGER
        constraint position_pk
            primary key,
    positiontitle     TEXT,
    educationrequired TEXT,
    minsalary         TEXT,
    maxsalary         TEXT
);