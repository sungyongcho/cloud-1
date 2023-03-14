FROM debian:buster

# Update the package list and install dependencies
RUN apt-get update && \
    apt-get install -y wget php-cli php-mbstring php-xml php-mysqli unzip nginx php7.3-fpm netcat supervisor

# Download the latest version of phpMyAdmin
RUN wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz && \
    mkdir -p /var/www/html/pma && \
    tar -xvf phpMyAdmin-latest-all-languages.tar.gz -C /var/www/html/pma --strip-components=1 && \
    rm phpMyAdmin-latest-all-languages.tar.gz

RUN mkdir -p /var/log/supervisor
RUN mkdir -p /var/run/php/

COPY ./conf/default /etc/nginx/sites-available/default
COPY ./conf/supervisord.conf /etc/supervisor/supervisord.conf


# Copy the configuration file

WORKDIR /var/www/html/pma

RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/7.3/fpm/php.ini
RUN service php7.3-fpm restart

# RUN sed -i 's|root /var/www/html;|root /var/www/html/pma;|' /etc/nginx/sites-available/default
# RUN sed -i 's|listen 80;|listen 9999;|' /etc/nginx/sites-available/default


RUN mv config.sample.inc.php config.inc.php
RUN chmod 660 /var/www/html/pma/config.inc.php
RUN chown -R www-data:www-data /var/www/html/pma
RUN sed -i "/\$cfg\['Servers'\]\[\$i\]\['host'\] = 'localhost';/a \$cfg['ForceSSL'] = true;" /var/www/html/pma/config.inc.php
RUN sed -i "/\$cfg\['Servers'\]\[\$i\]\['AllowNoPassword'\] = false;/a \$cfg\['PmaAbsoluteUri'\] = 'http://nginx/phpmyadmin';" /var/www/html/pma/config.inc.php

# RUN sed -i "s/\$cfg\['PmaAbsoluteUri'\]\s*=\s*['\"]\([^'\"]*\)['\"]/\$cfg\['PmaAbsoluteUri'\] = 'http://phpmyadmin:9999/'/g" /var/www/html/pma/config.inc.php
# RUN sed -i "s|// define('PMA_ABSOLUTE_URI'|define('PMA_ABSOLUTE_URI', 'http://localhost/pma');\n// define('PMA_ABSOLUTE_URI'|" /var/www/html/pma/config.inc.php

# RUN sed -i "/^\?>$/i \$cfg['PmaAbsoluteUri'] = 'http://$(ip route | grep default | awk '{print $3}')/pma';" config.inc.php

RUN sed -i 's/localhost/mariadb/g' config.inc.php
# COPY config.inc.php /usr/share/phpmyadmin/

EXPOSE 9999

# CMD ["php-fpm7.3", "-F", "-y", "/etc/php/7.3/fpm/php-fpm.conf", "-g", "/var/run/php/php7.3-fpm.pid"]

CMD ["/usr/bin/supervisord", "-n"]
# CMD ["nginx", "-g", "daemon off;"]
