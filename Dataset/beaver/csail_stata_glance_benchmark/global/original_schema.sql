CREATE TABLE "artifact_blob_locations" (
  "id" TEXT NOT NULL,
  "blob_id" TEXT NOT NULL,
  "value" TEXT NOT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL,
  "position" INTEGER DEFAULT NULL,
  "status" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "artifact_blob_locations_ibfk_1" FOREIGN KEY ("blob_id") REFERENCES "artifact_blobs" ("id")
);

CREATE TABLE "artifact_blobs" (
  "id" TEXT NOT NULL,
  "artifact_id" TEXT NOT NULL,
  "size" INTEGER NOT NULL,
  "checksum" TEXT DEFAULT NULL,
  "name" TEXT NOT NULL,
  "item_key" TEXT DEFAULT NULL,
  "position" INTEGER DEFAULT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "artifact_blobs_ibfk_1" FOREIGN KEY ("artifact_id") REFERENCES "artifacts" ("id")
);

CREATE TABLE "artifact_dependencies" (
  "id" TEXT NOT NULL,
  "artifact_source" TEXT NOT NULL,
  "artifact_dest" TEXT NOT NULL,
  "artifact_origin" TEXT NOT NULL,
  "is_direct" INTEGER NOT NULL,
  "position" INTEGER DEFAULT NULL,
  "name" TEXT DEFAULT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "artifact_dependencies_ibfk_1" FOREIGN KEY ("artifact_source") REFERENCES "artifacts" ("id"),
  CONSTRAINT "artifact_dependencies_ibfk_2" FOREIGN KEY ("artifact_dest") REFERENCES "artifacts" ("id"),
  CONSTRAINT "artifact_dependencies_ibfk_3" FOREIGN KEY ("artifact_origin") REFERENCES "artifacts" ("id")
);

CREATE TABLE "artifact_properties" (
  "id" TEXT NOT NULL,
  "artifact_id" TEXT NOT NULL,
  "name" TEXT NOT NULL,
  "string_value" TEXT DEFAULT NULL,
  "int_value" INTEGER DEFAULT NULL,
  "numeric_value" REAL DEFAULT NULL,
  "bool_value" INTEGER DEFAULT NULL,
  "text_value" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL,
  "position" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "artifact_properties_ibfk_1" FOREIGN KEY ("artifact_id") REFERENCES "artifacts" ("id")
);

CREATE TABLE "artifact_tags" (
  "id" TEXT NOT NULL,
  "artifact_id" TEXT NOT NULL,
  "value" TEXT NOT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "artifact_tags_ibfk_1" FOREIGN KEY ("artifact_id") REFERENCES "artifacts" ("id")
);

CREATE TABLE "artifacts" (
  "id" TEXT NOT NULL,
  "name" TEXT NOT NULL,
  "type_name" TEXT NOT NULL,
  "type_version_prefix" INTEGER NOT NULL,
  "type_version_suffix" TEXT DEFAULT NULL,
  "type_version_meta" TEXT DEFAULT NULL,
  "version_prefix" INTEGER NOT NULL,
  "version_suffix" TEXT DEFAULT NULL,
  "version_meta" TEXT DEFAULT NULL,
  "description" TEXT,
  "visibility" TEXT NOT NULL,
  "state" TEXT NOT NULL,
  "owner" TEXT NOT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT NOT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "published_at" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "image_locations" (
  "id" INTEGER NOT NULL ,
  "image_id" TEXT NOT NULL,
  "value" TEXT NOT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER NOT NULL,
  "meta_data" TEXT,
  "status" TEXT NOT NULL DEFAULT 'active',
  PRIMARY KEY ("id"),
  CONSTRAINT "image_locations_ibfk_1" FOREIGN KEY ("image_id") REFERENCES "images" ("id")
);

CREATE TABLE "image_members" (
  "id" INTEGER NOT NULL ,
  "image_id" TEXT NOT NULL,
  "member" TEXT NOT NULL,
  "can_share" INTEGER NOT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER NOT NULL,
  "status" TEXT NOT NULL DEFAULT 'pending',
  PRIMARY KEY ("id"),
  CONSTRAINT "image_members_ibfk_1" FOREIGN KEY ("image_id") REFERENCES "images" ("id")
);

CREATE TABLE "image_properties" (
  "id" INTEGER NOT NULL ,
  "image_id" TEXT NOT NULL,
  "name" TEXT NOT NULL,
  "value" TEXT,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "image_properties_ibfk_1" FOREIGN KEY ("image_id") REFERENCES "images" ("id")
);

CREATE TABLE "image_tags" (
  "id" INTEGER NOT NULL ,
  "image_id" TEXT NOT NULL,
  "value" TEXT NOT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "image_tags_ibfk_1" FOREIGN KEY ("image_id") REFERENCES "images" ("id")
);

CREATE TABLE "images" (
  "id" TEXT NOT NULL,
  "name" TEXT DEFAULT NULL,
  "size" INTEGER DEFAULT NULL,
  "status" TEXT NOT NULL,
  "is_public" INTEGER NOT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER NOT NULL,
  "disk_format" TEXT DEFAULT NULL,
  "container_format" TEXT DEFAULT NULL,
  "checksum" TEXT DEFAULT NULL,
  "owner" TEXT DEFAULT NULL,
  "min_disk" INTEGER NOT NULL,
  "min_ram" INTEGER NOT NULL,
  "protected" INTEGER NOT NULL DEFAULT '0',
  "virtual_size" INTEGER DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "metadef_namespace_resource_types" (
  "resource_type_id" INTEGER NOT NULL,
  "namespace_id" INTEGER NOT NULL,
  "properties_target" TEXT   DEFAULT NULL,
  "prefix" TEXT   DEFAULT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT DEFAULT NULL,
  PRIMARY KEY ("resource_type_id","namespace_id"),
  CONSTRAINT "metadef_namespace_resource_types_ibfk_1" FOREIGN KEY ("resource_type_id") REFERENCES "metadef_resource_types" ("id"),
  CONSTRAINT "metadef_namespace_resource_types_ibfk_2" FOREIGN KEY ("namespace_id") REFERENCES "metadef_namespaces" ("id")
);

CREATE TABLE "metadef_namespaces" (
  "id" INTEGER NOT NULL ,
  "namespace" TEXT   NOT NULL,
  "display_name" TEXT   DEFAULT NULL,
  "description" TEXT,
  "visibility" TEXT   DEFAULT NULL,
  "protected" INTEGER DEFAULT NULL,
  "owner" TEXT   NOT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "metadef_objects" (
  "id" INTEGER NOT NULL ,
  "namespace_id" INTEGER NOT NULL,
  "name" TEXT   NOT NULL,
  "description" TEXT,
  "required" TEXT,
  "json_schema" TEXT   NOT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "metadef_objects_fk_1" FOREIGN KEY ("namespace_id") REFERENCES "metadef_namespaces" ("id")
);

CREATE TABLE "metadef_properties" (
  "id" INTEGER NOT NULL ,
  "namespace_id" INTEGER NOT NULL,
  "name" TEXT   NOT NULL,
  "json_schema" TEXT   NOT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "metadef_properties_fk_1" FOREIGN KEY ("namespace_id") REFERENCES "metadef_namespaces" ("id")
);

CREATE TABLE "metadef_resource_types" (
  "id" INTEGER NOT NULL ,
  "name" TEXT   NOT NULL,
  "protected" INTEGER NOT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT DEFAULT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "metadef_tags" (
  "id" INTEGER NOT NULL ,
  "namespace_id" INTEGER NOT NULL,
  "name" TEXT NOT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "metadef_tags_fk_1" FOREIGN KEY ("namespace_id") REFERENCES "metadef_namespaces" ("id")
);

CREATE TABLE "migrate_version" (
  "repository_id" TEXT NOT NULL,
  "repository_path" TEXT,
  "version" INTEGER DEFAULT NULL,
  PRIMARY KEY ("repository_id")
);

CREATE TABLE "task_info" (
  "task_id" TEXT   NOT NULL,
  "input" TEXT,
  "result" TEXT,
  "message" TEXT,
  PRIMARY KEY ("task_id"),
  CONSTRAINT "task_info_ibfk_1" FOREIGN KEY ("task_id") REFERENCES "tasks" ("id")
);

CREATE TABLE "tasks" (
  "id" TEXT   NOT NULL,
  "type" TEXT   NOT NULL,
  "status" TEXT   NOT NULL,
  "owner" TEXT   NOT NULL,
  "expires_at" TEXT DEFAULT NULL,
  "created_at" TEXT NOT NULL,
  "updated_at" TEXT DEFAULT NULL,
  "deleted_at" TEXT DEFAULT NULL,
  "deleted" INTEGER NOT NULL,
  PRIMARY KEY ("id")
);