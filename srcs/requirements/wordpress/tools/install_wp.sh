#!/bin/sh

if [ -f ./var/www/html/wp-config.php ]
then
	echo "wordpress: already installed"
else

	wp core download \
		--version=6.3.2 \
		--path=/var/www/html/ --allow-root \

	wp config create \
		--dbname="$MYSQL_DATABASE" \
		--dbuser="$MYSQL_USER" \
		--dbpass="$MYSQL_PASSWORD" \
		--dbhost=mariadb \
		--path=/var/www/html/ --allow-root \

	wp core install \
		--url="$DOMAIN_NAME" \
		--title="$WP_TITLE" \
		--admin_user="$WP_ADMIN" \
		--admin_password="$WP_ADMIN_PWD" \
		--admin_email="$WP_ADMIN_EMAIL" \
		--path=/var/www/html/ --allow-root \

	wp user create \
		"$WP_USER" \
		"$WP_USER_EMAIL" \
		--role=author \
		--user_pass="$WP_USER_PWD" \
		--porcelain \
		--path=/var/www/html/ --allow-root \

	# Adjust permissions
	chown -R www-data:www-data /var/www/html

fi

exec "$@"
