/*
------------------------------------------------------------------------------
------------------------------------------------------------------------------
create database and schema
------------------------------------------------------------------------------
------------------------------------------------------------------------------
Purpose:
These script creates new database named "DataWarehouse" after checking if it already exists.
If it exists then it is dropped and recreate. Additionally the script sets up three schema:
bronze,silver, gold

Warning:
Running this script will drop the database nameed "DataWarehouse" and recreate. All data 
in the database will permanently deleted. Proceed with caution and ensure you have proper
backup

*/

-- drop and recreate the "DataWarehouse" database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name= 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO


use master;

-- create database 'DataWarehouse'
CREATE DATABASE DataWarehouse;

USE DataWarehouse;

-- creating schema

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
