.PHONY: db-start db-stop app-start app-stop db-init db-seed

# Environment variables for connecting to the SQL Server container
# Ensure these match your docker run settings
SQL_SERVER_CONTAINER_NAME=sqlserver-db
SQL_SERVER_HOST=localhost
SQL_SERVER_PORT=1433
SQL_SERVER_USER=sa
SQL_SERVER_PASSWORD=My!ComplexP@ssw0rd
DB_NAME=FruitsDB
SQL_SERVER_VOLUME=sqlvolume

db-start:
	@echo "Starting SQL Server container with volume '$(SQL_SERVER_VOLUME)'..."
	docker run -d \
		--name $(SQL_SERVER_CONTAINER_NAME) \
		-p $(SQL_SERVER_PORT):1433 \
		-e "ACCEPT_EULA=Y" \
		-e "MSSQL_SA_PASSWORD=$(SQL_SERVER_PASSWORD)" \
		-v $(SQL_SERVER_VOLUME):/var/opt/mssql \
		mcr.microsoft.com/mssql/server:2022-latest

db-stop:
	@echo "Stopping and removing SQL Server container..."
	docker stop $(SQL_SERVER_CONTAINER_NAME) || true
	docker rm $(SQL_SERVER_CONTAINER_NAME) || true

db-reset: db-stop
	@echo "Removing SQL Server volume '$(SQL_SERVER_VOLUME)'..."
	docker volume rm $(SQL_SERVER_VOLUME) || true
	@echo "Database volume reset complete."

app-start:
	dotnet watch

app-stop:
	@pkill -f 'dotnet run' || true

# --- SQL Server Initialization Commands ---
db-init: db-start
	docker cp schema.sql $(SQL_SERVER_CONTAINER_NAME):/tmp/schema.sql
	@echo "Waiting for SQL Server to be ready..."
	# Loop until SQL Server is ready (using sqlcmd inside the container)
	@until docker exec $(SQL_SERVER_CONTAINER_NAME) /opt/mssql-tools18/bin/sqlcmd \
		-S $(SQL_SERVER_HOST) -U $(SQL_SERVER_USER) -P "$(SQL_SERVER_PASSWORD)" \
		-Q "SELECT 1" -C; do \
		echo "SQL Server is unavailable - sleeping"; \
		sleep 5; \
	done
	@echo "SQL Server is ready. Executing schema.sql..."
	# Create the database if it doesn't exist
	docker exec $(SQL_SERVER_CONTAINER_NAME) /opt/mssql-tools18/bin/sqlcmd \
		-S $(SQL_SERVER_HOST) -U $(SQL_SERVER_USER) -P "$(SQL_SERVER_PASSWORD)" \
		-Q "IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'$(DB_NAME)') CREATE DATABASE $(DB_NAME);" \
		-C

	# Execute the schema.sql file
	docker exec $(SQL_SERVER_CONTAINER_NAME) /opt/mssql-tools18/bin/sqlcmd \
		-S $(SQL_SERVER_HOST) -U $(SQL_SERVER_USER) -P "$(SQL_SERVER_PASSWORD)" \
		-d $(DB_NAME) -i /tmp/schema.sql -C

	@echo "Schema initialization complete. Seeding data..."
	$(MAKE) db-seed

db-seed:
	docker cp seed.sql $(SQL_SERVER_CONTAINER_NAME):/tmp/seed.sql
	docker exec $(SQL_SERVER_CONTAINER_NAME) /opt/mssql-tools18/bin/sqlcmd \
		-S $(SQL_SERVER_HOST) -U $(SQL_SERVER_USER) -P "$(SQL_SERVER_PASSWORD)" \
		-d $(DB_NAME) -i /tmp/seed.sql -C