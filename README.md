# nginx-certbot

```
# example.conf
server {
    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/domain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/domain.com/privkey.pem;

    root /usr/share/nginx/html;
    index index.html;
}
```

```
# make sure to run this once without you custom domain configured
# else nginx will exit because there is no certificate yet
docker run -d \
  -p 80:80 \
  -p 443:443 \
  -e "CERTBOT_DOMAIN=domain.com" \
  -e "CERTBOT_EMAIL=mail@domain.com" \
  -e "CERTBOT_FLAGS=--staging" \
  -v "$PWD:example.conf:/etc/nginx/conf.d/example.conf:ro" \
  -v "$PWD:letsencrypt:/etc/letsencrypt" \
  choffmeister/nginx-certbot.latest
```
