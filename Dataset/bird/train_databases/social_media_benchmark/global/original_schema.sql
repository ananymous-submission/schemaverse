CREATE TABLE location
(
    LocationID INTEGER
        constraint location_pk
            primary key,
    Country    TEXT,
    State      TEXT,
    StateCode  TEXT,
    City       TEXT
);

CREATE TABLE twitter
(
    TweetID         TEXT
            primary key,
    Weekday         TEXT,
    Hour         INTEGER,
    Day          INTEGER,
    Lang         TEXT,
    IsReshare    TEXT,
    Reach        INTEGER,
    RetweetCount INTEGER,
    Likes        INTEGER,
    Klout        INTEGER,
    Sentiment    REAL,
    "text"         TEXT,
    LocationID   INTEGER,
    UserID       TEXT,
    foreign key (LocationID) references location(LocationID),
    foreign key (UserID) references user(UserID)
);

CREATE TABLE user
(
    UserID TEXT
        constraint user_pk
            primary key,
    Gender TEXT
);