CREATE TABLE "MovieCountryRelation" (
    "RowIndex" INTEGER,
    "MovieIdentifier" TEXT,
    "CountryIdentifier" REAL,
    "RelationId" INTEGER
);

CREATE TABLE "MovieProducerRelation" (
    "RowIndex" INTEGER,
    "MovieIdentifier" TEXT,
    "ProducerIdentifier" TEXT,
    "RelationId" INTEGER
);

CREATE TABLE "MovieRatingAtMost5Point1" (
    "RowIndex" INTEGER,
    "MovieIdentifier" TEXT,
    "MovieTitle" TEXT,
    "ReleaseYear" TEXT,
    "RatingScore" REAL,
    "VoteCount" INTEGER
);

CREATE TABLE "MovieRatingGreaterThan5Point1UpTo6Point2" (
    "RowIndex" INTEGER,
    "MovieIdentifier" TEXT,
    "MovieTitle" TEXT,
    "ReleaseYear" TEXT,
    "RatingScore" REAL,
    "VoteCount" INTEGER
);

CREATE TABLE "MovieRatingGreaterThan6Point2UpTo7Point1" (
    "RowIndex" INTEGER,
    "MovieIdentifier" TEXT,
    "MovieTitle" TEXT,
    "ReleaseYear" TEXT,
    "RatingScore" REAL,
    "VoteCount" INTEGER
);

CREATE TABLE "MovieRatingGreaterThan7Point1OrMissing" (
    "RowIndex" INTEGER,
    "MovieIdentifier" TEXT,
    "MovieTitle" TEXT,
    "ReleaseYear" TEXT,
    "RatingScore" REAL,
    "VoteCount" INTEGER
);