FROM debian:buster

# Install repositories that contain the PHP 7.4 packages
RUN apt update && apt install -y --no-install-recommends \
    apt-transport-https \
    lsb-release \
    ca-certificates \
    gnupg2 \
    curl \
    && curl -fsSL https://packages.sury.org/php/apt.gpg | apt-key add - \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list


# Install php-fpm and extensions
RUN apt update && apt install -y --no-install-recommends \
    php7.4-fpm \
    php7.4-curl \
    php7.4-dom \
    php7.4-exif \
    php7.4-fileinfo \
    php7.4-json \
    php7.4-mbstring \
    php7.4-mysqli \
    php7.4-xml \
    php7.4-zip \
    openssl \
    && apt clean && rm -rf /var/lib/apt/lists/*

# Download wp-cli
ADD --chmod=755 https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/bin/wp

# Install wordpress
COPY ./tools/install_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install_wp.sh
ENTRYPOINT ["install_wp.sh"]

# Configure PHP-FPM to listen on port 9000
RUN sed -i 's/^listen = .*/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf

# Create directory for php-fpm socket
RUN mkdir -p /run/php

WORKDIR /var/www/html
EXPOSE 9000
CMD ["php-fpm7.4", "-F"]
