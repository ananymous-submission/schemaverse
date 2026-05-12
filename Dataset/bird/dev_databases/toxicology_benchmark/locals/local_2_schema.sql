CREATE TABLE "singleBonds" (
    "bondId" TEXT,
    "moleculeId" TEXT DEFAULT NULL,
    "bondType" TEXT DEFAULT NULL,
    FOREIGN KEY ("moleculeId") REFERENCES "moleculesWithPlusLabel"("moleculeId")
);

CREATE TABLE "carbonAtoms" (
    "atomId" TEXT,
    "moleculeId" TEXT DEFAULT NULL,
    "elementSymbol" TEXT DEFAULT NULL
);

CREATE TABLE "moleculesWithPlusLabel" (
    "moleculeId" TEXT,
    "moleculeLabel" TEXT DEFAULT NULL
);