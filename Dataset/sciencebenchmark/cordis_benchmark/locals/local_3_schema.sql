CREATE TABLE "academic_programs" (
    "program_code" TEXT,
    "registry_number" TEXT,
    "full_title" TEXT,
    "short_label" TEXT,
    "parent_program_code" TEXT
);

CREATE TABLE "research_project_review_panels" (
    "research_project_id" INTEGER,
    "erc_panel_label" TEXT
);