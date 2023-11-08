#!/bin/bash
set -e

if [ -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then

    echo "WARNING: database \`${MYSQL_DATABASE}\` already exists";

else

    service mysql start

    # Create database
    mysql -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "CREATE DATABASE ${MYSQL_DATABASE};"
    mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    mysql -e "FLUSH PRIVILEGES;"

    # Set root password
    mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');"

    service mysql stop

    echo "SUCCESS: database \`${MYSQL_DATABASE}\` created";

fi

exec "$@"
