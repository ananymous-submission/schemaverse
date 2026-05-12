CREATE TABLE "sat_scores_over_1500_by_school" (
    "school_cds_code" TEXT,
    "students_with_sat_ge_1500" INTEGER,
    "total_test_takers" INTEGER NOT NULL,
    "county_name" TEXT,
    "enrollment_grade_12" INTEGER NOT NULL,
    "report_type" TEXT NOT NULL,
    FOREIGN KEY ("school_cds_code") REFERENCES "school_administration_contacts"("school_cds_code")
);

CREATE TABLE "sat_scores_over_1500_district_view" (
    "school_cds_code" TEXT,
    "students_with_sat_ge_1500" INTEGER,
    "county_name" TEXT,
    "district_name" TEXT,
    "enrollment_grade_12" INTEGER NOT NULL,
    "report_type" TEXT NOT NULL,
    "school_name" TEXT
);

CREATE TABLE "school_administration_contacts" (
    "school_cds_code" TEXT,
    "admin_primary_email" TEXT,
    "admin_secondary_email" TEXT,
    "admin_tertiary_email" TEXT,
    "admin_primary_name" TEXT,
    "admin_secondary_name" TEXT,
    "admin_tertiary_name" TEXT,
    "admin_primary_last_name" TEXT,
    "admin_secondary_last_name" TEXT,
    "admin_tertiary_last_name" TEXT
);