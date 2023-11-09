FROM debian:buster

ARG DOMAIN_NAME
ARG CERT_DIR
ARG CERT_SUBJ

# Install nginx
RUN apt update && \
    apt install -y --no-install-recommends \
        nginx \
        openssl && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Copy configuration and substitute variables
COPY ./conf/nginx.conf.template /etc/nginx/conf.d/
RUN sed -i "s|\${DOMAIN_NAME}|$DOMAIN_NAME|" /etc/nginx/conf.d/nginx.conf.template && \
    sed -i "s|\${CERT_DIR}|$CERT_DIR|" /etc/nginx/conf.d/nginx.conf.template && \
    mv /etc/nginx/conf.d/nginx.conf.template /etc/nginx/conf.d/nginx.conf

# Generate ssl certificates
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/nginx/ssl/$DOMAIN_NAME.crt \
       -keyout /etc/nginx/ssl/$DOMAIN_NAME.key \
       -subj "$CERT_SUBJ"

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80 443
