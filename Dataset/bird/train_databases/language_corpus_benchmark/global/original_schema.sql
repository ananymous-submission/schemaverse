CREATE TABLE biwords(lid    INTEGER REFERENCES langs(lid) ON UPDATE CASCADE ON DELETE CASCADE,
                                w1st   INTEGER REFERENCES words(wid) ON UPDATE CASCADE ON DELETE CASCADE,
                                w2nd   INTEGER REFERENCES words(wid) ON UPDATE CASCADE ON DELETE CASCADE,
                                occurrences INTEGER DEFAULT 0, -- times this pair appears in this language/page
                                PRIMARY KEY(lid,w1st,w2nd))
                                WITHOUT ROWID;

CREATE TABLE langs(lid    INTEGER PRIMARY KEY AUTOINCREMENT,
                            lang   TEXT UNIQUE,
                            locale TEXT UNIQUE,
                            pages  INTEGER DEFAULT 0,  -- total pages in this language
                            words  INTEGER DEFAULT 0);

CREATE TABLE langs_words(lid INTEGER REFERENCES langs(lid) ON UPDATE CASCADE ON DELETE CASCADE,
                                        wid INTEGER REFERENCES words(wid) ON UPDATE CASCADE ON DELETE CASCADE,
                                        occurrences INTEGER, -- repetitions of this word in this language
                                        PRIMARY KEY(lid,wid))
                                        WITHOUT ROWID;

CREATE TABLE pages(pid INTEGER PRIMARY KEY AUTOINCREMENT,
                            lid INTEGER REFERENCES langs(lid) ON UPDATE CASCADE ON DELETE CASCADE,
                            page INTEGER DEFAULT NULL, -- wikipedia page id
                            revision INTEGER DEFAULT NULL, -- wikipedia revision page id
                            title TEXT,
                            words INTEGER DEFAULT 0, -- number of different words in this page
                            UNIQUE(lid,page,title));

CREATE TABLE pages_words(pid INTEGER REFERENCES pages(pid) ON UPDATE CASCADE ON DELETE CASCADE,
                                        wid INTEGER REFERENCES words(wid) ON UPDATE CASCADE ON DELETE CASCADE,
                                        occurrences INTEGER DEFAULT 0, -- times this word appears into this page
                                        PRIMARY KEY(pid,wid))
                                        WITHOUT ROWID;

CREATE TABLE words(wid INTEGER PRIMARY KEY AUTOINCREMENT,
                            word        TEXT UNIQUE,
                            occurrences INTEGER DEFAULT 0);