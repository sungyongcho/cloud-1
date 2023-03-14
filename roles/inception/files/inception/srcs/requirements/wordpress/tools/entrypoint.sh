# Install WP-CLI
# https://supporthost.com/wp-cli-the-definitive-guide/
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Install and configurate Wordpress
if [ ! -f "wp-config.php" ]; then
wp core download --locale=en_US

    wp core config --dbname=${MARIADB_DB} --dbuser=${MARIADB_USER} --dbpass=${MARIADB_PWD} --dbhost=${MARIADB_HOST} --dbprefix=${TABLE_PREFIX} --path=/var/www/wordpress
fi

# Needed, otherwise, cboutier.42.fr redirects to example.com/...
# https://developer.wordpress.org/cli/commands/config/set/
# Sets the value of a specific constant or variable defined in wp-config.php file. Add the value if it doesn’t exist yet. This is the default behavior, override with –no-add.

wp config set WP_SITEURL "/"

wp config set WP_HOME "/"


# Run the installation
wp core install --url=${DOMAIN} --title=${TITLE} --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PWD} --admin_email=${WP_ADMIN_EMAIL}
# To have the latest version (with the bird!)
wp plugin update --all

# Create new users
wp user create ${WP_ADMIN_USER} ${WP_ADMIN_EMAIL} --role=administrator --user_pass=${WP_ADMIN_PWD}
wp user create ${WP_USER} ${WP_USER_EMAIL} --role=editor --user_pass=${WP_USER_PWD}

chown -R www-data:www-data /var/www/wordpress/*
#  Modify www.conf file, to listen to port 9000
sed -i "s|listen = /run/php/php7.3-fpm.sock|listen = 9000|g" /etc/php/7.3/fpm/pool.d/www.conf

exec php-fpm7.3 -F
