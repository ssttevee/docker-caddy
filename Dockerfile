FROM alpine:3.5

RUN apk add --no-cache --virtual .persistent-deps \
		ca-certificates \
		bash \
		curl \
		tar


## Download and install Caddy
RUN curl https://getcaddy.com | bash


ENV CADDYFILE /etc/Caddyfile

CMD ["/bin/sh", "-c", "/usr/local/bin/caddy -conf=$CADDYFILE"]
