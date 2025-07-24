-- Run this command to start and initialize the database:
-- make db-init
-- Run this command to stop the database and reset its volume completely:
-- make db-reset
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'FruitsDB')
BEGIN
  CREATE DATABASE FruitsDB;
END;
GO

USE FruitsDB;
GO

CREATE TABLE dbo.Fruits (
      Id     INT IDENTITY   NOT NULL
    , Name   NVARCHAR(50)   NOT NULL
    , Color  NVARCHAR(50)       NULL
    , CONSTRAINT PK_dbo_Fruits PRIMARY KEY (Id)
);
GO