FROM mariadb:latest
ENV MARIADB_ROOT_PASSWORD=rmit_password
# Copy SQL script into the container
COPY sql-scripts/sql-script.sql /docker-entrypoint-initdb.d/
EXPOSE 3306
