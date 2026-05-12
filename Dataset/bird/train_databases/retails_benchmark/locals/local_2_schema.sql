CREATE TABLE "li_commit_after_19970714" (
    "li_ord_id" INTEGER,
    "li_line_no" INTEGER,
    "li_commit_dt" DATE,
    "li_rcpt_dt" DATE,
    "li_ship_dt" DATE,
    FOREIGN KEY ("li_ord_id") REFERENCES "ord_dt_gt19930824_to19950416"("ord_id")
);

CREATE TABLE "li_core_records" (
    "li_ord_id" INTEGER,
    "li_line_no" INTEGER,
    "li_note" TEXT,
    "li_status" TEXT,
    "li_part_id" INTEGER NOT NULL,
    "li_qty" INTEGER NOT NULL,
    "li_ret_flag" TEXT,
    "li_ship_instr" TEXT,
    "li_ship_mode" TEXT,
    "li_supp_id" INTEGER NOT NULL,
    FOREIGN KEY ("li_part_id") REFERENCES "partsupp_avail_2509_5009"("ps_part_id"),
    FOREIGN KEY ("li_part_id") REFERENCES "partsupp_avail_5010_7498"("ps_part_id")
);

CREATE TABLE "part_brands_15_22_23_32_41" (
    "part_id" INTEGER,
    "part_brand" TEXT,
    "part_note" TEXT,
    "part_pack" TEXT,
    "part_mfgr" TEXT,
    "part_name" TEXT,
    "part_price" REAL,
    "part_size" INTEGER
);

CREATE TABLE "part_misc_96461" (
    "part_id" INTEGER,
    "part_note" TEXT,
    "part_pack" TEXT,
    "part_price" REAL,
    "part_size" INTEGER,
    "part_cat" TEXT
);

CREATE TABLE "partsupp_avail_2509_5009" (
    "ps_part_id" INTEGER,
    "ps_supp_id" INTEGER,
    "ps_cost" REAL NOT NULL,
    "ps_avail_qty" INTEGER,
    "ps_note" TEXT,
    FOREIGN KEY ("ps_part_id") REFERENCES "part_brands_15_22_23_32_41"("part_id"),
    FOREIGN KEY ("ps_part_id") REFERENCES "part_misc_96461"("part_id")
);

CREATE TABLE "partsupp_avail_5010_7498" (
    "ps_part_id" INTEGER,
    "ps_supp_id" INTEGER,
    "ps_cost" REAL NOT NULL,
    "ps_avail_qty" INTEGER,
    "ps_note" TEXT,
    FOREIGN KEY ("ps_part_id") REFERENCES "part_brands_15_22_23_32_41"("part_id")
);

CREATE TABLE "ord_dt_gt19930824_to19950416" (
    "ord_dt" DATE,
    "ord_id" INTEGER,
    "ord_cust_id" INTEGER NOT NULL,
    "ord_prio" TEXT,
    "ord_ship_prio" INTEGER,
    "ord_clerk" TEXT,
    "ord_status" TEXT,
    "ord_total_amt" REAL,
    "ord_note" TEXT
);

CREATE TABLE "ord_dt_gt19950416_to19961207" (
    "ord_dt" DATE,
    "ord_id" INTEGER,
    "ord_cust_id" INTEGER NOT NULL,
    "ord_prio" TEXT,
    "ord_ship_prio" INTEGER,
    "ord_clerk" TEXT,
    "ord_status" TEXT,
    "ord_total_amt" REAL,
    "ord_note" TEXT
);