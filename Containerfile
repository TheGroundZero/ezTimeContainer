FROM alpine:3.18

MAINTAINER TheGroundZero

RUN apk add --no-cache wget
RUN apk add --no-cache tar
RUN apk add --no-cache sed
RUN apk add --no-cache php82

RUN adduser -D -s /bin/sh timezoned

ADD --chown timezoned --chmod=774 src/server/ /home/timezoned/

RUN sed -i 's|/usr/local/bin/php|/usr/bin/php82|g' /home/timezoned/server
RUN sed -i 's|/usr/local/bin/php|/usr/bin/php82|g' /home/timezoned/timezoned

RUN ln -s /home/timezoned/timezoned /etc/local.d/timezoned
RUN chmod +x /etc/local.d/timezoned
RUN rc-update add local

USER timezoned
WORKDIR /home/timezoned

RUN <<EOT
	update
	sleep 5
	server
EOT

EXPOSE 2342/udp

COPY <<-EOT restart.sh
	#!/bin/sh
	/home/timezoned/update
EOT

RUN <<EOT
	chmod +x restart.sh
	touch crontab.tmp
	echo '0 0 * * 0 /home/timezoned/restart.sh > crontab.tmp'
	crontab crontab.tmp
	rm crontab.tmp
EOT

CMD ["/usr/sbin/crond", "-f", "-d", "0"]
