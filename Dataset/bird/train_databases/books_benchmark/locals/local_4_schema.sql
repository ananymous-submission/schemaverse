CREATE TABLE "BooksMax192Pages" (
    "BookKey" INTEGER,
    "BookTitle" TEXT,
    "Isbn13Code" TEXT,
    "LanguageKey" INTEGER,
    "PageCount" INTEGER,
    "ReleaseDate" DATE,
    "PublisherKey" INTEGER,
    FOREIGN KEY ("LanguageKey") REFERENCES "LanguageCatalog"("LanguageKey")
);

CREATE TABLE "BooksOver416OrNullPages" (
    "BookKey" INTEGER,
    "BookTitle" TEXT,
    "Isbn13Code" TEXT,
    "LanguageKey" INTEGER,
    "PageCount" INTEGER,
    "ReleaseDate" DATE,
    "PublisherKey" INTEGER,
    FOREIGN KEY ("LanguageKey") REFERENCES "LanguageCatalog"("LanguageKey")
);

CREATE TABLE "LanguageCatalog" (
    "LanguageKey" INTEGER,
    "LanguageIsoCode" TEXT,
    "LanguageDisplayName" TEXT
);

CREATE TABLE "OrderLinesPriceRange4Point86To9Point95" (
    "LineKey" INTEGER,
    "OrderKey" INTEGER,
    "BookKey" INTEGER,
    "UnitPrice" REAL
);

CREATE TABLE "OrderLinesPriceRange9Point95To15Point05" (
    "LineKey" INTEGER,
    "OrderKey" INTEGER,
    "BookKey" INTEGER,
    "UnitPrice" REAL
);