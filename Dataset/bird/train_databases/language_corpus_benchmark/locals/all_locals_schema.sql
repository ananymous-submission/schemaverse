-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/language_corpus/language_corpus.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "bigrams_max_one_occurrence" (
    "language_id" INTEGER,
    "w1st" INTEGER,
    "word_id" INTEGER,
    "occurrences_count" INTEGER DEFAULT 0
);

CREATE TABLE "bigrams_more_than_two_or_null_occurrence" (
    "language_id" INTEGER,
    "w1st" INTEGER,
    "word_id" INTEGER,
    "occurrences_count" INTEGER DEFAULT 0
);

CREATE TABLE "vocabulary_terms" (
    "word_id" INTEGER,
    "word_text" TEXT,
    "occurrences_count" INTEGER DEFAULT 0
);

CREATE TABLE "page_word_occ_gt1_up_to_2" (
    "page_id" INTEGER,
    "word_id" INTEGER,
    "occurrences_count" INTEGER DEFAULT 0,
    FOREIGN KEY ("page_id") REFERENCES "pages_wordcount_gt5_up_to_49"("page_id"),
    FOREIGN KEY ("page_id") REFERENCES "pages_wordcount_gt49_up_to_144"("page_id")
);

CREATE TABLE "pages_wordcount_gt5_up_to_49" (
    "page_id" INTEGER,
    "language_id" INTEGER,
    "page_number" INTEGER DEFAULT NULL,
    "revision_id" INTEGER DEFAULT NULL,
    "page_title" TEXT,
    "word_count" INTEGER DEFAULT 0
);

CREATE TABLE "pages_wordcount_gt49_up_to_144" (
    "page_id" INTEGER,
    "language_id" INTEGER,
    "page_number" INTEGER DEFAULT NULL,
    "revision_id" INTEGER DEFAULT NULL,
    "page_title" TEXT,
    "word_count" INTEGER DEFAULT 0
);

CREATE TABLE "language_word_occ_gt1_up_to_2" (
    "language_id" INTEGER,
    "word_id" INTEGER,
    "occurrences_count" INTEGER
);

CREATE TABLE "language_word_occ_gt2_up_to_5" (
    "language_id" INTEGER,
    "word_id" INTEGER,
    "occurrences_count" INTEGER,
    FOREIGN KEY ("word_id") REFERENCES "vocabulary_terms"("word_id")
);

