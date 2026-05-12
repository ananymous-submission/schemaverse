CREATE TABLE "enrollment_month_up_to_3" (
    "person_name" TEXT,
    "school_name" TEXT,
    "enrolled_month" INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE "enrollment_month_4_to_6" (
    "person_name" TEXT,
    "school_name" TEXT,
    "enrolled_month" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("person_name") REFERENCES "person_registry"("person_name")
);

CREATE TABLE "enrollment_month_7_to_10" (
    "person_name" TEXT,
    "school_name" TEXT,
    "enrolled_month" INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY ("person_name") REFERENCES "person_registry"("person_name")
);

CREATE TABLE "enrollment_month_over_10_or_null" (
    "person_name" TEXT,
    "school_name" TEXT,
    "enrolled_month" INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE "bankruptcy_filings" (
    "person_name" TEXT DEFAULT '',
    FOREIGN KEY ("person_name") REFERENCES "person_registry"("person_name")
);

CREATE TABLE "male_persons" (
    "person_name" TEXT DEFAULT '',
    FOREIGN KEY ("person_name") REFERENCES "person_registry"("person_name")
);

CREATE TABLE "person_registry" (
    "person_name" TEXT DEFAULT ''
);

CREATE TABLE "unemployed_persons" (
    "person_name" TEXT DEFAULT ''
);

CREATE TABLE "longest_absence_3_to_4_months" (
    "person_name" TEXT DEFAULT '',
    "longest_absence_months" INTEGER DEFAULT 0
);

CREATE TABLE "longest_absence_5_to_7_months" (
    "person_name" TEXT DEFAULT '',
    "longest_absence_months" INTEGER DEFAULT 0
);