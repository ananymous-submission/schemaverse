-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/authors/authors.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "publicationAuthor" (
    "authorId" INTEGER,
    "authorFullName" TEXT,
    "authorAffiliation" TEXT
);

CREATE TABLE "paperAuthorship" (
    "paperRecordId" INTEGER,
    "authorRefId" INTEGER,
    "snapshotAuthorName" TEXT,
    "snapshotAuthorAffiliation" TEXT,
    FOREIGN KEY ("authorRefId") REFERENCES "publicationAuthor"("authorId"),
    FOREIGN KEY ("paperRecordId") REFERENCES "papers1994To2000"("paperRecordId"),
    FOREIGN KEY ("paperRecordId") REFERENCES "papers2001To2006"("paperRecordId")
);

CREATE TABLE "papers1994To2000" (
    "paperRecordId" INTEGER,
    "paperTitle" TEXT,
    "publicationYear" INTEGER,
    "conferenceRefId" INTEGER,
    "journalRefId" INTEGER,
    "primaryKeyword" TEXT
);

CREATE TABLE "papers2001To2006" (
    "paperRecordId" INTEGER,
    "paperTitle" TEXT,
    "publicationYear" INTEGER,
    "conferenceRefId" INTEGER,
    "journalRefId" INTEGER,
    "primaryKeyword" TEXT
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "pub_jrn" (
    "jrn_id" INTEGER,
    "jrn_abbr" TEXT,
    "jrn_title" TEXT,
    "jrn_url" TEXT
);

