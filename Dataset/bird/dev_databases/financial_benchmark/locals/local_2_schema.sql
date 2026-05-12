CREATE TABLE "ClassicCard" (
    "CardId" INTEGER DEFAULT 0,
    "DispositionId" INTEGER NOT NULL,
    "CardType" TEXT NOT NULL,
    "IssuedDate" DATE NOT NULL
);

CREATE TABLE "JuniorOrGoldCard" (
    "CardId" INTEGER DEFAULT 0,
    "DispositionId" INTEGER NOT NULL,
    "CardType" TEXT NOT NULL,
    "IssuedDate" DATE NOT NULL
);

CREATE TABLE "CardDisposition" (
    "DispositionId" INTEGER,
    "ClientId" INTEGER NOT NULL,
    "AccountId" INTEGER NOT NULL,
    "DispositionType" TEXT NOT NULL
);

CREATE TABLE "ClientFemaleOrNull" (
    "ClientId" INTEGER,
    "Gender" TEXT NOT NULL,
    "BirthDate" DATE NOT NULL,
    "DistrictId" INTEGER NOT NULL
);