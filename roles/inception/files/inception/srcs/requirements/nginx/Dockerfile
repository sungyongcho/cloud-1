FROM debian:buster

# Update apt
RUN apt-get update \
&& apt-get upgrade -y

# Define ARGS
ARG DOMAIN

RUN apt-get -y install nginx

RUN apt-get -y install openssl

# Open https port
EXPOSE 443

# Create directory to save the HTTPS certificate and key
COPY ./conf/nginx.conf .
COPY ./tools/setup_nginx.sh .
RUN chmod 777 ./setup_nginx.sh
RUN ./setup_nginx.sh

# Start Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]

# https://www.it-connect.fr/debian-comment-installer-nginx-en-tant-que-serveur-web/
