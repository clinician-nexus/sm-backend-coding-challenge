-- Run this command to reseed the database:
-- make db-seed
USE FruitsDB;
GO

TRUNCATE TABLE dbo.Fruits;
INSERT dbo.Fruits (Name, Color) VALUES ('Apple'     , 'Red');
INSERT dbo.Fruits (Name, Color) VALUES ('Banana'    , 'Yellow');
INSERT dbo.Fruits (Name, Color) VALUES ('Lime'      , 'Green');
INSERT dbo.Fruits (Name, Color) VALUES ('Cherry'    , 'Red');
INSERT dbo.Fruits (Name, Color) VALUES ('Apple'     , 'Green');
INSERT dbo.Fruits (Name, Color) VALUES ('Grape'     , 'Purple');
INSERT dbo.Fruits (Name, Color) VALUES ('Lemon'     , 'Yellow');
INSERT dbo.Fruits (Name, Color) VALUES ('Grape'     , 'Green');
INSERT dbo.Fruits (Name, Color) VALUES ('Strawberry', 'Red');
INSERT dbo.Fruits (Name, Color) VALUES ('Kiwi'      , 'Green');