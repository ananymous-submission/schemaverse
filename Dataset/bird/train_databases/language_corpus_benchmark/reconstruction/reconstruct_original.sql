-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct biwords from row partitions (UNION (overlap))
CREATE VIEW "biwords" AS
SELECT "local_1"."BiwordFrequencyGreaterThanOneUpToTwo"."LanguageId" AS "lid", "local_1"."BiwordFrequencyGreaterThanOneUpToTwo"."FirstWordId" AS "w1st", "local_1"."BiwordFrequencyGreaterThanOneUpToTwo"."SecondWordId" AS "w2nd", "local_1"."BiwordFrequencyGreaterThanOneUpToTwo"."OccurrenceCount" AS "occurrences" FROM "local_1"."BiwordFrequencyGreaterThanOneUpToTwo"
UNION
SELECT "local_3"."bigrams_max_one_occurrence"."language_id" AS "lid", "local_3"."bigrams_max_one_occurrence"."w1st", "local_3"."bigrams_max_one_occurrence"."word_id" AS "w2nd", "local_3"."bigrams_max_one_occurrence"."occurrences_count" AS "occurrences" FROM "local_3"."bigrams_max_one_occurrence"
UNION
SELECT "local_3"."bigrams_more_than_two_or_null_occurrence"."language_id" AS "lid", "local_3"."bigrams_more_than_two_or_null_occurrence"."w1st", "local_3"."bigrams_more_than_two_or_null_occurrence"."word_id" AS "w2nd", "local_3"."bigrams_more_than_two_or_null_occurrence"."occurrences_count" AS "occurrences" FROM "local_3"."bigrams_more_than_two_or_null_occurrence";

-- Reconstruct langs from local_1.LanguageSummary
CREATE VIEW "langs" AS
SELECT
    "local_1"."LanguageSummary"."LanguageId" AS "lid",
    "local_1"."LanguageSummary"."LanguageName" AS "lang",
    "local_1"."LanguageSummary"."LocaleCode" AS "locale",
    "local_1"."LanguageSummary"."PageCount" AS "pages",
    "local_1"."LanguageSummary"."WordCount" AS "words"
FROM "local_1"."LanguageSummary";

-- Reconstruct langs_words from row partitions (UNION (overlap))
CREATE VIEW "langs_words" AS
SELECT "local_1"."LanguageWordOccurrencesAtMostOne"."LanguageId" AS "lid", "local_1"."LanguageWordOccurrencesAtMostOne"."WordId" AS "wid", "local_1"."LanguageWordOccurrencesAtMostOne"."OccurrenceCount" AS "occurrences" FROM "local_1"."LanguageWordOccurrencesAtMostOne"
UNION
SELECT "local_1"."LanguageWordOccurrencesGreaterThanFiveOrNull"."LanguageId" AS "lid", "local_1"."LanguageWordOccurrencesGreaterThanFiveOrNull"."WordId" AS "wid", "local_1"."LanguageWordOccurrencesGreaterThanFiveOrNull"."OccurrenceCount" AS "occurrences" FROM "local_1"."LanguageWordOccurrencesGreaterThanFiveOrNull"
UNION
SELECT "local_3"."language_word_occ_gt1_up_to_2"."language_id" AS "lid", "local_3"."language_word_occ_gt1_up_to_2"."word_id" AS "wid", "local_3"."language_word_occ_gt1_up_to_2"."occurrences_count" AS "occurrences" FROM "local_3"."language_word_occ_gt1_up_to_2"
UNION
SELECT "local_3"."language_word_occ_gt2_up_to_5"."language_id" AS "lid", "local_3"."language_word_occ_gt2_up_to_5"."word_id" AS "wid", "local_3"."language_word_occ_gt2_up_to_5"."occurrences_count" AS "occurrences" FROM "local_3"."language_word_occ_gt2_up_to_5";

-- Reconstruct pages from row partitions (UNION (overlap))
CREATE VIEW "pages" AS
SELECT "local_2"."pagesFiveOrFewerWords"."pageId" AS "pid", "local_2"."pagesFiveOrFewerWords"."langId" AS "lid", "local_2"."pagesFiveOrFewerWords"."pageNumber" AS "page", "local_2"."pagesFiveOrFewerWords"."revisionNumber" AS "revision", "local_2"."pagesFiveOrFewerWords"."pageTitle" AS "title", "local_2"."pagesFiveOrFewerWords"."wordCount" AS "words" FROM "local_2"."pagesFiveOrFewerWords"
UNION
SELECT "local_2"."pagesOver144OrNullWords"."pageId" AS "pid", "local_2"."pagesOver144OrNullWords"."langId" AS "lid", "local_2"."pagesOver144OrNullWords"."pageNumber" AS "page", "local_2"."pagesOver144OrNullWords"."revisionNumber" AS "revision", "local_2"."pagesOver144OrNullWords"."pageTitle" AS "title", "local_2"."pagesOver144OrNullWords"."wordCount" AS "words" FROM "local_2"."pagesOver144OrNullWords"
UNION
SELECT "local_3"."pages_wordcount_gt5_up_to_49"."page_id" AS "pid", "local_3"."pages_wordcount_gt5_up_to_49"."language_id" AS "lid", "local_3"."pages_wordcount_gt5_up_to_49"."page_number" AS "page", "local_3"."pages_wordcount_gt5_up_to_49"."revision_id" AS "revision", "local_3"."pages_wordcount_gt5_up_to_49"."page_title" AS "title", "local_3"."pages_wordcount_gt5_up_to_49"."word_count" AS "words" FROM "local_3"."pages_wordcount_gt5_up_to_49"
UNION
SELECT "local_3"."pages_wordcount_gt49_up_to_144"."page_id" AS "pid", "local_3"."pages_wordcount_gt49_up_to_144"."language_id" AS "lid", "local_3"."pages_wordcount_gt49_up_to_144"."page_number" AS "page", "local_3"."pages_wordcount_gt49_up_to_144"."revision_id" AS "revision", "local_3"."pages_wordcount_gt49_up_to_144"."page_title" AS "title", "local_3"."pages_wordcount_gt49_up_to_144"."word_count" AS "words" FROM "local_3"."pages_wordcount_gt49_up_to_144";

-- Reconstruct pages_words from row partitions (UNION (overlap))
CREATE VIEW "pages_words" AS
SELECT "local_2"."pagesWordOccurrencesAtMostOne"."pageId" AS "pid", "local_2"."pagesWordOccurrencesAtMostOne"."wordId" AS "wid", "local_2"."pagesWordOccurrencesAtMostOne"."occurrenceCount" AS "occurrences" FROM "local_2"."pagesWordOccurrencesAtMostOne"
UNION
SELECT "local_2"."pagesWordOccurrencesGreaterThanTwoOrNull"."pageId" AS "pid", "local_2"."pagesWordOccurrencesGreaterThanTwoOrNull"."wordId" AS "wid", "local_2"."pagesWordOccurrencesGreaterThanTwoOrNull"."occurrenceCount" AS "occurrences" FROM "local_2"."pagesWordOccurrencesGreaterThanTwoOrNull"
UNION
SELECT "local_3"."page_word_occ_gt1_up_to_2"."page_id" AS "pid", "local_3"."page_word_occ_gt1_up_to_2"."word_id" AS "wid", "local_3"."page_word_occ_gt1_up_to_2"."occurrences_count" AS "occurrences" FROM "local_3"."page_word_occ_gt1_up_to_2";

-- Reconstruct words from local_3.vocabulary_terms
CREATE VIEW "words" AS
SELECT
    "local_3"."vocabulary_terms"."word_id" AS "wid",
    "local_3"."vocabulary_terms"."word_text" AS "word",
    "local_3"."vocabulary_terms"."occurrences_count" AS "occurrences"
FROM "local_3"."vocabulary_terms";
