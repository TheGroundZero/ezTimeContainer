#!/bin/bash

kill $(pidof php82)

php82 ~timezoned/update
php82 ~timezoned/server
