CREATE TABLE generalinfo
(
    id_restaurant INTEGER         not null
        primary key,
    label         TEXT  null,
    food_type     TEXT  null,
    city          TEXT  null,
    review        REAL null,
    foreign key (city) references geographic(city)
            on update cascade on delete cascade
);

CREATE TABLE geographic
(
    city   TEXT not null
        primary key,
    county TEXT null,
    region TEXT null
);

CREATE TABLE location
(
    id_restaurant INTEGER        not null
        primary key,
    street_num    INTEGER          null,
    street_name   TEXT null,
    city          TEXT null,
    foreign key (city) references geographic (city)
            on update cascade on delete cascade,
    foreign key (id_restaurant) references generalinfo (id_restaurant)
            on update cascade on delete cascade
);