USE MASTER;
GO
CREATE DATABASE MSBI;
GO
USE MSBI;
GO
CREATE TABLE Country
(
CountryId INTEGER NOT NULL,--IDENTITY(1,1),
CountryName NVARCHAR(50) NOT NULL,
IsNew BIT DEFAULT 1
CONSTRAINT CountryId_PK PRIMARY KEY CLUSTERED (CountryId ASC)
);
/*GO
BEGIN TRANSACTION;
--INSERT INTO Country(CountryName) VALUES('India'),('Nepal'),('US');
BULK INSERT Country
FROM 'C:\Users\panos\Desktop\MS_BI\1\BulkfileTxtNew\BulkfileNew\BulkfileNew\Country\Country.txt'
WITH
(FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FIRSTROW = 2
);
COMMIT TRANSACTION;*/
GO
SELECT * FROM Country;
GO
CREATE TABLE Product
(
ProductId INTEGER NOT NULL,--IDENTITY(1,1),
ProductName NVARCHAR(50) NOT NULL,
DateCreated DATETIME,
DateExpired DATETIME
CONSTRAINT ProductId_PK PRIMARY KEY CLUSTERED (ProductId ASC)
);
/*GO
BEGIN TRANSACTION;
--INSERT INTO Product(ProductName) VALUES('Sport Shoes'),('Shirts'),('Pants'),('Toys');
BULK INSERT Product
FROM 'C:\Users\panos\Desktop\MS_BI\1\BulkfileTxtNew\BulkfileNew\BulkfileNew\Product\Product.txt'
WITH
(FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FIRSTROW = 2
);
COMMIT TRANSACTION;*/
GO
SELECT * FROM Product;
GO
CREATE TABLE SalesPerson
(
PersonId INTEGER NOT NULL,--IDENTITY(1,1),
PersonName NVARCHAR(50) NOT NULL,
CONSTRAINT PersonId_PK PRIMARY KEY CLUSTERED (PersonId ASC)
);
/*GO
BEGIN TRANSACTION;
--INSERT INTO SalesPerson(PersonName) VALUES('Shiv'),('Raju'),('Khadak'),('Shaam');
BULK INSERT SalesPerson
FROM 'C:\Users\panos\Desktop\MS_BI\1\BulkfileTxtNew\BulkfileNew\BulkfileNew\SalesPerson\SalesPerson.txt'
WITH
(FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FIRSTROW = 2
);
COMMIT TRANSACTION;*/
GO
SELECT * FROM SalesPerson;
GO
CREATE TABLE States
(
StatesId INTEGER NOT NULL,--IDENTITY(1,1),
StatesName NVARCHAR(50) NOT NULL,
CONSTRAINT StatesId_PK PRIMARY KEY CLUSTERED (StatesId ASC)
);
/*GO
BEGIN TRANSACTION;
--INSERT INTO States(StatesName) VALUES('Maharastra'),('Punjab'),('NewYork'),('Kathmandu');
BULK INSERT States
FROM 'C:\Users\panos\Desktop\MS_BI\1\BulkfileTxtNew\BulkfileNew\BulkfileNew\States\StatesId.txt'
WITH
(FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FIRSTROW = 2
);
COMMIT TRANSACTION;*/
GO
SELECT * FROM States;
GO
CREATE TABLE Customer
(
CustomerCode INTEGER NOT NULL,--IDENTITY(1001,1),
CustomerName NVARCHAR(50) NOT NULL,
CustomerAmount MONEY NOT NULL,
SalesDate DATETIME NOT NULL,
CountryName NVARCHAR(50) NOT NULL,
StatesName NVARCHAR(50) NOT NULL,
ProductName NVARCHAR(50) NOT NULL,
SalesPersonName NVARCHAR(50) NOT NULL--,
--CONSTRAINT CustomerCode_PK PRIMARY KEY CLUSTERED (CustomerCode ASC)
);
/*GO
BEGIN TRANSACTION;
/*INSERT INTO Customer(CustomerName,CustomerAmount,SalesDate,CountryName,StatesName,ProductName,SalesPersonName) 
VALUES('Shiv',12,'1/1/2010','India','Maharastra','Shoes','Shiv'),
('Raju',100,'2/2/2012','Nepal','Kathmandu','Shirts','Raju'),
('ajay',400,'1/1/2013','US','NewYork','Pants','Khadak'),
('Khadak',500,'3/3/2014','India','Punjab','Toys','Shaam'),
('Sham',700,'5/10/2014','Nepal','Kathmandu','Shirts','Shiv'),
('Rahul',-100,'3/2/2015','India','Maharastra','Toys','Khadak'),
('Rohit',0,'4/5/2015','US','NewYork','Shoes','Raju'),
('Sanjay',1240,'5/5/2015','India','Punjab','Toys','Shaam'),
('Jignesh',12,'1/1/2010','India','Maharastra','Shirts','Raja'),
('Raju',100,'2/2/2012','Nepal','Kathmandu','Shirts','Raju'),
('Rajnish',400,'1/1/2013','US','NewYork','Toys','Khadak'),
('Sukesh',500,'3/3/2014','India','Punjab','Toys','Shaam'),
('Pradip',700,'5/10/2014','Nepal','Kathmandu','Shirts','Shiv');*/
BULK INSERT Customer
FROM 'C:\Users\panos\Desktop\MS_BI\1\BulkfileTxtNew\BulkfileNew\BulkfileNew\Customer1.txt'
WITH
(FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FIRSTROW = 2
);
BULK INSERT Customer
FROM 'C:\Users\panos\Desktop\MS_BI\1\BulkfileTxtNew\BulkfileNew\BulkfileNew\Customer2.txt'
WITH
(FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FIRSTROW = 2
);
COMMIT TRANSACTION;*/
GO
SELECT * FROM Customer;
SELECT CustomerName FROM Customer;
SELECT LOWER(CustomerName) AS LowerCustomerName FROM Customer;
SELECT UPPER(SUBSTRING(CustomerName,1,1)) + LOWER(SUBSTRING(CustomerName,2,LEN(CustomerName)-1)) AS InitcapCustomerName FROM Customer;
GO
CREATE TABLE FactCustomer
(
CustomerCode INTEGER NOT NULL,--IDENTITY(1001,1),
CustomerName NVARCHAR(50) NOT NULL,
CustomerAmount MONEY NOT NULL,
SalesDate DATETIME NOT NULL,
--CountryName NVARCHAR(50),
--StatesName NVARCHAR(50),
--ProductName NVARCHAR(50),
--SalesPersonName NVARCHAR(50)
CountryId INTEGER,
StatesId INTEGER,
ProductId INTEGER,
PersonId INTEGER,
CONSTRAINT CustomerCodeFact_PK PRIMARY KEY CLUSTERED (CustomerCode ASC),
CONSTRAINT CountryId_FK FOREIGN KEY(CountryId) REFERENCES Country(CountryId) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT StatesId_FK FOREIGN KEY(StatesId) REFERENCES States(StatesId) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT ProductId_FK FOREIGN KEY(ProductId) REFERENCES Product(ProductId) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT SalesPersonId_FK FOREIGN KEY(PersonId) REFERENCES SalesPerson(PersonId) ON DELETE SET NULL ON UPDATE CASCADE
);
GO
SELECT * FROM Country;
SELECT * FROM Product;
SELECT * FROM States;
SELECT * FROM SalesPerson;
SELECT * FROM FactCustomer;
GO
SELECT SUM(CustomerAmount) AS TotalCustomerAmount FROM FactCustomer;
GO
SELECT CountryId, CountryName FROM Country WHERE IsNew = 1;
GO
SELECT ProductId, ProductName FROM Product WHERE DateExpired IS NULL;
SELECT ProductId, ProductName FROM Product WHERE DateCreated IS NOT NULL;
GO
SELECT 
CustomerAmount, 
SalesDate, 
YEAR(SalesDate) AS Year, 
MONTH(SalesDate) AS Month, 
DAY(SalesDate) AS Day,
DATEPART(QUARTER, SalesDate) AS Quarter,
DATEPART(MINUTE, SalesDate) AS Minutes,
DATEPART(SECOND, SalesDate) AS Seconds,
DATEPART(MILLISECOND, SalesDate) AS Milliseconds
FROM FactCustomer;
GO
SELECT * FROM Time;
GO
ALTER TABLE FactCustomer ADD CONSTRAINT SalesDate_FK FOREIGN KEY(SalesDate) REFERENCES Time(PK_Date) ON DELETE CASCADE ON UPDATE CASCADE;
GO
----------
----------
----------
----------
----------
USE MSBI;
GO
BEGIN TRANSACTION;
DELETE FROM Time;
COMMIT TRANSACTION;
GO
ALTER TABLE FactCustomer DROP CONSTRAINT IF EXISTS SalesDate_FK;
GO
BEGIN TRANSACTION;
TRUNCATE TABLE Time;
COMMIT TRANSACTION;
GO
ALTER TABLE Time DROP CONSTRAINT IF EXISTS PK_Time;
GO
DROP TABLE IF EXISTS Time;
GO
BEGIN TRANSACTION;
DELETE FROM FactCustomer;
COMMIT TRANSACTION;
GO
BEGIN TRANSACTION;
TRUNCATE TABLE FactCustomer;
COMMIT TRANSACTION;
GO
ALTER TABLE FactCustomer DROP CONSTRAINT IF EXISTS SalesPersonId_FK;
GO
ALTER TABLE FactCustomer DROP CONSTRAINT IF EXISTS ProductId_FK;
GO
ALTER TABLE FactCustomer DROP CONSTRAINT IF EXISTS StatesId_FK;
GO
ALTER TABLE FactCustomer DROP CONSTRAINT IF EXISTS CountryId_FK;
GO
ALTER TABLE FactCustomer DROP CONSTRAINT IF EXISTS CustomerCodeFact_PK;
GO
ALTER TABLE FactCustomer ALTER COLUMN CustomerCode INTEGER;
GO
DROP TABLE IF EXISTS FactCustomer;
GO
BEGIN TRANSACTION;
DELETE FROM Customer;
COMMIT TRANSACTION;
GO
BEGIN TRANSACTION;
TRUNCATE TABLE Customer;
COMMIT TRANSACTION;
GO
ALTER TABLE Customer DROP CONSTRAINT IF EXISTS CustomerCode_PK;
GO
ALTER TABLE Customer ALTER COLUMN CustomerCode INTEGER;
GO
DROP TABLE IF EXISTS Customer;
GO
BEGIN TRANSACTION;
DELETE FROM States;
COMMIT TRANSACTION;
GO
BEGIN TRANSACTION;
TRUNCATE TABLE States;
COMMIT TRANSACTION;
GO
ALTER TABLE States DROP CONSTRAINT IF EXISTS StatesId_PK;
GO
ALTER TABLE States ALTER COLUMN StatesId INTEGER;
GO
DROP TABLE IF EXISTS States;
GO
BEGIN TRANSACTION;
DELETE FROM SalesPerson;
COMMIT TRANSACTION;
GO
BEGIN TRANSACTION;
TRUNCATE TABLE SalesPerson;
COMMIT TRANSACTION;
GO
ALTER TABLE SalesPerson DROP CONSTRAINT IF EXISTS PersonId_PK;
GO
ALTER TABLE SalesPerson ALTER COLUMN PersonId INTEGER;
GO
DROP TABLE IF EXISTS SalesPerson;
GO
BEGIN TRANSACTION;
DELETE FROM Product;
COMMIT TRANSACTION;
GO
BEGIN TRANSACTION;
TRUNCATE TABLE Product;
COMMIT TRANSACTION;
GO
ALTER TABLE Product DROP CONSTRAINT IF EXISTS ProductId_PK;
GO
ALTER TABLE Product ALTER COLUMN ProductId INTEGER;
GO
DROP TABLE IF EXISTS Product;
GO
BEGIN TRANSACTION;
DELETE FROM Country;
COMMIT TRANSACTION;
GO
BEGIN TRANSACTION;
TRUNCATE TABLE Country;
COMMIT TRANSACTION;
GO
ALTER TABLE Country DROP CONSTRAINT IF EXISTS CountryId_PK;
GO
ALTER TABLE Country ALTER COLUMN CountryId INTEGER;
GO
DROP TABLE IF EXISTS Country;
GO
USE MASTER;
GO
ALTER DATABASE MSBI SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE IF EXISTS MSBI;