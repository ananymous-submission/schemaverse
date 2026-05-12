CREATE TABLE Community_Area
(
    community_area_no   INTEGER
            primary key,
    community_area_name TEXT,
    side                TEXT,
    population          TEXT
);

CREATE TABLE Crime
(
    report_no            INTEGER
            primary key,
    case_number          TEXT,
    date                 TEXT,
    block                TEXT,
    iucr_no              TEXT,
    location_description TEXT,
    arrest               TEXT,
    domestic             TEXT,
    beat                 INTEGER,
    district_no          INTEGER,
    ward_no              INTEGER,
    community_area_no    INTEGER,
    fbi_code_no          TEXT,
    latitude             TEXT,
    longitude            TEXT,
    foreign key (ward_no) references Ward(ward_no),
    foreign key (iucr_no) references IUCR(iucr_no),
    foreign key (district_no) references District(district_no),
    foreign key (community_area_no) references Community_Area(community_area_no),
    foreign key (fbi_code_no) references FBI_Code(fbi_code_no)
);

CREATE TABLE District
(
    district_no   INTEGER
            primary key,
    district_name TEXT,
    address       TEXT,
    zip_code      INTEGER,
    commander     TEXT,
    email         TEXT,
    phone         TEXT,
    fax           TEXT,
    tty           TEXT,
    twitter       TEXT
);

CREATE TABLE FBI_Code
(
    fbi_code_no   TEXT
            primary key,
    title         TEXT,
    description   TEXT,
    crime_against TEXT
);

CREATE TABLE IUCR
(
    iucr_no               TEXT
            primary key,
    primary_description   TEXT,
    secondary_description TEXT,
    index_code            TEXT
);

CREATE TABLE Neighborhood
(
    neighborhood_name TEXT
            primary key,
    community_area_no INTEGER,
    foreign key (community_area_no) references Community_Area(community_area_no)
);

CREATE TABLE Ward
(
    ward_no                INTEGER
            primary key,
    alderman_first_name    TEXT,
    alderman_last_name     TEXT,
    alderman_name_suffix   TEXT,
    ward_office_address    TEXT,
    ward_office_zip        TEXT,
    ward_email             TEXT,
    ward_office_phone      TEXT,
    ward_office_fax        TEXT,
    city_hall_office_room  INTEGER,
    city_hall_office_phone TEXT,
    city_hall_office_fax   TEXT,
    Population             INTEGER
);