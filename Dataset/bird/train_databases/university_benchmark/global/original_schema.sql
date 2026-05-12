CREATE TABLE country
(
    id           INTEGER not null
            primary key,
    country_name TEXT default NULL
);

CREATE TABLE ranking_criteria
(
    id                INTEGER not null
            primary key,
    ranking_system_id INTEGER          default NULL,
    criteria_name     TEXT default NULL,
    foreign key (ranking_system_id) references ranking_system(id)
);

CREATE TABLE ranking_system
(
    id          INTEGER not null
            primary key,
    system_name TEXT default NULL
);

CREATE TABLE university
(
    id              INTEGER not null
            primary key,
    country_id      INTEGER          default NULL,
    university_name TEXT default NULL,
    foreign key (country_id) references country(id)
);

CREATE TABLE university_ranking_year
(
    university_id       INTEGER default NULL,
    ranking_criteria_id INTEGER default NULL,
    year                INTEGER default NULL,
    score               INTEGER default NULL,
    foreign key (ranking_criteria_id) references ranking_criteria(id),
    foreign key (university_id) references university(id)
);

CREATE TABLE university_year
(
    university_id              INTEGER           default NULL,
    year                       INTEGER           default NULL,
    num_students               INTEGER           default NULL,
    student_staff_ratio        REAL default NULL,
    pct_international_students INTEGER           default NULL,
    pct_female_students        INTEGER           default NULL,
    foreign key (university_id) references university(id)
);