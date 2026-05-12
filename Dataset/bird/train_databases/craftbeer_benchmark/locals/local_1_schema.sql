CREATE TABLE "beersAbvAtMost0Point05" (
    "beerId" INTEGER,
    "breweryId" INTEGER NOT NULL,
    "alcoholByVolume" REAL,
    "bitternessIbu" REAL,
    "beerName" TEXT NOT NULL,
    "beerStyle" TEXT,
    "volumeOunces" REAL NOT NULL
);

CREATE TABLE "beersAbvGreaterThan0Point067OrNull" (
    "beerId" INTEGER,
    "breweryId" INTEGER NOT NULL,
    "alcoholByVolume" REAL,
    "bitternessIbu" REAL,
    "beerName" TEXT NOT NULL,
    "beerStyle" TEXT,
    "volumeOunces" REAL NOT NULL
);