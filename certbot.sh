#!/bin/sh

SSL_DIR="/etc/nginx/ssl"
NGINX_PID="$1"

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

    cp "/etc/letsencrypt/live/$CERTBOT_DOMAIN/fullchain.pem" "$SSL_DIR"
    cp "/etc/letsencrypt/live/$CERTBOT_DOMAIN/privkey.pem" "$SSL_DIR"
    kill -s HUP $NGINX_PID

    sleep 3600
done
