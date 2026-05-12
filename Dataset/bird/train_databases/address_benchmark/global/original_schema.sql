CREATE TABLE CBSA
(
    CBSA      INTEGER
            primary key,
    CBSA_name TEXT,
    CBSA_type TEXT
);

CREATE TABLE alias
(
    zip_code INTEGER
            primary key,
    alias    TEXT,
    foreign key (zip_code) references zip_data(zip_code)
);

CREATE TABLE area_code
(
    zip_code  INTEGER,
    area_code INTEGER,
    primary key (zip_code, area_code),
    foreign key (zip_code) references zip_data(zip_code)
);

CREATE TABLE avoid
(
    zip_code  INTEGER,
    bad_alias TEXT,
    primary key (zip_code, bad_alias),
    foreign key (zip_code) references zip_data(zip_code)
);

CREATE TABLE congress
(
    cognress_rep_id TEXT
            primary key,
    first_name      TEXT,
    last_name       TEXT,
    CID             TEXT,
    party           TEXT,
    state           TEXT,
    abbreviation    TEXT,
    House           TEXT,
    District        INTEGER,
    land_area       REAL,
    foreign key (abbreviation) references state(abbreviation)
);

CREATE TABLE country
(
    zip_code INTEGER,
    county   TEXT,
    state    TEXT,
    primary key (zip_code, county),
    foreign key (zip_code) references zip_data(zip_code),
    foreign key (state) references state(abbreviation)
);

CREATE TABLE state
(
    abbreviation TEXT
            primary key,
    name         TEXT
);

CREATE TABLE zip_congress
(
    zip_code INTEGER,
    district TEXT,
    primary key (zip_code, district),
    foreign key (district) references congress(cognress_rep_id),
    foreign key (zip_code) references zip_data(zip_code)
);

CREATE TABLE zip_data
(
    zip_code                         INTEGER
            primary key,
    city                             TEXT,
    state                            TEXT,
    multi_county                     TEXT,
    type                             TEXT,
    organization                     TEXT,
    time_zone                        TEXT,
    daylight_savings                 TEXT,
    latitude                         REAL,
    longitude                        REAL,
    elevation                        INTEGER,
    state_fips                       INTEGER,
    county_fips                      INTEGER,
    region                           TEXT,
    division                         TEXT,
    population_2020                  INTEGER,
    population_2010                  INTEGER,
    households                       INTEGER,
    avg_house_value                  INTEGER,
    avg_income_per_household         INTEGER,
    persons_per_household            REAL,
    white_population                 INTEGER,
    black_population                 INTEGER,
    hispanic_population              INTEGER,
    asian_population                 INTEGER,
    american_indian_population       INTEGER,
    hawaiian_population              INTEGER,
    other_population                 INTEGER,
    male_population                  INTEGER,
    female_population                INTEGER,
    median_age                       REAL,
    male_median_age                  REAL,
    female_median_age                REAL,
    residential_mailboxes            INTEGER,
    business_mailboxes               INTEGER,
    total_delivery_receptacles       INTEGER,
    businesses                       INTEGER,
    "1st_quarter_payroll"            INTEGER,
    annual_payroll                   INTEGER,
    employees                        INTEGER,
    water_area                       REAL,
    land_area                        REAL,
    single_family_delivery_units     INTEGER,
    multi_family_delivery_units      INTEGER,
    total_beneficiaries              INTEGER,
    retired_workers                  INTEGER,
    disabled_workers                 INTEGER,
    parents_and_widowed              INTEGER,
    spouses                          INTEGER,
    children                         INTEGER,
    over_65                          INTEGER,
    monthly_benefits_all             INTEGER,
    monthly_benefits_retired_workers INTEGER,
    monthly_benefits_widowed         INTEGER,
    CBSA                             INTEGER,
    foreign key (state) references state(abbreviation),
    foreign key (CBSA) references CBSA(CBSA)
);