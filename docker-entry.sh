#!/bin/sh -e

SSL_DIR="/etc/nginx/ssl"

function ensure {
    FILE="$1"
    if [ -f "$SSL_DIR/$FILE" ]; then
        echo "$SSL_DIR/$FILE found."
    else
        echo "$SSL_DIR/$FILE not found."
        cp "$SSL_DIR-fake/$FILE" "$SSL_DIR/$FILE"
    fi 
}

# ensure that at least a fake cert is available
ensure "fullchain.pem"
ensure "privkey.pem"

nginx -g "daemon off;" &
NGINX_PID="$!"
sleep 1
/certbot.sh "$NGINX_PID" &
CERTBOT_PID="$!"

while true; do
    if ! kill -0 $NGINX_PID &>/dev/null; then
        echo "Nginx terminated. Exiting with code 1"
        exit 1
    fi
    if ! kill -0 $CERTBOT_PID &>/dev/null; then
        echo "Certbot script terminated. Exiting with code 1"
        exit 1
    fi
    sleep 1
done
