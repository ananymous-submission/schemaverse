CREATE TABLE "actors"
(
    actorid   INTEGER not null
        primary key,
    a_gender  TEXT    not null,
    a_quality INTEGER not null
);

CREATE TABLE "directors"
(
    directorid  INTEGER not null
        primary key,
    d_quality   INTEGER not null,
    avg_revenue INTEGER not null
);

CREATE TABLE "movies"
(
    movieid     INTEGER default 0 not null
        primary key,
    year        INTEGER           not null,
    isEnglish   TEXT              not null,
    country     TEXT              not null,
    runningtime INTEGER           not null
);

CREATE TABLE "movies2actors"
(
    movieid  INTEGER not null
        references movies
            on update cascade on delete cascade,
    actorid  INTEGER not null
        references actors
            on update cascade on delete cascade,
    cast_num INTEGER not null,
    primary key (movieid, actorid)
);

CREATE TABLE "movies2directors"
(
    movieid    INTEGER not null
        references movies
            on update cascade on delete cascade,
    directorid INTEGER not null
        references directors
            on update cascade on delete cascade,
    genre      TEXT    not null,
    primary key (movieid, directorid)
);

CREATE TABLE "u2base"
(
    userid  INTEGER default 0 not null
        references users
            on update cascade on delete cascade,
    movieid INTEGER           not null
        references movies
            on update cascade on delete cascade,
    rating  TEXT              not null,
    primary key (userid, movieid)
);

CREATE TABLE users
(
    userid     INTEGER default 0 not null
        primary key,
    age        TEXT    not null,
    u_gender   TEXT    not null,
    occupation TEXT   not null
);