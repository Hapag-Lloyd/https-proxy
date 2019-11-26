#!/bin/bash
set -e

sed -i "s/INPORT/${INPORT}/g" /etc/nginx/conf.d/default.conf
openssl req -x509 -nodes -days 3650 -subj "/C=DE/ST=Hamburg/O=https-proxy/CN=localhost" -addext "subjectAltName=DNS:localhost" -newkey rsa:2048 -keyout /tmp/nginx/nginx-selfsigned.key -out /tmp/nginx/nginx-selfsigned.crt

# run additional commands given by Dockerfile
exec "$@"
