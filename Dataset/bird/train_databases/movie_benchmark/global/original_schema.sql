CREATE TABLE actor
(
    ActorID           INTEGER
        constraint actor_pk
            primary key,
    Name              TEXT,
    "Date of Birth"   DATE,
    "Birth City"      TEXT,
    "Birth Country"   TEXT,
    "Height (Inches)" INTEGER,
    Biography         TEXT,
    Gender            TEXT,
    Ethnicity         TEXT,
    NetWorth          TEXT
);

CREATE TABLE characters
(
    MovieID          INTEGER,
    ActorID          INTEGER,
    "Character Name" TEXT,
    creditOrder      INTEGER,
    pay              TEXT,
    screentime       TEXT,
    primary key (MovieID, ActorID),
    foreign key (ActorID) references actor(ActorID),
    foreign key (MovieID) references movie(MovieID)
);

CREATE TABLE movie
(
    MovieID        INTEGER
        constraint movie_pk
            primary key,
    Title          TEXT,
    "MPAA Rating"  TEXT,
    Budget         INTEGER,
    Gross          INTEGER,
    "Release Date" TEXT,
    Genre          TEXT,
    Runtime        INTEGER,
    Rating         REAL,
    "Rating Count" INTEGER,
    Summary        TEXT
);