#
# https://github.com/mysql/mysql-docker/tree/mysql-cluster
#
FROM oscarcosta/mysql-cluster

RUN mkdir /usr/mysql-cluster

# Override default config files
COPY my.cnf /etc/
COPY mysql-cluster.cnf /etc/
COPY my_entrypoint.sh /my_entrypoint.sh
COPY startup.sh /startup.sh

# copy database init script
COPY boat.sql /docker-entrypoint-initdb.d/
