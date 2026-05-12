CREATE TABLE "cust_addr_us" (
    "cust_id" INTEGER,
    "addr_line" NVARCHAR(70),
    "city_nm" NVARCHAR(40),
    "country_cd" NVARCHAR(40),
    "email_addr" NVARCHAR(60) NOT NULL,
    "fax_no" NVARCHAR(24),
    "phone_no" NVARCHAR(24),
    "postal_cd" NVARCHAR(10),
    "state_cd" NVARCHAR(40),
    "support_emp_id" INTEGER,
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_addr"("emp_id"),
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_dates"("emp_id"),
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_profile"("emp_id")
);

CREATE TABLE "cust_addr_ca_gb_pt" (
    "cust_id" INTEGER,
    "addr_line" NVARCHAR(70),
    "city_nm" NVARCHAR(40),
    "country_cd" NVARCHAR(40),
    "email_addr" NVARCHAR(60) NOT NULL,
    "fax_no" NVARCHAR(24),
    "phone_no" NVARCHAR(24),
    "postal_cd" NVARCHAR(10),
    "state_cd" NVARCHAR(40),
    "support_emp_id" INTEGER
);

CREATE TABLE "cust_addr_br_fr" (
    "cust_id" INTEGER,
    "addr_line" NVARCHAR(70),
    "city_nm" NVARCHAR(40),
    "country_cd" NVARCHAR(40),
    "email_addr" NVARCHAR(60) NOT NULL,
    "fax_no" NVARCHAR(24),
    "phone_no" NVARCHAR(24),
    "postal_cd" NVARCHAR(10),
    "state_cd" NVARCHAR(40),
    "support_emp_id" INTEGER,
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_addr"("emp_id"),
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_dates"("emp_id"),
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_profile"("emp_id")
);

CREATE TABLE "cust_addr_de_cz_in" (
    "cust_id" INTEGER,
    "addr_line" NVARCHAR(70),
    "city_nm" NVARCHAR(40),
    "country_cd" NVARCHAR(40),
    "email_addr" NVARCHAR(60) NOT NULL,
    "fax_no" NVARCHAR(24),
    "phone_no" NVARCHAR(24),
    "postal_cd" NVARCHAR(10),
    "state_cd" NVARCHAR(40),
    "support_emp_id" INTEGER,
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_addr"("emp_id"),
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_profile"("emp_id")
);

CREATE TABLE "cust_addr_other" (
    "cust_id" INTEGER,
    "addr_line" NVARCHAR(70),
    "city_nm" NVARCHAR(40),
    "country_cd" NVARCHAR(40),
    "email_addr" NVARCHAR(60) NOT NULL,
    "fax_no" NVARCHAR(24),
    "phone_no" NVARCHAR(24),
    "postal_cd" NVARCHAR(10),
    "state_cd" NVARCHAR(40),
    "support_emp_id" INTEGER,
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_addr"("emp_id")
);

CREATE TABLE "cust_city" (
    "cust_id" INTEGER,
    "city_nm" NVARCHAR(40),
    "comp_name" NVARCHAR(80),
    "country_cd" NVARCHAR(40),
    "nm" NVARCHAR(40) NOT NULL,
    "last_nm" NVARCHAR(20) NOT NULL,
    "postal_cd" NVARCHAR(10),
    "state_cd" NVARCHAR(40),
    "support_emp_id" INTEGER,
    FOREIGN KEY ("support_emp_id") REFERENCES "emp_addr"("emp_id")
);

CREATE TABLE "emp_addr" (
    "emp_id" INTEGER,
    "addr_line" NVARCHAR(70),
    "city_nm" NVARCHAR(40),
    "country_cd" NVARCHAR(40),
    "email_addr" NVARCHAR(60),
    "fax_no" NVARCHAR(24),
    "phone_no" NVARCHAR(24),
    "postal_cd" NVARCHAR(10),
    "mgr_emp_id" INTEGER,
    "state_cd" NVARCHAR(40),
    FOREIGN KEY ("mgr_emp_id") REFERENCES "emp_addr"("emp_id")
);

CREATE TABLE "emp_dates" (
    "emp_id" INTEGER,
    "birth_dt" DATETIME,
    "hire_dt" DATETIME,
    "job_title" NVARCHAR(30)
);

CREATE TABLE "emp_profile" (
    "emp_id" INTEGER,
    "city_nm" NVARCHAR(40),
    "email_addr" NVARCHAR(60),
    "fax_no" NVARCHAR(24),
    "nm" NVARCHAR(20) NOT NULL,
    "last_nm" NVARCHAR(20) NOT NULL,
    "phone_no" NVARCHAR(24),
    "mgr_emp_id" INTEGER,
    "state_cd" NVARCHAR(40)
);

CREATE TABLE "inv_bill_addr_known" (
    "inv_id" INTEGER,
    "bill_addr_line" NVARCHAR(70),
    "bill_postal_cd" NVARCHAR(10),
    "bill_state_cd" NVARCHAR(40),
    "cust_id" INTEGER NOT NULL,
    "inv_dt" DATETIME NOT NULL,
    "total_amt" NUMERIC(10,2) NOT NULL,
    FOREIGN KEY ("cust_id") REFERENCES "cust_addr_us"("cust_id"),
    FOREIGN KEY ("cust_id") REFERENCES "cust_addr_ca_gb_pt"("cust_id"),
    FOREIGN KEY ("cust_id") REFERENCES "cust_addr_br_fr"("cust_id")
);