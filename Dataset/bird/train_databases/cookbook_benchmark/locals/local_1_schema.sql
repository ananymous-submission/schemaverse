CREATE TABLE "PantryIngredient" (
    "IngredientId" INTEGER,
    "IngredientCategory" TEXT,
    "IngredientName" TEXT,
    "PluralForm" TEXT
);

CREATE TABLE "IngredientQuantityMaxQtyAtMostZeroPointFive" (
    "QuantityId" INTEGER,
    "RecipeId" INTEGER,
    "IngredientId" INTEGER,
    "MaximumQuantity" REAL,
    "MinimumQuantity" REAL,
    "UnitName" TEXT,
    "PreparationNotes" TEXT,
    "OptionalNote" TEXT,
    FOREIGN KEY ("IngredientId") REFERENCES "PantryIngredient"("IngredientId"),
    FOREIGN KEY ("RecipeId") REFERENCES "RecipeDirectionsServingsUpToFour"("RecipeId"),
    FOREIGN KEY ("RecipeId") REFERENCES "RecipeDirectionsServingsGreaterThanFourUpToSix"("RecipeId")
);

CREATE TABLE "IngredientQuantityMaxQtyGreaterThanTwoOrNull" (
    "QuantityId" INTEGER,
    "RecipeId" INTEGER,
    "IngredientId" INTEGER,
    "MaximumQuantity" REAL,
    "MinimumQuantity" REAL,
    "UnitName" TEXT,
    "PreparationNotes" TEXT,
    "OptionalNote" TEXT,
    FOREIGN KEY ("IngredientId") REFERENCES "PantryIngredient"("IngredientId")
);

CREATE TABLE "RecipeDirectionsServingsUpToFour" (
    "RecipeId" INTEGER,
    "PreparationDirections" TEXT,
    "ServingsCount" INTEGER,
    "SourceReference" TEXT,
    "StandardMinutes" INTEGER,
    "YieldUnit" TEXT
);

CREATE TABLE "RecipeDirectionsServingsGreaterThanFourUpToSix" (
    "RecipeId" INTEGER,
    "PreparationDirections" TEXT,
    "ServingsCount" INTEGER,
    "SourceReference" TEXT,
    "StandardMinutes" INTEGER,
    "YieldUnit" TEXT
);