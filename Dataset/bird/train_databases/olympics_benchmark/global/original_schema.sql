CREATE TABLE city
(
    id        INTEGER not null
            primary key,
    city_name TEXT default NULL
);

CREATE TABLE competitor_event
(
    event_id      INTEGER default NULL,
    competitor_id INTEGER default NULL,
    medal_id      INTEGER default NULL,
    foreign key (competitor_id) references games_competitor(id),
    foreign key (event_id) references event(id),
    foreign key (medal_id) references medal(id)
);

CREATE TABLE event
(
    id         INTEGER not null
            primary key,
    sport_id   INTEGER          default NULL,
    event_name TEXT default NULL,
    foreign key (sport_id) references sport(id)
);

CREATE TABLE games
(
    id         INTEGER not null
            primary key,
    games_year INTEGER          default NULL,
    games_name TEXT default NULL,
    season     TEXT default NULL
);

CREATE TABLE games_city
(
    games_id INTEGER default NULL,
    city_id  INTEGER default NULL,
    foreign key (city_id) references city(id),
    foreign key (games_id) references games(id)
);

CREATE TABLE games_competitor
(
    id        INTEGER not null
            primary key,
    games_id  INTEGER default NULL,
    person_id INTEGER default NULL,
    age       INTEGER default NULL,
    foreign key (games_id) references games(id),
    foreign key (person_id) references person(id)
);

CREATE TABLE medal
(
    id         INTEGER not null
            primary key,
    medal_name TEXT default NULL
);

CREATE TABLE noc_region
(
    id          INTEGER not null
            primary key,
    noc         TEXT   default NULL,
    region_name TEXT default NULL
);

CREATE TABLE person
(
    id        INTEGER not null
        primary key,
    full_name TEXT default NULL,
    gender    TEXT  default NULL,
    height    INTEGER          default NULL,
    weight    INTEGER          default NULL
);

CREATE TABLE person_region
(
    person_id INTEGER default NULL,
    region_id INTEGER default NULL,
    foreign key (person_id) references person(id),
    foreign key (region_id) references noc_region(id)
);

CREATE TABLE sport
(
    id         INTEGER not null
            primary key,
    sport_name TEXT default NULL
);