#!/bin/sh

while true
do
    killall php82

    /bin/sh ~timezoned/update
    /usr/local/bin/php ~timezoned/server &

    sleep 86400;
done
