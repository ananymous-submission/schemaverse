-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";

-- Reconstruct Ingredient from local_1.PantryIngredient
CREATE VIEW "Ingredient" AS
SELECT
    "local_1"."PantryIngredient"."IngredientId" AS "ingredient_id",
    "local_1"."PantryIngredient"."IngredientCategory" AS "category",
    "local_1"."PantryIngredient"."IngredientName" AS "name",
    "local_1"."PantryIngredient"."PluralForm" AS "plural"
FROM "local_1"."PantryIngredient";

-- Reconstruct Nutrition from vertical split + row partition on a fragment
CREATE VIEW "Nutrition" AS
SELECT t0.[recipe_uid], t0.[protein_grams], t0.[carbohydrates_grams], t0.[alcohol_grams], t1.[total_fat_grams], t0.[saturated_fat_grams], t0.[cholesterol_milligrams], t0.[sodium_milligrams], t0.[iron_milligrams], t0.[vitamin_c_amount], t0.[vitamin_a_amount], t0.[dietary_fiber_grams], t1.[pct_calories_from_carbs], t1.[pct_calories_from_fat], t1.[pct_calories_from_protein], t0.[calories_kcal]
FROM (
SELECT [nutrition_alcohol_fiber_le_0_34].[__orig_rowid] AS __orig_rowid, [local_2].[nutrition_alcohol_fiber_le_0_34].[recipe_uid], [local_2].[nutrition_alcohol_fiber_le_0_34].[protein_grams], [local_2].[nutrition_alcohol_fiber_le_0_34].[carbohydrates_grams], [local_2].[nutrition_alcohol_fiber_le_0_34].[alcohol_grams], [local_2].[nutrition_alcohol_fiber_le_0_34].[saturated_fat_grams], [local_2].[nutrition_alcohol_fiber_le_0_34].[cholesterol_milligrams], [local_2].[nutrition_alcohol_fiber_le_0_34].[sodium_milligrams], [local_2].[nutrition_alcohol_fiber_le_0_34].[iron_milligrams], [local_2].[nutrition_alcohol_fiber_le_0_34].[vitamin_c_amount], [local_2].[nutrition_alcohol_fiber_le_0_34].[vitamin_a_amount], [local_2].[nutrition_alcohol_fiber_le_0_34].[dietary_fiber_grams], [local_2].[nutrition_alcohol_fiber_le_0_34].[calories_kcal] FROM [local_2].[nutrition_alcohol_fiber_le_0_34]
UNION
SELECT [nutritionAlcoholFiber0_34To0_87].[__orig_rowid] AS __orig_rowid, [local_3].[nutritionAlcoholFiber0_34To0_87].[recipeId], [local_3].[nutritionAlcoholFiber0_34To0_87].[proteinGrams], [local_3].[nutritionAlcoholFiber0_34To0_87].[carbohydrateGrams], [local_3].[nutritionAlcoholFiber0_34To0_87].[alcoholGrams], [local_3].[nutritionAlcoholFiber0_34To0_87].[saturatedFatGrams], [local_3].[nutritionAlcoholFiber0_34To0_87].[cholesterolMg], [local_3].[nutritionAlcoholFiber0_34To0_87].[sodiumMg], [local_3].[nutritionAlcoholFiber0_34To0_87].[ironMg], [local_3].[nutritionAlcoholFiber0_34To0_87].[vitaminCUnits], [local_3].[nutritionAlcoholFiber0_34To0_87].[vitaminAUnits], [local_3].[nutritionAlcoholFiber0_34To0_87].[fiberGrams], [local_3].[nutritionAlcoholFiber0_34To0_87].[calorieCount] FROM [local_3].[nutritionAlcoholFiber0_34To0_87]
UNION
SELECT [nutritionAlcoholFiber0_87To1_58].[__orig_rowid] AS __orig_rowid, [local_3].[nutritionAlcoholFiber0_87To1_58].[recipeId], [local_3].[nutritionAlcoholFiber0_87To1_58].[proteinGrams], [local_3].[nutritionAlcoholFiber0_87To1_58].[carbohydrateGrams], [local_3].[nutritionAlcoholFiber0_87To1_58].[alcoholGrams], [local_3].[nutritionAlcoholFiber0_87To1_58].[saturatedFatGrams], [local_3].[nutritionAlcoholFiber0_87To1_58].[cholesterolMg], [local_3].[nutritionAlcoholFiber0_87To1_58].[sodiumMg], [local_3].[nutritionAlcoholFiber0_87To1_58].[ironMg], [local_3].[nutritionAlcoholFiber0_87To1_58].[vitaminCUnits], [local_3].[nutritionAlcoholFiber0_87To1_58].[vitaminAUnits], [local_3].[nutritionAlcoholFiber0_87To1_58].[fiberGrams], [local_3].[nutritionAlcoholFiber0_87To1_58].[calorieCount] FROM [local_3].[nutritionAlcoholFiber0_87To1_58]
UNION
SELECT [nutritionAlcoholFiberAbove1_58OrNull].[__orig_rowid] AS __orig_rowid, [local_3].[nutritionAlcoholFiberAbove1_58OrNull].[recipeId], [local_3].[nutritionAlcoholFiberAbove1_58OrNull].[proteinGrams], [local_3].[nutritionAlcoholFiberAbove1_58OrNull].[carbohydrateGrams], [local_3].[nutritionAlcoholFiberAbove1_58OrNull].[alcoholGrams], [local_3].[nutritionAlcoholFiberAbove1_58OrNull].[saturatedFatGrams], [local_3].[nutritionAlcoholFiberAbove1_58OrNull].[cholesterolMg], [local_3].[nutritionAlcoholFiberAbove1_58OrNull].[sodiumMg], [local_3].[nutritionAlcoholFiberAbove1_58OrNull].[ironMg], [local_3].[nutritionAlcoholFiberAbove1_58OrNull].[vitaminCUnits], [local_3].[nutritionAlcoholFiberAbove1_58OrNull].[vitaminAUnits], [local_3].[nutritionAlcoholFiberAbove1_58OrNull].[fiberGrams], [local_3].[nutritionAlcoholFiberAbove1_58OrNull].[calorieCount] FROM [local_3].[nutritionAlcoholFiberAbove1_58OrNull]
) t0
JOIN [local_2].[nutrition_alcohol_overview] t1 ON t0.[__orig_rowid] = t1.[__orig_rowid];

-- Reconstruct Quantity from row partitions (UNION (overlap))
CREATE VIEW "Quantity" AS
SELECT "local_1"."IngredientQuantityMaxQtyAtMostZeroPointFive"."QuantityId" AS "quantity_id", "local_1"."IngredientQuantityMaxQtyAtMostZeroPointFive"."RecipeId" AS "recipe_id", "local_1"."IngredientQuantityMaxQtyAtMostZeroPointFive"."IngredientId" AS "ingredient_id", "local_1"."IngredientQuantityMaxQtyAtMostZeroPointFive"."MaximumQuantity" AS "max_qty", "local_1"."IngredientQuantityMaxQtyAtMostZeroPointFive"."MinimumQuantity" AS "min_qty", "local_1"."IngredientQuantityMaxQtyAtMostZeroPointFive"."UnitName" AS "unit", "local_1"."IngredientQuantityMaxQtyAtMostZeroPointFive"."PreparationNotes" AS "preparation", "local_1"."IngredientQuantityMaxQtyAtMostZeroPointFive"."OptionalNote" AS "optional" FROM "local_1"."IngredientQuantityMaxQtyAtMostZeroPointFive"
UNION
SELECT "local_1"."IngredientQuantityMaxQtyGreaterThanTwoOrNull"."QuantityId" AS "quantity_id", "local_1"."IngredientQuantityMaxQtyGreaterThanTwoOrNull"."RecipeId" AS "recipe_id", "local_1"."IngredientQuantityMaxQtyGreaterThanTwoOrNull"."IngredientId" AS "ingredient_id", "local_1"."IngredientQuantityMaxQtyGreaterThanTwoOrNull"."MaximumQuantity" AS "max_qty", "local_1"."IngredientQuantityMaxQtyGreaterThanTwoOrNull"."MinimumQuantity" AS "min_qty", "local_1"."IngredientQuantityMaxQtyGreaterThanTwoOrNull"."UnitName" AS "unit", "local_1"."IngredientQuantityMaxQtyGreaterThanTwoOrNull"."PreparationNotes" AS "preparation", "local_1"."IngredientQuantityMaxQtyGreaterThanTwoOrNull"."OptionalNote" AS "optional" FROM "local_1"."IngredientQuantityMaxQtyGreaterThanTwoOrNull"
UNION
SELECT "local_3"."ingredientQuantityMax0_5To1_0"."quantityId" AS "quantity_id", "local_3"."ingredientQuantityMax0_5To1_0"."recipeId" AS "recipe_id", "local_3"."ingredientQuantityMax0_5To1_0"."ingredientId" AS "ingredient_id", "local_3"."ingredientQuantityMax0_5To1_0"."maxQuantity" AS "max_qty", "local_3"."ingredientQuantityMax0_5To1_0"."minQuantity" AS "min_qty", "local_3"."ingredientQuantityMax0_5To1_0"."measurementUnit" AS "unit", "local_3"."ingredientQuantityMax0_5To1_0"."preparationStyle" AS "preparation", "local_3"."ingredientQuantityMax0_5To1_0"."optionalNote" AS "optional" FROM "local_3"."ingredientQuantityMax0_5To1_0"
UNION
SELECT "local_3"."ingredientQuantityMax1_0To2_0"."quantityId" AS "quantity_id", "local_3"."ingredientQuantityMax1_0To2_0"."recipeId" AS "recipe_id", "local_3"."ingredientQuantityMax1_0To2_0"."ingredientId" AS "ingredient_id", "local_3"."ingredientQuantityMax1_0To2_0"."maxQuantity" AS "max_qty", "local_3"."ingredientQuantityMax1_0To2_0"."minQuantity" AS "min_qty", "local_3"."ingredientQuantityMax1_0To2_0"."measurementUnit" AS "unit", "local_3"."ingredientQuantityMax1_0To2_0"."preparationStyle" AS "preparation", "local_3"."ingredientQuantityMax1_0To2_0"."optionalNote" AS "optional" FROM "local_3"."ingredientQuantityMax1_0To2_0";

-- Reconstruct Recipe from vertical split + row partition on a fragment
CREATE VIEW "Recipe" AS
SELECT t0.[recipeId], t2.[titleText], t2.[subtitleText], t0.[servingsCount], t1.[YieldUnit], t0.[prepMinutes], t0.[cookMinutes], t0.[standardMinutes], t1.[SourceReference], t0.[overviewText], t0.[directionsText]
FROM [local_3].[recipeTimeOverview] t0
JOIN (
SELECT [RecipeDirectionsServingsGreaterThanFourUpToSix].[__orig_rowid] AS __orig_rowid, [local_1].[RecipeDirectionsServingsGreaterThanFourUpToSix].[RecipeId], [local_1].[RecipeDirectionsServingsGreaterThanFourUpToSix].[ServingsCount], [local_1].[RecipeDirectionsServingsGreaterThanFourUpToSix].[YieldUnit], [local_1].[RecipeDirectionsServingsGreaterThanFourUpToSix].[StandardMinutes], [local_1].[RecipeDirectionsServingsGreaterThanFourUpToSix].[SourceReference], [local_1].[RecipeDirectionsServingsGreaterThanFourUpToSix].[PreparationDirections] FROM [local_1].[RecipeDirectionsServingsGreaterThanFourUpToSix]
UNION
SELECT [RecipeDirectionsServingsUpToFour].[__orig_rowid] AS __orig_rowid, [local_1].[RecipeDirectionsServingsUpToFour].[RecipeId], [local_1].[RecipeDirectionsServingsUpToFour].[ServingsCount], [local_1].[RecipeDirectionsServingsUpToFour].[YieldUnit], [local_1].[RecipeDirectionsServingsUpToFour].[StandardMinutes], [local_1].[RecipeDirectionsServingsUpToFour].[SourceReference], [local_1].[RecipeDirectionsServingsUpToFour].[PreparationDirections] FROM [local_1].[RecipeDirectionsServingsUpToFour]
UNION
SELECT [recipeDirectionsServingsAbove6OrNull].[__orig_rowid] AS __orig_rowid, [local_3].[recipeDirectionsServingsAbove6OrNull].[recipeId], [local_3].[recipeDirectionsServingsAbove6OrNull].[servingsCount], [local_3].[recipeDirectionsServingsAbove6OrNull].[yieldUnit], [local_3].[recipeDirectionsServingsAbove6OrNull].[standardMinutes], [local_3].[recipeDirectionsServingsAbove6OrNull].[sourceAttribution], [local_3].[recipeDirectionsServingsAbove6OrNull].[stepDirections] FROM [local_3].[recipeDirectionsServingsAbove6OrNull]
) t1 ON t0.[__orig_rowid] = t1.[__orig_rowid]
JOIN [local_3].[recipeIntroduction] t2 ON t0.[__orig_rowid] = t2.[__orig_rowid];
