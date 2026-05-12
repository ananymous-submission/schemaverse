CREATE TABLE "nation" (
    "nationId" INTEGER,
    "isoCode" TEXT DEFAULT NULL,
    "commonName" TEXT DEFAULT NULL
);

CREATE TABLE "orgUnit" (
    "unitId" INTEGER,
    "unitName" TEXT DEFAULT NULL
);

CREATE TABLE "genderCategory" (
    "categoryId" INTEGER,
    "categoryLabel" TEXT DEFAULT NULL
);

CREATE TABLE "contentGenre" (
    "genreKey" INTEGER,
    "genreLabel" TEXT DEFAULT NULL
);

CREATE TABLE "searchTerm" (
    "termId" INTEGER,
    "termText" TEXT DEFAULT NULL
);

CREATE TABLE "locale" (
    "localeId" INTEGER,
    "isoLanguageCode" TEXT DEFAULT NULL,
    "localName" TEXT DEFAULT NULL
);