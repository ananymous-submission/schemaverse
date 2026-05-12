CREATE TABLE "biz_attr_false" (
    "attr_id" INTEGER,
    "biz_id" INTEGER,
    "attr_val" TEXT
);

CREATE TABLE "biz_attr_mixed" (
    "attr_id" INTEGER,
    "biz_id" INTEGER,
    "attr_val" TEXT
);

CREATE TABLE "compl_type_ref" (
    "compl_id" INTEGER,
    "compl_label" TEXT
);

CREATE TABLE "user_compl_low" (
    "compl_id" INTEGER,
    "usr_id" INTEGER,
    "compl_level" TEXT
);