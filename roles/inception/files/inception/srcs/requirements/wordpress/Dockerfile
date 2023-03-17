FROM debian:buster

RUN apt-get update

RUN apt-get install -y curl
RUN apt-get install -y mariadb-client
RUN	apt-get install -y php7.3 php7.3-phar \
        php7.3-fpm php7.3-common php7.3-mysqli php7.3-iconv php7.3-json \
        php7.3-mysqlnd netcat

ENV WP_CLI_ALLOW_ROOT true

# Needed, otherwise Error: unable to bind listening socket for address
RUN	mkdir -p /run/php

# Modify the working directory, the following commands will be executed in this directory
WORKDIR /var/www/wordpress

COPY    ./tools/entrypoint.sh /tmp/
# COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/
RUN chmod 777 /tmp/entrypoint.sh

EXPOSE  9000
CMD /tmp/entrypoint.sh
