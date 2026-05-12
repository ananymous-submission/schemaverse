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