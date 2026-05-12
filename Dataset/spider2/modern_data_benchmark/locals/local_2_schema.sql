CREATE TABLE "orderToppingExclusions" (
    "exclusionId" INTEGER,
    "orderReferenceId" INTEGER,
    "excludedToppingId" INTEGER,
    "exclusionCount" INTEGER
);

CREATE TABLE "toppingCatalog" (
    "toppingRefId" INTEGER,
    "toppingLabel" TEXT
);