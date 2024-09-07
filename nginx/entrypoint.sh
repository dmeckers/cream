#!/bin/bash

certs_dir="/etc/letsencrypt/live"
nginx_config="/etc/nginx/nginx.conf"

# Read environment variables
EMAIL=${EMAIL:-"gombovombo@gmail.com"}
FRONT_HOST_URL=${FRONT_HOST_URL:-"front.dev.cream-dream.site"}
API_HOST_URL=${API_HOST_URL:-"api.dev.cream-dream.site"}
FRONT_INTERNAL_HOST_URL=${FRONT_INTERNAL_HOST_URL:-"http://front-internal"}
API_INTERNAL_HOST_URL=${API_INTERNAL_HOST_URL:-"http://api-internal"}

printf "Starting nginx...\n"

# 1.start with settings to able get certs
# 2.get certs if not exist
# 3.replace variables in nginx config
# 4.start

nginx

if [ ! -f "$certs_dir/$API_HOST_URL/fullchain.pem" ]; then
    certbot certonly --webroot -w /var/www/certbot -d $API_HOST_URL --email $EMAIL --agree-tos --non-interactive
fi

if [ ! -f "$certs_dir/$FRONT_HOST_URL/fullchain.pem" ]; then
    certbot certonly --webroot -w /var/www/certbot -d $FRONT_HOST_URL --email $EMAIL --agree-tos --non-interactive
fi

envsubst '${FRONT_HOST_URL} ${API_HOST_URL} ${FRONT_INTERNAL_HOST_URL} ${API_INTERNAL_HOST_URL}' < /etc/nginx/conf.d/nginx_ready.conf > $nginx_config

nginx -s stop
nginx -g 'daemon off;'