SELECT COUNT(*) FROM Dish WHERE first_appeared < 1851 OR first_appeared > 2012;

SELECT CASE WHEN SUM(CASE WHEN name = 'Anchovies' THEN last_appeared - first_appeared ELSE 0 END) - SUM(CASE WHEN name = 'Fresh lobsters in every style' THEN last_appeared - first_appeared ELSE 0 END) > 0 THEN 'Anchovies' ELSE 'Fresh lobsters in every style' END FROM Dish WHERE name IN ('Fresh lobsters in every style', 'Anchovies');

SELECT name FROM Dish WHERE lowest_price = 0 ORDER BY menus_appeared DESC LIMIT 1;

SELECT COUNT(*) FROM Menu WHERE name = 'Waldorf Astoria' AND page_count = 4;

SELECT T1.name FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id WHERE T2.menu_page_id = 1389 AND T2.xpos < 0.25 AND T2.ypos < 0.25;

SELECT T2.price FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id WHERE T1.name = 'Clear green turtle';

SELECT SUM(CASE WHEN T1.name = 'Clear green turtle' THEN 1 ELSE 0 END) FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id WHERE T1.highest_price IS NULL;

SELECT T2.price FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id WHERE T1.name = 'Clear green turtle' ORDER BY T2.price DESC LIMIT 1;

SELECT T1.menu_id FROM MenuPage AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.menu_page_id INNER JOIN Dish AS T3 ON T2.dish_id = T3.id WHERE T3.name = 'Clear green turtle';

SELECT SUM(CASE WHEN T3.currency = 'Dollars' THEN 1 ELSE 0 END) FROM MenuItem AS T1 INNER JOIN MenuPage AS T2 ON T1.menu_page_id = T2.id INNER JOIN Menu AS T3 ON T2.menu_id = T3.id INNER JOIN Dish AS T4 ON T1.dish_id = T4.id WHERE T4.name = 'Clear green turtle';

SELECT SUM(CASE WHEN T4.name = 'Clear green turtle' THEN 1 ELSE 0 END) FROM MenuItem AS T1 INNER JOIN MenuPage AS T2 ON T1.menu_page_id = T2.id INNER JOIN Menu AS T3 ON T2.menu_id = T3.id INNER JOIN Dish AS T4 ON T1.dish_id = T4.id WHERE T3.call_number IS NULL;

SELECT T4.name FROM MenuItem AS T1 INNER JOIN MenuPage AS T2 ON T1.menu_page_id = T2.id INNER JOIN Menu AS T3 ON T2.menu_id = T3.id INNER JOIN Dish AS T4 ON T1.dish_id = T4.id WHERE T3.name = 'Zentral Theater Terrace';

SELECT T4.name FROM MenuItem AS T1 INNER JOIN MenuPage AS T2 ON T1.menu_page_id = T2.id INNER JOIN Menu AS T3 ON T2.menu_id = T3.id INNER JOIN Dish AS T4 ON T1.dish_id = T4.id WHERE T3.name = 'Zentral Theater Terrace' ORDER BY T1.price DESC LIMIT 1;

SELECT SUM(CASE WHEN T3.name = 'Zentral Theater Terrace' THEN 1 ELSE 0 END) FROM MenuItem AS T1 INNER JOIN MenuPage AS T2 ON T1.menu_page_id = T2.id INNER JOIN Menu AS T3 ON T2.menu_id = T3.id;

SELECT SUM(CASE WHEN T3.name = 'Waldorf Astoria' THEN 1 ELSE 0 END) FROM MenuItem AS T1 INNER JOIN MenuPage AS T2 ON T1.menu_page_id = T2.id INNER JOIN Menu AS T3 ON T2.menu_id = T3.id;

SELECT T2.menu_id FROM MenuItem AS T1 INNER JOIN MenuPage AS T2 ON T1.menu_page_id = T2.id INNER JOIN Menu AS T3 ON T2.menu_id = T3.id INNER JOIN Dish AS T4 ON T1.dish_id = T4.id WHERE T4.name = 'Clear green turtle' AND T3.sponsor IS NULL;

SELECT AVG(T1.page_number) FROM MenuPage AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.menu_page_id INNER JOIN Dish AS T3 ON T2.dish_id = T3.id WHERE T3.name = 'Clear green turtle';

SELECT SUM(T1.price) / COUNT(T1.price) FROM MenuItem AS T1 INNER JOIN MenuPage AS T2 ON T1.menu_page_id = T2.id INNER JOIN Menu AS T3 ON T2.menu_id = T3.id WHERE T3.name = 'Zentral Theater Terrace';

SELECT COUNT(*) FROM MenuItem WHERE created_at LIKE '2011-03-28%';

SELECT COUNT(*) FROM MenuItem WHERE menu_page_id = 144;

SELECT COUNT(*) FROM Menu WHERE location = 'Dutcher House';

SELECT COUNT(*) FROM Dish WHERE times_appeared > menus_appeared;

SELECT COUNT(*) FROM Menu WHERE venue = 'STEAMSHIP';

SELECT SUM(CASE WHEN T1.date = '1898-11-17' THEN 1 ELSE 0 END) FROM Menu AS T1 INNER JOIN MenuPage AS T2 ON T1.id = T2.menu_id;

SELECT T2.name FROM MenuItem AS T1 INNER JOIN Dish AS T2 ON T2.id = T1.dish_id WHERE T1.menu_page_id = 174;

SELECT T2.name, T1.dish_id FROM MenuItem AS T1 INNER JOIN Dish AS T2 ON T2.id = T1.dish_id WHERE T2.first_appeared = 1861;

SELECT T1.name, T2.price FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id WHERE T2.created_at LIKE '2011-05-23%' ORDER BY T2.price DESC LIMIT 1;

SELECT T3.name FROM MenuPage AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.menu_page_id INNER JOIN Dish AS T3 ON T2.dish_id = T3.id WHERE T1.page_number = 30 ORDER BY T1.full_height DESC, T1.full_height ASC LIMIT 1;

SELECT T1.page_number, T2.name FROM MenuPage AS T1 INNER JOIN Menu AS T2 ON T2.id = T1.menu_id ORDER BY T2.page_count DESC LIMIT 1;

SELECT COUNT(T1.dish_id) FROM MenuItem AS T1 INNER JOIN MenuPage AS T2 ON T1.menu_page_id = T2.id INNER JOIN Menu AS T3 ON T2.menu_id = T3.id WHERE T2.page_number = 2 GROUP BY T3.name ORDER BY T3.dish_count DESC LIMIT 1;

SELECT T2.menu_id, T1.xpos, T1.ypos FROM MenuItem AS T1 INNER JOIN MenuPage AS T2 ON T1.menu_page_id = T2.id INNER JOIN Menu AS T3 ON T2.menu_id = T3.id INNER JOIN Dish AS T4 ON T1.dish_id = T4.id WHERE T4.name = 'Fresh lobsters in every style';

SELECT T4.name FROM MenuItem AS T1 INNER JOIN MenuPage AS T2 ON T1.menu_page_id = T2.id INNER JOIN Menu AS T3 ON T2.menu_id = T3.id INNER JOIN Dish AS T4 ON T1.dish_id = T4.id WHERE T3.sponsor = 'CHAS.BRADLEY''S OYSTER & DINING ROOM' AND T1.xpos < 0.25 AND T1.ypos < 0.25;

SELECT T3.name, T3.event FROM MenuItem AS T1 INNER JOIN MenuPage AS T2 ON T1.menu_page_id = T2.id INNER JOIN Menu AS T3 ON T2.menu_id = T3.id INNER JOIN Dish AS T4 ON T1.dish_id = T4.id WHERE T4.name = 'Cerealine with Milk';

SELECT CAST(SUM(CASE WHEN T2.xpos BETWEEN 0.25 AND 0.75 AND T2.ypos BETWEEN 0.25 AND 0.75 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.id) FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id WHERE T1.name LIKE '%BLuefish%';

SELECT sponsor FROM Menu WHERE id = 12463;

SELECT event FROM Menu WHERE sponsor = 'REPUBLICAN HOUSE';

SELECT location FROM Menu WHERE id = 12472;

SELECT physical_description FROM Menu WHERE sponsor = 'Noviomagus';

SELECT occasion FROM Menu WHERE id = 12463;

SELECT location FROM Menu WHERE sponsor = 'Norddeutscher Lloyd Bremen';

SELECT T2.id FROM MenuPage AS T1 INNER JOIN Menu AS T2 ON T2.id = T1.menu_id WHERE T2.sponsor = 'Occidental & Oriental';

SELECT T1.image_id FROM MenuPage AS T1 INNER JOIN Menu AS T2 ON T2.id = T1.menu_id WHERE T2.location = 'Manhattan Hotel';

SELECT T1.full_height, T1.full_width FROM MenuPage AS T1 INNER JOIN Menu AS T2 ON T2.id = T1.menu_id WHERE T2.name = 'El Fuerte Del Palmar';

SELECT CASE WHEN T2.uuid = 'c02c9a3b-6881-7080-e040-e00a180631aa' THEN 'yes' ELSE 'no' END AS yn FROM Menu AS T1 INNER JOIN MenuPage AS T2 ON T1.id = T2.menu_id WHERE T1.name = 'The Biltmore' AND T2.uuid = 'c02c9a3b-6881-7080-e040-e00a180631aa';

SELECT T2.name FROM MenuPage AS T1 INNER JOIN Menu AS T2 ON T2.id = T1.menu_id ORDER BY T1.full_height DESC LIMIT 1;

SELECT T1.page_count FROM Menu AS T1 INNER JOIN MenuPage AS T2 ON T1.id = T2.menu_id WHERE T2.id = 130;

SELECT T3.price FROM Menu AS T1 INNER JOIN MenuPage AS T2 ON T1.id = T2.menu_id INNER JOIN MenuItem AS T3 ON T2.id = T3.menu_page_id WHERE T2.image_id = 4000009194;

SELECT T2.page_number FROM Menu AS T1 INNER JOIN MenuPage AS T2 ON T1.id = T2.menu_id INNER JOIN MenuItem AS T3 ON T2.id = T3.menu_page_id WHERE T3.xpos > 0.75 AND T3.ypos < 0.25;

SELECT T2.name FROM MenuItem AS T1 INNER JOIN Dish AS T2 ON T2.id = T1.dish_id WHERE SUBSTR(T1.created_at, 7, 1) = '4';

SELECT T2.name FROM MenuItem AS T1 INNER JOIN Dish AS T2 ON T2.id = T1.dish_id WHERE T1.menu_page_id = 1389;

SELECT T2.price FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id WHERE T2.id BETWEEN 1 AND 5 ORDER BY T2.price DESC LIMIT 1;

SELECT T1.name FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id WHERE T2.xpos < 0.25 AND T2.ypos < 0.25;

SELECT SUM(CASE WHEN T2.uuid = '510d47e4-2958-a3d9-e040-e00a18064a99' THEN T1.dish_count ELSE 0 END) - SUM(CASE WHEN T2.uuid = '510d47e4-295a-a3d9-e040-e00a18064a99' THEN T1.dish_count ELSE 0 END) FROM Menu AS T1 INNER JOIN MenuPage AS T2 ON T1.id = T2.menu_id;

SELECT SUM(T2.price) FROM MenuPage AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.menu_page_id WHERE T1.menu_id = 12882;

SELECT name FROM Dish ORDER BY highest_price DESC LIMIT 5;

SELECT COUNT(*) FROM Dish WHERE lowest_price = 0;

SELECT name FROM Dish WHERE first_appeared = 1855 AND last_appeared = 1900;

SELECT name FROM Menu GROUP BY name ORDER BY dish_count DESC LIMIT 10;

SELECT COUNT(*) FROM MenuItem AS T1 INNER JOIN Dish AS T2 ON T1.dish_id = T2.id WHERE T1.xpos > 0.75 AND T1.ypos < 0.25;

SELECT T1.last_appeared - T1.first_appeared, T2.updated_at FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id WHERE T1.name = 'Clear green turtle';

SELECT T1.name FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id WHERE T1.last_appeared - T1.first_appeared > 100;

SELECT COUNT(*) FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id WHERE T1.last_appeared - T1.first_appeared < 5;

SELECT T2.name, T1.price FROM MenuItem AS T1 INNER JOIN Dish AS T2 ON T2.id = T1.dish_id WHERE T2.lowest_price = 0;

SELECT T1.price FROM MenuItem AS T1 INNER JOIN MenuPage AS T2 ON T2.id = T1.menu_page_id WHERE T2.menu_id = 12474 AND T2.page_number = 2;

SELECT SUM(CASE WHEN T2.created_at BETWEEN '2011-03-31 20:24:46 UTC' AND '2011-04-15 23:09:51 UTC' THEN 1 ELSE 0 END) FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id;

SELECT T2.sponsor FROM MenuPage AS T1 INNER JOIN Menu AS T2 ON T2.id = T1.menu_id WHERE T1.full_height = 10000;

SELECT T1.image_id, T1.full_height, T1.full_width FROM MenuPage AS T1 INNER JOIN Menu AS T2 ON T2.id = T1.menu_id WHERE T2.event = '100TH ANNIVERSARY OF BIRTH OF DANIEL WEBSTER';

SELECT T1.event FROM Menu AS T1 INNER JOIN MenuPage AS T2 ON T1.id = T2.menu_id WHERE T2.full_width = 2000;

SELECT T1.name FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id WHERE T2.price = 180000;

SELECT T2.xpos, T2.ypos, T1.last_appeared - T1.first_appeared FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id WHERE T1.name = 'Small Hominy';

SELECT T1.full_height * T1.full_width, T1.page_number, T1.image_id FROM MenuPage AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.menu_page_id INNER JOIN Dish AS T3 ON T2.dish_id = T3.id WHERE T3.name = 'Baked Stuffed Mullet & Sauce Pomard';

SELECT COUNT(*) FROM Dish WHERE times_appeared > Dish.menus_appeared;

SELECT COUNT(*) FROM Menu WHERE date LIKE '2015-04%' AND sponsor = 'Krogs Fiskerestaurant';

SELECT name FROM Dish ORDER BY last_appeared - Dish.first_appeared DESC LIMIT 1;

SELECT event FROM Menu WHERE date = '1887-07-21' AND id = 21380;

SELECT SUM(CASE WHEN T1.name = 'Emil Kuehn' THEN 1 ELSE 0 END) FROM Menu AS T1 INNER JOIN MenuPage AS T2 ON T1.id = T2.menu_id;

SELECT SUM(CASE WHEN T1.name = 'Puree of split peas aux croutons' THEN 1 ELSE 0 END) FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id;

SELECT T1.name FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id WHERE SUBSTR(T2.created_at, 1, 4) = '2011' AND SUBSTR(T2.created_at, 7, 1) = '4' AND T1.highest_price IS NULL;

SELECT T1.name FROM Menu AS T1 INNER JOIN MenuPage AS T2 ON T1.id = T2.menu_id GROUP BY T2.menu_id ORDER BY COUNT(T2.page_number) DESC LIMIT 1;

SELECT T2.menu_page_id FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id WHERE T1.name = 'Mashed potatoes';

SELECT COUNT(*) FROM Menu AS T1 INNER JOIN MenuPage AS T2 ON T1.id = T2.menu_id WHERE T1.sponsor = 'PACIFIC MAIL STEAMSHIP COMPANY' GROUP BY T2.menu_id HAVING COUNT(T2.page_number) <= 2;

SELECT T1.menu_page_id FROM MenuItem AS T1 INNER JOIN Dish AS T2 ON T2.id = T1.dish_id WHERE T2.name = 'Milk' ORDER BY T1.price DESC LIMIT 1;

SELECT T2.menu_id FROM Menu AS T1 INNER JOIN MenuPage AS T2 ON T1.id = T2.menu_id WHERE T1.sponsor = 'OCCIDENTAL & ORIENTAL STEAMSHIP COMPANY' GROUP BY T2.menu_id ORDER BY COUNT(T2.page_number) DESC LIMIT 1;

SELECT T2.xpos, T2.ypos FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id WHERE T1.name = 'breaded veal cutlet with peas';

SELECT T2.name FROM MenuItem AS T1 INNER JOIN Dish AS T2 ON T2.id = T1.dish_id WHERE T1.xpos > 0.75 AND T1.ypos > 0.75 AND T1.menu_page_id = 48706;

SELECT T4.name FROM Menu AS T1 INNER JOIN MenuPage AS T2 ON T1.id = T2.menu_id INNER JOIN MenuItem AS T3 ON T2.id = T3.menu_page_id INNER JOIN Dish AS T4 ON T3.dish_id = T4.id WHERE T1.sponsor = 'THE SOCIETY OF THE CUMBERLAND' AND T1.event = '19NTH REUNION' AND T1.place = 'GRAND PACIFIC HOTEL,CHICAGO,ILL';

SELECT T4.sponsor FROM MenuPage AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.menu_page_id INNER JOIN Dish AS T3 ON T2.dish_id = T3.id INNER JOIN Menu AS T4 ON T4.id = T1.menu_id WHERE T3.name = 'Baked apples with cream' AND T3.id = 107 ORDER BY T2.price DESC LIMIT 1;

SELECT COUNT(*), T1.dish_id FROM MenuItem AS T1 INNER JOIN MenuPage AS T2 ON T1.menu_page_id = T2.id INNER JOIN Menu AS T3 ON T2.menu_id = T3.id INNER JOIN Dish AS T4 ON T1.dish_id = T4.id WHERE T3.name = 'Souper de Luxe' GROUP BY T3.id ORDER BY COUNT(T1.dish_id) DESC LIMIT 1;

SELECT id FROM Menu WHERE sponsor IS NULL;

SELECT COUNT(*) FROM Menu WHERE event = 'LUNCH';

SELECT COUNT(*) FROM Menu WHERE page_count > 10 AND dish_count > 20;

SELECT id FROM Menu ORDER BY dish_count DESC LIMIT 1;

SELECT COUNT(*) FROM Menu WHERE name = 'Zentral Theater Terrace';

SELECT COUNT(*) FROM Menu WHERE call_number IS NULL AND strftime('%Y', date) < '1950';

SELECT T2.image_id FROM Menu AS T1 INNER JOIN MenuPage AS T2 ON T1.id = T2.menu_id WHERE T1.name = 'Zentral Theater Terrace' AND T2.page_number = 1;

SELECT T1.name FROM Menu AS T1 INNER JOIN MenuPage AS T2 ON T1.id = T2.menu_id WHERE T2.image_id = 5189412;

SELECT CASE WHEN SUM(CASE WHEN T1.name = 'Zentral Theater Terrace' THEN T2.full_width ELSE 0 END) - SUM(CASE WHEN T1.name = 'Young''s Hotel' THEN T2.full_width ELSE 0 END) > 0 THEN 'Zentral Theater Terrace' ELSE 'Young''s Hotel' END FROM Menu AS T1 INNER JOIN MenuPage AS T2 ON T1.id = T2.menu_id;

SELECT T1.page_number FROM MenuPage AS T1 INNER JOIN Menu AS T2 ON T2.id = T1.menu_id WHERE T2.name = 'Ritz Carlton' ORDER BY T1.full_height DESC LIMIT 1;

SELECT SUM(CASE WHEN T1.name = 'Ritz Carlton' THEN 1 ELSE 0 END) FROM Menu AS T1 INNER JOIN MenuPage AS T2 ON T1.id = T2.menu_id WHERE T2.full_width > 1000;

SELECT SUM(CASE WHEN T1.page_number = 1 THEN 1 ELSE 0 END) FROM MenuPage AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.menu_page_id WHERE T1.menu_id = 12882;

SELECT T3.name FROM MenuPage AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.menu_page_id INNER JOIN Dish AS T3 ON T2.dish_id = T3.id WHERE T1.menu_id = 12882 AND T1.page_number = 1;

SELECT T1.page_number FROM MenuPage AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.menu_page_id INNER JOIN Dish AS T3 ON T2.dish_id = T3.id WHERE T3.name = 'Chicken gumbo';

SELECT T1.id FROM MenuPage AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.menu_page_id INNER JOIN Dish AS T3 ON T2.dish_id = T3.id WHERE T3.name = 'Chicken gumbo' ORDER BY T1.full_width DESC LIMIT 1;

SELECT SUM(CASE WHEN T1.name = 'Chicken gumbo' THEN 1 ELSE 0 END) FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id;

SELECT SUM(CASE WHEN T1.name = 'Paysanne Soup' THEN 1 ELSE 0 END) FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id WHERE T1.highest_price IS NULL;

SELECT T2.price FROM Dish AS T1 INNER JOIN MenuItem AS T2 ON T1.id = T2.dish_id WHERE T1.name = 'Chicken gumbo' ORDER BY T2.price DESC LIMIT 1;

SELECT T2.full_height * T2.full_width FROM Menu AS T1 INNER JOIN MenuPage AS T2 ON T1.id = T2.menu_id WHERE T1.name = 'Zentral Theater Terrace' AND T2.page_number = 1;

SELECT CAST(COUNT(dish_id) AS REAL) / COUNT(T3.page_count) FROM MenuItem AS T1 INNER JOIN MenuPage AS T2 ON T1.menu_page_id = T2.id INNER JOIN Menu AS T3 ON T2.menu_id = T3.id WHERE T2.menu_id = 12882;

