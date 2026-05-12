SELECT DISTINCT T2.`Product Name` FROM central_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T1.`Order ID` = 'CA-2011-112326';

SELECT MAX(strftime('%J', `Ship Date`) - strftime('%J', `Order Date`)) AS longestTimeDays FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.`Customer Name` = 'Aimee Bixby';

SELECT COUNT(DISTINCT T2.`Order ID`) FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.`Customer Name` = 'Aimee Bixby' AND T2.`Ship Mode` = 'Standard Class';

SELECT COUNT(DISTINCT T2.`Order ID`) FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.`Customer Name` = 'Aimee Bixby';

SELECT DISTINCT T2.`Order ID` FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.`Customer Name` = 'Aimee Bixby' GROUP BY T2.`Product ID` HAVING COUNT(T2.`Product ID`) > 3;

SELECT COUNT(DISTINCT T2.`Order ID`) FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T2.`Product ID` WHERE T3.Category = 'Furniture' AND T1.`Customer Name` = 'Aimee Bixby';

SELECT DISTINCT T3.`Product Name` FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T2.`Product ID` WHERE T1.`Customer Name` = 'Aimee Bixby' AND STRFTIME('%Y', T2.`Ship Date`) = '2016';

SELECT SUM(T1.Quantity) FROM central_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.`Product Name` = 'Telescoping Adjustable Floor Lamp';

SELECT DISTINCT T1.`Customer Name` FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T2.`Product ID` WHERE T3.`Product Name` = 'Telescoping Adjustable Floor Lamp';

SELECT COUNT(DISTINCT T1.`Customer Name`) FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T2.`Product ID` WHERE T3.`Product Name` = 'Telescoping Adjustable Floor Lamp' AND T1.Segment = 'Consumer';

SELECT SUM(T2.Quantity) FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T2.`Product ID` WHERE T1.`Customer Name` = 'Aimee Bixby' AND T3.`Product Name` = 'Xerox 1952' AND T2.`Order Date` = '2014-09-10';

SELECT COUNT(DISTINCT T2.`Order ID`) FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T2.`Product ID` WHERE T1.`Customer Name` = 'Aimee Bixby' AND T3.`Product Name` = 'Xerox 1952';

SELECT DISTINCT T2.Sales / (1 - T2.Discount) FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T2.`Product ID` WHERE T1.`Customer Name` = 'Aimee Bixby' AND T3.`Product Name` = 'Xerox 1952' AND T2.`Order Date` = '2014-09-10';

SELECT DISTINCT (T2.Sales / (1 - T2.discount)) * T2.Quantity - Profit FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T2.`Product ID` WHERE T1.`Customer Name` = 'Aimee Bixby' AND T3.`Product Name` = 'Xerox 1952' AND T2.`Order Date` = '2014-09-10';

SELECT COUNT(DISTINCT T1.`Product ID`) FROM east_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.`Sub-Category` = 'Art' AND T1.Region = 'East' AND STRFTIME('%Y', T1.`Order Date`) = '2013';

SELECT T2.`Customer Name` FROM east_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` GROUP BY T1.`Order ID`, T2.`Customer Name` ORDER BY SUM((T1.Sales / (1 - T1.Discount)) * T1.Quantity - T1.Profit) DESC LIMIT 1;

SELECT T2.`Product Name` FROM east_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` ORDER BY (T1.Sales / (1 - T1.Discount)) DESC LIMIT 1;

SELECT T3.`Product Name` FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T2.`Product ID` WHERE T1.`Customer Name` = 'Darren Powers' ORDER BY T2.`Order Date` DESC LIMIT 1;

SELECT SUM(T1.Quantity) FROM central_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.`Product Name` = 'Advantus Plastic Paper Clips';

SELECT T1.`Order ID` FROM central_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.`Product Name` = 'Logitech G600 MMO Gaming Mouse' GROUP BY T1.`Order ID` ORDER BY SUM((T1.Sales / (1 - T1.Discount)) * T1.Quantity - T1.Profit) DESC LIMIT 1;

SELECT DISTINCT T3.`Product Name` FROM west_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T1.`Product ID` WHERE T2.`Customer Name` = 'Alejandro Grove';

SELECT COUNT(DISTINCT T1.`Customer ID`) FROM west_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T1.`Product ID` WHERE T3.`Product Name` = 'Cardinal EasyOpen D-Ring Binders' AND T2.City = 'Chicago' AND T1.Quantity > 10;

SELECT DISTINCT T2.`Product Name` FROM west_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T1.Profit > 1000;

SELECT T2.`Product Name` FROM east_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T1.`Ship Mode` = 'First Class' AND T2.Region = 'East' LIMIT 10;

SELECT DISTINCT T3.`Product Name` FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T2.`Product ID` WHERE T1.`Customer Name` = 'Becky Martin' AND T3.Region = 'Central';

SELECT DISTINCT T2.`Customer Name` FROM west_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.Region = 'West' AND T1.`Ship Mode` = 'Second Class' LIMIT 5;

SELECT SUM(T2.Profit) FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.`Customer Name` = 'Patrick Gardner' AND T1.Region = 'Central';

SELECT T2.`Product Name` FROM south_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T1.`Ship Date` = '2013-03-04' AND T2.Region = 'South' AND T1.`Order Date` = '2013-03-04';

SELECT SUM(T1.Sales) FROM central_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.`Product Name` = 'Avery Hi-Liter EverBold Pen Style Fluorescent Highlighters, 4/Pack' AND T2.Region = 'Central';

SELECT T3.`Product Name` FROM east_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T1.`Product ID` WHERE T2.`Customer Name` = 'Jonathan Doherty' AND T2.Region = 'East' ORDER BY T1.Quantity DESC LIMIT 1;

SELECT SUM(T1.Quantity), T2.`Product Name` FROM east_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T1.`Ship Date` = '2015-03-25' AND T2.Region = 'East';

SELECT DISTINCT T2.`Customer Name` FROM east_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T1.`Product ID` WHERE T3.`Product Name` = 'Global High-Back Leather Tilter, Burgundy' AND T1.`Order Date` = '2013-10-13' AND T1.Region = 'East';

SELECT DISTINCT T3.Category FROM south_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T1.`Product ID` WHERE T2.`Customer Name` = 'Katherine Murray' AND T1.`Order Date` = '2018-11-04' AND T2.Region = 'South';

SELECT CAST(SUM(CASE  WHEN T2.Category = 'Furniture' THEN 1 ELSE 0 END) AS REAL) * 100 / SUM(T1.Quantity) FROM west_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.Region = 'West' AND T1.`Ship Mode` = 'Standard Class';

SELECT T2.`Ship Date` FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.`Customer Name` = 'Ann Chong' AND T1.Region = 'Central';

SELECT DISTINCT T2.Segment FROM west_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.Region = 'West' AND T1.`Order ID` = 'CA-2011-108189';

SELECT SUM(T1.Sales) FROM west_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.`Product Name` = 'Hon Valutask Swivel Chairs' AND T1.Region = 'West';

SELECT T1.`Order ID` FROM south_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T2.Region = 'South' AND T2.`Customer Name` = 'Frank Olsen';

SELECT T2.`Product Name` FROM central_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T1.`Order Date` = '2018-04-26' AND T1.`Ship Date` = '2018-04-27' AND T2.Region = 'Central';

SELECT T5.City, T5.State FROM west_superstore AS T1 INNER JOIN east_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN central_superstore AS T3 ON T3.`Customer ID` = T2.`Customer ID` INNER JOIN south_superstore AS T4 ON T4.`Customer ID` = T3.`Customer ID` INNER JOIN people AS T5 ON T5.`Customer ID` = T4.`Customer ID` ORDER BY T2.Sales DESC LIMIT 1;

SELECT T2.`Customer Name` FROM east_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.Region = 'East' ORDER BY T1.Profit DESC LIMIT 1;

SELECT T1.Quantity FROM west_superstore AS T1 INNER JOIN east_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN central_superstore AS T3 ON T3.`Customer ID` = T2.`Customer ID` INNER JOIN south_superstore AS T4 ON T4.`Customer ID` = T3.`Customer ID` INNER JOIN people AS T5 ON T5.`Customer ID` = T4.`Customer ID` WHERE T5.City = 'Chicago' AND T5.State = 'Illinois' ORDER BY T1.Quantity DESC LIMIT 1;

SELECT T1.`Order Date`, T2.`Product Name` FROM central_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T1.`Order ID` = 'CA-2011-137274' AND T2.Region = 'Central';

SELECT DISTINCT T2.`Customer Name` FROM south_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T1.`Product ID` WHERE T1.Region = 'South' AND T3.`Product Name` = 'Xerox 23';

SELECT T2.`Product Name` FROM central_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.Category = 'Office Supplies' AND T2.Region = 'Central' ORDER BY T1.Sales DESC LIMIT 1;

SELECT T2.`Customer Name` FROM west_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.Region = 'West' ORDER BY T1.Discount DESC LIMIT 1;

SELECT DISTINCT T2.`Product Name` FROM east_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.Region = 'East' AND T1.Profit > ( SELECT AVG(Profit) * 0.98 FROM east_superstore );

SELECT DISTINCT T2.`Customer Name` FROM east_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.Region = 'East' AND T1.Sales / (1 - T1.Discount) * T1.Quantity - T1.Profit > 80000;

SELECT COUNT(DISTINCT T1.`Order ID`) FROM east_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T2.`Customer Name` = 'Maxwell Schwartz' AND STRFTIME('%Y', T1.`Order Date`) = '2015';

SELECT DISTINCT T2.`Customer Name` FROM central_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T1.`Product ID` WHERE T3.`Product Name` = 'Bush Mission Pointe Library' AND T3.Region = 'Central';

SELECT SUM(T1.Profit) + SUM(T2.Profit) + SUM(T3.Profit) + SUM(T4.Profit) AS totalProfit FROM west_superstore AS T1 INNER JOIN east_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN central_superstore AS T3 ON T3.`Customer ID` = T2.`Customer ID` INNER JOIN south_superstore AS T4 ON T4.`Customer ID` = T3.`Customer ID` INNER JOIN product AS T5 ON T5.`Product ID` = T4.`Product ID` WHERE T5.`Product Name` = 'Cisco SPA301';

SELECT DISTINCT T3.`Product Name` FROM west_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T1.`Product ID` WHERE T2.`Customer Name` = 'Anne McFarland';

SELECT DISTINCT T3.`Product Name` FROM west_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T1.`Product ID` WHERE T2.City = 'Coachella';

SELECT east, west FROM ( SELECT COUNT(`Order ID`) AS east , ( SELECT COUNT(`Order ID`) FROM west_superstore WHERE `Order Date` LIKE '2015%' ) AS west FROM east_superstore WHERE `Order Date` LIKE '2015%' );

SELECT DISTINCT T3.`Product Name` FROM west_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T1.`Product ID` WHERE T2.`Customer Name` = 'Matt Abelman' AND STRFTIME('%Y', T1.`Order Date`) = '2013';

SELECT SUM((T1.Sales / (1 - T1.Discount)) * T1.Quantity - T1.Profit) AS cost FROM east_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T1.`Product ID` = T3.`Product ID` AND T1.Region = T3.Region WHERE T1.Region = 'East' AND T2.`Customer Name` = 'Brad Thomas' AND strftime('%Y', T1.`Order Date`) = '2016';

SELECT DISTINCT T2.`Customer Name`, T2.City, T2.Country FROM west_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T1.`Product ID` WHERE T3.`Product Name` = 'Plantronics Single Ear Headset';

SELECT DISTINCT T2.`Ship Date`, T3.`Product Name` FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T2.`Product ID` WHERE T1.`Customer Name` = 'Gene Hale';

SELECT COUNT(T1.`Order ID`) FROM south_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T1.`Ship Mode` = 'First Class' AND T2.Category = 'Furniture';

SELECT COUNT(*) FROM south_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T1.`Product ID` WHERE T3.Category = 'Office Supplies' AND T2.`Customer Name` = 'Cindy Stewart';

SELECT T2.Category FROM south_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` ORDER BY T1.Profit DESC LIMIT 1;

SELECT T3.`Product Name` FROM south_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T1.`Product ID` WHERE T2.`Customer Name` = 'Cindy Stewart';

SELECT T2.`Product Name` FROM west_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T1.`Ship Mode` = 'Same Day' AND T1.`Ship Date` LIKE '2013%';

SELECT DISTINCT T3.Category FROM east_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T1.`Product ID` LEFT JOIN central_superstore AS T4 ON T3.`Product ID` = T4.`Product ID` WHERE T2.`Customer Name` = 'Sam Craven';

SELECT SUM(T1.Quantity) FROM south_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T1.`Product ID` WHERE T2.`Customer Name` = 'Cindy Stewart' AND T3.`Product Name` = 'Lexmark X 9575 Professional All-in-One Color Printer';

SELECT DISTINCT T2.`Product Name` FROM central_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T1.`Ship Mode` = 'Standard Class' AND T1.Quantity >= 10;

SELECT T2.Category FROM west_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` ORDER BY T1.Sales LIMIT 1;

SELECT SUM(T1.Profit) FROM south_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` GROUP BY T2.`Product Name` = 'Memorix Froggy Flash Drive 8 GB';

SELECT SUM(T1.Sales) FROM east_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE STRFTIME('%Y', T1.`Order Date`) = '2016' AND T2.Category = 'Furniture';

SELECT AVG(T1.Sales) FROM west_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T1.`Product ID` WHERE T3.`Product Name` = 'Sharp AL-1530CS Digital Copier';

SELECT CAST(SUM(CASE  WHEN T3.Category = 'Office Supplies' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T3.Category) FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T2.`Product ID`;

SELECT CAST(SUM(CASE  WHEN State = 'Texas' THEN 1 ELSE 0 END) AS REAL) * 100 / SUM(CASE  WHEN State = 'Indiana' THEN 1 ELSE 0 END) FROM people;

SELECT T2.`Product Name` FROM central_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.`Sub-Category` = 'Art' GROUP BY T2.`Product Name` ORDER BY COUNT(T2.`Product ID`) DESC LIMIT 1;

SELECT DISTINCT T2.`Customer Name` FROM south_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE STRFTIME('%Y', T1.`Order Date`) = '2015' GROUP BY T2.`Customer Name` HAVING COUNT(T2.`Customer Name`) > 3;

SELECT MAX(T2.Profit) FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.`Customer Name` = 'Anna Chung';

SELECT COUNT(T2.`Customer ID`) FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.`Customer Name` = 'Corey Roper' AND STRFTIME('%Y', T2.`Ship Date`) = '2015';

SELECT SUM(T1.Sales) - SUM(T2.Sales) AS difference FROM east_superstore AS T1 INNER JOIN west_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID`;

SELECT DISTINCT T2.`Product Name` FROM central_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.Region = 'Central' AND T1.Profit < 0;

SELECT DISTINCT T2.`Product Name`, T1.`Ship Mode` FROM west_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.Region = 'West' ORDER BY T1.`Ship Date` - T1.`Order Date` LIMIT 1;

SELECT COUNT(DISTINCT T1.`Order ID`) FROM central_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.`Product Name` = 'O''Sullivan Plantations 2-Door Library in Landvery Oak' AND T2.Region = 'Central' AND T1.`Ship Mode` = 'First Class';

SELECT T2.`Customer Name` FROM east_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T2.Segment = 'Corporate' AND T2.State = 'Rhode Island' AND T2.Region = 'East' AND STRFTIME('%Y', T1.`Order Date`) = '2016' GROUP BY T2.`Customer Name` ORDER BY COUNT(T2.`Customer Name`) DESC LIMIT 1;

SELECT COUNT(DISTINCT T1.`Order ID`) FROM west_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` INNER JOIN people AS T3 ON T3.`Customer ID` = T1.`Customer ID` WHERE T1.Sales > 5000 AND T3.State = 'California' AND T2.Region = 'West';

SELECT T2.Segment FROM east_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T1.`Product ID` WHERE T1.Region = 'East' ORDER BY (T1.Sales / (1 - T1.Discount)) DESC LIMIT 1;

SELECT DISTINCT strftime('%J', `Ship Date`) - strftime('%J', `Order Date`) AS duration FROM central_superstore WHERE `Order ID` = 'CA-2011-134103';

SELECT COUNT(DISTINCT `Order ID`) FROM central_superstore WHERE Quantity > 5 AND `Ship Mode` = 'First Class';

SELECT `Order ID` FROM central_superstore WHERE Profit < 0 LIMIT 3;

SELECT DISTINCT T3.`Product Name` FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T2.`Product ID` WHERE T1.`Customer Name` = 'Phillina Ober';

SELECT T2.`Customer Name` FROM south_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T1.`Product ID` WHERE T3.`Product Name` = 'Hon Multipurpose Stacking Arm Chairs' GROUP BY T2.`Customer Name` ORDER BY COUNT(T2.`Customer Name`) DESC LIMIT 1;

SELECT DISTINCT T1.Profit FROM central_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.`Product Name` = 'O''Sullivan Living Dimensions 2-Shelf Bookcases';

SELECT SUM(T1.Quantity) FROM west_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.`Product Name` = 'Hon Pagoda Stacking Chairs';

SELECT COUNT(*) FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.`Customer Name` = 'Aaron Bergman' AND T2.`Ship Mode` = 'Standard Class';

SELECT T1.Sales / (1 - T1.Discount) FROM central_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.`Product Name` = 'Blackstonian Pencils';

SELECT DISTINCT T3.`Product Name` FROM east_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T1.`Product ID` WHERE T2.`Customer Name` = 'Aimee Bixby';

SELECT DISTINCT T1.Profit FROM south_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.`Product Name` = 'Sauder Camden County Barrister Bookcase, Planked Cherry Finish';

SELECT COUNT(T2.Category) FROM east_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T1.`Ship Mode` = 'Standard Class';

SELECT T1.`Order ID` FROM east_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T2.City = 'Houston' AND T2.State = 'Texas' ORDER BY T1.Profit DESC LIMIT 1;

SELECT COUNT(*) FROM central_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.Category = 'Furniture';

SELECT DISTINCT T2.`Product Name` FROM central_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE strftime('%Y-%m', T1.`Ship Date`) = '2013-03';

SELECT COUNT(DISTINCT T2.`Order ID`) FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.State = 'Texas';

SELECT COUNT(DISTINCT T2.`Order ID`) FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.`Customer Name` = 'Alan Barnes' AND STRFTIME('%Y', T2.`Order Date`) = '2015';

SELECT DISTINCT T2.`Product Name` FROM east_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T1.`Order ID` = 'CA-2011-141817';

SELECT CAST(SUM(CASE  WHEN T2.Discount = 0.2 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.State = 'Texas';

SELECT CAST(SUM(CASE  WHEN T1.`Ship Mode` = 'First Class' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM central_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.Category = 'Furniture' AND STRFTIME('%Y', T1.`Ship Date`) = '2013';

SELECT DISTINCT T2.`Customer Name` FROM west_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.`Order Date` = '2013-08-12' AND T1.Discount = 0.2 AND T1.Region = 'West';

SELECT DISTINCT T1.`Order ID` FROM central_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.`Product Name` = 'Security-Tint Envelopes' AND T1.`Order Date` = '2013-06-03';

SELECT DISTINCT T3.`Product Name` FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T2.`Product ID` WHERE T1.`Customer Name` = 'Bill Shonely' AND T2.Region = 'Central';

SELECT DISTINCT T2.`Customer Name` FROM west_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.Quantity = 8 AND T1.Region = 'West';

SELECT SUM(T2.Profit) FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` INNER JOIN product AS T3 ON T3.`Product ID` = T2.`Product ID` WHERE T1.City = 'Houston' AND T1.State = 'Texas' AND T2.Region = 'Central';

SELECT DISTINCT T2.`Customer Name` FROM east_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.`Ship Date` = '2013-03-05';

SELECT T2.`Product Name` FROM central_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.Region = 'Central' AND STRFTIME('%Y', T1.`Order Date`) = '2016' ORDER BY T1.Profit ASC LIMIT 1;

SELECT DISTINCT T2.`Customer Name` FROM east_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T1.`Order ID` = 'CA-2011-118976' AND T2.Region = 'East';

SELECT T2.`Product Name` FROM south_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.Region = 'South' ORDER BY T1.Sales DESC LIMIT 1;

SELECT T1.Sales, T1.Profit, T2.`Sub-Category` FROM east_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T1.`Order ID` = 'US-2011-126571' AND T2.Region = 'East';

SELECT T2.`Product Name` FROM east_superstore AS T1 INNER JOIN product AS T2 ON T1.`Product ID` = T2.`Product ID` WHERE T2.Region = 'East' ORDER BY T1.Quantity DESC LIMIT 1;

SELECT DISTINCT T2.`Customer Name` FROM south_superstore AS T1 INNER JOIN people AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T2.Region = 'South' AND T1.`Ship Mode` = 'Standard Class' AND 100 * T1.Sales / ( SELECT AVG(Sales) FROM south_superstore ) > 88;

SELECT CAST(SUM(CASE  WHEN T2.Discount = 0 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM people AS T1 INNER JOIN central_superstore AS T2 ON T1.`Customer ID` = T2.`Customer ID` WHERE T2.Region = 'Central' AND T1.State = 'Indiana';

