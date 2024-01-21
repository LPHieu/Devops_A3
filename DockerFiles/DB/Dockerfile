# RMIT University Vietnam
# Course: COSC2767 Systems Deployment and Operations
# Semester: 2023C
# Assessment: Assignment 3
# Author: Group 3
# Created  date: 02/01/2023
# Last modified: 20/01/2023
# Acknowledgement: None

FROM mariadb:latest
ENV MARIADB_ROOT_PASSWORD=rmit_password
# Copy SQL script into the container
COPY sql-scripts/sql-script.sql /docker-entrypoint-initdb.d/
EXPOSE 3306
