-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/citeseer/citeseer.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "doc_cite" (
    "doc_ref_id" TEXT,
    "cited_tok_id" TEXT,
    FOREIGN KEY ("doc_ref_id") REFERENCES "paper_agents"("doc_ref_id"),
    FOREIGN KEY ("doc_ref_id") REFERENCES "paper_ml"("doc_ref_id")
);

CREATE TABLE "paper_ir" (
    "doc_ref_id" TEXT,
    "cls_lbl" TEXT NOT NULL
);

CREATE TABLE "paper_agents" (
    "doc_ref_id" TEXT,
    "cls_lbl" TEXT NOT NULL
);

CREATE TABLE "paper_ml" (
    "doc_ref_id" TEXT,
    "cls_lbl" TEXT NOT NULL
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "PaperCitation" (
    "ReferencedPaperId" TEXT,
    "ReferencingPaperId" TEXT
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "publications_labeled_db" (
    "publication_id" TEXT,
    "topic_label" TEXT NOT NULL
);

CREATE TABLE "publications_labeled_hci_ai_or_null" (
    "publication_id" TEXT,
    "topic_label" TEXT NOT NULL
);

