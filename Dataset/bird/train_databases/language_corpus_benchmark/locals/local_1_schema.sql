CREATE TABLE "LanguageSummary" (
    "LanguageId" INTEGER,
    "LanguageName" TEXT,
    "LocaleCode" TEXT,
    "PageCount" INTEGER DEFAULT 0,
    "WordCount" INTEGER DEFAULT 0
);

CREATE TABLE "LanguageWordOccurrencesAtMostOne" (
    "LanguageId" INTEGER,
    "WordId" INTEGER,
    "OccurrenceCount" INTEGER,
    FOREIGN KEY ("LanguageId") REFERENCES "LanguageSummary"("LanguageId")
);

CREATE TABLE "LanguageWordOccurrencesGreaterThanFiveOrNull" (
    "LanguageId" INTEGER,
    "WordId" INTEGER,
    "OccurrenceCount" INTEGER,
    FOREIGN KEY ("LanguageId") REFERENCES "LanguageSummary"("LanguageId")
);

CREATE TABLE "BiwordFrequencyGreaterThanOneUpToTwo" (
    "LanguageId" INTEGER,
    "FirstWordId" INTEGER,
    "SecondWordId" INTEGER,
    "OccurrenceCount" INTEGER DEFAULT 0
);