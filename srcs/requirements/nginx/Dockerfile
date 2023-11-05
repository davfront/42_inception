FROM debian:buster

RUN apt update && \
    apt install -y --no-install-recommends nginx && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

    
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

# Copy the configuration file from the host to the container
# COPY ./conf /etc/nginx/conf.d

# # Set up the volume for HTML files
# VOLUME ["/var/www/html"]

# # Set ownership for the NGINX process
# RUN chown -R www-data:www-data /var/www/html

# # Set permissions for directories and files
# RUN find /var/www/html -type d -exec chmod 755 {} \; && \
#     find /var/www/html -type f -exec chmod 644 {} \;

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
