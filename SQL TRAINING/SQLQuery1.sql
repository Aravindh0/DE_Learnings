 -- 1 Retrieve the names of all products in the Product table

SELECT PRODUCTID, NAME FROM PRODUCTION.PRODUCT ORDER BY PRODUCTID

-- 2 Display the addresses of all customers from the Customer table

SELECT DISTINCT C.CUSTOMERID, A.ADDRESSID, A.ADDRESSLINE1, A.ADDRESSLINE2, A.CITY
FROM SALES.CUSTOMER C
JOIN SALES.SALESORDERHEADER H ON H.CUSTOMERID = C.CUSTOMERID
JOIN PERSON.ADDRESS A ON H.BILLTOADDRESSID=A.ADDRESSID


-- 3 List the names and salaries of all employees from the Employee table

SELECT P.FIRSTNAME,P.LASTNAME,H.RATE FROM PERSON.PERSON P JOIN HumanResources.EmployeePayHistory H ON P.BusinessEntityID = H.BusinessEntityID

-- 4 Show the order IDs and total amounts from the SalesOrderHeader table

SELECT SALESORDERID, TOTALDUE FROM SALES.SalesOrderHeader

-- 5 Fetch the categories of all products from the ProductCategory table

SELECT PRODUCTCATEGORYID, NAME FROM Production.ProductCategory

-- 6 Retrieve all columns from the Product table

SELECT * FROM Production.Product

-- 7 Display all columns from the SalesOrderHeader table

SELECT * FROM Sales.SalesOrderHeader

-- 8 List all columns from the Customer table

SELECT * FROM Sales.Customer

-- 9 Fetch all columns from the Employee table

SELECT * FROM HumanResources.Employee

-- 10 Display all columns from the ProductCategory table

SELECT * FROM Production.ProductCategory

-- 11 Insert a new product into the Product table
SELECT * FROM [Production].[Product]
EXEC SP_HELP 'Production.Product'

INSERT INTO [Production].[Product]
	([Name],[ProductNumber],[MakeFlag],[FinishedGoodsFlag],[Color],[SafetyStockLevel],[ReorderPoint],[StandardCost],[ListPrice],[Size],
	[SizeUnitMeasureCode],[WeightUnitMeasureCode],[Weight],[DaysToManufacture],[ProductLine],[Class],[Style],[ProductSubcategoryID],
	[ProductModelID],[SellStartDate],[SellEndDate],[DiscontinuedDate],[rowguid],[ModifiedDate])
VALUES
	('Vintage Handcrafted Wooden Handlebars','VHWH1000',1,1,'GOLD',3,4,6.9223,8.9,'M','CM','LB',1.5,1,'M','H','U',23,18,'2011-05-31 10:00:00.000',
	'2011-08-31 10:00:00.000','2012-05-31 10:00:00.000',NEWID(),'2014-02-08 10:02:36.827')

-- 12 Add a new customer into the Customer table

INSERT INTO [Sales].[Customer]
	([PersonID],[StoreID],[TerritoryID],[rowguid],[ModifiedDate])
VALUES
	(NULL,1956,10,NEWID(),'2014-09-12 11:15:07.263')
SELECT * FROM [Sales].[Customer]

-- 13 Insert a new employee into the Employee table

INSERT INTO [HumanResources].[Employee]
	([BusinessEntityID],[NationalIDNumber],[LoginID]         ,[JobTitle],[BirthDate],[MaritalStatus],[Gender],[HireDate],[SalariedFlag],[VacationHours],
	[SickLeaveHours],[CurrentFlag],[rowguid],[ModifiedDate])
VALUES
(291,'10000001','adventure-works\ken12','Design Engineer','1952-09-27','S','M','2008-01-24',0,5,23,1,NEWID(),'2014-06-30 00:00:00.000')
SELECT * FROM [HumanResources].[Employee]

-- 14 Add a new sales order into the SalesOrderHeader table

INSERT INTO [Sales].[SalesOrderHeader]
	([RevisionNumber],[OrderDate],[DueDate],[ShipDate],[Status],[OnlineOrderFlag],[PurchaseOrderNumber],[AccountNumber],[CustomerID],[SalesPersonID],[TerritoryID],[BillToAddressID],
	[ShipToAddressID],[ShipMethodID],[CreditCardID],[CreditCardApprovalCode],[CurrencyRateID],[SubTotal],[TaxAmt],[Freight],[Comment],[rowguid],[ModifiedDate])
VALUES
	(8,'2011-05-31 00:00:00.000','2011-06-12 00:00:00.000','2011-06-07 00:00:00.000',5,0,'PO18009186470',10-4020-000646,29614,283,5,517,849,5,15232,'55680Vi53503',
	4,20565.6206,1971.5149,616.0984,NULL,NEWID(),'2011-06-07 00:00:00.000')

SELECT * FROM [Sales].[SalesOrderHeader]

--15 Insert a new product category into the ProductCategory table 

INSERT INTO [Production].[ProductCategory]
	([Name],[rowguid],[ModifiedDate])
VALUES
	('Painting',NEWID(),'008-07-30 00:00:00.000')

SELECT * FROM  [Production].[ProductCategory]

-- 16 Update the price of a specific product in the Product table

UPDATE [Production].[Product]
SET ListPrice = 1000
WHERE PRODUCTID=1

SELECT * FROM [Production].[Product] 
WHERE PRODUCTID = 1

-- 17 Update the address of a particular customer in the Customer table
SELECT DISTINCT(C.CUSTOMERID), A.ADDRESSID, A.ADDRESSLINE1, A.ADDRESSLINE2, A.CITY
FROM SALES.CUSTOMER C
JOIN SALES.SALESORDERHEADER H ON H.CUSTOMERID = C.CUSTOMERID
JOIN PERSON.ADDRESS A ON H.BILLTOADDRESSID=A.ADDRESSID
WHERE H.CustomerID = 11002

UPDATE A
SET A.ADDRESSLINE1 = '000A, 5TH ST'
FROM PERSON.ADDRESS A
JOIN SALES.SALESORDERHEADER H ON H.BILLTOADDRESSID = A.ADDRESSID
WHERE H.CUSTOMERID = 11002;

-- 18 Update the salary of an employee in the Employee table

SELECT P.FIRSTNAME,P.LASTNAME,H.RATE,P.BusinessEntityID 
FROM PERSON.PERSON P JOIN HumanResources.EmployeePayHistory H ON P.BusinessEntityID = H.BusinessEntityID
WHERE P.BusinessEntityID = 1

UPDATE H
SET H.RATE = '120'
FROM HumanResources.EmployeePayHistory H JOIN PERSON.PERSON P  ON P.BusinessEntityID = H.BusinessEntityID
WHERE P.BusinessEntityID = 1

-- 19 Update the order status of a sales order in the SalesOrderHeader table

UPDATE [Sales].[SalesOrderHeader]
SET STATUS = 6
WHERE SALESORDERID = 43659
SELECT SalesOrderID, STATUS FROM [Sales].[SalesOrderHeader]

-- 20 Update the description of a product category in the ProductCategory table

SELECT P.PRODUCTID, C.PRODUCTCATEGORYID, D.ProductDescriptionID, PD.Description 
FROM PRODUCTION.PRODUCT P 
JOIN PRODUCTION.PRODUCTSUBCATEGORY S ON S.ProductSubcategoryID = P. ProductSubcategoryID
JOIN PRODUCTION.ProductCategory C ON S.ProductcategoryID = C.ProductCategoryID
JOIN Production.ProductModelProductDescriptionCulture D ON P.ProductModelID = D.ProductModelID
JOIN Production.ProductDescription PD ON D.ProductDescriptionID = PD.ProductDescriptionID 
WHERE P.ProductID = 994

UPDATE PD
SET PD.Description = 'NEW DESCRIPTION'
FROM PRODUCTION.PRODUCT P 
JOIN PRODUCTION.PRODUCTSUBCATEGORY S ON S.ProductSubcategoryID = P. ProductSubcategoryID
JOIN PRODUCTION.ProductCategory C ON S.ProductcategoryID = C.ProductCategoryID
JOIN Production.ProductModelProductDescriptionCulture D ON P.ProductModelID = D.ProductModelID
JOIN Production.ProductDescription PD ON D.ProductDescriptionID = PD.ProductDescriptionID
WHERE P.PRODUCTID=994

-- 21 Delete a specific product from the Product table *
DELETE [Production].[BillOfMaterials]
WHERE ProductID = 1

DELETE [Production].[Product] [Production].[BillOfMaterials]
WHERE ProductID = 1

-- 22 Remove a customer from the Customer table

DELETE [Sales].[Customer] 
WHERE CustomerID = 1

SELECT * FROM [Sales].[Customer]

-- 23 Delete an employee from the Employee table *

DELETE [HumanResources].[Employee]
WHERE BusinessEntityID = 1
SELECT * FROM [HumanResources].[Employee]

-- 24 Remove a sales order from the SalesOrderHeader table

DELETE [Sales].[SalesOrderHeader]
WHERE SalesOrderID = 43659

SELECT * FROM [Sales].[SalesOrderHeader]

-- 25 Delete a product category from the ProductCategory table

BEGIN TRAN
DELETE FROM Production.ProductDocument WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.ProductReview WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM sales.SalesOrderDetail WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM sales.SpecialOfferProduct WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.ProductProductPhoto WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.ProductListPriceHistory WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.ProductInventory WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.ProductCostHistory WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.TransactionHistory WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.BillOfMaterials WHERE ProductAssemblyID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.BillOfMaterials WHERE ComponentID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.WorkOrderRouting WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.WorkOrder WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
 
DELETE FROM Production.Product WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
 
ALTER TABLE Production.ProductSubcategory   NOCHECK  CONSTRAINT all
ALTER TABLE Production.ProductCategory   NOCHECK  CONSTRAINT all
DELETE FROM Production.ProductSubcategory WHERE ProductSubcategoryID in (1,2,3)
 
DELETE FROM Production.ProductCategory WHERE ProductCategoryID = 3
ALTER TABLE Production.ProductSubcategory   CHECK  CONSTRAINT all
ALTER TABLE Production.ProductCategory   CHECK  CONSTRAINT all
 
SELECT * FROM Production.ProductCategory
 
ROLLBACK TRAN

-- 26 Retrieve the names of all products from the Product table ordered alphabetically

SELECT PRODUCTID,NAME,PRODUCTNUMBER FROM [Production].[Product] ORDER BY NAME

-- 27 Display the addresses of all customers from the Customer table ordered by postal code

SELECT DISTINCT C.CUSTOMERID, A.ADDRESSID, A.ADDRESSLINE1, A.ADDRESSLINE2, A.CITY,A.POSTALCODE
FROM SALES.CUSTOMER C
JOIN SALES.SALESORDERHEADER H ON H.CUSTOMERID = C.CUSTOMERID
JOIN PERSON.ADDRESS A ON H.BILLTOADDRESSID=A.ADDRESSID ORDER BY POSTALCODE

-- 28 List the names and salaries of all employees from the Employee table ordered by salary in descending order

SELECT P.FIRSTNAME,P.LASTNAME,H.RATE FROM PERSON.PERSON P JOIN HumanResources.EmployeePayHistory H ON P.BusinessEntityID = H.BusinessEntityID ORDER BY RATE DESC

-- 29 Show the order IDs and total amounts from the SalesOrderHeader table ordered by order date

SELECT SalesOrderID, TotalDue,OrderDate FROM [Sales].[SalesOrderHeader] ORDER BY OrderDate

-- 30 Fetch the categories of all products from the ProductCategory table ordered by category ID

SELECT C.ProductCategoryID, C.Name, P.NAME 
FROM [Production].[Product] P 
JOIN [Production].[ProductSubcategory] S ON P.ProductSubcategoryID = S.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = S.ProductCategoryID
ORDER BY C.ProductCategoryID

-- 31 Retrieve the products from the Product table where the price is greater than $100

SELECT * FROM [Production].[Product] WHERE ListPrice > 100

-- 32 Display the customers from the Customer table where the city is 'Seattle'

SELECT DISTINCT C.CUSTOMERID, A.ADDRESSID, A.ADDRESSLINE1, A.ADDRESSLINE2, A.CITY
FROM SALES.CUSTOMER C
JOIN SALES.SALESORDERHEADER H ON H.CUSTOMERID = C.CUSTOMERID
JOIN PERSON.ADDRESS A ON H.BILLTOADDRESSID=A.ADDRESSID
WHERE CITY = 'SEATTLE'

-- 33 List the employees from the Employee table where the job title is 'Sales Representative'

SELECT P.BusinessEntityID,P.FirstName,P.LastName, E.JOBTITLE 
FROM [HumanResources].[Employee] E
JOIN [Person].[Person] P ON E.BusinessEntityID = P.BusinessEntityID
WHERE JobTitle = 'Sales Representative'

-- 34 Show the sales orders from the SalesOrderHeader table where the total amount is less than $500

SELECT * FROM [Sales].[SalesOrderHeader] WHERE TotalDue < 500

-- 35 Fetch the products from the Product table where the product category is 'Accessories'

SELECT C.ProductCategoryID, C.Name, P.NAME 
FROM [Production].[Product] P 
JOIN [Production].[ProductSubcategory] S ON P.ProductSubcategoryID = S.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = S.ProductCategoryID
WHERE C.NAME = 'Accessories'

-- 36 Retrieve the first name, last name, and email of all employees

SELECT P.FirstName,P.LastName, E.EmailAddress, P.PersonType
FROM [Person].[Person] P 
JOIN [Person].[EmailAddress] E ON P.BusinessEntityID = E.BusinessEntityID
WHERE PersonType = 'EM'

-- 37 Get the product name, list price, and color of all products

SELECT NAME, ListPrice, Color FROM [Production].[Product]

-- 38 Find the category name and description for all product categories

SELECT P.PRODUCTID, C.PRODUCTCATEGORYID,C.Name, PD.Description 
FROM PRODUCTION.PRODUCT P 
JOIN PRODUCTION.PRODUCTSUBCATEGORY S ON S.ProductSubcategoryID = P. ProductSubcategoryID
JOIN PRODUCTION.ProductCategory C ON S.ProductcategoryID = C.ProductCategoryID
JOIN Production.ProductModelProductDescriptionCulture D ON P.ProductModelID = D.ProductModelID
JOIN Production.ProductDescription PD ON D.ProductDescriptionID = PD.ProductDescriptionID 

-- 39 List the name, weight, and size of all products

SELECT NAME,WEIGHT,SIZE FROM [Production].[Product]

-- 40 Display the order date, customer ID, and total due amount for all orders

SELECT OrderDate, CustomerID, TotalDue FROM [Sales].[SalesOrderHeader]

-- 41 Retrieve all columns for the Product tab (6)

SELECT * FROM Production.Product

-- 42 Get all columns for the Employee table

SELECT * FROM [HumanResources].[Employee]

-- 43 Retrieve all columns for the SalesOrderHeader table (7)

SELECT * FROM Sales.SalesOrderHeader

-- 44 Fetch all columns for the Customer table (8)

SELECT * FROM Sales.Customer

-- 45 Get all columns for the ProductCategory table (10)

SELECT * FROM Production.ProductCategory

-- 46 Insert a new product with the specified name, list price, and color

INSERT INTO [Production].[Product]
	([Name],[ProductNumber],[Color],[SafetyStockLevel],[ReorderPoint],[StandardCost],[ListPrice],[Size],
	[SizeUnitMeasureCode],[WeightUnitMeasureCode],[Weight],[DaysToManufacture],[SellStartDate])
     VALUES
	('BIKE HANDLE','RV-H123','BLUE',250,20,145.88,2000,20,'CM','LB',2,0,'2008-04-30 00:00:00.000')
SELECT * FROM [Production].[Product]

-- 47 Add a new employee with the given first name, last name, and email

INSERT INTO [Person].[BusinessEntity]
	([rowguid],[ModifiedDate])
	VALUES
	(NEWID(),'2009-01-22 00:00:00.000')
INSERT INTO [Person].[Person]
	([BusinessEntityID],[PersonType],[NameStyle],[FirstName],[LastName],[EmailPromotion],[rowguid],[ModifiedDate])
     VALUES
	(20778,'EM',0,'ARAVINDH','A',0,NEWID(),'2009-01-22 00:00:00.000')
SELECT * FROM [Person].[Person]
INSERT INTO [Person].[EmailAddress]
	([BusinessEntityID],[EmailAddress],[rowguid],[ModifiedDate])
	VALUES
	(20778,'aravndh@hotmail.com',newid(),'2009-01-22 00:00:00.000')
SELECT * FROM [Person].[EmailAddress]

SELECT P.FirstName,P.LastName, E.EmailAddress, P.PersonType
FROM [Person].[Person] P 
JOIN [Person].[EmailAddress] E ON P.BusinessEntityID = E.BusinessEntityID
WHERE E.BusinessEntityID = 20778

-- 48 Insert a new customer with the provided details (12)

INSERT INTO [Sales].[Customer]
	([PersonID],[StoreID],[TerritoryID],[rowguid],[ModifiedDate])
VALUES
	(NULL,1956,10,NEWID(),'2014-09-12 11:15:07.263')
SELECT * FROM [Sales].[Customer]

-- 49 Add a new record into the ProductCategory table (15)

INSERT INTO [Production].[ProductCategory]
	([Name],[rowguid],[ModifiedDate])
VALUES
	('Painting',NEWID(),'008-07-30 00:00:00.000')

SELECT * FROM  [Production].[ProductCategory]

-- 50 Insert a new record into the SalesOrderHeader table (14)

INSERT INTO [Sales].[SalesOrderHeader]
	([RevisionNumber],[OrderDate],[DueDate],[ShipDate],[Status],[OnlineOrderFlag],[PurchaseOrderNumber],[AccountNumber],[CustomerID],[SalesPersonID],[TerritoryID],[BillToAddressID],
	[ShipToAddressID],[ShipMethodID],[CreditCardID],[CreditCardApprovalCode],[CurrencyRateID],[SubTotal],[TaxAmt],[Freight],[Comment],[rowguid],[ModifiedDate])
VALUES
	(8,'2011-05-31 00:00:00.000','2011-06-12 00:00:00.000','2011-06-07 00:00:00.000',5,0,'PO18009186470',10-4020-000646,29614,283,5,517,849,5,15232,'55680Vi53503',
	4,20565.6206,1971.5149,616.0984,NULL,NEWID(),'2011-06-07 00:00:00.000')

SELECT * FROM [Sales].[SalesOrderHeader]

-- 51 Update the list price of a specific product (16)

UPDATE [Production].[Product]
SET ListPrice = 1000
WHERE PRODUCTID=1

-- 52 Modify the email address of an employee

UPDATE [Person].[EmailAddress]
SET EmailAddress = 'newmail@gmail.com'
where EmailAddressID = 1

SELECT * FROM [Person].[EmailAddress]

-- 53 Update the customer's contact information

SELECT DISTINCT(C.CUSTOMERID), A.ADDRESSID, A.ADDRESSLINE1, A.ADDRESSLINE2, A.CITY
FROM SALES.CUSTOMER C
JOIN SALES.SALESORDERHEADER H ON H.CUSTOMERID = C.CUSTOMERID
JOIN PERSON.ADDRESS A ON H.BILLTOADDRESSID=A.ADDRESSID
WHERE H.CustomerID = 11002

UPDATE A
SET A.ADDRESSLINE1 = '000A, 5TH ST'
FROM PERSON.ADDRESS A
JOIN SALES.SALESORDERHEADER H ON H.BILLTOADDRESSID = A.ADDRESSID
WHERE H.CUSTOMERID = 11002;

-- 54 Update the description of a product category (20)

SELECT P.PRODUCTID, C.PRODUCTCATEGORYID, D.ProductDescriptionID, PD.Description 
FROM PRODUCTION.PRODUCT P 
JOIN PRODUCTION.PRODUCTSUBCATEGORY S ON S.ProductSubcategoryID = P. ProductSubcategoryID
JOIN PRODUCTION.ProductCategory C ON S.ProductcategoryID = C.ProductCategoryID
JOIN Production.ProductModelProductDescriptionCulture D ON P.ProductModelID = D.ProductModelID
JOIN Production.ProductDescription PD ON D.ProductDescriptionID = PD.ProductDescriptionID 
WHERE P.ProductID = 994

UPDATE PD
SET PD.Description = 'NEW DESCRIPTION'
FROM PRODUCTION.PRODUCT P 
JOIN PRODUCTION.PRODUCTSUBCATEGORY S ON S.ProductSubcategoryID = P. ProductSubcategoryID
JOIN PRODUCTION.ProductCategory C ON S.ProductcategoryID = C.ProductCategoryID
JOIN Production.ProductModelProductDescriptionCulture D ON P.ProductModelID = D.ProductModelID
JOIN Production.ProductDescription PD ON D.ProductDescriptionID = PD.ProductDescriptionID
WHERE P.PRODUCTID=994

-- 55 Update the order date of a specific order

UPDATE [Sales].[SalesOrderHeader]
SET OrderDate='2011-05-20'
WHERE SalesOrderID= 43660
SELECT * FROM [Sales].[SalesOrderHeader]

-- 56 Delete a specific product from the Product table (21)*


-- 57 Remove an employee record based on the employee ID (23)*


-- 58 Delete a customer record based on the customer ID (22)

DELETE [Sales].[Customer] 
WHERE CustomerID = 1

SELECT * FROM [Sales].[Customer]

-- 59 Remove a product category record based on the category ID (25)

BEGIN TRAN
DELETE FROM Production.ProductDocument WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.ProductReview WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM sales.SalesOrderDetail WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM sales.SpecialOfferProduct WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.ProductProductPhoto WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.ProductListPriceHistory WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.ProductInventory WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.ProductCostHistory WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.TransactionHistory WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.BillOfMaterials WHERE ProductAssemblyID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.BillOfMaterials WHERE ComponentID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.WorkOrderRouting WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
DELETE FROM Production.WorkOrder WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
 
DELETE FROM Production.Product WHERE ProductID in
( SELECT ProductID FROM production.Product WHERE ProductSubcategoryID in (1,2,3))
 
ALTER TABLE Production.ProductSubcategory   NOCHECK  CONSTRAINT all
ALTER TABLE Production.ProductCategory   NOCHECK  CONSTRAINT all
DELETE FROM Production.ProductSubcategory WHERE ProductSubcategoryID in (1,2,3)
 
DELETE FROM Production.ProductCategory WHERE ProductCategoryID = 3
ALTER TABLE Production.ProductSubcategory   CHECK  CONSTRAINT all
ALTER TABLE Production.ProductCategory   CHECK  CONSTRAINT all
 
SELECT * FROM Production.ProductCategory
 
ROLLBACK TRAN

-- 60 Delete an order from the SalesOrderHeader table based on the order ID (24)

DELETE [Sales].[SalesOrderHeader]
WHERE SalesOrderID = 43659

SELECT * FROM [Sales].[SalesOrderHeader]

-- 61 Retrieve all products sorted by their list price in descending order

SELECT * FROM [Production].[Product] ORDER BY ListPrice DESC

-- 62 Get all employees sorted by their last name in ascending order

SELECT * FROM [Person].[Person] WHERE PersonType = 'EM' ORDER BY LastName

-- 63 Retrieve all orders sorted by their order date in descending order

SELECT * FROM [Sales].[SalesOrderHeader] ORDER BY ORDERDATE DESC

--64 Get all customers sorted by their country in ascending order

SELECT P.BUSINESSENTITYID, P.PERSONTYPE,P.FIRSTNAME, P.LASTNAME, C.NAME
FROM [Person].[Person] P
JOIN [Person].[BusinessEntityAddress] EA ON P.BUSINESSENTITYID = EA.BUSINESSENTITYID
JOIN [Person].[Address] A ON A.ADDRESSID = EA. ADDRESSID
JOIN [Person].[StateProvince] S ON S.STATEPROVINCEID = A.STATEPROVINCEID
JOIN [Person].[CountryRegion] C ON C.COUNTRYREGIONCODE = S.COUNTRYREGIONCODE 
WHERE P.PERSONTYPE = 'IN'
ORDER BY C.NAME

--65 Retrieve all product categories sorted by their name in ascending order

SELECT * FROM [Production].[ProductCategory] ORDER BY NAME

--66 Retrieve products where the list price is greater than a specified value

SELECT * FROM [Production].[Product] 
WHERE ListPrice > 500

-- 67 Get employees who joined the company after a certain date

SELECT * FROM  [HumanResources].[Employee]
WHERE HireDate > '2011-05-31'

-- 68 Retrieve orders placed by a specific customer

SELECT SOH.CUSTOMERID,P.ProductID,P.Name, SOH.OrderDate
FROM [Sales].[SalesOrderHeader] SOH 
JOIN [Sales].[SalesOrderDetail] SOD ON SOD.SalesOrderID = SOH.SalesOrderID 
JOIN [Production].[Product] P ON P.ProductID = SOD.ProductID
WHERE SOD.SalesOrderID = 43660

-- 69 Get products belonging to a specific category

SELECT  C.PRODUCTCATEGORYID, C.Name, P.PRODUCTID, P.Name
FROM PRODUCTION.PRODUCT P 
JOIN PRODUCTION.PRODUCTSUBCATEGORY S ON S.ProductSubcategoryID = P. ProductSubcategoryID
JOIN PRODUCTION.ProductCategory C ON S.ProductcategoryID = C.ProductCategoryID
JOIN Production.ProductModelProductDescriptionCulture D ON P.ProductModelID = D.ProductModelID
WHERE C.ProductCategoryID = 1

-- 70 Retrieve employees who belong to a specific department

SELECT EDH.BusinessEntityID,P.PersonType, EDH.DepartmentID, D.Name FROM [HumanResources].[EmployeeDepartmentHistory] EDH
JOIN [HumanResources].[Department] D ON D.DepartmentID = EDH.DepartmentID
JOIN [Person].[Person] P ON P.BusinessEntityID = EDH.BusinessEntityID
WHERE D.Name = 'Engineering'

-- 71 Retrieve the top 10 customers with the highest total order amounts

SELECT TOP 10 (CustomerID),SUM(TotalDue) 'Total Order Amount'
FROM [Sales].[SalesOrderHeader]
GROUP BY CustomerID
ORDER BY 'Total Order Amount' DESC

-- 72 Get the names of products that have been ordered at least 100 times

 SELECT SOD.ProductID,P.Name,COUNT(SOD.ProductID) 'NO OF ORDERS'
 FROM [Sales].[SalesOrderDetail] SOD
 JOIN [Production].[Product] P ON SOD.ProductID = P.ProductID
 GROUP BY SOD.ProductID,P.Name
 HAVING COUNT(SOD.ProductID) >= 100

-- 73 Find the average order total for each month in the past year *

SELECT YEAR(SOH.OrderDate) 'ORDER YEAR', MONTH(SOH.OrderDate) 'ORDER MONTH', AVG (SOH.TotalDue) 'AVERAGE ORDER TOTAL'
FROM [Sales].[SalesOrderHeader] SOH
JOIN [Sales].[SalesOrderDetail] SOD ON SOH.SalesOrderID = SOD.SalesOrderID
WHERE YEAR(OrderDate) = YEAR( DATEADD(YEAR,-1,(SELECT MAX(ORDERDATE) FROM  [Sales].[SalesOrderHeader])))
GROUP BY YEAR(OrderDate),MONTH(OrderDate)
ORDER BY YEAR(OrderDate),MONTH(OrderDate)

-- 74 List the employees who have not made any sales

SELECT * FROM [Sales].[SalesPerson] WHERE SalesYTD IS NULL

-- 75 Retrieve the top 5 product categories with the highest total sales revenue

SELECT TOP 5 C.ProductCategoryID,C.Name, SUM(SOH.TOTALDUE) 'TOTAL SALES REVCENUE'
FROM [Sales].[SalesOrderDetail] SOD
JOIN [Sales].[SalesOrderHeader] SOH ON SOH.SalesOrderID = SOD.SalesOrderID
JOIN [Production].[Product] P ON SOD.ProductID = P.ProductID
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID= SC.ProductCategoryID
GROUP BY C.ProductCategoryID,C.Name
ORDER BY 'TOTAL SALES REVCENUE' DESC

-- 76 Retrieve all columns for products that have been discontinued

SELECT * FROM [Production].[Product] WHERE DiscontinuedDate IS NOT NULL

-- 77 Get all columns for employees who have been with the company for more than 5 years *

SELECT * FROM [HumanResources].[EmployeeDepartmentHistory]
WHERE DATEDIFF(YEAR, StartDate, EndDate) >= 2014
SELECT COUNT(*)
FROM [HumanResources].[EmployeeDepartmentHistory]
WHERE DATEADD(YEAR, -1, '2014/06/01') >= 2014

-- 78 Retrieve all columns for customers who have placed orders within the last 30 days

SELECT * FROM [Sales].[SalesOrderHeader] WHERE OrderDate BETWEEN '2014/06/01' AND '2014/06/30'

-- 79 Fetch all columns for products with a stock quantity less than the reorder point

SELECT P.ProductID,P.ReorderPoint,W.StockedQty
FROM [Production].[Product] P
JOIN [Production].[WorkOrder] W ON P.ProductID = W.ProductID
WHERE W.StockedQty < P.ReorderPoint

-- 80 Retrieve all columns for orders that have been shipped but not yet delivered

SELECT * FROM [Sales].[SalesOrderHeader]
WHERE Status = 5

-- 81 Insert a new product and associate it with an existing product category

INSERT INTO [Production].[Product]
	([Name],[ProductNumber],[MakeFlag],[FinishedGoodsFlag],[Color],[SafetyStockLevel],[ReorderPoint],[StandardCost],[ListPrice],[Size],
	[SizeUnitMeasureCode],[WeightUnitMeasureCode],[Weight],[DaysToManufacture],[ProductLine],[Class],[Style],[ProductSubcategoryID],
	[ProductModelID],[SellStartDate],[SellEndDate],[DiscontinuedDate],[rowguid],[ModifiedDate])
VALUES
	('Vintage Handcrafted Wooden Handlebars','VHWH1000',1,1,'GOLD',3,4,6.9223,8.9,'M','CM','LB',1.5,1,'M','H','U',23,18,'2011-05-31 10:00:00.000',
	'2011-08-31 10:00:00.000','2012-05-31 10:00:00.000',NEWID(),'2014-02-08 10:02:36.827')

INSERT INTO [Production].[ProductSubcategory]
	([ProductCategoryID],[Name],[rowguid],[ModifiedDate])
VALUES
	(1, 'Vintage Handcrafted Wooden Handlebars', NEWID(),'2014-02-08 10:02:36.827')

SELECT * FROM [Production].[ProductSubcategory]

-- 82 Add a new employee along with their contact information and assign them to a specific department
-- 83 Insert a new customer and associate them with an existing sales territory
-- 84 Add a new record into the SalesOrderDetail table with appropriate references
-- 85 Insert a new record into the Address table for a customer
-- 86 Update the list price of products in a specific category by a certain percentage

UPDATE [Production].[Product]
SET ListPrice = 133.34 * 1.1
WHERE ProductSubcategoryID IN 
(SELECT ProductSubcategoryID
FROM [Production].[ProductSubcategory]
WHERE ProductCategoryID = 1 )

SELECT * FROM [Production].[Product]

-- 87 Modify the sales quota for employees based on their sales performance *

UPDATE [Sales].[SalesPersonQuotaHistory]
SET SalesQuota = SalesQuota * 1.1 
WHERE BusinessEntityID IN 
(SELECT BusinessEntityID
FROM [Sales].[SalesPersonQuotaHistory]
WHERE  > SalesQuota)

SELECT * FROM [Sales].[SalesPersonQuotaHistory]
-- 88 Update the credit limit of customers based on their order history


-- 89 Update the shipping method for orders placed on a specific date range

SELECT POH.PurchaseOrderID,POH.ShipMethodID,POH.OrderDate 
FROM [Purchasing].[PurchaseOrderHeader] POH
JOIN [Purchasing].[ShipMethod] SM ON SM.ShipMethodID = POH.ShipMethodID
WHERE POH.OrderDate BETWEEN '2014-01-01' AND '2014-01-31'

UPDATE POH
SET POH.ShipMethodID = 3
FROM [Purchasing].[PurchaseOrderHeader] POH
JOIN [Purchasing].[ShipMethod] SM ON SM.ShipMethodID = POH.ShipMethodID
WHERE POH.OrderDate BETWEEN '2014-01-01' AND '2014-01-31'

-- 90 Update the product review rating based on customer feedback

UPDATE [Production].[ProductReview]
SET Rating = 4
WHERE ProductReviewID = 3

SELECT * FROM [Production].[ProductReview]

-- 91 Delete all products that have not been ordered in the past year

SELECT P.ProductID
FROM [Production].[Product] P
JOIN [Sales].[SalesOrderDetail] SOD ON P.ProductID = SOD.ProductID
JOIN [Sales].[SalesOrderHeader] SOH ON SOD.SalesOrderID = SOH.SalesOrderID AND SOH.OrderDate BETWEEN '2014-01-01' AND '2014-12-31'
WHERE SOD.SalesOrderID IS NULL
GROUP BY P.ProductID;

-- 92 Remove employees who have not made any sales in the last quarter

SELECT * FROM [Sales].[SalesPerson]

-- 93 Delete customers who have not placed any orders in the past six months *

SELECT C.CustomerID
FROM [Sales].[Customer] C
LEFT JOIN [Sales].[SalesOrderHeader] SOH ON C.CustomerID = SOH.CustomerID
AND SOH.OrderDate BETWEEN '2014-01-01' AND '2014-06-30'
WHERE SOH.SalesOrderID IS NULL
GROUP BY C.CustomerID

-- 94 Remove records from the SalesOrderDetail table for canceled orders


-- 95 Delete addresses associated with customers who no longer have active orders
-- 96 Retrieve top 5 orders with the highest total due amount, ordered by the order date

SELECT TOP 5 SalesOrderID, TotalDue, OrderDate
FROM [Sales].[SalesOrderHeader]
ORDER BY TotalDue DESC, OrderDate

-- 97 Get the top 10 products with the highest profit margins, ordered by the unit price


-- 98 Retrieve the 20 oldest customers, ordered by their registration date

SELECT TOP 20 CustomerID FROM [Sales].[Customer]
ORDER BY CustomerID

-- 99 Get the top 5 sales representatives with the highest total sales amount, ordered by their commission percentage

SELECT TOP 5 E.BusinessEntityID, SP.CommissionPct, SUM(SOH.TOTALDUE) AS 'Total Sales'
FROM [Sales].[SalesPerson] SP
JOIN [HumanResources].[Employee] E ON E.BusinessEntityID = SP.BusinessEntityID
JOIN [Sales].[SalesOrderHeader] SOH ON SOH.SalesPersonID = SP.BusinessEntityID
GROUP BY E.BusinessEntityID, SP.CommissionPct
ORDER BY SP.CommissionPct DESC

-- 100 Retrieve the top 3 product categories with the highest average list price, ordered by the average list price

SELECT TOP 3 SC.ProductCategoryID, PC.Name, AVG(P.ListPrice) 'Avg List pRICE'
FROM [Production].[ProductSubcategory] SC
JOIN [Production].[Product] P ON P.ProductSubcategoryID = SC.ProductSubcategoryID 
JOIN [Production].[ProductCategory] PC ON PC.ProductCategoryID = SC.ProductCategoryID
GROUP BY SC.ProductCategoryID, PC.Name
ORDER BY AVG(P.ListPrice) DESC

-- 101 Retrieve products with a stock quantity less than the average stock quantity for all products

SELECT PRODUCTID, StockedQty
FROM [Production].[WorkOrder]
WHERE StockedQty < (SELECT AVG(StockedQty) FROM [Production].[WorkOrder])

-- 102 Get orders where the total due amount exceeds the customer's credit limit


-- 103 Retrieve employees who have made sales exceeding a certain target amount(SALES QUOTA)

SELECT SP.BusinessEntityID,SUM(SOH.TotalDue) TotalSalesAmount
FROM [Sales].[SalesPerson] SP
JOIN [Sales].[SalesOrderHeader] SOH ON SP.BusinessEntityID = SOH.SalesPersonID
GROUP BY SP.BusinessEntityID
HAVING SUM(SOH.TotalDue) > 2500000

-- 104 Get customers who have placed orders in multiple product categories *

SELECT SOH.CustomerID
FROM [Sales].[SalesOrderHeader] SOH
JOIN [Sales].[SalesOrderDetail] SOD ON SOD.SalesOrderID = SOH.SalesOrderID
JOIN [Production].[Product] P ON P.ProductID = SOD.ProductID
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID
GROUP BY SOH.CustomerID
HAVING COUNT(DISTINCT C.ProductCategoryID) > 1

SELECT SOH.CustomerID, C.Name AS ProductCategoryName
FROM [Sales].[SalesOrderHeader] SOH
JOIN [Sales].[SalesOrderDetail] SOD ON SOD.SalesOrderID = SOH.SalesOrderID
JOIN [Production].[Product] P ON P.ProductID = SOD.ProductID
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID
WHERE C.ProductCategoryID IN (
    SELECT SC.ProductCategoryID 
    FROM [Production].[ProductSubcategory] SC
    GROUP BY SC.ProductCategoryID
    HAVING COUNT(DISTINCT SC.ProductCategoryID) > 1)

-- 105 Retrieve products that have been ordered by customers from a specific region

SELECT C.CustomerID FROM 
[Sales].[Customer] C
JOIN [Sales].[SalesOrderHeader] SOH ON SOH.CustomerID = C.CustomerID
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID

-- 106 Retrieve all products ordered by their list price in ascending order

SELECT * FROM [Production].[Product] ORDER BY ListPrice

-- 107 Get all employees ordered by their hire date in descending order

SELECT * FROM [HumanResources].[Employee] ORDER BY HireDate DESC

-- 108 List all orders ordered by their order date in ascending order

SELECT * FROM [Sales].[SalesOrderHeader] ORDER BY OrderDate 

-- 109 Retrieve all customers ordered by their last name in ascending order, then by their first name in ascending order

SELECT * FROM [Person].[Person] WHERE PERSONTYPE = 'IN' ORDER BY LastName, FirstName

-- 110 Get all products ordered by their product name in alphabetical order

SELECT * FROM [Production].[Product] ORDER BY Name

-- 111 Retrieve distinct product categories from the ProductCategory table

SELECT DISTINCT Name FROM [Production].[ProductCategory]

-- 112 Get distinct cities from the Address table

SELECT DISTINCT City FROM [Person].[Address]

-- 113 List distinct job titles from the Employee table

SELECT DISTINCT JobTitle FROM [HumanResources].[Employee]

-- 114 Retrieve distinct product colors from the Product table

SELECT DISTINCT Color FROM [Production].[Product]

-- 115 Get distinct payment methods from the SalesOrderHeader table

SELECT * FROM [Sales].[SalesOrderHeader]

-- 116 Retrieve the first name and last name of employees with an alias for each column

SELECT P.FirstName ForeName, P.LastName SurName
FROM [Person].[Person] P
JOIN [HumanResources].[Employee] E ON E.BusinessEntityID = P.BusinessEntityID

-- 117 Get the product name and list price with aliases "ProductName" and "Price", respectively

SELECT ProductID, NAME ProductName, ListPrice Price FROM [Production].[Product]

-- 118 List the category name and description with aliases "CategoryName" and "Description"

SELECT P.PRODUCTID, C.PRODUCTCATEGORYID,C.Name CategoryName, PD.Description DESCRIPTION
FROM PRODUCTION.PRODUCT P 
JOIN PRODUCTION.PRODUCTSUBCATEGORY S ON S.ProductSubcategoryID = P. ProductSubcategoryID
JOIN PRODUCTION.ProductCategory C ON S.ProductcategoryID = C.ProductCategoryID
JOIN Production.ProductModelProductDescriptionCulture D ON P.ProductModelID = D.ProductModelID
JOIN Production.ProductDescription PD ON D.ProductDescriptionID = PD.ProductDescriptionID 

-- 119 Retrieve the order date and total due amount with aliases "OrderDate" and "TotalAmount"

SELECT OrderDate OrderDate, TotalDue TotalAmount FROM [Sales].[SalesOrderHeader]

-- 120 Get the customer ID and company name with aliases "CustomerID" and "CompanyName"

-- 121 Create a new table "NewProducts" containing the product ID, name, and list price

SELECT PRODUCTID, NAME, LISTPRICE 
INTO NewProducts
FROM [Production].[Product]

SELECT * FROM NewProducts 

-- 122 Create a new table "HighValueOrders" containing orders with a total due amount greater than $1000

SELECT * INTO HighValueOrders
FROM [Sales].[SalesOrderHeader]
WHERE TotalDue > 1000

SELECT * FROM HighValueOrders

-- 123 Create a new table "ActiveCustomers" containing customers who have placed orders in the last 6 months

DECLARE @SIXMONTHSAGO DATETIME;
SELECT @SIXMONTHSAGO = DATEADD(MONTH, -6, MAX(OrderDate))
FROM [Sales].[SalesOrderHeader]

SELECT DISTINCT CustomerID
INTO ActiveCustomerS
FROM [Sales].[SalesOrderHeader]
WHERE OrderDate >= @SIXMONTHSAGO

SELECT * FROM ActiveCustomers

-- 124 Create a new table "EmployeesInfo" containing employee details such as first name, last name, and email


SELECT E.BusinessEntityID  EmployeeID, P.FirstName AS FirstName, P.LastName, EA.EmailAddress
INTO EmployeeInfo
FROM HumanResources.Employee E
JOIN Person.Person P ON P.BusinessEntityID = E.BusinessEntityID
JOIN Person.EmailAddress EA ON EA.BusinessEntityID = E.BusinessEntityID
 
SELECT * FROM EmployeeInfo

-- 125 Create a new table "ProductCategories" containing distinct product categories

SELECT DISTINCT ProductCategoryID, Name 
INTO ProductCategories
FROM [Production].[ProductCategory]

SELECT * FROM ProductCategories

-- 126 Retrieve all orders where the product ID is in a subquery that selects discontinued products

SELECT * FROM [Sales].[SalesOrderHeader] SOH
JOIN [Sales].[SalesOrderDetail] SOD ON SOH.SalesOrderID = SOD.SalesOrderID
WHERE SOD.ProductID IN 
(
SELECT ProductID FROM [Production].[Product]
WHERE DiscontinuedDate IS NOT NULL
)

-- 127 Get all customers who have placed orders in a subquery that selects orders placed in the last month

/*SELECT * FROM [Sales].[SalesOrderHeader]
WHERE OrderDate <
(
SELECT  DATEADD(MONTH,-1,MAX(ORDERDATE)) FROM [Sales].[SalesOrderHeader]
)*/

SELECT * FROM [Sales].[SalesOrderHeader]
WHERE CustomerID IN 
(
SELECT CustomerID, OrderDate
FROM [Sales].[SalesOrderHeader]
WHERE OrderDate >= DATEADD(MONTH, -1, (SELECT MAX(OrderDate) FROM [Sales].[SalesOrderHeader])))
AND  OrderDate < DATEADD(MONTH, 1, (SELECT MAX(OrderDate) FROM [Sales].[SalesOrderHeader])))

-- 128 List employees who have a higher salary than the average salary calculated from a subquery


-- 129 Retrieve products with a list price higher than the average list price of products in a specific category

SELECT P.ProductID,C.ProductCategoryID,P.Name, AVG(P.ListPrice) 
FROM [Production].[Product] P
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID

-- 130 Get orders with a total due amount higher than the maximum total due amount calculated from a subquery

SELECT * FROM [Sales].[SalesOrderHeader]
WHERE TotalDue >
(SELECT AVG(TotalDue)
FROM [Sales].[SalesOrderHeader])

-- 131 Group products by their color and count the number of products in each color category

SELECT Color, COUNT(*) NumberOfProducts
FROM [Production].[Product]
GROUP BY Color

-- 132 Group orders by their order date and count the number of orders placed on each date

SELECT OrderDate, COUNT(*) NumberOfOrders
FROM [Sales].[SalesOrderHeader]
GROUP BY OrderDate

-- 133 Group employees by their job title and count the number of employees in each job title category

SELECT JobTitle, COUNT(*) NumberOfEmployees 
FROM [HumanResources].[Employee]
GROUP BY JobTitle

-- 134 Group customers by their country and count the number of customers in each country *

SELECT TT.TerritoryID, SST.NAME, TT.[Number Of Customers]
FROM	 
(SELECT SC.TerritoryID,COUNT(SC.CustomerID) AS 'Number Of Customers'
FROM Sales.Customer AS SC
JOIN Sales.SalesTerritory AS SST ON SST.TerritoryID = SC.TerritoryID
GROUP BY SC.TerritoryID) AS TT
JOIN Sales.SalesTerritory AS SST ON TT.TerritoryID = SST.TerritoryID

-- 135 Group products by their weight and calculate the average list price for each weight category

SELECT Weight, AVG(ListPrice)  AverageListPrice
FROM [Production].[Product]
GROUP BY Weight

-- 136 Retrieve product categories with more than 10 products

SELECT C.ProductCategoryID, C.Name CategoryName, COUNT(P.ProductID) ProductCount
FROM [Production].[ProductCategory] C
JOIN [Production].[ProductSubcategory] SC ON C.ProductCategoryID = SC.ProductCategoryID
JOIN [Production].[Product] P ON SC.ProductSubcategoryID = P.ProductSubcategoryID
GROUP BY C.ProductCategoryID, C.Name
HAVING COUNT(P.ProductID) > 10

-- 137 Get orders with a total due amount greater than $1000

SELECT * FROM [Sales].[SalesOrderHeader]
WHERE TotalDue > 1000

-- 138 List customers who have placed more than 5 orders

SELECT SOH.CustomerID, COUNT(*) Orders
FROM [Sales].[SalesOrderHeader] SOH
GROUP BY SOH.CustomerID
HAVING COUNT(*) > 5

-- 139 Retrieve employees with a commission percentage higher than 15%

SELECT * FROM [Sales].[SalesPerson]
WHERE CommissionPct > 0.15

-- 140 Get product categories with an average list price higher than $500

SELECT C.ProductCategoryID, C.Name  ProductCategoryName, AVG(P.ListPrice) AverageListPrice
FROM [Production].[ProductCategory] C
JOIN [Production].[ProductSubcategory] SC ON C.ProductCategoryID = SC.ProductCategoryID
JOIN [Production].[Product] P ON SC.ProductSubcategoryID = P.ProductSubcategoryID
GROUP BY C.ProductCategoryID, C.Name
HAVING AVG(P.ListPrice) < 500

-- 141 Retrieve the top 10 highest-priced products

SELECT TOP 10 ProductID, Name, ListPrice
FROM [Production].[Product]
ORDER BY ListPrice DESC

-- 142 Get the top 5 orders with the highest total due amount

SELECT TOP 5 SalesOrderID, TotalDue
FROM [Sales].[SalesOrderHeader]
ORDER BY TotalDue DESC

-- 143 List the top 3 customers with the most orders

SELECT TOP 3 CustomerID, COUNT(SalesOrderID)  TotalOrders
FROM [Sales].[SalesOrderHeader]
GROUP BY CustomerID
ORDER BY TotalOrders DESC

-- 144 Retrieve the top 5 employees with the highest sales amount

SELECT TOP 5 SP.BusinessEntityID,SP.SalesYTD
FROM Sales.SalesPerson SP
JOIN HumanResources.Employee E ON SP.BusinessEntityID = E.BusinessEntityID
ORDER BY SP.SalesYTD DESC

-- 145 Get the top 5 product categories with the highest number of products

SELECT TOP 5 C.ProductCategoryID, C.Name, COUNT(P.ProductID) NumberOfProducts
FROM Production.Product P
JOIN Production.ProductSubcategory SC ON P.ProductSubcategoryID = SC.ProductSubcategoryID
JOIN Production.ProductCategory C ON SC.ProductCategoryID = C.ProductCategoryID
GROUP BY C.ProductCategoryID, C.Name
ORDER BY COUNT(P.ProductID) DESC

-- 146 Retrieve the list of products sorted by their list price in descending order

SELECT * FROM [Production].[Product] ORDER BY ListPrice DESC

-- 147 Get the employee list ordered by their hire date in ascending order

SELECT * FROM [HumanResources].[Employee] ORDER BY HireDate ASC

-- 148 Retrieve orders sorted by their total due amount in descending order

SELECT * FROM [Sales].[SalesOrderHeader] ORDER BY TotalDue DESC

-- 149 Get the list of customers ordered alphabetically by their last name, then first name (109)

SELECT * FROM [Person].[Person] WHERE PERSONTYPE = 'IN' ORDER BY LastName, FirstName

-- 150 Retrieve product categories ordered by their category ID in ascending order

SELECT * FROM [Production].[ProductCategory] 
ORDER BY ProductCategoryID 

-- 151 Retrieve the distinct list of product colors available (114)

SELECT DISTINCT Color FROM [Production].[Product]

-- 152 Get the distinct list of job titles held by employees (113)

SELECT DISTINCT JobTitle FROM [HumanResources].[Employee]

-- 153 Retrieve the distinct list of territories associated with customers

SELECT ST.TerritoryID,ST.Name, COUNT (C.CustomerID) 'No Of Customers' FROM [Sales].[Customer] C
JOIN [Sales].[SalesTerritory] ST ON ST.TerritoryID = C.TerritoryID
GROUP BY ST.TerritoryID,ST.Name

-- 154 Get the distinct list of cities where customers are located 

SELECT  A.CITY, COUNT(C.CUSTOMERID) Customers
FROM SALES.CUSTOMER C
JOIN SALES.SALESORDERHEADER H ON H.CUSTOMERID = C.CUSTOMERID
JOIN PERSON.ADDRESS A ON H.BILLTOADDRESSID=A.ADDRESSID
GROUP BY A.CITY

-- 155 Retrieve the distinct list of payment methods used in orders

-- 156 Retrieve the employee ID and their full name (concatenating first and last name) as "Employee Name"

SELECT P.BUSINESSENTITYID, CONCAT(P.FirstName, P.LastName) 'Employee Name' 
FROM [Person].[Person] P
JOIN [HumanResources].[Employee] E ON E.BusinessEntityID =  P.BusinessEntityID 

-- 157 Get the product ID and their list price as "Price" for all products

SELECT ProductID, ListPrice Price FROM [Production].[Product]

-- 158 Retrieve the order date and total due amount as "Total Amount" for all orders

SELECT OrderDate, TotalDue 'Total Amount' FROM [Purchasing].[PurchaseOrderHeader]

-- 159 Get the customer ID and their company name as "Customer" for all customers

-- 160 Retrieve the product category ID and name as "Category" for all categories

SELECT ProductCategoryID, Name Category FROM [Production].[ProductCategory]

-- 161 Create a new table "HighValueOrders" containing orders with a total due amount greater than $1000 (122)

SELECT * INTO HighValueOrders
FROM [Sales].[SalesOrderHeader]
WHERE TotalDue > 1000;

SELECT * FROM HighValueOrders

-- 162 Create a new table "NewEmployees" containing employees hired in the current year

DECLARE @CURRENTYEAR DATETIME
SELECT @CURRENTYEAR = YEAR(MAX(HIREDATE))
FROM [HumanResources].[Employee]

SELECT * INTO NewEmployees
FROM [HumanResources].[Employee]
WHERE YEAR(HireDate) = @CURRENTYEAR

SELECT * FROM NewEmployees

-- 163 Create a new table "ActiveCustomers" containing customers who have placed orders in the last 6 months(123)

DECLARE @SIXMONTHSAGO DATETIME
SELECT @SIXMONTHSAGO = DATEADD(MONTH, -6, MAX(OrderDate))
FROM [Sales].[SalesOrderHeader]

SELECT DISTINCT CustomerID
INTO ActiveCustomerS
FROM [Sales].[SalesOrderHeader]
WHERE OrderDate >= @SIXMONTHSAGO

SELECT * FROM ActiveCustomers

-- 164 Create a new table "PopularProducts" containing products with more than 100 orders

SELECT ProductID,COUNT(SalesOrderID) 'No Of Orders' FROM [Sales].[SalesOrderDetail]
GROUP BY ProductID
HAVING COUNT(SalesOrderID) > 100
ORDER BY 'No Of Orders' 

SELECT ProductID, COUNT(SalesOrderID) 'No Of Orders'
INTO PopularProducts
FROM [Sales].[SalesOrderDetail]
GROUP BY ProductID
HAVING COUNT(SalesOrderID) > 100

SELECT * FROM PopularProducts

-- 165 Create a new table "ProductCategories" containing distinct product categories (125)

SELECT DISTINCT ProductCategoryID, Name 
INTO ProductCategories
FROM [Production].[ProductCategory]

SELECT * FROM ProductCategories

-- 166 Retrieve the list of products with a price higher than the average price of all products

SELECT ProductID, Name, ListPrice
FROM [Production].[Product]
WHERE ListPrice > (SELECT AVG(ListPrice) FROM [Production].[Product])

-- 167 Get the list of employees whose sales exceed the average sales of all employees

SELECT * FROM [Sales].[SalesPerson]
WHERE SalesYTD > (SELECT AVG(SalesYTD) FROM [Sales].[SalesPerson]) 

-- 168 Retrieve orders where the total due amount is greater than the average order total

SELECT * FROM [Sales].[SalesOrderHeader]
WHERE TotalDue > (SELECT AVG(TotalDue) FROM [Sales].[SalesOrderHeader])

-- 169 Get customers who have placed orders in territories with more than 10 customers

SELECT SalesPersonID, COUNT(CustomerID) 'No Of Customers' , TerritoryID FROM [Sales].[SalesOrderHeader]
GROUP BY TerritoryID,SalesPersonID
HAVING COUNT(CustomerID) > 10

-- 170 Retrieve products from categories with at least one discontinued product

SELECT * FROM [Production].[Product] WHERE DiscontinuedDate IS NOT NULL

-- 171 Get the count of orders placed by each customer

SELECT CustomerID, COUNT (SalesOrderID) 'No Of Orders' FROM [Sales].[SalesOrderHeader]
GROUP BY CustomerID

-- 172 Retrieve the total sales amount for each product

SELECT DISTINCT ProductID, SUM(LineTotal) TotalSales FROM [Sales].[SalesOrderDetail]
GROUP BY ProductID
ORDER BY ProductID

-- 173 Get the average list price for each product category

SELECT C.ProductCategoryID, C.Name ProductCategoryName, AVG(P.ListPrice) AverageListPrice
FROM [Production].[Product] P
INNER JOIN [Production].[ProductSubcategory] SC ON P.ProductSubcategoryID = SC.ProductSubcategoryID
INNER JOIN [Production].[ProductCategory] C ON SC.ProductCategoryID = C.ProductCategoryID
GROUP BY C.ProductCategoryID, C.Name

-- 174 Retrieve the total number of employees in each department

SELECT DISTINCT D.DepartmentID, D.Name, COUNT(E.BusinessEntityID) 'No Of Employees'
FROM [HumanResources].[Employee] E
JOIN [HumanResources].[EmployeeDepartmentHistory] EDH ON EDH.BusinessEntityID = E.BusinessEntityID
JOIN [HumanResources].[Department] D ON D.DepartmentID = EDH.DepartmentID
GROUP BY D.DepartmentID, D.Name

-- 175 Get the total sales amount for each year

SELECT YEAR(ORDERDATE) Year , SUM(TOTALDUE) 'Total Sales' 
FROM [Sales].[SalesOrderHeader]
GROUP BY YEAR(ORDERDATE)

-- 176 Retrieve product categories with an average list price greater than $500 (140)

SELECT C.ProductCategoryID, C.Name  ProductCategoryName, AVG(P.ListPrice) AverageListPrice
FROM [Production].[ProductCategory] C
JOIN [Production].[ProductSubcategory] SC ON C.ProductCategoryID = SC.ProductCategoryID
JOIN [Production].[Product] P ON SC.ProductSubcategoryID = P.ProductSubcategoryID
GROUP BY C.ProductCategoryID, C.Name
HAVING AVG(P.ListPrice) < 500

-- 177 Get employees with a total sales amount greater than $10000

SELECT BusinessEntityID FROM [Sales].[SalesPerson]
WHERE SalesYTD > 10000

-- 178 Retrieve territories with more than 20 customers

SELECT DISTINCT TerritoryID, COUNT(CustomerID) Customers FROM [Sales].[SalesOrderHeader]
GROUP BY TerritoryID
ORDER BY COUNT(CustomerID)

-- 179 Get product categories with more than 10 products

SELECT TOP 5 C.ProductCategoryID, C.Name, COUNT(P.ProductID) NumberOfProducts
FROM Production.Product P
JOIN Production.ProductSubcategory SC ON P.ProductSubcategoryID = SC.ProductSubcategoryID
JOIN Production.ProductCategory C ON SC.ProductCategoryID = C.ProductCategoryID
GROUP BY C.ProductCategoryID, C.Name
ORDER BY COUNT(P.ProductID) DESC

-- 180 Retrieve orders with a total due amount greater than $2000

SELECT * FROM [Sales].[SalesOrderHeader] WHERE TotalDue > 2000

-- 181 Retrieve the top 10 highest priced products

SELECT TOP 10 ListPrice, ProductID FROM [Production].[Product]
ORDER BY ListPrice DESC

-- 182 Get the top 5 customers with the highest total order amounts

SELECT TOP 5 (CustomerID),SUM(TotalDue) 'Total Order Amount'
FROM [Sales].[SalesOrderHeader]
GROUP BY CustomerID
ORDER BY 'Total Order Amount' DESC

-- 183 Retrieve the top 3 employees with the highest sales

SELECT TOP 3 SP.BusinessEntityID,SP.SalesYTD
FROM Sales.SalesPerson SP
JOIN HumanResources.Employee E ON SP.BusinessEntityID = E.BusinessEntityID
ORDER BY SP.SalesYTD DESC

-- 184 Get the top 5 product categories with the highest number of products (145)

SELECT TOP 5 C.ProductCategoryID, C.Name, COUNT(P.ProductID) NumberOfProducts
FROM Production.Product P
JOIN Production.ProductSubcategory SC ON P.ProductSubcategoryID = SC.ProductSubcategoryID
JOIN Production.ProductCategory C ON SC.ProductCategoryID = C.ProductCategoryID
GROUP BY C.ProductCategoryID, C.Name
ORDER BY COUNT(P.ProductID) DESC

-- 185 Retrieve the top 10 orders with the highest total due amount

SELECT TOP 10 SalesOrderID, TotalDue
FROM [Sales].[SalesOrderHeader]
ORDER BY TotalDue DESC

-- 186 Retrieve the top 5 customers with the highest average order total, ordered by the average order total in descending order

SELECT TOP 5 CustomerID, AVG(TOTALDUE) 'Highest Average Order Total' FROM [Sales].[SalesOrderHeader]
GROUP BY CustomerID
ORDER BY AVG(TOTALDUE) DESC

-- 187 Get the list of products sorted by the total number of units sold in descending order

SELECT P.ProductID, P.Name AS ProductName, COUNT(SOD.OrderQty) TotalUnitsSold
FROM [Production].[Product] P
JOIN [Sales].[SalesOrderDetail] SOD ON P.ProductID = SOD.ProductID
GROUP BY P.ProductID, P.Name
ORDER BY TotalUnitsSold DESC
 
-- 188 Retrieve the list of employees sorted by their total sales amount in descending order

SELECT BusinessEntityID, SalesYTD, SalesLastYear, SalesQuota
FROM Sales.SalesPerson
ORDER BY SalesYTD DESC

-- 189 Get the list of orders sorted by the difference between the order date and ship date in ascending order

SELECT SalesOrderID,OrderDate,ShipDate,DATEDIFF(day, OrderDate, ShipDate) DaysDifference
FROM[Sales].[SalesOrderHeader]
ORDER BY DaysDifference ASC

-- 190 Retrieve the list of customers sorted by the total number of orders they've placed, with customers who have placed the same number of orders ordered alphabetically by their last name

SELECT C.CustomerID,P.LastName,P.FirstName,COUNT(SOH.SalesOrderID) TotalOrders
FROM [Sales].[Customer] C
JOIN [Person].[Person] P ON C.PersonID = P.BusinessEntityID
JOIN [Sales].[SalesOrderHeader] SOH ON C.CustomerID = SOH.CustomerID
GROUP BY C.CustomerID,P.LastName,P.FirstName
ORDER BY TotalOrders DESC,P.LastName ASC

-- 191 Retrieve the distinct list of product colors available in each product category

SELECT DISTINCT Color FROM [Production].[Product]

-- 192 Get the distinct list of payment methods used by customers who have placed orders in the last month

-- 193 Retrieve the distinct list of territories associated with customers who have placed orders for products with a list price greater than $1000

SELECT DISTINCT SOH.TerritoryID,COUNT (C.CustomerID) 'No Of Customers'
FROM [Sales].[SalesOrderHeader] SOH
JOIN [Sales].[SalesOrderDetail] SOD ON SOD.SalesOrderID = SOH.SalesOrderID
JOIN [Production].[Product] P ON P.ProductID = SOD.ProductID
JOIN [Sales].[Customer] C ON C.CustomerID = SOH.CustomerID
JOIN [Sales].[SalesTerritory] ST ON ST.TerritoryID = SOH.TerritoryID
WHERE P.ListPrice > 1000
GROUP BY SOH.TerritoryID
ORDER BY SOH.TerritoryID

-- 194 Get the distinct list of cities where customers are located, along with the total number of customers in each city

SELECT DISTINCT A.City, COUNT (C.CustomerID) 'No Of Customers' FROM [Sales].[Customer] C
JOIN [Sales].[SalesOrderHeader] SOH ON SOH.CustomerID =  C.CustomerID
JOIN [Person].[Address] A ON A.AddressID = SOH.BillToAddressID
GROUP BY A.City

-- 195 Retrieve the distinct list of product categories along with the total number of products and the average list price for each category

SELECT DISTINCT C.ProductCategoryID, COUNT(P.PRODUCTID) 'No Of Products' 
FROM [Production].[Product] P
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID
GROUP BY C.ProductCategoryID

-- 196 Retrieve the product ID, name, and total number of units sold as "UnitsSold" for each product

SELECT P.ProductID,P.Name, COUNT(SOD.OrderQty) UnitsSold
FROM [Production].[Product] P
JOIN [Sales].[SalesOrderDetail] SOD ON SOD.ProductID = P.ProductID
GROUP BY P.ProductID,P.Name

-- 197 Get the employee ID, first name, last name, and total sales amount as "TotalSales" for each employee

SELECT P.BusinessEntityID, P.FirstName, P.LastName, SP.SalesYTD TotalSales   
FROM [Person].[Person] P
JOIN [Sales].[SalesPerson] SP ON SP.BusinessEntityID = P.BusinessEntityID

-- 198 Retrieve the order ID, order date, and total due amount as "OrderTotal" for each order

SELECT SalesOrderID, OrderDate, TotalDue OrderTotal FROM [Sales].[SalesOrderHeader]

-- 199 Get the customer ID, company name, and total number of orders placed as "OrderCount" for each customer

SELECT CustomerID, COUNT(SalesOrderID) OrderCount FROM [Sales].[SalesOrderHeader]
GROUP BY CustomerID

-- 200 Retrieve the product category ID, name, and total number of products as "ProductCount" for each category

SELECT C.ProductCategoryID, C.Name, COUNT (P.ProductID) ProductCount
FROM [Production].[Product] P
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P. ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID
GROUP BY C.ProductCategoryID,C.Name

-- 201 Create a new table "HighValueCustomers" containing customers who have placed orders with a total due amount greater than the average total due amount

SELECT * INTO HighValueCustomers
FROM [Sales].[SalesOrderHeader]
WHERE TotalDue > (SELECT AVG(TotalDue) FROM [Sales].[SalesOrderHeader])

SELECT * FROM HighValueCustomers 

-- 202 Create a new table "NewProductSales" containing products sold within the last month, along with their sales details

DECLARE @LASTMONTH DATETIME
SELECT @LASTMONTH = DATEADD(MONTH,-1,MAX(OrderDate))
FROM [Sales].[SalesOrderHeader]

SELECT * INTO NewProductSales
FROM [Sales].[SalesOrderHeader]
WHERE @LASTMONTH < OrderDate

SELECT * FROM NewProductSales

-- 203 Create a new table "TopEmployees" containing the top 10 employees with the highest total sales amount

SELECT * INTO TopEmployees
FROM [Sales].[SalesPerson]
WHERE SalesYTD IN
(SELECT TOP 10 SalesYTD FROM [Sales].[SalesPerson])

SELECT * FROM TopEmployees

-- 204 Create a new table "PopularCategories" containing product categories with more than 100 units sold

SELECT * INTO PopularCategories
FROM [Sales].[SalesOrderDetail]
WHERE OrderQty IN
(SELECT COUNT(OrderQty) FROM [Sales].[SalesOrderDetail]
WHERE COUNT(OrderQty) >100)

DROP TABLE PopularCategories
SELECT * FROM [Sales].[SalesOrderDetail]
SELECT SUM(ORDERQTY) FROM [Sales].[SalesOrderDetail]

-- 205 Create a new table "HighValueOrders" containing orders with a total due amount greater than $5000

SELECT * INTO HighValueOrders2
FROM [Sales].[SalesOrderHeader]
WHERE TotalDue > 5000

SELECT * FROM HighValueOrders2

-- 206 Retrieve the list of products with a price higher than the average price of products in their respective categories

SELECT C.ProductCategoryID,P.ProductID, C.Name ProductCategoryName, P.ListPrice 
FROM [Production].[ProductCategory] C
JOIN [Production].[ProductSubcategory] SC ON C.ProductCategoryID = SC.ProductCategoryID
JOIN [Production].[Product] P ON SC.ProductSubcategoryID = P.ProductSubcategoryID
WHERE P.ListPrice > (SELECT AVG(ListPrice) FROM [Production].[Product])

-- 207 Get the list of employees whose total sales amount exceeds the average total sales amount of employees in their respective departments

SELECT SP.BusinessEntityID,D.Name, SP.SalesYTD
FROM [Sales].[SalesPerson] SP
JOIN [HumanResources].[EmployeeDepartmentHistory] EDH ON EDH.BusinessEntityID = SP.BusinessEntityID
JOIN [HumanResources].[Department] D ON D.DepartmentID =EDH.DepartmentID
WHERE SP.SalesYTD >
(SELECT AVG(SP.SalesYTD) FROM [Sales].[SalesPerson] SP)
 
-- 208 Retrieve orders where the total due amount is greater than the average total due amount of orders placed by customers in their respective territories

SELECT TerritoryID, CustomerID, SUM(Totaldue) TotalDue 
FROM [Sales].[SalesOrderHeader] SOH
GROUP BY TerritoryID, CustomerID 
HAVING SUM(Totaldue) >
(SELECT AVG(Totaldue)  
FROM [Sales].[SalesOrderHeader] 
WHERE TerritoryID = SOH.TerritoryID AND CustomerID = SOH.CustomerID)

-- 209 Get customers who have placed orders in territories where the total number of customers exceeds the average number of customers across all territories

SELECT * FROM [Sales].[Customer]
SELECT * FROM [Sales].[SalesOrderHeader]
-- 210 Retrieve products from categories where the average list price is greater than the average list price of all categories

SELECT C.ProductCategoryID, C.Name,P.Name, P.ListPrice
FROM [Production].[ProductCategory] C
JOIN [Production].[ProductSubcategory] SC ON SC.ProductCategoryID = C.ProductCategoryID
JOIN [Production].[Product] P ON P.ProductSubcategoryID = SC.ProductSubcategoryID
WHERE P.ListPrice >
(SELECT AVG(ListPrice) FROM [Production].[Product])

-- 211 Get the total sales amount for each product category, along with the number of products in each category

SELECT SOD.ProductID,SUM(SOH.TOTALDUE) SalesAmount , COUNT(SOD.ORDERQTY) NoOfProducts
FROM [Sales].[SalesOrderDetail] SOD
JOIN [Sales].[SalesOrderHeader] SOH ON SOH.SalesOrderID = SOD.SalesOrderID
JOIN [Production].[Product] P ON P.ProductID = SOD.ProductID
GROUP BY SOD.ProductID

SELECT C.ProductCategoryID, sum(P.ListPrice), count('p.productid')
FROM [Production].[ProductCategory] C
JOIN [Production].[ProductSubcategory] SC ON SC.ProductCategoryID = C.ProductCategoryID
JOIN [Production].[Product] P ON P.ProductSubcategoryID = SC.ProductSubcategoryID
group by C.ProductCategoryID

-- 212 Retrieve the total number of orders placed by each customer in each year

SELECT YEAR(ORDERDATE) Year, COUNT(SalesOrderID) 'Total Order', CustomerID
FROM [Sales].[SalesOrderHeader]
GROUP BY YEAR(ORDERDATE), CustomerID

-- 213 Get the total sales amount for each employee in each year

SELECT YEAR(SOH.OrderDate) OrderYear,E.BusinessEntityID EmployeeID,SUM(SOD.LineTotal) TotalSalesAmount
FROM [Sales].[SalesOrderHeader] SOH
JOIN [Sales].[SalesOrderDetail] SOD ON SOH.SalesOrderID = SOD.SalesOrderID
JOIN [HumanResources].[Employee] E ON SOH.SalesPersonID = E.BusinessEntityID
GROUP BY YEAR(SOH.OrderDate),E.BusinessEntityID
ORDER BY YEAR(SOH.OrderDate)

-- 214 Retrieve the total number of products sold in each territory

SELECT SOH.TerritoryID, COUNT(SOD.SalesOrderID) 'Number Of Products Sold'
FROM [Sales].[SalesOrderHeader] SOH 
JOIN [Sales].[SalesOrderDetail] SOD ON SOD.SalesOrderID = SOH.SalesOrderID
GROUP BY SOH.TerritoryID
ORDER BY SOH.TerritoryID

-- 215 Get the total sales amount for each month of the year

SELECT YEAR(ORDERDATE) Year, MONTH(ORDERDATE) Month, SUM(TOTALDUE) 'Total Sales' 
FROM [Sales].[SalesOrderHeader]
GROUP BY MONTH(ORDERDATE), YEAR(ORDERDATE) 
ORDER BY YEAR(ORDERDATE),MONTH(ORDERDATE)

-- 216 Retrieve product categories with an average list price greater than the average list price of all categories and with at least 10 products

SELECT C.ProductCategoryID, C.Name ProductCategoryName, AVG(P.ListPrice) AverageListPrice,COUNT(P.ProductID) ProductCount
FROM [Production].[ProductCategory] C
JOIN [Production].[ProductSubcategory] SC ON C.ProductCategoryID = SC.ProductCategoryID
JOIN [Production].[Product] P ON SC.ProductSubcategoryID = P.ProductSubcategoryID
GROUP BY C.ProductCategoryID, C.Name
HAVING AVG(P.ListPrice) > (SELECT AVG(ListPrice) FROM [Production].[Product])
AND COUNT(P.ProductID) >= 10
 
-- 217 Get employees with a total sales amount greater than $50000 and who have made sales to at least 10 different customers

SELECT SP.BusinessEntityID, SP.SalesYTD, COUNT(DISTINCT SOH.CustomerID) NoOfCustomers 
FROM Sales.SalesPerson SP
JOIN Sales.SalesOrderHeader SOH ON SOH.SalesPersonID = SP.BusinessEntityID
GROUP BY SP.BusinessEntityID,SP.SalesYTD 
HAVING SP.SalesYTD > 50000
AND COUNT(DISTINCT SOH.CustomerID) >= 10 

-- 218 Retrieve territories with more than 5 customers and with a total sales amount greater than $100000

SELECT ST.TerritoryID, COUNT(DISTINCT C.CustomerID) Customers, SUM(SOH.TotalDue) TotalSalesAmount
FROM [Sales].[SalesOrderHeader] SOH
JOIN [Sales].[SalesTerritory] ST ON SOH.TerritoryID = ST.TerritoryID
JOIN [Sales].[Customer] C ON SOH.CustomerID = C.CustomerID
GROUP BY ST.TerritoryID
HAVING COUNT(DISTINCT C.CustomerID) > 5
AND SUM(SOH.TotalDue) > 100000

-- 219 Get product categories with an average list price greater than $500 and with at least 20 units sold

SELECT C.ProductCategoryID, C.Name ProductCategoryName, AVG(P.ListPrice) AverageListPrice,SUM(SOD.OrderQty) ProductCount
FROM [Production].[ProductCategory] C
JOIN [Production].[ProductSubcategory] SC ON C.ProductCategoryID = SC.ProductCategoryID
JOIN [Production].[Product] P ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Sales].[SalesOrderDetail] SOD ON SOD.ProductID = P.ProductID
GROUP BY C.ProductCategoryID, C.Name
HAVING AVG (P.ListPrice) > 500
AND SUM (SOD.OrderQty) >= 20  

-- 220 Retrieve orders with a total due amount greater than $5000 and with at least 3 different products

SELECT SOH.SalesOrderID, SOH.TotalDue, COUNT(DISTINCT SOD.ProductID) AS ProductCount
FROM[Sales].[SalesOrderHeader] SOH
JOIN[Sales].[SalesOrderDetail] SOD ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.SalesOrderID,SOH.TotalDue
HAVING SOH.TotalDue > 5000 
AND COUNT(DISTINCT SOD.ProductID) >= 3

SELECT SOH.SalesOrderID, SOH.TotalDue, COUNT(DISTINCT SOD.ProductID) AS ProductCount
FROM [Sales].[SalesOrderHeader] SOH
JOIN [Sales].[SalesOrderDetail] SOD ON SOH.SalesOrderID = SOD.SalesOrderID
WHERE SOH.SalesOrderID = 43662
GROUP BY SOH.SalesOrderID, SOH.TotalDue
HAVING SOH.TotalDue > 5000 AND COUNT(DISTINCT SOD.ProductID) >= 3;


-- 221 Retrieve the top 5 customers with the highest total order amounts, excluding customers who have placed less than 3 orders

SELECT TOP 5 SOD.CustomerID, SUM(SOD.TotalDue) TotalOrderAmount
FROM [Sales].[SalesOrderHeader] SOD
JOIN [Sales].[SalesOrderDetail] SOH ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOD.CustomerID
HAVING COUNT (SOH.SalesOrderID) > 3
ORDER BY SUM(SOD.TotalDue) DESC

-- 222 Get the top 10 products with the highest profit margins, calculated as the difference between the list price and the standard cost, excluding products with a profit margin less than $50

SELECT TOP 10 PRODUCTID, (ListPrice - StandardCost) 'Highest Profit Margins' FROM [Production].[Product]
WHERE (ListPrice - StandardCost) > 50
ORDER BY (ListPrice - StandardCost) DESC

-- 223 Retrieve the top 3 employees with the highest average sales amount per order, excluding employees with less than 10 orders

SELECT TOP 3 SalesPersonID, AVG(TotalDue)  AvgSalesAmountPerOrder, COUNT(SalesOrderID) OrderCount
FROM Sales.SalesOrderHeader  GROUP BY SalesPersonID
HAVING COUNT(SalesOrderID) >= 10
ORDER BY AvgSalesAmountPerOrder DESC

-- 224 Get the top 5 product categories with the highest average list price, excluding categories with less than 10 products

SELECT TOP 5 C.ProductCategoryID, AVG(P.LISTPRICE) AvgListPrice, count(P.ProductID) ProductCount
FROM [Production].[Product] P
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID
GROUP BY C.ProductCategoryID
HAVING COUNT(P.PRODUCTID) > 10
ORDER BY AVG(P.LISTPRICE) DESC

-- 225 Retrieve the top 10 orders with the highest total due amount, excluding orders with less than 5 products *

SELECT * FROM [Sales].[SalesOrderHeader] SOH
JOIN  [Sales].[SalesOrderDetail] SOD ON SOD.SalesOrderID =SOH.SalesOrderID

-- 226 Retrieve the first and last names of employees along with their corresponding job titles.

SELECT P.FirstName, P.LastName, E.JobTitle
FROM [Person].[Person] P
JOIN [HumanResources].[Employee] E ON E.BusinessEntityID =P.BusinessEntityID

-- 227 Get the list of products along with their corresponding product categories, including products without a category.

SELECT C.ProductCategoryID,P.Name FROM [Production].[Product] P
LEFT JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID

-- 228 Retrieve the list of product categories along with the names of products belonging to each category, including categories without any products.

SELECT C.ProductCategoryID, C.Name, SC.Name FROM [Production].[ProductSubcategory] SC
LEFT JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID

-- 229 Retrieve a list of customers and orders, including customers who haven't placed any orders and orders without associated customers.

SELECT * FROM [Sales].[Customer] C
FULL JOIN [Sales].[SalesOrderHeader] SOH ON C.CustomerID = SOH.CustomerID

SELECT * FROM Sales.Customer
SELECT * FROM Sales.SalesOrderHeader

-- 230 Generate a Cartesian product of product categories and territories, showing all possible combinations.

SELECT * FROM [Production].[ProductCategory], [Sales].[SalesTerritory]

-- 231 Retrieve the names of employees along with the names of their managers.

-- 232 Retrieve the list of products and their corresponding product descriptions.

SELECT P.PRODUCTID, C.PRODUCTCATEGORYID,C.Name, SC.Name, PD.Description 
FROM PRODUCTION.PRODUCT P 
JOIN PRODUCTION.PRODUCTSUBCATEGORY SC ON SC.ProductSubcategoryID = P. ProductSubcategoryID
JOIN PRODUCTION.ProductCategory C ON SC.ProductcategoryID = C.ProductCategoryID
JOIN Production.ProductModelProductDescriptionCulture D ON P.ProductModelID = D.ProductModelID
JOIN Production.ProductDescription PD ON D.ProductDescriptionID = PD.ProductDescriptionID 

-- 233 Retrieve the list of orders along with the names of customers who placed those orders, matching on both customer ID and territory ID.

SELECT SOH.SalesOrderID,SOH.CustomerID,CONCAT(P.FirstName,P.LastName) CustomerName,C.TerritoryID
FROM [Sales].[SalesOrderHeader] SOH
JOIN [Person].[Person] P ON P.BusinessEntityID = SOH.CustomerID
JOIN [Sales].[Customer] C ON C.CustomerID =  SOH.CustomerID

-- 234 Get the total sales amount for each product, joining the SalesOrderDetail table with the Product table.

SELECT SOD.SalesOrderID, P.ProductID, P.Name, SOD.LineTotal 
FROM [Sales].[SalesOrderDetail] SOD
JOIN [Production].[Product] P ON P.ProductID = SOD.ProductID

-- 235 Retrieve the list of employees who have sold products with a price higher than the average price of all products.

SELECT DISTINCT E.BusinessEntityID
FROM [HumanResources].[Employee] E
JOIN [Sales].[SalesOrderHeader] SOH ON E.BusinessEntityID = SOH.SalesPersonID
JOIN [Sales].[SalesOrderDetail] SOD ON SOH.SalesOrderID = SOD.SalesOrderID
JOIN [Production].[Product] P ON SOD.ProductID = P.ProductID
WHERE P.ListPrice > (SELECT AVG(ListPrice) FROM [Production].[Product])

-- 236 Retrieve the product name and list price along with the product category name for each product.

SELECT C.ProductCategoryID,P.Name ProductName, P.ListPrice Price, P.Color ProductColor 
FROM [Production].[Product] P
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID

-- 237 Get the list of employees along with their corresponding departments, including employees who are not assigned to any department.

SELECT E.BusinessEntityID,D.DepartmentID 
FROM [HumanResources].[Employee] E
JOIN [HumanResources].[EmployeeDepartmentHistory] EDH ON EDH.BusinessEntityID = E.BusinessEntityID
JOIN [HumanResources].[Department] D ON D.DepartmentID = EDH.DepartmentID

-- 238 Retrieve the list of product categories along with the names of products belonging to each category, including categories without any products.

SELECT C.ProductCategoryID, C.Name, SC.Name FROM [Production].[ProductSubcategory] SC
LEFT JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID

-- 239 Retrieve a list of customers and orders, including customers who haven't placed any orders and orders without associated customers. (229)

SELECT * FROM [Sales].[Customer] C
FULL JOIN [Sales].[SalesOrderHeader] SOH ON C.CustomerID = SOH.CustomerID

-- 240 Generate a Cartesian product of product categories and territories, showing all possible combinations. (230)

SELECT * FROM [Production].[ProductCategory], [Sales].[SalesTerritory]

-- 241 Retrieve the names of employees along with the names of their managers.

-- 242 Retrieve the list of products and their corresponding product descriptions.

SELECT P.PRODUCTID, C.PRODUCTCATEGORYID,C.Name, SC.Name, PD.Description 
FROM PRODUCTION.PRODUCT P 
JOIN PRODUCTION.PRODUCTSUBCATEGORY SC ON SC.ProductSubcategoryID = P. ProductSubcategoryID
JOIN PRODUCTION.ProductCategory C ON SC.ProductcategoryID = C.ProductCategoryID
JOIN Production.ProductModelProductDescriptionCulture D ON P.ProductModelID = D.ProductModelID
JOIN Production.ProductDescription PD ON D.ProductDescriptionID = PD.ProductDescriptionID 

-- 243 Retrieve the list of orders along with the names of customers who placed those orders, matching on both customer ID and territory ID.

SELECT SOH.SalesOrderID,SOH.CustomerID,CONCAT(P.FirstName,P.LastName) CustomerName,C.TerritoryID
FROM [Sales].[SalesOrderHeader] SOH
JOIN [Person].[Person] P ON P.BusinessEntityID = SOH.CustomerID
JOIN [Sales].[Customer] C ON C.CustomerID =  SOH.CustomerID

-- 244 Get the total sales amount for each product, joining the SalesOrderDetail table with the Product table. (234)

SELECT SOD.SalesOrderID, P.ProductID, P.Name, SOD.LineTotal 
FROM [Sales].[SalesOrderDetail] SOD
JOIN [Production].[Product] P ON P.ProductID = SOD.ProductID

-- 245 Retrieve the list of employees who have sold products with a price higher than the average price of all products. (235)

SELECT DISTINCT E.BusinessEntityID
FROM [HumanResources].[Employee] E
JOIN [Sales].[SalesOrderHeader] SOH ON E.BusinessEntityID = SOH.SalesPersonID
JOIN [Sales].[SalesOrderDetail] SOD ON SOH.SalesOrderID = SOD.SalesOrderID
JOIN [Production].[Product] P ON SOD.ProductID = P.ProductID
WHERE P.ListPrice > (SELECT AVG(ListPrice) FROM [Production].[Product])

-- 246 Retrieve the product name, list price, and color along with the product category name for each product, using aliases for table names.(236)

SELECT C.ProductCategoryID,P.Name ProductName, P.ListPrice Price, P.Color ProductColor 
FROM [Production].[Product] P
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID

-- 247 Retrieve the list of orders along with the names of customers who placed those orders, matching on customer ID, and filtering orders placed in the last month.

SELECT SOH.SalesOrderID,SOH.CustomerID,SOH.TerritoryID,CONCAT(P.FirstName,P.LastName) CustomerName, SOH.OrderDate
FROM [Sales].[SalesOrderHeader] SOH
JOIN [Person].[Person] P ON P.BusinessEntityID = SOH.CustomerID
WHERE SOH.ORDERDATE >= DATEADD(MONTH,- 1, (SELECT MAX(ORDERDATE) FROM [Sales].[SalesOrderHeader]))
AND SOH.OrderDate <= (SELECT MAX(OrderDate) FROM [Sales].[SalesOrderHeader])

-- 248 Get the total sales amount for each product category, along with the number of products in each category, only for categories with more than 10 products.

SELECT C.ProductCategoryID, COUNT(DISTINCT P.ProductID) NoOfProducts, SUM(SOD.LineTotal) TotalSales FROM [Production].[Product] P
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID
JOIN [Sales].[SalesOrderDetail] SOD ON SOD.ProductID = P.ProductID
JOIN [Sales].[SalesOrderHeader] SOH ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY C.ProductCategoryID
HAVING COUNT(DISTINCT P.ProductID) > 10

-- 249 Retrieve the total sales amount for each product category, along with the number of discontinued products in each category.

SELECT C.ProductCategoryID, SUM(SOD.LineTotal) TotalSales, COUNT(P.DiscontinuedDate) NumberOfDiscontinuedProducts FROM [Production].[Product] P
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID
JOIN [Sales].[SalesOrderDetail] SOD ON SOD.ProductID = P.ProductID
JOIN [Sales].[SalesOrderHeader] SOH ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY C.ProductCategoryID, P.DiscontinuedDate

-- 250 Retrieve the list of orders along with the names of customers who placed those orders and the shipping method used for each order

SELECT SOH.SalesOrderID, CONCAT (P.FirstName,' ', P.LastName) CustomerName, SM.Name
FROM [Sales].[SalesOrderHeader] SOH
JOIN [Purchasing].[ShipMethod] SM ON SM.ShipMethodID = SOH.ShipMethodID
LEFT JOIN [Person].[Person] P ON P.BusinessEntityID = SOH.CustomerID

-- 251 Retrieve the list of employees along with their job title and the job title of their manager.	

-- 252 Retrieve the list of products and their corresponding product descriptions, filtering out products with a description longer than 100 characters.

SELECT P.PRODUCTID, C.PRODUCTCATEGORYID,C.Name, SC.Name, PD.Description 
FROM PRODUCTION.PRODUCT P 
JOIN PRODUCTION.PRODUCTSUBCATEGORY SC ON SC.ProductSubcategoryID = P. ProductSubcategoryID
JOIN PRODUCTION.ProductCategory C ON SC.ProductcategoryID = C.ProductCategoryID
JOIN Production.ProductModelProductDescriptionCulture D ON P.ProductModelID = D.ProductModelID
JOIN Production.ProductDescription PD ON D.ProductDescriptionID = PD.ProductDescriptionID 
WHERE LEN(PD.Description) > 100

--253 Retrieve the list of orders along with the names of customers who placed those orders, ordered by order date in descending order.

SELECT SOH.SalesOrderID, CONCAT(P.FirstName,' ',P.LastName) CustomerName FROM [Sales].[SalesOrderHeader] SOH
JOIN [Person].[Person] P ON P.BusinessEntityID = SOH.CustomerID
ORDER BY SOH.OrderDate DESC

-- 254 Retrieve the top 10 customers with the highest total order amounts along with their corresponding order details.

SELECT TOP 10 CustomerID, SUM(TotalDue) TotalOrderAmounts  
FROM [Sales].[SalesOrderHeader]
GROUP BY CustomerID 
ORDER BY TotalOrderAmounts DESC

-- 255 Retrieve the list of employees along with the total number of orders each employee has processed, only for employees with more than 10 orders.

SELECT SalesPersonID, COUNT(SalesOrderID) NoOfOrders
FROM [Sales].[SalesOrderHeader]
GROUP BY SalesPersonID
HAVING COUNT(SalesOrderID) > 10 

-- 256 Retrieve the total sales amount for each product category, joining the SalesOrderDetail table with the Product and ProductCategory tables.

SELECT C.ProductCategoryID, SUM(SOH.TOTALDUE) TotalSales
FROM [Production].[Product] P
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID
JOIN [Sales].[SalesOrderDetail] SOD ON SOD.ProductID = P.ProductID
JOIN [Sales].[SalesOrderHeader] SOH ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY C.ProductCategoryID

-- 257 Get the list of employees along with their corresponding departments, including only employees who are currently active (based on a specified column in the Employee table).

SELECT E.BusinessEntityID,D.DepartmentID, E.CurrentFlag
FROM [HumanResources].[Employee] E
JOIN [HumanResources].[EmployeeDepartmentHistory] EDH ON EDH.BusinessEntityID = E.BusinessEntityID
JOIN [HumanResources].[Department] D ON D.DepartmentID = EDH.DepartmentID
WHERE E.CurrentFlag = 1

-- 258 Retrieve the list of product categories along with the number of products in each category, including categories without any products, by joining the ProductCategory table with the Product table.

SELECT  C.ProductCategoryID, C.Name, COUNT(P.ProductID) NoOfProducts 
FROM [Production].[Product] P 
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID
GROUP BY  C.ProductCategoryID, C.Name

-- 259 Retrieve a list of customers and orders, including customers who haven't placed any orders and orders without associated customers. Additionally, display "No Order" for customers who haven't placed any orders.

SELECT C.CustomerID,
CASE 
WHEN SOH.SalesOrderID IS NULL THEN 'NO ORDER'
ELSE CAST(SOH.SalesOrderID AS VARCHAR(15))
END AS 'SalesOrder'
FROM [Sales].[SalesOrderHeader] AS SOH
FULL JOIN  [Sales].[Customer] AS C
ON SOH.CustomerID = C.CustomerID

-- 260 Generate a Cartesian product of product categories and territories, showing all possible combinations, but filter the result to include only territories located in a specific country.

SELECT * FROM [Production].[ProductCategory], [Sales].[SalesTerritory] 

-- 261 Retrieve the names of employees along with the names of their managers, including multiple levels of hierarchy if applicable.

-- 262 Retrieve the list of orders along with the names of customers who placed those orders and the names of the sales representatives who handled those orders, joining the SalesOrderHeader table with the Customer and SalesPerson tables.

SELECT SOH.SalesOrderID, CONCAT(PP.FirstName, ' ', PP.LastName) CustomerName, CONCAT (P.FirstName,' ',P.LastName) SalesRepresentatives
FROM  [Sales].[SalesOrderHeader] SOH
JOIN [Sales].[SalesPerson] SP ON SP.BusinessEntityID = SOH.SalesPersonID
JOIN [Sales].[Customer] C ON C.CustomerID = SOH.CustomerID
JOIN [Person].[Person] P ON P.BusinessEntityID = SP.BusinessEntityID
JOIN [Person].[Person] PP ON C.PersonID = PP.BusinessEntityID
order by SOH.SalesOrderID

-- 263 Retrieve the list of employees who have sold products with a total sales amount exceeding the average sales amount of all employees, joining the Employee and SalesOrderHeader tables.

SELECT SOH.SalesPersonID, SUM(SOH.TOTALDUE) TotalSales 
FROM [Sales].[SalesOrderHeader] SOH 
JOIN [HumanResources].[Employee] E ON E.BusinessEntityID = SOH.SalesPersonID
GROUP BY SOH.SalesPersonID
HAVING SUM(SOH.TOTALDUE) > (SELECT AVG(TotalDue) FROM [Sales].[SalesOrderHeader])

-- 264 Retrieve the list of customers along with the total number of orders they've placed and the total amount spent by each customer, only including customers who have placed more than 5 orders and spent more than $1000 in total.

SELECT CustomerID, COUNT(SalesOrderID) NoOfOrders,SUM(TotalDue) TotalAmount
FROM [Sales].[SalesOrderHeader]
GROUP BY CustomerID
HAVING COUNT(SalesOrderID) > 5
AND SUM(TotalDue) >1000

-- 265 Retrieve the list of employees along with their first and last names from both the Employee and EmployeeBackup tables, combining the results using UNION, and then filtering out duplicate records.

SELECT * INTO EmployeeBackup
FROM [Person].[Person]

SELECT BusinessEntityID, FirstName, LastName FROM [Person].[Person]
UNION
SELECT BusinessEntityID, FirstName, LastName FROM EmployeeBackup

-- 266 Retrieve the list of products along with their product subcategory names and product category names by joining the Product, ProductSubcategory, and ProductCategory tables.

SELECT P.ProductID,C.ProductCategoryID,P.Name ProductName, SC.Name CategoryName
FROM [Production].[Product] P
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID

-- 267 Get the list of employees along with their hire date and the number of years they've been with the company, including employees who are not assigned to any department.

SELECT BusinessEntityID, HireDate,
DATEDIFF(YEAR, HireDate, GETDATE()) NumberOfYears
FROM [HumanResources].[Employee]

-- 268 Retrieve the list of product categories along with the names of products belonging to each category, including only categories with at least one product with a list price greater than $500.

SELECT P.ProductID,C.ProductCategoryID,P.Name ProductName, SC.Name CategoryName,P.ListPrice, COUNT(P.ProductID)
FROM [Production].[Product] P
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID
GROUP BY P.ProductID,C.ProductCategoryID,P.Name, SC.Name 
HAVING P.ListPrice > 500
AND COUNT(P.ProductID) >= 1

SELECT P.[Name], PC.[Name], COUNT(PC.[Name]) AS 'ProductCategory'
FROM [Production].[Product] AS P
INNER JOIN [Production].[ProductSubcategory] AS PSC
ON 	P.ProductSubcategoryID = PSC.ProductSubcategoryID
INNER JOIN [Production].[ProductCategory] AS PC
ON PC.ProductCategoryID = PSC.ProductCategoryID
GROUP BY P.[Name], PC.[Name], P.ListPrice
HAVING P.ListPrice > 500
AND COUNT(PC.[Name]) >= 1

-- 269 Retrieve a list of customers and orders, including customers who haven't placed any orders and orders without associated customers. 
-- Additionally, display the total number of orders placed by each customer.

SELECT C.CustomerID,SOH.SalesOrderID,  COUNT (SOH.SalesOrderID) NoOfOrders
FROM [Sales].[Customer] C
FULL JOIN [Sales].[SalesOrderHeader] SOH ON C.CustomerID = SOH.CustomerID
GROUP BY C.CustomerID,SOH.SalesOrderID

SELECT C.CustomerID,SOH.SalesOrderID,  COUNT(SOH.SalesOrderID)over(partition by C.CustomerID) NoOfOrders
FROM [Sales].[Customer] C
FULL JOIN [Sales].[SalesOrderHeader] SOH ON C.CustomerID = SOH.CustomerID

-- 270 Generate a Cartesian product of product categories and territories, showing all possible combinations, and calculate the total sales amount for each combination.

SELECT C.ProductCategoryID,C.Name CategoryName, ST.TerritoryID,ST.Name TerritoryName,SUM(SOH.TotalDue) TotalSalesAmount
FROM [Production].[ProductCategory] C
CROSS JOIN [Sales].[SalesTerritory] ST
JOIN [Production].[ProductSubcategory] SC ON C.ProductCategoryID = SC.ProductCategoryID
JOIN [Production].[Product] P ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Sales].[SalesOrderDetail] SOD ON P.ProductID = SOD.ProductID
JOIN [Sales].[SalesOrderHeader] SOH ON SOD.SalesOrderID = SOH.SalesOrderID AND SOH.TerritoryID = ST.TerritoryID
GROUP BY C.ProductCategoryID, C.Name, ST.TerritoryID, ST.Name
ORDER BY C.ProductCategoryID, ST.TerritoryID


SELECT C.[Name], ST.TerritoryID, SUM(SOH.TotalDue) TotalAmount 
FROM [Production].[ProductCategory] C
CROSS JOIN [Sales].[SalesTerritory] ST
INNER JOIN [Sales].[SalesOrderHeader] SOH
ON SOH.TerritoryID = ST.TerritoryID
GROUP BY C.[Name], ST.TerritoryID
ORDER BY ST.TerritoryID ASC

SELECT SUM(TotalDue) FROM [Sales].[SalesOrderHeader]
GROUP BY  TerritoryID
HAVING TerritoryID = 1

SELECT * FROM [Sales].[SalesOrderHeader]
-- 271 Retrieve the hierarchy of employees, including their managers and subordinates, using a recursive common table expression (CTE).

-- 272 Retrieve the list of orders along with the names of customers who placed those orders and the names of the sales representatives who handled those orders, only including orders with a total due amount greater than $1000.

SELECT SOH.SalesOrderID, CONCAT(PP.FirstName, ' ', PP.LastName) CustomerName, 
CONCAT (P.FirstName,' ',P.LastName) SalesRepresentatives
FROM  [Sales].[SalesOrderHeader] SOH
JOIN [Sales].[SalesPerson] SP ON SP.BusinessEntityID = SOH.SalesPersonID
JOIN [Sales].[Customer] C ON C.CustomerID = SOH.CustomerID
JOIN [Person].[Person] P ON P.BusinessEntityID = SP.BusinessEntityID
JOIN [Person].[Person] PP ON C.PersonID = PP.BusinessEntityID
WHERE SOH.TotalDue > 1000

-- 273 Retrieve the list of product categories along with the average list price of products in each category, only including categories where the average list price is higher than the overall average list price of all products.

SELECT P.ProductID,C.ProductCategoryID,P.Name ProductName, SC.Name CategoryName, AVG(P.ListPrice) ListPrice
FROM [Production].[Product] P
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID
GROUP BY P.ProductID,C.ProductCategoryID,P.Name, SC.Name 
HAVING AVG(P.ListPrice) > (SELECT AVG(ListPrice) FROM [Production].[Product])

-- 274 Retrieve the list of employees along with their departments and the total number of orders they've processed, only including employees who have processed more than 50 orders and belong to a department with at least 5 employees.

SELECT SOH.SalesPersonID,D.Name, COUNT(SOH.SalesOrderID) NoOfOrders
FROM [Sales].[SalesOrderHeader] SOH
JOIN [HumanResources].[EmployeeDepartmentHistory] EDH ON EDH.BusinessEntityID = SOH.SalesPersonID
JOIN [HumanResources].[Department] D ON D.DepartmentID = EDH.DepartmentID
WHERE D.DepartmentID IN
(SELECT DepartmentID FROM [HumanResources].[EmployeeDepartmentHistory]
GROUP BY DepartmentID
HAVING COUNT(BusinessEntityID) > 5
)
GROUP BY SOH.SalesPersonID,D.Name
HAVING COUNT(SOH.SalesOrderID) > 50

-- 275 Retrieve the list of customers who have placed orders along with the list of customers who have not placed orders, combining the results using UNION or UNION ALL to display all customers.

SELECT CustomerID FROM [Sales].[Customer]
UNION 
SELECT CustomerID FROM [Sales].[SalesOrderHeader]

-- 276 Retrieve the list of products along with their product subcategory names and product category names, only including products with a list price greater than $1000.

SELECT P.ProductID,C.ProductCategoryID,P.Name ProductName, SC.Name CategoryName
FROM [Production].[Product] P
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID 
WHERE P.ListPrice > 1000

-- 277 Get the list of employees along with their departments and the total number of employees in each department, including departments with no employees.

SELECT D.DepartmentID, D.Name, COUNT(DISTINCT E.BusinessEntityID) NumberOfEmployees
FROM [HumanResources].[Employee] E
JOIN [HumanResources].[EmployeeDepartmentHistory] EDH ON EDH.BusinessEntityID = E.BusinessEntityID
JOIN [HumanResources].[Department] D ON D.DepartmentID = EDH.DepartmentID AND EDH.EndDate IS NULL
GROUP BY D.DepartmentID, D.Name
ORDER BY NumberOfEmployees

-- 278 Retrieve the list of product categories along with the total number of products in each category and the average list price, including categories without any products.

SELECT  C.ProductCategoryID, C.Name, COUNT(P.ProductID) NoOfProducts, AVG(P.ListPrice) AverageListPrice
FROM [Production].[Product] P 
LEFT JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID
GROUP BY  C.ProductCategoryID, C.Name

-- 279 Retrieve a list of customers and orders, including customers who haven't placed any orders and orders without associated customers. Additionally, display the total number of orders placed by each customer, excluding customers with no orders.

SELECT C.CustomerID, COUNT(SOH.SalesOrderID) NoOfOrders
FROM [Sales].[Customer] C
LEFT JOIN [Sales].[SalesOrderHeader] SOH ON C.CustomerID = SOH.CustomerID
GROUP BY C.CustomerID
HAVING COUNT(SOH.SalesOrderID) > 0

-- 280 Generate a Cartesian product of product categories and territories, showing all possible combinations, and filter the result to include only territories with more than 10 customers, sorted by the total number of customers in descending order.

SELECT C.[Name], ST.TerritoryID, COUNT(SOH.CustomerID) NumberOfCustomers
FROM [Production].[ProductCategory] C
CROSS JOIN [Sales].[SalesTerritory] ST
INNER JOIN [Sales].[SalesOrderHeader] SOH ON SOH.TerritoryID = ST.TerritoryID
GROUP BY C.[Name], ST.TerritoryID
HAVING COUNT(SOH.CustomerID) > 10
ORDER BY NumberOfCustomers DESC

-- 281 Retrieve the hierarchical structure of employees, including their managers and subordinates, using a recursive common table expression (CTE), and filter the result to include only employees with a hire date in the past year.

-- 282 Retrieve the list of orders along with the names of customers who placed those orders and the names of the sales representatives who handled those orders, only including orders with a total due amount greater than $1000 and handled by 
-- sales representatives with more than 5 years of experience.

SELECT SOH.SalesOrderID, CONCAT(PP.FirstName, ' ', PP.LastName) CustomerName, CONCAT (P.FirstName,' ',P.LastName) SalesRepresentatives, DATEDIFF (YEAR, E.HireDate, GETDATE()) Experience
FROM  [Sales].[SalesOrderHeader] SOH
JOIN [Sales].[SalesPerson] SP ON SP.BusinessEntityID = SOH.SalesPersonID
JOIN [Sales].[Customer] C ON C.CustomerID = SOH.CustomerID
JOIN [Person].[Person] P ON P.BusinessEntityID = SP.BusinessEntityID
JOIN [Person].[Person] PP ON C.PersonID = PP.BusinessEntityID
JOIN [HumanResources].[Employee] E ON E.BusinessEntityID = SP.BusinessEntityID
WHERE SOH.TotalDue > 1000
AND DATEDIFF (YEAR, E.HireDate, GETDATE()) > 5

-- 283 Retrieve the list of product categories along with the total number of products in each category and the average list price, 
-- only including categories where the average list price is higher than the overall average list price of all products, sorted by the 
-- total number of products in descending order.

SELECT  C.ProductCategoryID, C.Name, COUNT(P.ProductID) NoOfProducts, AVG(P.ListPrice) AverageListPrice
FROM [Production].[Product] P 
LEFT JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID
GROUP BY  C.ProductCategoryID, C.Name
HAVING AVG(P.ListPrice) > (SELECT  AVG(ListPrice) FROM [Production].[Product])

--284 Retrieve the list of employees along with their departments and the total number of orders they've processed, only including employees who have processed more than 50 orders and belong to a department with at least 5 employees, and 
-- combine the results with the list of employees who have not processed any orders.

SELECT SOH.SalesPersonID,D.Name, COUNT(SOH.SalesOrderID) NoOfOrders
FROM [Sales].[SalesOrderHeader] SOH
JOIN [HumanResources].[EmployeeDepartmentHistory] EDH ON EDH.BusinessEntityID = SOH.SalesPersonID
JOIN [HumanResources].[Department] D ON D.DepartmentID = EDH.DepartmentID
WHERE D.DepartmentID IN
(SELECT DepartmentID FROM [HumanResources].[EmployeeDepartmentHistory]
GROUP BY DepartmentID
HAVING COUNT(BusinessEntityID) > 5
)
GROUP BY SOH.SalesPersonID,D.Name
HAVING COUNT(SOH.SalesOrderID) > 50

UNION

SELECT SOH.SalesPersonID,D.Name, COUNT(SOH.SalesOrderID) NoOfOrders
FROM [Sales].[SalesOrderHeader] SOH
JOIN [HumanResources].[EmployeeDepartmentHistory] EDH ON EDH.BusinessEntityID = SOH.SalesPersonID
JOIN [HumanResources].[Department] D ON D.DepartmentID = EDH.DepartmentID
GROUP BY SOH.SalesPersonID,D.Name
HAVING COUNT(SOH.SalesOrderID) = 0

-- 285 Retrieve the list of customers who have placed orders along with the list of customers who have not placed orders, combining the results using UNION or UNION ALL to display all customers, and implement pagination to display results in 
-- batches of 10 records.

SELECT CustomerID FROM [Sales].[Customer]
UNION 
SELECT CustomerID FROM [Sales].[SalesOrderHeader]

-- 286 Write a query to retrieve the product names along with a new column "PriceRange" that categorizes products as "Low" if the list price is below $50, "Medium" if between $50 and $100, and "High" if above $100.

SELECT ProductID, Name, 
CASE
WHEN ListPrice < 50 THEN 'Low'
WHEN ListPrice BETWEEN 50 AND 100 THEN 'Medium' 
WHEN ListPrice > 100 THEN 'High'
END PriceRange
FROM [Production].[Product]

-- 287 Retrieve the product names and list prices for products with IDs 1, 5, and 10

SELECT ProductID, Name, ListPrice
FROM [Production].[Product]
WHERE ProductID IN (1,5,10)

-- 288 Get the list of employees whose first name starts with 'J'

SELECT E.BusinessEntityID, P.FirstName FROM [HumanResources].[Employee] E
JOIN [Person].[Person] P ON P.BusinessEntityID = E.BusinessEntityID
WHERE P.FirstName LIKE 'J%'

-- 289 Retrieve the product names that have no associated product reviews

SELECT ProductID,Name
FROM [Production].[Product] 
WHERE ProductID NOT IN
(SELECT ProductID FROM [Production].[ProductReview])

-- 290 Get the list of orders that do not contain products with IDs 15, 20, and 25

SELECT ProductID, Name, ListPrice
FROM [Production].[Product]
WHERE ProductID NOT IN (15,20,25)

-- 291 Retrieve the product names and list prices for products with a list price less than $50 and a color of 'Red'

SELECT NAME,ListPrice FROM [Production].[Product]
WHERE ListPrice < 50 
AND Color = 'RED'

-- 292 Get the list of employees hired between '2005-01-01' and '2008-12-31'

SELECT * FROM [HumanResources].[Employee] 
WHERE HireDate BETWEEN '2005-01-01' and '2008-12-31'

-- 293 Retrieve the product names with a list price greater than $100

SELECT NAME,ListPrice 
FROM [Production].[Product]
WHERE ListPrice > 100

-- 294 Write a query to retrieve the product names along with a new column "PriceCategory" that categorizes products as "Budget" if the list price is below $50, 
-- "Standard" if between $50 and $100, and "Premium" if above $100

SELECT ProductID, Name, 
CASE
WHEN ListPrice < 50 THEN 'Budget'
WHEN ListPrice BETWEEN 50 AND 100 THEN 'Standard' 
WHEN ListPrice > 100 THEN 'Premium'
END PriceCategory
FROM [Production].[Product]

-- 295 Retrieve the order IDs along with a new column "OrderStatus" that categorizes orders as "Pending" if the order status is 1, "In Progress" if the status is 2, and "Completed" if the status is 3

SELECT SalesOrderID,
CASE
WHEN Status = 1 THEN 'Pending'
WHEN Status = 2 THEN 'In Progress'
WHEN Status = 3 THEN 'Completed'
ELSE Status
END OrderStatus
FROM [Sales].[SalesOrderHeader]

-- 296 Get the list of product names and list prices for products with IDs 2, 6, and 11

SELECT ProductID, Name, ListPrice
FROM [Production].[Product]
WHERE ProductID IN (2,6,11)

-- 297 Retrieve the order IDs and order dates for orders with IDs 1001, 1005, and 1010

SELECT SalesOrderID, OrderDate FROM [Sales].[SalesOrderHeader]
WHERE SalesOrderID IN (1001, 1005, 1010)

-- 298 Get the list of employee names and titles for employees with titles containing the word 'Manager

SELECT BusinessEntityID, JobTitle 
FROM [HumanResources].[Employee]
WHERE JobTitle LIKE '%Manager%'

-- 299 Retrieve the list of product names for products with names containing the word 'bike'

SELECT ProductID, Name 
FROM [Production].[Product]
WHERE NAME LIKE'%BIKE%'

-- 300 Retrieve the product names that have no associated product images

SELECT * FROM [Production].[Product]
WHERE ProductID NOT IN
(SELECT ProductID FROM [Production].[ProductProductPhoto])

-- 301 Get the list of customer IDs and names for customers who have not placed any orders

SELECT C.CustomerID , CONCAT(P.FirstName,' ',P.LastName) CustomerName
FROM [Sales].[SalesOrderHeader] SOH
RIGHT JOIN [Sales].[Customer] C ON C.CustomerID = SOH.CustomerID
JOIN [Person].[Person] P ON P.BusinessEntityID = C.CustomerID
WHERE SOH.SalesOrderID IS NULL
ORDER BY C.CustomerID

-- 302 Get the list of orders that do not contain products with IDs 16, 21, and 26

SELECT * FROM [Sales].[SalesOrderDetail]
WHERE ProductID NOT IN (16,21,26)

-- 303 Retrieve the product names for products not belonging to categories with IDs 2, 5, and 8

SELECT P.ProductID, P.Name, SC.ProductCategoryID
FROM [Production].[Product] P
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
WHERE SC.ProductCategoryID NOT IN (2,5,8)

-- 304 Retrieve the product names and list prices for products with a list price less than $50 or a color of 'Blue'

SELECT NAME,ListPrice FROM [Production].[Product]
WHERE ListPrice < 50 
AND Color = 'Blue'

-- 305 Get the list of employees hired after '2005-01-01' and belonging to the department with ID 5

SELECT * FROM [HumanResources].[Employee] E
JOIN [HumanResources].[EmployeeDepartmentHistory] EDH ON EDH.BusinessEntityID = E.BusinessEntityID
WHERE HireDate > '2005-01-01' AND EDH.DepartmentID = 5

-- 306 Get the list of orders placed between '2010-01-01' and '2010-12-31'

SELECT * FROM [Sales].[SalesOrderHeader] 
WHERE OrderDate BETWEEN '2010-01-01' AND '2010-12-31'

-- 307 Retrieve the product names with a list price between $50 and $100

SELECT * FROM [Production].[Product] 
WHERE ListPrice BETWEEN $50 AND $100

-- 308 Retrieve the customer IDs and names for customers with a total amount spent greater than $1000

SELECT SOH.CustomerID, CONCAT(P.FirstName,' ' ,P.LastName) CustromerName, SUM(SOH.TotalDue) TotalAmount
FROM [Sales].[SalesOrderHeader] SOH
JOIN [Person].[Person] P ON P.BusinessEntityID = SOH.CustomerID
GROUP BY SOH.CustomerID, CONCAT(P.FirstName,' ' ,P.LastName)
HAVING SUM(SOH.TotalDue) > 1000

-- 309 Get the list of products with a weight greater than 10 pounds

SELECT * FROM [Production].[Product]
WHERE Weight > 10.00

-- 310 Write a query to retrieve the employee names along with a new column "EmployeeType" that categorizes employees as 
-- "Full-Time" if their job title contains 'Manager', and "Part-Time" otherwise

SELECT CONCAT(P.FirstName,' ',P.LastName) EmployeeName,
CASE
WHEN E.JobTitle LIKE '%MANAGER%' THEN 'Full-Time'
ELSE 'Part-Time'
END EmployeeType
FROM [Person].[Person] P
JOIN [HumanResources].[Employee] E ON E.BusinessEntityID = P.BusinessEntityID
 
-- 311 Retrieve the product names along with a new column "DiscountType" that categorizes products as "Discounted" if their 
-- standard cost is less than the list price, and "Regular Price" otherwise
  

-- 312 Get the list of product names and list prices for products with IDs 3, 7, and 12

SELECT ProductID, NAME, ListPrice 
FROM [Production].[Product]
WHERE ProductID IN (3,7,12)

-- 313 Retrieve the order IDs and order dates for orders with IDs 1002, 1006, and 1011

SELECT SalesOrderID, OrderDate 
FROM [Sales].[SalesOrderHeader]
WHERE SalesOrderID IN (1002, 1006, 1011)

-- 314 Get the list of employee names and titles for employees with titles containing the word 'Assistant'

SELECT CONCAT(P.FirstName,' ',P.LastName) EmployeeName, E.JobTitle
FROM [Person].[Person] P
JOIN [HumanResources].[Employee] E ON E.BusinessEntityID = P.BusinessEntityID
WHERE E.JobTitle LIKE '%Assistant%'

-- 315 Retrieve the list of product names for products with names containing the word 'helmet'

SELECT * FROM [Production].[Product]
WHERE Name LIKE '%helmet%'

-- 316 Retrieve the product names that have no associated product manuals



-- 317 Get the list of customer IDs and names for customers who have not placed any orders in the year 2020

SELECT SOH.CustomerID, CONCAT(P.FirstName,' ', P.LastName) CustomerName FROM [Sales].[SalesOrderHeader] SOH
JOIN [Person].[Person] P ON P.BusinessEntityID = SOH.CustomerID
WHERE YEAR(SOH.OrderDate) != 2020

SELECT C.CustomerID, CONCAT(P.FirstName, ' ', P.LastName) CustomerName
FROM [Sales].[Customer] C
JOIN [Person].[Person] P ON P.BusinessEntityID = C.CustomerID
LEFT JOIN (SELECT CustomerID
FROM [Sales].[SalesOrderHeader]
WHERE YEAR(OrderDate) = 2020) ORDER20 ON ORDER20.CustomerID = C.CustomerID
WHERE ORDER20.CustomerID IS NULL

-- 318 Get the list of orders that do not contain products with IDs 17, 22, and 27

SELECT * FROM [Sales].[SalesOrderDetail]
WHERE ProductID IN (17,22,27)

-- 319 Retrieve the product names for products not belonging to categories with IDs 3, 6, and 9

SELECT * FROM [Production].[Product] P
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
WHERE SC.ProductCategoryID NOT IN (3,6,9)

-- 320 Retrieve the product names and list prices for products with a list price less than $50 and a color of 'Black'

SELECT NAME,ListPrice FROM [Production].[Product]
WHERE ListPrice < 50 
AND Color = 'Black'

-- 321 Get the list of employees hired after '2008-01-01' and belonging to either the department with ID 5 or the department with ID 8

SELECT E.BusinessEntityID,EDH.DepartmentID, E.HireDate FROM [HumanResources].[Employee] E
JOIN [HumanResources].[EmployeeDepartmentHistory] EDH ON EDH.BusinessEntityID = E.BusinessEntityID
WHERE HireDate > '2008-01-01' AND (EDH.DepartmentID = 5 OR EDH.DepartmentID = 8)

-- 322 Get the list of orders placed between '2015-01-01' and '2015-12-31'

SELECT * FROM [Sales].[SalesOrderHeader]
WHERE OrderDate BETWEEN '2015-01-01' AND '2015-12-31'

-- 323 Retrieve the product names with a weight between 5 and 10 pounds

SELECT Name,Weight FROM [Production].[Product]
WHERE WEIGHT BETWEEN 5.00 AND 10.00

-- 324 Retrieve the customer IDs and names for customers with a total amount spent greater than $5000

SELECT SOH.CustomerID, CONCAT(P.FirstName,' ' ,P.LastName) CustromerName, SUM(SOH.TotalDue) TotalAmount
FROM [Sales].[SalesOrderHeader] SOH
JOIN [Person].[Person] P ON P.BusinessEntityID = SOH.CustomerID
GROUP BY SOH.CustomerID, CONCAT(P.FirstName,' ' ,P.LastName)
HAVING SUM(SOH.TotalDue) > 5000

-- 325 Get the list of products with a list price greater than twice their standard cost

SELECT ProductID, Name, ListPrice FROM [Production].[Product]
WHERE ListPrice > (2*StandardCost)

-- 326 Write a query to retrieve the order IDs along with a new column "OrderPriority" that categorizes orders as "High Priority" 
-- if the total due amount is greater than $5000, "Medium Priority" if between $1000 and $5000, and "Low Priority" otherwise

SELECT SalesOrderID, CustomerID, 
CASE
WHEN TotalDue > 1000 THEN 'High Priority'
WHEN TotalDue > 5000 THEN 'Medium Priority'
ELSE 'Low Priority'
END OrderPriority
FROM [Sales].[SalesOrderHeader]  

-- 327 Get the list of product names and list prices for products with IDs 4, 8, and 13, and include a count of how many times each product has been ordered

SELECT P.ProductID,P.Name, P.ListPrice, COUNT(SOD.ProductID) NoOfProducts  FROM [Production].[Product] P 
FULL JOIN [Sales].[SalesOrderDetail] SOD ON SOD.ProductID = P.ProductID
GROUP BY P.ProductID, P.ListPrice,P.Name
HAVING P.ProductID IN (4,8,13)

-- 328 Retrieve the employee names and titles for employees with titles similar to 'Engineer', allowing for wildcard matches

SELECT CONCAT(P.FirstName,' ',P.LastName) EmployeeName, E.JobTitle FROM [Person].[Person] P
JOIN [HumanResources].[Employee] E ON E.BusinessEntityID = P.BusinessEntityID
WHERE E.JobTitle LIKE '%Engineer%'

-- 329 Retrieve the product names that have no associated product reviews, but only consider products with a list price above the average list price

SELECT ProductID,Name
FROM [Production].[Product] 
WHERE ProductID NOT IN
(SELECT ProductID FROM [Production].[ProductReview])
AND ListPrice > (SELECT AVG(ListPrice) FROM [Production].[Product]) 

-- 330 Get the list of orders that do not contain any products with IDs 18, 23, and 28, and also do not contain any products with a list price above $100

SELECT * FROM [Sales].[SalesOrderDetail] SOD
JOIN [Production].[Product] P ON P.ProductID = SOD.ProductID
WHERE P.ProductID NOT IN (18,23,28)
AND P.ListPrice > 100

-- 331 Retrieve the product names and list prices for products with a list price less than $50 or a color of 'Red', but exclude products with a weight exceeding 10 pounds

SELECT NAME,ListPrice, Weight FROM [Production].[Product]
WHERE (ListPrice < 50 
OR Color = 'Red') 
AND Weight < 10

-- 332 Get the list of orders placed between '2018-01-01' and '2018-12-31', and include the total number of distinct products ordered in each order

SELECT SOD.SalesOrderID, COUNT(DISTINCT SOD.ProductID) NoOfProducts 
FROM [Sales].[SalesOrderHeader] SOH
JOIN [Sales].[SalesOrderDetail] SOD ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE SOH.OrderDate BETWEEN '2018-01-01' AND '2018-12-31'
GROUP BY SOD.SalesOrderID

-- 333 Retrieve the customer IDs and names for customers with a total amount spent greater than the average total amount 
-- spent by all customers, and also with a total number of orders placed greater than the average number of orders placed by allcustomers

SELECT SOH.CustomerID,CONCAT(P.FirstName, ' ', P.LastName) AS CustomerName,SUM(SOH.TotalDue) AS TotalAmount,COUNT(SOH.SalesOrderID) AS NumberOfOrders
FROM [Sales].[SalesOrderHeader] SOH
JOIN [Person].[Person] P ON P.BusinessEntityID = SOH.CustomerID
GROUP BY SOH.CustomerID, P.FirstName, P.LastName
HAVING SUM(SOH.TotalDue) > (SELECT AVG(TotalSpent) FROM (SELECT SUM(TotalDue) TotalSpent FROM [Sales].[SalesOrderHeader] GROUP BY CustomerID) A)
AND COUNT(SOH.SalesOrderID) > (SELECT AVG(OrderCount) FROM (SELECT COUNT(SalesOrderID) OrderCount FROM [Sales].[SalesOrderHeader] GROUP BY CustomerID) B)

-- 334 Write a query to retrieve the order IDs along with a new column "OrderType" that categorizes orders as "Online" if the 
-- order was placed online (using a specific column in the Orders table) and "In-Store" if it was placed in-store

SELECT CustomerID,SalesOrderID,
CASE
WHEN OnlineOrderFlag = 1 THEN 'Online'
WHEN OnlineOrderFlag = 0 THEN 'In-Store'
END OrderType
FROM [Sales].[SalesOrderHeader]

-- 335 Get the list of product names and list prices for products with IDs 4, 8, and 13, and include a count of how many times each product has been ordered, 
-- but only consider orders placed in the year 2020

SELECT P.ProductID, P.ListPrice, COUNT(SOD.ProductID) NoOfProducts  FROM [Production].[Product] P 
FULL JOIN [Sales].[SalesOrderDetail] SOD ON SOD.ProductID = P.ProductID
JOIN [Sales].[SalesOrderHeader] SOH ON SOH.SalesOrderID = SOD.SalesOrderID
WHERE P.ProductID IN (4,8,13)
AND YEAR (SOH.OrderDate) = 2020
GROUP BY P.ProductID, P.ListPrice

-- 336 Retrieve the employee names and titles for employees with titles containing both the words 'Sales' and 'Representative', in any order

SELECT CONCAT(P.FirstName,' ',P.LastName) EmployeeName, E.JobTitle FROM [Person].[Person] P
JOIN [HumanResources].[Employee] E ON E.BusinessEntityID = P.BusinessEntityID
WHERE E.JobTitle LIKE '%Sales%' AND E.JobTitle LIKE '%Representative%'

SELECT CONCAT(P.FirstName,' ',P.LastName) EmployeeName, E.JobTitle FROM [Person].[Person] P
JOIN [HumanResources].[Employee] E ON E.BusinessEntityID = P.BusinessEntityID
WHERE E.JobTitle LIKE '%Sales Representative%' 

-- 337 Retrieve the product names that have no associated product reviews, 
--but only consider products with a list price above the average list price in their respective category

SELECT T1.Name,T1.ProductCategoryID,T1.ListPrice, T2.Average FROM
(SELECT P.ProductID,P.Name,C.ProductCategoryID,P.ListPrice
FROM [Production].[Product] P
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID
WHERE ProductID NOT IN
(SELECT ProductID FROM [Production].[ProductReview])) T1
JOIN
(SELECT C.ProductCategoryID, AVG(P.ListPrice) Average 
FROM [Production].[Product] P
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID
GROUP BY C.ProductCategoryID ) T2
ON T1.ProductCategoryID = T2.ProductCategoryID
AND T2.Average < T1.ListPrice

-- 338 Get the list of orders that do not contain any products with IDs 18, 23, and 28, and also do not contain any products with 
-- a list price above $100, but only consider orders placed by customers located in the 'United States'

SELECT SOH.SalesOrderID,P.ProductID, P.ListPrice, CR.Name
FROM [Sales].[SalesOrderDetail] SOD
JOIN [Production].[Product] P ON P.ProductID = SOD.ProductID
JOIN [Sales].[SalesOrderHeader] SOH ON SOH.SalesOrderID = SOD.SalesOrderID
JOIN [Sales].[Customer] C ON C.CustomerID = SOH.CustomerID
JOIN [Sales].[SalesTerritory] ST ON ST.TerritoryID = C.TerritoryID
JOIN [Person].[CountryRegion] CR ON CR.CountryRegionCode = ST.CountryRegionCode
WHERE (P.ProductID NOT IN (18,23,28)
AND P.ListPrice > 100)
AND CR.Name = 'United States' 

-- 339 Retrieve the product names and list prices for products with a list price less than $50 or a color of 'Red', 
-- but exclude products with a weight exceeding 10 pounds and which are discontinued

SELECT NAME,ListPrice,Weight, DiscontinuedDate FROM [Production].[Product]
WHERE (ListPrice < 50 
OR Color = 'RED') 
AND Weight < 10 AND DiscontinuedDate IS NOT NULL

-- 340 Get the list of orders placed between '2018-01-01' and '2018-12-31', and include the total number of distinct products ordered in each order, 
-- but only consider orders with a total due amount greater than the average total due amount

SELECT SOD.SalesOrderID, COUNT(DISTINCT SOD.ProductID) NoOfProducts 
FROM [Sales].[SalesOrderHeader] SOH
JOIN [Sales].[SalesOrderDetail] SOD ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE SOH.OrderDate BETWEEN '2018-01-01' AND '2018-12-31'
AND SOH.TotalDue > (SELECT AVG(TotalDue)FROM [Sales].[SalesOrderHeader])
GROUP BY SOD.SalesOrderID

-- 341 Retrieve the customer IDs and names for customers with a total amount spent greater than the average total amount 
-- spent by all customers, and also with a total number of orders placed greater than the average number of orders placed by all
-- customers, but only consider customers who have placed orders in both the 'Online' and 'In-Store' categories

SELECT SOH.CustomerID,CONCAT(P.FirstName, ' ', P.LastName) AS CustomerName,SUM(SOH.TotalDue) AS TotalAmount,COUNT(SOH.SalesOrderID) AS NumberOfOrders
FROM [Sales].[SalesOrderHeader] SOH
JOIN [Person].[Person] P ON P.BusinessEntityID = SOH.CustomerID
WHERE (SOH.OnlineOrderFlag = 0 AND SOH.OnlineOrderFlag = 1)
GROUP BY SOH.CustomerID, P.FirstName, P.LastName
HAVING (SUM(SOH.TotalDue) > (SELECT AVG(TotalSpent) FROM (SELECT SUM(TotalDue) TotalSpent FROM [Sales].[SalesOrderHeader] GROUP BY CustomerID)  A)
AND COUNT(SOH.SalesOrderID) > (SELECT AVG(OrderCount) FROM (SELECT COUNT(SalesOrderID) OrderCount FROM [Sales].[SalesOrderHeader] GROUP BY CustomerID) B))

-- 342 Write a query to retrieve the order IDs along with a new column "OrderPriority" that categorizes orders as "High Priority" 
-- if the total due amount is greater than $5000, "Medium Priority" if between $1000 and $5000, and "Low Priority" otherwise

SELECT SalesOrderID, CustomerID, 
CASE
WHEN TotalDue > 1000 THEN 'High Priority'
WHEN TotalDue > 5000 THEN 'Medium Priority'
ELSE 'Low Priority'
END OrderPriority
FROM [Sales].[SalesOrderHeader]  

-- 343 Get the list of product names and list prices for products with IDs 4, 8, and 13, and include a count of how many times each product has been ordered,
-- but only consider orders placed in the year 2021 and shipped to the 'United States'

SELECT P.ProductID, P.ListPrice, COUNT(SOD.ProductID) NoOfOrders, CR.Name
FROM [Sales].[SalesOrderDetail] SOD
FULL JOIN [Production].[Product] P ON P.ProductID = SOD.ProductID
FULL  JOIN [Sales].[SalesOrderHeader] SOH ON SOH.SalesOrderID = SOD.SalesOrderID
FULL  JOIN [Sales].[SalesTerritory] ST ON ST.TerritoryID = SOH.TerritoryID
FULL JOIN [Person].[CountryRegion] CR ON CR.CountryRegionCode = ST.CountryRegionCode
WHERE P.ProductID IN (4,8,13) AND YEAR(SOH.OrderDate) = 2021 AND CR.Name = 'United States'
GROUP BY P.ProductID, P.ListPrice, CR.Name

-- 344 Retrieve the employee names and titles for employees with titles containing both the words 'Sales' and 'Manager', in any order, and who have been hired after '2010-01-01'

SELECT CONCAT(P.FirstName,' ',P.LastName) EmployeeName, E.JobTitle, E.HireDate FROM [Person].[Person] P
JOIN [HumanResources].[Employee] E ON E.BusinessEntityID = P.BusinessEntityID
WHERE (E.JobTitle LIKE '%Sales %' AND E.JobTitle LIKE '%Manager%')
AND E.HireDate > '2010-01-01'

-- 345 Retrieve the product names that have no associated product reviews, but only consider products with a list price above 
-- the average list price in their respective category and which are not discontinued

SELECT T1.Name,T1.ProductCategoryID,T1.ListPrice, T2.Average, T1.DiscontinuedDate FROM
(SELECT P.ProductID,P.Name,C.ProductCategoryID,P.ListPrice, P.DiscontinuedDate
FROM [Production].[Product] P
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID
WHERE ProductID NOT IN
(SELECT ProductID FROM [Production].[ProductReview])) T1
JOIN
(SELECT C.ProductCategoryID, AVG(P.ListPrice) Average 
FROM [Production].[Product] P
JOIN [Production].[ProductSubcategory] SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN [Production].[ProductCategory] C ON C.ProductCategoryID = SC.ProductCategoryID
GROUP BY C.ProductCategoryID ) T2
ON T1.ProductCategoryID = T2.ProductCategoryID
AND T2.Average < T1.ListPrice
AND T1.DiscontinuedDate IS NULL

-- 346 Get the list of orders that do not contain any products with IDs 18, 23, and 28, and also do not contain any products with 
-- a list price above $100, but only consider orders placed by customers located in the 'United States' and shipped to the 'Canada'

SELECT SOD.SalesOrderID, P.ListPrice, SOH.ShipToAddressID
FROM [Sales].[SalesOrderDetail] SOD
JOIN [Production].[Product] P ON P.ProductID = SOD.ProductID
JOIN [Sales].[SalesOrderHeader] SOH ON SOH.SalesOrderID = SOD.SalesOrderID
JOIN [Person].[Address] A ON A.AddressID = SOH.BillToAddressID
JOIN [Person].[StateProvince] SP ON SP.StateProvinceID = A.StateProvinceID
JOIN [Person].[CountryRegion]  CR ON CR.CountryRegionCode = SP.CountryRegionCode
WHERE SOD.ProductID NOT IN (18, 23, 28)
AND P.ListPrice > 100 AND CR.[Name] = 'United States'
AND SOH.ShipToAddressID IN (SELECT A.AddressID  
FROM [Sales].[SalesOrderDetail] D
JOIN [Sales].[SalesOrderHeader] H ON H.SalesOrderID = D.SalesOrderID
JOIN [Person].[Address] A ON A.AddressID = H.BillToAddressID
JOIN [Person].[StateProvince] SP ON SP.StateProvinceID = A.StateProvinceID
WHERE SP.CountryRegionCode = 'CA')

-- 347 Retrieve the product names and list prices for products with a list price less than $50 or a color of 'Red', but exclude 
-- products with a weight exceeding 10 pounds and which are discontinued, and have been ordered at least 10 times

SELECT P.NAME,P.ListPrice,P.Weight, P.DiscontinuedDate, COUNT (SOD.ProductID) NoOfProducts
FROM [Production].[Product] P
JOIN [Sales].[SalesOrderDetail] SOD ON SOD.ProductID = P.ProductID
WHERE (ListPrice < 50 
OR Color = 'RED') 
AND Weight < 10 AND DiscontinuedDate IS NOT NULL
GROUP BY P.NAME, P.ListPrice, P.Weight, P.DiscontinuedDate
HAVING COUNT (SOD.ProductID) >= 10

-- 348 Get the list of orders placed between '2019-01-01' and '2019-12-31', and include the total number of distinct products 
-- ordered in each order, but only consider orders with a total due amount greater than the average total due amount and with a 
-- payment method of 'Credit Card'

SELECT SOD.SalesOrderID, COUNT(DISTINCT SOD.ProductID) NoOfProducts, CC.CreditCardID 
FROM [Sales].[SalesOrderHeader] SOH
JOIN [Sales].[SalesOrderDetail] SOD ON SOD.SalesOrderID = SOH.SalesOrderID
JOIN [Sales].[Customer] C ON C.CustomerID = SOH.CustomerID
JOIN [Sales].[PersonCreditCard] CC ON CC.BusinessEntityID = C.CustomerID
WHERE SOH.OrderDate BETWEEN '2019-01-01' AND '2019-12-31'
AND SOH.TotalDue > (SELECT AVG(TotalDue)FROM [Sales].[SalesOrderHeader])
GROUP BY SOD.SalesOrderID,CC.CreditCardID

-- 349 Retrieve the customer IDs and names for customers with a total amount spent greater than the average total amount 
-- spent by all customers, and also with a total number of orders placed greater than the average number of orders placed by all
-- customers, but only consider customers who have placed orders in both the 'Online' and 'In-Store' categories, and have not 
-- placed any orders in the year 2022

SELECT SOH.CustomerID,CONCAT(P.FirstName, ' ', P.LastName) AS CustomerName,SUM(SOH.TotalDue) AS TotalAmount,COUNT(SOH.SalesOrderID) AS NumberOfOrders
FROM [Sales].[SalesOrderHeader] SOH
JOIN [Person].[Person] P ON P.BusinessEntityID = SOH.CustomerID
WHERE (SOH.OnlineOrderFlag = 0 AND SOH.OnlineOrderFlag = 1)
AND YEAR(SOH.OrderDate) =2022
GROUP BY SOH.CustomerID, P.FirstName, P.LastName
HAVING (SUM(SOH.TotalDue) > (SELECT AVG(TotalSpent) FROM (SELECT SUM(TotalDue) TotalSpent FROM [Sales].[SalesOrderHeader] GROUP BY CustomerID)  A)
AND COUNT(SOH.SalesOrderID) > (SELECT AVG(OrderCount) FROM (SELECT COUNT(SalesOrderID) OrderCount FROM [Sales].[SalesOrderHeader] GROUP BY CustomerID) B))
