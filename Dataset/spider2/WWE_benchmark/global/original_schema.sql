CREATE TABLE Belts (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
            name TEXT UNIQUE
    );

CREATE TABLE Cards (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
            table_id INTEGER,
            location_id INTEGER,
            promotion_id INTEGER,
            event_date TEXT,
            event_id INTEGER,
            url TEXT UNIQUE,
            info_html TEXT,
            match_html TEXT UNIQUE
        );

CREATE TABLE Events (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
            name TEXT UNIQUE
        );

CREATE TABLE Locations (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
            name TEXT UNIQUE
        );

CREATE TABLE Match_Types (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
            name TEXT UNIQUE
    );

CREATE TABLE Matches (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
            card_id INTEGER,
            winner_id TEXT,
            win_type TEXT,
            loser_id TEXT,
            match_type_id TEXT,
            duration TEXT,
            title_id TEXT,
            title_change INTEGER
    );

CREATE TABLE Promotions (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
            name TEXT UNIQUE
        );

CREATE TABLE Tables (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
            html TEXT UNIQUE,
            url TEXT UNIQUE
        );

CREATE TABLE Wrestlers (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
            name UNIQUE
    );