-- Create a database if it doesn't exist (optional, but good practice)
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'FruitsDB')
BEGIN
    CREATE DATABASE FruitsDB;
END;
GO

USE FruitsDB;
GO

CREATE TABLE Fruits (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Color NVARCHAR(50)
);
GO