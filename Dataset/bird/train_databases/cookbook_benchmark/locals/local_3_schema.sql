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