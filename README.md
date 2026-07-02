# Backend coding challenge

The app uses a local SQLite database (`FruitsDB.db`) that is pre-seeded and
committed to this repo, so there's no database setup step — just start the app.

- `make app-start` - starts dotnet api in watch mode so it updates as your code changes
- [http://localhost:5162/fruits](http://localhost:5162/fruits) - fruits endpoint - can just open in browser

# Other commands
These are only needed if you want to rebuild the database; `FruitsDB.db` already exists.
- `make db-init` - recreate the database from scratch (schema.sql + seed.sql)
- `make db-seed` - re-apply the seed data (seed.sql)
- `make db-reset` - delete the database file
- `make db-select` - verify the data exists
