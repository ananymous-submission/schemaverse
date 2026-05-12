CREATE TABLE "identifier_map" (
    "mapping_key" TEXT,
    "transformation_rules" TEXT NOT NULL
);

CREATE TABLE "migration_record" (
    "repository_key" TEXT,
    "repository_location" TEXT,
    "migration_version" INTEGER DEFAULT NULL
);

CREATE TABLE "project_route" (
    "endpoint_key" TEXT,
    "project_key" TEXT
);