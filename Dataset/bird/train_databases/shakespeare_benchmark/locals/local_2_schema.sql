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