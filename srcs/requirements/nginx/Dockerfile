FROM debian:buster

# Install nginx
RUN apt update && \
    apt install -y --no-install-recommends \
        nginx \
        openssl && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Copy configuration and certificates
COPY ./conf /etc/nginx/conf.d

# Generate ssl certificates
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/nginx/ssl/dapereir.42.fr.crt \
       -keyout /etc/nginx/ssl/dapereir.42.fr.key \
       -subj "/C=FR/ST=Rhône/L=Lyon/O=Ecole42Lyon/OU=IT/CN=dapereir.42.fr/"

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80 443
