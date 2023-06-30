FROM alpine:3.18

MAINTAINER TheGroundZero

RUN apk add --no-cache wget tar sed php82 php82-sockets tzdata-utils supercronic

RUN ln -s /usr/bin/php82 /usr/local/bin/php

RUN adduser -D -s /bin/sh -u 1000 timezoned

USER timezoned
WORKDIR /home/timezoned

COPY --chown=1000:1000 --chmod=774 src/update .
COPY --chown=1000:1000 --chmod=774 src/server .
COPY --chown=1000:1000 --chmod=774 src/update.sh .
COPY --chown=1000:1000 --chmod=444 src/crontab .

RUN php82 update
RUN php82 server &

HEALTHCHECK --interval=5m --timeout=3s CMD pidof php82

EXPOSE 2342/udp
