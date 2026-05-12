-- Consolidated local schemas
-- Generated from: /lustre06/project/6048152/mdaviran/data-integration/data-integration/BIRD/train_databases/cookbook/cookbook.sqlite
--
-- Each section below corresponds to one local_*.sqlite database.

-- ========================================================================
-- local_1
-- DDL file: local_1_schema.sql
-- ========================================================================

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

-- ========================================================================
-- local_2
-- DDL file: local_2_schema.sql
-- ========================================================================

CREATE TABLE "nutrition_alcohol_fiber_le_0_34" (
    "recipe_uid" INTEGER,
    "alcohol_grams" REAL,
    "calories_kcal" REAL,
    "carbohydrates_grams" REAL,
    "cholesterol_milligrams" REAL,
    "dietary_fiber_grams" REAL,
    "iron_milligrams" REAL,
    "protein_grams" REAL,
    "saturated_fat_grams" REAL,
    "sodium_milligrams" REAL,
    "vitamin_a_amount" REAL,
    "vitamin_c_amount" REAL
);

CREATE TABLE "nutrition_alcohol_overview" (
    "recipe_uid" INTEGER,
    "alcohol_grams" REAL,
    "calories_kcal" REAL,
    "carbohydrates_grams" REAL,
    "pct_calories_from_carbs" REAL,
    "pct_calories_from_fat" REAL,
    "pct_calories_from_protein" REAL,
    "protein_grams" REAL,
    "saturated_fat_grams" REAL,
    "sodium_milligrams" REAL,
    "total_fat_grams" REAL
);

-- ========================================================================
-- local_3
-- DDL file: local_3_schema.sql
-- ========================================================================

CREATE TABLE "recipeTimeOverview" (
    "recipeId" INTEGER,
    "cookMinutes" INTEGER,
    "directionsText" TEXT,
    "overviewText" TEXT,
    "prepMinutes" INTEGER,
    "servingsCount" INTEGER,
    "standardMinutes" INTEGER
);

CREATE TABLE "recipeIntroduction" (
    "recipeId" INTEGER,
    "introductionText" TEXT,
    "subtitleText" TEXT,
    "titleText" TEXT
);

CREATE TABLE "recipeDirectionsServingsAbove6OrNull" (
    "recipeId" INTEGER,
    "stepDirections" TEXT,
    "servingsCount" INTEGER,
    "sourceAttribution" TEXT,
    "standardMinutes" INTEGER,
    "yieldUnit" TEXT
);

CREATE TABLE "nutritionAlcoholFiber0_34To0_87" (
    "recipeId" INTEGER,
    "alcoholGrams" REAL,
    "calorieCount" REAL,
    "carbohydrateGrams" REAL,
    "cholesterolMg" REAL,
    "fiberGrams" REAL,
    "ironMg" REAL,
    "proteinGrams" REAL,
    "saturatedFatGrams" REAL,
    "sodiumMg" REAL,
    "vitaminAUnits" REAL,
    "vitaminCUnits" REAL,
    FOREIGN KEY ("recipeId") REFERENCES "recipeTimeOverview"("recipeId"),
    FOREIGN KEY ("recipeId") REFERENCES "recipeIntroduction"("recipeId")
);

CREATE TABLE "nutritionAlcoholFiber0_87To1_58" (
    "recipeId" INTEGER,
    "alcoholGrams" REAL,
    "calorieCount" REAL,
    "carbohydrateGrams" REAL,
    "cholesterolMg" REAL,
    "fiberGrams" REAL,
    "ironMg" REAL,
    "proteinGrams" REAL,
    "saturatedFatGrams" REAL,
    "sodiumMg" REAL,
    "vitaminAUnits" REAL,
    "vitaminCUnits" REAL,
    FOREIGN KEY ("recipeId") REFERENCES "recipeDirectionsServingsAbove6OrNull"("recipeId")
);

CREATE TABLE "nutritionAlcoholFiberAbove1_58OrNull" (
    "recipeId" INTEGER,
    "alcoholGrams" REAL,
    "calorieCount" REAL,
    "carbohydrateGrams" REAL,
    "cholesterolMg" REAL,
    "fiberGrams" REAL,
    "ironMg" REAL,
    "proteinGrams" REAL,
    "saturatedFatGrams" REAL,
    "sodiumMg" REAL,
    "vitaminAUnits" REAL,
    "vitaminCUnits" REAL,
    FOREIGN KEY ("recipeId") REFERENCES "recipeTimeOverview"("recipeId"),
    FOREIGN KEY ("recipeId") REFERENCES "recipeIntroduction"("recipeId")
);

CREATE TABLE "ingredientQuantityMax0_5To1_0" (
    "quantityId" INTEGER,
    "recipeId" INTEGER,
    "ingredientId" INTEGER,
    "maxQuantity" REAL,
    "minQuantity" REAL,
    "measurementUnit" TEXT,
    "preparationStyle" TEXT,
    "optionalNote" TEXT
);

CREATE TABLE "ingredientQuantityMax1_0To2_0" (
    "quantityId" INTEGER,
    "recipeId" INTEGER,
    "ingredientId" INTEGER,
    "maxQuantity" REAL,
    "minQuantity" REAL,
    "measurementUnit" TEXT,
    "preparationStyle" TEXT,
    "optionalNote" TEXT,
    FOREIGN KEY ("recipeId") REFERENCES "nutritionAlcoholFiber0_34To0_87"("recipeId"),
    FOREIGN KEY ("recipeId") REFERENCES "nutritionAlcoholFiber0_87To1_58"("recipeId"),
    FOREIGN KEY ("recipeId") REFERENCES "nutritionAlcoholFiberAbove1_58OrNull"("recipeId"),
    FOREIGN KEY ("recipeId") REFERENCES "recipeTimeOverview"("recipeId")
);

