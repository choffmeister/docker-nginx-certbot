FROM nginx:alpine

RUN apk --no-cache --update add certbot

COPY default.conf /etc/nginx/conf.d/default.conf
COPY ssl-fake/ /etc/nginx/ssl-fake

WORKDIR /etc/nginx/conf.d
VOLUME /etc/nginx/ssl
VOLUME /etc/letsencrypt

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/docker-entry.sh"]

COPY docker-entry.sh /docker-entry.sh
COPY certbot.sh /certbot.sh
