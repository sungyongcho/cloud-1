FROM debian:buster

# The ENTRYPOINT specifies a command that will always be executed when the container starts.
# Default parameters cannot be overridden from the Docker Command Line Interface
# The CMD specifies arguments that will be fed to the ENTRYPOINT. 
# Sets default parameters that can be overridden from the Docker Command Line Interface

# ARGS: Add build arguments, which are environment variables accessible only during the build process.
ARG     MARIADB_ROOT_PWD
ARG     MARIADB_DB
ARG     MARIADB_USER
ARG     MARIADB_PWD

# RUN echo "MARIADB_ROOT_PWD: $MARIADB_ROOT_PWD"
# RUN echo "MARIADB_DB: $MARIADB_DB"
# RUN echo "MARIADB_USER: $MARIADB_USER"
# RUN echo "MARIADB_PWD: $MARIADB_PWD"

RUN     apt-get update
RUN     apt-get install -y mariadb-server mariadb-client

# Create the daemon folder
RUN     mkdir -p /var/lib/mysqld /run/mysqld

# Copy the sql configuration file into the container
COPY    /conf/setup.sql /tmp/setup.sql

# EXPAND ENV VARIABLES in the setup.sql file
RUN     sed -i "s/MARIADB_HOST/$MARIADB_HOST/g" /tmp/setup.sql
RUN     sed -i "s/MARIADB_USER/$MARIADB_USER/g" /tmp/setup.sql
RUN     sed -i "s/MARIADB_PWD/$MARIADB_PWD/g" /tmp/setup.sql
RUN     sed -i "s/MARIADB_DB/$MARIADB_DB/g" /tmp/setup.sql
RUN     sed -i "s/MARIADB_ROOT_PWD/$MARIADB_ROOT_PWD/g" /tmp/setup.sql

COPY    /conf/mariadb.cnf /etc/my.cnf.d/

# mysql has to be the owner of the mysql folder
RUN     chown -R mysql:mysql /var/lib/mysql 

# Allow remote connection to database server
# https://di-marco.net/blog/it/2020-01-21-tips-allow_remote_connections_to_mysql_server/
RUN     sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
RUN     cat /etc/mysql/mariadb.conf.d/50-server.cnf

# Change owner for the daemon
RUN     chown -R mysql:mysql /run/mysqld
RUN     service mysql start && mysql -u root -v < /tmp/setup.sql

CMD     ["mysqld_safe"]

EXPOSE  3306
