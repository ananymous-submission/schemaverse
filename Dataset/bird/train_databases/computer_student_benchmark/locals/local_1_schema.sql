CREATE TABLE "advisory_assignments" (
    "advisee_person_id" INTEGER,
    "assignment_id" INTEGER,
    FOREIGN KEY ("advisee_person_id") REFERENCES "people_years_one_seven_twelve_or_other"("person_id")
);

CREATE TABLE "people_year_zero" (
    "person_id" INTEGER,
    "is_professor" INTEGER,
    "is_student" INTEGER,
    "position_title" TEXT,
    "program_phase" TEXT,
    "years_in_program" TEXT
);

CREATE TABLE "people_years_one_seven_twelve_or_other" (
    "person_id" INTEGER,
    "is_professor" INTEGER,
    "is_student" INTEGER,
    "position_title" TEXT,
    "program_phase" TEXT,
    "years_in_program" TEXT
);