FROM debian:buster

# Install php-fpm and extensions
RUN apt update && apt install -y --no-install-recommends \
    php7.3-fpm \
    php7.3-curl \
    php7.3-dom \
    php7.3-exif \
    php7.3-fileinfo \
    php7.3-json \
    php7.3-mbstring \
    php7.3-mysqli \
    php7.3-xml \
    php7.3-zip \
    openssl \
    && apt clean && rm -rf /var/lib/apt/lists/*

# Download wp-cli
ADD --chmod=755 https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/bin/wp

# Install wordpress
COPY ./tools/install_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install_wp.sh
ENTRYPOINT ["install_wp.sh"]

# Configure PHP-FPM to listen on port 9000
RUN sed -i 's/^listen = .*/listen = 9000/' /etc/php/7.3/fpm/pool.d/www.conf

# Create directory for php-fpm socket
RUN mkdir -p /run/php

WORKDIR /var/www/html
EXPOSE 9000
CMD ["php-fpm7.3", "-F"]
