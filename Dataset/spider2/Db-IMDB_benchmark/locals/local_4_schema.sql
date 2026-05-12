CREATE TABLE "movieDirectorship" (
    "creditOrder" INTEGER,
    "movieId" TEXT,
    "personId" TEXT,
    "directorshipId" INTEGER
);

CREATE TABLE "malePerson" (
    "recordIndex" INTEGER,
    "personId" TEXT,
    "fullName" TEXT,
    "gender" TEXT
);

CREATE TABLE "femaleOrNullPerson" (
    "recordIndex" INTEGER,
    "personId" TEXT,
    "fullName" TEXT,
    "gender" TEXT
);