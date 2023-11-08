FROM debian:buster

# Install nginx
RUN apt update && \
    apt install -y --no-install-recommends nginx && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the configuration file
COPY ./conf /etc/nginx/conf.d

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80
