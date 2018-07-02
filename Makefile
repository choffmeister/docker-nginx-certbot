IMAGE=choffmeister/nginx-certbot
TAG=latest

build:
	docker build -t "$(IMAGE):$(TAG)" .

test: build
	docker run --rm -it \
	  -e "CERTBOT_DOMAIN=test.com" \
	  -e "CERTBOT_EMAIL=test@test.com" \
	  -e "CERTBOT_FLAGS=--staging" \
	  -v $(PWD)/example.conf:/etc/nginx/conf.d/example.conf:ro \
	  -p 80:80 \
	  -p 443:443 \
	  --name nginx-certbot-test \
	  "$(IMAGE):$(TAG)"
