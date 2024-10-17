-- 1 Query to find the average sales by year: Write a SQL query to find the average sales for each 
-- year from the Sales SalesOrderHeader table

SELECT 
	YEAR(OrderDate)		AS		'Sales Year', 
	AVG(TotalDue)		AS		'Avg Sales' 
FROM 
	[Sales].[SalesOrderHeader]
GROUP BY 
	YEAR(OrderDate)

-- 2 Query to find the total sales by year and month: Write a SQL query to find the total sales for 
-- each year and month from the Sales SalesOrderHeader table

SELECT
	YEAR(OrderDate)					AS		'Sales Year', 
	DATENAME(MONTH,OrderDate)		AS		'Sales Month',
	AVG(TotalDue)					AS		'Avg Sales' 
FROM 
	[Sales].[SalesOrderHeader]
GROUP BY 
	YEAR(OrderDate),
	DATENAME(MONTH,OrderDate)
ORDER BY 
	YEAR(OrderDate),
	DATENAME(MONTH,OrderDate)

-- 3 Query to find the products that have never been sold: Write a SQL query to find the products 
-- that have never been sold from the Sales SalesOrderDetail and Production Product tables

SELECT 
	P.ProductID, 
	P.Name 
FROM 
	[Production].[Product]			AS		P
WHERE
	P.ProductID NOT IN
(SELECT 
	SOD.ProductID 
FROM	
	[Sales].[SalesOrderDetail]		AS		SOD)

-- 4 Query to find the customers who have not placed any orders in the last year: Write a SQL 
-- query to find the customers who have not placed any orders in the last year from the Sales 
-- SalesOrderHeader table

SELECT 
	C.CustomerID, 
	YEAR(SOH.OrderDate)				AS		'Year'
FROM 
	[Sales].[Customer]				AS		C
LEFT JOIN
	[Sales].[SalesOrderHeader]		AS		SOH		ON		SOH.CustomerID = C.CustomerID
WHERE 
	C.CustomerID 
NOT IN 
(
SELECT 
	CustomerID 
FROM 
	[Sales].[SalesOrderHeader]
WHERE
	YEAR(OrderDate) = DATEADD(YEAR, -1, (SELECT MAX (OrderDate) FROM [Sales].[SalesOrderHeader]))
)

-- 5 Query to find the most popular product category: Write a SQL query to find the product 
-- category that has the highest total sales from the Sales SalesOrderDetail, Production Product, and 
-- Production ProductSubcategory tables

SELECT 
	SC.ProductCategoryID, 
	SUM(SOD.LineTotal)						AS			'Total Sales' 
FROM 
	[Sales].[SalesOrderDetail]				AS			SOD
INNER JOIN  
	[Production].[Product]					AS			P		ON		P.ProductID				= SOD.ProductID
INNER JOIN  
	[Production].[ProductSubcategory]		AS			SC		ON		SC.ProductSubcategoryID = P.ProductSubcategoryID
GROUP BY SC.ProductCategoryID

-- 6 Query to find the salesperson with the highest total sales: Write a SQL query to find the 
-- salesperson who has the highest total sales from the Sales SalesOrderHeader and Sales SalesPerson 
-- tables

SELECT 
	SP.BusinessEntityID, 
	SUM(SOH.TotalDue)				AS		'Total Sales'
FROM 
	[Sales].[SalesOrderHeader]		AS		SOH
INNER JOIN 
	[Sales].[SalesPerson]			AS		SP		ON		SP.BusinessEntityID = SOH.SalesPersonID
GROUP BY 
	SP.BusinessEntityID

-- 7 Query to find the total quantity of each product sold: Write a SQL query to find the total 
-- quantity of each product sold from the Sales SalesOrderDetail table

SELECT 
	ProductID, 
	COUNT(SalesOrderID)		 AS		 'No Of Products' 
FROM 
	[Sales].[SalesOrderDetail]
GROUP BY 
	ProductID

-- 8 Query to find the average sales amount for each salesperson: Write a SQL query to find the 
-- average sales amount for each salesperson from the Sales SalesOrderHeader and Sales SalesPerson 
-- tables

SELECT 
	SP.BusinessEntityID, 
	AVG(SOH.TotalDue)				AS		'Avg Sales'
FROM 
	[Sales].[SalesOrderHeader]		AS		SOH
INNER JOIN 
	[Sales].[SalesPerson]			AS		SP		ON		SP.BusinessEntityID = SOH.SalesPersonID
GROUP BY 
	SP.BusinessEntityID

-- 9 Query to find the customers who have placed more than 10 orders: Write a SQL query to find 
-- the customers who have placed more than 10 orders from the Sales SalesOrderHeader table

SELECT 
	CustomerID, 
	COUNT(SalesOrderID)		AS		'No Of Orders' 
FROM 
	[Sales].[SalesOrderHeader]
GROUP BY 
	CustomerID
HAVING 
	COUNT(SalesOrderID) > 10

-- 10 Query to find the most expensive product in each category: Write a SQL query to find the 
-- most expensive product in each category from the Production Product and Production 
-- ProductSubcategory tables

SELECT 
	P.ProductID, 
	P.Name, 
	SC.ProductCategoryID,
	T1.Expensive
FROM 
	[Production].[Product]				AS	P
INNER JOIN 
	[Production].[ProductSubcategory]	AS	SC	ON SC.ProductSubcategoryID = P.ProductSubcategoryID
INNER JOIN  
(SELECT SC.ProductCategoryID ,MAX(P.ListPrice)	AS 'Expensive'
FROM 
	[Production].[Product]						AS	P
INNER JOIN 
	[Production].[ProductSubcategory]			AS	SC	ON SC.ProductSubcategoryID = P.ProductSubcategoryID
GROUP BY
	SC.ProductCategoryID )						AS	T1	ON T1.ProductCategoryID = SC.ProductCategoryID
AND
	T1.Expensive = P.ListPrice

-- 11 Query to find the total sales for each territory: Write a SQL query to find the total sales for 
-- each territory from the Sales SalesOrderHeader and Sales SalesTerritory tables

SELECT 
	ST.TerritoryID, 
	SUM(SOH.TotalDue)				AS		'Total Sales'
FROM 
	[Sales].[SalesOrderHeader]		AS		SOH
INNER JOIN 
	[Sales].[SalesTerritory]		AS		ST		ON		ST.TerritoryID = SOH.TerritoryID
GROUP BY 
	ST.TerritoryID

-- 12 Query to find the total number of employees in each department: Write a SQL query to find 
-- the total number of employees in each department from the HumanResources 
-- EmployeeDepartmentHistory table

SELECT 
	DepartmentID,
	COUNT(BusinessEntityID)			AS		'No Of Employees'
FROM 
	[HumanResources].[EmployeeDepartmentHistory]
WHERE
	EndDate IS NULL
GROUP BY 
	DepartmentID

-- 13 Query to find the total sales by each customer: Write a SQL query to find the total sales by 
-- each customer from the Sales SalesOrderHeader table

SELECT 
	CustomerID, 
	SUM(TotalDue) AS 'Total Sales'	
FROM 
	[Sales].[SalesOrderHeader]
GROUP BY 
	CustomerID

-- 14 Query to find the most popular product category: Write a SQL query to find the most popular 
-- product category based on the total quantity of products sold from the Sales SalesOrderDetail and 
-- Production Product tables

SELECT 
	SC.ProductCategoryID,
	COUNT(SOD.OrderQty)					AS	   'Total Quantity Sold'
FROM 
	[Sales].[SalesOrderDetail]			AS		SOD
INNER JOIN 
	[Production].[Product]				AS		P		ON P.ProductID = SOD.ProductID
INNER JOIN 
	[Production].[ProductSubcategory]	AS		SC		ON SC.ProductSubcategoryID = P.ProductSubcategoryID
GROUP BY
	SC.ProductCategoryID
ORDER BY
	'Total Quantity Sold' DESC

-- 15 Query to find the total purchase order amount for each vendor: Write a SQL query to find 
-- the total purchase order amount for each vendor from the Purchasing PurchaseOrderHeader table 

SELECT 
	VendorID, 
	SUM(TotalDue)		AS		'Total Order Amount'	
FROM 
	[Purchasing].[PurchaseOrderHeader]
GROUP BY 
	VendorID

-- 16 Query to find the total number of work orders for each product: Write a SQL query to find 
-- the total number of work orders for each product from the Production WorkOrder table

SELECT 
	ProductID, 
	COUNT(WorkOrderID)			AS			'Total Number Of Work Orders' 
FROM 
	[Production].[WorkOrder]
GROUP BY 
	ProductID 

-- 17 Query to find the top 5 products with the highest total sales: Write a SQL query to find the 
-- top 5 products with the highest total sales from the Sales SalesOrderDetail table 

SELECT TOP 5
	ProductID, 
	SUM(LineTotal)		AS		'Total Sales'
FROM 
	[Sales].[SalesOrderDetail]
GROUP BY 
	ProductID

-- 18 Query to find the total sales by year and by product category: Write a SQL query to find the 
-- total sales by year and by product category from the Sales SalesOrderHeader, Sales SalesOrderDetail, 
-- and Production Product tables 

SELECT 
	YEAR(SOH.OrderDate)						AS		'Order Year',
	SC.ProductCategoryID,
	SUM(SOD.LineTotal)						AS		'Total Sales'
FROM 
	[Sales].[SalesOrderHeader]				AS		SOH
INNER JOIN 
	[Sales].[SalesOrderDetail]				AS		SOD			ON		SOD.SalesOrderID = SOH.SalesOrderID
INNER JOIN 
	[Production].[Product]					AS		P			ON		P.ProductID = SOD.ProductID
INNER JOIN 
	[Production].[ProductSubcategory]		AS		SC			ON		SC.ProductSubcategoryID = P.ProductSubcategoryID
GROUP BY
	YEAR(SOH.OrderDate),
	SC.ProductCategoryID
ORDER BY
	YEAR(SOH.OrderDate) DESC

-- 19 Query to find the total quantity of products sold by each salesperson: Write a SQL query to 
-- find the total quantity of products sold by each salesperson from the Sales SalesOrderHeader, Sales 
-- SalesOrderDetail, and Sales SalesPerson tables 

SELECT 
	SP.BusinessEntityID, 
	SUM(SOD.OrderQty)				AS		'Quantity Of Products'	
FROM 
	[Sales].[SalesOrderHeader]		AS		SOH
INNER JOIN 
	[Sales].[SalesOrderDetail]		AS		SOD		ON		SOD.SalesOrderID = SOH.SalesOrderID
INNER JOIN 
	[Sales].[SalesPerson]			AS		SP		ON		SP.BusinessEntityID = SOH.SalesPersonID
GROUP BY 
	SP.BusinessEntityID
ORDER BY 
	SP.BusinessEntityID

-- 20 Query to find the total purchase order amount for each product by year: Write a SQL query 
-- to find the total purchase order amount for each product by year from the Purchasing 
-- PurchaseOrderHeader, Purchasing PurchaseOrderDetail, and Production Product tables 

SELECT 
	P.ProductID,
	YEAR(POH.OrderDate)					AS		'Year',
	SUM(POH.SubTotal)					AS		'Total Purchase Amount'
FROM
	[Purchasing].[PurchaseOrderHeader]	AS		POH
INNER JOIN 
	[Purchasing].[PurchaseOrderDetail]	AS		POD		ON		POD.PurchaseOrderID = POH.PurchaseOrderID
INNER JOIN 
	[Production].[Product]				AS		P		ON		P.ProductID = POD.ProductID
GROUP BY 
	P.ProductID,
	YEAR(POH.OrderDate)
ORDER BY 
	ProductID

-- 21 Query to find the total number of work orders for each product by year: Write a SQL query to 
-- find the total number of work orders for each product by year from the Production WorkOrder table 

SELECT 
	ProductID, 
	COUNT(WorkOrderID)		AS		'Total Number Of Work Orders', 
	YEAR(StartDate)			AS		'YEAR'
FROM 
	[Production].[WorkOrder]
GROUP BY 
	ProductID,
	YEAR(StartDate)
 
-- 22 Query to find the total sales by month and by product category: Write a SQL query to find 
-- the total sales by month and by product category from the Sales SalesOrderHeader, Sales 
-- SalesOrderDetail, and Production Product tables 

SELECT 
	SC.ProductCategoryID,
	DATENAME(MONTH, SOH.OrderDate)					AS		'Month',
	SUM(SOH.SubTotal)								AS		'Total Purchase Amount'
FROM 		
	[Sales].[SalesOrderHeader]						AS		SOH
INNER JOIN 
		[Sales].[SalesOrderDetail]					AS		SOD		ON		SOD.SalesOrderID = SOH.SalesOrderID
INNER JOIN 
	[Production].[Product]							AS		P		ON		P.ProductID = SOD.ProductID
INNER JOIN 
	[Production].[ProductSubcategory]				AS		SC		ON		SC.ProductSubcategoryID = P.ProductSubcategoryID
GROUP BY 
	SC.ProductCategoryID,
	DATENAME(MONTH, SOH.OrderDate)
ORDER BY
	SC.ProductCategoryID

-- 23 Query to find the total quantity of products sold by each sales territory: Write a SQL query to 
-- find the total quantity of products sold by each sales territory from the Sales SalesOrderHeader, Sales 
-- SalesOrderDetail, and Sales SalesTerritory tables 

SELECT 
	SOD.ProductID,
	ST.TerritoryID,
	SUM(SOD.OrderQty)				AS	   'Total Quantity' 
FROM 
	[Sales].[SalesOrderHeader]		AS		SOH
INNER JOIN 
	[Sales].[SalesOrderDetail]		AS		SOD			ON		SOD.SalesOrderID = SOH.SalesOrderID
INNER JOIN 
	[Sales].[SalesTerritory]		AS		ST			ON		ST.TerritoryID = SOH.TerritoryID
GROUP BY 
	SOD.ProductID, 
	ST.TerritoryID
ORDER BY 
	ST.TerritoryID

-- 24 Query to find the total purchase order amount for each product by month: Write a SQL 
-- query to find the total purchase order amount for each product by month from the Purchasing 
-- PurchaseOrderHeader, Purchasing PurchaseOrderDetail, and Production Product tables 

SELECT 
	P.ProductID,
	DATENAME(MONTH, POH.OrderDate)					AS		'Month',
	SUM(POH.SubTotal)								AS		'Total Purchase Amount'
FROM [Purchasing].[PurchaseOrderHeader]				AS		POH
INNER JOIN 
	[Purchasing].[PurchaseOrderDetail]				AS		POD		ON		POD.PurchaseOrderID = POH.PurchaseOrderID
INNER JOIN 
	[Production].[Product]							AS		P		ON		P.ProductID = POD.ProductID
GROUP BY 
	P.ProductID,
	DATENAME(MONTH, POH.OrderDate)
ORDER BY
	P.ProductID

-- 25 Query to find the total number of work orders for each product by month: Write a SQL query 
-- to find the total number of work orders for each product by month from the Production WorkOrder 
-- table

SELECT 
	ProductID, 
	DATENAME(MONTH,StartDate)		AS		'Month',
	COUNT(WorkOrderID)				AS		'Total Number Of Work Orders'
FROM 
	[Production].[WorkOrder]
GROUP BY 
	ProductID,
	DATENAME(MONTH,StartDate)
ORDER BY 
	ProductID

-- 26 Query to find the total sales for each product category by sales territory: Write a SQL query 
-- to find the total sales for each product category by sales territory from the Sales SalesOrderHeader, 
-- Sales SalesOrderDetail, Sales SalesTerritory, and Production Product tables

SELECT 
	SC.ProductCategoryID,
	ST.TerritoryID,
	SUM(SOD.LineTotal)				AS	   'Total Quantity' 
FROM 
	[Sales].[SalesOrderHeader]		AS		SOH
INNER JOIN 
	[Sales].[SalesOrderDetail]		AS		SOD			ON		SOD.SalesOrderID = SOH.SalesOrderID
INNER JOIN 
	[Sales].[SalesTerritory]		AS		ST			ON		ST.TerritoryID = SOH.TerritoryID
INNER JOIN 
	[Production].[Product]			AS		P			ON		P.ProductID = SOD.ProductID
INNER JOIN 
	[Production].[ProductSubcategory] AS	SC			ON		SC.ProductSubcategoryID = P.ProductSubcategoryID
GROUP BY 
	SC.ProductCategoryID, 
	ST.TerritoryID
ORDER BY 
	SC.ProductCategoryID

-- 27 Query to find the total sales by each salesperson: Write a SQL query to find the total sales by 
-- each salesperson from the Sales SalesOrderHeader and Sales SalesPerson tables

SELECT 
	SP.BusinessEntityID, 
	SUM(SOH.TotalDue)				AS		'Total Sales'
FROM 
	[Sales].[SalesOrderHeader]		AS		SOH
INNER JOIN 
	[Sales].[SalesPerson]			AS		SP		ON		SP.BusinessEntityID = SOH.SalesPersonID
GROUP BY 
	SP.BusinessEntityID

-- 28 Query to find the total quantity of products purchased by each vendor: Write a SQL query to 
-- find the total quantity of products purchased by each vendor from the Purchasing 
-- PurchaseOrderHeader, Purchasing PurchaseOrderDetail, and Purchasing Vendor tables

SELECT 
	V.BusinessEntityID,
	SUM(POD.OrderQty)						AS	   'Quantity Of Orders'
FROM 
	[Purchasing].[PurchaseOrderHeader]		AS		POH
INNER JOIN 
	[Purchasing].[PurchaseOrderDetail]		AS		POD		ON		POD.PurchaseOrderID = POH.PurchaseOrderID
INNER JOIN 
	[Purchasing].[Vendor]					AS		V		ON		V.BusinessEntityID = POH.VendorID
GROUP BY
	V.BusinessEntityID

-- 29 Query to find the total number of work orders for each product by year: Write a SQL query to 
-- find the total number of work orders for each product by year from the Production WorkOrder table 

SELECT 
	ProductID, 
	YEAR(StartDate)					AS		'YEAR',
	COUNT(WorkOrderID)				AS		'Total Number Of Work Orders'
FROM 
	[Production].[WorkOrder]
GROUP BY 
	ProductID,
	YEAR(StartDate)
ORDER BY 
	YEAR(StartDate)

-- 30 Query to find the total sales for each product subcategory by sales territory: Write a SQL 
-- query to find the total sales for each product subcategory by sales territory from the Sales 
-- SalesOrderHeader, Sales SalesOrderDetail, Sales SalesTerritory, and Production Product tables

SELECT 
	SC.ProductSubcategoryID,
	ST.TerritoryID,
	SUM(SOD.LineTotal)					AS	   'Total Quantity' 
FROM 
	[Sales].[SalesOrderHeader]			AS		SOH
INNER JOIN 
	[Sales].[SalesOrderDetail]			AS		SOD			ON		SOD.SalesOrderID = SOH.SalesOrderID
INNER JOIN 
	[Sales].[SalesTerritory]			AS		ST			ON		ST.TerritoryID = SOH.TerritoryID
INNER JOIN 
	[Production].[Product]				AS		P			ON		P.ProductID = SOD.ProductID
INNER JOIN 
	[Production].[ProductSubcategory]	AS		SC			ON		SC.ProductSubcategoryID = P.ProductSubcategoryID
GROUP BY 
	SC.ProductSubcategoryID, 
	ST.TerritoryID
ORDER BY 
	SC.ProductSubcategoryID

-- 31 Query to find the total purchase order amount for each product by vendor: Write a SQL 
-- query to find the total purchase order amount for each product by vendor from the Purchasing 
-- PurchaseOrderHeader, Purchasing PurchaseOrderDetail, Purchasing Vendor, and Production Product 
-- tables

SELECT 
	V.BusinessEntityID,
	P.ProductID,
	SUM(POD.LineTotal)						AS	   'Order Amount'
FROM 
	[Purchasing].[PurchaseOrderHeader]		AS		POH
INNER JOIN 
	[Purchasing].[PurchaseOrderDetail]		AS		POD		ON		POD.PurchaseOrderID = POH.PurchaseOrderID
INNER JOIN 
	[Purchasing].[Vendor]					AS		V		ON		V.BusinessEntityID = POH.VendorID
INNER JOIN 
	[Production].[Product]					AS		P		ON		P.ProductID = POD.ProductID
GROUP BY
	V.BusinessEntityID,
	P.ProductID

-- 32 Retrieve the current system date and time.

SELECT 
	SYSDATETIME()		AS		'Current Date Time'

-- 33 List all orders placed after January 1, 2023.

SELECT *								-- OUR DATABASE CONSISTS ONLY DATAS UPTO 2014 SO USING 2014 INSTEAD OF 2023
FROM 
	[Sales].[SalesOrderHeader]
WHERE 
	OrderDate > '2014-01-01' 

-- 34 Find the number of days between the order date and the ship date for each order.

SELECT 
	SalesOrderID,
	OrderDate,
	ShipDate,
	DATEDIFF(DAY,OrderDate,ShipDate)		AS		'No Of Days'
FROM 
	[Sales].[SalesOrderHeader]

-- 35 Retrieve the total number of orders placed in each month of the year 2023.

SELECT 
	DATENAME(MONTH,OrderDate)	AS		'Month', 
	COUNT(SalesOrderID)			AS		'Number Of Orders'
FROM  
	[Sales].[SalesOrderHeader]
WHERE 
	YEAR(OrderDate) IN 
		(SELECT 
			YEAR(MAX(OrderDate)) 
		FROM 
			[Sales].[SalesOrderHeader])
GROUP BY 
	DATENAME(MONTH,OrderDate)

-- 36 List all orders placed on weekends (Saturday or Sunday).

SELECT 
	SalesOrderID, 
	OrderDate
FROM 
	[Sales].[SalesOrderHeader]
WHERE
	DATEPART(DW, OrderDate) IN (1,7)

-- 37 Find the average number of days it took to ship orders for each customer.

SELECT 
	CustomerID, 
	AVG(DATEDIFF(DAY,OrderDate,ShipDate))		AS		'Average Number Of Days' 
FROM 
	[Sales].[SalesOrderHeader]
GROUP BY 
	CustomerID
ORDER BY
	CustomerID

-- 38 Retrieve all orders placed in the last quarter of 2023.

SELECT 
	SalesOrderID, 
	OrderDate  
FROM 
	[Sales].[SalesOrderHeader]
WHERE 
	YEAR(OrderDate) = 2013
AND 
	DATEPART(Q,OrderDate) = 4

-- 39 List all orders placed on weekdays (Monday to Friday) between 9:00 AM and 5:00 PM.

SELECT 
	SalesOrderID, 
	OrderDate
FROM 
	[Sales].[SalesOrderHeader]
WHERE
	(DATEPART(DW, OrderDate) BETWEEN 2 AND 6)
AND 
	(DATEPART(HOUR,OrderDate) BETWEEN 9 AND 17)

-- 40 Find the total sales amount for each month of the year 2023.

SELECT 
	DATENAME(MONTH,OrderDate) AS 'Month', 
	SUM(TotalDue) AS 'Total Sales'
FROM 
	[Sales].[SalesOrderHeader]
WHERE YEAR(OrderDate) IN
		(SELECT 
			YEAR(MAX(OrderDate))
				FROM 
					[Sales].[SalesOrderHeader])
GROUP BY 
DATENAME(MONTH,OrderDate)
ORDER BY 
SUM(TotalDue)

-- 41 Retrieve the orders placed on the same day they were shipped.

SELECT
	SalesOrderID,
	OrderDate,
	ShipDate,
	DATEDIFF(DAY,OrderDate,ShipDate) 'Day Difference'
FROM 
	[Sales].[SalesOrderHeader]
WHERE
	DATEDIFF(DAY,OrderDate,ShipDate) = 0

-- 42 List all orders placed on Mondays.

SELECT * 
FROM 
	[Sales].[SalesOrderHeader]
WHERE
	DATENAME(DW,OrderDate) = 'MONDAY'

-- 43 Find the average time taken to ship orders, excluding weekends.

SELECT  
	AVG(DATEDIFF(HOUR,OrderDate,ShipDate))		AS		'Average Number Of Days' 
FROM 
	[Sales].[SalesOrderHeader]
WHERE
	DATEPART(DW, OrderDate) NOT IN (1,7)
AND
	DATEPART(DW, ShipDate) NOT IN (1,7)

-- 44 Retrieve the number of orders placed in each quarter of the year 2023.

SELECT
	DATEPART(Q,OrderDate)		AS		'Quarter',
	COUNT(SalesOrderID)			AS		'Total No Of Orders' 
FROM 
	[Sales].[SalesOrderHeader]
WHERE
	YEAR(OrderDate) = 2014
GROUP BY
	DATEPART(Q,OrderDate) 

-- 45 List all orders placed on the last day of each month.

SELECT * 
FROM 
	[Sales].[SalesOrderHeader]
WHERE 
	OrderDate = EOMONTH(OrderDate)

-- 46 Retrieve the orders placed exactly one year ago from the current date.

SELECT * 
FROM 
	[Sales].[SalesOrderHeader]
WHERE 
	OrderDate = DATEADD(YEAR,-1,GETDATE())

-- 47 Find the total number of orders placed in each hour of the day.

SELECT 
    DATEPART(HOUR, OrderDate)		AS		'Hour',
    COUNT(SalesOrderID)				AS		TotalOrders
FROM 
    [Sales].[SalesOrderHeader]
GROUP BY 
    DATEPART(HOUR, OrderDate),
	DAY(OrderDate)

-- 48 Retrieve the orders placed in the month of December for each year.

SELECT * 
FROM 
	[Sales].[SalesOrderHeader]
WHERE 
	MONTH(OrderDate) = 12

-- 49 Find the number of days elapsed between the order date and today's date for each order.

SELECT 
	OrderDate, DATEDIFF(DAY, 
	OrderDate, GETDATE())			AS		'Elapsed Date'	
FROM 
	[Sales].[SalesOrderHeader]

-- 50 List all orders placed during the first half of each month.

SELECT *
FROM 
    [Sales].[SalesOrderHeader]
WHERE 
    DATEPART(DAY, OrderDate) <= 15