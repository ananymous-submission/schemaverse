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