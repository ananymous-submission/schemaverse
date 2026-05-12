SELECT AVG(T2.StandardCost) FROM Product AS T1 INNER JOIN ProductCostHistory AS T2 ON T1.ProductID = T2.ProductID WHERE T1.ProductNumber = 'CA-1098';

SELECT T1.Name, T2.StartDate FROM Product AS T1 INNER JOIN ProductCostHistory AS T2 ON T1.ProductID = T2.ProductID WHERE T2.EndDate IS NULL;

SELECT T1.Name FROM Product AS T1 INNER JOIN ProductCostHistory AS T2 ON T1.ProductID = T2.ProductID WHERE T1.StandardCost - T2.StandardCost > 80 GROUP BY T1.Name;

SELECT T1.Name, T2.Quantity FROM Product AS T1 INNER JOIN ShoppingCartItem AS T2 ON T1.ProductID = T2.ProductID WHERE T2.ShoppingCartID = 14951;

SELECT T1.Name FROM Product AS T1 INNER JOIN ShoppingCartItem AS T2 ON T1.ProductID = T2.ProductID WHERE T2.Quantity > 5;

SELECT DISTINCT T1.Name FROM Product AS T1 INNER JOIN TransactionHistory AS T2 ON T1.ProductID = T2.ProductID WHERE T1.Class = 'L' AND T2.TransactionType = 'P' ORDER BY T1.Name;

SELECT DISTINCT T1.Name, T1.ListPrice FROM Product AS T1 INNER JOIN TransactionHistory AS T2 ON T1.ProductID = T2.ProductID WHERE T2.Quantity > 10000;

SELECT T1.Name FROM Product AS T1 INNER JOIN TransactionHistory AS T2 ON T1.ProductID = T2.ProductID WHERE T1.Class = 'H' ORDER BY T2.Quantity ASC LIMIT 1;

SELECT COUNT(T2.TransactionID) FROM Product AS T1 INNER JOIN TransactionHistory AS T2 ON T1.ProductID = T2.ProductID WHERE T1.ProductLine = 'M';

SELECT SUM((T1.ListPrice - T1.StandardCost) * T2.Quantity) FROM Product AS T1 INNER JOIN ShoppingCartItem AS T2 ON T1.ProductID = T2.ProductID WHERE T2.ShoppingCartID = 20621;

SELECT Name, ListPrice FROM Product WHERE Class = 'H';

SELECT ProductLine FROM Product WHERE FinishedGoodsFlag = 1 GROUP BY ProductLine ORDER BY COUNT(FinishedGoodsFlag) DESC LIMIT 1;

SELECT ProductID, Rating, Comments FROM ProductReview WHERE ReviewerName LIKE 'J%';

SELECT T1.Name, T1.ProductLine, T2.Rating, T1.ListPrice FROM Product AS T1 INNER JOIN ProductReview AS T2 ON T1.ProductID = T2.ProductID ORDER BY T2.Rating ASC LIMIT 1;

SELECT DISTINCT Name FROM Product WHERE ListPrice - StandardCost > 100;

SELECT T1.Name, T2.ReviewerName, T2.Rating, T2.Comments FROM Product AS T1 INNER JOIN ProductReview AS T2 USING (productID) WHERE T1.ProductLine = 'R';

SELECT COUNT(T1.ProductID), AVG(T2.Rating) FROM Product AS T1 INNER JOIN ProductReview AS T2 ON T1.ProductID = T2.ProductID WHERE T1.Name = 'HL Mountain Pedal';

SELECT T1.Name FROM Product AS T1 INNER JOIN PurchaseOrderDetail AS T2 ON T1.ProductID = T2.ProductID WHERE T2.RejectedQty = T2.ReceivedQty AND T2.RejectedQty <> 0;

SELECT T1.Name, T2.UnitPrice FROM Product AS T1 INNER JOIN PurchaseOrderDetail AS T2 ON T1.ProductID = T2.ProductID WHERE T2.RejectedQty = 0 ORDER BY T2.LineTotal DESC LIMIT 1;

SELECT T1.Name, T1.ProductLine FROM Product AS T1 INNER JOIN PurchaseOrderDetail AS T2 ON T1.ProductID = T2.ProductID WHERE T2.OrderQty > 4999;

SELECT SUM(T2.OrderQty) FROM Product AS T1 INNER JOIN PurchaseOrderDetail AS T2 ON T1.ProductID = T2.ProductID WHERE T1.ProductLine = 'T';

SELECT T1.Name, T2.LineTotal FROM Product AS T1 INNER JOIN PurchaseOrderDetail AS T2 ON T1.ProductID = T2.ProductID WHERE Class = 'L' ORDER BY OrderQty * UnitPrice DESC LIMIT 1;

SELECT T1.Name FROM Product AS T1 INNER JOIN ProductVendor AS T2 ON T1.ProductID = T2.ProductID ORDER BY T2.LastReceiptCost - T2.StandardPrice DESC LIMIT 1;

SELECT DISTINCT T1.Name FROM Product AS T1 INNER JOIN ProductVendor AS T2 ON T1.ProductID = T2.ProductID WHERE T2.MinOrderQty = 100 ORDER BY T1.Name DESC;

SELECT T1.Name, T1.ListPrice - T1.StandardCost FROM Product AS T1 INNER JOIN ProductReview AS T2 ON T1.ProductID = T2.ProductID ORDER BY T2.Rating DESC LIMIT 1;

SELECT SUM((T1.ListPrice - T1.StandardCost) * T2.Quantity) FROM Product AS T1 INNER JOIN TransactionHistory AS T2 ON T1.ProductID = T2.ProductID WHERE T1.ProductID = 827;

SELECT FromCurrencyCode, ToCurrencyCode FROM CurrencyRate ORDER BY AverageRate DESC LIMIT 1;

SELECT OrderQty FROM PurchaseOrderDetail ORDER BY UnitPrice DESC LIMIT 1;

SELECT Name FROM SalesTerritory WHERE CountryRegionCode = 'US' AND (Name = 'Northwest' OR Name = 'Southeast') ORDER BY SalesLastYear DESC LIMIT 1;

SELECT T1.FirstName, T1.MiddleName, T1.LastName FROM Person AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN Document AS T3 ON T3.Owner = T2.BusinessEntityID WHERE T2.JobTitle = 'Document Control Manager' AND T3.DocumentLevel = 1 AND T3.Status = 2 GROUP BY T1.FirstName, T1.MiddleName, T1.LastName;

SELECT T1.CustomerID FROM SalesOrderHeader AS T1 INNER JOIN SalesPerson AS T2 ON T1.SalesPersonID = T2.BusinessEntityID ORDER BY T1.SubTotal DESC LIMIT 1;

SELECT T2.UnitPrice * T2.OrderQty FROM SpecialOffer AS T1 INNER JOIN SalesOrderDetail AS T2 ON T1.SpecialOfferID = T2.SpecialOfferID WHERE T1.Description = 'Volume Discount 11 to 14' AND T1.SpecialOfferID = 2 AND T2.ProductID = 716 AND T2.SalesOrderID = 46625;

SELECT COUNT(T1.ProductID) FROM Product AS T1 INNER JOIN BillOfMaterials AS T2 ON T1.ProductID = T2.ProductAssemblyID WHERE T1.MakeFlag = 1 AND T1.DaysToManufacture = 1 AND T2.BOMLevel = 4 AND T1.ReorderPoint <= 600;

SELECT T2.Bonus FROM SalesTerritory AS T1 INNER JOIN SalesPerson AS T2 ON T1.TerritoryID = T2.TerritoryID WHERE T1.CountryRegionCode = 'CA' ORDER BY T2.SalesQuota DESC LIMIT 1;

SELECT T2.Name FROM ProductReview AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T1.Rating = ( SELECT Rating FROM ProductReview ORDER BY Rating ASC LIMIT 1 );

SELECT COUNT(T2.BusinessEntityID) FROM Department AS T1 INNER JOIN EmployeeDepartmentHistory AS T2 ON T1.DepartmentID = T2.DepartmentID WHERE T2.StartDate >= '2009-01-01' AND T2.StartDate < '2010-01-01' AND T1.Name = 'Production';

SELECT T3.FirstName, T3.MiddleName, T3.LastName, T1.JobTitle FROM Employee AS T1 INNER JOIN EmployeePayHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN Person AS T3 ON T2.BusinessEntityID = T3.BusinessEntityID WHERE T1.MaritalStatus = 'S' AND T1.Gender = 'F' ORDER BY T2.Rate DESC LIMIT 1;

SELECT T2.FirstName, T2.MiddleName, T2.LastName, T1.HireDate FROM Employee AS T1 INNER JOIN Person AS T2 USING (BusinessEntityID) WHERE T1.JobTitle = 'Vice President of Engineering';

SELECT COUNT(T1.BusinessEntityID) FROM Employee AS T1 INNER JOIN EmployeePayHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.CurrentFlag = 1 AND T2.Rate <= 30;

SELECT T1.Name FROM Department AS T1 INNER JOIN EmployeeDepartmentHistory AS T2 ON T1.DepartmentID = T2.DepartmentID ORDER BY T2.StartDate DESC LIMIT 1;

SELECT T2.FirstName, T2.MiddleName, T2.LastName, T1.Gender FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.PersonType = 'SP';

SELECT T2.PayFrequency FROM Employee AS T1 INNER JOIN EmployeePayHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID ORDER BY T1.SickLeaveHours ASC LIMIT 1;

SELECT T1.JobTitle FROM Employee AS T1 INNER JOIN EmployeePayHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID ORDER BY T2.Rate ASC LIMIT 1;

SELECT COUNT(T2.BusinessEntityID) FROM Department AS T1 INNER JOIN EmployeeDepartmentHistory AS T2 USING (DepartmentID) WHERE T1.Name = 'Finance';

SELECT ( SELECT ListPrice - StandardCost FROM Product WHERE ListPrice != 0 ORDER BY ListPrice DESC LIMIT 1 ) , ( SELECT ListPrice - StandardCost FROM Product WHERE ListPrice != 0 ORDER BY ListPrice LIMIT 1 );

SELECT T2.Name, T1.LastReceiptCost - T1.StandardPrice FROM ProductVendor AS T1 INNER JOIN Vendor AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.CreditRating = 3;

SELECT COUNT(*) FROM Address WHERE AddressLine2 <> '';

SELECT PostalCode FROM Address ORDER BY ModifiedDate DESC LIMIT 1;

SELECT JULIANDAY(EndDate) - JULIANDAY(StartDate) FROM BillOfMaterials ORDER BY JULIANDAY(EndDate) - JULIANDAY(StartDate) DESC LIMIT 1;

SELECT COUNT(BillOfMaterialsID) FROM BillOfMaterials WHERE EndDate IS NULL;

SELECT UnitMeasureCode FROM BillOfMaterials ORDER BY PerAssemblyQty DESC LIMIT 1;

SELECT COUNT(DocumentNode) FROM Document WHERE DocumentSummary IS NULL;

SELECT Title FROM Document WHERE Status = 1;

SELECT DISTINCT T2.BusinessEntityID, T2.JobTitle FROM Document AS T1 INNER JOIN Employee AS T2 ON T1.Owner = T2.BusinessEntityID WHERE T1.Status = 2;

SELECT T1.PayFrequency FROM EmployeePayHistory AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID ORDER BY T2.BirthDate ASC LIMIT 1;

SELECT COUNT(T1.BusinessEntityID) FROM EmployeePayHistory AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.MaritalStatus = 'M' AND T1.PayFrequency = ( SELECT PayFrequency FROM EmployeePayHistory ORDER BY PayFrequency DESC LIMIT 1 );

SELECT T1.Rate FROM EmployeePayHistory AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID ORDER BY T2.HireDate DESC LIMIT 1;

SELECT SUM(CASE WHEN T2.Gender = 'M' THEN 1 ELSE 0 END) FROM EmployeePayHistory AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.Rate > 40;

SELECT T1.Rate FROM EmployeePayHistory AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.SalariedFlag = 1 ORDER BY T1.Rate DESC LIMIT 1;

SELECT T2.VacationHours FROM EmployeePayHistory AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.BusinessEntityID = ( SELECT BusinessEntityID FROM EmployeePayHistory ORDER BY Rate DESC LIMIT 1 );

SELECT T1.Rate FROM EmployeePayHistory AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID ORDER BY T2.VacationHours DESC LIMIT 1;

SELECT COUNT(T1.BusinessEntityID) FROM EmployeePayHistory AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.SickLeaveHours > 10 AND T1.Rate > 35;

SELECT COUNT(T1.BusinessEntityID) FROM EmployeePayHistory AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.CurrentFlag = 1 AND T2.Gender = 'M' AND T1.PayFrequency = 2;

SELECT COUNT(T1.BusinessEntityID) FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.Gender = 'M' AND T2.PersonType = 'SP';

SELECT T2.PersonType FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID ORDER BY T1.BirthDate ASC LIMIT 1;

SELECT T2.NameStyle FROM EmployeePayHistory AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.Rate IS NOT NULL ORDER BY T1.Rate ASC LIMIT 1;

SELECT COUNT(T1.BusinessEntityID) FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.NameStyle = 0 AND T1.MaritalStatus = 'M';

SELECT COUNT(T1.BusinessEntityID) FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.EmailPromotion = 1 AND T1.SickLeaveHours > 10;

SELECT T1.BusinessEntityID FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.EmailPromotion = 1 AND T1.VacationHours > 20;

SELECT T2.AdditionalContactInfo FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE PersonType = 'SP' ORDER BY T1.BirthDate ASC LIMIT 1;

SELECT T2.FirstName FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.NameStyle = 0 AND T1.Gender = 'M';

SELECT COUNT(T1.BusinessEntityID) FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.CurrentFlag = 1 AND T2.Title = 'Mr.';

SELECT T2.Demographics FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN EmployeePayHistory AS T3 ON T2.BusinessEntityID = T3.BusinessEntityID WHERE T1.MaritalStatus = 'M' ORDER BY T3.Rate DESC LIMIT 1;

SELECT T2.Suffix FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.PersonType = 'SP' ORDER BY T1.SickLeaveHours DESC LIMIT 1;

SELECT COUNT(T1.BusinessEntityID) FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN EmployeePayHistory AS T3 ON T2.BusinessEntityID = T3.BusinessEntityID WHERE T1.MaritalStatus = 'M' AND T2.NameStyle = 1 AND T3.Rate = ( SELECT Rate FROM EmployeePayHistory ORDER BY Rate DESC LIMIT 1 );

SELECT COUNT(T1.BusinessEntityID) FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.CurrentFlag = 1 AND T2.EmailPromotion = 1;

SELECT T2.CreditCardID FROM Person AS T1 INNER JOIN PersonCreditCard AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.PersonType = 'SC';

SELECT CAST(SUM(T1.VacationHours) AS REAL) / COUNT(T1.BusinessEntityID) FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.Gender = 'M' AND T2.PersonType = 'EM';

SELECT MAX(T1.Rate) - SUM(T1.Rate) / COUNT(T1.BusinessEntityID) FROM EmployeePayHistory AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN Employee AS T3 ON T2.BusinessEntityID = T3.BusinessEntityID WHERE T2.EmailPromotion = 2 AND T3.MaritalStatus = 'M';

SELECT CAST(COUNT(IIF(T1.PersonType = 'SC', T1.PersonType, NULL)) AS REAL) / COUNT(T1.PersonType) FROM Person AS T1 INNER JOIN Employee AS T2 WHERE T1.PersonType = 'SC' AND T1.NameStyle = 0 AND T2.MaritalStatus = 'M';

SELECT CAST(SUM(CASE WHEN T2.VacationHours > 20 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.BusinessEntityID) FROM EmployeePayHistory AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.CurrentFlag = 1 AND T2.SickLeaveHours > 10;

SELECT SUM(LastReceiptCost) / COUNT(ProductID) FROM ProductVendor WHERE AverageLeadTime = 60;

SELECT CAST(SUM(ActualCost) AS REAL) / COUNT(TransactionID) FROM TransactionHistoryArchive WHERE TransactionType = 'P' AND TransactionDate >= '2012-01-01' AND TransactionDate < '2012-07-01';

SELECT CAST(SUM(CASE WHEN MaritalStatus = 'M' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(BusinessEntityID) FROM Employee WHERE SUBSTR(HireDate, 1, 4) = '2009' AND Gender = 'M';

SELECT CAST(SUM(CASE WHEN EmailPromotion = 2 THEN 1 ELSE 0 END) AS REAL) * 100 / SUM(CASE WHEN PersonType = 'SC' THEN 1 ELSE 0 END) FROM Person WHERE FirstName = 'Mary';

SELECT DISTINCT ProductID FROM ProductVendor WHERE StandardPrice - LastReceiptCost < 0;

SELECT SUM(TotalDue) / COUNT(TotalDue) FROM PurchaseOrderHeader WHERE Status = 2;

SELECT CAST(SUM(CASE WHEN OrderQty < 3 AND UnitPriceDiscount = 0.2 THEN 1 ELSE 0 END) AS REAL) / COUNT(SalesOrderID) FROM SalesOrderDetail;

SELECT BusinessEntityID FROM SalesPerson WHERE SalesYTD > SalesLastYear + SalesLastyear * 0.6 AND Bonus > 3000;

SELECT SUM(CASE WHEN T2.Name = 'Home' THEN 1 ELSE 0 END) , SUM(CASE WHEN T2.Name = 'Shipping' THEN 1 ELSE 0 END) FROM BusinessEntityAddress AS T1 INNER JOIN AddressType AS T2 ON T1.AddressTypeID = T2.AddressTypeID;

SELECT T2.CustomerID FROM SalesOrderDetail AS T1 INNER JOIN Customer AS T2 WHERE T1.UnitPrice = 35 AND T1.OrderQty = 32;

SELECT T2.BusinessEntityID FROM CreditCard AS T1 INNER JOIN PersonCreditCard AS T2 ON T1.CreditCardID = T2.CreditCardID WHERE T1.CardType = 'ColonialVoice' AND T1.ExpMonth = 3 AND T1.ExpYear = 2005;

SELECT T2.CreditRating FROM ProductVendor AS T1 INNER JOIN Vendor AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.StandardPrice = 18.9900 AND T1.AverageLeadTime = 16 AND STRFTIME('%Y-%m-%d', T1.LastReceiptDate) = '2011-08-27';

SELECT COUNT(ProductID) FROM Product WHERE Name LIKE '%accessories %' OR Name LIKE '%components%';

SELECT T1.JobTitle FROM Employee AS T1 INNER JOIN EmployeeDepartmentHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.DepartmentID = 12 ORDER BY T2.StartDate DESC LIMIT 1;

SELECT T2.FirstName, T2.LastName FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.MaritalStatus = 'S' AND T1.Gender = 'M' AND T1.JobTitle LIKE 'Production Supervisor%';

SELECT COUNT(T1.LocationID) FROM Location AS T1 INNER JOIN ProductInventory AS T2 USING (LocationID) WHERE T1.Name = 'Subassembly';

SELECT SUM(T2.ScrappedQty) FROM ScrapReason AS T1 INNER JOIN WorkOrder AS T2 ON T1.ScrapReasonID = T2.ScrapReasonID WHERE T1.Name = 'Trim length too long';

SELECT SUM(T2.OrderQty) FROM PurchaseOrderHeader AS T1 INNER JOIN PurchaseOrderDetail AS T2 ON T1.PurchaseOrderID = T2.PurchaseOrderID WHERE T1.Status = 1;

SELECT COUNT(DISTINCT T1.ProductID) FROM SalesOrderDetail AS T1 INNER JOIN SpecialOfferProduct AS T2 ON T1.SpecialOfferID = T2.SpecialOfferID INNER JOIN SpecialOffer AS T3 ON T2.SpecialOfferID = T3.SpecialOfferID WHERE T1.OrderQty > 2 AND T1.UnitPriceDiscount = 0;

SELECT DISTINCT T2.TransactionType FROM Product AS T1 INNER JOIN TransactionHistory AS T2 ON T1.ProductID = T2.ProductID WHERE T1.Size = 62 AND T1.Color = 'Yellow' AND T1.SafetyStockLevel = 500;

SELECT T1.Name FROM ProductSubcategory AS T1 INNER JOIN Product AS T2 USING (ProductSubcategoryID) WHERE T2.Color = 'Grey' GROUP BY T1.Name;

SELECT T2.EndDate FROM Product AS T1 INNER JOIN ProductCostHistory AS T2 ON T1.ProductID = T2.ProductID WHERE T1.WeightUnitMeasureCode = 'G' ORDER BY T1.Weight DESC LIMIT 1;

SELECT CAST(SUM(CASE WHEN T2.VacationHours > 20 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.BusinessEntityID) FROM EmployeePayHistory AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.CurrentFlag = 1 AND T2.SickLeaveHours > 10;

SELECT CAST(SUM(IIF(T1.ShipMethodID = 5, T3.OrderQty, 0)) AS REAL) / COUNT(T3.ProductID) FROM ShipMethod AS T1 INNER JOIN PurchaseOrderHeader AS T2 ON T1.ShipMethodID = T2.ShipMethodID INNER JOIN PurchaseOrderDetail AS T3 ON T2.PurchaseOrderID = T3.PurchaseOrderID;

SELECT T2.Name FROM SalesTerritory AS T1 INNER JOIN StateProvince AS T2 ON T1.CountryRegionCode = T2.CountryRegionCode INNER JOIN SalesTaxRate AS T3 ON T2.StateProvinceID = T3.StateProvinceID ORDER BY (T1.SalesYTD - T1.SalesLastYear) / T1.SalesLastYear DESC LIMIT 1;

SELECT COUNT(BusinessEntityID) FROM EmployeePayHistory WHERE rate * PayFrequency > 50;

SELECT FirstName, MiddleName, LastName FROM Person WHERE BusinessEntityID = 1 AND PersonType = 'EM';

SELECT NAME FROM Vendor WHERE BusinessEntityID = 1492;

SELECT COUNT(*) FROM ProductVendor WHERE MinOrderQty > 500 AND MaxOrderQty < 15000;

SELECT Name FROM Department WHERE GroupName = 'Executive General and Administration';

SELECT LastName FROM Person WHERE PersonType = 'EM' AND MiddleName LIKE 'C%';

SELECT COUNT(DISTINCT BusinessEntityID) FROM ProductVendor WHERE AverageLeadTime = 25;

SELECT ProductID FROM ProductCostHistory ORDER BY StandardCost ASC LIMIT 3;

SELECT COUNT(ProductID) FROM Product WHERE FinishedGoodsFlag = 0 AND Color = 'Black';

SELECT JobTitle FROM Employee ORDER BY SickLeaveHours DESC LIMIT 3;

SELECT AddressLine1, AddressLine2 FROM Address WHERE AddressID = 11906;

SELECT LastReceiptCost - StandardPrice FROM ProductVendor WHERE BusinessEntityID = 1580;

SELECT ListPrice - StandardCost FROM Product WHERE ProductID = 740;

SELECT ReviewerName FROM ProductReview WHERE Rating = 5;

SELECT BusinessEntityID FROM Vendor WHERE CreditRating = ( SELECT CreditRating FROM Vendor ORDER BY CreditRating DESC LIMIT 1 );

SELECT T1.FirstName, T2.BirthDate FROM Person AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.BusinessEntityID = 18;

SELECT T1.Name FROM ContactType AS T1 INNER JOIN BusinessEntityContact AS T2 ON T1.ContactTypeID = T2.ContactTypeID WHERE T2.BusinessEntityID = 332;

SELECT T2.BusinessEntityID FROM PhoneNumberType AS T1 INNER JOIN PersonPhone AS T2 ON T1.PhoneNumberTypeID = T2.PhoneNumberTypeID WHERE T1.Name = 'Cell' LIMIT 3;

SELECT T1.Name FROM Currency AS T1 INNER JOIN CountryRegionCurrency AS T2 ON T1.CurrencyCode = T2.CurrencyCode INNER JOIN CountryRegion AS T3 ON T2.CountryRegionCode = T3.CountryRegionCode WHERE T3.Name = 'Brazil';

SELECT COUNT(T2.BusinessEntityID) FROM Department AS T1 INNER JOIN EmployeeDepartmentHistory AS T2 ON T1.DepartmentID = T2.DepartmentID WHERE T1.Name = 'Finance';

SELECT T1.AverageLeadTime, T2.Name FROM ProductVendor AS T1 INNER JOIN Vendor AS T2 USING (businessentityid) WHERE T2.BusinessEntityID = 1496 GROUP BY T1.AverageLeadTime, T2.Name;

SELECT SUM(IIF(T1.city = 'Bothell', 1, 0)) - SUM(IIF(T1.city = 'Kenmore', 1, 0)) , stateprovincecode FROM Address AS T1 INNER JOIN StateProvince AS T2 ON T1.stateprovinceid = T2.stateprovinceid GROUP BY stateprovincecode;

SELECT T1.ProductModelID FROM ProductModelProductDescriptionCulture AS T1 INNER JOIN Culture AS T2 USING (cultureid) INNER JOIN ProductDescription AS T3 USING (productdescriptionid) WHERE T3.Description LIKE 'Chromoly steel%' AND T2.Name = 'English';

SELECT T1.BusinessEntityID, T2.'Group' FROM SalesPerson AS T1 INNER JOIN SalesTerritory AS T2 USING (territoryid) WHERE T1.CommissionPct >= 0.018;

SELECT T2.Name FROM PersonPhone AS T1 INNER JOIN PhoneNumberType AS T2 ON T1.PhoneNumberTypeID = T2.PhoneNumberTypeID GROUP BY T2.Name ORDER BY COUNT(T2.Name) DESC;

SELECT T1.Name FROM ContactType AS T1 INNER JOIN BusinessEntityContact AS T2 ON T1.ContactTypeID = T2.ContactTypeID GROUP BY T1.Name ORDER BY COUNT(T1.Name) DESC LIMIT 1;

SELECT T2.EmailAddress FROM Person AS T1 INNER JOIN EmailAddress AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.PersonType = 'SP';

SELECT T2.JobTitle FROM Person AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.FirstName = 'Suchitra';

SELECT COUNT(T1.BusinessentityID) FROM Person AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.PersonType = 'EM' AND T2.MaritalStatus = 'S';

SELECT SUM(CASE WHEN T1.Name = 'English' THEN 1 ELSE 0 END) - SUM(CASE WHEN T1.Name = 'Arabic' THEN 1 ELSE 0 END) FROM Culture AS T1 INNER JOIN ProductModelProductDescriptionCulture AS T2 ON T1.CultureID = T2.CultureID WHERE T1.Name = 'English' OR T1.Name = 'Arabic';

SELECT T1.AddressLine1 FROM Address AS T1 INNER JOIN BusinessEntityAddress AS T2 USING (AddressID) WHERE T2.BusinessEntityID = 1;

SELECT T2.BusinessEntityID FROM Address AS T1 INNER JOIN BusinessEntityAddress AS T2 ON T1.AddressID = T2.AddressID WHERE T1.City = 'Duvall';

SELECT CAST(SUM(CASE WHEN T1.Name = 'Thai' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.CultureID) FROM Culture AS T1 INNER JOIN ProductModelProductDescriptionCulture AS T2 ON T1.CultureID = T2.CultureID;

SELECT CAST(SUM(CASE WHEN T2.Gender = 'M' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.BusinessentityID) FROM Person AS T1 INNER JOIN Employee AS T2 ON T1.BusinessentityID = T2.BusinessentityID WHERE T1.PersonType = 'EM';

SELECT T2.City, T1.Name, T1.IsOnlyStateProvinceFlag FROM StateProvince AS T1 INNER JOIN Address AS T2 ON T1.StateProvinceID = T2.StateProvinceID WHERE T2.AddressID = 15873;

SELECT T1.AddressLine1, T1.AddressLine2 FROM Address AS T1 INNER JOIN BusinessEntityAddress AS T2 ON T1.AddressID = T2.AddressID WHERE T2.BusinessEntityID = 24;

SELECT ExpYear FROM CreditCard WHERE CreditCardID = 9648;

SELECT BusinessEntityID FROM Person WHERE FirstName = 'Emma' AND LastName = 'Harris';

SELECT LocationID FROM Location WHERE Name = 'Debur and Polish';

SELECT DepartmentID FROM Department WHERE GroupName = 'Sales and Marketing';

SELECT BusinessEntityID FROM SalesPerson WHERE SalesLastYear = '1635823.3967';

SELECT StartTime FROM Shift WHERE ShiftID = '2';

SELECT Name FROM ContactType WHERE ContactTypeID = '16';

SELECT ShipBase FROM ShipMethod WHERE Name = 'OVERSEAS - DELUXE';

SELECT Name FROM Culture WHERE CultureID = 'fr';

SELECT CurrencyCode FROM Currency WHERE Name = 'Mauritius Rupee';

SELECT PhoneNumberTypeID FROM PhoneNumberType WHERE Name = 'Cell';

SELECT BirthDate FROM Employee WHERE HireDate = '2008-12-07';

SELECT T1.Name FROM Product AS T1 INNER JOIN ProductModel AS T2 ON T1.ProductModelID = T2.ProductModelID WHERE T1.ProductID = 793;

SELECT T2.UnitMeasureCode FROM Product AS T1 INNER JOIN UnitMeasure AS T2 ON T1.SizeUnitMeasureCode = T2.UnitMeasureCode OR T1.WeightUnitMeasureCode = T2.UnitMeasureCode WHERE T1.ProductID = 762 GROUP BY T1.ProductID, T2.UnitMeasureCode;

SELECT AddressLine1, AddressLine2 FROM Address WHERE AddressID IN ( SELECT AddressID FROM BusinessEntityAddress WHERE BusinessEntityID = 4 );

SELECT T2.Name FROM BillOfMaterials AS T1 INNER JOIN UnitMeasure AS T2 ON T1.UnitMeasureCode = T2.UnitMeasureCode WHERE T1.ComponentID = 494 AND T1.EndDate IS NULL GROUP BY T2.name;

SELECT COUNT(T2.BusinessEntityID) FROM Document AS T1 INNER JOIN Employee AS T2 ON T1.Owner = T2.BusinessEntityID WHERE T2.JobTitle = 'Document Control Assistant' AND T2.BirthDate = '1975-12-25' AND T1.DocumentSummary IS NULL;

SELECT T1.ListPrice FROM Product AS T1 INNER JOIN ProductListPriceHistory AS T2 ON T1.ProductID = T2.ProductID WHERE T1.ListPrice - T1.StandardCost > 21.9037 AND STRFTIME('%Y-%m-%d', T2.StartDate) >= '2012-10-01';

SELECT T1.ThumbNailPhoto FROM ProductPhoto AS T1 INNER JOIN ProductProductPhoto AS T2 ON T1.ProductPhotoID = T2.ProductPhotoID WHERE T2.ProductID = 1;

SELECT LENGTH(T2.PasswordHash) FROM Person AS T1 INNER JOIN Password AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.FirstName = 'Catherine' AND T1.LastName = 'Ward';

SELECT T1.Rating FROM ProductReview AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T1.ReviewerName = 'Jill' AND T2.Name = 'HL Mountain Pedal';

SELECT T1.LastReceiptCost - T1.StandardPrice FROM ProductVendor AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T2.Name = 'Freewheel';

SELECT T1.Bonus FROM SalesPerson AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.FirstName = 'Rachel' AND T2.LastName = 'Valdez';

SELECT COUNT(DISTINCT T1.Name) FROM SalesTaxRate AS T1 INNER JOIN StateProvince AS T2 ON T1.StateProvinceID = T2.StateProvinceID WHERE T2.Name = 'Quebec';

SELECT T2.EmailAddress FROM Person AS T1 INNER JOIN EmailAddress AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.FirstName = 'Kevin' AND T1.MiddleName = 'A' AND T1.LastName = 'Wright';

SELECT T1.CountryRegionCode FROM StateProvince AS T1 INNER JOIN CountryRegion AS T2 ON T1.CountryRegionCode = T2.CountryRegionCode WHERE T2.Name = 'France' AND T1.IsOnlyStateProvinceFlag = 1;

SELECT T1.TransactionType FROM TransactionHistory AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T2.Name = 'HL Road Frame - Black, 48' AND STRFTIME('%Y-%m-%d',T1.TransactionDate) = '2013-07-31';

SELECT T1.TransactionType FROM TransactionHistoryArchive AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T2.Name = 'LL Road Handlebars' AND STRFTIME('%Y-%m-%d',T1.TransactionDate) = '2012-11-03';

SELECT T1.CreditRating FROM Vendor AS T1 INNER JOIN BusinessEntity AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.rowguid = '33671A4E-DF2B-4879-807B-E3F930DD5C0C';

SELECT T1.PreferredVendorStatus FROM Vendor AS T1 INNER JOIN BusinessEntity AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.rowguid = '684F328D-C185-43B9-AF9A-37ACC680D2AF';

SELECT T1.ActiveFlag FROM Vendor AS T1 INNER JOIN BusinessEntityContact AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.PersonID = 2054;

SELECT T2.PhoneNumber FROM Person AS T1 INNER JOIN PersonPhone AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.FirstName = 'Gerald' AND T1.LastName = 'Patel';

SELECT T2.Name FROM PersonPhone AS T1 INNER JOIN PhoneNumberType AS T2 USING (PhoneNumberTypeID) WHERE T1.BusinessEntityID = 13626;

SELECT T2.JobTitle FROM Person AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.FirstName = 'Lynn' AND T1.MiddleName = 'N' AND T1.LastName = 'Tsoflias';

SELECT COUNT(*) FROM ProductCategory AS T1 INNER JOIN ProductSubcategory AS T2 ON T1.ProductCategoryID = T2.ProductCategoryID WHERE T1.Name = 'Bikes';

SELECT CAST(SUM(CASE WHEN T1.DocumentSummary IS NOT NULL THEN 1 ELSE 0 END) AS REAL) / COUNT(T1.DocumentSummary) FROM Document AS T1 INNER JOIN Employee AS T2 ON T1.Owner = T2.BusinessEntityID WHERE T2.JobTitle = 'Document Control Assistant' AND T2.HireDate = '2009-01-22';

SELECT (T1.LastReceiptCost - T1.StandardPrice) / T1.StandardPrice FROM ProductVendor AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T2.Name = 'HL Grip Tape';

SELECT CAST(SUM(CASE WHEN T2.Name = 'Cell' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.Name) FROM PersonPhone AS T1 INNER JOIN PhoneNumberType AS T2 ON T1.PhoneNumberTypeID = T2.PhoneNumberTypeID;

SELECT ProductAssemblyID FROM BillOfMaterials WHERE UnitMeasureCode = 'EA' AND BOMLevel = 2 AND PerAssemblyQty > 10;

SELECT COUNT(LocationID) FROM WorkOrderRouting WHERE ActualResourceHrs = 2;

SELECT COUNT(*) FROM WorkOrderRouting AS T1 INNER JOIN BillOfMaterials AS T2 ON T1.LocationID = T2.ProductAssemblyID INNER JOIN WorkOrder AS T3 ON T3.WorkOrderID = T1.WorkOrderID WHERE T1.LocationID = 40;

SELECT SUM(T1.PerAssemblyQty), T2.Name FROM BillOfMaterials AS T1 INNER JOIN UnitMeasure AS T2 ON T1.UnitMeasureCode = T2.UnitMeasureCode WHERE T1.UnitMeasureCode IN ('EA', 'IN', 'OZ') GROUP BY T2.Name;

SELECT ProductID FROM Product WHERE ProductID NOT IN ( SELECT T1.ProductID FROM Product AS T1 INNER JOIN WorkOrder AS T2 ON T1.ProductID = T2.ProductID );

SELECT ProductID FROM Product WHERE ProductID IN ( SELECT ProductID FROM TransactionHistory WHERE TransactionType = 'P' );

SELECT T2.FirstName, T2.MiddleName, T2.LastName FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.JobTitle = 'Accountant';

SELECT T1.JobTitle FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.FirstName = 'Ken' AND T2.MiddleName = 'J' AND T2.LastName = 'Sánchez';

SELECT COUNT(T1.BusinessEntityID) FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.EmailPromotion = 0 AND T1.Gender = 'M';

SELECT BusinessEntityID FROM SalesPerson WHERE BusinessEntityID IN ( SELECT BusinessEntityID FROM SalesPersonQuotaHistory WHERE STRFTIME('%Y', QuotaDate) = '2013' ) ORDER BY CAST(SalesLastYear AS REAL) / SalesQuota DESC LIMIT 1;

SELECT COUNT(T1.BusinessEntityID) FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.PersonType = 'EM' AND T1.MaritalStatus = 'M';

SELECT COUNT(T1.BusinessEntityID) FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.JobTitle LIKE 'Production Technician%' AND T1.MaritalStatus = 'S' AND T2.PersonType = 'VC';

SELECT SUM(T1.SickLeaveHours) FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.EmailPromotion = 0;

SELECT COUNT(T1.BusinessEntityID) FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.PersonType = 'SP' AND SUBSTR(T1.HireDate, 0, 4) < 2010;

SELECT T1.BusinessEntityID, SUM(T1.SalesQuota) FROM SalesPerson AS T1 INNER JOIN SalesPersonQuotaHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE STRFTIME('%Y', T2.QuotaDate) = '2011' GROUP BY T1.BusinessEntityID ORDER BY SUM(T1.SalesYTD) DESC LIMIT 1;

SELECT COUNT(T1.BusinessEntityID) FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.FirstName = 'Alex' AND T1.MaritalStatus = 'S' AND T1.OrganizationLevel = 1;

SELECT CAST(SUM(T1.VacationHours) AS REAL) / COUNT(T1.BusinessEntityID) FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.PersonType = 'SP';

SELECT T1.LastName, T3.JobTitle FROM Person AS T1 INNER JOIN Document AS T2 ON T1.BusinessEntityID = T2.Owner INNER JOIN Employee AS T3 ON T1.BusinessEntityID = T3.BusinessEntityID WHERE T2.Title = 'Crank Arm and Tire Maintenance';

SELECT COUNT(T3.BusinessEntityID) FROM ( SELECT T1.BusinessEntityID FROM Employee AS T1 INNER JOIN Person AS T2 USING (BusinessEntityID) WHERE T2.Suffix IS NULL GROUP BY T1.BusinessEntityID ) AS T3;

SELECT DISTINCT T1.BusinessEntityID FROM SalesPerson AS T1 INNER JOIN SalesPersonQuotaHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.TerritoryID = 1 AND STRFTIME('%Y', QuotaDate) = '2013';

SELECT T3.LastName FROM Employee AS T1 INNER JOIN JobCandidate AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN Person AS T3 ON T1.BusinessEntityID = T3.BusinessEntityID WHERE T1.BusinessEntityID IN (212, 274);

SELECT T3.EmailAddress FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN EmailAddress AS T3 ON T2.BusinessEntityID = T3.BusinessEntityID WHERE T1.Gender = 'F' AND T1.MaritalStatus = 'S';

SELECT T1.Color FROM Product AS T1 INNER JOIN ProductReview AS T2 ON T1.ProductID = T2.ProductID WHERE T1.ProductID = 709 OR 937 OR 798;

SELECT SUM(T1.SalesQuota) FROM SalesPerson AS T1 INNER JOIN SalesPersonQuotaHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.BusinessEntityID = 275 AND STRFTIME('%Y', QuotaDate) = '2013';

SELECT DISTINCT T1.BusinessEntityID FROM SalesPerson AS T1 INNER JOIN SalesPersonQuotaHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE STRFTIME('%Y', T2.QuotaDate) = '2013' AND T1.SalesQuota < T1.SalesLastYear;

SELECT CAST(SUM(CASE WHEN T1.Gender = 'F' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.BusinessEntityID) FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.EmailPromotion = 1;

SELECT CAST(SUM(CASE WHEN T1.MaritalStatus = 'M' THEN 1 ELSE 0 END) AS REAL) * 100 / SUM(CASE WHEN T1.MaritalStatus = 'S' THEN 1 ELSE 0 END) FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.PersonType = 'EM';

SELECT SUM(T1.Bonus) , CAST(SUM(T1.Bonus) AS REAL) * 100 / SUM(T1.SalesQuota) FROM SalesPerson AS T1 INNER JOIN SalesPersonQuotaHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE STRFTIME('%Y', T2.QuotaDate) = '2013';

SELECT COUNT(CardNumber) FROM CreditCard WHERE CardType = 'vista';

SELECT Name FROM Product WHERE ProductID = 475;

SELECT COUNT(BusinessEntityID) FROM Employee WHERE MaritalStatus = 's' AND BirthDate < '1980-1-1';

SELECT Name FROM Store WHERE SalesPersonID = 277;

SELECT SUM(Quantity) FROM TransactionHistory WHERE TransactionDate LIKE '2013-08%' AND TransactionType = 'S' AND ProductID = 989;

SELECT CardNumber FROM CreditCard WHERE ExpYear < 2007;

SELECT T2.Rate FROM Employee AS T1 INNER JOIN EmployeePayHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE STRFTIME('%Y', T1.HireDate) - STRFTIME('%Y', T1.BirthDate) = 20;

SELECT T2.Name FROM SalesPerson AS T1 INNER JOIN SalesTerritory AS T2 ON T1.TerritoryID = T2.TerritoryID WHERE T1.BusinessEntityID = 277;

SELECT T2.FirstName, T2.MiddleName, T2.LastName FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.JobTitle = 'Vice President of Production';

SELECT COUNT(T2.BusinessEntityID) FROM Department AS T1 INNER JOIN EmployeeDepartmentHistory AS T2 ON T1.DepartmentID = T2.DepartmentID INNER JOIN Shift AS T3 ON T2.ShiftId = T3.ShiftId WHERE T1.Name = 'Information Services' AND T3.Name = 'Evening';

SELECT T2.PurchaseOrderID FROM Vendor AS T1 INNER JOIN PurchaseOrderHeader AS T2 ON T1.BusinessEntityID = T2.VendorID WHERE T1.CreditRating = 5;

SELECT T2.Name FROM PersonPhone AS T1 INNER JOIN PhoneNumberType AS T2 ON T1.PhoneNumberTypeID = T2.PhoneNumberTypeID WHERE T1.PhoneNumber = '114-555-0100';

SELECT SUM(t2.freight) FROM ShipMethod AS t1 INNER JOIN PurchaseOrderHeader AS t2 ON t1.shipmethodid = t2.shipmethodid WHERE t1.name = 'cargo transport 5' AND t2.orderdate = '2011-12-14';

SELECT COUNT(T2.TotalDue) FROM Person AS T1 INNER JOIN SalesOrderHeader AS T2 ON T1.ModifiedDate = T2.DueDate WHERE T1.FirstName = 'David' AND T1.MiddleName = 'R' AND T1.LastName = 'Campbell' AND T1.PersonType = 'SP';

SELECT T3.EmailAddress FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN EmailAddress AS T3 ON T2.BusinessEntityID = T3.BusinessEntityID WHERE T1.JobTitle = 'Facilities Manager';

SELECT COUNT(T2.CustomerID) FROM SalesTerritory AS T1 INNER JOIN Customer AS T2 ON T1.TerritoryID = T2.TerritoryID WHERE T1.Name = 'Canada';

SELECT T1.ShipToAddressID FROM SalesOrderHeader AS T1 INNER JOIN Address AS T2 ON T1.BillToAddressID = T2.AddressID WHERE T1.SalesOrderID = 43873 GROUP BY T1.ShipToAddressID;

SELECT T2.FirstName FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.SickLeaveHours > 65;

SELECT COUNT(T1.BusinessEntityID) FROM Employee AS T1 INNER JOIN EmployeePayHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.JobTitle LIKE 'Production Technician%' AND T2.Rate < ( SELECT AVG(T2.Rate) FROM Employee AS T1 INNER JOIN EmployeePayHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.JobTitle LIKE 'Production Technician%' );

SELECT CAST(SUM(CASE WHEN T2.Name = 'United Kingdom' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.SalesOrderID) FROM SalesOrderHeader AS T1 INNER JOIN SalesTerritory AS T2 ON T1.TerritoryID = T2.TerritoryID;

SELECT ModifiedDate FROM PersonPhone WHERE PhoneNumber = '1 (11) 500 555-0143';

SELECT BusinessEntityID FROM SalesPerson ORDER BY SalesYTD DESC LIMIT 1;

SELECT Name FROM Vendor WHERE ActiveFlag = 1;

SELECT TerritoryID FROM Customer WHERE ModifiedDate < '2014-12-09' GROUP BY TerritoryID ORDER BY COUNT(TerritoryID) DESC LIMIT 1;

SELECT SUM(TotalDue) FROM PurchaseOrderHeader WHERE OrderDate LIKE '2013-05-29%';

SELECT FirstName FROM Person WHERE PersonType = 'VC' GROUP BY FirstName ORDER BY COUNT(*) DESC LIMIT 1;

SELECT T2.FirstName, T2.MiddleName, T2.LastName FROM Employee AS T1 INNER JOIN Person AS T2 USING (BusinessEntityID) WHERE T1.JobTitle = 'Production Technician - WC50' GROUP BY T2.FirstName, T2.MiddleName, T2.LastName;

SELECT COUNT(OrderQty) FROM SalesOrderDetail WHERE ProductID IN ( SELECT ProductID FROM Product WHERE Name = 'Minipump' );

SELECT T2.BusinessEntityID FROM CreditCard AS T1 INNER JOIN PersonCreditCard AS T2 ON T1.CreditCardID = T2.CreditCardID WHERE T1.CardNumber = 11113366963373;

SELECT T3.City, T3.AddressLine1 FROM BusinessEntityAddress AS T1 INNER JOIN AddressType AS T2 ON T1.AddressTypeID = T2.AddressTypeID INNER JOIN Address AS T3 ON T1.AddressID = T3.AddressID WHERE T1.BusinessEntityID = 5555 AND T2.Name = 'Home';

SELECT T2.Name FROM SpecialOfferProduct AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T1.SpecialOfferID = 15;

SELECT T3.CreditCardID FROM Person AS T1 INNER JOIN PersonCreditCard AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN CreditCard AS T3 ON T2.CreditCardID = T3.CreditCardID WHERE T1.FirstName = 'Michelle' AND T1.MiddleName = 'E' AND T1.LastName = 'Cox';

SELECT T2.Name FROM SalesOrderHeaderSalesReason AS T1 INNER JOIN SalesReason AS T2 ON T1.SalesReasonID = T2.SalesReasonID WHERE T1.SalesOrderID = 51883;

SELECT T2.CardNumber FROM SalesOrderHeader AS T1 INNER JOIN CreditCard AS T2 ON T1.CreditCardID = T2.CreditCardID WHERE T1.SalesOrderID = 45793;

SELECT T2.BusinessEntityID FROM SalesTerritory AS T1 INNER JOIN SalesPerson AS T2 ON T1.TerritoryID = T2.TerritoryID WHERE T1.Name = 'Northwest' AND T1.CountryRegionCode = 'US';

SELECT T1.BusinessEntityID FROM Employee AS T1 INNER JOIN EmployeePayHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.JobTitle LIKE 'Production Technician%' ORDER BY T2.Rate DESC LIMIT 1;

SELECT T2.FirstName, T2.MiddleName, T2.LastName FROM SalesPerson AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.TerritoryID = 9;

SELECT T2.Description FROM SpecialOfferProduct AS T1 INNER JOIN SpecialOffer AS T2 ON T1.SpecialOfferID = T2.SpecialOfferID WHERE T1.ProductID = 762;

SELECT AVG(T2.Rate) FROM Employee AS T1 INNER JOIN EmployeePayHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID GROUP BY T1.Gender;

SELECT CAST(SUM(CASE WHEN T1.Name = 'Night' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.BusinessEntityID) FROM Shift AS T1 INNER JOIN EmployeeDepartmentHistory AS T2 ON T1.ShiftId = T2.ShiftId;

SELECT COUNT(BusinessEntityID) FROM Employee WHERE MaritalStatus = 'M' AND STRFTIME('%Y', BirthDate) < '1960' AND Gender = 'M';

SELECT Name FROM Product ORDER BY ListPrice DESC LIMIT 5;

SELECT MIN(HireDate) FROM Employee WHERE JobTitle = 'Accountant';

SELECT JobTitle FROM Employee WHERE STRFTIME('%Y', HireDate) = '2007' GROUP BY HireDate ORDER BY COUNT(JobTitle) DESC LIMIT 1;

SELECT LastReceiptCost - StandardPrice FROM ProductVendor ORDER BY StandardPrice DESC LIMIT 1;

SELECT COUNT(T3.Name) FROM Person AS T1 INNER JOIN EmployeeDepartmentHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN Department AS T3 ON T2.DepartmentID = T3.DepartmentID WHERE T1.FirstName = 'Sheela' AND T1.LastName = 'Word' AND STRFTIME('%Y', T3.ModifiedDate) BETWEEN '2011' AND '2012';

SELECT AVG(2009 - STRFTIME('%Y', T2.BirthDate)) FROM Person AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.PersonType = 'SP';

SELECT T2.GroupName FROM EmployeeDepartmentHistory AS T1 INNER JOIN Department AS T2 ON T1.DepartmentID = T2.DepartmentID GROUP BY T2.GroupName ORDER BY COUNT(T1.BusinessEntityID) LIMIT 1;

SELECT 2015 - STRFTIME('%Y', T1.BirthDate), T2.Rate FROM Employee AS T1 INNER JOIN EmployeePayHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.JobTitle = 'Marketing Specialist' ORDER BY 2015 - STRFTIME('%Y', T1.BirthDate) DESC LIMIT 1;

SELECT T1.UnitPrice, T3.Name FROM PurchaseOrderDetail AS T1 INNER JOIN PurchaseOrderHeader AS T2 ON T1.PurchaseOrderID = T2.PurchaseOrderID INNER JOIN Vendor AS T3 ON T2.VendorID = T3.BusinessEntityID ORDER BY T1.UnitPrice LIMIT 1;

SELECT T2.BusinessEntityID, STRFTIME('%Y', T2.HireDate) - STRFTIME('%Y', T2.BirthDate) FROM PurchaseOrderHeader AS T1 INNER JOIN Employee AS T2 ON T1.EmployeeID = T2.BusinessEntityID ORDER BY T1.TotalDue DESC LIMIT 1;

SELECT T2.JobTitle, T1.Rate, T3.FirstName, T3.MiddleName, T3.LastName FROM EmployeePayHistory AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN Person AS T3 ON T2.BusinessEntityID = T3.BusinessEntityID ORDER BY T1.Rate DESC LIMIT 9, 1;

SELECT T1.ListPrice - T1.StandardCost, T1.Name FROM Product AS T1 INNER JOIN ProductReview AS T2 ON T1.ProductID = T2.ProductID WHERE T2.ReviewerName = 'John Smith' ORDER BY T2.Rating DESC LIMIT 1;

SELECT T1.Rate FROM EmployeePayHistory AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN Person AS T3 ON T2.BusinessEntityID = T3.BusinessEntityID ORDER BY T2.HireDate ASC LIMIT 0, 5;

SELECT T2.Name FROM ProductVendor AS T1 INNER JOIN Vendor AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.MaxOrderQty BETWEEN 500 AND 750 ORDER BY T1.LastReceiptCost - T1.StandardPrice DESC LIMIT 9, 1;

SELECT 2011 - STRFTIME('%Y', T2.HireDate) FROM Document AS T1 INNER JOIN Employee AS T2 ON T1.Owner = T2.BusinessEntityID WHERE T1.Status = 1;

SELECT T1.DaysToManufacture FROM Product AS T1 INNER JOIN ProductReview AS T2 ON T1.ProductID = T2.ProductID WHERE T2.Rating = 5 AND T1.Class = 'M' ORDER BY T2.Rating LIMIT 1;

SELECT T1.JobTitle, T2.FirstName, T2.MiddleName, T2.LastName FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID ORDER BY T1.HireDate LIMIT 1;

SELECT COUNT(T1.TransactionID) FROM TransactionHistory AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T1.Quantity BETWEEN 100 AND 250 AND T2.ReorderPoint <= 375;

SELECT AVG(T2.Rate) FROM Employee AS T1 INNER JOIN EmployeePayHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.Gender = 'F';

SELECT DISTINCT T4.Name FROM Product AS T1 INNER JOIN ProductVendor AS T2 ON T1.ProductID = T2.ProductID INNER JOIN ProductSubcategory AS T3 ON T1.ProductSubcategoryID = T3.ProductSubcategoryID INNER JOIN Vendor AS T4 ON T2.BusinessEntityID = T4.BusinessEntityID WHERE T1.MakeFlag = 0 AND T1.Style = 'W' AND T3.Name = 'Tights';

SELECT T2.PayFrequency FROM Employee AS T1 INNER JOIN EmployeePayHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.JobTitle = 'Scheduling Assistant' ORDER BY T1.HireDate LIMIT 1;

SELECT T2.Class, T2.ProductLine, T2.ListPrice FROM ShoppingCartItem AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID GROUP BY T1.ProductID ORDER BY SUM(Quantity) LIMIT 1;

SELECT T2.FirstName, T2.MiddleName, T2.LastName FROM SalesPerson AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID ORDER BY T1.CommissionPct DESC LIMIT 1;

SELECT T2.FirstName, T2.MiddleName, T2.LastName FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID ORDER BY STRFTIME('%Y', T1.HireDate) - STRFTIME('%Y', T1.BirthDate) DESC LIMIT 1, 1;

SELECT (T2.ListPrice - T2.StandardCost) * SUM(T1.Quantity), T2.Name FROM ShoppingCartItem AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID GROUP BY T1.ProductID, T2.Name, T2.ListPrice, T2.StandardCost, T1.Quantity ORDER BY SUM(T1.Quantity) DESC LIMIT 1;

SELECT T2.OrderQty - T2.ReceivedQty, VendorID FROM PurchaseOrderHeader AS T1 INNER JOIN PurchaseOrderDetail AS T2 ON T1.PurchaseOrderID = T2.PurchaseOrderID ORDER BY T2.OrderQty - T2.ReceivedQty DESC LIMIT 1;

SELECT T1.AverageLeadTime, T1.LastReceiptCost - T1.StandardPrice, T4.AddressLine1, T4.AddressLine2 , T4.City, T4.PostalCode FROM ProductVendor AS T1 INNER JOIN Vendor AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN BusinessEntityAddress AS T3 ON T1.BusinessEntityID = T3.BusinessEntityID INNER JOIN Address AS T4 ON T3.AddressID = T4.AddressID WHERE T1.ProductID = 843;

SELECT COUNT(BusinessEntityID) FROM SalesPerson WHERE Bonus = 0;

SELECT COUNT(SalesTaxRateID) FROM SalesTaxRate WHERE Name LIKE '%+%';

SELECT ActualCost FROM TransactionHistory WHERE TransactionType = 'P' ORDER BY ActualCost DESC LIMIT 1;

SELECT Status FROM SalesOrderHeader ORDER BY Freight DESC LIMIT 1;

SELECT COUNT(ProductID) FROM ProductVendor WHERE OnOrderQty = 0;

SELECT LastReceiptCost - StandardPrice FROM ProductVendor ORDER BY LastReceiptCost - StandardPrice DESC LIMIT 1;

SELECT ReviewerName FROM ProductReview WHERE Rating = ( SELECT Rating FROM ProductReview ORDER BY Rating DESC LIMIT 1 );

SELECT T2.Name FROM ProductReview AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID GROUP BY T1.ProductID ORDER BY COUNT(T1.ProductReviewID) DESC LIMIT 1;

SELECT COUNT(T1.ProductID) FROM ProductReview AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T2.MakeFlag = 0 AND T1.Rating != 5;

SELECT T1.Comments FROM ProductReview AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T2.FinishedGoodsFlag = 1 GROUP BY T1.Comments ORDER BY COUNT(T1.ProductReviewID) DESC LIMIT 1;

SELECT T2.Name FROM ProductReview AS T1 INNER JOIN Product AS T2 USING (ProductID) WHERE T2.FinishedGoodsFlag = 1 AND T2.MakeFlag = 1 GROUP BY T2.Name ORDER BY COUNT(T1.COMMENTS) > 10;

SELECT T2.NAME FROM ProductReview AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T2.FinishedGoodsFlag = 1 GROUP BY T2.NAME ORDER BY COUNT(T1.comments) > 10;

SELECT T1.ReviewerName FROM ProductReview AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T2.Class = 'M' AND T2.Style = 'W' AND T1.Rating = 5;

SELECT T2.Class FROM ProductReview AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID GROUP BY T2.Class ORDER BY COUNT(T1.ProductReviewID) DESC LIMIT 1;

SELECT T1.EmailAddress FROM ProductReview AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T2.Class = 'H';

SELECT T2.Name FROM ProductListPriceHistory AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID GROUP BY T2.Name ORDER BY COUNT(T1.ListPrice) > 3;

SELECT T1.Description FROM ProductDescription AS T1 INNER JOIN Product AS T2 WHERE T2.Name = 'Headset Ball Bearings' AND T1.productDescriptionID = T2.ProductID;

SELECT T1.StandardPrice FROM ProductVendor AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T2.Name = 'Hex Nut 5' ORDER BY T1.StandardPrice DESC LIMIT 1;

SELECT T1.StandardPrice FROM ProductVendor AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T2.Name = 'Hex Nut 5' GROUP BY T1.StandardPrice ORDER BY COUNT(T1.StandardPrice) DESC LIMIT 1;

SELECT COUNT(DISTINCT T3.Name) FROM ProductVendor AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID INNER JOIN Vendor AS T3 ON T1.BusinessEntityID = T3.BusinessEntityID WHERE T2.Name = 'Hex Nut 5' AND T3.CreditRating = 1 AND 3;

SELECT T3.PurchasingWebServiceURL FROM ProductVendor AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID INNER JOIN Vendor AS T3 ON T1.BusinessEntityID = T3.BusinessEntityID WHERE T2.Name = 'Hex Nut 5';

SELECT T3.Name FROM ProductVendor AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID INNER JOIN Vendor AS T3 ON T1.BusinessEntityID = T3.BusinessEntityID WHERE T2.Name = 'Hex Nut 5' ORDER BY T1.StandardPrice LIMIT 1;

SELECT COUNT(T2.Name) FROM ProductVendor AS T1 INNER JOIN Product AS T2 USING (ProductID) INNER JOIN Vendor AS T3 ON T1.BusinessEntityID = T3.BusinessEntityID WHERE T3.PreferredVendorStatus = 1 AND T2.Class = 'M';

SELECT T2.ListPrice FROM Product AS T1 INNER JOIN ProductListPriceHistory AS T2 ON T1.ProductID = T2.ProductID WHERE T1.Name = 'LL Fork';

SELECT SUM(CASE WHEN T1.ProductLine = 'M' THEN 1 ELSE 0 END) FROM Product AS T1 INNER JOIN ProductVendor AS T2 ON T1.ProductID = T2.ProductID INNER JOIN Vendor AS T3 ON T2.BusinessEntityID = T3.BusinessEntityID GROUP BY T1.ProductID HAVING COUNT(T1.Name) > 2;

SELECT SUM(CASE WHEN T2.ProductLine = 'M' THEN 1 ELSE 0 END) FROM ProductReview AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID GROUP BY T1.ProductID HAVING COUNT(T1.ProductReviewID) > 1;

SELECT T1.EmailAddress FROM ProductReview AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T2.Name = 'HL Mountain Pedal' ORDER BY T1.Rating LIMIT 1;

SELECT COUNT(T2.ProductID) FROM ProductVendor AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T1.OnOrderQty IS NULL OR T1.OnOrderQty = 0;

SELECT T2.Name FROM ProductVendor AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T2.MakeFlag = 0 AND (T1.OnOrderQty IS NULL OR T1.OnOrderQty = 0);

SELECT SUM(CASE WHEN T2.ProductLine = 'M' THEN 1 ELSE 0 END) FROM ProductReview AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T2.FinishedGoodsFlag = 1 GROUP BY T1.ProductID ORDER BY COUNT(T1.ProductReviewID) DESC LIMIT 1;

SELECT SUM(T1.StandardPrice) / COUNT(T1.BusinessEntityID) FROM ProductVendor AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T2.Name = 'Hex Nut 5';

SELECT T2.Name FROM ProductReview AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T2.ProductLine = 'M' GROUP BY T2.Name ORDER BY CAST(SUM(T1.Rating) AS REAL) / COUNT(T1.ProductID) DESC LIMIT 1;

SELECT T2.Name FROM ProductReview AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T2.MakeFlag = 1 GROUP BY T2.Name ORDER BY SUM(T1.Rating) DESC LIMIT 1;

SELECT FirstName, LastName FROM Person WHERE PersonType = 'EM' ORDER BY BusinessEntityID;

SELECT FirstName, MiddleName, LastName FROM Person WHERE LastName = 'Anderson' AND PersonType = 'IN';

SELECT T1.FirstName, T1.LastName, T2.HireDate FROM Person AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN EmployeeDepartmentHistory AS T3 ON T2.BusinessEntityID = T3.BusinessEntityID WHERE T3.EndDate IS NOT NULL;

SELECT T1.FirstName, T1.LastName FROM Person AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE STRFTIME('%Y', T2.HireDate) >= '2007' AND T2.SalariedFlag = 1;

SELECT T1.FirstName, T1.LastName FROM Person AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.MaritalStatus = 'M' AND T2.VacationHours < 20;

SELECT T1.FirstName, T1.LastName , STRFTIME('%Y', CURRENT_TIMESTAMP) - STRFTIME('%Y', BirthDate) FROM Person AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN EmployeeDepartmentHistory AS T3 ON T2.BusinessEntityID = T3.BusinessEntityID WHERE T3.ShiftId = 3 ORDER BY STRFTIME('%Y', CURRENT_TIMESTAMP) - STRFTIME('%Y', BirthDate) DESC LIMIT 1;

SELECT T1.FirstName, T1.LastName FROM Person AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN EmployeeDepartmentHistory AS T3 ON T2.BusinessEntityID = T3.BusinessEntityID INNER JOIN Department AS T4 ON T3.DepartmentID = T4.DepartmentID WHERE STRFTIME('%Y', T2.HireDate) = '2009' AND T4.Name = 'Shipping and Receiving';

SELECT T2.JobTitle, T4.Name FROM Person AS T1 INNER JOIN Employee AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN EmployeeDepartmentHistory AS T3 ON T2.BusinessEntityID = T3.BusinessEntityID INNER JOIN Department AS T4 ON T3.DepartmentID = T4.DepartmentID ORDER BY T2.HireDate LIMIT 1;

SELECT AVG(T1.Rate) FROM EmployeePayHistory AS T1 INNER JOIN EmployeeDepartmentHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN Department AS T3 ON T2.DepartmentID = T3.DepartmentID WHERE T1.RateChangeDate = ( SELECT MAX(T1.RateChangeDate) FROM EmployeePayHistory AS T1 INNER JOIN Department AS T2 ON T1.BusinessEntityID = T2.DepartmentID );

SELECT T2.FirstName, T2.LastName FROM EmployeePayHistory AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN Employee AS T3 ON T2.BusinessEntityID = T3.BusinessEntityID WHERE T3.JobTitle NOT LIKE 'Chief Executive Officer' ORDER BY T1.Rate DESC LIMIT 1;

SELECT T1.Name FROM Vendor AS T1 INNER JOIN ProductVendor AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.ProductID = 319 ORDER BY T2.AverageLeadTime LIMIT 1;

SELECT T3.Name FROM Vendor AS T1 INNER JOIN ProductVendor AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN Product AS T3 ON T2.ProductID = T3.ProductID WHERE T1.Name = 'Australia Bike Retailer';

SELECT T1.Name FROM Vendor AS T1 INNER JOIN ProductVendor AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T2.ProductID = 342 ORDER BY T2.LastReceiptCost - T2.StandardPrice DESC LIMIT 1;

SELECT T2.Rate , (MAX(T2.Rate) - MIN(T2.Rate)) * 100 / MAX(T2.Rate) FROM Person AS T1 INNER JOIN EmployeePayHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.FirstName = 'Rob' AND T1.LastName = 'Walters';

SELECT AVG(STRFTIME('%Y', CURRENT_TIMESTAMP) - STRFTIME('%Y', T1.HireDate)) FROM Employee AS T1 INNER JOIN EmployeeDepartmentHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN Department AS T3 ON T2.DepartmentID = T3.DepartmentID WHERE T3.Name = 'Research and Development';

SELECT AVG(STRFTIME('%Y', CURRENT_TIMESTAMP) - STRFTIME('%Y', BirthDate)) FROM Employee;

SELECT CAST(SUM(CASE WHEN JobTitle = 'Sales Representative' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(BusinessEntityID) FROM Employee;

SELECT T1.FirstName, T1.LastName, T2.PhoneNumber FROM Person AS T1 INNER JOIN PersonPhone AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN Employee AS T3 ON T1.BusinessEntityID = T3.BusinessEntityID WHERE T3.JobTitle = 'Marketing Manager';

SELECT T3.FirstName, T3.LastName FROM CreditCard AS T1 INNER JOIN PersonCreditCard AS T2 ON T1.CreditCardID = T2.CreditCardID INNER JOIN Person AS T3 ON T2.BusinessEntityID = T3.BusinessEntityID WHERE T1.CardType = 'Distinguish';

SELECT T4.Name FROM Store AS T1 INNER JOIN SalesPerson AS T2 ON T1.SalesPersonID = T2.BusinessEntityID INNER JOIN Person AS T3 ON T2.BusinessEntityID = T3.BusinessEntityID INNER JOIN SalesTerritory AS T4 ON T2.TerritoryID = T4.TerritoryID WHERE T1.Name = 'Area Bike Accessories';

SELECT T3.Name, T4.FirstName, T4.LastName FROM SalesTerritory AS T1 INNER JOIN Customer AS T2 ON T1.TerritoryID = T2.TerritoryID INNER JOIN Store AS T3 ON T2.StoreID = T3.BusinessEntityID INNER JOIN Person AS T4 ON T2.PersonID = T4.BusinessEntityID WHERE T1.Name = 'France';

SELECT T1.Name, T3.Name FROM Product AS T1 INNER JOIN ProductVendor AS T2 ON T1.ProductID = T2.ProductID INNER JOIN Vendor AS T3 ON T2.BusinessEntityID = T3.BusinessEntityID WHERE STRFTIME('%Y', T1.SellStartDate) = '2013';

SELECT T2.FirstName, T2.MiddleName, T2.LastName FROM SalesPerson AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID ORDER BY T1.SalesYTD DESC LIMIT 1;

SELECT T2.Name FROM ProductVendor AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID INNER JOIN Vendor AS T3 ON T1.BusinessEntityID = T3.BusinessEntityID WHERE T1.MaxOrderQty = 1000 AND T2.StandardCost > 17;

SELECT T2.FirstName, T2.LastName, T1.JobTitle FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.Gender = 'M' AND T1.MaritalStatus = 'M' ORDER BY T1.BirthDate LIMIT 1;

SELECT T3.Name FROM Product AS T1 INNER JOIN ProductVendor AS T2 ON T1.ProductID = T2.ProductID INNER JOIN Vendor AS T3 ON T2.BusinessEntityID = T3.BusinessEntityID WHERE T1.ProductNumber = 'WB-H098';

SELECT T2.Name FROM ProductVendor AS T1 INNER JOIN Vendor AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.ProductID = 348 ORDER BY T1.AverageLeadTime ASC LIMIT 1;

SELECT T2.FirstName, T2.LastName FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE STRFTIME('%Y', T1.BirthDate) > '1970' ORDER BY T1.SickLeaveHours LIMIT 1;

SELECT STRFTIME('%Y', CURRENT_TIMESTAMP) - STRFTIME('%Y', T1.BirthDate) + 1 , T3.Name FROM Employee AS T1 INNER JOIN EmployeeDepartmentHistory AS T2 USING (BusinessEntityID) INNER JOIN Department AS T3 USING (DepartmentID) ORDER BY T1.BirthDate DESC LIMIT 1;

SELECT DISTINCT ProductCategoryID FROM ProductSubcategory LIMIT 3;

SELECT SalesYTD - SalesQuota FROM SalesPerson WHERE BusinessEntityID = 288;

SELECT BusinessEntityID FROM SalesPerson ORDER BY SalesLastYear LIMIT 3;

SELECT TerritoryID FROM SalesTerritory ORDER BY SalesYTD DESC LIMIT 3;

SELECT Type FROM SpecialOffer WHERE Category = 'Reseller';

SELECT DiscountPct FROM SpecialOffer WHERE Type = 'Excess Inventory' ORDER BY DiscountPct DESC LIMIT 1;

SELECT PlannedCost - ActualCost FROM WorkOrderRouting WHERE ProductID = 818;

SELECT COUNT(*) FROM BillOfMaterials WHERE BOMLevel = 2 AND EndDate IS NULL;

SELECT COUNT(DocumentNode) FROM Document WHERE Status = 2 AND DocumentSummary IS NULL;

SELECT SalesTaxRateID FROM SalesTaxRate WHERE Name LIKE '%+%';

SELECT TransactionID FROM TransactionHistory WHERE TransactionType = 'W' ORDER BY Quantity DESC LIMIT 1;

SELECT Name FROM Vendor WHERE PreferredVendorStatus = 0 LIMIT 3;

SELECT COUNT(BusinessEntityID) FROM Vendor WHERE PreferredVendorStatus = 0 AND ActiveFlag = 1;

SELECT COUNT(T1.BusinessEntityID) FROM EmployeeDepartmentHistory AS T1 INNER JOIN Shift AS T2 ON T1.ShiftId = T2.ShiftId WHERE T2.ShiftId = 3 AND STRFTIME('%Y', T2.StartTime) >= '2009';

SELECT T3.Name FROM EmployeeDepartmentHistory AS T1 INNER JOIN Shift AS T2 ON T1.ShiftId = T2.ShiftId INNER JOIN Department AS T3 ON T1.DepartmentID = T3.DepartmentID WHERE T2.Name = 'Night' GROUP BY T3.Name ORDER BY COUNT(T1.BusinessEntityID) DESC LIMIT 1;

SELECT COUNT(*) FROM ShipMethod AS T1 INNER JOIN SalesOrderHeader AS T2 USING (ShipMethodID) WHERE T1.Name = 'XRQ - TRUCK GROUND';

SELECT T2.Name FROM SalesOrderHeaderSalesReason AS T1 INNER JOIN SalesReason AS T2 ON T1.SalesReasonID = T2.SalesReasonID WHERE T1.SalesOrderID = 43718;

SELECT T1.Name FROM ProductSubcategory AS T1 INNER JOIN ProductCategory AS T2 ON T1.ProductCategoryID = T2.ProductCategoryID WHERE T2.name = 'Bikes';

SELECT T2.Name FROM SalesPerson AS T1 INNER JOIN SalesTerritory AS T2 ON T1.TerritoryID = T2.TerritoryID GROUP BY T1.TerritoryID ORDER BY SUM(T1.SalesQuota) DESC LIMIT 1;

SELECT T1.Name FROM Product AS T1 INNER JOIN SalesOrderDetail AS T2 ON T1.ProductID = T2.ProductID WHERE T2.SalesOrderID = 43660;

SELECT T1.Name FROM Product AS T1 INNER JOIN SalesOrderDetail AS T2 ON T1.ProductID = T2.ProductID GROUP BY T1.Name ORDER BY SUM(T2.OrderQty) DESC LIMIT 0, 5;

SELECT T2.Shelf FROM Product AS T1 INNER JOIN ProductInventory AS T2 ON T1.ProductID = T2.ProductID WHERE T1.Name = 'Down Tube';

SELECT T2.Name FROM BusinessEntityAddress AS T1 INNER JOIN AddressType AS T2 ON T1.AddressTypeID = T2.AddressTypeID INNER JOIN Store AS T3 ON T1.BusinessEntityID = T3.BusinessEntityID WHERE T3.Name = 'Fun Toys and Bikes';

SELECT T1.Name FROM ContactType AS T1 INNER JOIN BusinessEntityContact AS T2 ON T1.ContactTypeID = T2.ContactTypeID INNER JOIN Store AS T3 ON T2.BusinessEntityID = T3.BusinessEntityID WHERE T3.Name = 'Next-Door Bike Store';

SELECT T2.ReferenceOrderID FROM Product AS T1 INNER JOIN TransactionHistory AS T2 ON T1.ProductID = T2.ProductID WHERE T1.Name = 'Mountain End Caps';

SELECT T1.AddressLine1 FROM Address AS T1 INNER JOIN BusinessEntityAddress AS T2 ON T1.AddressID = T2.AddressID WHERE T2.BusinessEntityID = 12;

SELECT T2.BusinessEntityID FROM Address AS T1 INNER JOIN BusinessEntityAddress AS T2 ON T1.AddressID = T2.AddressID WHERE T1.City = 'Dallas' LIMIT 3;

SELECT T2.Name FROM Address AS T1 INNER JOIN StateProvince AS T2 ON T1.StateProvinceID = T2.StateProvinceID WHERE T1.City = 'Racine';

SELECT CAST(SUM(CASE WHEN T1.Name = 'Arabic' THEN 1 ELSE 0 END) AS REAL) * 100 / SUM(CASE WHEN T1.Name = 'Thai' THEN 1 ELSE 0 END) FROM Culture AS T1 INNER JOIN ProductModelProductDescriptionCulture AS T2 ON T1.CultureID = T2.CultureID;

SELECT CAST(SUM(CASE WHEN T1.SalesQuota > 300000 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.BusinessEntityID) FROM SalesPerson AS T1 INNER JOIN SalesTerritory AS T2 ON T1.TerritoryID = T2.TerritoryID WHERE T2.CountryRegionCode = 'US' AND T2.Name = 'Northwest';

SELECT T2.LastReceiptCost - T2.StandardPrice FROM Product AS T1 INNER JOIN ProductVendor AS T2 ON T1.ProductID = T2.ProductID WHERE T1.Name LIKE '%Crankarm%';

SELECT T1.Name FROM Product AS T1 INNER JOIN ProductReview AS T2 ON T1.ProductID = T2.ProductID WHERE T2.Rating = ( SELECT Rating FROM ProductReview ORDER BY Rating DESC LIMIT 1 );

SELECT Rate FROM EmployeePayHistory WHERE PayFrequency = 1 ORDER BY Rate DESC LIMIT 1, 1;

SELECT COUNT(CreditCardID) FROM CreditCard WHERE CardType = 'Vista' AND ExpYear < 2007;

SELECT StartTime FROM Shift WHERE Name = 'Night';

SELECT Weight FROM Product WHERE WeightUnitMeasureCode = 'LB' GROUP BY Weight ORDER BY COUNT(Style) DESC LIMIT 1;

SELECT SalesLastYear - SalesYTD, Name, CountryRegionCode FROM SalesTerritory ORDER BY SalesLastYear - SalesYTD DESC LIMIT 1;

SELECT Name, ReorderPoint FROM Product WHERE SizeUnitMeasureCode = 'CM' ORDER BY Size DESC LIMIT 6;

SELECT TotalDue FROM PurchaseOrderHeader ORDER BY Freight DESC LIMIT 2, 1;

SELECT 10 * (ListPrice - StandardCost) FROM Product WHERE Weight IS NOT NULL ORDER BY Weight LIMIT 1;

SELECT TaxAmt, PurchaseOrderID FROM PurchaseOrderHeader ORDER BY TaxAmt DESC LIMIT 1;

SELECT COUNT(BusinessEntityID) FROM SalesPersonQuotaHistory WHERE SalesQuota < 500000;

SELECT T3.StartTime, T3.EndTime FROM Employee AS T1 INNER JOIN EmployeeDepartmentHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN Shift AS T3 ON T2.ShiftId = T3.ShiftId WHERE STRFTIME('%Y', T1.BirthDate) < '1969' ORDER BY T1.BirthDate LIMIT 5, 1;

SELECT T1.Name, T2.Rating FROM Product AS T1 INNER JOIN ProductReview AS T2 ON T1.ProductID = T2.ProductID WHERE T1.DaysToManufacture = ( SELECT DaysToManufacture FROM Product ORDER BY DaysToManufacture LIMIT 1 ) ORDER BY T1.ListPrice - T1.StandardCost DESC LIMIT 1;

SELECT T2.FirstName, T2.MiddleName, T2.LastName FROM SalesPerson AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.Bonus < 1000;

SELECT T2.EndDate FROM Employee AS T1 INNER JOIN EmployeeDepartmentHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN Department AS T3 ON T2.DepartmentID = T3.DepartmentID WHERE T1.JobTitle = 'Senior Tool Designer' AND STRFTIME('%Y', T1.HireDate) - STRFTIME('%Y', T1.BirthDate) = 33 AND T2.EndDate IS NOT NULL;

SELECT SUM(T2.TotalDue) FROM Vendor AS T1 INNER JOIN PurchaseOrderHeader AS T2 ON T1.BusinessEntityID = T2.VendorID WHERE T1.CreditRating = 4 AND T1.PreferredVendorStatus = 0;

SELECT T3.Name FROM Shift AS T1 INNER JOIN EmployeeDepartmentHistory AS T2 ON T1.ShiftId = T2.ShiftId INNER JOIN Department AS T3 ON T2.DepartmentID = T3.DepartmentID GROUP BY T2.DepartmentID ORDER BY COUNT(T1.Name = 'Night') DESC LIMIT 1;

SELECT 2 * (T1.ListPrice - T1.StandardCost) FROM Product AS T1 INNER JOIN ProductSubcategory AS T2 ON T1.ProductSubcategoryID = T2.ProductSubcategoryID WHERE T1.Class = 'H' AND T1.Color = 'Black' AND T1.Size = 58 AND T2.Name = 'Road Bikes';

SELECT T2.FirstName, T2.MiddleName, T2.LastName FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.JobTitle LIKE 'Production Technician%' AND T1.Gender = 'M' AND T1.MaritalStatus = 'M' ORDER BY T1.BirthDate DESC LIMIT 10;

SELECT T2.Name, T2.CreditRating FROM ProductVendor AS T1 INNER JOIN Vendor AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.AverageLeadTime = 60 ORDER BY T1.LastReceiptCost - T1.StandardPrice DESC LIMIT 1;

SELECT T1.LastReceiptCost - T1.StandardPrice, T2.Name FROM ProductVendor AS T1 INNER JOIN Vendor AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.MaxOrderQty = 200;

SELECT T2.FirstName, T2.LastName FROM PurchaseOrderHeader AS T1 INNER JOIN Person AS T2 ON T1.EmployeeID = T2.BusinessEntityID WHERE T2.PersonType = 'EM' AND T1.Status = 3 GROUP BY T2.FirstName, T2.LastName ORDER BY COUNT(T1.PurchaseOrderID) DESC LIMIT 1;

SELECT T2.Name FROM ProductVendor AS T1 INNER JOIN Vendor AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID ORDER BY T1.MaxOrderQty ASC LIMIT 1, 1;

SELECT T2.MinOrderQty FROM Vendor AS T1 INNER JOIN ProductVendor AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.ActiveFlag = 0 ORDER BY T2.MinOrderQty LIMIT 1;

SELECT STRFTIME('%Y', T1.HireDate) - STRFTIME('%Y', T1.BirthDate), T2.FirstName, T2.MiddleName, T2.LastName FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.VacationHours <= 10 ORDER BY STRFTIME('%Y', T1.HireDate) - STRFTIME('%Y', T1.BirthDate) DESC LIMIT 1;

SELECT T2.PersonType FROM Employee AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.Gender = 'F' AND T1.MaritalStatus = 'S' AND STRFTIME('%Y-%m-%d', T1.HireDate) BETWEEN '2008-1-1' AND '2008-12-31' GROUP BY T2.PersonType ORDER BY COUNT(T2.PersonType) DESC LIMIT 1;

SELECT T2.ListPrice - T2.StandardCost FROM ProductReview AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T1.ReviewerName = 'David' ORDER BY T1.Rating DESC LIMIT 1;

SELECT T3.'Group', T2.Name FROM SalesTaxRate AS T1 INNER JOIN StateProvince AS T2 ON T1.StateProvinceID = T2.StateProvinceID INNER JOIN SalesTerritory AS T3 ON T2.TerritoryID = T3.TerritoryID ORDER BY T1.TaxRate LIMIT 1, 1;

SELECT AVG(T1.ListPrice - T1.StandardCost), COUNT(DISTINCT T1.Size) , COUNT(DISTINCT T1.Style) FROM Product AS T1 INNER JOIN ProductSubcategory AS T2 ON T1.ProductSubcategoryID = T2.ProductSubcategoryID WHERE T1.Class = 'L' AND T2.Name = 'Road Frames' GROUP BY T1.Class, T1.Color;

SELECT DiscountPct FROM SpecialOffer WHERE Description = 'LL Road Frame Sale';

SELECT COUNT(SpecialOfferID) FROM SpecialOffer WHERE Type = 'Excess Inventory';

SELECT Description FROM SpecialOffer WHERE Type = 'Seasonal Discount' ORDER BY DiscountPct DESC LIMIT 1;

SELECT Description, DiscountPct FROM SpecialOffer WHERE Category = 'Reseller' ORDER BY DiscountPct DESC LIMIT 0, 3;

SELECT Demographics FROM Store WHERE Name = 'Valley Bicycle Specialists';

SELECT SUM(FinishedGoodsFlag) FROM Product WHERE MakeFlag = 1;

SELECT SafetyStockLevel FROM Product WHERE Name = 'Chainring Bolts';

SELECT Name FROM Product ORDER BY StandardCost DESC LIMIT 1;

SELECT PersonType FROM Person WHERE FirstName = 'David' AND LastName = 'Bradley';

SELECT COUNT(BusinessEntityID) FROM Person WHERE PersonType = 'SC' AND Title = 'Mr.';

SELECT T2.AddressLine1, T2.AddressLine2 FROM BusinessEntityAddress AS T1 INNER JOIN Address AS T2 ON T1.AddressID = T2.AddressID INNER JOIN Store AS T3 ON T1.BusinessEntityID = T3.BusinessEntityID WHERE T3.Name = 'Valley Bicycle Specialists';

SELECT T2.EmailAddress FROM Person AS T1 INNER JOIN EmailAddress AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.FirstName = 'David' AND T1.LastName = 'Bradley';

SELECT T2.PhoneNumber FROM Person AS T1 INNER JOIN PersonPhone AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.PersonType = 'SC';

SELECT T2.PasswordHash FROM Person AS T1 INNER JOIN Password AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.FirstName = 'David' AND T1.LastName = 'Bradley';

SELECT T2.EmailAddress FROM Person AS T1 INNER JOIN EmailAddress AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.EmailPromotion = 2;

SELECT T3.CardNumber FROM Person AS T1 INNER JOIN PersonCreditCard AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN CreditCard AS T3 ON T2.CreditCardID = T3.CreditCardID WHERE T1.FirstName = 'David' AND T1.LastName = 'Bradley';

SELECT T3.ExpYear FROM Person AS T1 INNER JOIN PersonCreditCard AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN CreditCard AS T3 ON T2.CreditCardID = T3.CreditCardID WHERE T1.FirstName = 'David' AND T1.LastName = 'Bradley';

SELECT T1.FirstName, T1.LastName FROM Person AS T1 INNER JOIN PersonCreditCard AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN CreditCard AS T3 ON T2.CreditCardID = T3.CreditCardID WHERE T3.ExpYear = 2007 AND T1.PersonType = 'SC';

SELECT COUNT(T1.FirstName) FROM Person AS T1 INNER JOIN PersonCreditCard AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN CreditCard AS T3 ON T2.CreditCardID = T3.CreditCardID WHERE T3.CardType = 'Vista' AND T1.PersonType = 'SC';

SELECT COUNT(T3.DepartmentID) FROM Person AS T1 INNER JOIN EmployeeDepartmentHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN Department AS T3 ON T2.DepartmentID = T3.DepartmentID WHERE T1.FirstName = 'David' AND T1.LastName = 'Bradley';

SELECT T2.DepartmentID FROM Person AS T1 INNER JOIN EmployeeDepartmentHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN Department AS T3 ON T2.DepartmentID = T3.DepartmentID WHERE T1.FirstName = 'David' AND T1.LastName = 'Bradley';

SELECT COUNT(T1.BusinessEntityID) FROM Person AS T1 INNER JOIN EmployeeDepartmentHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN Department AS T3 ON T2.DepartmentID = T3.DepartmentID WHERE T3.Name = 'Engineering' AND STRFTIME('%Y', T2.EndDate) > '2009' AND STRFTIME('%Y', T2.StartDate) < '2009';

SELECT T1.FirstName, T1.LastName FROM Person AS T1 INNER JOIN EmployeeDepartmentHistory AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN Department AS T3 ON T2.DepartmentID = T3.DepartmentID WHERE T3.Name = 'Engineering' ORDER BY T2.EndDate - T2.StartDate DESC LIMIT 1;

SELECT COUNT(T1.BusinessEntityID) FROM EmployeeDepartmentHistory AS T1 INNER JOIN Department AS T2 ON T1.DepartmentID = T2.DepartmentID INNER JOIN Person AS T3 ON T1.BusinessEntityID WHERE T3.PersonType = 'SC' AND T2.GroupName = 'Manufacturing' AND STRFTIME('%Y', T1.EndDate) >= '2007' AND STRFTIME('%Y', T1.StartDate) <= '2007';

SELECT T3.CardNumber FROM EmployeeDepartmentHistory AS T1 INNER JOIN Department AS T2 ON T1.DepartmentID = T2.DepartmentID INNER JOIN CreditCard AS T3 ON T1.ModifiedDate = T3.ModifiedDate INNER JOIN PersonCreditCard AS T4 ON T3.CreditCardID = T4.CreditCardID WHERE T2.Name = 'Finance' AND T1.EndDate IS NOT NULL;

SELECT COUNT(T1.BusinessEntityID) FROM EmployeeDepartmentHistory AS T1 INNER JOIN Department AS T2 ON T1.DepartmentID = T2.DepartmentID INNER JOIN PersonCreditCard AS T3 ON T1.BusinessEntityID = T3.BusinessEntityID INNER JOIN CreditCard AS T4 ON T3.CreditCardID = T4.CreditCardID WHERE T4.ExpYear = 2007 AND T2.Name = 'Engineering';

SELECT T2.EmailAddress FROM EmployeeDepartmentHistory AS T1 INNER JOIN EmailAddress AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID GROUP BY T2.BusinessEntityID ORDER BY COUNT(T1.DepartmentID) DESC LIMIT 1;

SELECT COUNT(T1.BusinessEntityID) FROM EmployeeDepartmentHistory AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID INNER JOIN Department AS T3 ON T1.DepartmentID = T3.DepartmentID WHERE T3.Name = 'Engineering' AND T2.EmailPromotion = 0;

SELECT COUNT(T1.BusinessEntityID) FROM EmployeeDepartmentHistory AS T1 INNER JOIN Department AS T2 ON T1.DepartmentID = T2.DepartmentID WHERE T2.GroupName = 'Quality Assurance' AND STRFTIME('%Y', T1.StartDate) = '2007';

SELECT T3.Name FROM SpecialOffer AS T1 INNER JOIN SpecialOfferProduct AS T2 ON T1.SpecialOfferID = T2.SpecialOfferID INNER JOIN Product AS T3 ON T2.ProductID = T3.ProductID WHERE T1.Description = 'LL Road Frame Sale';

SELECT COUNT(DISTINCT ProductID) FROM SpecialOffer AS T1 INNER JOIN SpecialOfferProduct AS T2 ON T1.SpecialOfferID = T2.SpecialOfferID WHERE T1.Description = 'LL Road Frame Sale';

SELECT CASE WHEN COUNT(T1.Description) >= 1 THEN 'Yes' ELSE 'No' END FROM SpecialOffer AS T1 INNER JOIN SpecialOfferProduct AS T2 ON T1.SpecialOfferID = T2.SpecialOfferID INNER JOIN Product AS T3 ON T2.ProductID = T3.ProductID WHERE T3.Name = 'Chainring Bolts';

SELECT COUNT(T2.ProductID) FROM SpecialOffer AS T1 INNER JOIN SpecialOfferProduct AS T2 ON T1.SpecialOfferID = T2.SpecialOfferID INNER JOIN Product AS T3 ON T2.ProductID = T3.ProductID INNER JOIN ProductSubcategory AS T4 ON T3.ProductSubcategoryID = T4.ProductSubcategoryID INNER JOIN ProductCategory AS T5 ON T4.ProductCategoryID = T5.ProductCategoryID WHERE T1.Description = 'LL Road Frame Sale' AND T4.Name = 'Clothing';

SELECT CASE WHEN T1.MakeFlag = 1 THEN T1.Name END FROM Product AS T1 INNER JOIN ProductSubcategory AS T2 ON T1.ProductSubcategoryID = T2.ProductSubcategoryID INNER JOIN ProductCategory AS T3 ON T2.ProductCategoryID = T3.ProductCategoryID WHERE T2.ProductSubcategoryID = 3;

SELECT CAST(SUM(365 * (STRFTIME('%Y', T1.EndDate) - STRFTIME('%Y', T1.StartDate)) + 30 * (STRFTIME('%m', T1.EndDate) - STRFTIME('%m', T1.StartDate)) + STRFTIME('%d', T1.EndDate) - STRFTIME('%d', T1.StartDate)) AS REAL) / COUNT(T1.BusinessEntityID) FROM EmployeeDepartmentHistory AS T1 INNER JOIN Department AS T2 ON T1.DepartmentID = T2.DepartmentID WHERE T2.Name = 'Engineering' AND T1.EndDate IS NOT NULL;

SELECT AVG(T3.Rate) FROM EmployeeDepartmentHistory AS T1 INNER JOIN Department AS T2 ON T1.DepartmentID = T2.DepartmentID INNER JOIN EmployeePayHistory AS T3 ON T1.BusinessEntityID = T3.BusinessEntityID WHERE T2.Name = 'Engineering' AND STRFTIME('%Y', EndDate) > '2007' AND STRFTIME('%Y', T1.StartDate) < '2007';

SELECT (MAX(T1.ListPrice) - MIN(T1.ListPrice)) * 100 / MIN(T1.ListPrice) FROM Product AS T1 INNER JOIN ProductSubcategory AS T2 ON T1.ProductSubcategoryID = T2.ProductSubcategoryID INNER JOIN ProductCategory AS T3 ON T2.ProductCategoryID = T3.ProductCategoryID WHERE T3.Name = 'Clothing';

SELECT SUM(T1.ListPrice - T1.StandardCost) / COUNT(T1.ProductID) FROM Product AS T1 INNER JOIN ProductSubcategory AS T2 ON T1.ProductSubcategoryID = T2.ProductSubcategoryID INNER JOIN ProductCategory AS T3 ON T2.ProductCategoryID = T3.ProductCategoryID WHERE T3.Name = 'Clothing';

SELECT ProductID FROM ProductCostHistory WHERE StartDate LIKE '2013%' ORDER BY StandardCost LIMIT 1;

SELECT ProductID FROM Product WHERE Color = 'Yellow';

SELECT BusinessEntityID FROM Person WHERE Title = 'Mr.' AND FirstName = 'Hung-Fu' AND LastName = 'Ting';

SELECT PhoneNumber FROM PersonPhone WHERE BusinessEntityID = 12597;

SELECT ListPrice FROM ProductListPriceHistory WHERE ProductID = 912;

SELECT CASE WHEN ActualCost = PlannedCost THEN 'No' ELSE 'Yes' END FROM WorkOrderRouting;

SELECT T2.ThumbnailPhotoFileName FROM ProductProductPhoto AS T1 INNER JOIN ProductPhoto AS T2 ON T1.ProductPhotoID = T2.ProductPhotoID WHERE T1.ProductID = 979;

SELECT DISTINCT T2.Name FROM ProductListPriceHistory AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T1.ListPrice > 1000;

SELECT T1.ProductID FROM ProductListPriceHistory AS T1 INNER JOIN ProductCostHistory AS T2 ON T1.ProductID = T2.ProductID ORDER BY T1.ListPrice - T2.StandardCost DESC LIMIT 1;

SELECT T2.Name FROM ProductInventory AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T1.LocationID = 1 AND T1.Shelf = 'L' AND T1.Bin = 6;

SELECT T2.Name FROM WorkOrderRouting AS T1 INNER JOIN Location AS T2 ON T1.LocationID = T2.LocationID WHERE T1.WorkOrderID = 35493;

SELECT T2.ProductID FROM ProductPhoto AS T1 INNER JOIN ProductProductPhoto AS T2 ON T1.ProductPhotoID = T2.ProductPhotoID WHERE T1.LargePhotoFileName LIKE '%large.gif';

SELECT T2.ProductID FROM ProductSubcategory AS T1 INNER JOIN Product AS T2 ON T1.ProductSubcategoryID = T2.ProductSubcategoryID WHERE T1.Name = 'Socks';

SELECT 100 / T2.ListPrice FROM Product AS T1 INNER JOIN ProductListPriceHistory AS T2 ON T1.ProductID = T2.ProductID WHERE T1.Name = 'Cable Lock';

SELECT T2.Name FROM WorkOrder AS T1 INNER JOIN ScrapReason AS T2 ON T1.ScrapReasonID = T2.ScrapReasonID WHERE T1.WorkOrderID = 57788;

SELECT T2.StandardCost FROM Product AS T1 INNER JOIN ProductCostHistory AS T2 ON T1.ProductID = T2.ProductID WHERE T1.Name LIKE '%Sport%';

SELECT T2.Quantity FROM Location AS T1 INNER JOIN ProductInventory AS T2 ON T1.LocationID = T2.LocationID WHERE T2.ProductID = 476 AND T1.Name = 'Metal Storage';

SELECT DISTINCT T2.ProductID FROM ProductCostHistory AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T1.StandardCost < ( SELECT SUM(StandardCost) / COUNT(ProductID) FROM Product );

SELECT (T1.ListPrice - T2.StandardCost) * 100 / T2.StandardCost FROM ProductListPriceHistory AS T1 INNER JOIN ProductCostHistory AS T2 ON T1.ProductID = T2.ProductID WHERE T1.ProductID = 858;

SELECT COUNT(ProductID) FROM ProductProductPhoto WHERE ProductPhotoID != 1;

SELECT 365 * (STRFTIME('%Y', ActualEndDate) - STRFTIME('%Y', ActualStartDate)) + 30 * (STRFTIME('%m', ActualEndDate) - STRFTIME('%m', ActualStartDate)) + STRFTIME('%d', ActualEndDate) - STRFTIME('%d', ActualStartDate) FROM WorkOrderRouting WHERE WorkOrderID = 425;

SELECT ProductID FROM ProductListPriceHistory WHERE StartDate LIKE '2012%' ORDER BY ListPrice DESC LIMIT 1;

SELECT StandardCost FROM ProductCostHistory WHERE ProductID = 847;

SELECT OrganizationLevel FROM Employee WHERE JobTitle = 'Human Resources Manager';

SELECT COUNT(WorkOrderID) FROM WorkOrder WHERE EndDate > DueDate;

SELECT T2.StandardCost, T2.ProductNumber FROM ProductCostHistory AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T1.ProductID = 888;

SELECT COUNT(DISTINCT T2.ProductID) FROM ProductPhoto AS T1 INNER JOIN ProductProductPhoto AS T2 ON T1.ProductPhotoID = T2.ProductPhotoID WHERE T1.LargePhotoFileName = 'roadster_black_large.gif';

SELECT T2.LocationID, T2.Shelf, T2.Bin FROM Product AS T1 INNER JOIN ProductInventory AS T2 ON T1.ProductID = T2.ProductID WHERE T1.Name LIKE 'Lock Ring';

SELECT T2.Name FROM ProductSubcategory AS T1 INNER JOIN ProductCategory AS T2 ON T1.ProductCategoryID = T2.ProductCategoryID WHERE T1.Name = 'Road Frames';

SELECT T2.WorkOrderID FROM ScrapReason AS T1 INNER JOIN WorkOrder AS T2 ON T1.ScrapReasonID = T2.ScrapReasonID WHERE T1.Name = 'Handling damage';

SELECT T1.ListPrice - T2.StandardCost FROM ProductListPriceHistory AS T1 INNER JOIN ProductCostHistory AS T2 ON T1.ProductID = T2.ProductID WHERE T1.ProductID = 792;

SELECT T2.FirstName, T2.LastName FROM EmailAddress AS T1 INNER JOIN Person AS T2 ON T1.BusinessEntityID = T2.BusinessEntityID WHERE T1.EmailAddress = 'regina7@adventure-works.com';

SELECT T2.Name FROM ProductInventory AS T1 INNER JOIN Location AS T2 ON T1.LocationID = T2.LocationID WHERE T1.ProductID = 810;

SELECT T2.Name FROM WorkOrder AS T1 INNER JOIN Product AS T2 ON T1.ProductID = T2.ProductID WHERE T1.WorkOrderID = 2540;

SELECT T2.ListPrice FROM Product AS T1 INNER JOIN ProductListPriceHistory AS T2 ON T1.ProductID = T2.ProductID WHERE T1.Name = 'AWC Logo Cap';

SELECT T2.WorkOrderID FROM Product AS T1 INNER JOIN WorkOrder AS T2 ON T1.ProductID = T2.ProductID WHERE T1.Name = 'Down Tube';

SELECT AVG((T1.ListPrice - T2.StandardCost) * 100 / T2.StandardCost) FROM ProductListPriceHistory AS T1 INNER JOIN ProductCostHistory AS T2 ON T1.ProductID = T2.ProductID;

SELECT 100.0 * SUM(CASE WHEN T1.Name = 'Subassembly' THEN 1 ELSE 0 END) / COUNT(T2.WorkOrderID) FROM Location AS T1 INNER JOIN WorkOrderRouting AS T2 ON T1.LocationID = T2.LocationID;

