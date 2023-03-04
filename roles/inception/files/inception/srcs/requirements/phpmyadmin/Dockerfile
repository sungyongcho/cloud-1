FROM debian:buster

# Update the package list and install dependencies
RUN apt-get update && \
    apt-get install -y wget php-cli php-mbstring php-xml php-mysqli unzip

# Download the latest version of phpMyAdmin
RUN wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz && \
    mkdir -p /var/www/html/pma && \
    tar -xvf phpMyAdmin-latest-all-languages.tar.gz -C /var/www/html/pma --strip-components=1 && \
    rm phpMyAdmin-latest-all-languages.tar.gz

# Copy the configuration file

WORKDIR /var/www/html/pma

RUN mv config.sample.inc.php config.inc.php
RUN chmod 660 /var/www/html/pma/config.inc.php
RUN chown -R www-data:www-data /var/www/html/pma
RUN sed -i "/\$cfg\['Servers'\]\[\$i\]\['host'\] = 'localhost';/a \$cfg['ForceSSL'] = true;" /var/www/html/pma/config.inc.php
RUN sed -i "/^\?>$/i \$cfg['PmaAbsoluteUri'] = 'http://$(ip route | grep default | awk '{print $3}')/pma';" config.inc.php

RUN sed -i 's/localhost/mariadb/g' config.inc.php
# COPY config.inc.php /usr/share/phpmyadmin/

EXPOSE 9999

CMD ["php", "-S", "0.0.0.0:9999"]
