# Create website folder 
mkdir -p /var/www/html
mkdir -p /etc/nginx/ssl

# Config Nginx file
rm -f /etc/nginx/sites-enabled/default
rm -f /etc/nginx/sites-available/default
mv ./nginx.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

# Get SSL certification
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -out /etc/nginx/ssl/cboutier.42.fr.crt -keyout /etc/nginx/ssl/cboutier.42.fr.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=cboutier.42.fr/UID=cboutier"
