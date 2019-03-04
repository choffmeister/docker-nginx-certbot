#!/bin/sh

NGINX_PID="$1"

sleep 10
while true; do
    # create real cert
    certbot certonly \
        --non-interactive \
        --standalone \
        --agree-tos \
        --preferred-challenges http-01 \
        --http-01-port 40000 \
        --email $CERTBOT_EMAIL \
        --domains $CERTBOT_DOMAIN $CERTBOT_FLAGS
    # make nginx reload
    kill -s HUP $NGINX_PID

    sleep 3600
done
