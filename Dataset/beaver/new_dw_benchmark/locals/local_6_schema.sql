CREATE TABLE "dept_hier_links_std_funds_ctr" (
    "dlc_cd" TEXT DEFAULT NULL,
    "lnk_obj_cd" TEXT DEFAULT NULL,
    "dlc_id" TEXT DEFAULT NULL,
    "hier_tp" TEXT DEFAULT NULL,
    "lnk_obj_id" TEXT DEFAULT NULL,
    "lnk_type_lbl" TEXT DEFAULT NULL
);

CREATE TABLE "dept_hier_links_orgunit_misc" (
    "dlc_cd" TEXT DEFAULT NULL,
    "lnk_obj_cd" TEXT DEFAULT NULL,
    "dlc_id" TEXT DEFAULT NULL,
    "hier_tp" TEXT DEFAULT NULL,
    "lnk_obj_id" TEXT DEFAULT NULL,
    "lnk_type_lbl" TEXT DEFAULT NULL
);

CREATE TABLE "dept_hier_links_by_hier_tp" (
    "dlc_cd" TEXT DEFAULT NULL,
    "lnk_obj_cd" TEXT DEFAULT NULL,
    "hier_tp" TEXT DEFAULT NULL,
    "lnk_type_lbl" TEXT DEFAULT NULL,
    "lnk_type_cd" TEXT DEFAULT NULL
);

CREATE TABLE "tip_det_isbn_alt" (
    "tip_mat_id" TEXT DEFAULT NULL,
    "subj_id" TEXT DEFAULT NULL,
    "isbn_cd" TEXT DEFAULT NULL,
    "rec_cnt" INTEGER DEFAULT NULL,
    "term_cd" TEXT DEFAULT NULL,
    "tip_mat_status_id" TEXT DEFAULT NULL,
    "tip_subj_offer_id" TEXT DEFAULT NULL
);

CREATE TABLE "tip_mat_author_info" (
    "tip_mat_id" TEXT DEFAULT NULL,
    "new_shelf_price_amt" INTEGER DEFAULT NULL,
    "author_name" TEXT DEFAULT NULL,
    "publisher_name" TEXT DEFAULT NULL,
    "rental_new_price_amt" INTEGER DEFAULT NULL,
    "title_txt" TEXT DEFAULT NULL
);

CREATE TABLE "tip_mat_author_edition" (
    "tip_mat_id" TEXT DEFAULT NULL,
    "new_shelf_price_amt" INTEGER DEFAULT NULL,
    "author_name" TEXT DEFAULT NULL,
    "edition_lbl" TEXT DEFAULT NULL,
    "isbn_cd" TEXT DEFAULT NULL,
    "publisher_name" TEXT DEFAULT NULL,
    "title_txt" TEXT DEFAULT NULL
);

CREATE TABLE "tip_mat_info_src" (
    "tip_mat_id" TEXT DEFAULT NULL,
    "new_shelf_price_amt" INTEGER DEFAULT NULL,
    "mat_info_src_cd" TEXT DEFAULT NULL,
    "yr_val" TEXT DEFAULT NULL
);

CREATE TABLE "tip_mat_rent_used_le_5" (
    "tip_mat_id" TEXT DEFAULT NULL,
    "new_shelf_price_amt" INTEGER DEFAULT NULL,
    "rental_new_price_amt" INTEGER DEFAULT NULL,
    "rental_used_price_amt" INTEGER DEFAULT NULL,
    "used_shelf_price_amt" INTEGER DEFAULT NULL
);

CREATE TABLE "tip_mat_rent_used_gt5_le20" (
    "tip_mat_id" TEXT DEFAULT NULL,
    "new_shelf_price_amt" INTEGER DEFAULT NULL,
    "rental_new_price_amt" INTEGER DEFAULT NULL,
    "rental_used_price_amt" INTEGER DEFAULT NULL,
    "used_shelf_price_amt" INTEGER DEFAULT NULL
);

CREATE TABLE "tip_mat_rent_used_gt20_le67" (
    "tip_mat_id" TEXT DEFAULT NULL,
    "new_shelf_price_amt" INTEGER DEFAULT NULL,
    "rental_new_price_amt" INTEGER DEFAULT NULL,
    "rental_used_price_amt" INTEGER DEFAULT NULL,
    "used_shelf_price_amt" INTEGER DEFAULT NULL
);

CREATE TABLE "tip_mat_rent_used_gt67_or_null" (
    "tip_mat_id" TEXT DEFAULT NULL,
    "new_shelf_price_amt" INTEGER DEFAULT NULL,
    "rental_new_price_amt" INTEGER DEFAULT NULL,
    "rental_used_price_amt" INTEGER DEFAULT NULL,
    "used_shelf_price_amt" INTEGER DEFAULT NULL
);

CREATE TABLE "tip_mat_status_ref" (
    "tip_mat_status_id" TEXT DEFAULT NULL,
    "tip_mat_status_cd" TEXT DEFAULT NULL,
    "tip_mat_status_lbl" TEXT DEFAULT NULL,
    "wh_load_dt" TEXT DEFAULT NULL
);