CREATE TABLE "attr_cat" (
    "attr_cat_id" INTEGER DEFAULT 0,
    "attr_lbl" TEXT NOT NULL
);

CREATE TABLE "img_obj_attr_map" (
    "img_ref_id" INTEGER DEFAULT 0,
    "attr_cat_id" INTEGER DEFAULT 0,
    "obj_samp_id" INTEGER DEFAULT 0
);