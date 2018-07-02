# nginx-certbot

```
# example.conf
server {
    listen 443 ssl;
    ssl_certificate /etc/nginx/ssl/fullchain.pem;
    ssl_certificate_key /etc/nginx/ssl/privkey.pem;

    root /usr/share/nginx/html;
    index index.html;
}
```

```
docker run -d \
  -p 80:80 \
  -p 443:443 \
  -e "CERTBOT_DOMAIN=domain.com" \
  -e "CERTBOT_EMAIL=mail@domain.com" \
  -e "CERTBOT_FLAGS=--staging" \
  -v "$PWD:example.conf:/etc/nginx/conf.d/example.conf:ro" \
  choffmeister/nginx-certbot.latest
```
