CREATE TABLE "research_assistant" (
    "student_identifier" INTEGER,
    "competency_level" INTEGER,
    "faculty_id" INTEGER,
    "stipend_amount" TEXT,
    FOREIGN KEY ("faculty_id") REFERENCES "faculty_contact"("faculty_id"),
    FOREIGN KEY ("faculty_id") REFERENCES "faculty_profile"("faculty_id")
);

CREATE TABLE "faculty_contact" (
    "faculty_id" INTEGER,
    "contact_email" TEXT,
    "gender_identity" TEXT,
    "alma_mater" TEXT,
    "reputation_score" INTEGER,
    "teaching_proficiency" INTEGER
);

CREATE TABLE "faculty_profile" (
    "faculty_id" INTEGER,
    "primary_email" TEXT,
    "given_name" TEXT,
    "gender_identity" TEXT,
    "alma_mater" TEXT,
    "family_name" TEXT
);