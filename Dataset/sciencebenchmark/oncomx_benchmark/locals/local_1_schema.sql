CREATE TABLE "anat_ent" (
    "anat_id" TEXT,
    "anat_name" TEXT,
    "anat_desc" TEXT
);

CREATE TABLE "bio_fda_drug_map" (
    "bio_fda_id" TEXT,
    "bio_drug_id" TEXT
);

CREATE TABLE "dm_tissue_map" (
    "uber_anat_id" TEXT,
    "dm_id" INTEGER,
    FOREIGN KEY ("dm_id") REFERENCES "dm_aa_pos_le144"("dm_id")
);

CREATE TABLE "dm_aa_pos_le144" (
    "dm_id" INTEGER,
    "aa_pos_up" INTEGER,
    "aa_alt" TEXT,
    "pep_pos" INTEGER,
    "aa_ref" TEXT
);

CREATE TABLE "dm_aa_pos_gt144_le310" (
    "dm_id" INTEGER,
    "aa_pos_up" INTEGER,
    "aa_alt" TEXT,
    "pep_pos" INTEGER,
    "aa_ref" TEXT
);

CREATE TABLE "dm_aa_pos_gt310_le608" (
    "dm_id" INTEGER,
    "aa_pos_up" INTEGER,
    "aa_alt" TEXT,
    "pep_pos" INTEGER,
    "aa_ref" TEXT
);

CREATE TABLE "dm_aa_pos_gt608_or_null" (
    "dm_id" INTEGER,
    "aa_pos_up" INTEGER,
    "aa_alt" TEXT,
    "pep_pos" INTEGER,
    "aa_ref" TEXT
);

CREATE TABLE "norm_expr_rank_gt8660_le17900" (
    "ensg_id" TEXT,
    "uber_anat_id" TEXT,
    "uber_dev_id" TEXT,
    "expr_lvl_anat_rel" TEXT,
    "expr_lvl_gene_rel" TEXT,
    "expr_rank" NUMERIC,
    "expr_score" NUMERIC
);

CREATE TABLE "norm_expr_rank_gt17900_le28200" (
    "ensg_id" TEXT,
    "uber_anat_id" TEXT,
    "uber_dev_id" TEXT,
    "expr_lvl_anat_rel" TEXT,
    "expr_lvl_gene_rel" TEXT,
    "expr_rank" NUMERIC,
    "expr_score" NUMERIC
);

CREATE TABLE "norm_expr_rank_gt28200_or_null" (
    "ensg_id" TEXT,
    "uber_anat_id" TEXT,
    "uber_dev_id" TEXT,
    "expr_lvl_anat_rel" TEXT,
    "expr_lvl_gene_rel" TEXT,
    "expr_rank" NUMERIC,
    "expr_score" NUMERIC,
    FOREIGN KEY ("uber_anat_id") REFERENCES "anat_ent"("anat_id")
);

CREATE TABLE "norm_expr_call_qual" (
    "ensg_id" TEXT,
    "uber_anat_id" TEXT,
    "uber_dev_id" TEXT,
    "call_qual" TEXT,
    FOREIGN KEY ("uber_anat_id") REFERENCES "anat_ent"("anat_id")
);