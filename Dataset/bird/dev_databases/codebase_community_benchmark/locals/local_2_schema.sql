CREATE TABLE "post_link_rel" (
    "link_id" INTEGER,
    "created_at" DATETIME,
    "src_post_ref" INTEGER,
    "rel_post_ref" INTEGER,
    "link_type_id" INTEGER
);

CREATE TABLE "tag_bin_ct_le7" (
    "tag_id" INTEGER,
    "tag_lbl" TEXT,
    "use_cnt" INTEGER,
    "excerpt_post_ref" INTEGER,
    "wiki_post_ref" INTEGER
);

CREATE TABLE "tag_bin_ct_8_29" (
    "tag_id" INTEGER,
    "tag_lbl" TEXT,
    "use_cnt" INTEGER,
    "excerpt_post_ref" INTEGER,
    "wiki_post_ref" INTEGER
);

CREATE TABLE "tag_bin_ct_30_87" (
    "tag_id" INTEGER,
    "tag_lbl" TEXT,
    "use_cnt" INTEGER,
    "excerpt_post_ref" INTEGER,
    "wiki_post_ref" INTEGER
);

CREATE TABLE "tag_bin_ct_gt87_or_null" (
    "tag_id" INTEGER,
    "tag_lbl" TEXT,
    "use_cnt" INTEGER,
    "excerpt_post_ref" INTEGER,
    "wiki_post_ref" INTEGER
);