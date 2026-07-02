-- SQLite schema for the pre-seeded FruitsDB.db committed to this repo.
-- The database is already generated and checked in, so you normally don't
-- need to run anything. To regenerate it from scratch: make db-init
CREATE TABLE Fruits (
      Id     INTEGER PRIMARY KEY AUTOINCREMENT
    , Name   TEXT    NOT NULL
    , Color  TEXT
);
