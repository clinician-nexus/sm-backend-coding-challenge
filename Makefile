.PHONY: app-start app-stop db-init db-seed db-select db-reset

DB_FILE=FruitsDB.db

app-start:
	dotnet watch

app-stop:
	@pkill -f 'dotnet run' || true

# --- SQLite database commands ---
# The database (FruitsDB.db) is pre-seeded and committed to the repo, so you
# normally don't need any of these. They're here only if you want to rebuild it.

# Recreate the database from scratch (schema + seed).
db-init: db-reset
	python3 -c "import sqlite3; c=sqlite3.connect('$(DB_FILE)'); c.executescript(open('schema.sql').read()); c.executescript(open('seed.sql').read()); c.commit(); c.close()"
	@echo "Database initialized at $(DB_FILE)."

# Re-apply seed data to the existing database.
db-seed:
	python3 -c "import sqlite3; c=sqlite3.connect('$(DB_FILE)'); c.executescript(open('seed.sql').read()); c.commit(); c.close()"
	@echo "Database re-seeded."

# Print all rows to verify the table exists and is seeded.
db-select:
	python3 -c "import sqlite3; c=sqlite3.connect('$(DB_FILE)'); [print(r) for r in c.execute('SELECT * FROM Fruits')]; c.close()"

# Delete the database file.
db-reset:
	@rm -f $(DB_FILE)
	@echo "Removed $(DB_FILE)."
