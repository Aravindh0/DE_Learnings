-- Create the table in schema1
create schema schema1
CREATE TABLE schema1.sales (
    id INT,
    product_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10, 2)
)

-- Create the table in schema2
create schema schema2

CREATE TABLE schema2.sales (
    id INT,
    product_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10, 2)
)

-- Insert data into schema1.sales
INSERT INTO schema1.sales (id, product_name, quantity, price)
VALUES
    (1, 'Product A', 10, 50.00),
    (2, 'Product B', 5, 30.00),
    (3, 'Product C', 8, 20.00),
	(4, 'Product D', 10, 30.00)

-- Insert the data into schema2.sales

INSERT INTO schema2.sales (id, product_name, quantity, price)
VALUES
    (1, 'Product A', 10, 100.00),
    (2, 'Product B', 6, 300.00),
    (3, 'Product C', 8, 20.00),
	(4, 'Product D', 10, 30.00)

select * from schema1.sales --Source
select * from schema2.sales --Target

-- Working on SCD Type 1

Merge into
	schema2.sales as target
Using
	schema1.sales as source
On
	target.id = source.id
When matched then
	update 
		set
		target.id = source.id,
		target.product_name = source.product_name,
		target.quantity = source.quantity,
		target.price = source.price
When not matched then
	INSERT (id, product_name, quantity, price)
	values(source.id, source.product_name, source.quantity, source.price);



-- Update existing rows
UPDATE schema2.sales
SET product_name = source.product_name,
    quantity = source.quantity,
    price = source.price
FROM schema2.sales AS target
INNER JOIN schema1.sales AS source ON target.id = source.id;

-- Insert new rows
INSERT INTO schema2.sales (id, product_name, quantity, price)
SELECT id, product_name, quantity, price
FROM schema1.sales AS source
WHERE NOT EXISTS (
    SELECT 1
    FROM schema2.sales AS target
    WHERE target.id = source.id
);

-- SCD Type 2 

CREATE TABLE schema1.Employee (
    EmployeeID INT ,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DateOfBirth DATE,
    Gender CHAR(1),
    DepartmentID INT,
    IsActive BIT
)

CREATE TABLE schema2.Employee (
    EmployeeID INT ,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DateOfBirth DATE,
    Gender CHAR(1),
    DepartmentID INT
);

INSERT INTO schema1.Employee (EmployeeID, FirstName, LastName, DateOfBirth, Gender, DepartmentID, IsActive)
VALUES 
    (1, 'John', 'Doe', '1990-05-15', 'M', 1, 1),
    (2, 'Jane', 'Smith', '1985-09-22', 'F', 2, 1),
    (3, 'Michael', 'Johnson', '1982-03-10', 'M', 1, 1),
    (4, 'Emily', 'Williams', '1993-11-28', 'F', 2, 1);


INSERT INTO schema2.Employee (EmployeeID, FirstName, LastName, DateOfBirth, Gender, DepartmentID)
VALUES 
    (1, 'Jack', 'Doe', '1990-05-15', 'M', 1),
    (2, 'Jane', 'Smith', '1985-09-22', 'F', 1),
    (3, 'Miraj', 'Johnson', '1982-03-10', 'M', 1),
    (4, 'Clara', 'Williams', '1993-11-28', 'F', 2),
	(5, 'Adam', 'Dol', '1990-05-15', 'M', 2),
    (6, 'Randy', 'Ortan', '1985-09-22', 'M', 1);

update schema2.Employee
set firstname='Rand'
where employeeid = 6

select * from schema1.Employee --Target
select * from schema2.Employee --Source

Merge into
	schema1.Employee as T
Using
	schema2.Employee as S
On
	T.EmployeeID = S.EmployeeID
When matched and (
		T.FirstName != S.FirstName OR 
		T.LastName != S.LastName OR 
		T.DateOfBirth != S.DateOfBirth OR 
		T.Gender != S.Gender OR 
		T.DepartmentID != S.DepartmentID) then 
	Update 
		Set
			T.IsActive = 0;
Insert into schema1.Employee (EmployeeID, FirstName, LastName, DateOfBirth, Gender, DepartmentID, IsActive)
	Select *,1 from schema2.Employee as Source
Where not exists (
	Select 1 from schema1.Employee as Target where Target.employeeid = Source.employeeid and Target.Isactive=1)

--Type 3 SCD

CREATE TABLE schema1.salary (
    EmployeeID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
)

CREATE TABLE schema2.salary (
    EmployeeID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
	CurrentSalary DECIMAL(10, 2),
	PreviousSalary DECIMAL(10, 2)
)

-- Inserting values into the Employee table
INSERT INTO schema1.salary (EmployeeID, FullName, Department, Salary)
VALUES
    (1, 'Bergin', 'Sales', 50000.00),
    (2, 'Jack', 'Marketing', 60000.00),
    (3, 'Rashik', 'Finance', 70000.00),
    (4, 'Aswanth', 'Human Resources', 55000.00)

INSERT INTO schema2.salary (EmployeeID, FullName, Department, Salary, CurrentSalary, PreviousSalary)
VALUES
    (1, 'Bergin', 'Sales', 50000.00, Null, Null),
    (2, 'Jack', 'Marketing', 60000.00, Null, Null),
    (3, 'Rashik', 'Finance', 70000.00, Null, Null),
    (4, 'Aswanth', 'Human Resources', 55000.00, Null, Null)

SELECT * FROM schema1.salary --Source
SELECT * FROM schema2.salary --Target

update schema1.salary
set salary = 45000
where EmployeeID = 2

Merge into
	schema2.salary as T
Using 
	schema1.salary as S
On
	T.EmployeeID = S.EmployeeID
When matched and T.Salary != S.Salary then
	Update
		Set T.PreviousSalary = T.Salary,
			T.CurrentSalary = S.Salary
When not matched then
	Insert(EmployeeID, FullName, Department, Salary, CurrentSalary, PreviousSalary)
	Values(S.EmployeeID, S.FullName, S.Department, S.Salary, Null, S.Salary);