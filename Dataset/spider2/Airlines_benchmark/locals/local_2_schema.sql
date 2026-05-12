CREATE TABLE "bp_bno_le15" (
    "tkt_ref" character(13) NOT NULL,
    "flt_ref" INTEGER NOT NULL,
    "brd_pos" INTEGER NOT NULL,
    "seat_loc" character varying(4) NOT NULL
);

CREATE TABLE "bp_bno_gt15_lte36" (
    "tkt_ref" character(13) NOT NULL,
    "flt_ref" INTEGER NOT NULL,
    "brd_pos" INTEGER NOT NULL,
    "seat_loc" character varying(4) NOT NULL
);

CREATE TABLE "bp_bno_gt36_lte72" (
    "tkt_ref" character(13) NOT NULL,
    "flt_ref" INTEGER NOT NULL,
    "brd_pos" INTEGER NOT NULL,
    "seat_loc" character varying(4) NOT NULL
);

CREATE TABLE "bp_bno_gt72_or_null" (
    "tkt_ref" character(13) NOT NULL,
    "flt_ref" INTEGER NOT NULL,
    "brd_pos" INTEGER NOT NULL,
    "seat_loc" character varying(4) NOT NULL
);

CREATE TABLE "bk_dte_on_or_before_2017_07_12_081800" (
    "bk_ref" character(6) NOT NULL,
    "bk_ts" timestamp with time zone NOT NULL,
    "ttl_amt" numeric(10,2) NOT NULL
);

CREATE TABLE "bk_dte_gt20170712_081800_lte20170724_052400" (
    "bk_ref" character(6) NOT NULL,
    "bk_ts" timestamp with time zone NOT NULL,
    "ttl_amt" numeric(10,2) NOT NULL
);

CREATE TABLE "bk_dte_gt20170724_052400_lte20170805_015800" (
    "bk_ref" character(6) NOT NULL,
    "bk_ts" timestamp with time zone NOT NULL,
    "ttl_amt" numeric(10,2) NOT NULL
);

CREATE TABLE "bk_dte_gt20170805_015800_or_null" (
    "bk_ref" character(6) NOT NULL,
    "bk_ts" timestamp with time zone NOT NULL,
    "ttl_amt" numeric(10,2) NOT NULL
);