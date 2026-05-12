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