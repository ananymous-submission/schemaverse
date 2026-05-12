SELECT COUNT(EmployeeID) FROM Employees WHERE TitleOfCourtesy = 'Dr.';

SELECT FirstName, LastName FROM Employees WHERE EmployeeID = ( SELECT ReportsTo FROM Employees WHERE LastName = 'Davolio' AND FirstName = 'Nancy' );

SELECT HomePhone FROM Employees WHERE LastName = 'Davolio' AND FirstName = 'Nancy';

SELECT COUNT(EmployeeID) FROM Employees WHERE ReportsTo = ( SELECT EmployeeID FROM Employees WHERE LastName = 'Fuller' AND FirstName = 'Andrew' );

SELECT FirstName, LastName FROM Employees WHERE Salary = ( SELECT MAX(Salary) FROM Employees );

SELECT ( SELECT Salary FROM Employees WHERE LastName = 'Fuller' AND FirstName = 'Andrew' ) - ( SELECT Salary FROM Employees WHERE LastName = 'Davolio' AND FirstName = 'Nancy' ) AS RESULT;

SELECT COUNT(Country) FROM Employees WHERE Title = 'Sales Representative' AND Country = 'UK';

SELECT T1.FirstName, T1.LastName FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID WHERE T3.TerritoryDescription = 'Hollis';

SELECT COUNT(T2.TerritoryID) FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T1.FirstName = 'Nancy' AND T1.LastName = 'Davolio';

SELECT T3.TerritoryDescription FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID WHERE T1.FirstName = 'Nancy' AND T1.LastName = 'Davolio';

SELECT COUNT(T2.TerritoryID) FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T1.City = 'London';

SELECT T3.TerritoryDescription FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID WHERE T1.ReportsTo = ( SELECT EmployeeID FROM Employees WHERE FirstName = 'Andrew' AND LastName = 'Fuller' );

SELECT COUNT(COUNTEID) FROM ( SELECT T1.EmployeeID AS COUNTEID FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T1.Country = 'UK' GROUP BY T1.EmployeeID HAVING COUNT(T2.TerritoryID) > 4 ) T1;

SELECT COUNT(T1.TerritoryID) FROM Territories AS T1 INNER JOIN Region AS T2 ON T1.RegionID = T2.RegionID WHERE T2.RegionDescription = 'Eastern';

SELECT DISTINCT T1.TerritoryDescription FROM Territories AS T1 INNER JOIN Region AS T2 ON T1.RegionID = T2.RegionID WHERE T2.RegionDescription = 'Eastern';

SELECT COUNT(T.EmployeeID) FROM ( SELECT T3.EmployeeID FROM Region AS T1 INNER JOIN Territories AS T2 ON T1.RegionID = T2.RegionID INNER JOIN EmployeeTerritories AS T3 ON T2.TerritoryID = T3.TerritoryID WHERE T1.RegionDescription = 'Eastern' GROUP BY T3.EmployeeID ) T;

SELECT T1.HomePhone FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID INNER JOIN Region AS T4 ON T3.RegionID = T4.RegionID WHERE T4.RegionDescription = 'Eastern ' GROUP BY T1.HomePhone;

SELECT ( SELECT COUNT(T1.TerritoryID) FROM Territories AS T1 INNER JOIN Region AS T2 ON T1.RegionID = T2.RegionID WHERE T2.RegionDescription = 'Eastern' ) - ( SELECT COUNT(T1.TerritoryID) FROM Territories AS T1 INNER JOIN Region AS T2 ON T1.RegionID = T2.RegionID WHERE T2.RegionDescription = 'Southern' ) AS Calu;

SELECT T1.ProductName FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID WHERE T2.OrderID = 10248;

SELECT T2.Quantity FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID WHERE T2.OrderID = 10273 AND T1.ProductName = 'Ikura';

SELECT T2.UnitPrice * T2.Quantity FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID WHERE T2.OrderID = 10273 AND T1.ProductName = 'Ikura';

SELECT T1.UnitsInStock + T1.UnitsOnOrder FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID WHERE T2.OrderID = 10248 ORDER BY T2.Quantity DESC LIMIT 1;

SELECT T1.ProductName FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID WHERE T2.OrderID = 10248 ORDER BY T1.ReorderLevel DESC LIMIT 1;

SELECT COUNT(T2.OrderID) FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID WHERE T1.ProductName = 'Tofu';

SELECT T2.OrderID FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID WHERE T1.Discontinued = 1;

SELECT COUNT(T2.OrderID) FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID WHERE T1.ProductName = 'Ikura' AND T2.UnitPrice < T1.UnitPrice;

SELECT T2.CompanyName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.ProductName = 'Aniseed Syrup';

SELECT T1.ProductName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.Country = 'Japan';

SELECT DISTINCT T2.Phone FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.UnitsInStock < T1.UnitsOnOrder;

SELECT COUNT(T1.Discontinued) FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.Country = 'USA' AND T1.Discontinued = 1;

SELECT T2.CompanyName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.UnitPrice = ( SELECT MAX(UnitPrice) FROM Products );

SELECT AVG(T1.Salary) FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID GROUP BY T1.EmployeeID HAVING COUNT(T2.TerritoryID) > 4;

SELECT CAST((T1.UnitPrice - T2.UnitPrice) AS REAL) * 100 / T1.UnitPrice FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID WHERE T2.OrderID = 10273 AND T1.ProductName = 'Ikura';

SELECT CAST(SUM(T2.Quantity) AS REAL) / COUNT(T2.OrderID) FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID WHERE T1.ProductName = 'Ikura';

SELECT T1.ProductName FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID WHERE T2.OrderID = 10248 ORDER BY T1.UnitsOnOrder / T1.UnitsInStock DESC LIMIT 1;

SELECT FirstName, LastName FROM Employees WHERE BirthDate = ( SELECT MAX(BirthDate) FROM Employees );

SELECT FirstName, LastName FROM Employees WHERE HireDate = ( SELECT MAX(HireDate) FROM Employees );

SELECT COUNT(T2.OrderID) FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T1.FirstName = 'Michael' AND T1.LastName = 'Suyama';

SELECT T3.TerritoryDescription FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID WHERE T1.TitleOfCourtesy = 'Mr.' AND T1.FirstName = 'Robert' AND T1.LastName = 'King';

SELECT T3.TerritoryDescription FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID WHERE T1.EmployeeID = ( SELECT ReportsTo FROM Employees WHERE TitleOfCourtesy = 'Ms.' AND FirstName = 'Laura' AND LastName = 'Callahan' );

SELECT T1.FirstName, T1.LastName FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID WHERE T3.TerritoryDescription = 'Santa Monica';

SELECT T1.HomePhone FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID WHERE T3.TerritoryDescription = 'Savannah';

SELECT SUM(T2.Quantity) FROM Orders AS T1 INNER JOIN `Order Details` AS T2 ON T1.OrderID = T2.OrderID WHERE T1.CustomerID = 'HILAA' AND T1.OrderDate LIKE '1997-12-25%';

SELECT COUNT(T2.ProductID) FROM Orders AS T1 INNER JOIN `Order Details` AS T2 ON T1.OrderID = T2.OrderID WHERE T1.Freight = ( SELECT MAX(Freight) FROM Orders ) GROUP BY T1.OrderID;

SELECT T2.CompanyName FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T1.OrderID = 10585;

SELECT COUNT(T1.OrderID) FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T2.CompanyName = 'Federal Shipping';

SELECT COUNT(T1.ProductID) FROM Products AS T1 INNER JOIN Categories AS T2 ON T1.CategoryID = T2.CategoryID WHERE T2.CategoryName = 'Dairy Products';

SELECT T2.CategoryName FROM Products AS T1 INNER JOIN Categories AS T2 ON T1.CategoryID = T2.CategoryID WHERE T1.ProductName = 'Tofu';

SELECT SUM(T1.UnitsInStock + T1.UnitsOnOrder) FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Escargots Nouveaux';

SELECT T1.ReorderLevel FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Nord-Ost-Fisch Handelsgesellschaft mbH';

SELECT COUNT(T1.ProductID) FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Karkki Oy';

SELECT T2.ContactName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.ProductName = 'Gudbrandsdalsost';

SELECT T2.Country FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.ProductName = 'Scottish Longbreads';

SELECT COUNT(T1.TerritoryID) FROM Territories AS T1 INNER JOIN Region AS T2 ON T1.RegionID = T2.RegionID WHERE T2.RegionDescription = 'Northern';

SELECT T2.RegionDescription FROM Territories AS T1 INNER JOIN Region AS T2 ON T1.RegionID = T2.RegionID WHERE T1.TerritoryDescription = 'Columbia';

SELECT CAST(COUNT(CASE WHEN T2.CompanyName = 'United Package' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T1.OrderID) FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T1.CustomerID = 'WHITC';

SELECT CAST((COUNT(CASE WHEN T2.CompanyName = 'United Package' THEN 1 ELSE NULL END) - COUNT(CASE WHEN T2.CompanyName = 'Speedy Express' THEN 1 ELSE NULL END)) AS REAL) * 100 / COUNT(CASE WHEN T2.CompanyName = 'Speedy Express' THEN 1 ELSE NULL END) FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID;

SELECT CAST(( SELECT COUNT(T1.TerritoryID) FROM Territories AS T1 INNER JOIN Region AS T2 ON T1.RegionID = T2.RegionID WHERE T2.RegionDescription = 'Eastern' ) AS REAL) / ( SELECT COUNT(T1.TerritoryID) FROM Territories AS T1 INNER JOIN Region AS T2 ON T1.RegionID = T2.RegionID WHERE T2.RegionDescription = 'Southern' ) AS Calu;

SELECT COUNT(CustomerID) FROM Customers GROUP BY Country ORDER BY COUNT(CustomerID) DESC LIMIT 1;

SELECT OrderID FROM Orders WHERE Freight > 800;

SELECT Address, City, Region, Country, PostalCode FROM Customers WHERE CompanyName = 'Island Trading';

SELECT ProductName FROM Products WHERE UnitPrice = ( SELECT MAX(UnitPrice) FROM Products );

SELECT COUNT(SupplierID) FROM Suppliers WHERE Country = 'USA';

SELECT ProductName FROM Products WHERE ReorderLevel = ( SELECT MAX(ReorderLevel) FROM Products );

SELECT FirstName, LastName FROM Employees WHERE Salary = ( SELECT MAX(Salary) FROM Employees );

SELECT ProductName FROM Products WHERE Discontinued = 1;

SELECT AVG(Salary) FROM Employees WHERE Title = 'Sales Representative' AND Country = 'UK';

SELECT T2.CompanyName FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T1.ShipCountry = 'USA' GROUP BY T2.CompanyName ORDER BY COUNT(T2.CompanyName) DESC LIMIT 1;

SELECT COUNT(T1.ProductName) FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Pavlova, Ltd.';

SELECT COUNT(T1.OrderID) FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T1.CustomerID = 'GREAL' AND T2.CompanyName = 'United Package';

SELECT DISTINCT T2.CompanyName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.ReorderLevel = ( SELECT MAX(ReorderLevel) FROM Products );

SELECT COUNT(T1.OrderID) FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T2.CompanyName = 'United Package';

SELECT COUNT(T1.Discontinued) FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.Discontinued = 1 AND T2.Country = 'Australia';

SELECT T2.UnitPrice * T2.Quantity + T1.Freight FROM Orders AS T1 INNER JOIN `Order Details` AS T2 ON T1.OrderID = T2.OrderID ORDER BY T2.UnitPrice * T2.Quantity + T1.Freight DESC LIMIT 2;

SELECT T1.SupplierID FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID GROUP BY T1.SupplierID ORDER BY COUNT(*) DESC LIMIT 1;

SELECT DISTINCT T1.ProductName FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID WHERE T2.UnitPrice < 5;

SELECT T1.Title FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID GROUP BY T1.Title ORDER BY COUNT(T2.TerritoryID) DESC LIMIT 1;

SELECT T1.ProductID FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID GROUP BY T1.ProductID ORDER BY COUNT(*) DESC LIMIT 1;

SELECT T3.TerritoryDescription FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID WHERE T1.TitleOfCourtesy = 'Dr.';

SELECT DISTINCT T1.TerritoryDescription FROM Territories AS T1 INNER JOIN Region AS T2 ON T1.RegionID = T2.RegionID WHERE T2.RegionDescription = 'Eastern' ORDER BY T1.TerritoryDescription;

SELECT CAST(COUNT(T2.TerritoryID) AS REAL) / COUNT(DISTINCT T1.EmployeeID) FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T1.Title = 'Sales Representative';

SELECT T1.ProductName FROM Products AS T1 INNER JOIN Categories AS T2 ON T1.CategoryID = T2.CategoryID WHERE T2.CategoryName = 'Beverages' ORDER BY T1.ReorderLevel DESC LIMIT 1;

SELECT T1.FirstName, T1.LastName FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID GROUP BY T1.FirstName, T1.LastName ORDER BY COUNT(*) DESC LIMIT 1;

SELECT COUNT(T2.ProductID) FROM Orders AS T1 INNER JOIN `Order Details` AS T2 ON T1.OrderID = T2.OrderID GROUP BY T2.ProductID ORDER BY COUNT(T1.Freight) DESC LIMIT 1;

SELECT T1.ProductName FROM Products AS T1 INNER JOIN Categories AS T2 ON T1.CategoryID = T2.CategoryID WHERE T2.CategoryName = 'Seafood' ORDER BY T1.UnitsInStock + T1.UnitsOnOrder DESC LIMIT 1;

SELECT MAX(Salary) - MIN(Salary) FROM ( SELECT T1.Salary FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID GROUP BY T1.EmployeeID, T1.Salary ORDER BY COUNT(T2.TerritoryID) DESC LIMIT 2 ) T1;

SELECT SUM(UnitPrice) / COUNT(UnitPrice) FROM Products WHERE UnitsInStock > 50;

SELECT CompanyName FROM `Customer and Suppliers by City` WHERE CITY = ( SELECT City FROM `Customer and Suppliers by City` GROUP BY City ORDER BY COUNT(Relationship) DESC LIMIT 1 );

SELECT CompanyName, ContactName, ContactTitle FROM Customers WHERE City = 'Madrid';

SELECT FirstName, LastName, HomePhone FROM Employees ORDER BY BirthDate DESC;

SELECT AVG(UnitPrice) AS avg FROM Invoices WHERE Country = 'UK';

SELECT ProductID FROM `Order Details` GROUP BY ProductID ORDER BY SUM(Quantity) DESC LIMIT 1;

SELECT T2.CompanyName, T2.Address, T2.Phone FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.UnitPrice > 30;

SELECT DISTINCT T1.CompanyName, T1.Address FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Freight > ( SELECT AVG(Freight) FROM Orders );

SELECT T1.FirstName, T1.LastName FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID WHERE T3.TerritoryDescription = 'Wilton';

SELECT DISTINCT T2.CompanyName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.Discontinued = 1 AND T2.Country != 'USA';

SELECT T3.ProductName FROM Orders AS T1 INNER JOIN `Order Details` AS T2 ON T1.OrderID = T2.OrderID INNER JOIN Products AS T3 ON T2.ProductID = T3.ProductID WHERE T1.OrderDate LIKE '1998%' ORDER BY T3.UnitPrice + T1.Freight DESC LIMIT 5;

SELECT COUNT(T3.CustomerID) FROM Shippers AS T1 INNER JOIN Orders AS T2 ON T1.ShipperID = T2.ShipVia INNER JOIN Customers AS T3 ON T2.CustomerID = T3.CustomerID WHERE T2.ShipName = 'Federal Shipping';

SELECT T3.ProductName FROM Orders AS T1 INNER JOIN `Order Details` AS T2 ON T1.OrderID = T2.OrderID INNER JOIN Products AS T3 ON T2.ProductID = T3.ProductID GROUP BY T3.ProductName ORDER BY COUNT(*) DESC LIMIT 10;

SELECT T2.CompanyName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID GROUP BY T2.SupplierID, T2.CompanyName ORDER BY COUNT(T1.ProductName) DESC LIMIT 1;

SELECT DISTINCT T1.FirstName, T1.LastName, T4.RegionDescription FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID INNER JOIN Region AS T4 ON T3.RegionID = T4.RegionID ORDER BY T1.FirstName;

SELECT FirstName, LastName, Title, address FROM Employees WHERE EmployeeID = ( SELECT T1.EmployeeID FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T2.OrderDate BETWEEN '1996-01-01 00:00:00' AND '1997-01-01 00:00:00' GROUP BY T1.EmployeeID ORDER BY COUNT(T2.OrderID) DESC LIMIT 1 );

SELECT AVG(T2.UnitPrice) FROM Orders AS T1 INNER JOIN `Order Details` AS T2 ON T1.OrderID = T2.OrderID INNER JOIN Shippers AS T3 ON T1.ShipVia = T3.ShipperID WHERE T1.OrderDate LIKE '1997%' AND T3.CompanyName = 'United Package';

SELECT CAST(COUNT(CASE WHEN T2.CompanyName = 'Speedy Express' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T1.ShipVia) FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID;

SELECT TitleOfCourtesy FROM Employees ORDER BY Salary LIMIT 3;

SELECT LastName FROM Employees WHERE ReportsTo = ( SELECT EmployeeID FROM Employees WHERE Title = 'Vice President, Sales' );

SELECT UnitPrice * Quantity * (1 - Discount) AS THETOP FROM `Order Details` ORDER BY UnitPrice * Quantity * (1 - Discount) DESC LIMIT 1;

SELECT ProductName FROM Products ORDER BY UnitsInStock + UnitsOnOrder DESC LIMIT 3;

SELECT ProductID FROM Products ORDER BY ReorderLevel ASC, UnitPrice DESC LIMIT 1;

SELECT COUNT(T1.CategoryID) FROM Categories AS T1 INNER JOIN Products AS T2 ON T1.CategoryID = T2.CategoryID WHERE T1.CategoryName = 'Dairy Products' AND T2.Discontinued = 0;

SELECT T3.TerritoryDescription FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID WHERE T1.Title = 'Inside Sales Coordinator';

SELECT T1.CompanyName FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Freight > 2000000;

SELECT T2.CompanyName FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T1.ShipCity = 'Aachen' GROUP BY T2.CompanyName ORDER BY COUNT(T1.ShipVia) DESC LIMIT 1;

SELECT DISTINCT T1.FirstName, T1.LastName FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID INNER JOIN Region AS T4 ON T3.RegionID = T4.RegionID WHERE T4.RegionDescription = 'Northern';

SELECT T2.ContactName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.ProductName = 'Pavlova';

SELECT T3.ProductName FROM Orders AS T1 INNER JOIN `Order Details` AS T2 ON T1.OrderID = T2.OrderID INNER JOIN Products AS T3 ON T2.ProductID = T3.ProductID WHERE T1.ShipCity = 'Paris';

SELECT T4.ProductName FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN `Order Details` AS T3 ON T2.OrderID = T3.OrderID INNER JOIN Products AS T4 ON T3.ProductID = T4.ProductID WHERE T1.PostalCode = 28023 ORDER BY T3.Quantity LIMIT 1;

SELECT DISTINCT T1.FirstName, T1.LastName FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID INNER JOIN Region AS T4 ON T3.RegionID = T4.RegionID WHERE T4.RegionDescription = 'Southern' AND T1.ReportsTo = ( SELECT EmployeeID FROM Employees WHERE FirstName = 'Andrew' AND LastName = 'Fuller' );

SELECT T2.OrderDate FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN `Order Details` AS T3 ON T2.OrderID = T3.OrderID INNER JOIN Products AS T4 ON T3.ProductID = T4.ProductID WHERE T4.ProductName = 'Filo Mix' AND T3.Quantity = 9 AND T1.CompanyName = 'Du monde entier';

SELECT T3.CategoryName FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID INNER JOIN Categories AS T3 ON T1.CategoryID = T3.CategoryID WHERE T2.OrderID = 10933;

SELECT T1.HomePhone FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID WHERE T3.TerritoryDescription = 'Portsmouth';

SELECT CAST(SUM(T2.Quantity) AS REAL) / COUNT(T2.OrderID) FROM Orders AS T1 INNER JOIN `Order Details` AS T2 ON T1.OrderID = T2.OrderID INNER JOIN Shippers AS T3 ON T1.ShipVia = T3.ShipperID WHERE T1.ShippedDate LIKE '1996-11%' AND T3.CompanyName = 'Federal Shipping';

SELECT CAST(COUNT(CASE WHEN T1.ShippedDate LIKE '1996-09%' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T1.ShipVia) FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T2.CompanyName = 'United Package' AND T1.ShippedDate LIKE '1996%';

SELECT COUNT(ContactTitle) FROM Customers WHERE Country = 'Mexico' AND ContactTitle = 'Owner';

SELECT Address, City, Region, PostalCode, Country FROM Customers WHERE ContactName = 'Andr Fonseca';

SELECT CompanyName FROM Customers WHERE Phone LIKE '(171)%';

SELECT ( SELECT COUNT(Title) FROM Employees WHERE Country = 'UK' AND Title = 'Sales Representative' ) - ( SELECT COUNT(Title) FROM Employees WHERE Country = 'USA' AND Title = 'Sales Representative' ) AS DIFFERENCE;

SELECT COUNT(CustomerID) FROM Customers WHERE City = 'Sao Paulo' AND Country = 'Brazil' AND ContactTitle = 'Sales Associate';

SELECT T1.LastName FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T2.OrderID = 10521 AND T2.CustomerID = 'CACTU';

SELECT T2.Freight FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.OrderID = 10692 AND T1.CompanyName = 'Alfreds Futterkiste';

SELECT T2.CompanyName FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T1.OrderID = 10558;

SELECT T1.OrderID FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T2.CompanyName = 'Speedy Express' LIMIT 3;

SELECT T2.ProductName FROM Categories AS T1 INNER JOIN Products AS T2 ON T1.CategoryID = T2.CategoryID WHERE T1.CategoryName = 'Beverages';

SELECT T1.Description FROM Categories AS T1 INNER JOIN Products AS T2 ON T1.CategoryID = T2.CategoryID WHERE T2.ProductName = 'tofu';

SELECT T2.CompanyName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.ProductName = 'Gula Malacca';

SELECT T1.ProductName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Aux joyeux ecclsiastiques';

SELECT T1.UnitPrice FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName LIKE 'Mayumi%' AND T1.ProductName = 'Konbu';

SELECT T2.ContactName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.ProductName = 'Camembert Pierrot';

SELECT T2.ProductName FROM Categories AS T1 INNER JOIN Products AS T2 ON T1.CategoryID = T2.CategoryID WHERE T2.Discontinued = 1 AND T1.CategoryName = 'Meat/Poultry' LIMIT 3;

SELECT T1.ProductName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Heli Swaren GmbH & Co. KG' ORDER BY T1.ReorderLevel DESC LIMIT 2;

SELECT ContactName FROM Suppliers WHERE CompanyName = 'Heli Swaren GmbH & Co. KG';

SELECT Country FROM Customers WHERE CompanyName = 'Drachenblut Delikatessen';

SELECT COUNT(TerritoryID) FROM Territories;

SELECT SUM(UnitPrice) FROM `Order Details` GROUP BY OrderID ORDER BY SUM(UnitPrice) DESC LIMIT 1;

SELECT ProductName FROM Products WHERE UnitPrice = ( SELECT MAX(UnitPrice) FROM Products );

SELECT COUNT(ShipCountry) FROM Orders WHERE ShipCountry = 'France';

SELECT T2.RegionDescription FROM Territories AS T1 INNER JOIN Region AS T2 ON T1.RegionID = T2.RegionID WHERE T1.TerritoryDescription = 'Hoffman Estates';

SELECT T2.HomePage FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.ProductName = 'Thringer Rostbratwurst';

SELECT DISTINCT T1.FirstName FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T2.ShipCity = 'Reims';

SELECT T2.Quantity FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T2.ProductID = T1.ProductID WHERE T1.ProductName = 'Manjimup Dried Apples' ORDER BY T2.Quantity DESC LIMIT 1;

SELECT COUNT(T1.OrderID) FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T2.CompanyName = 'Speedy Express';

SELECT DISTINCT T1.TerritoryDescription FROM Territories AS T1 INNER JOIN Region AS T2 ON T1.RegionID = T2.RegionID WHERE T2.RegionDescription = 'Southern';

SELECT T2.UnitPrice FROM Categories AS T1 INNER JOIN Products AS T2 ON T1.CategoryID = T2.CategoryID WHERE T1.Description = 'Cheeses';

SELECT COUNT(T2.OrderID) FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.CompanyName = 'Laughing Bacchus Wine Cellars';

SELECT T3.ProductName FROM Orders AS T1 INNER JOIN `Order Details` AS T2 ON T1.OrderID = T2.OrderID INNER JOIN Products AS T3 ON T2.ProductID = T3.ProductID WHERE T1.ShipAddress = 'Starenweg 5' GROUP BY T3.ProductName;

SELECT T1.ProductName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Bigfoot Breweries';

SELECT T3.TerritoryDescription FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID WHERE T1.LastName = 'King' AND T1.FirstName = 'Robert';

SELECT T1.ContactName FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.ShipCountry = 'Switzerland' GROUP BY T1.ContactName;

SELECT CAST(COUNT(CASE WHEN T1.Title = 'Sales Representative' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T2.OrderID) FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID;

SELECT COUNT(Country) FROM Employees WHERE TitleOfCourtesy = 'Dr.' AND Country = 'USA';

SELECT AVG(Salary) FROM Employees WHERE EmployeeID BETWEEN 1 AND 9;

SELECT SUM(Salary) FROM Employees WHERE Country = 'UK';

SELECT CASE WHEN HomePhone = '(206) 555-1189' THEN 'YES' ELSE 'NO' END FROM Employees WHERE FirstName = 'Laura' AND LastName = 'Callahan';

SELECT Notes FROM Employees WHERE Salary = ( SELECT MAX(Salary) FROM Employees );

SELECT T2.CustomerID FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T1.FirstName = 'Michael' AND T1.LastName = 'Suyama';

SELECT DISTINCT T2.ShipCountry FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T1.FirstName = 'Janet' AND T1.LastName = 'Leverling';

SELECT COUNT(T2.EmployeeID) FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T1.FirstName = 'Margaret' AND T1.LastName = 'Peacock';

SELECT CAST(SUM(T1.Salary) AS REAL) / COUNT(T2.EmployeeID) FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T1.FirstName = 'Andrew' AND T1.LastName = 'Fuller';

SELECT T1.ProductName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Exotic Liquids';

SELECT T1.QuantityPerUnit FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Tokyo Traders';

SELECT COUNT(T1.Discontinued) FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'New Orleans Cajun Delights';

SELECT SUM(T1.UnitPrice) / COUNT(T1.SupplierID) FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Formaggi Fortini s.r.l.';

SELECT COUNT(T1.SupplierID) FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.Country = 'Japan';

SELECT T2.ContactName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.ProductName = 'Teatime Chocolate Biscuits';

SELECT DISTINCT T2.CompanyName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.ReorderLevel = ( SELECT MAX(ReorderLevel) FROM Products );

SELECT T2.ContactTitle FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.QuantityPerUnit = '10 boxes x 12 pieces';

SELECT SUM(T1.UnitsOnOrder) FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Exotic Liquids';

SELECT CAST(COUNT(CASE WHEN T2.CompanyName = 'Gai pturage' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T1.SupplierID) FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID;

SELECT ProductID FROM Products ORDER BY UnitsInStock DESC LIMIT 5;

SELECT COUNT(*) FROM Products WHERE Discontinued = 1;

SELECT Address, HomePhone, Salary FROM Employees WHERE Title = 'Sales Manager';

SELECT FirstName, LastName FROM Employees WHERE Title = 'Vice President, Sales';

SELECT CompanyName FROM `Sales Totals by Amount` ORDER BY SaleAmount DESC LIMIT 10;

SELECT AVG(ProductSales) FROM `Sales by Category` GROUP BY CategoryName;

SELECT SUM(T2.Quantity) FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID WHERE T1.ProductName LIKE 'Uncle Bob%s Organic Dried Pears';

SELECT COUNT(T1.ProductID) FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID INNER JOIN Categories AS T3 ON T1.CategoryID = T3.CategoryID WHERE T3.CategoryName = 'Seafood' AND T2.Quantity > 50;

SELECT T1.ProductName, T1.ProductID, T1.ReorderLevel FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Pavlova, Ltd.';

SELECT DISTINCT T2.CompanyName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.Discontinued = 1;

SELECT T1.FirstName, T1.LastName FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T2.EmployeeID < 4;

SELECT COUNT(DISTINCT T1.FirstName) FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID INNER JOIN Region AS T4 ON T3.RegionID = T4.RegionID WHERE T4.RegionDescription = 'Eastern';

SELECT COUNT(T1.OrderID) FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T2.CompanyName = 'Federal Shipping' AND T1.ShippedDate BETWEEN '1997-03-01 00:00:00' AND '1997-10-08 23:59:59';

SELECT DISTINCT T2.CustomerID FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T1.LastName = 'Peacock' AND T1.FirstName = 'Margaret' AND T2.ShipCountry = 'Brazil' AND T2.ShippedDate BETWEEN '1997-03-31 00:00:00' AND '1997-12-10 23:59:59';

SELECT T1.ReorderLevel FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID WHERE T2.Quantity = 1;

SELECT T1.UnitPrice * T1.UnitsInStock FROM Products AS T1 INNER JOIN Categories AS T2 ON T1.CategoryID = T2.CategoryID;

SELECT COUNT(T2.TerritoryID) FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T1.FirstName = 'Anne' AND T1.LastName = 'Dodsworth';

SELECT T1.CompanyName, TIMESTAMPDIFF(DAY, T2.ShippedDate, T2.RequiredDate) FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Country = 'USA' AND TIMESTAMPDIFF(DAY, T2.ShippedDate, T2.RequiredDate) < 0;

SELECT T1.ContactName, T1.Phone FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN `Order Details` AS T3 ON T2.OrderID = T3.OrderID GROUP BY T2.OrderID, T1.ContactName, T1.Phone ORDER BY SUM(T3.UnitPrice * T3.Quantity * (1 - T3.Discount)) DESC LIMIT 1;

SELECT T4.LastName, T4.FirstName, T4.ReportsTo , T1.Quantity * T1.UnitPrice * (1 - T1.Discount) AS payment FROM `Order Details` AS T1 INNER JOIN Orders AS T2 ON T1.OrderID = T2.OrderID INNER JOIN Customers AS T3 ON T2.CustomerID = T3.CustomerID INNER JOIN Employees AS T4 ON T2.EmployeeID = T4.EmployeeID ORDER BY payment DESC LIMIT 1;

SELECT COUNT(City) FROM Customers WHERE Country = 'Germany' AND City = 'Berlin';

SELECT COUNT(T1.ProductName) FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Exotic Liquids';

SELECT T2.CompanyName, T1.ProductName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.UnitPrice = ( SELECT MIN(UnitPrice) FROM Products );

SELECT SUM(T1.UnitPrice) / COUNT(T2.SupplierID) FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Tokyo Traders';

SELECT COUNT(T1.RegionID) FROM Territories AS T1 INNER JOIN Region AS T2 ON T1.RegionID = T2.RegionID WHERE T2.RegionDescription = 'Eastern';

SELECT T2.RegionID FROM Territories AS T1 INNER JOIN Region AS T2 ON T1.RegionID = T2.RegionID GROUP BY T2.RegionID ORDER BY COUNT(T1.TerritoryID) DESC LIMIT 1;

SELECT T2.RegionDescription FROM Territories AS T1 INNER JOIN Region AS T2 ON T1.RegionID = T2.RegionID WHERE T1.TerritoryID = 2116;

SELECT CAST(COUNT(CASE WHEN T1.City = 'Madrid' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T1.City) FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID WHERE STRFTIME('%Y', T2.OrderDate) = 1996;

SELECT FirstName, LastName, Title FROM Employees;

SELECT FirstName, LastName FROM Employees WHERE Salary = ( SELECT MAX(Salary) FROM Employees );

SELECT COUNT(Title) FROM Employees WHERE Salary > 2000 AND Title = 'Sales Representative';

SELECT COUNT(T1.CustomerID) FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID WHERE STRFTIME('%Y', T2.OrderDate) = '1996' AND T1.Country = 'UK';

SELECT T1.CompanyName FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID WHERE STRFTIME('%Y', T2.OrderDate) = '1998' GROUP BY T1.CompanyName ORDER BY COUNT(T2.OrderID) DESC LIMIT 1;

SELECT COUNT(T2.CustomerID) FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID WHERE STRFTIME('%Y', T2.OrderDate) = '1996' GROUP BY T1.Country;

SELECT COUNT(T2.OrderID) FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID WHERE STRFTIME('%Y', T2.OrderDate) = '1999' AND T1.CompanyName = 'Hanna Moos';

SELECT datediff(T2.ShippedDate, T2.OrderDate) FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.CompanyName = 'Berglunds snabbkp' ORDER BY datediff(T2.ShippedDate, T2.OrderDate) LIMIT 1;

SELECT T1.CompanyName FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.OrderID = 10257;

SELECT STRFTIME('%Y', T2.OrderDate) FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.CompanyName = 'Around the Horn' GROUP BY STRFTIME('%Y', T2.OrderDate) ORDER BY COUNT(T2.OrderID) DESC LIMIT 1;

SELECT COUNT(EmployeeID) FROM Employees WHERE ReportsTo = ( SELECT EmployeeID FROM Employees WHERE LastName = 'Fuller' AND FirstName = 'Andrew' );

SELECT Country FROM Suppliers GROUP BY Country ORDER BY COUNT(SupplierID) DESC LIMIT 1;

SELECT FirstName, LastName FROM Employees WHERE ReportsTo = ( SELECT EmployeeID FROM Employees WHERE Title = 'Sales Manager' );

SELECT COUNT(OrderID) FROM Orders WHERE OrderDate LIKE '1996-08%' GROUP BY CustomerID ORDER BY COUNT(OrderID) DESC LIMIT 1;

SELECT Salary FROM Employees WHERE HireDate = ( SELECT MIN(HireDate) FROM Employees );

SELECT MAX(TIMESTAMPDIFF(YEAR, BirthDate, HireDate)) FROM Employees;

SELECT SUM(T2.UnitPrice * T2.Quantity) FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID WHERE T1.Discontinued = 1;

SELECT T2.CategoryName FROM Products AS T1 INNER JOIN Categories AS T2 ON T1.CategoryID = T2.CategoryID WHERE T1.Discontinued = 1 GROUP BY T2.CategoryName ORDER BY COUNT(T1.ProductID) DESC LIMIT 1;

SELECT COUNT(T2.ProductID) FROM Categories AS T1 INNER JOIN Products AS T2 ON T1.CategoryID = T2.CategoryID INNER JOIN `Order Details` AS T3 ON T2.ProductID = T3.ProductID INNER JOIN Orders AS T4 ON T3.OrderID = T4.OrderID WHERE T1.CategoryName = 'Condiments' AND T1.CategoryID = 2 AND T4.OrderDate LIKE '1997%';

SELECT T1.CompanyName FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN `Order Details` AS T3 ON T2.OrderID = T3.OrderID GROUP BY T1.CompanyName ORDER BY COUNT(T3.ProductID) DESC LIMIT 1;

SELECT CAST(SUM(T1.ShipVia) AS REAL) / 12 FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T2.CompanyName = 'Federal Shipping' AND T1.ShippedDate LIKE '1996%';

SELECT T1.ProductName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName LIKE 'G%day, Mate';

SELECT COUNT(T2.RegionDescription), T1.TerritoryDescription, COUNT(*) AS num FROM Territories AS T1 INNER JOIN Region AS T2 ON T1.RegionID = T2.RegionID GROUP BY T1.TerritoryDescription ORDER BY num DESC LIMIT 1;

SELECT T2.CompanyName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.UnitPrice = ( SELECT MAX(UnitPrice) FROM Products );

SELECT COUNT(EID) FROM ( SELECT T1.EmployeeID AS EID FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T1.TitleOfCourtesy IN ('Ms.' OR 'Mrs.') GROUP BY T1.EmployeeID HAVING COUNT(T2.TerritoryID) >= 3 ) T1;

SELECT T2.CompanyName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID ORDER BY T1.ReorderLevel DESC LIMIT 8;

SELECT T1.CompanyName FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN `Order Details` AS T3 ON T2.OrderID = T3.OrderID WHERE T3.Discount = 0 GROUP BY T1.CompanyName ORDER BY SUM(T3.UnitPrice * T3.Quantity) DESC LIMIT 1;

SELECT SUM(T3.UnitPrice * T3.Quantity) FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN `Order Details` AS T3 ON T2.OrderID = T3.OrderID WHERE T1.FirstName = 'Nancy' AND T1.LastName = 'Davolio' AND T2.OrderDate LIKE '1996-12%' AND T3.Discount = 0;

SELECT SUM(T2.UnitPrice * T2.Quantity * (1 - T2.Discount)) FROM Orders AS T1 INNER JOIN `Order Details` AS T2 ON T1.OrderID = T2.OrderID WHERE T1.OrderDate LIKE '1997%';

SELECT SUM(T2.UnitPrice * T2.Quantity * (1 - T2.Discount)) / 3 FROM Orders AS T1 INNER JOIN `Order Details` AS T2 ON T1.OrderID = T2.OrderID WHERE T1.ShippedDate BETWEEN '1996-01-01 00:00:00' AND '1998-12-31 23:59:59';

SELECT COUNT(OrderID) FROM Orders WHERE ShipCountry = 'Venezuela' AND STRFTIME('%Y', ShippedDate) = '1996';

SELECT CategoryID, Description FROM Categories WHERE CategoryName = 'Condiments';

SELECT ProductID, OrderID, UnitPrice FROM `Order Details` WHERE UnitPrice * Quantity * (1 - Discount) > 15000;

SELECT TerritoryID FROM EmployeeTerritories WHERE EmployeeID = 7;

SELECT CompanyName, HomePage FROM Suppliers WHERE City = 'Sydney';

SELECT FirstName, LastName , TIMESTAMPDIFF(YEAR, BirthDate, HireDate) AS AGE FROM Employees WHERE Title = 'Vice President, Sales';

SELECT CompanyName FROM Suppliers WHERE Country = 'Germany';

SELECT TitleOfCourtesy, FirstName, LastName , TIMESTAMPDIFF(YEAR, BirthDate, NOW()) AS ages FROM Employees WHERE City = 'London';

SELECT CompanyName, Address, Phone, Fax FROM Customers WHERE City = 'London';

SELECT FirstName, LastName, Title FROM Employees WHERE ReportsTo = ( SELECT EmployeeID FROM Employees WHERE Title = 'Sales Manager' );

SELECT CompanyName, City FROM Customers WHERE Country = 'Canada';

SELECT UnitsInStock + UnitsOnOrder, ProductName FROM Products WHERE QuantityPerUnit = '10 - 500 g pkgs.';

SELECT T2.ProductName, T1.CategoryName FROM Categories AS T1 INNER JOIN Products AS T2 ON T1.CategoryID = T2.CategoryID ORDER BY T2.ReorderLevel DESC LIMIT 1;

SELECT T2.CompanyName, T2.City, T1.ProductName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.UnitsInStock + UnitsOnOrder > 120;

SELECT T2.ContactName, T2.ContactTitle, T1.ProductName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Escargots Nouveaux';

SELECT T3.TerritoryID, T3.TerritoryDescription, T4.RegionDescription FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID INNER JOIN Region AS T4 ON T3.RegionID = T4.RegionID WHERE T1.TitleOfCourtesy = 'Mrs.' AND T1.LastName = 'Peacock' AND T1.FirstName = 'Margaret';

SELECT T1.ProductName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.Country = 'Spain';

SELECT T3.ProductName FROM Orders AS T1 INNER JOIN `Order Details` AS T2 ON T1.OrderID = T2.OrderID INNER JOIN Products AS T3 ON T2.ProductID = T3.ProductID WHERE T1.RequiredDate LIKE '1998-03-26%' AND T1.CustomerID = 'WILMK';

SELECT T2.ProductName, T1.CategoryName FROM Categories AS T1 INNER JOIN Products AS T2 ON T1.CategoryID = T2.CategoryID WHERE T2.ReorderLevel = ( SELECT MAX(ReorderLevel) FROM Products );

SELECT COUNT(T2.OrderID) FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Country = 'Ireland';

SELECT T4.ProductName FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN `Order Details` AS T3 ON T2.OrderID = T3.OrderID INNER JOIN Products AS T4 ON T3.ProductID = T4.ProductID WHERE T1.Country = 'Norway' AND STRFTIME('%Y', T2.OrderDate) = '1996';

SELECT T5.CompanyName FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN `Order Details` AS T3 ON T2.OrderID = T3.OrderID INNER JOIN Products AS T4 ON T3.ProductID = T4.ProductID INNER JOIN Suppliers AS T5 ON T4.SupplierID = T5.SupplierID WHERE T1.FirstName = 'Anne' AND T1.LastName = 'Dodsworth' AND T2.ShipCountry = 'Brazil' AND T2.OrderDate LIKE '1996-12%';

SELECT T1.FirstName, T1.LastName, T1.Title, T1.Salary , COUNT(T2.OrderID) FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE ShipCountry = 'USA' GROUP BY T1.FirstName, T1.LastName, T1.Title, T1.Salary, T1.BirthDate ORDER BY T1.BirthDate LIMIT 1;

SELECT T1.TerritoryID, T1.TerritoryDescription FROM Territories AS T1 INNER JOIN Region AS T2 ON T1.RegionID = T2.RegionID WHERE T2.RegionDescription = 'Southern';

SELECT SUM(T2.UnitPrice * T2.Quantity * (1 - T2.Discount)) / COUNT(T1.ProductID) FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID INNER JOIN Categories AS T3 ON T1.CategoryID = T3.CategoryID WHERE T3.CategoryName = 'Confections';

SELECT SUM(T3.UnitPrice * T3.Quantity * (1 - T3.Discount)) AS TOTALPAYMENT FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN `Order Details` AS T3 ON T2.OrderID = T3.OrderID WHERE T1.City = 'San Francisco';

SELECT SUM(T1.UnitsInStock + T1.UnitsOnOrder) FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.Country = 'Japan';

SELECT T2.ProductName, T3.CategoryName FROM Suppliers AS T1 INNER JOIN Products AS T2 ON T1.SupplierID = T2.SupplierID INNER JOIN Categories AS T3 ON T2.CategoryID = T3.CategoryID WHERE T1.Country = 'Australia' AND T2.Discontinued = 1;

SELECT T3.Country, T1.OrderID FROM `Order Details` AS T1 INNER JOIN Products AS T2 ON T1.ProductID = T2.ProductID INNER JOIN Suppliers AS T3 ON T2.SupplierID = T3.SupplierID WHERE T2.ProductName = 'Ipoh Coffee' ORDER BY T1.UnitPrice * T1.Quantity * (1 - T1.Discount) DESC LIMIT 1;

SELECT T1.ProductName , SUM(T2.UnitPrice * T2.Quantity * (1 - T2.Discount)) FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID WHERE T2.OrderID = 10979 GROUP BY T1.ProductName;

SELECT DISTINCT T1.ContactName, T1.ContactTitle FROM Suppliers AS T1 INNER JOIN Products AS T2 ON T1.SupplierID = T2.SupplierID INNER JOIN Categories AS T3 ON T2.CategoryID = T3.CategoryID WHERE T3.CategoryName = 'Grains/Cereals' AND T1.SupplierID BETWEEN 1 AND 10 LIMIT 1;

SELECT T2.Phone, COUNT(T1.OrderID) FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T2.CompanyName = 'Speedy Express' AND T1.ShippedDate LIKE '1998-01-30%' GROUP BY T2.Phone;

SELECT DISTINCT T3.ProductName FROM Orders AS T1 INNER JOIN `Order Details` AS T2 ON T1.OrderID = T2.OrderID INNER JOIN Products AS T3 ON T2.ProductID = T3.ProductID WHERE DATEDIFF(T1.ShippedDate, T1.RequiredDate) < 0;

SELECT T4.ProductName FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN `Order Details` AS T3 ON T2.OrderID = T3.OrderID INNER JOIN Products AS T4 ON T3.ProductID = T4.ProductID WHERE T1.Title = 'Inside Sales Coordinator' AND T2.ShippedDate LIKE '1996%' AND T2.ShipCountry = 'Mexico';

SELECT T2.ProductName FROM Categories AS T1 INNER JOIN Products AS T2 ON T1.CategoryID = T2.CategoryID WHERE T1.CategoryName = 'Dairy Products' AND T2.ReorderLevel = ( SELECT MAX(ReorderLevel) FROM Products );

SELECT SUM(UnitsInStock + UnitsOnOrder) FROM Products WHERE ProductName = 'Mascarpone Fabioli';

SELECT T2.ProductName, T1.CategoryName FROM Categories AS T1 INNER JOIN Products AS T2 ON T1.CategoryID = T2.CategoryID WHERE T2.UnitPrice IN (( SELECT MIN(UnitPrice) FROM Products ), ( SELECT MAX(UnitPrice) FROM Products ));

SELECT T1.CompanyName FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN `Order Details` AS T3 ON T2.OrderID = T3.OrderID GROUP BY T2.CustomerID ORDER BY SUM(T3.UnitPrice * T3.Quantity * (1 - T3.Discount)) DESC LIMIT 1;

SELECT COUNT(T2.EmployeeID) FROM Territories AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.TerritoryID = T2.TerritoryID INNER JOIN Region AS T3 ON T1.RegionID = T3.RegionID WHERE T3.RegionDescription = 'Northern';

SELECT SUM(UnitPrice * Quantity * (1 - Discount)) / COUNT(OrderID) FROM `Order Details`;

SELECT CAST(COUNT(CASE WHEN Discontinued = 1 THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(ProductID) FROM Products;

SELECT T1.FirstName, T1.LastName FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T2.OrderID = 10274;

SELECT COUNT(T2.OrderID) FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.CompanyName = 'GROSELLA-Restaurante';

SELECT T4.ProductName, T3.Quantity FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN `Order Details` AS T3 ON T2.OrderID = T3.OrderID INNER JOIN Products AS T4 ON T3.ProductID = T4.ProductID INNER JOIN Customers AS T5 ON T2.CustomerID = T5.CustomerID WHERE T1.FirstName = 'Nancy' AND T1.LastName = 'Davolio' AND T5.CompanyName = 'GROSELLA-Restaurante';

SELECT COUNT(T2.OrderID) , SUM(T3.UnitPrice * T3.Quantity * (1 - T3.Discount)) / COUNT(T2.OrderID) FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN `Order Details` AS T3 ON T2.OrderID = T3.OrderID WHERE T1.CompanyName = 'Laughing Bacchus Wine Cellars';

SELECT COUNT(T2.Quantity) FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID WHERE T1.ProductName = 'Pavlova';

SELECT ( SELECT MIN(Salary) FROM Employees WHERE Title = 'Sales Representative' ) AS MIN , ( SELECT MAX(Salary) FROM Employees WHERE Title = 'Sales Representative' ) AS MAX;

SELECT COUNT(SupplierID) FROM Suppliers WHERE Country = 'USA';

SELECT ProductName FROM Products WHERE Discontinued = 1;

SELECT ContactName FROM Customers WHERE CompanyName = 'Eastern Connection' AND ContactTitle = 'Sales Agent';

SELECT COUNT(ShipperID) FROM Shippers;

SELECT CAST(COUNT(CASE WHEN T2.ShipCountry = 'Austria' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T2.OrderID) FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T1.FirstName = 'Andrew' AND T1.LastName = 'Fuller';

SELECT CategoryName FROM Categories WHERE Description = 'Soft drinks, coffees, teas, beers, and ales';

SELECT Phone FROM Customers WHERE CompanyName = 'Around the Horn';

SELECT Fax FROM Customers WHERE CompanyName = 'Blondesddsl pre et fils' AND City = 'Strasbourg';

SELECT COUNT(CompanyName) FROM Customers WHERE City = 'London';

SELECT Address FROM Customers WHERE CompanyName = 'Eastern Connection' AND ContactName = 'Ann Devon';

SELECT CompanyName FROM Customers WHERE Country = 'France';

SELECT COUNT(T1.ProductName) FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Exotic Liquids';

SELECT T2.CompanyName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.UnitPrice = ( SELECT MAX(UnitPrice) FROM Products );

SELECT T2.CompanyName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.City = 'London' ORDER BY T1.UnitsInStock DESC LIMIT 1;

SELECT T1.ProductName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Exotic Liquids' ORDER BY T1.ReorderLevel DESC LIMIT 1;

SELECT T3.CategoryName FROM Suppliers AS T1 INNER JOIN Products AS T2 ON T1.SupplierID = T2.SupplierID INNER JOIN Categories AS T3 ON T2.CategoryID = T3.CategoryID WHERE T1.CompanyName = 'New Orleans Cajun Delights' AND T2.ProductName LIKE 'Chef Anton%s Gumbo Mix';

SELECT T2.Country FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.ProductName = 'Ipoh Coffee' AND T2.CompanyName = 'Leka Trading';

SELECT T2.CategoryName FROM Products AS T1 INNER JOIN Categories AS T2 ON T1.CategoryID = T2.CategoryID WHERE T1.UnitsOnOrder = ( SELECT MAX(T1.UnitsOnOrder) FROM Products );

SELECT ( SELECT T1.UnitPrice FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'New Orleans Cajun Delights' AND T1.ProductName LIKE 'Chef Anton%s Cajun Seasoning' ) - ( SELECT T1.UnitPrice FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'New Orleans Cajun Delights' AND T1.ProductName LIKE 'Chef Anton%s Gumbo Mix' ) AS calu;

SELECT T1.ProductName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName LIKE 'Cooperativa de Quesos%' AND T1.UnitPrice > 20;

SELECT DISTINCT T2.ProductName FROM Suppliers AS T1 INNER JOIN Products AS T2 ON T1.SupplierID = T2.SupplierID INNER JOIN `Order Details` AS T3 ON T2.ProductID = T3.ProductID WHERE T1.CompanyName = 'Tokyo Traders' AND T3.Quantity > 40;

SELECT T3.CategoryName FROM Suppliers AS T1 INNER JOIN Products AS T2 ON T1.SupplierID = T2.SupplierID INNER JOIN Categories AS T3 ON T2.CategoryID = T3.CategoryID WHERE T2.UnitsInStock > 100 AND T1.CompanyName = 'Exotic Liquids';

SELECT SUM(CASE WHEN T2.Quantity < 50 THEN 1 ELSE 0 END) , CAST(SUM(IF(T2.Quantity < 50, 1, 0)) AS REAL) / COUNT(T1.ProductID) FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID;

SELECT SUM(IF(T1.ProductName = 'Geitost', 1, 0)) AS sum , CAST(SUM(IF(T1.ProductName = 'Geitost', 1, 0)) AS REAL) / COUNT(T1.ProductID) FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID;

SELECT Title FROM Employees WHERE FirstName = 'Robert' AND LastName = 'King';

SELECT CompanyName FROM Shippers WHERE Phone = '(503) 555-9931';

SELECT Address, HomePhone FROM Employees WHERE FirstName = 'Margaret' AND LastName = 'Peacock';

SELECT DISTINCT ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry FROM Orders WHERE ShipName = 'Rattlesnake Canyon Grocery';

SELECT T1.ProductName FROM Products AS T1 INNER JOIN Categories AS T2 ON T1.CategoryID = T2.CategoryID WHERE T2.CategoryName = 'Confections';

SELECT T2.CompanyName, T2.ContactName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T1.ProductName LIKE 'Sir Rodney%s Marmalade';

SELECT T1.FirstName, T1.LastName FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID WHERE T3.TerritoryDescription = 'Denver';

SELECT T3.TerritoryDescription FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID WHERE T1.FirstName = 'Laura' AND T1.LastName = 'Callahan';

SELECT COUNT(T1.OrderID) FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T2.CompanyName = 'Federal Shipping' AND T1.ShipVia = 3;

SELECT T1.ProductName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.Country = 'Finland';

SELECT T2.CategoryName, T2.Description FROM Products AS T1 INNER JOIN Categories AS T2 ON T1.CategoryID = T2.CategoryID WHERE T1.ProductName = 'Mozzarella di Giovanni';

SELECT DISTINCT T1.CompanyName FROM Suppliers AS T1 INNER JOIN Products AS T2 ON T1.SupplierID = T2.SupplierID INNER JOIN Categories AS T3 ON T2.CategoryID = T3.CategoryID WHERE T3.Description = 'Cheeses';

SELECT T1.ProductName FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Zaanse Snoepfabriek';

SELECT T1.UnitPrice FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Plutzer Lebensmittelgromrkte AG' AND T1.Discontinued = 1;

SELECT T1.ShipCity FROM Orders AS T1 INNER JOIN `Order Details` AS T2 ON T1.OrderID = T2.OrderID INNER JOIN Products AS T3 ON T2.ProductID = T3.ProductID WHERE T3.ProductName = 'Mishi Kobe Niku';

SELECT CAST(COUNT(CASE WHEN T1.ShipCountry = 'Sweden' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T1.OrderID) FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T2.CompanyName = 'Speedy Express';

SELECT COUNT(TerritoryID) FROM Territories WHERE RegionID = 1;

SELECT COUNT(TerritoryDescription) FROM Territories WHERE RegionID IN (1, 2, 3, 4) GROUP BY RegionID;

SELECT COUNT(SupplierID) FROM Suppliers WHERE Country = 'UK';

SELECT ContactName FROM Suppliers WHERE CompanyName = 'Tokyo Traders';

SELECT COUNT(Country) FROM Employees WHERE Country = 'USA' AND Title = 'Sales Representative';

SELECT Salary, Title FROM Employees WHERE Salary = ( SELECT MAX(Salary) FROM Employees );

SELECT COUNT(T1.ProductID) FROM Products AS T1 INNER JOIN Suppliers AS T2 ON T1.SupplierID = T2.SupplierID WHERE T2.CompanyName = 'Plutzer Lebensmittelgromrkte AG' AND T1.UnitsInStock = 0 AND T1.UnitsOnOrder = 0;

SELECT T1.ProductName, T2.Quantity FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID ORDER BY T1.UnitPrice DESC LIMIT 1;

SELECT T1.Title FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID GROUP BY T1.Title ORDER BY COUNT(T2.OrderID) LIMIT 1;

SELECT T2.ProductID FROM Customers AS T1 INNER JOIN `Order Details` AS T2 WHERE T1.Country = 'Germany' GROUP BY T2.ProductID ORDER BY COUNT(T2.ProductID) DESC LIMIT 1;

SELECT SUM(T2.Quantity * T2.UnitPrice) FROM Orders AS T1 INNER JOIN `Order Details` AS T2 ON T1.OrderID = T2.OrderID INNER JOIN Shippers AS T3 ON T1.ShipVia = T3.ShipperID WHERE T3.CompanyName = 'Speedy Express' AND T1.ShipCountry = 'Brazil';

SELECT COUNT(T1.EmployeeID), SUM(T3.Quantity * T3.UnitPrice) FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN `Order Details` AS T3 ON T2.OrderID = T3.OrderID WHERE T1.ReportsTo = 2 ORDER BY SUM(T3.UnitPrice * T3.Quantity) DESC LIMIT 1;

SELECT SUM(T3.UnitPrice * T3.Quantity) FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN `Order Details` AS T3 ON T2.OrderID = T3.OrderID WHERE T1.Title = 'Sales Representative' ORDER BY SUM(T3.UnitPrice * T3.Quantity);

SELECT COUNT(T1.EmployeeID), T3.RegionID FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID WHERE T1.Country = 'UK' GROUP BY T3.RegionID;

SELECT T1.CompanyName, T2.ShipCountry FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN `Order Details` AS T3 ON T2.OrderID = T3.OrderID GROUP BY T1.CompanyName, T2.ShipCountry ORDER BY COUNT(T3.ProductID) DESC LIMIT 1;

SELECT T1.CustomerID, T4.CategoryName FROM Orders AS T1 INNER JOIN `Order Details` AS T2 ON T1.OrderID = T2.OrderID INNER JOIN Products AS T3 ON T2.ProductID = T3.ProductID INNER JOIN Categories AS T4 ON T3.CategoryID = T4.CategoryID ORDER BY T1.CustomerID DESC, T4.CategoryName DESC;

SELECT COUNT(T1.UnitPrice * T3.Quantity) FROM Products AS T1 INNER JOIN Categories AS T2 ON T1.CategoryID = T2.CategoryID INNER JOIN `Order Details` AS T3 ON T1.ProductID = T3.ProductID WHERE T2.CategoryName = 'Confections' GROUP BY T3.Quantity ORDER BY T3.Quantity DESC LIMIT 1;

SELECT ProductName FROM Products WHERE ProductID = 77;

SELECT CompanyName FROM Suppliers WHERE Country = 'USA';

SELECT Title FROM Employees WHERE FirstName = 'Laura' AND LastName = 'Callahan';

SELECT DISTINCT T1.FirstName, T1.LastName FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Customers AS T3 ON T2.CustomerID = T3.CustomerID WHERE T3.CompanyName = 'Victuailles en stock';

SELECT COUNT(T1.OrderID) FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T2.CompanyName = 'Federal Shipping';

SELECT T1.FirstName, T1.LastName FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID WHERE T3.TerritoryDescription = 'Morristown';

SELECT DISTINCT T1.TerritoryDescription FROM Territories AS T1 INNER JOIN Region AS T2 ON T1.RegionID = T2.RegionID WHERE T2.RegionDescription = 'Northern';

SELECT COUNT(T2.OrderID) FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T1.FirstName = 'Michael' AND T1.LastName = 'Suyama';

SELECT CAST(( SELECT COUNT(T1.TerritoryID) FROM Territories AS T1 INNER JOIN Region AS T2 ON T1.RegionID = T2.RegionID WHERE T2.RegionDescription = 'Northern' ) AS REAL) * 100 / ( SELECT COUNT(T1.TerritoryID) FROM Territories AS T1 INNER JOIN Region AS T2 ON T1.RegionID = T2.RegionID WHERE T2.RegionDescription = 'Westerns' ) AS Calu;

SELECT EmployeeID FROM EmployeeTerritories WHERE TerritoryID BETWEEN 1000 AND 2000;

SELECT T3.RegionID, T3.TerritoryDescription, T4.RegionDescription FROM Employees AS T1 INNER JOIN EmployeeTerritories AS T2 ON T1.EmployeeID = T2.EmployeeID INNER JOIN Territories AS T3 ON T2.TerritoryID = T3.TerritoryID INNER JOIN Region AS T4 ON T3.RegionID = T4.RegionID WHERE T1.LastName = 'Davolio' AND T1.FirstName = 'Nancy';

SELECT T1.FirstName, T1.LastName, COUNT(T2.OrderID) FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T1.Title = 'Sales Representative' AND STRFTIME('%Y', T1.HireDate) = '1992' GROUP BY T1.EmployeeID, T1.FirstName, T1.LastName;

SELECT SUM(T2.UnitPrice * T2.Quantity * (1 - T2.Discount)) AS sum FROM Products AS T1 INNER JOIN `Order Details` AS T2 ON T1.ProductID = T2.ProductID WHERE T1.ProductName = 'Vegie-spread';

SELECT T1.CompanyName FROM Suppliers AS T1 INNER JOIN Products AS T2 ON T1.SupplierID = T2.SupplierID INNER JOIN `Order Details` AS T3 ON T2.ProductID = T3.ProductID INNER JOIN Orders AS T4 ON T3.OrderID = T4.OrderID WHERE date(T4.OrderDate) = '1996-08-14';

SELECT T2.ProductName, T1.CompanyName FROM Suppliers AS T1 INNER JOIN Products AS T2 ON T1.SupplierID = T2.SupplierID INNER JOIN `Order Details` AS T3 ON T2.ProductID = T3.ProductID WHERE T3.OrderID = 10337 ORDER BY T2.ReorderLevel DESC LIMIT 1;

SELECT T1.CompanyName FROM Shippers AS T1 INNER JOIN Orders AS T2 ON T1.ShipperID = T2.ShipVia WHERE STRFTIME('%Y', T2.ShippedDate) = '1998' GROUP BY T1.CompanyName ORDER BY COUNT(T2.OrderID) DESC LIMIT 1;

SELECT COUNT(CustomerID) FROM Customers WHERE City = 'London';

SELECT Title FROM Employees WHERE FirstName = 'Michael' AND LastName = 'Suyama';

SELECT FirstName, LastName FROM Employees WHERE BirthDate = '1955-03-04 00:00:00';

SELECT T1.FirstName, T1.LastName FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T2.OrderID = 10250;

SELECT COUNT(T2.OrderID) FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T1.City = 'Tacoma';

SELECT T1.Country FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T2.OrderID = 10257;

SELECT T1.Title FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T2.OrderID = 10257;

SELECT T1.Phone FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.OrderID = 10264;

SELECT T1.Region FROM Customers AS T1 INNER JOIN Orders AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.OrderID = 10276;

SELECT T1.FirstName, T1.LastName, AVG(T1.Salary) FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T2.ShipCountry = 'Brazil' GROUP BY T1.FirstName, T1.LastName ORDER BY SUM(T1.Salary) DESC LIMIT 1;

SELECT CAST(SUM(CASE WHEN STRFTIME('%Y', T2.ShippedDate) = '1996' THEN T1.Salary ELSE 0 END) AS REAL) * 100 / SUM(T1.Salary) FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID;

SELECT T1.HireDate FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T2.OrderID = 10281;

SELECT COUNT(T2.OrderID) FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T1.ReportsTo = 5;

SELECT T1.FirstName, T1.LastName FROM Employees AS T1 INNER JOIN Orders AS T2 ON T1.EmployeeID = T2.EmployeeID WHERE T2.OrderID = 10280;

SELECT T2.CompanyName FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T1.OrderID = 10260;

SELECT COUNT(T1.OrderID) FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T2.CompanyName = 'United Package';

SELECT T2.Phone FROM Orders AS T1 INNER JOIN Shippers AS T2 ON T1.ShipVia = T2.ShipperID WHERE T1.OrderID = 10260;

