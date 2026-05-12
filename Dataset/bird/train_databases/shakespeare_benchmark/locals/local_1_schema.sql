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