-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct Author from local_1.publicationAuthor
CREATE VIEW "Author" AS
SELECT
    "local_1"."publicationAuthor"."authorId" AS "Id",
    "local_1"."publicationAuthor"."authorFullName" AS "Name",
    "local_1"."publicationAuthor"."authorAffiliation" AS "Affiliation"
FROM "local_1"."publicationAuthor";

-- Reconstruct Conference from local_2.conference_catalog
CREATE VIEW "Conference" AS
SELECT
    "local_2"."conference_catalog"."conference_id" AS "Id",
    "local_2"."conference_catalog"."short_label" AS "ShortName",
    "local_2"."conference_catalog"."official_title" AS "FullName",
    "local_2"."conference_catalog"."website_url" AS "HomePage"
FROM "local_2"."conference_catalog";

-- Reconstruct Journal from local_3.pub_jrn
CREATE VIEW "Journal" AS
SELECT
    "local_3"."pub_jrn"."jrn_id" AS "Id",
    "local_3"."pub_jrn"."jrn_abbr" AS "ShortName",
    "local_3"."pub_jrn"."jrn_title" AS "FullName",
    "local_3"."pub_jrn"."jrn_url" AS "HomePage"
FROM "local_3"."pub_jrn";

-- Reconstruct Paper from row partitions (UNION (overlap))
CREATE VIEW "Paper" AS
SELECT "local_1"."papers1994To2000"."paperRecordId" AS "Id", "local_1"."papers1994To2000"."paperTitle" AS "Title", "local_1"."papers1994To2000"."publicationYear" AS "Year", "local_1"."papers1994To2000"."conferenceRefId" AS "ConferenceId", "local_1"."papers1994To2000"."journalRefId" AS "JournalId", "local_1"."papers1994To2000"."primaryKeyword" AS "Keyword" FROM "local_1"."papers1994To2000"
UNION
SELECT "local_1"."papers2001To2006"."paperRecordId" AS "Id", "local_1"."papers2001To2006"."paperTitle" AS "Title", "local_1"."papers2001To2006"."publicationYear" AS "Year", "local_1"."papers2001To2006"."conferenceRefId" AS "ConferenceId", "local_1"."papers2001To2006"."journalRefId" AS "JournalId", "local_1"."papers2001To2006"."primaryKeyword" AS "Keyword" FROM "local_1"."papers2001To2006"
UNION
SELECT "local_2"."papers_up_to_1993"."paper_id" AS "Id", "local_2"."papers_up_to_1993"."paper_title" AS "Title", "local_2"."papers_up_to_1993"."publication_year" AS "Year", "local_2"."papers_up_to_1993"."conference_id" AS "ConferenceId", "local_2"."papers_up_to_1993"."journal_id" AS "JournalId", "local_2"."papers_up_to_1993"."keyword_term" AS "Keyword" FROM "local_2"."papers_up_to_1993"
UNION
SELECT "local_2"."papers_after_2006_or_null"."paper_id" AS "Id", "local_2"."papers_after_2006_or_null"."paper_title" AS "Title", "local_2"."papers_after_2006_or_null"."publication_year" AS "Year", "local_2"."papers_after_2006_or_null"."conference_id" AS "ConferenceId", "local_2"."papers_after_2006_or_null"."journal_id" AS "JournalId", "local_2"."papers_after_2006_or_null"."keyword_term" AS "Keyword" FROM "local_2"."papers_after_2006_or_null";

-- Reconstruct PaperAuthor from local_1.paperAuthorship
CREATE VIEW "PaperAuthor" AS
SELECT
    "local_1"."paperAuthorship"."paperRecordId" AS "PaperId",
    "local_1"."paperAuthorship"."authorRefId" AS "AuthorId",
    "local_1"."paperAuthorship"."snapshotAuthorName" AS "Name",
    "local_1"."paperAuthorship"."snapshotAuthorAffiliation" AS "Affiliation"
FROM "local_1"."paperAuthorship";
