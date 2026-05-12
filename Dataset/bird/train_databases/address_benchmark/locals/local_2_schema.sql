CREATE TABLE "representatives_district_above_13_or_null" (
    "representative_id" TEXT,
    "congress_identifier" TEXT,
    "district_number" INTEGER,
    "chamber" TEXT,
    "state_abbr" TEXT,
    "land_area_sq_miles" REAL,
    "party_affiliation" TEXT
);

CREATE TABLE "representatives_directory" (
    "representative_id" TEXT,
    "congress_identifier" TEXT,
    "chamber" TEXT,
    "state_abbr" TEXT,
    "given_name" TEXT,
    "family_name" TEXT,
    "party_affiliation" TEXT,
    "state_name" TEXT
);

CREATE TABLE "zip_to_representative" (
    "postal_zip" INTEGER,
    "representative_id" TEXT,
    FOREIGN KEY ("postal_zip") REFERENCES "zip_payroll_upto_145000"("postal_zip"),
    FOREIGN KEY ("postal_zip") REFERENCES "zip_payroll_145000_to_1687000"("postal_zip"),
    FOREIGN KEY ("representative_id") REFERENCES "representatives_district_above_13_or_null"("representative_id"),
    FOREIGN KEY ("representative_id") REFERENCES "representatives_directory"("representative_id")
);

CREATE TABLE "zip_payroll_upto_145000" (
    "postal_zip" INTEGER,
    "quarter_payroll" INTEGER,
    "dependent_children" INTEGER,
    "disabled_beneficiaries" INTEGER,
    "monthly_benefits_total" INTEGER,
    "monthly_benefits_retirees" INTEGER,
    "monthly_benefits_widows" INTEGER,
    "parents_and_widows" INTEGER,
    "retired_beneficiaries" INTEGER,
    "spouse_beneficiaries" INTEGER,
    "beneficiaries_total" INTEGER
);

CREATE TABLE "zip_payroll_145000_to_1687000" (
    "postal_zip" INTEGER,
    "quarter_payroll" INTEGER,
    "dependent_children" INTEGER,
    "disabled_beneficiaries" INTEGER,
    "monthly_benefits_total" INTEGER,
    "monthly_benefits_retirees" INTEGER,
    "monthly_benefits_widows" INTEGER,
    "parents_and_widows" INTEGER,
    "retired_beneficiaries" INTEGER,
    "spouse_beneficiaries" INTEGER,
    "beneficiaries_total" INTEGER
);

CREATE TABLE "zip_payroll_1687000_to_18990000" (
    "postal_zip" INTEGER,
    "quarter_payroll" INTEGER,
    "dependent_children" INTEGER,
    "disabled_beneficiaries" INTEGER,
    "monthly_benefits_total" INTEGER,
    "monthly_benefits_retirees" INTEGER,
    "monthly_benefits_widows" INTEGER,
    "parents_and_widows" INTEGER,
    "retired_beneficiaries" INTEGER,
    "spouse_beneficiaries" INTEGER,
    "beneficiaries_total" INTEGER
);