-- Consolidated local schemas
-- Generated from: /project/6048152/mdaviran/data-integration/BIRD/train_databases/shakespeare/shakespeare.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

CREATE TABLE "chapters_scene_at_most_2" (
    "chapter_id" INTEGER,
    "act_number" INTEGER NOT NULL,
    "scene_number" INTEGER NOT NULL,
    "scene_description" TEXT NOT NULL,
    "work_ref_id" INTEGER NOT NULL
);

CREATE TABLE "chapters_scene_above_6_or_null" (
    "chapter_id" INTEGER,
    "act_number" INTEGER NOT NULL,
    "scene_number" INTEGER NOT NULL,
    "scene_description" TEXT NOT NULL,
    "work_ref_id" INTEGER NOT NULL
);

CREATE TABLE "paragraphs_number_up_to_788" (
    "paragraph_id" INTEGER,
    "paragraph_number" INTEGER NOT NULL,
    "plain_text" TEXT NOT NULL,
    "character_ref_id" INTEGER NOT NULL,
    "chapter_ref_id" INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE "paragraphs_number_above_2340_or_null" (
    "paragraph_id" INTEGER,
    "paragraph_number" INTEGER NOT NULL,
    "plain_text" TEXT NOT NULL,
    "character_ref_id" INTEGER NOT NULL,
    "chapter_ref_id" INTEGER NOT NULL DEFAULT 0
);

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "CharacterRosterEmptyDescription" (
    "CharacterId" INTEGER,
    "CharacterName" TEXT NOT NULL,
    "NameAbbreviation" TEXT NOT NULL,
    "CharacterDescription" TEXT NOT NULL
);

CREATE TABLE "CharacterRosterWithRoleCategories" (
    "CharacterId" INTEGER,
    "CharacterName" TEXT NOT NULL,
    "NameAbbreviation" TEXT NOT NULL,
    "RoleCategory" TEXT NOT NULL
);

CREATE TABLE "ParagraphsQuartileTwo789To1556" (
    "ParagraphId" INTEGER,
    "ParagraphNumber" INTEGER NOT NULL,
    "TextContent" TEXT NOT NULL,
    "CharacterReferenceId" INTEGER NOT NULL,
    "ChapterReferenceId" INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE "ParagraphsQuartileThree1557To2340" (
    "ParagraphId" INTEGER,
    "ParagraphNumber" INTEGER NOT NULL,
    "TextContent" TEXT NOT NULL,
    "CharacterReferenceId" INTEGER NOT NULL,
    "ChapterReferenceId" INTEGER NOT NULL DEFAULT 0
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "literaryWorks" (
    "workId" INTEGER,
    "shortTitle" TEXT NOT NULL,
    "fullTitle" TEXT NOT NULL,
    "publicationYear" INTEGER NOT NULL,
    "genre" TEXT NOT NULL
);

CREATE TABLE "chaptersSceneAboveTwoToThree" (
    "chapterId" INTEGER,
    "actNumber" INTEGER NOT NULL,
    "sceneNumber" INTEGER NOT NULL,
    "sceneDescription" TEXT NOT NULL,
    "workRefId" INTEGER NOT NULL
);

CREATE TABLE "chaptersSceneAboveThreeToSix" (
    "chapterId" INTEGER,
    "actNumber" INTEGER NOT NULL,
    "sceneNumber" INTEGER NOT NULL,
    "sceneDescription" TEXT NOT NULL,
    "workRefId" INTEGER NOT NULL
);

