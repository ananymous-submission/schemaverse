CREATE TABLE "cc_recv_le_20130829" (
    "comp_id" TEXT,
    "recv_date" DATE,
    "prio" INTEGER,
    "comp_type" TEXT
);

CREATE TABLE "cc_recv_20130830_20150325" (
    "comp_id" TEXT,
    "recv_date" DATE,
    "prio" INTEGER,
    "comp_type" TEXT
);

CREATE TABLE "cc_recv_20150326_20160822" (
    "comp_id" TEXT,
    "recv_date" DATE,
    "prio" INTEGER,
    "comp_type" TEXT
);

CREATE TABLE "cc_recv_gt_20160822_null" (
    "comp_id" TEXT,
    "recv_date" DATE,
    "prio" INTEGER,
    "comp_type" TEXT
);

CREATE TABLE "cc_call_meta" (
    "comp_id" TEXT,
    "call_num" INTEGER,
    "call_outcome" TEXT,
    "phone_term" TEXT,
    "client_rand_id" TEXT,
    "srv_name" TEXT,
    "vru_line" TEXT,
    FOREIGN KEY ("client_rand_id") REFERENCES "client_date_parts"("cli_id")
);

CREATE TABLE "cc_call_serv" (
    "comp_id" TEXT,
    "call_num" INTEGER,
    "call_outcome" TEXT,
    "phone_term" TEXT,
    "srv_exit_time" TEXT,
    "srv_start_time" TEXT,
    "srv_dur" TEXT,
    "srv_name" TEXT,
    "vru_line" TEXT
);

CREATE TABLE "client_addr_le_31" (
    "cli_id" TEXT,
    "addr_line1" TEXT,
    "addr_line2" TEXT,
    "age_yrs" INTEGER,
    "city" TEXT,
    "district_code" INTEGER,
    "email_addr" TEXT,
    "phone_num" TEXT,
    "sex_code" TEXT,
    "social_id" TEXT,
    "zip_code" INTEGER
);

CREATE TABLE "client_date_parts" (
    "cli_id" TEXT,
    "day_n" INTEGER,
    "mon_n" INTEGER,
    "yr_n" INTEGER
);

CREATE TABLE "ev_recv_le_20130524" (
    "comp_id" TEXT,
    "cli_id" TEXT,
    "recv_date" DATE,
    "sent_to_co_date" TEXT,
    FOREIGN KEY ("cli_id") REFERENCES "client_addr_le_31"("cli_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_le_20130829"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_20130830_20150325"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_call_meta"("comp_id")
);

CREATE TABLE "ev_recv_20130525_20141229" (
    "comp_id" TEXT,
    "cli_id" TEXT,
    "recv_date" DATE,
    "sent_to_co_date" TEXT,
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_le_20130829"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_20150326_20160822"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_gt_20160822_null"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_call_meta"("comp_id")
);

CREATE TABLE "ev_recv_20141230_20160308" (
    "comp_id" TEXT,
    "cli_id" TEXT,
    "recv_date" DATE,
    "sent_to_co_date" TEXT,
    FOREIGN KEY ("cli_id") REFERENCES "client_addr_le_31"("cli_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_le_20130829"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_gt_20160822_null"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_call_meta"("comp_id")
);

CREATE TABLE "ev_recv_gt_20160308_null" (
    "comp_id" TEXT,
    "cli_id" TEXT,
    "recv_date" DATE,
    "sent_to_co_date" TEXT,
    FOREIGN KEY ("cli_id") REFERENCES "client_addr_le_31"("cli_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_20130830_20150325"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_20150326_20160822"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_gt_20160822_null"("comp_id")
);

CREATE TABLE "ev_cons_narr" (
    "comp_id" TEXT,
    "cli_id" TEXT,
    "cons_narr" TEXT,
    "cons_consent" TEXT,
    "cons_disputed" TEXT,
    "issue_cat" TEXT,
    "sub_issue" TEXT,
    "timely_resp" TEXT,
    FOREIGN KEY ("cli_id") REFERENCES "client_addr_le_31"("cli_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_le_20130829"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_20130830_20150325"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_20150326_20160822"("comp_id")
);

CREATE TABLE "ev_product" (
    "comp_id" TEXT,
    "cli_id" TEXT,
    "product" TEXT,
    "sub_product" TEXT,
    FOREIGN KEY ("cli_id") REFERENCES "client_date_parts"("cli_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_recv_20130830_20150325"("comp_id"),
    FOREIGN KEY ("comp_id") REFERENCES "cc_call_serv"("comp_id")
);