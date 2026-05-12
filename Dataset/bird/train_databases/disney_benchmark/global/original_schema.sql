CREATE TABLE characters
(
    movie_title  TEXT
            primary key,
    release_date TEXT,
    hero         TEXT,
    villian      TEXT,
    song         TEXT,
    foreign key (hero) references "voice-actors"(character)
);

CREATE TABLE director
(
    name     TEXT
            primary key,
    director TEXT,
    foreign key (name) references characters(movie_title)
);

CREATE TABLE movies_total_gross
(
    movie_title              TEXT,
    release_date             TEXT,
    genre                    TEXT,
    MPAA_rating              TEXT,
    total_gross              TEXT,
    inflation_adjusted_gross TEXT,
    primary key (movie_title, release_date),
    foreign key (movie_title) references characters(movie_title)
);

CREATE TABLE revenue
(
    Year                              INTEGER
            primary key,
    "Studio Entertainment[NI 1]"      REAL,
    "Disney Consumer Products[NI 2]"  REAL,
    "Disney Interactive[NI 3][Rev 1]" INTEGER,
    "Walt Disney Parks and Resorts"   REAL,
    "Disney Media Networks"           TEXT,
    Total                             INTEGER
);

CREATE TABLE "voice-actors"
(
    character     TEXT
            primary key,
    "voice-actor" TEXT,
    movie         TEXT,
    foreign key (movie) references characters(movie_title)
);