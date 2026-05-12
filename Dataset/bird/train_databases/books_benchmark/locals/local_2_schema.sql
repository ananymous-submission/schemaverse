CREATE TABLE "addressStatusLookup" (
    "statusKey" INTEGER,
    "statusLabel" TEXT
);

CREATE TABLE "customerAddressStatusUpToOne" (
    "customerIdRef" INTEGER,
    "addressIdRef" INTEGER,
    "statusKeyRef" INTEGER
);