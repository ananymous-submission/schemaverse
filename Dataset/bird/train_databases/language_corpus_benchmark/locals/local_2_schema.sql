CREATE TABLE "pagesFiveOrFewerWords" (
    "pageId" INTEGER,
    "langId" INTEGER,
    "pageNumber" INTEGER DEFAULT NULL,
    "revisionNumber" INTEGER DEFAULT NULL,
    "pageTitle" TEXT,
    "wordCount" INTEGER DEFAULT 0
);

CREATE TABLE "pagesOver144OrNullWords" (
    "pageId" INTEGER,
    "langId" INTEGER,
    "pageNumber" INTEGER DEFAULT NULL,
    "revisionNumber" INTEGER DEFAULT NULL,
    "pageTitle" TEXT,
    "wordCount" INTEGER DEFAULT 0
);

CREATE TABLE "pagesWordOccurrencesAtMostOne" (
    "pageId" INTEGER,
    "wordId" INTEGER,
    "occurrenceCount" INTEGER DEFAULT 0,
    FOREIGN KEY ("pageId") REFERENCES "pagesOver144OrNullWords"("pageId")
);

CREATE TABLE "pagesWordOccurrencesGreaterThanTwoOrNull" (
    "pageId" INTEGER,
    "wordId" INTEGER,
    "occurrenceCount" INTEGER DEFAULT 0,
    FOREIGN KEY ("pageId") REFERENCES "pagesFiveOrFewerWords"("pageId")
);