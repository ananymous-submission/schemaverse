CREATE TABLE "univ_enrl" (
    "off_id" INTEGER,
    "stu_id" INTEGER,
    "enr_grade" REAL
);

CREATE TABLE "stu_demo" (
    "nm" TEXT,
    "city" TEXT,
    "last_nm" TEXT,
    "stu_id" INTEGER,
    "state" TEXT,
    "zip_cd" TEXT
);

CREATE TABLE "stu_acadrec" (
    "nm" TEXT,
    "city" TEXT,
    "class_lvl" TEXT,
    "gpa" REAL,
    "last_nm" TEXT,
    "major" TEXT,
    "stu_id" INTEGER,
    "zip_cd" TEXT
);