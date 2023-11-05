FROM debian:buster

# Define arguments
ARG MARIADB_DATABASE
ARG MARIADB_USER
ARG MARIADB_PASSWORD
ARG MARIADB_ROOT_PASSWORD

# Install mariadb
RUN apt update && \
    apt install -y --no-install-recommends mariadb-server && \
    # apt install -y --no-install-recommends mariadb-client && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
# Purge and re-create /var/lib/mysql with appropriate ownership
    # mkdir -p /var/run/mysqld && \
    # chown -R mysql:mysql /var/run/mysqld && \
# ensure that /var/run/mysqld is writable
    # chmod 777 /var/run/mysqld

# Create database
RUN service mysql start && \
    mysql -e "CREATE USER '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';" && \
    mysql -e "CREATE DATABASE ${MARIADB_DATABASE};" && \
    mysql -e "GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%';" && \
    mysql -e "FLUSH PRIVILEGES;"

# Set root password
RUN service mysql start && \
    mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MARIADB_ROOT_PASSWORD}');"

EXPOSE 3306
CMD ["mysqld", "--bind-address=0.0.0.0"]
