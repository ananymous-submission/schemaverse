SELECT T1.title FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id ORDER BY T2.total_fat DESC LIMIT 1;

SELECT T2.total_fat - T2.sat_fat FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id WHERE T1.title = 'Raspberry Chiffon Pie';

SELECT T1.title FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id WHERE T2.sodium < 5;

SELECT T1.title FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id WHERE T2.iron > 20;

SELECT DISTINCT CASE WHEN CASE WHEN T2.title = 'Raspberry Chiffon Pie' THEN T1.vitamin_c END > CASE WHEN T2.title = 'Fresh Apricot Bavarian' THEN T1.vitamin_c END THEN 'Raspberry Chiffon Pie' ELSE 'Fresh Apricot Bavarian' END AS "vitamin_c is higher" FROM Nutrition T1 INNER JOIN Recipe T2 ON T2.recipe_id = T1.recipe_id;

SELECT T1.title FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id WHERE T1.prep_min > 10 ORDER BY T2.calories DESC LIMIT 1;

SELECT T2.calories FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id WHERE T1.title = 'Raspberry Chiffon Pie';

SELECT T2.optional FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id INNER JOIN Ingredient AS T3 ON T3.ingredient_id = T2.ingredient_id WHERE T1.title = 'Raspberry Chiffon Pie' AND T3.name = 'graham cracker crumbs';

SELECT COUNT(*) FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id WHERE T1.title = 'Raspberry Chiffon Pie' AND T2.max_qty = T2.min_qty;

SELECT T3.name FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id INNER JOIN Ingredient AS T3 ON T3.ingredient_id = T2.ingredient_id WHERE T1.title = 'Raspberry Chiffon Pie' AND T2.preparation IS NULL;

SELECT COUNT(*) FROM Ingredient AS T1 INNER JOIN Quantity AS T2 ON T1.ingredient_id = T2.ingredient_id WHERE T1.name = 'graham cracker crumbs';

SELECT T2.min_qty FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id INNER JOIN Ingredient AS T3 ON T3.ingredient_id = T2.ingredient_id WHERE T1.title = 'Raspberry Chiffon Pie' AND T3.name = 'graham cracker crumbs';

SELECT T2.calories * T2.pcnt_cal_fat FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id WHERE T1.title = 'Raspberry Chiffon Pie';

SELECT AVG(T2.calories) FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id WHERE T1.source = 'Produce for Better Health Foundation and 5 a Day';

SELECT T2.calories FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id WHERE T1.title = 'Turkey Tenderloin Bundles';

SELECT COUNT(*) FROM Ingredient AS T1 INNER JOIN Quantity AS T2 ON T1.ingredient_id = T2.ingredient_id WHERE T1.name = '1% lowfat milk' AND T2.unit = 'cup(s)' AND T2.recipe_id = 1436;

SELECT T1.title FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id ORDER BY T2.total_fat DESC LIMIT 1;

SELECT COUNT(*) FROM Ingredient AS T1 INNER JOIN Quantity AS T2 ON T1.ingredient_id = T2.ingredient_id WHERE T1.name = 'seedless red grapes';

SELECT T1.name FROM Ingredient AS T1 INNER JOIN Quantity AS T2 ON T1.ingredient_id = T2.ingredient_id WHERE T2.recipe_id = 1397 AND T2.optional = 'TRUE';

SELECT T1.title FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id INNER JOIN Ingredient AS T3 ON T3.ingredient_id = T2.ingredient_id WHERE T3.name = 'frozen raspberries in light syrup' AND T2.max_qty = T2.min_qty;

SELECT T1.name FROM Ingredient AS T1 INNER JOIN Quantity AS T2 ON T1.ingredient_id = T2.ingredient_id GROUP BY T1.name ORDER BY COUNT(T1.name) DESC LIMIT 1;

SELECT T2.preparation FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id INNER JOIN Ingredient AS T3 ON T3.ingredient_id = T2.ingredient_id WHERE T1.title = 'Raspberry-Pear Couscous Cake' AND T3.name = 'apple juice';

SELECT COUNT(*) FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id INNER JOIN Ingredient AS T3 ON T3.ingredient_id = T2.ingredient_id WHERE T1.title = 'Chicken Pocket Sandwich' AND T3.name = 'almonds' AND T2.unit = 'cup(s)';

SELECT T1.title FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id ORDER BY T2.vitamin_c DESC LIMIT 1;

SELECT T2.vitamin_a FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id WHERE T1.title = 'Sherried Beef';

SELECT T1.title FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id GROUP BY T1.title ORDER BY COUNT(title) DESC LIMIT 1;

SELECT CAST(SUM(CASE WHEN T1.title = 'Lasagne-Spinach Spirals' THEN T2.sodium ELSE 0 END) AS REAL) * 100 / SUM(CASE WHEN T1.title = 'Beef and Spinach Pita Pockets' THEN T2.sodium ELSE 0 END) FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id;

SELECT AVG(T3.calories) FROM Ingredient AS T1 INNER JOIN Quantity AS T2 ON T2.ingredient_id = T1.ingredient_id INNER JOIN Nutrition AS T3 ON T3.recipe_id = T2.recipe_id WHERE T1.name = 'coarsely ground black pepper';

SELECT T1.title FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id WHERE T2.iron > 20;

SELECT COUNT(*) FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id WHERE T1.title = 'Apricot Yogurt Parfaits';

SELECT T1.name FROM Ingredient AS T1 INNER JOIN Quantity AS T2 ON T1.ingredient_id = T2.ingredient_id WHERE T2.preparation = 'cooked in beef broth';

SELECT COUNT(*) FROM Nutrition AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id WHERE T1.vitamin_a > 0;

SELECT T1.title FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id ORDER BY T2.vitamin_c DESC LIMIT 5;

SELECT T1.name FROM Ingredient AS T1 INNER JOIN Quantity AS T2 ON T1.ingredient_id = T2.ingredient_id GROUP BY T2.ingredient_id ORDER BY COUNT(T2.ingredient_id) ASC LIMIT 1;

SELECT COUNT(*) FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id INNER JOIN Ingredient AS T3 ON T3.ingredient_id = T2.ingredient_id WHERE T3.category = 'baking products' AND T1.title = 'No-Bake Chocolate Cheesecake';

SELECT T3.name FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id INNER JOIN Ingredient AS T3 ON T3.ingredient_id = T2.ingredient_id WHERE T1.title = 'Strawberry Sorbet';

SELECT T3.name FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id INNER JOIN Ingredient AS T3 ON T3.ingredient_id = T2.ingredient_id WHERE T1.title = 'Warm Chinese Chicken Salad' AND T2.optional = 'TRUE';

SELECT T1.title FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id WHERE T2.alcohol > 10 ORDER BY T1.prep_min DESC LIMIT 1;

SELECT COUNT(T1.title) FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id ORDER BY T2.total_fat - T2.sat_fat DESC LIMIT 1;

SELECT T1.title FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id WHERE T1.source = 'National Potato Board' ORDER BY T2.calories DESC LIMIT 1;

SELECT T2.recipe_id, T1.prep_min + T1.cook_min + T1.stnd_min FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id GROUP BY T2.recipe_id ORDER BY COUNT(T2.ingredient_id) DESC LIMIT 1;

SELECT T1.name, CAST(COUNT(T2.ingredient_id) AS FLOAT) * 100 / ( SELECT COUNT(T2.ingredient_id) FROM Ingredient AS T1 INNER JOIN Quantity AS T2 ON T2.ingredient_id = T1.ingredient_id ) AS "percentage" FROM Ingredient AS T1 INNER JOIN Quantity AS T2 ON T2.ingredient_id = T1.ingredient_id GROUP BY T2.ingredient_id ORDER BY COUNT(T2.ingredient_id) DESC LIMIT 1;

SELECT T1.title, T1.prep_min + T1.cook_min + T1.stnd_min FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id ORDER BY T2.total_fat DESC LIMIT 1;

SELECT T1.title FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id INNER JOIN Ingredient AS T3 ON T3.ingredient_id = T2.ingredient_id WHERE T3.name = 'almond extract';

SELECT T3.name FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id INNER JOIN Ingredient AS T3 ON T3.ingredient_id = T2.ingredient_id WHERE T1.title = 'Tomato-Cucumber Relish';

SELECT COUNT(*) FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id WHERE T1.title = 'Idaho Potato Supreme';

SELECT T1.name FROM Ingredient AS T1 INNER JOIN Quantity AS T2 ON T1.ingredient_id = T2.ingredient_id INNER JOIN Nutrition AS T3 ON T3.recipe_id = T2.recipe_id WHERE T2.max_qty = T2.min_qty ORDER BY T3.carbo DESC LIMIT 1;

SELECT T1.title FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id WHERE T2.iron > 20;

SELECT T1.name FROM Ingredient AS T1 INNER JOIN Quantity AS T2 ON T1.ingredient_id = T2.ingredient_id INNER JOIN Nutrition AS T3 ON T3.recipe_id = T2.recipe_id ORDER BY T3.vitamin_a DESC LIMIT 1;

SELECT T3.name, T2.max_qty FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id INNER JOIN Ingredient AS T3 ON T3.ingredient_id = T2.ingredient_id WHERE T1.servings = 7;

SELECT CAST(SUM(CASE WHEN T2.sodium < 5 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id WHERE T1.source = 'The California Tree Fruit Agreement';

SELECT T1.name FROM Ingredient AS T1 INNER JOIN Quantity AS T2 ON T1.ingredient_id = T2.ingredient_id WHERE T2.unit = 'slice(s)';

SELECT COUNT(*) FROM Ingredient AS T1 INNER JOIN Quantity AS T2 ON T1.ingredient_id = T2.ingredient_id WHERE T1.category = 'canned dairy';

SELECT T1.title, T1.prep_min + T1.cook_min + T1.stnd_min FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id INNER JOIN Ingredient AS T3 ON T3.ingredient_id = T2.ingredient_id WHERE T3.name = 'lima beans';

SELECT CAST(SUM(CASE WHEN T1.servings >= 10 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id INNER JOIN Ingredient AS T3 ON T3.ingredient_id = T2.ingredient_id WHERE T3.name = 'sea bass steak';

SELECT T2.total_fat FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id WHERE T1.title = 'Raspberry Chiffon Pie';

SELECT pcnt_cal_prot FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id WHERE T1.title = 'Raspberry Chiffon Pie';

SELECT COUNT(*) FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id INNER JOIN Ingredient AS T3 ON T3.ingredient_id = T2.ingredient_id WHERE T1.title = 'Raspberry Chiffon Pie';

SELECT T1.title FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id WHERE T2.alcohol = 0;

SELECT AVG(T1.vitamin_c) FROM Nutrition AS T1 INNER JOIN Recipe AS T2 ON T2.recipe_id = T1.recipe_id WHERE T2.title LIKE '%cake%';

SELECT COUNT(*) FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id INNER JOIN Ingredient AS T3 ON T3.ingredient_id = T2.ingredient_id WHERE T3.category = 'dairy' AND T1.servings > 10;

SELECT T1.title FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id WHERE T2.iron > 20;

SELECT T1.title FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id ORDER BY T2.calories DESC LIMIT 1;

SELECT COUNT(T2.recipe_id) FROM Ingredient AS T1 INNER JOIN Quantity AS T2 ON T2.ingredient_id = T1.ingredient_id INNER JOIN Nutrition AS T3 ON T3.recipe_id = T2.recipe_id WHERE T1.category NOT LIKE '%dairy%';

SELECT T3.name, T3.category FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id INNER JOIN Ingredient AS T3 ON T3.ingredient_id = T2.ingredient_id WHERE T1.title = 'Apricot Yogurt Parfaits';

SELECT T1.title FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id WHERE T2.max_qty <> T2.min_qty;

SELECT T3.name FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id INNER JOIN Ingredient AS T3 ON T3.ingredient_id = T2.ingredient_id ORDER BY T1.cook_min DESC LIMIT 1;

SELECT CAST(SUM(CASE WHEN T1.cook_min < 20 AND T2.cholestrl = 0 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM Recipe AS T1 INNER JOIN Nutrition AS T2 ON T1.recipe_id = T2.recipe_id;

SELECT CAST(SUM(CASE WHEN T4.calories > 200 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM Recipe AS T1 INNER JOIN Quantity AS T2 ON T1.recipe_id = T2.recipe_id INNER JOIN Ingredient AS T3 ON T3.ingredient_id = T2.ingredient_id INNER JOIN Nutrition AS T4 ON T4.recipe_id = T1.recipe_id WHERE T3.category = 'cheese';

