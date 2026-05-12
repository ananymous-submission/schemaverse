CREATE TABLE employee
(
    employee_id INTEGER
            primary key,
    first_name  TEXT,
    last_name   TEXT,
    address     TEXT,
    city        TEXT,
    state       TEXT,
    zip         INTEGER,
    phone       TEXT,
    title       TEXT,
    salary      INTEGER,
    supervisor  INTEGER,
    foreign key (supervisor) references employee(employee_id)
);

CREATE TABLE establishment
(
    license_no    INTEGER
            primary key,
    dba_name      TEXT,
    aka_name      TEXT,
    facility_type TEXT,
    risk_level    INTEGER,
    address       TEXT,
    city          TEXT,
    state         TEXT,
    zip           INTEGER,
    latitude      REAL,
    longitude     REAL,
    ward          INTEGER
);

CREATE TABLE inspection
(
    inspection_id   INTEGER
            primary key,
    inspection_date DATE,
    inspection_type TEXT,
    results         TEXT,
    employee_id     INTEGER,
    license_no      INTEGER,
    followup_to     INTEGER,
    foreign key (employee_id) references employee(employee_id),
    foreign key (license_no) references establishment(license_no),
    foreign key (followup_to) references inspection(inspection_id)
);

CREATE TABLE inspection_point
(
    point_id    INTEGER
            primary key,
    Description TEXT,
    category    TEXT,
    code        TEXT,
    fine        INTEGER,
    point_level TEXT
);

CREATE TABLE violation
(
    inspection_id     INTEGER,
    point_id          INTEGER,
    fine              INTEGER,
    inspector_comment TEXT,
    primary key (inspection_id, point_id),
    foreign key (inspection_id) references inspection(inspection_id),
    foreign key (point_id) references inspection_point(point_id)
);