FROM nginx:alpine

RUN apk --no-cache --update add certbot

COPY docker-entry.sh /docker-entry.sh
COPY certbot.sh /certbot.sh
WORKDIR /etc/nginx/conf.d
COPY default.conf /etc/nginx/conf.d/default.conf

VOLUME /etc/letsencrypt

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/docker-entry.sh"]
