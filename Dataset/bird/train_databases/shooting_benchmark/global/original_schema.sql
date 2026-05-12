CREATE TABLE incidents
(
    case_number                TEXT  not null
        primary key,
    date                       DATE          not null,
    location                   TEXT  not null,
    subject_statuses           TEXT  not null,
    subject_weapon             TEXT  not null,
    subjects                   TEXT  not null,
    subject_count              INTEGER           not null,
    officers                  TEXT not null

);

CREATE TABLE officers
(
    case_number TEXT not null,
    race        TEXT         null,
    gender      TEXT         not null,
    last_name   TEXT not null,
    first_name  TEXT null,
    full_name   TEXT not null,
    foreign key (case_number) references incidents (case_number)
);

CREATE TABLE subjects
(
    case_number TEXT not null,
    race        TEXT         not null,
    gender      TEXT         not null,
    last_name   TEXT not null,
    first_name  TEXT null,
    full_name   TEXT not null,
    foreign key (case_number) references incidents (case_number)
);