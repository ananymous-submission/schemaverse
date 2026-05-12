CREATE TABLE "EstuaryJurisdiction" (
    "RiverName" TEXT DEFAULT '',
    "CountryName" TEXT DEFAULT '',
    "ProvinceName" TEXT DEFAULT ''
);

CREATE TABLE "RiverJurisdiction" (
    "RiverName" TEXT DEFAULT '',
    "CountryName" TEXT DEFAULT '',
    "ProvinceName" TEXT DEFAULT ''
);

CREATE TABLE "SourceJurisdiction" (
    "RiverName" TEXT DEFAULT '',
    "CountryName" TEXT DEFAULT '',
    "ProvinceName" TEXT DEFAULT ''
);

CREATE TABLE "RiverCoordinates" (
    "RiverName" TEXT DEFAULT '',
    "EstuaryLatitudeDeg" REAL,
    "EstuaryLongitudeDeg" REAL,
    "SourceLatitudeDeg" REAL,
    "SourceLongitudeDeg" REAL
);

CREATE TABLE "RiverProfile" (
    "RiverName" TEXT DEFAULT '',
    "RiverLengthKilometers" REAL,
    "MountainRanges" TEXT,
    "TerminusSea" TEXT,
    "SourceElevationMeters" REAL,
    "SourceLatitudeDeg" REAL,
    "SourceLongitudeDeg" REAL
);