CREATE TABLE "addr_lastlte_20210306_155155" (
    "addr_id_lte155155" INT,
    "addr_line" VARCHAR(50) NOT NULL,
    "city_id_fk" INT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    "post_code" VARCHAR(10) DEFAULT NULL,
    FOREIGN KEY ("city_id_fk") REFERENCES "city_lastlte_20210306_155151"("city_id_pk_old")
);

CREATE TABLE "addr_lastrange_155155_155156" (
    "addr_id_range_155155_155156" INT,
    "addr_line" VARCHAR(50) NOT NULL,
    "city_id_fk" INT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    "post_code" VARCHAR(10) DEFAULT NULL,
    FOREIGN KEY ("city_id_fk") REFERENCES "city_gt_155152_or_null"("city_id_pk_var")
);

CREATE TABLE "addr_lastrange_155156_155157" (
    "addr_id_range_155156_155157" INT,
    "addr_line" VARCHAR(50) NOT NULL,
    "city_id_fk" INT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    "post_code" VARCHAR(10) DEFAULT NULL,
    FOREIGN KEY ("city_id_fk") REFERENCES "city_lastlte_20210306_155151"("city_id_pk_old"),
    FOREIGN KEY ("city_id_fk") REFERENCES "city_gt_155152_or_null"("city_id_pk_var")
);

CREATE TABLE "addr_lastgt_155157_or_null" (
    "addr_id_gt155157" INT,
    "addr_line" VARCHAR(50) NOT NULL,
    "city_id_fk" INT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    "post_code" VARCHAR(10) DEFAULT NULL,
    FOREIGN KEY ("city_id_fk") REFERENCES "city_lastlte_20210306_155151"("city_id_pk_old"),
    FOREIGN KEY ("city_id_fk") REFERENCES "city_gt_155152_or_null"("city_id_pk_var")
);

CREATE TABLE "addr_core" (
    "addr_id_core" INT,
    "addr_line" VARCHAR(50) NOT NULL,
    "addr_unit" VARCHAR(50) DEFAULT NULL,
    "city_id_fk" INT NOT NULL,
    "dist" VARCHAR(20) NOT NULL,
    "phone_no" VARCHAR(20) NOT NULL,
    "post_code" VARCHAR(10) DEFAULT NULL,
    FOREIGN KEY ("city_id_fk") REFERENCES "city_gt_155152_or_null"("city_id_pk_var")
);

CREATE TABLE "city_lastlte_20210306_155151" (
    "city_id_pk_old" INT,
    "city_name" VARCHAR(50) NOT NULL,
    "country_fk" SMALLINT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL
);

CREATE TABLE "city_gt_155152_or_null" (
    "city_id_pk_var" INT,
    "city_name" VARCHAR(50) NOT NULL,
    "country_fk" SMALLINT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL
);

CREATE TABLE "cust_lastlte_20210306_155337" (
    "cust_id_pk_old" INT,
    "store_fk" INT NOT NULL,
    "fname" VARCHAR(45) NOT NULL,
    "lname" VARCHAR(45) NOT NULL,
    "email_addr" VARCHAR(50) DEFAULT NULL,
    "addr_id_fk" INT NOT NULL,
    "is_active" CHAR(1) NOT NULL DEFAULT 'Y',
    "created_ts" TIMESTAMP NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_lastrange_155155_155156"("addr_id_range_155155_155156"),
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_core"("addr_id_core")
);

CREATE TABLE "cust_lastgt_20210306_155339_or_null" (
    "cust_id_pk_recent" INT,
    "store_fk" INT NOT NULL,
    "fname" VARCHAR(45) NOT NULL,
    "lname" VARCHAR(45) NOT NULL,
    "email_addr" VARCHAR(50) DEFAULT NULL,
    "addr_id_fk" INT NOT NULL,
    "is_active" CHAR(1) NOT NULL DEFAULT 'Y',
    "created_ts" TIMESTAMP NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_lastlte_20210306_155155"("addr_id_lte155155"),
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_lastrange_155156_155157"("addr_id_range_155156_155157"),
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_lastgt_155157_or_null"("addr_id_gt155157"),
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_core"("addr_id_core")
);

CREATE TABLE "pay_amt_cat_3_8_7_1_other" (
    "pay_id_pk" INT,
    "amt" DECIMAL(5,2) NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    "pay_date_ts" TIMESTAMP NOT NULL,
    "rental_fk" INT DEFAULT NULL
);

CREATE TABLE "pay_hist_cust" (
    "pay_id_pk" INT,
    "amt" DECIMAL(5,2) NOT NULL,
    "cust_id_fk" INT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    "rental_fk" INT DEFAULT NULL,
    "staff_id_fk" SMALLINT NOT NULL,
    FOREIGN KEY ("staff_id_fk") REFERENCES "staff_status"("staff_id_pk"),
    FOREIGN KEY ("cust_id_fk") REFERENCES "cust_lastlte_20210306_155337"("cust_id_pk_old")
);

CREATE TABLE "staff_status" (
    "staff_id_pk" SMALLINT,
    "is_active_flag" SMALLINT NOT NULL DEFAULT 1,
    "addr_id_fk" INT NOT NULL,
    "email_addr" VARCHAR(50) DEFAULT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    "passwd_hash" VARCHAR(40) DEFAULT NULL,
    "pic_blob" BLOB DEFAULT NULL,
    "store_fk" INT NOT NULL,
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_lastrange_155156_155157"("addr_id_range_155156_155157")
);

CREATE TABLE "store_loc" (
    "store_id_pk" INT,
    "manager_staff_fk" SMALLINT NOT NULL,
    "addr_id_fk" INT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_lastlte_20210306_155155"("addr_id_lte155155"),
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_lastgt_155157_or_null"("addr_id_gt155157"),
    FOREIGN KEY ("addr_id_fk") REFERENCES "addr_core"("addr_id_core")
);

CREATE TABLE "rental_lastrange_155413_155446" (
    "rental_id_pk" INT,
    "cust_id_fk" INT NOT NULL,
    "invent_fk" INT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    "staff_id_fk" SMALLINT NOT NULL,
    FOREIGN KEY ("cust_id_fk") REFERENCES "cust_lastgt_20210306_155339_or_null"("cust_id_pk_recent"),
    FOREIGN KEY ("staff_id_fk") REFERENCES "staff_status"("staff_id_pk")
);

CREATE TABLE "rental_lastrange_155446_155520" (
    "rental_id_pk" INT,
    "cust_id_fk" INT NOT NULL,
    "invent_fk" INT NOT NULL,
    "last_upd_ts" TIMESTAMP NOT NULL,
    "staff_id_fk" SMALLINT NOT NULL,
    FOREIGN KEY ("cust_id_fk") REFERENCES "cust_lastgt_20210306_155339_or_null"("cust_id_pk_recent"),
    FOREIGN KEY ("staff_id_fk") REFERENCES "staff_status"("staff_id_pk")
);