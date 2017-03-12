#!/bin/bash

# Set nginx config
cp "/etc/nginx/nginx.${NODE_ENV}.conf" /data/nginx.conf

# Give redis some time to come up
sleep 10

./nodebb upgrade && ./nodebb dev

exit $?
