FROM alpine:3.5


ENV CADDY_BIN /usr/local/bin/caddy
ENV CADDYFILE /etc/Caddyfile


## Download and install Caddy
ENV CADDY_VER 0.9.4

RUN apk add --no-cache --virtual setup-dependencies \
		ca-certificates \
		curl \
		tar \
	&& WORK_DIR=/tmp/caddy && CADDY_TAR=$WORK_DIR/caddy.tar.gz && BIN_NAME=caddy_linux_amd64 \
	&& mkdir -p $WORK_DIR \
	&& curl -fsSL https://github.com/mholt/caddy/releases/download/v$CADDY_VER/caddy_linux_amd64.tar.gz -o $CADDY_TAR \
	&& tar -xzf $CADDY_TAR -C $WORK_DIR $BIN_NAME \
	&& chmod +x $WORK_DIR/$BIN_NAME \
	&& mv $WORK_DIR/$BIN_NAME $CADDY_BIN \
	&& rm -fr $WORK_DIR \
	&& $CADDY_BIN --version \
	&& apk del setup-dependencies


CMD ["/bin/sh", "-c", "$CADDY_BIN -conf=$CADDYFILE"]
