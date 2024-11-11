
Create Table EmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

Create Table EmployeeSalary 
(EmployeeID int, 
JobTitle varchar(50), 
Salary int
)




Insert into EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')


Insert Into EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

SELECT DISTINCT(FirstName)
From EmployeeDemographics

SELECT *
From SQLTutorial.dbo.EmployeeDemographics

SELECT COUNT(FirstName) AS total
From EmployeeDemographics 


SELECT COUNT(*) AS total
From SQLTutorial.dbo.EmployeeDemographics 

Deterministic
SELECT Max(Salary) AS Maximum
From SQLTutorial.dbo.EmployeeSalary

Non-deterministic
SELECT GetDate() As Date

SELECT Current_timestamp

SELECT AVG(age) AS total
From EmployeeDemographics
WHERE FirstName = 'Jim'


SELECT AVG(age) AS total
From EmployeeDemographics
WHERE FirstName <> 'Jim'

SELECT *
From EmployeeDemographics
WHERE FirstName <> 'Jim'


SELECT *
From EmployeeDemographics
WHERE LastName = 'Palmer' OR Age = 30

SELECT *
From EmployeeDemographics
WHERE LastName Like 'S%ot%'


SELECT *
From EmployeeDemographics
WHERE LastName Like '%S%'

SELECT *
From EmployeeDemographics
WHERE LastName IN ('Scott', 'Schrute', 'Hudson')

SELECT Gender, COUNT(Gender) AS CountGender
FROM EmployeeDemographics
WHERE Age > 30
GROUP BY Gender
ORDER BY CountGender 


SELECT *
FROM EmployeeDemographics
ORDER BY 1 Desc , 4 Desc




Insert into EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'Male')


Table 3 Query:

Create Table WareHouseEmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)


Table 3 Insert:

Insert into WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')


SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
INNER JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
Full Outer JOIN SQLTutorial.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


SELECT EmployeeSalary.EmployeeID, FirstName, LastName, Gender, Salary
FROM SQLTutorial.dbo.EmployeeDemographics
RIGHT OUTER JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
LEFT OUTER JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID



SELECT *
From SQLTutorial.dbo.WarehouseEmployeeDemographics

Assume we want to know the highest paid employee apart from michael

SELECT EmployeeSalary.EmployeeID, FirstName, LastName JobTitle, Salary
FROM SQLTutorial.dbo.EmployeeDemographics
INNER JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
	WHERE FirstName <> 'Michael'
	ORDER BY Salary Desc



SELECT JobTitle, AVG(Salary) AS AVGSalary
FROM SQLTutorial.dbo.EmployeeDemographics
INNER JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle = 'Salesman' OR JobTitle = 'Accountant'
GROUP BY JobTitle
Order By AVGSalary DESC
	


SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
FULL OUTER JOIN SQLTutorial.dbo.WareHouseEmployeeDemographics
	ON EmployeeDemographics.EmployeeID = WareHouseEmployeeDemographics.EmployeeID


---------------------------------------------UNION ALL--------------------------------------


SELECT *
From SQLTutorial.dbo.EmployeeDemographics

UNION ALL

SELECT *
From SQLTutorial.dbo.WarehouseEmployeeDemographics



But this is wrong.
SELECT EmployeeID, FirstName, Age
From SQLTutorial.dbo.EmployeeDemographics

UNION ALL

SELECT EmployeeID, JobTitle, Salary
From SQLTutorial.dbo.EmployeeSalary

--------------------------------------------------CASE Statements--------------------------------


SELECT FirstName, JobTitle, Age, Averagesal, Category
FROM (
    SELECT
        ed.FirstName,
        es.JobTitle,
        ed.Age,
        AVG(es.Salary) AS Averagesal,
        CASE
            WHEN ed.Age > 30 THEN 'old'
            WHEN ed.Age <= 30 THEN 'Young'
            ELSE 'Unknown'
        END AS Category
    FROM SQLTutorial.dbo.EmployeeDemographics ed
    FULL OUTER JOIN SQLTutorial.dbo.EmployeeSalary es
    ON ed.EmployeeID = es.EmployeeId
    GROUP BY ed.FirstName, es.JobTitle, ed.Age
) AS Subquery
ORDER BY Averagesal DESC;


SELECT FirstName, JobTitle, Age, AVG(Salary) AS Averagesal,
	CASE
		WHEN Age > 30 THEN 'old'
		WHEN Age <= 30 THEN 'Young'
		ELSE 'Unknown'
	END AS Category

FROM SQLTutorial.dbo.EmployeeDemographics
FULL OUTER JOIN SQLTutorial.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeId
GROUP BY Category
ORDER BY Averagesal Desc




SELECT 
    FirstName,
    JobTitle,
    Age,
    CASE
        WHEN Age >= 35 THEN 'old'
        WHEN Age BETWEEN 30 AND 35 THEN 'Midium'
		WHEN Age <= 30 THEN 'Young'
        ELSE 'Unknown'
    END AS Category,
    AVG(Salary) AS Averagesal

FROM SQLTutorial.dbo.EmployeeDemographics
FULL OUTER JOIN SQLTutorial.dbo.EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

GROUP BY 
    FirstName,
    JobTitle,
    Age,
    CASE
        WHEN Age > 30 THEN 'old'
        WHEN Age <= 30 THEN 'Young'
        ELSE 'Unknown'
    END

ORDER BY Averagesal DESC;


--------------------------------------------------HAVING CLAUSE----------------

SELECT JobTitle, COUNT(JobTitle) AS Number
FROM SQLTutorial.dbo.EmployeeDemographics
JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1
ORDER BY COUNT(JobTitle) DESC


SELECT JobTitle, AVG(Salary) AS AVGSalary
FROM SQLTutorial.dbo.EmployeeDemographics
JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary) DESC




--------------------------------------------------UPDATING / DELETING----------------
SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics

UPDATE SQLTutorial.dbo.EmployeeDemographics
SET Age = 31, Gender = 'Female', EmployeeID = 1012
WHERE FirstName = 'Holly' AND LastName = 'FLAX'

--------------------------------------------------ALIASING----------------

SELECT FirstName + '' + LastName AS FullName
FROM SQLTutorial.dbo.EmployeeDemographics

SELECT Demo.EmployeeID
FROM SQLTutorial.dbo.EmployeeDemographics AS Demo



SELECT Demo.EmployeeID AS ID, Demo.FirstName, Demo.LastName, Sal.Salary, Ware.Age
FROM SQLTutorial.dbo.EmployeeDemographics Demo
LEFT JOIN SQLTutorial.dbo.EmployeeSalary Sal
	ON Demo.EmployeeID = Sal.EmployeeID

LEFT JOIN SQLTutorial.dbo.WareHouseEmployeeDemographics Ware
	ON Demo.EmployeeID = Ware.EmployeeID


--------------------------------------------------PARTITION BY----------------

SELECT FirstName, LastName, Gender, Salary, 
	COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
FROM SQLTutorial.dbo.EmployeeDemographics dem
JOIN SQLTutorial.dbo.EmployeeSalary sal
	ON dem.EmployeeID = sal.EmployeeID


-----------------------------------------------CTE--------------------------------------

WITH Cte_Employee AS
(
SELECT FirstName, LastName, Gender, Salary, 
	COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
FROM SQLTutorial.dbo.EmployeeDemographics dem
JOIN SQLTutorial.dbo.EmployeeSalary sal
	ON dem.EmployeeID = sal.EmployeeID
	)
	SELECT FirstName, Gender, AVG(Salary) AS AVGSALARY
	FROM Cte_Employee
	GROUP BY FirstName, Gender
	ORDER BY AVGSALARY



-----------------------------------------------Temp Tables--------------------------------------

CREATE TABLE #temp_Employee (
EmployeeID int,
JobTitle varchar (100),
Salary int 
)

SELECT *
FROM #temp_Employee


INSERT INTO #temp_Employee VALUES (
1001, 'HR', '45000'
)

INSERT INTO #temp_Employee

SELECT *
FROM SQLTutorial..EmployeeSalary


------------------------------------------Application of Temp Table-----------------------

CREATE TABLE #temp_employee2 (
EmployeeID int,
JobTitle varchar(100),
Salary int
)

SELECT * 
FROM #temp_employee2

DROP TABLE IF EXISTS #temp_employee3
CREATE TABLE #temp_employee3 (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)

SELECT * 
FROM #temp_employee3

INSERT INTO #temp_employee3
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM SQLTutorial..EmployeeDemographics emp
JOIN SQLTutorial..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle



------------------------------------------String Functions-----------------------
--------------------------------TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower-----------------------


DROP TABLE IF EXISTS EmployeeErrors

CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)


INSERT INTO EmployeeErrors VALUES 
('1001  ', 'Jimbo', 'Halbert'),
('  1002', 'Pamela', 'Beasely'),
('1005', 'TOby', 'Flenderson - Fired')


SELECT *
FROM EmployeeErrors

SELECT EmployeeID,TRIM(EmployeeID) AS IDTRIM
FROM EmployeeErrors

SELECT EmployeeID,LTRIM(EmployeeID) AS IDTRIM
FROM EmployeeErrors

SELECT EmployeeID,RTRIM(EmployeeID) AS IDTRIM
FROM EmployeeErrors

-------------------------------------------------------Replace-----------------------

SELECT LastName, REPLACE(LastName,'- Fired', '') AS LastNameFixed
FROM EmployeeErrors


-------------------------------------------------------Substring-----------------------

SELECT SUBSTRING(FirstName, 3,3)
FROM EmployeeErrors


SELECT err.FirstName, dem.FirstName
FROM EmployeeDemographics dem
JOIN EmployeeErrors err
	ON dem.FirstName = err.FirstName


SELECT SUBSTRING(err.FirstName,1,3), SUBSTRING(dem.FirstName,1,3), SUBSTRING(err.LastName,1,3), SUBSTRING(dem.LastName,1,3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	ON SUBSTRING(err.FirstName,1,3) = SUBSTRING(dem.FirstName,1,3)
	and SUBSTRING(err.LastName,1,3) = SUBSTRING(dem.LastName,1,3)



SELECT FirstName, UPPER(FirstName)
FROM EmployeeErrors


SELECT FirstName, LOWER(FirstName)
FROM EmployeeErrors

-------------------------------------------------------Stored Procedures-----------------------

CREATE PROCEDURE TEST
AS
SELECT *
FROM EmployeeErrors

EXEC TEST



CREATE PROCEDURE Temp_Employee
AS
DROP TABLE IF EXISTS #temp_employee
Create table #temp_employee (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)


Insert into #temp_employee
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM SQLTutorial..EmployeeDemographics emp
JOIN SQLTutorial..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle

Select * 
From #temp_employee

Exec Temp_Employee


-------------------------------------------------------Stored Procedures-----------------------


CREATE PROCEDURE Temp_Employee2 
@JobTitle nvarchar(100) ----Define the parameter 
AS
DROP TABLE IF EXISTS #temp_employee3
Create table #temp_employee3 (
JobTitle varchar(100), 
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)


Insert into #temp_employee3
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM SQLTutorial..EmployeeDemographics emp
JOIN SQLTutorial..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
where JobTitle = @JobTitle --- Assign parameter
group by JobTitle

Select * 
From #temp_employee3

EXEC Temp_Employee2 @jobtitle = 'Salesman' -----Calling stored procedure plus value of the parameter 
EXEC Temp_Employee2 @jobtitle = 'Accountant'
