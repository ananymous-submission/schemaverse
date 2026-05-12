CREATE TABLE "activity_types" (
  "code" TEXT,
  "description" TEXT,
  PRIMARY KEY ("code")
);

CREATE TABLE "countries" (
  "unics_id" INTEGER,
  "country_name" TEXT,
  "country_code2" TEXT,
  "country_code3" TEXT,
  "geocode_country_code" TEXT,
  PRIMARY KEY ("unics_id")
);

CREATE TABLE "ec_framework_programs" (
  "ec_framework_program_name" TEXT,
  PRIMARY KEY ("ec_framework_program_name")
);

CREATE TABLE "erc_panels" (
  "code" TEXT,
  "description" TEXT,
  "part_of" TEXT,
  PRIMARY KEY ("code"),
  FOREIGN KEY ("part_of") REFERENCES "erc_research_domains" ("code")
);

CREATE TABLE "erc_research_domains" (
  "code" TEXT,
  "description" TEXT,
  PRIMARY KEY ("code")
);

CREATE TABLE "eu_territorial_units" (
  "geocode_regions" TEXT,
  "description" TEXT,
  "geocode_level" INTEGER,
  "nuts_version" TEXT,
  PRIMARY KEY ("geocode_regions")
);

CREATE TABLE "funding_schemes" (
  "code" TEXT,
  "title" TEXT,
  PRIMARY KEY ("code")
);

CREATE TABLE "institutions" (
  "unics_id" INTEGER,
  "country_id" INTEGER,
  "institutions_name" TEXT,
  "geocode_regions_3" TEXT,
  "db_pedia_url" TEXT,
  "wikidata_url" TEXT,
  "grid_id" TEXT,
  "acronym" TEXT,
  "short_name" TEXT,
  "website" TEXT,
  "document_vectors" TEXT,
  PRIMARY KEY ("unics_id"),
  FOREIGN KEY ("country_id") REFERENCES "countries" ("unics_id"),
  FOREIGN KEY ("geocode_regions_3") REFERENCES "eu_territorial_units" ("geocode_regions")
);

CREATE TABLE "people" (
  "unics_id" INTEGER,
  "full_name" TEXT,
  PRIMARY KEY ("unics_id")
);

CREATE TABLE "programmes" (
  "code" TEXT,
  "rcn" TEXT,
  "title" TEXT,
  "short_name" TEXT,
  "parent" TEXT,
  PRIMARY KEY ("code"),
  FOREIGN KEY ("parent") REFERENCES "programmes" ("code")
);

CREATE TABLE "project_erc_panels" (
  "project" INTEGER,
  "panel" TEXT,
  PRIMARY KEY ("project"),
  FOREIGN KEY ("panel") REFERENCES "erc_panels" ("code"),
  FOREIGN KEY ("project") REFERENCES "projects" ("unics_id")
);

CREATE TABLE "project_member_roles" (
  "code" TEXT,
  "description" TEXT,
  PRIMARY KEY ("code")
);

CREATE TABLE "project_members" (
  "unics_id" INTEGER,
  "project" INTEGER,
  "pic_number" TEXT,
  "rcn" TEXT,
  "member_name" TEXT,
  "activity_type" TEXT,
  "country" TEXT,
  "street" TEXT,
  "city" TEXT,
  "postal_code" TEXT,
  "ec_contribution" REAL,
  "institution_id" INTEGER,
  "member_role" TEXT,
  "geocode_regions_3" TEXT,
  "member_short_name" TEXT,
  "department_name" TEXT,
  "vat_number" TEXT,
  "latitude" NUMERIC,
  "longitude" NUMERIC,
  "region_code" TEXT,
  "region_name" TEXT,
  PRIMARY KEY ("unics_id"),
  FOREIGN KEY ("activity_type") REFERENCES "activity_types" ("code"),
  FOREIGN KEY ("institution_id") REFERENCES "institutions" ("unics_id"),
  FOREIGN KEY ("member_role") REFERENCES "project_member_roles" ("code"),
  FOREIGN KEY ("geocode_regions_3") REFERENCES "eu_territorial_units" ("geocode_regions"),
  FOREIGN KEY ("project") REFERENCES "projects" ("unics_id")
);

CREATE TABLE "project_programmes" (
  "project" INTEGER,
  "programme" TEXT,
  PRIMARY KEY ("project", "programme"),
  FOREIGN KEY ("programme") REFERENCES "programmes" ("code"),
  FOREIGN KEY ("project") REFERENCES "projects" ("unics_id")
);

CREATE TABLE "project_subject_areas" (
  "project" INTEGER,
  "subject_area" TEXT,
  PRIMARY KEY ("project", "subject_area"),
  FOREIGN KEY ("project") REFERENCES "projects" ("unics_id"),
  FOREIGN KEY ("subject_area") REFERENCES "subject_areas" ("code")
);

CREATE TABLE "project_topics" (
  "project" INTEGER,
  "topic" TEXT,
  PRIMARY KEY ("project", "topic"),
  FOREIGN KEY ("project") REFERENCES "projects" ("unics_id"),
  FOREIGN KEY ("topic") REFERENCES "topics" ("code")
);

CREATE TABLE "projects" (
  "unics_id" INTEGER,
  "acronym" TEXT,
  "title" TEXT,
  "ec_call" TEXT,
  "ec_fund_scheme" TEXT,
  "cordis_ref" TEXT,
  "ec_ref" TEXT,
  "start_date" TEXT,
  "end_date" TEXT,
  "start_year" INTEGER,
  "end_year" INTEGER,
  "homepage" TEXT,
  "total_cost" REAL,
  "ec_max_contribution" REAL,
  "framework_program" TEXT,
  "objective" TEXT,
  "principal_investigator" INTEGER,
  PRIMARY KEY ("unics_id"),
  FOREIGN KEY ("ec_fund_scheme") REFERENCES "funding_schemes" ("code"),
  FOREIGN KEY ("framework_program") REFERENCES "ec_framework_programs" ("ec_framework_program_name"),
  FOREIGN KEY ("principal_investigator") REFERENCES "people" ("unics_id")
);

CREATE TABLE "subject_areas" (
  "code" TEXT,
  "title" TEXT,
  "description" TEXT,
  PRIMARY KEY ("code")
);

CREATE TABLE "topics" (
  "code" TEXT,
  "rcn" TEXT,
  "title" TEXT,
  PRIMARY KEY ("code")
);