-- 101 Retrieve the total number of orders and the average order amount for each customer.

SELECT 
	CustomerID, 
	COUNT(SalesOrderID)			AS		'Total Number Of Orders', 
	AVG(TotalDue)				AS		'Average Order Amount'
FROM 
	[Sales].[SalesOrderHeader]
GROUP BY
	CustomerID

-- 102 Find the number of products in each product category along with the average list price of 
-- products within each category.

SELECT 
	SC.ProductCategoryID,
	COUNT(P.ProductID)						AS 'Number Of Products' ,
	AVG(P.ListPrice)						AS 'Average List Price'
FROM 
	[Production].[Product]					AS			P		
INNER JOIN  
	[Production].[ProductSubcategory]		AS			SC		ON		SC.ProductSubcategoryID = P.ProductSubcategoryID
GROUP BY
	SC.ProductCategoryID

-- 103 Retrieve the top 5 customers who have made the highest total purchases.

SELECT 
	TOP 5
	CustomerID, 
	SUM(SubTotal) AS 'Total Purchases'
FROM 
	[Sales].[SalesOrderHeader]
GROUP BY 
	CustomerID 
ORDER BY 
	 'Total Purchases' DESC

-- 104 Find the total number of orders and the total sales amount for each month of the year.

SELECT 
	YEAR(OrderDate)			AS		'Year',
	MONTH(OrderDate)		AS		'Month', 
	COUNT(SalesOrderID)		AS		'Total Number Of Orders',
	SUM(TotalDue)			AS		'Total Sale'
FROM 
	[Sales].[SalesOrderHeader]
GROUP BY 
	YEAR(OrderDate),
	MONTH(OrderDate)
ORDER BY
	YEAR(OrderDate)

-- 105 Retrieve the customer who has made the highest single purchase.

SELECT 
	TOP 1
	CustomerID,
	SubTotal
FROM 
	[Sales].[SalesOrderHeader]
ORDER BY
	SubTotal DESC

-- 106 Find the top 3 best-selling products based on the total quantity sold.

SELECT 
	TOP 3 
	ProductID,
	SUM(OrderQty)		AS		'Total Quantity Sold'
FROM 
	[Sales].[SalesOrderDetail]
GROUP BY
	ProductID
ORDER BY 
	SUM(OrderQty) DESC

-- 107 Retrieve the average number of days it took to ship orders for each customer

SELECT 
	CustomerID,
	AVG(DATEDIFF(DAY,OrderDate,ShipDate))		AS		'Avg Days'
FROM 
	[Sales].[SalesOrderHeader]
GROUP BY
	CustomerID
ORDER BY
	CustomerID

-- 108 Find the number of orders placed by each customer in the year 2023 along with their total 
-- purchase amount.

SELECT 
	CustomerID,
	COUNT(SalesOrderID)		AS		'Number Of Orders',
	SUM(SubTotal)			AS		'Total Purchase'
FROM 
	[Sales].[SalesOrderHeader]
WHERE 
	YEAR(OrderDate) = 2014
GROUP BY 
	CustomerID
ORDER BY 
	CustomerID

-- 109 Retrieve the total sales amount for each product category.

SELECT 
	SC.ProductCategoryID,
	SUM(SOD.LineTotal)					AS	   'Total Sales'
FROM 
	[Sales].[SalesOrderDetail]			AS		SOD
INNER JOIN 
	[Production].[Product]				AS		P		ON P.ProductID = SOD.ProductID
INNER JOIN 
	[Production].[ProductSubcategory]	AS		SC		ON SC.ProductSubcategoryID = P.ProductSubcategoryID
GROUP BY
	SC.ProductCategoryID

-- 110 Find the number of orders placed on each day of the week along with the average order 
-- amount.

SELECT
	DATEPART(WEEKDAY,OrderDate)			AS		'Day',
	DATENAME(WEEKDAY,OrderDate)			AS		'DayName',
	COUNT(SalesOrderID)					AS		'NumberOfOrders',
	AVG(TotalDue)						AS		'AverageAmount'
FROM 
	Sales.SalesOrderHeader
GROUP BY
	DATENAME(WEEKDAY,OrderDate),
	DATEPART(WEEKDAY,OrderDate)
ORDER BY 
	'Day'

-- 111 Retrieve the top 3 sales representatives based on the total sales amount generated from 
-- their orders.

SELECT 
	TOP 3
	SalesPersonID,
	COUNT(SalesOrderID)			AS			'No Of Sales',
	SUM(SubTotal)				AS			'Total Sales'
FROM 
	[Sales].[SalesOrderHeader]
GROUP BY
	SalesPersonID
ORDER BY
	SUM(SubTotal) DESC

-- 112 Find the average quantity of products sold per order.

SELECT 
	SalesOrderID,
	AVG(OrderQty)			AS			'Average Quantity Of Products'
FROM 
	[Sales].[SalesOrderDetail]
GROUP BY
	SalesOrderID

-- 113 Retrieve the top 5 customers who have the highest average order amount.

SELECT 
	TOP 5
	CustomerID,
	AVG(SubTotal)				AS			'Average Order Amount'
FROM 
	[Sales].[SalesOrderHeader]
GROUP BY
	CustomerID
ORDER BY
	AVG(SubTotal) DESC

-- 114 Find the number of orders placed by each customer along with their total purchase amount 
-- and rank them within each category based on the total purchase amount.

SELECT 
	CustomerID,
	COUNT(SalesOrderID)													AS		'Number Of Orders',
	SUM(SubTotal)														AS		'Total Purchase Amount',
	RANK() OVER(PARTITION BY CustomerID ORDER BY SUM(SubTotal))			AS		'Rank'
FROM 
	[Sales].[SalesOrderHeader]
GROUP BY
	CustomerID

SELECT 
	CustomerID,
	COUNT(SalesOrderID) AS 'Number Of Orders',
	SUM(SubTotal) AS 'Total Purchase Amount',
	RANK() OVER(ORDER BY SUM(SubTotal) DESC) AS 'Rank'
FROM 
	[Sales].[SalesOrderHeader]
GROUP BY
	CustomerID
ORDER BY
	'Rank';


-- 115 Retrieve the product category with the highest total sales amount.

SELECT 
	TOP 1
	SC.ProductCategoryID,
	SUM(SOD.LineTotal)							AS		'Total Sales Amount'
FROM 
	[Sales].[SalesOrderHeader]					AS		SOH
INNER JOIN 
	[Sales].[SalesOrderDetail]					AS		SOD			ON		SOD.SalesOrderID = SOH.SalesOrderID
INNER JOIN 
	[Production].[Product]						AS		P			ON		P.ProductID = SOD.ProductID
INNER JOIN 
	[Production].[ProductSubcategory]			AS		SC			ON		SC.ProductSubcategoryID = P.ProductSubcategoryID
GROUP BY
	SC.ProductCategoryID
ORDER BY
	SC.ProductCategoryID DESC

-- 116 Find the median order amount for each month.

SELECT 
    A.Month,
    COUNT(1)/2 AS 'HalfCount',
    COUNT(1)/2 + 1 AS 'HalfCountPlusOne'
FROM (
    SELECT 
        MONTH(OrderDate) AS 'Month', 
        ROW_NUMBER() OVER(PARTITION BY TotalDue ORDER BY MONTH(OrderDate)) AS RN,
        COUNT(1) OVER(PARTITION BY TotalDue) AS C
    FROM [Sales].[SalesOrderHeader]
) A
GROUP BY A.Month


WITH Ranked AS (
		SELECT
			DATENAME(MONTH,OrderDate)													AS		'Month',
			TotalDue,
			ROW_NUMBER() OVER (PARTITION BY MONTH(OrderDate) ORDER BY TOTALDUE ASC)		AS		'Postition',
			COUNT(TotalDue) OVER (PARTITION BY MONTH(OrderDate))						AS		'TotalCountByMonth'	
		FROM 
			Sales.SalesOrderHeader 
				)
SELECT 
	*,
	FLOOR((TotalCountByMonth + 1) / 2),CEILING((TotalCountByMonth + 1) / 2)
FROM 
	Ranked
WHERE
	Postition IN (FLOOR((TotalCountByMonth + 1) / 2),CEILING((TotalCountByMonth + 1) / 2))

-- 117 Retrieve the top 3 product categories with the highest average sales amount per order.

WITH CTE AS
(
SELECT
	SOD.SalesOrderID,
	C.Name							AS		'Category',
	AVG(SOD.LineTotal)				AS		'TotalSales',
	RANK()OVER(PARTITION BY SOD.SalesOrderID ORDER BY AVG(SOD.LineTotal) DESC) AS 'Rank'
FROM 
	Sales.SalesOrderDetail			AS		SOD
JOIN
	Production.Product				AS		P		ON SOD.ProductID = P.ProductID
JOIN
	Production.ProductSubcategory	AS		SC		ON	P.ProductSubcategoryID = SC.ProductSubcategoryID
JOIN
	Production.ProductCategory		AS		C		ON	SC.ProductCategoryID = C.ProductCategoryID
GROUP BY 
	C.Name,
	SOD.SalesOrderID
)
SELECT * 
FROM 
	CTE 
WHERE 
	Rank <=3
ORDER BY 
	SalesOrderID

-- 118 Find the customers who have made at least 5 orders and have spent more than $5000 in 
-- total, and list them in descending order of their total purchase amount.

SELECT 
	CustomerID,
	COUNT(SalesOrderID)			AS		'Number Of Orders',	
	SUM(SubTotal)				AS		'Total Purchase Amount'
FROM 
	[Sales].[SalesOrderHeader]
GROUP BY 
	CustomerID
HAVING
	SUM(SubTotal) > 5000
AND
	COUNT(SalesOrderID) >=5
ORDER BY
	SUM(SubTotal) DESC

-- 119 Retrieve the top 5 sales representatives who have the highest average sales amount per 
-- order.

SELECT 
	TOP 5
	SalesPersonID,
	AVG(SubTotal)			AS			'Average Sales Amount'
FROM 
	[Sales].[SalesOrderHeader]
GROUP BY 
	SalesPersonID
ORDER BY 
	AVG(SubTotal) DESC

-- 120 Find the number of orders placed in each quarter of the year along with the total sales 
-- amount for each quarter.

SELECT
	DATEPART(Q,OrderDate)		AS		'QUARTER',
	COUNT(SalesOrderID)			AS		'Number Of Orders',
	SUM(SubTotal)				AS		'Total Sales'
FROM
	[Sales].[SalesOrderHeader]
GROUP BY
	DATEPART(Q,OrderDate)
ORDER BY
	DATEPART(Q,OrderDate)

-- 121 Retrieve the order date in the format 'YYYY-MM-DD' for all orders.

SELECT 
	SalesOrderID,
	FORMAT(OrderDate,'yyyy-MM-dd')		AS		'Formated Date'
FROM 
	[Sales].[SalesOrderHeader]

-- 122 Convert the list price of products to integer values.

SELECT 
	ProductID, 
	CAST(ListPrice AS INT)			AS		'Converted List Price'
FROM
	[Production].[Product]

-- 123 Retrieve the order quantity as floating-point numbers for all orders.

SELECT 
	ProductID,
	CAST(OrderQty AS float)			AS		'Float',
	FORMAT(OrderQty ,'0.00')		AS		'Float1'
FROM 
	[Sales].[SalesOrderDetail]

-- 124 Convert the order date to the day of the year (1-365) for all orders.

SELECT 
	SalesOrderID, 
	DATEPART(DAYOFYEAR,OrderDate) AS 'Day Of The Year'
FROM 
	[Sales].[SalesOrderHeader]

-- 125 Retrieve the last modification date of products in the format 'DD-MM-YYYY HH:MI:SS'.

SELECT 
	ProductID, 
	ModifiedDate,
	FORMAT(ModifiedDate,'dd-MM-yyyy HH:mm:ss') AS 'Formated Date'
FROM 
	[Production].[Product]

-- 126 Convert the order status code to its corresponding description for all orders.

SELECT *,
CASE
	WHEN Status = 1			THEN		'In process'
	WHEN Status = 2			THEN		'Approved'
	WHEN Status = 3			THEN		'Backordered'
	WHEN Status = 4			THEN		'Rejected'
	WHEN Status = 5			THEN		'Shipped'
	WHEN Status = 6			THEN		'Cancelled'
END 'Order Status'
FROM
	[Sales].[SalesOrderHeader]

-- 127 Retrieve the ship date as a date without time for all orders.

SELECT 
	SalesOrderID, 
	CONVERT(DATE,ShipDate) AS 'Ship Date As A Date'
FROM 
	[Sales].[SalesOrderHeader]

-- 128 Convert the birth date of employees to their corresponding age.

SELECT 
	BusinessEntityID,
	BirthDate,
	DATEDIFF(YEAR,BirthDate,GETDATE())		AS		'AGE'
FROM 
	[HumanResources].[Employee]

-- 129 Retrieve the total due amount of orders as currency formatted strings.

SELECT 
	SalesOrderID,
	FORMAT(TotalDue,'C', 'EN-IN')		AS		'Currency'
FROM
	[Sales].[SalesOrderHeader]

-- 130 Convert the product weight from pounds to kilograms.

SELECT 
    ProductID,
CASE 
	WHEN WeightUnitMeasureCode = 'LB'		THEN		Weight * 0.453592 
ELSE 
	Weight
END 
	WeightInKilograms
FROM 
    Production.Product

-- 131 Retrieve the order date and ship date of orders, converting them to the format 'YYYY-MM-DD 
-- HH:MM:SS'.

SELECT 
	SalesOrderID,
	OrderDate,
	FORMAT(OrderDate,'yyyy-MM-dd HH:mm:ss')			AS		'Conveted Order Date',
	ShipDate,
	FORMAT(ShipDate,'yyyy-MM-dd HH:mm:ss')			AS		'Conveted Ship Date'
FROM 
	[Sales].[SalesOrderHeader]

-- 132 List all products whose list prices are converted to euros (assuming 1 USD = 0.84 EUR), 
-- rounded to two decimal places.

SELECT 
	ProductID,
	FORMAT(ListPrice,'C')								AS		'USD',
	FORMAT(ROUND((ListPrice*0.84),2),'C','EN-GB')		AS		'Euro'
FROM 
	[Production].[Product]

-- 133 Retrieve the total sales amount of each order, converting it to a monetary format with 
-- commas and two decimal places.

SELECT 
	SalesOrderID,
	SubTotal,
	FORMAT(SubTotal,'N','EN-US') AS 'Monetary Format'
FROM [Sales].[SalesOrderHeader]

-- 134 Find the age of employees, converting their birth dates to years.

SELECT 
	BusinessEntityID,
	BirthDate,
	YEAR(BirthDate)							AS		'Birth Year',
	DATEDIFF(YEAR,BirthDate,GETDATE())		AS		'AGE'
FROM 
	[HumanResources].[Employee]

-- 135 Retrieve the date and time of each order, converting them to the format 'DayOfWeek, Month 
-- Day, Year HH:MM AM/PM'.

SELECT 
	SalesOrderID,
	orderdate,
	CONCAT(DATENAME(DW,OrderDate),
	',',
	DATENAME(MONTH,OrderDate),
	' ',
	DATEPART(DAY,OrderDate),
	',', YEAR(OrderDate),
	',',
	FORMAT(OrderDate,' hh:mm:tt'))			AS		'Converted Format'			
FROM 
	[Sales].[SalesOrderHeader]

-- 136 List all products whose weights are converted to kilograms (assuming 1 pound = 0.45359237 
-- kilograms), rounded to two decimal places.

SELECT 
    ProductID,
CASE 
	WHEN WeightUnitMeasureCode = 'LB'		THEN		ROUND((Weight * 0.45359237),2)
ELSE 
	Weight
END 
	WeightInKilograms

FROM 
    Production.Product


SELECT 
    ProductID,
CASE 
	WHEN WeightUnitMeasureCode = 'LB'		THEN		FORMAT(Weight * 0.45359237,'0.00')
ELSE 
	Weight
END 
	WeightInKilograms

FROM 
    Production.Product

-- 137 Retrieve the total sales amount of each order, converting it to scientific notation. 

SELECT 
	SalesOrderID,
	TotalDue,
	FORMAT(TotalDue, 'E2') AS 'Scientific Notation'
FROM
	[Sales].[SalesOrderHeader]

-- 138 Find the length of product names, converting the lengths to binary format.

SELECT 
	Name,
	LEN(Name)						AS		'Name Length',
	CAST(LEN(Name) AS VARBINARY)	AS		'Binary'
FROM [Production].[Product]

SELECT 
	Name,
	LEN(Name)						AS		'Name Length',
	CAST(LEN(Name) AS BINARY)		AS		'Binary'
FROM [Production].[Product]

-- 139 Retrieve the hire date of employees, converting them to the format 'Day, Month DD, YYYY'.

SELECT 
	BusinessEntityID,
	HireDate,
	CONCAT(
	DATENAME(DW,HireDate),' ',DATENAME(MONTH,HireDate),' ',DATEPART(DAY,HireDate), ' ',YEAR(HireDate))		AS		'Converted Date'
FROM 
	[HumanResources].[Employee]

-- 140 List all products whose dimensions (height, width, depth) are converted to cubic 
-- centimeters.(Question Doubt)

-- 141 Retrieve the orders where the total amount is greater than $1000 and less than $2000.

SELECT 
	SalesOrderID,
	TotalDue 
FROM 
	[Sales].[SalesOrderHeader]
WHERE 
	TotalDue
BETWEEN
	1000 AND 2000

-- 142 List all products that are either in category 'Bikes' or have a list price greater than $1000.

SELECT 
	C.ProductCategoryID,
	C.Name,
	P.ListPrice
FROM 
	[Production].[Product]				AS		P		
INNER JOIN 
	[Production].[ProductSubcategory]	AS		SC		ON SC.ProductSubcategoryID = P.ProductSubcategoryID
INNER JOIN 
	[Production].[Productcategory]		AS		C		ON C.ProductcategoryID = SC.ProductcategoryID
WHERE
	C.Name = 'BIKES'
OR
	P.ListPrice > 1000
ORDER BY
	C.ProductCategoryID

-- 143 Retrieve the orders where the ship date is NULL or the difference between the order date 
-- and ship date is greater than 7 days.

SELECT 
	SalesOrderID,
	OrderDate,
	ShipDate,
	DATEDIFF(DAY,OrderDate,ShipDate)		AS		'Date Difference'
FROM 
	[Sales].[SalesOrderHeader]
WHERE
	ShipDate IS NULL
OR
	DATEDIFF(DAY,OrderDate,ShipDate) > 7

-- 144 Find the employees who have either 'Sales Representative' or 'Sales Manager' as their job 
-- title.

SELECT 
	BusinessEntityID,
	JobTitle
FROM 
	[HumanResources].[Employee]
WHERE
	JobTitle = 'Sales Representative'
OR
	JobTitle = 'Sales Manager'

-- 145 Retrieve the orders where the customer has a credit limit greater than $5000 and the 
-- payment due is not yet received.(No Credit Limit)


-- 146 List all products with a list price less than $500 but not in the 'Accessories' category.

SELECT 
	C.ProductCategoryID,
	C.Name,
	P.ListPrice
FROM 
	[Production].[Product]				AS		P		
INNER JOIN 
	[Production].[ProductSubcategory]	AS		SC		ON SC.ProductSubcategoryID = P.ProductSubcategoryID
INNER JOIN 
	[Production].[Productcategory]		AS		C		ON C.ProductcategoryID = SC.ProductcategoryID
WHERE
	P.ListPrice < 1000
AND
	C.Name != 'Accessories'
ORDER BY
	C.ProductCategoryID

-- 147 Retrieve the orders where the payment due date is before the ship date or the payment due 
-- amount is greater than the total due amount. (No Payment Due Amount)

SELECT 
	SalesOrderID, 
	DueDate, 
	ShipDate 
FROM 
	[Sales].[SalesOrderHeader]
WHERE
	DueDate < ShipDate

-- 148 Find the employees who started working after January 1, 2015, and are not in the 
-- 'Production Technician' role.

SELECT * 
FROM 
	[HumanResources].[Employee]
WHERE 
	HireDate > '2013-01-01'
AND
	JobTitle != 'Production Technician'

-- 149 Retrieve the orders where the payment due date is not in the future and the payment status 
-- is not 'Paid'.

SELECT 
	SalesOrderID,
	DueDate
FROM 
	[Sales].[SalesOrderHeader]
WHERE
	DueDate < GETDATE()

-- 150 List all customers whose email address is either null or contains 'gmail.com'.

SELECT 
*
FROM 
	[Person].[EmailAddress]
WHERE
	EmailAddress IS NULL 
OR
	EmailAddress LIKE '%gmail.com'
	