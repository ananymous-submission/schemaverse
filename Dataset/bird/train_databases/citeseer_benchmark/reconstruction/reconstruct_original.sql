-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct cites from local_2.PaperCitation
CREATE VIEW "cites" AS
SELECT
    "local_2"."PaperCitation"."ReferencedPaperId" AS "cited_paper_id",
    "local_2"."PaperCitation"."ReferencingPaperId" AS "citing_paper_id"
FROM "local_2"."PaperCitation";

-- Reconstruct content from local_1.doc_cite
CREATE VIEW "content" AS
SELECT
    "local_1"."doc_cite"."doc_ref_id" AS "paper_id",
    "local_1"."doc_cite"."cited_tok_id" AS "word_cited_id"
FROM "local_1"."doc_cite";

-- Reconstruct paper from row partitions (UNION (overlap))
CREATE VIEW "paper" AS
SELECT "local_1"."paper_ir"."doc_ref_id" AS "paper_id", "local_1"."paper_ir"."cls_lbl" AS "class_label" FROM "local_1"."paper_ir"
UNION
SELECT "local_1"."paper_agents"."doc_ref_id" AS "paper_id", "local_1"."paper_agents"."cls_lbl" AS "class_label" FROM "local_1"."paper_agents"
UNION
SELECT "local_1"."paper_ml"."doc_ref_id" AS "paper_id", "local_1"."paper_ml"."cls_lbl" AS "class_label" FROM "local_1"."paper_ml"
UNION
SELECT "local_3"."publications_labeled_db"."publication_id" AS "paper_id", "local_3"."publications_labeled_db"."topic_label" AS "class_label" FROM "local_3"."publications_labeled_db"
UNION
SELECT "local_3"."publications_labeled_hci_ai_or_null"."publication_id" AS "paper_id", "local_3"."publications_labeled_hci_ai_or_null"."topic_label" AS "class_label" FROM "local_3"."publications_labeled_hci_ai_or_null";
