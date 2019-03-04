#!/bin/sh -e

/certbot.sh "1" &
exec nginx -g "daemon off;"
