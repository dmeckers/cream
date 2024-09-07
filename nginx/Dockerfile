FROM nginx:alpine-slim

RUN apk add --no-cache bash certbot certbot-nginx openssl curl \
    && mkdir -p /etc/letsencrypt/live \
    && mkdir -p /etc/letsencrypt/archive \
    && mkdir -p /etc/letsencrypt/renewal \
    && mkdir -p /scripts

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./nginx_ready.conf /etc/nginx/conf.d/nginx_ready.conf
