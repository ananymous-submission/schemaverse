CREATE TABLE "orderLinesPriceAtMost4Point86" (
    "lineId" INTEGER,
    "orderId" INTEGER,
    "bookId" INTEGER,
    "linePrice" REAL
);

CREATE TABLE "orderLinesPriceAbove15Point05OrNull" (
    "lineId" INTEGER,
    "orderId" INTEGER,
    "bookId" INTEGER,
    "linePrice" REAL
);

CREATE TABLE "publisherDirectory" (
    "publisherId" INTEGER,
    "publisherName" TEXT
);

CREATE TABLE "booksPages193To299" (
    "bookId" INTEGER,
    "bookTitle" TEXT,
    "isbn13Code" TEXT,
    "languageId" INTEGER,
    "pageCount" INTEGER,
    "publicationDate" DATE,
    "publisherId" INTEGER
);

CREATE TABLE "booksPages300To416" (
    "bookId" INTEGER,
    "bookTitle" TEXT,
    "isbn13Code" TEXT,
    "languageId" INTEGER,
    "pageCount" INTEGER,
    "publicationDate" DATE,
    "publisherId" INTEGER,
    FOREIGN KEY ("publisherId") REFERENCES "publisherDirectory"("publisherId")
);