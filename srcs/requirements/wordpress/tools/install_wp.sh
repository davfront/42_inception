#!/bin/sh
set -e

if wp core is-installed --path=/var/www/html/ --allow-root; then

	echo "WARNING: wordpress already installed"

else

	rm -rf /var/www/html/*

	wp core download \
		--version="$WP_VERSION" \
		--quiet --path=/var/www/html/ --allow-root

	wp config create \
		--dbname="$MYSQL_DATABASE" \
		--dbuser="$MYSQL_USER" \
		--dbpass="$MYSQL_PASSWORD" \
		--dbhost=mariadb \
		--quiet --path=/var/www/html/ --allow-root

	wp core install \
		--url="$DOMAIN_NAME" \
		--title="$WP_TITLE" \
		--admin_user="$WP_ADMIN" \
		--admin_password="$WP_ADMIN_PWD" \
		--admin_email="$WP_ADMIN_EMAIL" \
		--quiet --path=/var/www/html/ --allow-root

	wp user create \
		"$WP_USER" \
		"$WP_USER_EMAIL" \
		--role=author \
		--user_pass="$WP_USER_PWD" \
		--porcelain \
		--quiet --path=/var/www/html/ --allow-root

	# Adjust permissions
	chown -R www-data:www-data /var/www/html

	echo "SUCCESS: wordpress installed"

fi

exec "$@"
