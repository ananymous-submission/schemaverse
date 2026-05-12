CREATE TABLE "staff_category_memberships" (
    "staff_member_id" INTEGER,
    "category_identifier" TEXT DEFAULT 'ACC'
);

CREATE TABLE "academic_programs" (
    "program_id" INTEGER,
    "program_name" TEXT
);

CREATE TABLE "student_profiles" (
    "student_id" INTEGER,
    "study_area_code" TEXT,
    "name" TEXT,
    "last_name" TEXT,
    "phone_number" TEXT,
    "state_code" TEXT,
    "street_address" TEXT,
    "postal_code" TEXT
);