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

# Install wordpress
ADD https://wordpress.org/wordpress-6.3.2.tar.gz /tmp/wordpress-6.3.2.tar.gz
RUN mkdir -p /var/www && \
    tar -xzvf /tmp/wordpress-6.3.2.tar.gz -C /var/www && \
    rm /tmp/wordpress-6.3.2.tar.gz && \
    mv /var/www/wordpress /var/www/html

# Adjust permissions
RUN chown -R www-data:www-data /var/www/html

# Configure PHP-FPM to listen on TCP socket instead of Unix socket
RUN sed -i 's/^listen = .*/listen = 9000/' /etc/php/7.3/fpm/pool.d/www.conf

WORKDIR /var/www/html
EXPOSE 9000
RUN mkdir -p /run/php
CMD ["php-fpm7.3", "-F"]
