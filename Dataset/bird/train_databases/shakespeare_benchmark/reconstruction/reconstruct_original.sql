-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct chapters from row partitions (UNION (overlap))
CREATE VIEW "chapters" AS
SELECT "local_1"."chapters_scene_at_most_2"."chapter_id" AS "id", "local_1"."chapters_scene_at_most_2"."act_number" AS "Act", "local_1"."chapters_scene_at_most_2"."scene_number" AS "Scene", "local_1"."chapters_scene_at_most_2"."scene_description" AS "Description", "local_1"."chapters_scene_at_most_2"."work_ref_id" AS "work_id" FROM "local_1"."chapters_scene_at_most_2"
UNION
SELECT "local_1"."chapters_scene_above_6_or_null"."chapter_id" AS "id", "local_1"."chapters_scene_above_6_or_null"."act_number" AS "Act", "local_1"."chapters_scene_above_6_or_null"."scene_number" AS "Scene", "local_1"."chapters_scene_above_6_or_null"."scene_description" AS "Description", "local_1"."chapters_scene_above_6_or_null"."work_ref_id" AS "work_id" FROM "local_1"."chapters_scene_above_6_or_null"
UNION
SELECT "local_3"."chaptersSceneAboveTwoToThree"."chapterId" AS "id", "local_3"."chaptersSceneAboveTwoToThree"."actNumber" AS "Act", "local_3"."chaptersSceneAboveTwoToThree"."sceneNumber" AS "Scene", "local_3"."chaptersSceneAboveTwoToThree"."sceneDescription" AS "Description", "local_3"."chaptersSceneAboveTwoToThree"."workRefId" AS "work_id" FROM "local_3"."chaptersSceneAboveTwoToThree"
UNION
SELECT "local_3"."chaptersSceneAboveThreeToSix"."chapterId" AS "id", "local_3"."chaptersSceneAboveThreeToSix"."actNumber" AS "Act", "local_3"."chaptersSceneAboveThreeToSix"."sceneNumber" AS "Scene", "local_3"."chaptersSceneAboveThreeToSix"."sceneDescription" AS "Description", "local_3"."chaptersSceneAboveThreeToSix"."workRefId" AS "work_id" FROM "local_3"."chaptersSceneAboveThreeToSix";

-- Reconstruct characters from row partitions (UNION (overlap))
CREATE VIEW "characters" AS
SELECT "local_2"."CharacterRosterEmptyDescription"."CharacterId" AS "id", "local_2"."CharacterRosterEmptyDescription"."CharacterName" AS "CharName", "local_2"."CharacterRosterEmptyDescription"."NameAbbreviation" AS "Abbrev", "local_2"."CharacterRosterEmptyDescription"."CharacterDescription" AS "Description" FROM "local_2"."CharacterRosterEmptyDescription"
UNION
SELECT "local_2"."CharacterRosterWithRoleCategories"."CharacterId" AS "id", "local_2"."CharacterRosterWithRoleCategories"."CharacterName" AS "CharName", "local_2"."CharacterRosterWithRoleCategories"."NameAbbreviation" AS "Abbrev", "local_2"."CharacterRosterWithRoleCategories"."RoleCategory" AS "Description" FROM "local_2"."CharacterRosterWithRoleCategories";

-- Reconstruct paragraphs from row partitions (UNION (overlap))
CREATE VIEW "paragraphs" AS
SELECT "local_1"."paragraphs_number_up_to_788"."paragraph_id" AS "id", "local_1"."paragraphs_number_up_to_788"."paragraph_number" AS "ParagraphNum", "local_1"."paragraphs_number_up_to_788"."plain_text" AS "PlainText", "local_1"."paragraphs_number_up_to_788"."character_ref_id" AS "character_id", "local_1"."paragraphs_number_up_to_788"."chapter_ref_id" AS "chapter_id" FROM "local_1"."paragraphs_number_up_to_788"
UNION
SELECT "local_1"."paragraphs_number_above_2340_or_null"."paragraph_id" AS "id", "local_1"."paragraphs_number_above_2340_or_null"."paragraph_number" AS "ParagraphNum", "local_1"."paragraphs_number_above_2340_or_null"."plain_text" AS "PlainText", "local_1"."paragraphs_number_above_2340_or_null"."character_ref_id" AS "character_id", "local_1"."paragraphs_number_above_2340_or_null"."chapter_ref_id" AS "chapter_id" FROM "local_1"."paragraphs_number_above_2340_or_null"
UNION
SELECT "local_2"."ParagraphsQuartileTwo789To1556"."ParagraphId" AS "id", "local_2"."ParagraphsQuartileTwo789To1556"."ParagraphNumber" AS "ParagraphNum", "local_2"."ParagraphsQuartileTwo789To1556"."TextContent" AS "PlainText", "local_2"."ParagraphsQuartileTwo789To1556"."CharacterReferenceId" AS "character_id", "local_2"."ParagraphsQuartileTwo789To1556"."ChapterReferenceId" AS "chapter_id" FROM "local_2"."ParagraphsQuartileTwo789To1556"
UNION
SELECT "local_2"."ParagraphsQuartileThree1557To2340"."ParagraphId" AS "id", "local_2"."ParagraphsQuartileThree1557To2340"."ParagraphNumber" AS "ParagraphNum", "local_2"."ParagraphsQuartileThree1557To2340"."TextContent" AS "PlainText", "local_2"."ParagraphsQuartileThree1557To2340"."CharacterReferenceId" AS "character_id", "local_2"."ParagraphsQuartileThree1557To2340"."ChapterReferenceId" AS "chapter_id" FROM "local_2"."ParagraphsQuartileThree1557To2340";

-- Reconstruct works from local_3.literaryWorks
CREATE VIEW "works" AS
SELECT
    "local_3"."literaryWorks"."workId" AS "id",
    "local_3"."literaryWorks"."shortTitle" AS "Title",
    "local_3"."literaryWorks"."fullTitle" AS "LongTitle",
    "local_3"."literaryWorks"."publicationYear" AS "Date",
    "local_3"."literaryWorks"."genre" AS "GenreType"
FROM "local_3"."literaryWorks";
