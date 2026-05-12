CREATE TABLE "Author"
(
    Id          INTEGER
        constraint Author_pk
            primary key,
    Name        TEXT,
    Affiliation TEXT
);

CREATE TABLE "Conference"
(
    Id        INTEGER
        constraint Conference_pk
            primary key,
    ShortName TEXT,
    FullName  TEXT,
    HomePage  TEXT
);

CREATE TABLE "Journal"
(
    Id        INTEGER
        constraint Journal_pk
            primary key,
    ShortName TEXT,
    FullName  TEXT,
    HomePage  TEXT
);

CREATE TABLE Paper
(
    Id           INTEGER
            primary key,
    Title        TEXT,
    Year         INTEGER,
    ConferenceId INTEGER,
    JournalId    INTEGER,
    Keyword      TEXT,
    foreign key (ConferenceId) references Conference(Id),
    foreign key (JournalId) references Journal(Id)
);

CREATE TABLE PaperAuthor
(
    PaperId     INTEGER,
    AuthorId    INTEGER,
    Name        TEXT,
    Affiliation TEXT,
    foreign key (PaperId) references Paper(Id),
    foreign key (AuthorId) references Author(Id)
);