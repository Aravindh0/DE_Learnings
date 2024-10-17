-- 151 Retrieve the orders where the total amount is greater than $1000 or the payment status is 
-- 'Partial'.

SELECT 
	SalesOrderID,
	SUM(TotalDue) AS 'Total Amount'
FROM 
	[Sales].[SalesOrderHeader]
GROUP BY
	SalesOrderID
HAVING 
	SUM(TotalDue) > 1000

-- 152 List all products that are either out of stock or have a list price greater than $2000.

SELECT * 
FROM 
	[Production].[Product] AS P
INNER JOIN 
	[Production].[WorkOrder] AS W ON W.ProductID = P.ProductID
WHERE 
	W.StockedQty = 0
OR 
	P.ListPrice > 2000

SELECT * 
FROM 
	[Production].[Product]
WHERE 
	SafetyStockLevel = 0
OR 
	ListPrice >= 2000

-- 153 Retrieve the orders where the ship date is NULL and the payment status is not 'Paid'.

SELECT 
	SalesOrderID,
	ShipDate
FROM 
	[Sales].[SalesOrderHeader]
WHERE
	ShipDate IS NULL

-- 154 Find the employees who have either 'Sales Representative' or 'Sales Manager' as their job 
-- title and have a salary greater than $50000.

SELECT * FROM [HumanResources].[Employee]
SELECT * FROM  [HumanResources].[EmployeePayHistory]

-- 155 Retrieve the orders where the payment due date is before the ship date or the payment 
-- status is 'Overdue'.


-- 156 List all products with a list price less than $500 but not in the 'Bikes' category.

SELECT 
	P.ProductID,
	C.Name,
	P.ListPrice 
FROM 
	[Production].[Product]				AS		P
INNER JOIN 
	[Production].[ProductSubcategory]	AS		SC		ON		SC.ProductSubcategoryID = P.ProductSubcategoryID
INNER JOIN 
	[Production].[ProductCategory]		AS		C		ON		C.ProductcategoryID = SC.ProductcategoryID
WHERE
	P.ListPrice < 500
AND
	C.Name != 'Bikes'

-- 157 Retrieve the orders where the payment due date is not in the future or the payment status is 
-- 'Pending'.

SELECT * 
FROM 
	[Sales].[SalesOrderHeader]
WHERE 
	DueDate > GETDATE()

-- 158 Find the employees who started working after January 1, 2015, and have a job title other 
-- than 'Sales Manager'.

SELECT* 
FROM 
	[HumanResources].[Employee]
WHERE 
	HireDate > '01-01-2013'
AND
	JobTitle != 'Sales Manager'

-- 159 Retrieve the orders where the payment due date is not in the past and the payment status is 
-- not 'Paid' or 'Partial'.

SELECT * 
FROM 
	[Sales].[SalesOrderHeader]
WHERE 
	DueDate < OrderDate

-- 160 List all customers whose email address is either null or contains 'hotmail.com' but not 
-- 'gmail.com'.

SELECT
* 
FROM 
	[Person].[EmailAddress]
WHERE
	EmailAddress IS NULL
OR
	EmailAddress LIKE '%hotmail.com%'
AND
	EmailAddress NOT LIKE '%gmail.com%'

-- 161 Of course! Here are 10 more complex-level practice questions involving logical functions in 
-- SQL: (Not A Question)

-- 162 Retrieve the orders where the total amount is greater than $5000 and the payment status is 
-- either 'Pending' or 'Partial'.

SELECT 
	SalesOrderID, 
	TotalDue
FROM
	[Sales].[SalesOrderHeader]
WHERE
	TotalDue > 5000

-- 163 List all products that are either in stock or have a list price greater than $1500 and belong to 
-- the 'Road Bikes' category.

SELECT * 
FROM 
	[Production].[Product] AS P
INNER JOIN
	[Production].[ProductSubcategory] AS SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
WHERE 
	(P.SafetyStockLevel > 0
OR
	P.ListPrice = 1500)
AND
	SC.Name = 'Road Bikes'

-- 164 Retrieve the orders where the ship date is NULL and the payment status is 'Pending', or the 
-- payment due amount is greater than $500.

SELECT * 
FROM 
	[Sales].[SalesOrderHeader]
WHERE
	ShipDate IS NULL
OR
	TotalDue  > 500


-- 165 Find the employees who have 'Senior' in their job title or have a salary greater than $80000.

SELECT * 
FROM 
	[HumanResources].[Employee]
WHERE 
	JobTitle LIKE '%Senior%'

-- 166 Retrieve the orders where the payment due date is before the ship date and the payment 
-- status is 'Overdue', or the total amount is greater than $10000.

SELECT 
	SalesOrderID,
	DueDate,
	ShipDate,
	TotalDue
FROM 
	[Sales].[SalesOrderHeader]
WHERE
	DueDate < ShipDate
OR
	TotalDue > 10000

-- 167 List all products with a list price less than $1000 but not in the 'Components' category.

SELECT 
	P.ProductID,
	C.Name,
	P.ListPrice
FROM 
	[Production].[Product] AS P
INNER JOIN
	[Production].[ProductSubcategory] AS SC ON SC.ProductSubcategoryID = P.ProductSubcategoryID
INNER JOIN
	[Production].[ProductCategory] AS C ON C.ProductCategoryID = SC.ProductCategoryID
WHERE
	P.ListPrice < 1000
AND
	C.Name != 'Components'

-- 168 Retrieve the orders where the payment due date is in the future or the payment status is 
-- either 'Pending' or 'Partial'.

SELECT *
FROM
	[Sales].[SalesOrderHeader]
WHERE
	DueDate >= DATEADD(DAY,2,GETDATE())

-- 169 Find the employees who started working after January 1, 2018, and are not in the 
-- 'Marketing' department.

SELECT 
	E.BusinessEntityID,
	E.HireDate,
	D.Name
FROM [HumanResources].[Employee] AS E
INNER JOIN
	[HumanResources].[EmployeeDepartmentHistory] AS EDH ON EDH.BusinessEntityID = E.BusinessEntityID
INNER JOIN	
	[HumanResources].[Department] AS D ON D.DepartmentID = EDH.DepartmentID
WHERE 
	HireDate > '01/01/2013'
AND
	D.Name != 'Marketing'

-- 170 Retrieve the orders where the payment due date is not in the past and the payment status is 
-- not 'Paid' and not 'Pending'.

SELECT * 
FROM 
	[Sales].[SalesOrderHeader]
WHERE 
	DueDate < OrderDate

-- 171 List all customers whose email address is either null or contains 'yahoo.com' and does not 
-- contain 'gmail.com'.

SELECT
* 
FROM 
	[Person].[EmailAddress]
WHERE
	(EmailAddress IS NULL
OR
	EmailAddress LIKE '%yahoo.com%')
AND
	EmailAddress NOT LIKE '%gmail.com%'

-- 172 Retrieve the sales order ID, order date, and the running total sales amount for each order, 
-- sorted by order date.

SELECT 
	SalesOrderID,
	OrderDate,
	TotalDue,
	SUM(TotalDue) OVER (PARTITION BY OrderDate ORDER BY SalesOrderID) AS 'Running Total',
	SUM(TotalDue) OVER ( ORDER BY OrderDate)
	FROM 
	[Sales].[SalesOrderHeader]

SELECT 
	SalesOrderID,
	OrderDate,
	TotalDue,
	SUM(TotalDue) OVER (PARTITION BY OrderDate ORDER BY OrderDate) AS 'Running Total'
FROM 
	[Sales].[SalesOrderHeader]

-- 173 Find the product ID, name, and the cumulative sum of quantities sold for each product, 
-- ordered by product ID.

SELECT 
	P.ProductID,
	P.Name,
	--OrderQty,
	SUM(SOD.OrderQty) OVER (PARTITION BY P.ProductID ORDER BY  P.ProductID) AS 'Cumulative Sum'
	,SUM(SOD.OrderQty) OVER ( ORDER BY  P.ProductID)
FROM 
	[Sales].[SalesOrderDetail] AS SOD
INNER JOIN
	[Production].[Product] AS P ON P.ProductID = SOD.ProductID

-- 174 Retrieve the employee ID, hire date, and the running count of employees hired over time, 
-- ordered by hire date.

SELECT 
	BusinessEntityID,
	HireDate
FROM 
	[HumanResources].[Employee]

-- 175 Find the sales order ID, order date, and the rank of each order based on the total sales 
-- amount, ordered by order date.

SELECT 
	SalesOrderID,
	OrderDate,
	TotalDue,
	RANK()OVER(ORDER BY TotalDue DESC,OrderDate)		AS		RANK
FROM [Sales].[SalesOrderHeader]

-- 176 Retrieve the customer ID, order date, and the percentage of total sales amount contributed 
-- by each order, ordered by order date.

SELECT
	CustomerID,
	OrderDate,
	TotalDue,
	(TotalDue/(SELECT SUM(TotalDue) FROM [Sales].[SalesOrderHeader]))*100 AS 'Percentage Of Total Sales Amount'
FROM
	[Sales].[SalesOrderHeader]

-- 177 List the product ID, name, and the difference between the current row's list price and the 
-- average list price of all products, ordered by product ID.

SELECT 
	ProductID,
	Name,
	ListPrice,
	ListPrice - (SELECT AVG(ListPrice) FROM [Production].[Product])			AS		'Difference'
FROM
	[Production].[Product] 
ORDER BY
	ProductID

-- 178 Retrieve the employee ID, hire date, and the average number of employees hired per year, 
-- ordered by hire date.

WITH AverageCount AS (
    SELECT 
        YEAR(HireDate)								AS	HireYear,
        COUNT( BusinessEntityID)					AS	EmployeesHired,
        AVG(COUNT( BusinessEntityID)) OVER ()		AS	AvgEmployeesPerYear
    FROM 
        HumanResources.Employee
    GROUP BY				
        YEAR(HireDate)
)
SELECT 
    E.BusinessEntityID								AS		EmployeeID,
    E.HireDate,
    AC.AvgEmployeesPerYear
FROM 
    HumanResources.Employee							AS		E
JOIN 
    AverageCount									AS		AC		ON	YEAR(E.HireDate) = AC.HireYear
ORDER BY 
	E.HireDate

-- 179 Find the sales order ID, order date, and the running total of sales amount for each year, 
-- ordered by order date.

SELECT 
	SalesOrderID,
	OrderDate,
	TotalDue,
	SUM(TotalDue) OVER (PARTITION BY YEAR(OrderDate) ORDER BY SalesOrderID) AS 'Running Total'
FROM 
	[Sales].[SalesOrderHeader]

select SalesOrderID,OrderDate ,TOTALDUE,SUM(TotalDue)over(partition by year(orderdate)order by salesorderid) from Sales.SalesOrderHeader


-- 180 Retrieve the product ID, name, and the percentage of total revenue generated by each 
-- product, ordered by product ID.

SELECT
	SOD.ProductID,
	P.Name																				AS		'ProductName',
	(SUM(SOD.LineTotal) / (SELECT SUM(LineTotal) FROM Sales.SalesOrderDetail)) * 100	AS		'PercentageOfRevenue'
FROM 
	Sales.SalesOrderDetail																AS		SOD
JOIN
	Production.Product																	AS		P		ON	SOD.ProductID = P.ProductID
GROUP BY
	SOD.ProductID,
	P.Name
ORDER BY
	SOD.ProductID
-- 181 List the employee ID, hire date, and the average tenure of employees hired in the same year, 
-- ordered by hire date.

WITH EmployeeTenure AS (
    SELECT 
        BusinessEntityID,
        HireDate,
        DATEDIFF(YEAR, HireDate, GETDATE())					AS		Tenure
    FROM 
        HumanResources.Employee
)
SELECT 
    E.BusinessEntityID,
    E.HireDate,
    AVG(T.Tenure) OVER (PARTITION BY YEAR(E.HireDate))		AS		AverageTenure
FROM 
   HumanResources.Employee									AS		E
JOIN 
    EmployeeTenure											AS		T		ON		E.BusinessEntityID = T.BusinessEntityID
ORDER BY 
    E.HireDate

-- 182 Retrieve the sales order ID, order date, and the difference in total sales amount from the 
-- previous order, ordered by order date.

WITH PreviousOrder AS
(SELECT 
	SalesOrderID,
	OrderDate,
	TotalDue,
	LAG(TotalDue) OVER (ORDER BY SalesOrderID) AS 'Lag'
FROM 
	[Sales].[SalesOrderHeader])
SELECT 
	SOH.SalesOrderID,
	SOH.OrderDate,
	SOH.TotalDue,
	SOH.TotalDue - PO.Lag AS 'Difference'
FROM
	[Sales].[SalesOrderHeader] AS SOH
INNER JOIN
	PreviousOrder AS PO ON PO.SalesOrderID = SOH.SalesOrderID

-- 183 Find the product ID, name, and the rank of each product based on the total quantity sold, 
-- ordered by product ID.

WITH QTY AS
(
SELECT 
	ProductID,
	SUM(OrderQty) AS 'TotalQty'
FROM 
	[Sales].[SalesOrderDetail] 
GROUP BY
	ProductID
	)
SELECT 
	P.ProductID,
	P.Name,
	RANK()OVER(ORDER BY Q.TotalQty DESC)		AS		RANK
FROM 
	[Production].[Product] AS P
INNER JOIN 
	QTY AS Q ON Q.ProductID = P.ProductID

-- 184 Retrieve the employee ID, hire date, and the number of employees hired in the same year as 
-- each employee, ordered by hire date.

SELECT 
    E.BusinessEntityID,
    E.HireDate,
    COUNT(E.BusinessEntityID) OVER (PARTITION BY YEAR(E.HireDate))		AS		EmployeesHired
FROM 
   HumanResources.Employee												AS		E
ORDER BY
	E.HireDate

-- 185 Find the sales order ID, order date, and the sum of total sales amount for the last 3 orders, 
-- ordered by order date.

SELECT 
	SalesOrderID,
	OrderDate,
	TotalDue,
	SUM(TotalDue)OVER(ORDER BY OrderDate ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING )
FROM
	[Sales].[SalesOrderHeader]

-- 186 Retrieve the product ID, name, and the average list price of products within the same 
-- subcategory, ordered by product ID.

SELECT
    ProductID,
    Name,
    AVG(ListPrice) OVER (PARTITION BY ProductSubcategoryID)			AS		'AverageListPrice'
FROM
    [Production].[Product]
ORDER BY
    ProductID

-- 187 List the employee ID, hire date, and the difference in years between the hire date of each 
-- employee and the earliest hire date.

SELECT
    BusinessEntityID,
    HireDate,
    DATEDIFF(YEAR, MIN(HireDate) OVER (), HireDate)				AS		'Difference In Years'
FROM
    [HumanResources].[Employee]

-- 188 Retrieve the sales order ID, order date, and the average of total sales amount for the last 5 
-- orders, ordered by order date.

SELECT 
	SalesOrderID,
	OrderDate,
	TotalDue,
	SUM(TotalDue)OVER(ORDER BY OrderDate ROWS BETWEEN 5 PRECEDING AND 1 PRECEDING )
FROM
	[Sales].[SalesOrderHeader]

-- 189 Find the product ID, name, and the difference in quantity sold from the previous order for 
-- each product, ordered by product ID.

WITH QtyDiff AS (
    SELECT
        P.ProductID,
        P.Name,
        OrderQty - LAG(OrderQty) OVER (PARTITION BY P.ProductID ORDER BY SOH.OrderDate)			AS		QuantityDifference
    FROM
        Sales.SalesOrderDetail																	AS		SOD
	INNER JOIN	
		[Sales].[SalesOrderHeader]																AS		SOH			ON		SOH.SalesOrderID = SOD.SalesOrderID
    INNER JOIN 
		Production.Product																		AS		P			ON		P.ProductID = SOD.ProductID
)
SELECT
    ProductID,
    Name,
    QuantityDifference
FROM
    QtyDiff
ORDER BY
    ProductID

-- 190 Retrieve the employee ID, hire date, and the running total of employee count for each hire 
-- year, ordered by hire date.
-- 191 List the product ID, name, and the average list price of products in the same category, 
-- ordered by product ID.

SELECT
    P.ProductID,
    P.Name,
    AVG(ListPrice) OVER (PARTITION BY C.ProductCategoryID)		AS		'AverageListPrice'
FROM
    [Production].[Product]										AS		P
INNER JOIN
	[Production].[ProductSubcategory]							AS		SC			ON		SC.ProductSubcategoryID =P.ProductSubcategoryID
INNER JOIN 
	[Production].[ProductCategory]								AS		C			ON		C.ProductCategoryID = SC.ProductCategoryID
ORDER BY
    ProductID

-- 192 Retrieve the product ID, name, and assign a unique row number to each product, ordered by 
-- product name.

SELECT
    ProductID,
    Name,
    ROW_NUMBER() OVER (ORDER BY Name)		AS		 RowNumber
FROM
    [Production].[Product]
ORDER BY
    Name

-- 193 List the employee ID, hire date, and assign a rank to each employee based on their hire date, 
-- ordered by hire date.

SELECT
    BusinessEntityID,
    HireDate,
    RANK() OVER (ORDER BY HireDate)			AS		'Rank'
FROM
    [HumanResources].[Employee]
ORDER BY
    HireDate

-- 194 Retrieve the customer ID, order date, and assign a dense rank to each customer based on 
-- their order date, ordered by order date.

SELECT
    CustomerID,
    OrderDate,
    DENSE_RANK() OVER (ORDER BY OrderDate)		AS		'DenseRank'
FROM
    [Sales].[SalesOrderHeader]
ORDER BY
    OrderDate

-- 195 Find the sales order ID, order date, and assign a unique row number to each order, 
-- partitioned by the sales person ID and ordered by order date.

SELECT
    SalesOrderID,
    OrderDate,
    ROW_NUMBER() OVER (PARTITION BY SalesPersonID ORDER BY OrderDate)		AS		'RowNumber'
FROM
    [Sales].[SalesOrderHeader]

-- 196 Retrieve the product ID, name, and assign a rank to each product based on the list price, 
-- partitioned by the product category, ordered by product name.

SELECT
    P.ProductID,
    P.Name,
    RANK() OVER (PARTITION BY c.ProductCategoryID ORDER BY ListPrice)		AS		'Rank'
FROM
     [Production].[Product]													AS		P
INNER JOIN
	[Production].[ProductSubcategory]										AS		SC		ON		SC.ProductSubcategoryID =P.ProductSubcategoryID
INNER JOIN 
	[Production].[ProductCategory]											AS		C		ON		C.ProductCategoryID = SC.ProductCategoryID
ORDER BY
    p.Name

-- 197 List the employee ID, hire date, and assign a dense rank to each employee based on the 
-- department ID, ordered by hire date.

SELECT
    E.BusinessEntityID,
    E.HireDate,
    D.DepartmentID,
    DENSE_RANK() OVER (PARTITION BY D.DepartmentID ORDER BY HireDate)		AS		'DenseRank'
FROM
    [HumanResources].[Employee]												AS		E
INNER JOIN
	[HumanResources].[EmployeeDepartmentHistory]							AS		EDH			ON		EDH.BusinessEntityID = E.BusinessEntityID
INNER JOIN
	[HumanResources].[Department]											AS		D			ON		D.DepartmentID = EDH.DepartmentID
ORDER BY
    E.HireDate


-- 198 Retrieve the product ID, name, and assign a unique row number to each product, partitioned 
-- by the product subcategory, ordered by product ID.

SELECT
    ProductID,
    Name,
    ProductSubcategoryID,
    ROW_NUMBER() OVER (PARTITION BY ProductSubcategoryID ORDER BY ProductID)		AS		'RowNumber'
FROM
    [Production].[Product]

-- 199 Find the sales order ID, order date, and assign a rank to each order based on the total due 
-- amount, ordered by order date.

SELECT
    SalesOrderID,
    OrderDate,
    RANK() OVER (ORDER BY TotalDue,OrderDate)			AS		'Rank'
FROM
    [Sales].[SalesOrderHeader]

-- 200 Retrieve the product ID, name, and assign a dense rank to each product based on the weight, 
-- ordered by product ID.

SELECT
    ProductID,
    Name,
    Weight,
    DENSE_RANK() OVER (ORDER BY Weight)			AS		'DenseRank'
FROM
    [Production].[Product]
ORDER BY
    ProductID

-- 201 List the employee ID, hire date, and assign a unique row number to each employee, 
-- partitioned by the job title, ordered by hire date.

SELECT 
    BusinessEntityID,
    HireDate,
    ROW_NUMBER() OVER (PARTITION BY JobTitle ORDER BY HireDate)			AS		'RowNumber'
FROM 
    [HumanResources].[Employee]

-- 202 Retrieve the sales order ID, order date, and the row number of each order within its 
-- customer, ordered by order date.

SELECT 
    SalesOrderID,
    OrderDate,
    ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate)			AS		'RowNumber'
FROM 
    [Sales].[SalesOrderHeader]

-- 203 Find the product ID, name, and the dense rank of each product based on the total quantity 
-- sold, ordered by product ID.

SELECT 
    ProductID,
    Name,
    DENSE_RANK() OVER (ORDER BY TotalQuantitySold DESC)			AS		'DenseRank'
FROM (
    SELECT 
        P.ProductID,
        P.Name,
        SUM(sod.OrderQty)										AS		TotalQuantitySold
    FROM 
        [Production].[Product]									AS		P
    INNER JOIN 
        [Sales].[SalesOrderDetail]								AS		SOD			ON		P.ProductID = SOD.ProductID
    GROUP BY 
        P.ProductID, P.Name
)																AS		ProductSales
ORDER BY 
    ProductID

-- 204 Retrieve the employee ID, hire date, and the rank of each employee based on their hire year, 
-- ordered by hire date.

SELECT 
    BusinessEntityID,
    HireDate,
    RANK() OVER (PARTITION BY YEAR(HireDate) ORDER BY HireDate)			AS		'Rank'
FROM 
    [HumanResources].[Employee]

-- 205 Find the product ID, name, and the row number of each product based on the list price, 
-- ordered by product ID.

SELECT 
    ProductID,
    Name,
    ROW_NUMBER() OVER (ORDER BY ListPrice,ProductID)		AS		'RowNumber'
FROM 
    [Production].[Product]

-- 206 Retrieve the sales order ID, order date, and the rank of each order based on the total sales 
-- amount, ordered by order date.

SELECT 
    SalesOrderID,
    OrderDate,
    RANK() OVER (ORDER BY SUM(TotalDue) DESC, OrderDate)		AS		'Rank'
FROM 
    [Sales].[SalesOrderHeader]
GROUP BY 
    SalesOrderID,
    OrderDate

-- 207 List the employee ID, hire date, and the dense rank of each employee based on the years of 
-- experience, ordered by hire date.

SELECT 
    BusinessEntityID,
    HireDate,
    DENSE_RANK() OVER (ORDER BY DATEDIFF(YEAR, HireDate, GETDATE()),HireDate)		AS		'DenseRank'
FROM 
    [HumanResources].[Employee]

-- 208 Retrieve the product ID, name, and the row number of each product within its category, 
-- ordered by product ID.

SELECT 
    P.ProductID,
    P.Name,
    ROW_NUMBER() OVER (PARTITION BY SC.ProductCategoryID ORDER BY P.ProductID)		AS		'RowNumber'
FROM 
    [Production].[Product]															AS		P
INNER JOIN
	[Production].[ProductSubcategory]												AS		SC		ON		SC.ProductSubcategoryID = P.ProductSubcategoryID

-- 209 Find the sales order ID, order date, and the rank of each order based on the order year, 
-- ordered by order date.

SELECT 
    SalesOrderID,
    OrderDate,
    RANK() OVER (PARTITION BY YEAR(OrderDate) ORDER BY OrderDate)		AS		'Rank'
FROM 
    [Sales].[SalesOrderHeader]

-- 210 Retrieve the customer ID, order date, and the dense rank of each customer based on the 
-- total sales amount, ordered by order date

SELECT 
    CustomerID,
    OrderDate,
    DENSE_RANK() OVER (PARTITION BY CustomerID ORDER BY SUM(TotalDue) DESC)			AS		'DenseRank'
FROM 
    [Sales].[SalesOrderHeader]
GROUP BY 
    CustomerID, OrderDate
ORDER BY 
    OrderDate

-- 211 List the employee ID, hire date, and the row number of each employee within its 
-- department, ordered by hire date.

SELECT 
    E.BusinessEntityID,
    E.HireDate,
    ROW_NUMBER() OVER (PARTITION BY D.DepartmentID ORDER BY E.HireDate)			AS		'RowNumber'
FROM 
    [HumanResources].[Employee]													AS		E
INNER JOIN
	[HumanResources].[EmployeeDepartmentHistory]								AS		EDH			ON		EDH.BusinessEntityID = E.BusinessEntityID
INNER JOIN
	[HumanResources].[Department]												AS		D			ON		D.DepartmentID = EDH.DepartmentID

