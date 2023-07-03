#!/bin/bash

while true
do
    killall php82

    php82 ~timezoned/update
    php82 ~timezoned/server &

    sleep 86400;
done
