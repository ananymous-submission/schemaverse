CREATE TABLE "conference_catalog" (
    "conference_id" INTEGER,
    "short_label" TEXT,
    "official_title" TEXT,
    "website_url" TEXT
);

CREATE TABLE "papers_up_to_1993" (
    "paper_id" INTEGER,
    "paper_title" TEXT,
    "publication_year" INTEGER,
    "conference_id" INTEGER,
    "journal_id" INTEGER,
    "keyword_term" TEXT
);

CREATE TABLE "papers_after_2006_or_null" (
    "paper_id" INTEGER,
    "paper_title" TEXT,
    "publication_year" INTEGER,
    "conference_id" INTEGER,
    "journal_id" INTEGER,
    "keyword_term" TEXT,
    FOREIGN KEY ("conference_id") REFERENCES "conference_catalog"("conference_id")
);