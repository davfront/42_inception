FROM debian:buster

# Install mariadb
RUN apt update && \
    apt install -y --no-install-recommends mariadb-server && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    # Listen on all interfaces
    sed -i 's/^bind-address/# bind-address/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Create database
COPY ./tools/create_db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_db.sh
ENTRYPOINT ["/usr/local/bin/create_db.sh"]

# Start mysql server
CMD ["mysqld"]
EXPOSE 3306
