CREATE TABLE "MountainLocation" (
    "MountainName" TEXT DEFAULT '',
    "CountryName" TEXT DEFAULT '',
    "ProvinceName" TEXT DEFAULT ''
);

CREATE TABLE "SeaLocation" (
    "SeaName" TEXT DEFAULT '',
    "CountryName" TEXT DEFAULT '',
    "ProvinceName" TEXT DEFAULT ''
);

CREATE TABLE "SeaConvergence" (
    "IncomingSea" TEXT DEFAULT '',
    "ReceivingSea" TEXT DEFAULT ''
);

CREATE TABLE "SeaDetails" (
    "SeaName" TEXT DEFAULT '',
    "MaximumDepth" REAL
);