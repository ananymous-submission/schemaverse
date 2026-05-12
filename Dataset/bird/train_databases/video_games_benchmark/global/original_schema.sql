CREATE TABLE game
(
    id        INTEGER not null
            primary key,
    genre_id  INTEGER          default NULL,
    game_name TEXT default NULL,
    foreign key (genre_id) references genre(id)
);

CREATE TABLE game_platform
(
    id                INTEGER not null
            primary key,
    game_publisher_id INTEGER default NULL,
    platform_id       INTEGER default NULL,
    release_year      INTEGER default NULL,
    foreign key (game_publisher_id) references game_publisher(id),
    foreign key (platform_id) references platform(id)
);

CREATE TABLE game_publisher
(
    id           INTEGER not null
            primary key,
    game_id      INTEGER default NULL,
    publisher_id INTEGER default NULL,
    foreign key (game_id) references game(id),
    foreign key (publisher_id) references publisher(id)
);

CREATE TABLE genre
(
    id         INTEGER not null
            primary key,
    genre_name TEXT default NULL
);

CREATE TABLE platform
(
    id            INTEGER not null
            primary key,
    platform_name TEXT default NULL
);

CREATE TABLE publisher
(
    id             INTEGER not null
            primary key,
    publisher_name TEXT default NULL
);

CREATE TABLE region
(
    id          INTEGER not null
            primary key,
    region_name TEXT default NULL
);

CREATE TABLE region_sales
(
    region_id        INTEGER           default NULL,
    game_platform_id INTEGER           default NULL,
    num_sales        REAL default NULL,
    foreign key (game_platform_id) references game_platform(id),
    foreign key (region_id) references region(id)
);