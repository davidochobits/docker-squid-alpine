FROM alpine:3.17.1

MAINTAINER davidochobits@protonmail.com

RUN apk update \
    && apk add squid=5.7-r0 \
    && apk add curl \
    && rm -rf /var/cache/apk/*

COPY start-squid.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/start-squid.sh"]
