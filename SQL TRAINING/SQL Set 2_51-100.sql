-- 51 Retrieve the orders placed in the first and last weeks of each month.

SELECT 
	SalesOrderID, 
	OrderDate 
FROM 
	[Sales].[SalesOrderHeader]
WHERE 
	DAY(OrderDate) <= 7 
OR
	DAY(OrderDate) > DAY(EOMONTH(OrderDate)) - 7

-- 52 Retrieve the top 5 customers who have the longest average time between placing an order 
-- and receiving it.

SELECT 
	TOP 5
	CustomerID,
	AVG(DATEDIFF(HOUR,OrderDate,DueDate))		AS		'AVG Time'
FROM
	[Sales].[SalesOrderHeader]
GROUP BY 
	CustomerID
ORDER BY
	CustomerID DESC

-- 53 Find the total sales amount for each month of the year 2023, including orders that haven't 
-- been shipped yet.

SELECT 
	DATENAME(MONTH,OrderDate) AS 'Month', 
	SUM(TotalDue) AS 'Total Sales'
FROM 
	[Sales].[SalesOrderHeader]
WHERE 
	YEAR(OrderDate) = 2014
OR
	ShipDate IS NULL
GROUP BY 
DATENAME(MONTH,OrderDate)
ORDER BY 
SUM(TotalDue)

-- 54 Retrieve the orders placed by customers who have placed orders on consecutive days.

WITH cte AS (
  SELECT CustomerId,OrderDate,
         CASE
           WHEN LEAD(OrderDate) OVER (PARTITION BY CustomerId ORDER BY OrderDate) IS NULL THEN NULL
           ELSE DATEDIFF(DAY, OrderDate, LEAD(OrderDate) OVER (PARTITION BY CustomerId ORDER BY OrderDate))
         END AS Day_gap
  FROM [Sales].[SalesOrderHeader]
)
SELECT CustomerId,OrderDate
FROM cte
WHERE Day_gap = 1
GROUP BY CustomerId,OrderDate



SELECT DISTINCT CUSTOMERID
	FROM 
	(
	SELECT TOP 100 PERCENT CustomerID, OrderDate, 
	Lead(OrderDate,1) OVER(PARTITION BY CustomerID ORDER BY OrderDate asc) LeadDate,
	DateAdd(day,1,OrderDate) AddDate
	FROM Sales.SalesOrderHeader
	ORDER BY CustomerID asc ,OrderDate asc
	) AS X
	WHERE X.LeadDate = X.AddDate


/*
SELECT CustomerID,YEAR(OrderDate),MONTH(OrderDate), CONVERT(DATE,OrderDate) FROM [Sales].[SalesOrderHeader] 
WHERE YEAR(OrderDate) = 2014
GROUP BY CustomerID, YEAR(OrderDate),MONTH(OrderDate),CONVERT(DATE,OrderDate)
ORDER BY CustomerID*/

-- 55 List all orders placed on holidays (e.g., New Year's Day, Christmas Day).



-- 56 Retrieve the orders placed on weekdays (Monday to Friday) where the order was shipped on 
-- the next business day.

SELECT SalesOrderID ,OrderDate, ShipDate FROM [Sales].[SalesOrderHeader]
WHERE DATEPART(DW,OrderDate) NOT IN (1,7)
AND DATEPART(DW,ShipDate) NOT IN (1,7)

SELECT SalesOrderID ,OrderDate, ShipDate FROM [Sales].[SalesOrderHeader]
WHERE DATEPART(DW,OrderDate) NOT IN (1,7)
AND DATEADD(DAY,1,OrderDate)  = ShipDate

-- 57 Find the total sales amount for each weekday (Monday to Sunday) for the year 2023.

SELECT 
    DATENAME(DW, OrderDate)				AS		Weekday,
    SUM(TotalDue)						AS		TotalSalesAmount
FROM 
    [Sales].[SalesOrderHeader]
WHERE 
    YEAR(OrderDate) = 2014
GROUP BY 
    DATENAME(DW, OrderDate)

-- 58 Retrieve the orders placed by customers who haven't placed any orders in the year 2023.

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
	YEAR(OrderDate) = '2014'
)

-- 59 Find the average time taken to ship orders for each product category.

SELECT 
	SC.ProductCategoryID, 
	AVG(DATediff(HOUR,OrderDate,Shipdate))		AS		'Avg Time'
FROM 
	[Sales].[SalesOrderDetail]				AS		SOD
INNER JOIN 
	[Sales].[SalesOrderHeader]				AS		SOH			ON		SOH.SalesOrderID		=	SOD.SalesOrderID
INNER JOIN 
	[Production].[Product]					AS		P			ON		P.ProductID				=	SOD.ProductID
INNER JOIN 
	[Production].[ProductSubcategory]		AS		SC			ON		SC.ProductSubcategoryID =	P.ProductSubcategoryID
GROUP BY 
	SC.ProductCategoryID

-- 60 Retrieve the orders placed on the last business day of each month.

SELECT
	SalesOrderID, 
	DATENAME(DW,EOMONTH(OrderDate))		AS		'Day',
	EOMONTH(OrderDate)					AS		'Last Business Day'
FROM 
	[Sales].[SalesOrderHeader]
WHERE 
	DATENAME(DW,EOMONTH(OrderDate)) 
IN
(
	SELECT 
		DATENAME(DW,EOMONTH(OrderDate)) 
	FROM	
		[Sales].[SalesOrderHeader] 
	WHERE	
		DATENAME(DW,EOMONTH(OrderDate)) 
	NOT IN 
		('SUNDAY','SATURDAY')
)


SELECT *
	FROM Sales.SalesOrderHeader
	WHERE OrderDate BETWEEN DATEADD(DAY,-2,EOMONTH(ORDERDATE)) AND EOMONTH(OrderDate) 
	AND DATEPART(WEEKDAY,OrderDate) NOT IN (7,1)


WITH LastBusinessDays AS (
    SELECT 
        SalesOrderID,
        OrderDate,
        ROW_NUMBER() OVER (PARTITION BY YEAR(OrderDate), MONTH(OrderDate) ORDER BY OrderDate DESC) AS rn
    FROM 
        Sales.SalesOrderHeader
    WHERE 
        DATENAME(DW, OrderDate) NOT IN ('Saturday', 'Sunday')
)
SELECT 
   *
FROM 
    LastBusinessDays
WHERE 
    rn = 1
-- 61 Find the number of orders placed in each hour of the day, considering only orders placed 
-- between 9:00 AM and 5:00 PM.

SELECT 
	DATEPART(HOUR,OrderDate)		AS		'Hour Of The Day',
	COUNT(SalesOrderID)				AS		'No Of Orders'
FROM 
	[Sales].[SalesOrderHeader]
WHERE
	DATEPART(HOUR,OrderDate) BETWEEN 9 AND 17
GROUP BY
	DATEPART(HOUR,OrderDate)

-- 62 Retrieve the top 3 customers who have the highest total sales amount in each quarter of the 
-- year 2023.

WITH CUSRANK AS
(
SELECT 
	CustomerID,
	DATEPART(Q,OrderDate) AS 'Quarter',
	SUM(TotalDue) AS 'Total Sales',
	ROW_NUMBER() OVER(PARTITION BY DATEPART(Q,OrderDate) ORDER BY SUM(TotalDue) DESC) AS 'Rank'
FROM 
	[Sales].[SalesOrderHeader]
WHERE
	YEAR(OrderDate) = 2013
GROUP BY
	DATEPART(Q,OrderDate),
	CustomerID
)
SELECT * FROM CUSRANK 
WHERE Rank <= 3

-- 63 Find the average time taken to ship orders for each customer, considering only orders placed 
-- in the second half of the year.

SELECT 
    MONTH(OrderDate)							AS		'Avg Second Half Months',
	AVG(DATediff(HOUR,OrderDate,Shipdate))		AS		'Hour Of The Day',
	COUNT(SalesOrderID)							AS		'No Of Orders'
FROM 
	[Sales].[SalesOrderHeader]
WHERE
	MONTH(OrderDate) > 6
GROUP BY
	MONTH(OrderDate)

-- 64 Retrieve the orders placed by customers who have placed orders on all weekdays (Monday 
-- to Friday) of the week.

SELECT 
	*
FROM 
	[Sales].[SalesOrderHeader]
WHERE 
	CustomerID 
IN
(
	SELECT 
		CustomerID 
	FROM 
		[Sales].[SalesOrderHeader]
	WHERE 
		DATEPART(DW,OrderDate) 
	IN 
		(2,3,4,5,6)
	GROUP BY 
		CustomerID
	HAVING 
		COUNT(DISTINCT DATEPART(WEEKDAY, OrderDate)) = 5
)

-- 65 List all orders placed on the first business day of each month.

WITH ROWNUM AS
(
SELECT
	SalesOrderID, 
	DATENAME(DW,OrderDate)		AS		'Day',
	OrderDate					AS		'First Business Day',
	ROW_NUMBER() OVER (PARTITION BY YEAR(OrderDate), MONTH(OrderDate) ORDER BY OrderDate) AS 'Rank'
FROM 
	[Sales].[SalesOrderHeader]
WHERE
	DATENAME(DW,OrderDate) NOT IN  ('SATURDAY','SUNDAY')
) 
SELECT * FROM ROWNUM WHERE RANK=1

-- 66 Retrieve the orders placed on weekends (Saturday or Sunday) where the order was shipped 
-- on the next business day.

SELECT 
	SalesOrderID,
	DATENAME(WEEKDAY,OrderDate)			AS		'Day',
	OrderDate,
	ShipDate
FROM
	Sales.SalesOrderHeader
WHERE
	DATEPART(WEEKDAY,OrderDate)			
IN	
	(7,1)	
AND
	DATEDIFF(DAY,OrderDate,ShipDate) = 1	
AND 
	DATEPART(WEEKDAY, ShipDate)
BETWEEN		
	2 AND 6

-- 67 Find the total sales amount for each product category for orders placed on the first Monday 
-- of each month.

SELECT 
	SC.ProductCategoryID,
	DATENAME(DW, SOH.OrderDate)						AS		'Day',
	SUM(SOD.LineTotal)								AS		'Total Purchase Amount'
FROM 		
	[Sales].[SalesOrderHeader]						AS		SOH
INNER JOIN 
		[Sales].[SalesOrderDetail]					AS		SOD		ON		SOD.SalesOrderID = SOH.SalesOrderID
INNER JOIN 
	[Production].[Product]							AS		P		ON		P.ProductID = SOD.ProductID
INNER JOIN 
	[Production].[ProductSubcategory]				AS		SC		ON		SC.ProductSubcategoryID = P.ProductSubcategoryID
WHERE 
	SOH.OrderDate
IN
(
	SELECT 
		OrderDate
	FROM 
		[Sales].[SalesOrderHeader]
	WHERE
		DATEPART(DW, OrderDate) = 2
	AND
		DAY(OrderDate) <= 7		
)
GROUP BY
	SC.ProductCategoryID,
	DATENAME(DW, SOH.OrderDate)

-- 68 Retrieve the orders placed on the same day of the week as the current date.

SELECT 
    SalesOrderID,
    OrderDate,
	DATENAME(DW,OrderDate)		AS		'Day' 
FROM 
    [Sales].[SalesOrderHeader]
WHERE 
    DATEPART(DW, OrderDate) = DATEPART(DW, GETDATE())

-- 69 Find the average number of days between placing an order and shipping it, grouped by the 
-- year and month of the order date.  

SELECT 
	CustomerID,
	AVG(DATEDIFF(DAY,OrderDate,ShipDate)) AS 'Avg Days'
FROM 
	[Sales].[SalesOrderHeader]
GROUP BY 
	YEAR(OrderDate),
	MONTH(OrderDate),
	CustomerID

-- 70 Retrieve the orders placed by customers who have not placed any orders in the last 90 days.

SELECT 
	DISTINCT SOH.CustomerID, 
	SOH.SalesOrderID				
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
	OrderDate >= DATEADD(DAY,-90,(SELECT MAX(OrderDate) FROM [Sales].[SalesOrderHeader]))
)

-- 71 Find the total sales amount for each hour of the day, considering only orders placed on 
-- weekdays (Monday to Friday).

SELECT 
	DATEPART(HOUR,OrderDate)		AS		'Hour', 
	SUM(TotalDue)					AS		'Total Sales'
FROM 
	[Sales].[SalesOrderHeader]
WHERE 
	DATENAME(DW,OrderDate) 
NOT IN
	('SATURDAY','SUNDAY')
GROUP BY 
	DATEPART(HOUR,OrderDate)

-- 72 Retrieve the first name and last name of employees, concatenating them with a space in 
-- between.

SELECT 
	E.BusinessEntityID,
	CONCAT(P.FirstName,' ',P.LastName)	AS		'Emplyee Name'
FROM 
	[HumanResources].[Employee]			AS		E
INNER JOIN  
	[Person].[Person]					AS		P		ON		P.BusinessEntityID = E.BusinessEntityID

-- 73 List all products whose names contain the word "bike".

SELECT * 
FROM 
	[Production].[Product]
WHERE 
	Name 
LIKE
	'%bike%'

-- 74 Retrieve the email addresses of customers, ensuring they are in lowercase.

SELECT 
	C.CustomerID, 
	EA.EmailAddress,
CASE
	WHEN LOWER(EA.EmailAddress) = EA.EmailAddress COLLATE Latin1_General_BIN THEN 'Lower Case'
	ELSE 'Upper Case'
	END 'Lower Or Upper'
FROM 
	[Sales].[Customer]				AS		C
INNER JOIN 
	[Person].[EmailAddress]			AS		EA		ON		EA.BusinessEntityID = C.CustomerID

-- 75 Find the length of the product names.

SELECT 
	ProductID, 
	Name, 
	LEN(Name)		AS		'Length'
FROM 
	[Production].[Product]

-- 76 List all customers whose names start with the letter "A".

SELECT 
	C.CustomerID,
	CONCAT(P.FirstName,' ',P.LastName)		AS		'Customer Name'
FROM 
	[Sales].[Customer]						AS		C
INNER JOIN 
	[Person].[Person]						AS		P		ON		P.BusinessEntityID = C.CustomerID
WHERE
	CONCAT(P.FirstName,' ',P.LastName)		LIKE	'A%'

-- 77 Retrieve the first 3 characters of each product's name.

SELECT 
	ProductID,
	Name, 
	LEFT(Name,3)			AS			'First 3 Characters'
FROM 
	[Production].[Product]

-- 78 Find the position of the first occurrence of the letter "o" in each product's name.

SELECT 
	Name,
	CHARINDEX('O',Name)			AS		'Occurance Position' 
FROM
	[Production].[Product]

-- 79 List all customers whose names contain exactly 5 characters.

SELECT 
	C.CustomerID, 
	P.FirstName 
FROM 
	[Sales].[Customer]		AS		C
INNER JOIN 
	[Person].[Person]		AS		P		ON		P.BusinessEntityID = C.CustomerID
WHERE 
	LEN(P.FirstName) = 5
	 
-- 80 Retrieve the last 4 characters of each product's name.

SELECT 
	NAME, 
	RIGHT(NAME,4)			AS			'Last Character'
FROM
	[Production].[Product]

-- 81 Find the product names in uppercase.

SELECT 
	Name,
CASE
	WHEN Name = UPPER(Name)	COLLATE Latin1_General_BIN THEN 'Upper Case'
	ELSE 'Lower Case'	
	END 'Upper Or Lower'
FROM 
	[Production].[Product]

SELECT Name
FROM [Production].[Product]
WHERE Name = UPPER(Name) COLLATE Latin1_General_BIN

-- 82 Retrieve the first name and last name of employees, ensuring that each name starts with an 
-- uppercase letter followed by lowercase letters.


SELECT 
	E.BusinessEntityID,
	PF.FirstName, 
	PL.LastName,
CASE
	WHEN PF.FirstName = CONCAT(UPPER(LEFT(PF.FirstName, 1)), LOWER(SUBSTRING(PF.FirstName, 2, LEN(PF.FirstName) - 1)))  THEN 'Upper Ensured'
	ELSE 'Not Ensured'
	END 'First',
CASE
	WHEN PL.LastName = CONCAT(UPPER(LEFT(PL.LastName, 1)), LOWER(SUBSTRING(PL.LastName, 2, LEN(PL.LastName) - 1)))  THEN 'Lower Ensured'
	ELSE 'Not Ensured'
	END 'Last'
FROM 
	[HumanResources].[Employee] AS E
INNER JOIN 
	[Person].[Person] AS PF ON PF.BusinessEntityID = E.BusinessEntityID
INNER JOIN 
	[Person].[Person] AS PL ON PL.BusinessEntityID = E.BusinessEntityID

-- 83 List all products whose names are longer than the average length of product names.

SELECT 
	ProductID, 
	Name,
	LEN(Name)		AS		'Length'
FROM 
	[Production].[Product]
WHERE
	LEN(Name) > (SELECT AVG(LEN(Name)) FROM [Production].[Product])

-- 84 Retrieve the email addresses of customers, splitting them into username and domain parts.

SELECT P.EmailAddress ,
    LEFT( P.EmailAddress, CHARINDEX('@',  P.EmailAddress) - 1) AS UserName,
    RIGHT( P.EmailAddress, LEN( P.EmailAddress) - CHARINDEX('@',  P.EmailAddress)) AS Domain 
	FROM Person.EmailAddress P
INNER JOIN 
Sales.Customer S 
ON P.BusinessEntityID = S.CustomerID

-- 85 Find the product names along with the number of words in each name.

SELECT 
    Name AS ProductName,
    LEN(Name) - LEN(REPLACE(Name, ' ', '')) + 1		AS			'NumberOfWords'
FROM 
    Production.Product

SELECT 
    Name AS ProductName,
	LEN(Name) - LEN(REPLACE(REPLACE(Name, '-', '') , ' ', '')) + 1  AS NumberOfWords
FROM 
    Production.Product

-- 86 List all customers whose names contain at least two words.

SELECT 
	C.CustomerID,
	CONCAT(P.FirstName,' ',P.LastName)																		AS		'Name',
	LEN(CONCAT(P.FirstName,' ',P.LastName)) - LEN(REPLACE(CONCAT(P.FirstName,' ',P.LastName),' ',''))+1		AS		'Count'
FROM 
	[Sales].[Customer] AS C
INNER JOIN 
	[Person].[Person] AS P ON P.BusinessEntityID = C.CustomerID
WHERE
	LEN(CONCAT(P.FirstName,' ',P.LastName)) - LEN(REPLACE(CONCAT(P.FirstName,' ',P.LastName),' ','')) >= 1

-- 87 Retrieve the product names with the last word removed.

SELECT 
    Name,
    LEFT(Name, LEN(Name) - CHARINDEX(' ', REVERSE(Name))) AS 'Name Without Last Word'
FROM 
    [Production].[Product]

-- 88 Find the position of the second occurrence of the letter "e" in each product's name.

SELECT 
	Name,
	CHARINDEX('E',Name,CHARINDEX('E',Name)+1)		AS		'Position'
FROM 
	[Production].[Product]

-- 89 List all customers whose names end with the letter "n" and have exactly two words in their 
-- names.

SELECT 
	C.CustomerID,
	CONCAT(P.FirstName,' ',P.LastName)		AS		'Customer Name'
FROM 
	[Sales].[Customer] AS C
INNER JOIN 
	[Person].[Person] AS P ON P.BusinessEntityID = C.CustomerID
WHERE
	RIGHT(CONCAT(P.FirstName,' ',P.LastName),1) = 'N'
AND
	LEN(CONCAT(P.FirstName,' ',P.LastName)) - LEN(REPLACE(CONCAT(P.FirstName,' ',P.LastName),' ','')) = 1

-- 90 Retrieve the product names sorted in descending order based on the number of vowels in 
-- each name.

SELECT 
	Name,
	LEN(NAME) - LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( Name, 'A',''),'E',''),'I',''),'O',''),'U','')) AS 'Number Of Vowels'
FROM 
	[Production].[Product]
ORDER BY 
	'Number Of Vowels' DESC

-- 91 Retrieve the product names with the words reversed within each name.

SELECT NAME,REVERSE(Name) FROM [Production].[Product]

SELECT NAME,REPLACE(Name,1,2) FROM [Production].[Product]

SELECT 
Name AS OriginalProductName,( SELECT STRING_AGG(REVERSE(value), ' ') WITHIN GROUP (ORDER BY pos)
FROM (SELECT value,
ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS pos
From STRING_SPLIT(Name, ' ') ) AS words) AS ReversedProductName
FROM Production.Product

-- 92 Retrieve the product names along with the number of vowels in each name.

SELECT 
	Name,
	LEN(NAME) - LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( Name, 'A',''),'E',''),'I',''),'O',''),'U','')) AS 'Number Of Vowels'
FROM 
	[Production].[Product]

-- 93 List all customers whose email addresses contain a domain ending with ".com".

SELECT 
	C.CustomerID, 
	EA.EmailAddress 
FROM 
	[Sales].[Customer]			AS		C
INNER JOIN 
	[Person].[EmailAddress]		AS		EA		ON		EA.BusinessEntityID = C.PersonID
WHERE 
	RIGHT(EA.EmailAddress,4) = '.com'
	
SELECT 
	C.CustomerID, 
	EA.EmailAddress 
FROM 
	[Sales].[Customer]			AS		C
INNER JOIN 
	[Person].[EmailAddress]		AS		EA		ON EA.BusinessEntityID = C.PersonID
WHERE 
	EA.EmailAddress LIKE '%.com'

-- 94 Retrieve the first name and last name of employees, reversing their names.

SELECT 
	P.FirstName,
	P.LastName,
	REVERSE(CONCAT(P.FirstName,' ',P.LastName))				AS		'Reversed Name',
	CONCAT(REVERSE(P.FirstName),' ',REVERSE(P.LastName))	AS		'Reversed Name 1'
FROM 
	[HumanResources].[Employee] AS E
INNER JOIN 
	[Person].[Person] AS P ON P.BusinessEntityID = E.BusinessEntityID

-- 95 Find the product names along with the number of characters in each name excluding spaces.

SELECT 
	Name,
	LEN(REPLACE(NAME,' ','')) AS 'Number Of Characters'
FROM 
	[Production].[Product]

-- 96 Retrieve the email addresses of customers, extracting the domain name part.

SELECT 
	C.PersonID,
	LEFT(EmailAddress,CHARINDEX('@',EmailAddress)-1)		AS		'UserName',
	RIGHT(EmailAddress,CHARINDEX('@',EmailAddress)-1)		AS		'Domain Name'
FROM 
	[Sales].[Customer]										AS		C
INNER JOIN 
	[Person].[EmailAddress]									AS		EA			ON		EA.BusinessEntityID = C.PersonID

-- 97 List all customers whose names contain a palindrome (a word that reads the same forwards 
-- and backwards).

 SELECT 
	 C.PersonID,
	 CONCAT(P.FirstName,' ',P.LastName)				AS		'Customer Name',
	 REVERSE(CONCAT(P.FirstName,' ',P.LastName))	AS		'Reversed Name'
 FROM 
	[Sales].[Customer]							AS		C
 INNER JOIN 
	[Person].[Person]							AS		P		ON		C.PersonID = P.BusinessEntityID
WHERE
	CONCAT(P.FirstName,P.LastName) = REVERSE(CONCAT(P.FirstName,P.LastName))	

-- 98 Retrieve the product names with each word capitalized (title case).

SELECT 
	Name, 
	CONCAT(UPPER(LEFT(NAME,1)))

FROM [Production].[Product]

-- 99 List all customers whose names contain more vowels than consonants.

SELECT 
	CONCAT(P.FirstName, P.LastName)				AS		'Customer Name',
	LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( CONCAT(P.FirstName, '', P.LastName), 'A',''),'E',''),'I',''),'O',''),'U','')) 
												AS		'Number Of Consonants',
	LEN(CONCAT(P.FirstName, P.LastName)) - LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( CONCAT(P.FirstName, '', P.LastName), 'A',''),'E',''),'I',''),'O',''),'U',''))
												AS		'Number Of Vowels'
FROM 
	[Sales].[Customer] 
												AS		C	
INNER JOIN
	[Person].[Person] 
												AS		P		ON		P.BusinessEntityID = C.PersonID
WHERE 
	LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( CONCAT(P.FirstName, P.LastName), 'A',''),'E',''),'I',''),'O',''),'U',''))  
	<
	LEN(CONCAT(P.FirstName, P.LastName)) - LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( CONCAT(P.FirstName, '', P.LastName), 'A',''),'E',''),'I',''),'O',''),'U',''))

-- 100 Retrieve the product names along with the number of times the letter "s" appears in each 
-- name.

SELECT 
	Name,
	LEN(Name) - LEN(REPLACE(Name,'S','')) AS 'Number Of Times'
FROM 
	[Production].[Product]
ORDER BY
	'Number Of Times' DESC

