CREATE TABLE "inspection_point_food_protection" (
    "inspection_point_id" INTEGER,
    "description_text" TEXT,
    "category_label" TEXT,
    "reference_code" TEXT,
    "penalty_amount" INTEGER,
    "severity_level" TEXT
);

CREATE TABLE "inspection_point_food_maintenance" (
    "inspection_point_id" INTEGER,
    "description_text" TEXT,
    "category_label" TEXT,
    "reference_code" TEXT,
    "penalty_amount" INTEGER,
    "severity_level" TEXT
);

CREATE TABLE "inspection_point_equipment_and_hygiene" (
    "inspection_point_id" INTEGER,
    "description_text" TEXT,
    "category_label" TEXT,
    "reference_code" TEXT,
    "penalty_amount" INTEGER,
    "severity_level" TEXT
);

CREATE TABLE "inspection_point_pest_control_compliance_sanitation" (
    "inspection_point_id" INTEGER,
    "description_text" TEXT,
    "category_label" TEXT,
    "reference_code" TEXT,
    "penalty_amount" INTEGER,
    "severity_level" TEXT
);

CREATE TABLE "inspection_point_other_categories" (
    "inspection_point_id" INTEGER,
    "description_text" TEXT,
    "category_label" TEXT,
    "reference_code" TEXT,
    "penalty_amount" INTEGER,
    "severity_level" TEXT
);

CREATE TABLE "inspection_violation" (
    "inspection_record_id" INTEGER,
    "inspection_point_id" INTEGER,
    "violation_penalty_amount" INTEGER,
    "inspector_notes" TEXT,
    FOREIGN KEY ("inspection_point_id") REFERENCES "inspection_point_food_maintenance"("inspection_point_id"),
    FOREIGN KEY ("inspection_point_id") REFERENCES "inspection_point_pest_control_compliance_sanitation"("inspection_point_id")
);